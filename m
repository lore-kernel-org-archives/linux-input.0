From: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>
Subject: Re: [patch] add module parameter to provide hardware-calibrated
 coordinate data for MicroTouch/3M touchscreens
Date: Fri, 14 Nov 2008 11:17:45 -0500 (EST)
Message-ID: <alpine.LNX.1.10.0811141037400.3866@floyd.root.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.ritz-OI3hZJvNYWs@public.gmane.org, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


On Thu, Nov 13, 2008 at 7:03 PM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
>
> On Thu, Nov 13, 2008 at 06:25:39PM -0500, Dan Streetman wrote:
> >
> > On Thu, Nov 13, 2008 at 3:31 PM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> > > On Thu, Nov 13, 2008 at 03:22:52PM -0500, Dan Streetman wrote:
> > >>
>
> Still linewrapped (the attached version isn't but then you have 2 copies
> of the same patch in one email, which our tools do not like...)

Ok, back to (al)pine it is then for patch submissions :)

I can't believe it's been so long since I used pine or sent a patch in...

>
> > >> @@ -60,6 +60,10 @@ static int swap_xy;
> > >>  module_param(swap_xy, bool, 0644);
> > >>  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
> > >>
> > >> +static int hwcalib_xy = 0;
> > >> +module_param(hwcalib_xy, bool, 0444);
> > >> +MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if
> > available");
> > >
> > > Should this variable be allowed to be changed at run time?  That might
> > > be useful if the code is built into the system.  If so, please change
> > > the permissions on the module_param() call.
> >
> > I set it as read only because I had to override the min/max coordinate
> > values in the mtouch_init() function
> > if the hw-calibrated coordinates were being used, so if someone changed the
> > value after a screen
> > was already connected, it would start reporting hw-calibrated coordinates
> > but the min/max values
> > would still be the raw min/max...however, for people wanting to change the
> > value and then hotplug
> > their touchscreens (to reset the min/max values), it would be useful.
> > Below is the patch with the
> > permissions adjusted.
>
> This kind of implies that you want this setting on a per-device basis,
> right?  Why not make it attached to the individual device instead of a
> system-wide option?

Oh no, I don't think it is useful on a per-device basis; I was only concerned 
about changing the value after a touchscreen had been connected.

I hadn't intended to get into the details of whether I think the raw coordinate 
data or hardware-calibrated coordinate data is better, but I guess I might as 
well :)

My opinion is that there is no benefit in using the raw coordinate data, at all.  
All the advantages are with the hardware-calibrated coordinate data:

1) The hw-calibrated data has a higher resolution, of 0xffff on each axis; the 
raw coordinate data has a resolution of 0x4000 on each axis.  No benefit to the 
raw data here.

2) The raw coordinates will never match the screen position, regardless of 
whether the screen is hardware-calibrated.  The hw-calibrated coordinates will 
match exactly the screen position if the screen is hw-calbrated.

3) With capacitive and resistive touchscreens, the raw coordinate values "drift" 
over time.  So occasionally, some calibration has to be done.  If the raw data 
is being used, then software calibration has to be done; if the hw-calibrated 
data is being used, then *either* software calibration or hardware calibration 
can be done.

4) Backwards compatibility is broken if we switch, however.  Anyone who has 
their system set up with a Microtouch touchscreen with software calibration will 
have to re-perform the software calibration one time.

I'll briefly explain my understanding of what is involved from the user end with 
both approaches.  Etiher way, the usbtouchscreen module creates an evdev node 
with ABS_X and ABS_Y coordinates, and it reports the min and max of those 
coordinate ranges as 0 to 0x4000 for the raw data or 0 to 0xffff if changed to 
use the hw-calib data.  The xorg.conf file has a InputDevice section added to 
use the "evdev" driver.  The X evdev driver reads the evdev node's reported 
minimum and maximum ABS_X and ABS_Y values.  It uses those values to map all 
incoming coordinate points into a screen position.  When using the raw 
coordinate data, those min and max values *do not* correspond to the actual min 
and max values that will be sent when touching the corners of the screen, 
specifically because it is raw data - the actual min and max values will vary 
per touchscreen, and over time with "drift".  So the user *has* to manually find 
the actual min and max X and Y values and put that into the xorg.conf file so X 
will know what the correct values to use are.  However, when using the 
hardware-calibrated coordinates, if the touchscreen is correctly hw-calibrated, 
the min and max values of 0-0xffff do exactly match the values reported when 
touching the corners of the screen.  So there is no need to put any min/max 
values manually into the xorg.conf file.  In fact, with a hardware-calibrated 
touchscreen and a simple, generic evdev InputDevice section int the xorg.conf 
file, you can just plug the touchscreen in and it will immediately and fully 
automatically work with the cursor directly under your finger.

Now, I realize I've been saying "with a hw-calibrated touchscreen".  So how is 
it hw-calibrated?  Right now, either by using one fresh from manufacturing, or 
by using another system that does have a hw-calibration program (e.g. Windows).  
But, Microtouch does publish the full spec for these devices including how to 
hardware-calibrate them, and it is actually rather easy.  Part of my "next 
steps" is to add a simple way to perform hardware calibration on these 
touchscreens in Linux.

But I want to point out, that besides the one-time need to change any 
existing user's software calibration values, there is no difference from a 
software-calibration point of view between the raw coordinates and the 
hardware-calibration coordinates.  You can still use "touchcal" to get the 
actual min/max values and manually put that into your xorg.conf file.  Even if 
the touchscreen is not hardware-calibrated, it will work fine.


So, what I really think the patch should do is not add a module parameter, but 
simply change the values over to use the hw-calibrated coordinate data, and 
ignore the raw coordinate data.  Does everyone agree?


>
> thanks,
>
> greg k-h


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
