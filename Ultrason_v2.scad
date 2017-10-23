// * LEGO®, the LEGO® logo, the Brick, DUPLO®, and MINDSTORMS® are trademarks of the LEGO® Group. ©2012 The LEGO® Group, and are not affiliated in any way with this work. 

/* [General] */

// Width of the block, in studs
block_width = 1;

// Length of the block, in studs
block_length = 6;

//Various mounts for sensors
ultrasonic_mount = true; 
side_mount = false;

//Include additional mounts to support the plow? (Note: none is not recomended)
//"solid3x2" vs "solid2deep" vs "solid3deep" vs "button" vs "none" 
plow_mount = "solid2deep"; 

//Include holes for blade?
HolesForBlade = true;


// Height of the block. A ratio of "1" is a standard LEGO brick height; a ratio of "1/3" is a standard LEGO plate height; 
//2+1/3 puts it at the same height as the side mounts.
//4+1/3 is the recomended height with ultrasonic.
block_height_ratio = 4+1/3; // [.33333333333 =1/3 brick, .5=1/2 brick and so on]

//Support clearance. The clearance between automatic supports and the part. If your support is hard to remove then increase this clearance.
clearance = .15;




/* Hidden */

// NO ONE SHOULD HAVE TO CHANGE ANY OF THE BELOW


// If your printer prints the blocks correctly except for the stud diameter (or post diameter for tiles), use this variable to resize the studs & posts for your printer. A value of 1.05 will print the studs at 105% of standard.
//If you are printing in flexible material 1.025 is recomended. 
//If you are printing in hard material 1.00 is recomended.
stud_rescale = 1.025;

//CALCULATIONS

knob_diameter=4.896*stud_rescale;		//knobs on top of blocks
knob_height=1.8+.1;
knob_spacing=8.0;
wall_thickness=1.45;
roof_thickness=.8500;
block_height=9.6*block_height_ratio;
pin_diameter=3.2;		//pin for bottom blocks with width/length of 1
post_diameter=6.5137;  
reinforcing_width=.6;
axle_spline_width=2.0;
axle_diameter=5;
cylinder_precision=0.05;
    overall_length=block_length*8;
	overall_width=block_width*8;
    
//MODEL BEGIN

 //MAIN BLOCK (WITH ANY SUBTRATIONS) 
    if (side_mount == true ){
           translate([8*(block_length/2+1),4*2,9.6+3.2]){block(3,2.05,1/block_height_ratio,axle_hole=false,reinforcement=true);}
           translate([-8*(block_length/2+1),4*2,9.6+3.2]){block(3,2.05,1/block_height_ratio,axle_hole=false,reinforcement=true);} 
     
        //THese are the supports for the overhanging parts.
       translate([-8*block_length/2-8.5,4*2,(9.6+3.2-clearance)/2]){cube([16.2,16.2*1.5+.1,(9.6+3.2-clearance*2)],center = true); }  
       translate([8*block_length/2+8.5,4*2,(9.6+3.2-clearance)/2]){cube([16.2,16.2*1.5+.1,(9.6+3.2-clearance*2)],center = true); }  
    }
    
        
    translate([0,(block_width-1)*4,0]){
    difference(){
    
   block(block_width ,block_length,1,axle_hole=false,reinforcement=true);
    
    //Ultrasonic Sensor Holes, Optional.
    if (ultrasonic_mount == true ){
        rotate(v=[1,0,0],a=90){translate([13,28.6,0]){cylinder(r=8.4,    block_width*8, center=true); }} 
        rotate(v=[1,0,0],a=90){translate([-13,28.6,0]){cylinder(r=8.4,    block_width*8, center=true); }}
        translate([0,4*block_width,22]){cube([10.2,8*block_width+.1,4.5],center = true); }  
        }
        
    //CUT OUT FOR BUTTON MOUNT, Optional.
    if (plow_mount == "button"){
       translate([0,0,(13.5)/2]){cube([16.2*2,8*block_width+.1,(13.501)],center = true); }     
      translate([0,0,(9.59)/2]){cube([50*2,8*block_width+.1,(9.591)],center = true); }        
   } 

    //CUT OUT FOR HARD MOUNTS, optional
    if (plow_mount == "solid3x2"){
       translate([0,0,(9.599)/2]){cube([15.5,8*block_width+.1,(9.6)],center = true); }
   } 
   
       if (plow_mount == "solid2deep"){
       translate([0,0,(9.599)/2]){cube([8*block_length+.1,8*block_width+.1,(9.6)],center = true); }
   } 
   
         if (plow_mount == "solid3deep"){
       translate([0,0,(9.599)/2]){cube([8*block_length+.1,8*block_width+.1,(9.6)],center = true); }
   } 
        
        if (HolesForBlade == true) {  
            bladeholes();    
            }
}}  
   

