
thickness = 4;
innerMargin = 5;

width = (558 - innerMargin)/2;
length = (468 - innerMargin)/2;
height = 230/2;

teethW = 9;
teethL = 7;
teethH = 5;

handleR = 15;
handleL = 100;
handleThickness = 20;

// test wall
//wall(width, length, thickness, [5, 7, 9, 11], [0, 0, 0, 0]);

tolerance = 0.0;

//assembled = true;
assembled = false;

box();

module box()
{
	angle = assembled?90:0;

	bottom();
	right(angle);
	left(angle);
	rear(angle);
	front(angle);
}

module bottom()
{
	wall(width, length, thickness, [teethW, teethL, teethW, teethL], [0, 0, 0, 0]);
}

module right(angle)
{
	translate([width, 0, 0])
	rotate([0, -1*angle, 0])
	difference()
	{
		wall(height, length, thickness, [teethH, teethL, teethH, 0], [0, 1, 0, 0]);
		hull()
		{
			for(i = [-1:2:1])
			translate([height - handleThickness - handleR, length/2 + handleL/2*i, -1])
			cylinder(r = handleR, h = thickness + 2);
		}
	}
}

module left(angle)
{
	rotate([0, angle, 0])
	translate([-height, 0, 0])
	difference()
	{
		wall(height, length, thickness, [teethH, 0, teethH, teethL], [0, 1, 0, 1]);
		hull()
		{
			for(i = [-1:2:1])
			translate([handleThickness + handleR, length/2 + handleL/2*i, -1])
			cylinder(r = handleR, h = thickness + 2);
		}
	}
}

module front(angle)
{
	rotate([-1*angle, 0, 0])
	translate([0, -height, 0])
	wall(width, height, thickness, [0, teethH, teethW, teethH], [0, 1, 1, 1]);
}

module rear(angle)
{
	translate([0, length, 0])
	rotate([angle, 0, 0])
	wall(width, height, thickness, [teethW, teethH, 0, teethH], [1, 1, 0, 1]);
}

// conf - 4 values showing number of teeth, 0 - teeth are not cut
module wall(x, y, thickness, teethConf, teethOddity)
{
	difference()
	{
		cube([x, y, thickness]);

		if(teethConf[0] > 0)
			cutter(x, teethConf[0], thickness, teethOddity[0]==0);

		if(teethConf[1] > 0)
			translate([0, y, 0])
			rotate([0, 0, -90])
			cutter(y, teethConf[1], thickness, teethOddity[1]==0);

		if(teethConf[2] > 0)
			translate([x, y, 0])
			rotate([0, 0, -180])
			cutter(x, teethConf[2], thickness, teethOddity[2]==0);

		if(teethConf[3] > 0)
			translate([x, 0, 0])
			rotate([0, 0, -270])
			cutter(y, teethConf[3], thickness, teethOddity[3]==0);
	}
}

module cutter(length, count, thickness, odd = true)
{
	for(i = [0:count])
	{
		if(odd && i%2 == 0)
			translate([i*length/count - tolerance, -1, -1])
			cube([length/count + tolerance*2, thickness+1, thickness+2]);
		if(!odd && i%2 != 0)
			translate([i*length/count - tolerance, -1, -1])
			cube([length/count + tolerance*2, thickness+1, thickness+2]);
	}
}


