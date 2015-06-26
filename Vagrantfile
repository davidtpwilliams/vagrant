Vagrant.configure("2") do |config|

  # install apache2 (httpd) 
  config.vm.provision :shell, :path => "install_apache.sh"

  # build as normal user (named "ec2-user")
  # change this to environment variables by putting entries in ~/.bashrc
  config.vm.synced_folder "/home/davidw/scripts/vagrant", "/home/ec2-user/vagrant", type: "rsync",
    rsync__exclude: ".git/",
    rsync__args: ["--verbose", "--rsync-path='sudo rsync'", "--archive", "--delete", "-z"]
  
  # Read the key pair from a file as this file will be stored on GitHub
  keyarray=[]
  File.open("/home/davidw/scripts/vagrant/awskeypair", "r").each do |f|
    f.each_line do |line|
	  keyarray.push line
	end	
  end 
  keyarray[0] = keyarray[0].chomp
  keyarray[1] = keyarray[1].chomp
  
  #config.vm.synced_folder '.', '/vagrant', :disabled => true
  config.vm.provider :aws do |aws, override|
    config.vm.box = "dummy"
    config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
	aws.access_key_id = keyarray[0]
    aws.secret_access_key = keyarray[1]	
    aws.keypair_name = "awscert3"
    aws.region = "ap-southeast-2"
    aws.security_groups = 'SSH'
    aws.ami = "ami-11b0c12b"
    aws.instance_type = "t2.micro"
    override.ssh.username = "ec2-user"
    aws.tags = {
      'Name' => 'My Puppet Master',
     }
    override.ssh.private_key_path = "/home/davidw/scripts/vagrant/awscert3.pem"
  end
end
