From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid-lg: Fixes immediate disconnection of Logitech
 Rumblepad 2
Date: Thu, 26 Jan 2017 09:29:28 +0100
Message-ID: <20170126082928.GC13244@mail.corp.redhat.com>
References: <72472ae2-17b1-7e1b-11f2-3ff00c7c6d87@gmail.com>
 <20170124080722.GF9285@mail.corp.redhat.com>
 <4444f83d-f7d2-0bed-5dd2-e44a068ffbfd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752835AbdAZI3e (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 03:29:34 -0500
Content-Disposition: inline
In-Reply-To: <4444f83d-f7d2-0bed-5dd2-e44a068ffbfd@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ardinar23@gmail.com
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>

On Jan 24 2017 or thereabouts, Ardinartsev Nikita wrote:
> 
> 
> 24.01.2017 11:07, Benjamin Tissoires пишет:
> > Hi,
> > 
> > On Jan 20 2017 or thereabouts, Ardinartsev Nikita wrote:
> > > hid-lg: Fixes immediate disconnection of Logitech Rumblepad 2
> > > 
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117091
> > 
> > Having a bug link is fine, but please also write a short description of
> > what you are trying to solve.
> > 
> > > Signed-off-by: Ardinartsev Nikita <ardinar23@gmail.com>
> > > ---
> > >  drivers/hid/hid-lg.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
> > > index c5c5fbe..f1afb6b 100644
> > > --- a/drivers/hid/hid-lg.c
> > > +++ b/drivers/hid/hid-lg.c
> > > @@ -872,7 +872,7 @@ static const struct hid_device_id lg_devices[] = {
> > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > USB_DEVICE_ID_LOGITECH_WINGMAN_FFG),
> > >  		.driver_data = LG_NOGET | LG_FF4 },
> > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
> > > -		.driver_data = LG_FF2 },
> > > +		.driver_data = LG_FF2 | LG_NOGET },
> > 
> > This looks OK, but I'd like to get the confirmation first that the
> > rumble effects are still working.
> > 
> > Cheers,
> > Benjamin
> > 
> > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940),
> > >  		.driver_data = LG_FF3 },
> > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR),
> > > --
> > > 2.7.4
> 
> I just tested vibration with `fftest`:
> fftest /dev/input/event15
> Force feedback test program.
> HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES
> 
> Device /dev/input/event15 opened
> Features:
>   * Absolute axes: X, Y, Z, RZ, Hat 0 X, Hat 0 Y,
>     [27 00 03 00 00 00 00 00 ]
>   * Relative axes:
>     [00 00 ]
>   * Force feedback effects types: Periodic, Rumble, Gain,
>     Force feedback periodic effects: Square, Triangle, Sine,
>     [00 00 00 00 00 00 00 00 00 00 03 07 01 00 00 00 ]
>   * Number of simultaneous effects: 16
> 
> Setting master gain to 75% ... OK
> Uploading effect #0 (Periodic sinusoidal) ... OK (id 0)
> Uploading effect #1 (Constant) ... Error: Invalid argument
> Uploading effect #2 (Spring) ... Error: Invalid argument
> Uploading effect #3 (Damper) ... Error: Invalid argument
> Uploading effect #4 (Strong rumble, with heavy motor) ... OK (id 1)
> Uploading effect #5 (Weak rumble, with light motor) ... OK (id 2)
> 
> Effects 0,4,5 are working in the same way as with xpad driver, gamepad is
> vibrating. `fftest` is working equivalently for D-mode (after patch) and
> X-mode (which always worked). In X-mode `fftest` can't upload effects 1,2,3
> either.

Cool. Thanks for testing. Could you please resubmit a v2 of the patch
with an extended commit message which includes also the fact that you
tested the gamepad with fftest and no regressions where observed?

Cheers,
Benjamin

