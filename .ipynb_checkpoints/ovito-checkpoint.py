from ovito.io import import_file
import ovito.vis as vis
import sys

    
v = sys.argv[1]
pipeline = import_file("./RUN"+v+"/dump.micelle")

pipeline.add_to_scene()

def modifier_color_radius(frame, data):
    color_property = data.particles_.create_property("Color")
    radius_property = data.particles_.create_property("Radius")
    type_property = data.particles['Particle Type']
    for i in range(len(color_property)):
        if type_property.array[i] == 1:
            radius_property.marray[i] = 0.1
            color_property.marray[i] = (175/250, 40/250, 250/250)
        elif type_property.array[i] == 2:
            radius_property.marray[i] = 0.6
            color_property.marray[i] = (250/250, 211/250,34/250)
        elif type_property.array[i] == 3:
            radius_property.marray[i] = 0.3
            color_property.marray[i] = (154/250, 39/250,250/250)
        else:
            radius_property.marray[i] = 0.3
            color_property.marray[i] = (250/250, 102/250,250/250)

import ovito.modifiers as md
            
# Указываем Ovito какую функцию modifier использовать
pipeline.modifiers.append(
    md.PythonScriptModifier(
        function = modifier_color_radius)
)
  
import math
import math
import numpy as np

data=pipeline.compute().particles.vis.shape = vis.ParticlesVis.Shape.Circle

vp = vis.Viewport()

vp.type = vis.Viewport.Type.Ortho

vp.camera_pos = np.array([15, 17, 1.46947])
vp.camera_dir = np.array([0, 0, -1])
vp.fov = 20.5

vp.render_anim(size=(800,400), filename=("movie"+v+".mp4"),
    renderer=vis.TachyonRenderer(), range=(0,501))