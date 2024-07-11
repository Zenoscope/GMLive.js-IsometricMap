
// stuff to do:

// https://yal.cc/r/gml/

/*
2) DONE   load image for each different sprite
3) Animate image for each sprite
	//(change image to image + (total_frames/4) (+ 1?) modulus total_frames
	//switch
	if (direction == "N"){ 
		start_frame = 1
		end_frame = total_frames/4
		}
	else if (direction == "E") {
		start_frame = (total_frames/4) + 1 
		end_frame = (total_frames/4)*2
		}
	else if (direction == "S") {
		start_frame = ((total_frames/4)*2) + 1
		end_frame = (total_frames/4)*3
		}
	else if (direction == "W") {
		start_frame = ((total_frames/4)*3) + 1
		end_frame = total_frames
		}
		
1) DONE Make map bigger and zoom it in

1.5)  Occlusion - Kind of works, need to move the drawn part.

This bit here:
global.iso_orig_x = room_width/2;
global.iso_orig_y = (room_height - global.iso_cell_h * 16) / 2;

    only drawing tiles which are visible, maybe a bit of a border outside the viewscreen
	say the player starts at 30,30, the draw distance might be 10,10 so you'd draw 25-35
	the map is eg 60, 60

// spawn the main character here
// counting from zero
char_map_x = 3;
char_map_y = 3;

map_max_x = 10 // array[0].length
map_max_y = 10 // array.length

draw_dist_x = 3;
draw_dist_y = 3;

for (var i = (char_map_x - draw_dist_x); i < (char_map_x + draw_dist_x); i++)
for (var k = (char_map_y - draw_dist_y); k < (char_map_y + draw_dist_y); k++) {
// see below for what happens when the map hits the side.

4) DONE rotate map 
	needs to rotate around the player, or around the centre of the screen if they are at the edge
	have a virtual map that the map is copied into, then that gets rotated.
	https://danceswithcode.net/engineeringnotes/rotations_in_2d/rotations_in_2d.html
	
5) DONE move character on map - input keys, move the character forward/backward etc 

5.5 move map instead of character

6) Map edge - move the character intead of the map
// if the player gets within draw_dist of the side (x or y) then the draw_dist needs to change
// and the player location can stay the same.
if (char_map_x > (map_max_x - draw_dist_x) {
	min_draw_x = (map_max_x - draw_dist_x);
	max_draw_x = map_max_x;
	}
else if (char_map_x < (0 + draw_dist_x) {
	min_draw_x = 0;
	max_draw_x = draw_dist_x;
	}
else {
	min_draw_x = (char_map_x - draw_dist_x)
	max_draw_x = (char_map_x + draw_dist_x) 
	}

//
// Y bit goes here
//

for (var i = min_draw_x; i < max_draw_x; i++)
for (var k = min_draw_y; k < max_draw_y; k++) {

7) collisions - colliding with buildings - Needs an alpha channel for the collision mask
 also need to have the car drawn properly so its in the right place in terms of depth
 add some tall buildings for it to drive behind
 also change the centre of the sprite to the bottom middle
 
8) NPC's - spawn points (another ds_map?)

9) Spawn street furniture, lamp posts, doorways etc (does the tile spawn them? fractional depths?)
	NB any extra stuff will need to be rotated around the origin of the tile (which could easliy be the centre, so nop problem there)
	it needs to be incrememted to the correct image as well

10) Internal collision eg walking to a doorway to enter a building

*/

//*************
// setup sample:
background_color = c_white;
room_width = browser_width;
room_height = browser_height;
// setup grid:
//global.iso_cell_w = 128;
//global.iso_cell_h = 128/1.75;
global.iso_cell_w = 64;
global.iso_cell_h = global.iso_cell_w/1.75;

global.iso_orig_x = room_width/2;
global.iso_orig_y = (room_height - global.iso_cell_h * 16) / 2;

