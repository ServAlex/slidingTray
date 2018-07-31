# slidingTray
https://www.thingiverse.com/thing:3020851

# there are several display modes:
mode = "assembled"
walls and floor are arranged into a box configuration

mode = "unfolded"
walls are laid flat

mode = "optimized"
walls are laid flat and arranged to minimize waste

mode = "projection"
same as optimized but added a projection for dxf export

# parameters:
width, length, height parameters are outer dimensions of the box
thickness is thickness of the material
tolerance is subtracted from the width of the teeth, negative value for tighter fit

teethW, teethL, teethH - number of teeth along width, length and height

slitPresent - whether to add slit for handling or not
slitR - handle slit rounding radius
slitL - length of the slit
slitThickness - thickness of the remaining material