//MOUNTING ADD ONS
if (plow_mount == "solid3x2"){
     difference(){
        //places the brick in the back
        translate([0,4*block_width+4,0]){block(block_width+2,2,1/block_height_ratio,axle_hole=false,reinforcement=true);}
    
        if (HolesForBlade == true) {  
            bladeholes();    
            }
    }
    
   }else if (plow_mount == "solid2deep"){
     difference(){
        //places the 2x deep brick in the back
        translate([0,4*block_width,0]){block(block_width+1,block_length,1/     block_height_ratio,axle_hole=false,reinforcement=true);}
    
        if (HolesForBlade == true) {  
            bladeholes();    
            }
    }
    
   }else if (plow_mount == "solid3deep"){
     difference(){
        //places the 2x deep brick in the back
        translate([0,4*block_width*2,0]){block(block_width+2,block_length,1/     block_height_ratio,axle_hole=false,reinforcement=true);}
    
        if (HolesForBlade == true) {  
            bladeholes();    
            }
    }
    
   }else if (plow_mount == "button") {
 
      //THIS IS THE PRINTING SUPPORT FOR OVERHANGING MATERIAL. 
       translate([0,(block_width-1)*4,0]){
       translate([-(16.2*2-1)/2,-(8*block_width+.1)/2,0]){cube([16.2*2-1,8*block_width+.1,(13.5-clearance*1.5)],center = false); }  
   }
       
      //places the 2x3 bricks on the sides
          translate([-16-8,4*block_width*2,0]){block(block_width+2,2,1/block_height_ratio,axle_hole=false,reinforcement=true);}
          translate([16+8,4*block_width*2,0]){block(block_width+2,2,1/block_height_ratio,axle_hole=false,reinforcement=true);}
          
              
} else if (plow_mount == "none") {
    
}



module block(width,length,height,axle_hole,reinforcement) {
    overall_length=(length-1)*knob_spacing+knob_diameter/stud_rescale+wall_thickness*2;
	overall_width=(width-1)*knob_spacing+knob_diameter/stud_rescale+wall_thickness*2;
	start=(knob_diameter/2+knob_spacing/2+wall_thickness);
	translate([-overall_length/2,-overall_width/2,0])
		union() {
			difference() {
				union() {
					cube([overall_length,overall_width,height*block_height]);
					translate([knob_diameter/2+wall_thickness,knob_diameter/2+wall_thickness,0]) 
						for (ycount=[0:width-1])
							for (xcount=[0:length-1]) {	
                                translate([xcount*knob_spacing,ycount*knob_spacing,0])
                                cylinder(r=knob_diameter/2,h=block_height*height+knob_height,$fs=cylinder_precision); //the studs on the very top. 
						}
				}
                            
                    translate([wall_thickness,wall_thickness,-roof_thickness]) cube([overall_length-wall_thickness*2,overall_width-wall_thickness*2,block_height*height]);
              						                    
				if (axle_hole==true)
					if (width>1 && length>1) for (ycount=[1:width-1])
						for (xcount=[1:length-1])
							translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,-block_height/2])  axle(height+1);
                        //grooves();
        
			}
	
			if (reinforcement==true && width>1 && length>1)
				difference() {
					for (ycount=[1:width-1])
						for (xcount=[1:length-1])
							translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,0]) reinforcement(height);
					for (ycount=[1:width-1])
						for (xcount=[1:length-1])
							translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,-0.5]) cylinder(r=post_diameter/2-0.1, h=height*block_height+0.5, $fs=cylinder_precision);
				}
	
			if (width>1 && length>1) for (ycount=[1:width-1])
				for (xcount=[1:length-1])
					translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,0]) post(height,axle_hole);
	
			if (width==1 && length!=1)
				for (xcount=[1:length-1])
					translate([(xcount-1)*knob_spacing+start,overall_width/2,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);   
         
            if (width==1 && length!=1)
				for (xcount=[1:length-1])
					translate([(xcount-1)*knob_spacing+start,overall_width/2,block_height/2]) cube([reinforcing_width,7,height*block_height],center=true);     
  
         
			if (length==1 && width!=1)
				for (ycount=[1:width-1])
					translate([overall_length/2,(ycount-1)*knob_spacing+start,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
            if (length==1 && width!=1)
				for (ycount=[1:width-1])
                    translate([overall_length/2,(ycount-1)*knob_spacing+start,block_height/2]) cube([7,reinforcing_width,height*block_height],center=true);  

            }
}

module post(height,axle_hole=false) {
	difference() {
		cylinder(r=post_diameter/2, h=height*block_height,$fs=cylinder_precision);
		translate([0,0,-0.5])
            cylinder(r=knob_diameter/2, h=height*block_height+1,$fs=cylinder_precision);

	}
}

module reinforcement(height) {
	union() {
		translate([0,0,height*block_height/2]) union() {
			cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height],center=true);
			rotate(v=[0,0,1],a=90) cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height], center=true);
		}
	}
}


module axle(height) {
	translate([0,0,height*block_height/2]) union() {
		cube([axle_diameter,axle_spline_width,height*block_height],center=true);
		cube([axle_spline_width,axle_diameter,height*block_height],center=true);
	}
}

module bladeholes(height) {
        //Holes to locate blade.  //because its rotated, Z is the depth. Y is the height
    rotate(v=[1,0,0],a=90){translate([8,4.8+3.2,3.2]){cylinder(r=5, block_width*8, center=true); }} //Blades were sepertes by +/- 21
    rotate(v=[1,0,0],a=90){translate([-8,4.8+3.2,3.2]){cylinder(r=5, block_width*8, center=true); }} 
    }
    