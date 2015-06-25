def whyrun_supported?
  true
end

def do_i_exist?(user)
  Etc.getpwnam(user)
  true
rescue ArgumentError
  false
end

action :manage do
  converge_by("Managing user #{new_resource.name}") do
    if new_resource.name == 'root'
      home_dir = '/root'
    else
      home_dir = new_resource.home_directory.nil? ? "/home/#{new_resource.name}" : new_resource.home_directory
    end

    user new_resource.name do
      action [:manage, :modify] if do_i_exist?(new_resource.name)
      home home_dir
      unless new_resource.system
        gid new_resource.gid unless new_resource.gid.nil?
        uid new_resource.uid unless new_resource.uid.nil?
      end
      password new_resource.password unless new_resource.password.nil?
      shell new_resource.shell
      system new_resource.system # ~FC048
    end

    directory home_dir do
      owner new_resource.name
      group new_resource.name
      mode 0700
    end
  end
end
