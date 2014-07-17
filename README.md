### DESCRIPTION:
   **Lenyadi** is a frontEnd of command-line youtube-dl made in **Ruby** as program language and **GTK+** as graphical         library.
   With lenyadi and the power of youtube-dl you can download audio,video from Youtube and many other sites.

### DEPENDENCIES:
  * ruby-devel      => Ruby interpreter
  * rubygem-gtk2    => Ruby/GTK2 is a Ruby binding of GTK+-2.10.x
  * rubygem-bundler => Manage rubygems dependencies in Ruby libraries
  * gcc 	    => GNU Compiler
  * youtube-dl	    => Small command-line program to download videos from YouTube.com and a few more site
  * ffmpeg          => Library for convert audio and video files
  * libvpx          => VP8/VP9 Codec SDK
  * libvpx-utils    => Utils for libvpx

### INSTALLATION IN FEDORA

Just follow the next steps for install dependencies and download the script:

    sudo yum -y install ruby-devel rubygem-gtk2 rubygem-bundler gcc youtube-dl ffmpeg libvpx libvpx-utils
    sudo gem install libnotify
    sudo youtube-dl -U
    wget https://github.com/n0oir/lenyadi/blob/master/lenyadi.rb
    chmod +x lenyadi.rb
    ruby lenyadi.rb

### INSTALLATION IN UBUNTU

Just follow the next steps for install dependencies and download the script:

    sudo apt-get install ruby ruby-gtk2 ruby-bundler youtube-dl python-pip
    sudo pip install --upgrade youtube-dl
    sudo gem install libnotify
    wget https://github.com/n0oir/lenyadi/blob/master/lenyadi.rb
    chmod +x lenyadi.rb
    ruby lenyadi.rb

### CREATE A DESKTOP FILE
Just follow this steps for create a desktop entry

    nano /home/username/.local/share/applications/lenyadi.desktop
    
Now copy this example of desktop file and paste into lenyadi.desktop

    [Desktop Entry]
    Type=Application  
    Version=0.1
    Name=Lenyadi
    Comment=FrontEnd of youtube-dl
    Icon=/home/username/Downloads/lenyadi.svg
    Exec=/home/username/Downloads/lenyadi.rb
    Categories=AudioVideo;Audio;

Now replace this lines

    Icon=path where is your favorite icon
    Exec=path where is your lenyadi.rb file
    
Save the file 

    Ctrl + o
    
And Exit

    Ctrl + x
    
Log out and try

    :)

### BUGS 

Please report any issue to this address

    https://github.com/n0oir/lenyadi/issues
    
### CONTACT

    morel DOT riquelme AT gmail DOT com
    

