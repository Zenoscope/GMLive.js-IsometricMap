//
// Collision test
//

// stuff to do:
// chuck in more tiles for a fake map.
// Circular collision mask on doorway
// precise image collision mask on eg buildings

spr_playerA = sprite_add("https://raw.githubusercontent.com/hydroshiba/crossy-clone/main/asset/texture/car/taxi/front.bmp",1, true, false, 0,0);
player_x_loc = 100;
player_y_loc = 100;

_radius = 50;
drawnYet = false;
//object_array = [];

#define draw

var _x_off = sprite_get_width(spr_playerA) / 2;
var _y_off = sprite_get_height(spr_playerA) / 2;
draw_set_colour(c_white);
draw_set_colour(c_white);
draw_circle(player_x_loc,player_y_loc,_radius,true);
// draw_sprite_ext(spr_playerA,1,player_x_loc - _x_off,player_y_loc - _y_off,1,1,0,c_white,1);

driver = instance_create(player_x_loc,player_y_loc,obj_blank);
//driver.sprite_index = spr_playerA;

// draw some circles to crash into
if (drawnYet == false){
for (i=0;i<5;i++){
	var _x_loc = irandom_range(100,700);
	var _y_loc = irandom_range(200,700);
	
	draw_circle(_x_loc,_y_loc,_radius,false);
	object_array[i] = instance_create(_x_loc,_y_loc,obj_blank);
	//object_array[i] = instance_create_depth(_x_loc[i],_y_loc[i],100,obj_blank);
	object_array[i].sprite_index = spr_playerA;
	}
	
	
	drawnYet = true;
}

/*
if (drawnYet == false){
	//drive=instance_create(player_x_loc,player_y_loc,obj_blank);
	//draw_circle(player_x_loc + _x_off ,player_y_loc + _y_off,_radius,false);
	//drive.sprite_index = spr_playerA;
	// object_array[i] = instance_create_depth(_x_loc[i],_y_loc[i],100,obj_blank);
	//draw_circle(300 + _x_off,300 + _y_off,_radius,false);
	//crash=instance_create(layer_x_loc ,layer_y_loc ,obj_blank);
	crash.sprite_index = spr_playerA;
	drawnYet = true;
	}
*/


draw_circle(300,300,_radius,true);

#define step
var _precise = true;
var _notme = false;

// ??
if (collision_circle(player_x_loc,player_y_loc,_radius,object_array,_precise,_notme) != noone){
	show_debug_message("owch!");	
	}
else {
	show_debug_message("no.");
	}

// does not work
/*
if (collision_circle(300,300,_radius,driver,_precise,_notme) != noone){
	show_debug_message("owwies");
	}
*/

//works
/*
if (collision_circle(player_x_loc,player_y_loc,_radius,object,_precise,_notme) != noone){
	show_debug_message("owch");
	}
else {
	show_debug_message("1");
	}
*/

key_up = keyboard_check(vk_up); //tecla arriba
key_dwn = keyboard_check(vk_down); //tecla abajo
key_lft = keyboard_check(vk_left); //tecla izquierda
key_rgt = keyboard_check(vk_right); //tecla derecha

// 0 //down
// 7 // dleft
//15 // left
//23 // left
// 

if (key_up) {
	player_y_loc -=10;
	}
	
if (key_dwn) {
	player_y_loc+=10;
	}

if (key_lft) {
	player_x_loc -=10;
	}
if (key_rgt) {
	player_x_loc +=10;
	}
