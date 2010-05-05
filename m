From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT messages
Date: Wed, 05 May 2010 23:19:11 +0200
Message-ID: <4BE1E0CF.9020008@tudelft.nl>
References: <4BE1629E.50901@tudelft.nl> <20100505163832.GA7337@core.coreip.homeip.net> <4BE1B289.2040204@euromail.se> <4BE1B595.9090705@tudelft.nl> <4BE1B84C.1040903@euromail.se> <4BE1BA57.5080709@tudelft.nl> <4BE1C198.3080809@euromail.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010807040008010400000100"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:51967 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758509Ab0EEVTP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 17:19:15 -0400
In-Reply-To: <4BE1C198.3080809@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Benjamin Tissoires <tissoire@cena.fr>

This is a multi-part message in MIME format.
--------------010807040008010400000100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Op 05-05-10 21:06, Henrik Rydberg schreef:
> Éric Piel wrote:
>>
>> BTW, does anyone know a graphical app which reads the MT events from a
>> /dev/input/eventX device and displays them as points in a window? That
>> would be rather helpful to reverse-engineer/debug multitouch hardwares.
> 
> Something like fingermgmt in OSX? Not to my knowledge. The touchd project
> includes some graphics via python, but is not based on MT events. Maybe our
> friends at ENAC has something cooking?

Thanks a lot for the tips.
I've hacked up an app which does just this, based on touchd and
pyinputevent.

Apparently when there are two fingers, the hardware doesn't report
really the finger coordinates but the lowest and highest points of the
rectangle defined by the two fingers.

For those who want to tinker too, attached is the source code of my
hack. Note that the synaptics driver grabs the event device so normally
you cannot receive anything. So you need to disable it, for instance
with a HAL rule like this:
 <?xml version="1.0" encoding="ISO-8859-1"?>
<deviceinfo version="0.2">
  <device>
    <match key="info.capabilities" contains="input.touchpad">
       <match key="info.product" contains="ETPS/2 Elantech Touchpad">
        <merge key="input.x11_driver" type="string">mult</merge>
       </match>
    </match>
  </device>
</deviceinfo>

Then a rmmod psmouse; modprobe psmouse should free the device. You also
need pyinputevent.py in the same directory.

See you,
Eric

--------------010807040008010400000100
Content-Type: text/x-python;
 name="fingerviewer.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fingerviewer.py"

# Copyright 2010, Eric Piel <eric.piel@tremplin-utc.net>

# This file contains part of touchd - 2008, Scott Shawcroft, scott.shawcroft@gmail.com
# This file uses pyinputevent available http://github.com/rmt/pyinputevent/ by Robert Thomson and individual contributors.

# FingerViewer is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.

# FingerViewer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with FingerViewer.  If not, see <http://www.gnu.org/licenses/>.

# Runs the finger view window.
# use a command like:
# sudo python fingerviewer.py /dev/input/event1

import pygtk
import gtk
import math
import time
import threading, thread
from pyinputevent import *

gtk.gdk.threads_init()


class MouseDevice(SimpleDevice):
    """
    Report Multitouch events
    """
    def __init__(self, viewer, *args, **kwargs):
        SimpleDevice.__init__(self, *args, **kwargs)
        self.viewer = viewer
        self.x = 0
        self.y = 0
        self.num = 0
    def receive(self, event):
        etype, ecode, evalue = (
            event.etype,
            event.ecode,
            event.evalue,
        )
        #print "%s" % event
        if etype == 3:
            if ecode == 53:
                self.x = evalue
            elif ecode == 54:
                self.y = evalue
        elif etype == 0:
            if ecode == 2:
               viewer.got_finger(self.num, self.x, self.y, 0, 0, 10)
               self.num += 1
            elif ecode == 0:
               self.num = 0
            

class FingerViewer:
	def __init__(self):
		self.window = gtk.Window()
		self.window.set_title("Fingers")
		self.width = 400
		self.height = 200
		self.window.width = self.width
		self.window.height = self.height
		
		self.window.connect("destroy",self.hide)
		self.window.show()
		
		self.image = gtk.Image()
		self.image.show()
		self.window.add(self.image)
		
		pixmap = gtk.gdk.Pixmap(None,self.width,self.height,24)
		self.image.set_from_pixmap(pixmap,None)
		self.context = pixmap.cairo_create()
		self.context.rectangle(0,0,self.width,self.height)
		self.context.set_source_rgb(1,1,1)
		self.context.fill()
		
		self.context.set_line_width(2)
		
		self.fingers = []
	
	def got_finger(self,num,x,y,dx,dy,p):
		if num==0:
			# update the image
			self.draw_all()
		
		self.fingers.append((num,x,y,dx,dy,p))

	def draw_all(self):
		self.context.rectangle(0,0,self.width,self.height) # fill with white
		self.context.set_source_rgb(1,1,1)
		self.context.fill()
		
		for i in range(len(self.fingers)):
			num,x,y,dx,dy,p = self.fingers[i]
			self.draw_finger(num,x,y,dx,dy,p)
		
		self.image.queue_draw()
		self.fingers = []

	def draw_finger(self,num,x,y,dx,dy,p):
		dy*=-1
		
		# draw the finger
		tx = self.translate_x(x)
		ty = self.translate_y(y)
		self.context.arc(tx,ty,10+p/500.0*20,0,2*math.pi)
		self.context.set_source_rgba(0,0,1)
		self.context.fill()
		
		# draw the velocity
		VRES = 500
		VSCALE = 100
		self.context.set_source_rgb(0,0,0)
		self.context.move_to(tx,ty)
		self.context.line_to(tx+(float(dx)/VRES)*VSCALE,ty-(float(dy)/VRES)*VSCALE)
		self.context.stroke()
		
		# draw number label
		self.context.set_source_rgb(1,1,1)
		self.context.move_to(tx-5,ty+5)
		self.context.set_font_size(15)
		self.context.show_text(str(num+1))
	
	def num_fingers(self,i):
		if i==0:
			self._wipe()
	
	# translate to the graphical coordinates
	def translate_x(self,v):
		XRES = 1152
		return ((float(v)/XRES)*(self.width))
	
	# translate to the graphical coordinates
	def translate_y(self,v):
		YRES = 768
		YOFF = 0
		return ((float(v+YOFF)/YRES)*(self.height))
	
	def hide(self,widget):
		#self.window.hide()
                gtk.main_quit()

	def readValues(self, args):
            import select
            controller = Controller("Controller")
            fds = {}
            poll = select.poll()
            dev = args
            print dev
            dev = MouseDevice(self, dev)
            fds[dev.fileno()] = dev
            poll.register(dev, select.POLLIN | select.POLLPRI)
            while True:
                for x,e in poll.poll():
                    dev = fds[x]
                    dev.read()

if __name__ == "__main__":
    viewer = FingerViewer()
    threading.Thread(target=viewer.readValues, args=sys.argv[1:]).start()
    gtk.main()


# vim:shiftwidth=4:expandtab:spelllang=en_gb:spell:         

--------------010807040008010400000100--
