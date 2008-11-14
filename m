From: Greg KH <greg@kroah.com>
Subject: Re: [patch] add module parameter to provide hardware-calibrated
	coordinate data for MicroTouch/3M touchscreens
Date: Thu, 13 Nov 2008 16:03:24 -0800
Message-ID: <20081114000324.GB19644@kroah.com>
References: <491CB773.2020205@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:57765 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754097AbYKNAHk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 19:07:40 -0500
Content-Disposition: inline
In-Reply-To: <491CB773.2020205@ieee.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Streetman <ddstreet@ieee.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, daniel.ritz@gmx.ch, Vojtech Pavlik <vojtech@suse.cz>

On Thu, Nov 13, 2008 at 06:25:39PM -0500, Dan Streetman wrote:
>
> On Thu, Nov 13, 2008 at 3:31 PM, Greg KH <greg@kroah.com> wrote:
> > On Thu, Nov 13, 2008 at 03:22:52PM -0500, Dan Streetman wrote:
> >>
> >> --- a/drivers/input/touchscreen/usbtouchscreen.c      2008-11-12
> >> 13:06:23.000000000 -0500
> >> +++ b/drivers/input/touchscreen/usbtouchscreen.c      2008-11-12
> >> 13:07:44.000000000 -0500
> >
> > Your patch is line-wrapped :(
>
> Stupid gmail! :(
> I'm trying now with thunderbird but I'm not sure if it has problems also or 
> not.  I'm attaching the patch as well just in case :(

Still linewrapped (the attached version isn't but then you have 2 copies
of the same patch in one email, which our tools do not like...)

> >> @@ -60,6 +60,10 @@ static int swap_xy;
> >>  module_param(swap_xy, bool, 0644);
> >>  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
> >>
> >> +static int hwcalib_xy = 0;
> >> +module_param(hwcalib_xy, bool, 0444);
> >> +MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if 
> available");
> >
> > Should this variable be allowed to be changed at run time?  That might
> > be useful if the code is built into the system.  If so, please change
> > the permissions on the module_param() call.
>
> I set it as read only because I had to override the min/max coordinate 
> values in the mtouch_init() function
> if the hw-calibrated coordinates were being used, so if someone changed the 
> value after a screen
> was already connected, it would start reporting hw-calibrated coordinates 
> but the min/max values
> would still be the raw min/max...however, for people wanting to change the 
> value and then hotplug
> their touchscreens (to reset the min/max values), it would be useful.  
> Below is the patch with the
> permissions adjusted.

This kind of implies that you want this setting on a per-device basis,
right?  Why not make it attached to the individual device instead of a
system-wide option?

thanks,

greg k-h