spr_playerA = sprite_add("https://raw.githubusercontent.com/hydroshiba/crossy-clone/main/asset/texture/car/taxi/front.bmp",1, true, false, 0,0);
spr_playerB = sprite_add("https://raw.githubusercontent.com/hydroshiba/crossy-clone/main/asset/texture/car/taxi/back.bmp",1, true, false, 0,0);

spr_truckA = sprite_add("https://raw.githubusercontent.com/hydroshiba/crossy-clone/main/asset/texture/truck/front.bmp",1, true, false, 0,0);
spr_truckB = sprite_add("https://raw.githubusercontent.com/hydroshiba/crossy-clone/main/asset/texture/truck/back.bmp",1, true, false, 0,0);

// use sprite part to get the right sprites

//spr_playerA = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow01.png",1, true, false, 0,0);
//spr_playerB = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow02.png",1, true, false, 0,0);
//spr_playerC = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow03.png",1, true, false, 0,0);
//spr_playerD = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow04.png",1, true, false, 0,0);

spr_bung1a = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow01.png",1, true, false, 0,0);
spr_bung1b = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow02.png",1, true, false, 0,0);
spr_bung1c = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow03.png",1, true, false, 0,0);
spr_bung1d = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow04.png",1, true, false, 0,0);

spr_bung2a = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow11.png",1, true, false, 0,0);
spr_bung2b = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow12.png",1, true, false, 0,0);
spr_bung2c = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow13.png",1, true, false, 0,0);
spr_bung2d = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/Bungalow14.png",1, true, false, 0,0);

spr_bung3a = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/House21.png",1, true, false, 0,0);
spr_bung3b = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/House22.png",1, true, false, 0,0);
spr_bung3c = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/House23.png",1, true, false, 0,0);
spr_bung3d = sprite_add("https://raw.githubusercontent.com/tarabaz/magical-voxel-3d-city-model/main/Demo-Image/512px/House24.png",1, true, false, 0,0);

sprite_set_offset(spr_bung3a, sprite_width / 2 , sprite_height + 50);
sprite_set_offset(spr_bung3b, sprite_width / 2 , sprite_height + 50);
sprite_set_offset(spr_bung3c, sprite_width / 2 , sprite_height + 50);
sprite_set_offset(spr_bung3d, sprite_width / 2 , sprite_height + 50);


spr_bung1 = [spr_bung1a,spr_bung1b,spr_bung1c,spr_bunga1d]
spr_bung2 = [spr_bung2a,spr_bung2b,spr_bung2c,spr_bung2d]
spr_bung3 = [spr_bung3a,spr_bung3b,spr_bung3c,spr_bung3d]

//spr_player = [spr_playerA,spr_playerB,spr_playerA,spr_playerB]
//spr_truck = [spr_truckA,spr_truckB,spr_truckA,spr_truckB]
spr_player = [spr_truckA,spr_truckB,spr_truckA,spr_truckB]

// needs to be odd
// sprite are 0, 1, 2
map_array = [
    // reads from right to left
	[ 0, 0, 0, 2, 0, 0, 2],
	[ 0, 0, 2, 2, 2, 0, 0],
	[ 0, 2, 2, 2, 2, 2, 0],
	
	[ 2, 2, 2, 2, 2, 2, 2],
	
	[ 0, 0, 2, 2, 2, 0, 0],
	[ 0, 0, 2, 2, 2, 0, 0],
	[ 0, 0, 2, 2, 2, 0, 0]
	]

// map_rotated = map_array;
map_rotated = [
	[ -1, -1, -1, -1, -1, -1, -1],
	[ -1, -1, -1, -1, -1, -1, -1],
	[ -1, -1, -1, -1, -1, -1, -1],
	
	[ -1, -1, -1, -1, -1, -1, -1],
	
	[ -1, -1, -1, -1, -1, -1, -1],
	[ -1, -1, -1, -1, -1, -1, -1],
	[ -1, -1, -1, -1, -1, -1, -1],
	]

// start location of the player
//player_x_loc = array_length_1d(map_array) / 2 ; // (array_length(array)/2)
//player_y_loc = array_length_1d(map_array[0]) / 2;

