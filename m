From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] add module parameter to provide hardware-calibrated
	coordinate data for MicroTouch/3M touchscreens
Date: Sat, 15 Nov 2008 22:08:35 +0100
Message-ID: <20081115210835.GH6995@suse.cz>
References: <3fad22b40811131222k3a168a06tfe01b09ca106e0a2@mail.gmail.com> <20081114213125.GA6995@suse.cz> <3fad22b40811141346t5b4f90f8t3bfeaf34023222bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:33220 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751518AbYKOVJT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Nov 2008 16:09:19 -0500
Content-Disposition: inline
In-Reply-To: <3fad22b40811141346t5b4f90f8t3bfeaf34023222bc@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Streetman <ddstreet@ieee.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Greg KH <greg@kroah.com>, daniel.ritz@gmx.ch

On Fri, Nov 14, 2008 at 04:46:08PM -0500, Dan Streetman wrote:
> Ok - I'll update the patch to invert Y before reporting.
> 
> On the issue of whether to use a module param to send raw coordinates
> or hw-calibrated coordinates, or to just change the code to report the
> hw-calibrated coordinates instead of the raw coordinates, what do you
> think?

I'm in favor for the option, because of:

	* backwards compatibility 
	* the Linux input standard is unprocessed coordinate data
	  (but after compensating for all hardware quirks)
	* most touchscreens can't do HW calibration anyway, and we
	  benefit from common SW calibration code, eg in tslib

Actually, I don't see much value in the hw-calibrated data, but I see it
could be useful in some cases, so I'm still fine with adding the
possibility to use that mode.

Vojtech

> 
> On Fri, Nov 14, 2008 at 4:31 PM, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Thu, Nov 13, 2008 at 03:22:52PM -0500, Dan Streetman wrote:
> >
> >> Note that the Y axis is inverted as reported by the touchscreen, so
> >> this reverses the Y min and max (0xffff for the min, 0 for the max).
> >> This works fine on my system using the X evdev driver.
> >
> >> +     // Default min/max xy are the raw values, override if using hw-calib
> >> +     if (hwcalib_xy) {
> >> +             input_set_abs_params(usbtouch->input, ABS_X, 0, 0xffff, 0, 0);
> >> +             input_set_abs_params(usbtouch->input, ABS_Y, 0xffff, 0, 0, 0);
> >
> > While it does work with the X evdev, please don't do it, and instead do
> > the inversion before reporting ABS_Y. Linux input devices should follow
> > the (USB) HID specification of axis direction and stick to it. The
> > behaviour with reversed min/max is undefined.
> >
> > --
> > Vojtech Pavlik
> > Director SuSE Labs
> >
> 

-- 
Vojtech Pavlik
Director SuSE Labs
