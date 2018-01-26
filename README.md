# VHDL-Cannon-Game
  
Cannon game installed on the CPU on an electronic board as built-in software.  
Developed with VHDL designing language for Altera DE0 board with Cyclone III core CPU, with Altera Quartus II
  
## Tags
Game, VGA, Altera, VHDL, geii-lab-sin1
  
## Project description
In this project, the main goal was to learn how VGA standard works and implement it to display a tiny game on a standard definition screen. 
This game has just a simple rule: launch a ball from the cannon to a target.   
  
But this target changes its position after each throw. So to allow you to change the arrival point of your shoot you can change the starting angle (from 0 to 90°) of your throw. By the way you can't neither change the position of your cannon nor the speed of the bullet, just the launch angle.
  
## How to use this repo?
Same for final user and developer:
1. Download this repo
2. Download, install, and open your favorite IDE and VHDL-compiler-downloader. You can use Altera Quartus II which includes both
3. Create an empty project
4. Import each `.vhd file in your project
5. Set FPGA as Top-level identity in your project settings
6. You are now ready to download the program on your board, and/or modify the code (developers only). 
	
> **Important thing when flashing:**  
> Because this project was developed for a certain device, you have to choose the same as us when flashing the CPU (Altera DE0 with Cyclone III)

## Credits
This work was done as part of a university project.  
  
Done by **Marcelin Gerardi** and **Maxime Marmont**, 1st-year students in a 2-year university degree in Electrical Engineering and Computer Science (DUT GEII, Génie Electrique et Informatique Industrielle) in IUT Annecy, France.  
  
January 2016  

## Copyright/license
MIT License  
Copyright © 2016 Marcelin GERARDI & Maxime MARMONT  