player_x_loc = 3;
player_y_loc = 3;
player_angle = 1;
scale_factor = 1;

// copy the original map array to the new map array.
// array_rotated = map_array;
// map rotation is mirroring, not rotating
// 90 is a copy of the array, 
// everything is rotated by 90 degrees for some reason
map_angle_list=[0,90,180,270]
map_angle = 1;


// need to take into account the direction the player is facing
// unless they face forward after rotating the map?

x_scale = (global.iso_cell_w * 2)/512;
y_scale = (global.iso_cell_w * 2)/512;

rotate_map()

//*************
#define draw

draw_sprite(spr_playerB,1,100,100);
draw_sprite(spr_playerA,1,200,100);

// draws the map

for (var i = 0; i < array_length_1d(map_rotated); i++)
for (var k = 0; k < array_length_1d(map_rotated[0]); k++) {
    var cx = i + 0.5;
    var cy = k + 0.5;
    var map_sprite = map_rotated[i][k];
    
    // function which chooses the shape from another array/dsmap/list of shapes
    switch(map_sprite){
        case 0:
            display_sprite = spr_bung1[map_angle];
        break;
        case 1:
            display_sprite = spr_bung2[map_angle];
        break;
        case 2:
            display_sprite = spr_bung3[map_angle];
        break;
            // more cases (with breaks)
        default:
            // error imae
        }
        
    //if ( floor(player_y_loc) == i && floor(player_x_loc) == k) {
    	draw_sprite_ext(spr_player[player_angle],1,iso_to_scr_x(player_x_loc,player_y_loc),iso_to_scr_y(player_x_loc,player_y_loc),x_scale * scale_factor,y_scale,0,c_white,1);
    	//}
    
    draw_sprite_ext(display_sprite,1,iso_to_scr_x(cx, cy),iso_to_scr_y(cx, cy),x_scale,y_scale,0,c_white,1);
    //draw_sprite_ext(display_sprite,1,i,k*10,x_scale,y_scale,0,c_white,1);
    
    }

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// instructions
draw_text(3, 3, "Use the arrow keys to steer the car and the E and Q keys to rotate the map");
draw_text(3, 25, "Click to start");

var mx = mouse_x, my = mouse_y;
var rx = iso_from_scr_x(mx, my); // relative X
var ry = iso_from_scr_y(mx, my); // relative Y
draw_set_colour($333333);
draw_text(3, 50,
    "Mouse (absolute): " + string(mx) + ", " + string(my) + "#" + 
    "Mouse (relative): " + string(rx) + ", " + string(ry)
    );
    
// draw the grid lines:
draw_set_colour($dddddd);
for (var i = 0; i <= 8; i++) {
    draw_line_iso(0, i, 8, i);
    draw_line_iso(i, 0, i, 8);
}
// draw the cursor:
rx = clamp(rx, 0, 8);
ry = clamp(ry, 0, 8);
draw_set_colour(c_red);
draw_line_iso(0, ry, 8, ry);
draw_set_colour(c_blue);
draw_line_iso(rx, 0, rx, 8);
// draw the cell coordinates:
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour($333333);


#define step //Evento Step

key_e = keyboard_check_released(ord("E")); //tecla e
key_q = keyboard_check_released(ord("Q")); //tecla cu

if (key_e) {
	//show_debug_message("you pressed E " + string(player_x_loc) + " " + string(player_y_loc) )
	map_angle++;
	if (map_angle > 3) map_angle = 0;
	player_angle++;
	if (player_angle > 3) player_angle = 0;
	// redraw_map = true;
	rotate_map();
	
	// show_debug_message(map_angle_list[map_angle]);
	}
if (key_q) {
	//show_debug_message("you pressed Q " + string(player_x_loc) + " " + string(player_y_loc) )
	map_angle--;
	if (map_angle < 0) map_angle = 3;
	player_angle--;
	if (player_angle < 0) player_angle = 0;
	//redraw_map = true;
	rotate_map();
	// show_debug_message(map_angle_list[map_angle]);
	}

