#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
=begin

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

Author       : Carlos Morel-Riquelme <morel.riquelme AT gmail DOT com>
Date 	     : 07/17/2014
Script       : Lenyadi
License      : GPL v3
version   	 : v0.1
Summary      : Lenyadi is a FrontEnd of command youtube-dl for Linux
Dependencies : ruby-devel      => Ruby interpreter
			   rubygem-gtk2    => Ruby/GTK2 is a Ruby binding of GTK+-2.10.x
			   rubygem-bundler => Manage rubygems dependencies in Ruby libraries
			   gcc 			   => GNU Compiler
			   youtube-dl	   => Small command-line program to download videos from YouTube.com and a few more site
			   ffmpeg          => VP8/VP9 Codec SDK
			   libvpx  		   => VP8/VP9 Codec SDK
			   libvpx-utils    => Utils for libvpx
=end

#Módulos de Librería gráfica y de notificación
require(%q{gtk2}) # => rubygem-gtk2
require(%q{libnotify}) # => gem install libnotify

#Creamos una nueva Clase que hereda de GTK::Window
class Lenyadi < Gtk::Window
	def initialize #Constructor de la clase
		super
		threads
	end

	#Función que crea el hilo o thread principal 
	def threads
		main_thread = Thread.new do #Creamos un nuevo thread
			create_window #Dejamos la función set_window como thread
			main_thread.join #Iniciamos el thread 
		end
	end

	#Función que muestra una notificación al inicio de la descarga 
	def notify_download
		notify_download = Libnotify.new do |n|
	    n.summary    = %q{Descargando Contenido Multimedia ...}
	    n.body       = %q{	Sea Paciente}
	    n.timeout    = 3
	    n.urgency    = :normal   
	    n.append     = false       
	    n.transient  = true    
	    n.icon_path  = %q{/usr/share/icons/gnome/24x24/status/appointment-soon.png}
	    end
        notify_download.show!
	end

	def notify_complete
		notify_complete = Libnotify.new do |n|
	    n.summary    = %q{Contenido Descargado Exitosamente}
	    n.body       = %q{	Gracias}
	    n.timeout    = 3       
	    n.urgency    = :normal   
	    n.append     = false       
	    n.transient  = true    
	    n.icon_path  = %q{/usr/share/icons/gnome/24x24/emblems/emblem-default.png}
	    end
        notify_complete.show!
	end

	def notify_error
		notify_error = Libnotify.new do |n|
	    n.summary    = %q{Ups ha Ocurrido un Error}
	    n.body       = %q{Revisa que todo este bien}
	    n.timeout    = 3        
	    n.urgency    = :normal   
	    n.append     = false       
	    n.transient  = true    
	    n.icon_path  = %q{/usr/share/icons/gnome/24x24/status/software-update-urgent.png}
	    end
        notify_error.show!
	end	

	#Función para Limpiar los widgets
	def new_download
		@txt_url.set_text(%q{}) #Aqui dejamos en blanco el entry
		@chk_audio.set_active(false) #Desactivamos el checkbutton
		@chk_video.set_active(false) #Desactivamos el checkbutton
		@chk_playlist.set_active(false) #Desactivamos el checkbutton
	end

	#Función que cierra la ventana principal y sale del programa
	def main_quit
		Gtk.main_quit
	end

	#Función para descargar contenido multimedia
	def download
		download_thread = Thread.new do #Creamos un thread para la función
			#Seteamos las variables de la función junto a los comandos a ejecutar
			url = @txt_url.text
			youtube_audio = %q{youtube-dl -x  --audio-quality 0 --audio-format mp3 }
			youtube_video = %q{youtube-dl }
			youtube_playlist = %q{youtube-dl -cit "}

			case 
			#Si el checkbutton de audio esta activo y el entry no esta vacío ejecutamos los comandos
			when (@chk_audio.active? and @txt_url != %q{})
				execute = youtube_audio + url
				notify_download #Mostramos notificación 
				youtube_dl = system(execute) #Ejecutamos el comando del sistema
				notify_complete #Mostramos notificación 

			#Si el checkbutton de vídeo esta activo y el entry no esta vacío ejecutamos los comandos
	        when (@chk_video.active? and @txt_url != %q{})
	        	execute = youtube_video + url
	        	notify_download #Mostramos notificación
	        	youtube_dl = system(execute) #Ejecutamos el comando del sistema
				notify_complete #Mostramos notificación

			#Si el checkbutton de playlist esta activo y el entry no esta vacío ejecutamos los comandos
	        when (@chk_playlist.active? and @txt_url != %q{})
	        	execute = youtube_playlist + url + %q{"}
	        	notify_download #Mostramos notificación
	        	youtube_dl = system(execute) #Ejecutamos el comando del sistema
				notify_complete #Mostramos notificación
	        	
			else
				notify_error #Si no se cumplen las condiciones mostramos una notificación de error 
	        end
	        download_thread.join #Inicamos el thread
	    end
	end

	#Función que crea la ventana principal
	def create_window
		@window = Gtk::Window.new(type=Gtk::Window::TOPLEVEL) #Aquí creamos la ventana
		@window.set_title(%q{Lenyadi For Linux}) #Título de la ventana
		@window.set_default_size(350,270) #Tamaño de la ventana
		@window.set_resizable(false) #Desactivamos el redimensionamiento
		@window.border_width =10 #Padding de la ventana
		@window.set_window_position(Gtk::Window::POS_CENTER_ALWAYS) #Posición de la ventana
		@window.signal_connect(%q{destroy}) do #Función para cerrar la ventana al darle click a la 'X'
			Gtk.main_quit
		end

		#Creamos las etiquetas de la aplicación
		@lbl_url = Gtk::Label.new(%q{##### Ingrese Una URL #####})
		@lbl_download_type = Gtk::Label.new(%q{#### ¿ Que Deseas Descargar ? ####})
		@lbl_download_format = Gtk::Label.new(%q{#### Elije el Formato de Descarga #####})
		@lbl_download_option = Gtk::Label.new(%q{########## Opciones ##########})
		
		#Creamos el cuadro de texto de la aplicación
		@txt_url = Gtk::Entry.new
		@txt_url.set_size_request(250,25)

		#Creamos los checkbutton de la aplicación
		@chk_audio = Gtk::CheckButton.new(label=%q{Audio})
		@chk_audio.set_active(false)
		@chk_video = Gtk::CheckButton.new(label=%q{Video})
		@chk_video.set_active(false)
		@chk_playlist = Gtk::CheckButton.new(label=%q{Playlist})
		@chk_playlist.set_active(false)

		#Creamos los botones de la aplicación
		@btn_new = Gtk::Button.new(%q{Nuevo})
		@btn_new.set_size_request(90,40)
		@btn_new.signal_connect(%q{clicked}) do
			new_download 
		end
		
		@btn_download = Gtk::Button.new(%q{Descargar})
		@btn_download.set_size_request(90,40)
		@btn_download.signal_connect(%q{clicked}) do 
			download 
		end
		@btn_quit = Gtk::Button.new(%q{Salir})
		@btn_quit.set_size_request(90,40)
		@btn_quit.signal_connect(%q{clicked}) do 
			main_quit
		end

		#Contenedor de los widgets
		@fixed = Gtk::Fixed.new
		@fixed.put(@lbl_url,40,5)
		@fixed.put(@txt_url,50,30)
		@fixed.put(@lbl_download_type,20,70)
		@fixed.put(@chk_audio,30,95)
		@fixed.put(@chk_video,120,95)
		@fixed.put(@chk_playlist,210,95)
		@fixed.put(@lbl_download_option,20,130)	
		@fixed.put(@btn_new,10,160)
		@fixed.put(@btn_download,117,160)
		@fixed.put(@btn_quit,220,160)

		@window.add(@fixed)
		@window.show_all
	end
end
Gtk.init #aqui inicializamos gtk2
	app = Lenyadi.new #instanciamos la clase Lenyadi antes creada
Gtk.main #loop de la aplicacion