key_up = keyboard_check(vk_up); //tecla arriba
key_dwn = keyboard_check(vk_down); //tecla abajo
key_lft = keyboard_check(vk_left); //tecla izquierda
key_rgt = keyboard_check(vk_right); //tecla derecha

if (key_up) {
	show_debug_message("you pressed up " + string(floor(player_x_loc)) + " " + string(floor(player_y_loc)) )
	player_x_loc +=0.1;
	// change the sprite
	player_angle = 0;
	scale_factor = 1;
	}
	
if (key_dwn) {
	show_debug_message("you pressed dwn " + string(floor(player_x_loc)) + " " + string(floor(player_y_loc)) )
	player_x_loc -=0.1;
	player_angle = 1;
	scale_factor = 1;
	}

if (key_lft) {
	show_debug_message("you pressed lft " + string(floor(player_x_loc)) + " " + string(floor(player_y_loc)) )
	player_y_loc +=0.1;
	player_angle = 2;
	scale_factor = -1;
	}
if (key_rgt) {
	show_debug_message("you pressed rgt " + string(floor(player_x_loc)) + " " + string(floor(player_y_loc)) )
	player_y_loc -=0.1;
	player_angle = 4;
	scale_factor = -1;
	}


//*************functions
#define draw_line_iso
// (x1, y1, x2, y2)
var x1 = argument0, y1 = argument1;
var x2 = argument2, y2 = argument3;
draw_line(
    iso_to_scr_x(x1, y1), iso_to_scr_y(x1, y1),
    iso_to_scr_x(x2, y2), iso_to_scr_y(x2, y2)
);

#define iso_to_scr_x
// (iso_x, iso_y)
return global.iso_orig_x + (argument0 - argument1) * global.iso_cell_w;

#define iso_to_scr_y
// (iso_x, iso_y)
return global.iso_orig_y + (argument0 + argument1) * global.iso_cell_h;

#define iso_from_scr_x
// (scr_x, scr_y)
return ((argument1 - global.iso_orig_y) / global.iso_cell_h
    + (argument0 - global.iso_orig_x) / global.iso_cell_w) / 2;

#define iso_from_scr_y
// (scr_x, scr_y)
return ((argument1 - global.iso_orig_y) / global.iso_cell_h
    - (argument0 - global.iso_orig_x) / global.iso_cell_w) / 2;

#define rotate_map

theta = degtorad(map_angle_list[map_angle]);

// array point to rotate
// rotate around the middle of the array.
xc = (array_length_1d(map_array) / 2) - 0.5 ; // (array_length(array)/2)
yc = (array_length_1d(map_array[0]) / 2) - 0.5; // round it down to find the proper centre
// round xc and yc down

//show_debug_message("half array length =" + string( array_length_1d(map_array)/2 ) );
//show_debug_message("half array length =" + string( array_length_1d(map_array[0])/2 ) );

cos_theta = cos(theta);
sin_theta = sin(theta);

for (var i = 0; i < array_length_1d(map_array); i++) {
for (var k = 0; k < array_length_1d(map_array[0]); k++) {

		// the equations start from 1, but the array starts from zero
        //x1 = ((x0 - xc) * cos_theta) - ((y0 - yc) * sin_theta) + xc;
        //y1 = ((x0 - xc) * sin_theta) + ((y0 - yc) * cos_theta) + yc;
        new_x = ((k - xc) * cos_theta) + ((i - yc) * sin_theta) + xc;
        new_y = ((k - xc) * sin_theta) - ((i - yc) * cos_theta) + yc;

        // show_debug_message("i:" + string(i) + " k: " + string(k) + "=> " + "new X:" + string(new_x) + "new y: " + string(new_y))
        // map_rotated[i][k] = map_array[i][k];
        map_rotated[new_x][new_y] = map_array[i][k];
        // x1 and y1 are the new array positions.
        }
    }

//for (var i = 0; i < array_length_1d(map_rotated); i++) {
//    show_debug_message( "map " +  string(map_rotated[i]))
//}

//show_debug_message("map angle " + string(map_angle_list[map_angle]));

//redraw_map = false;
