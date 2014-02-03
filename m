From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] Input: xpad: properly name the LED class devices
Date: Mon, 3 Feb 2014 20:46:31 +0100
Message-ID: <20140203194631.GB3625@kroah.com>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
 <1391173414-6199-8-git-send-email-gregkh@linuxfoundation.org>
 <CANq1E4SwvEXeZ3L235PKnSKZaepDfvx+wVy7Q2o6hAA3g-2OTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45517 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbaBCTpD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 14:45:03 -0500
Content-Disposition: inline
In-Reply-To: <CANq1E4SwvEXeZ3L235PKnSKZaepDfvx+wVy7Q2o6hAA3g-2OTw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

On Mon, Feb 03, 2014 at 06:39:20PM +0100, David Herrmann wrote:
> Hi
> 
> On Fri, Jan 31, 2014 at 2:03 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Don't just increment the LED device number, but use the joystick id so
> > that you have a chance to associate the LED device to the correct xpad
> > device by the name, instead of having to use the sysfs tree, which
> > really doesn't work.
> >
> > Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/input/joystick/xpad.c | 40 +++++++++++++++++-----------------------
> >  1 file changed, 17 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> > index d342d41a7a0d..ae156de46a12 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -781,8 +781,6 @@ static void xpad_led_set(struct led_classdev *led_cdev,
> >
> >  static int xpad_led_probe(struct usb_xpad *xpad)
> >  {
> > -       static atomic_t led_seq = ATOMIC_INIT(0);
> > -       long led_no;
> >         struct xpad_led *led;
> >         struct led_classdev *led_cdev;
> >         int error;
> > @@ -794,9 +792,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
> >         if (!led)
> >                 return -ENOMEM;
> >
> > -       led_no = (long)atomic_inc_return(&led_seq) - 1;
> > -
> > -       snprintf(led->name, sizeof(led->name), "xpad%ld", led_no);
> > +       snprintf(led->name, sizeof(led->name), "xpad%d", xpad->joydev_id);
> 
> I guess that patch should be dropped, too?

Yes it should.

> Why not use the usb-interface here? It's quite common to use bt-mac
> addresses for BT devices, so something similar for USB seems fine to
> me.

I don't know if the interface number of the device corrisponds to the
"number" of the order that the devices are connected to the wireless
basestation.  I'll have to do some debugging to determine this first...

But yes, we should use something like that instead of the joydev minor
number, especially if we don't want people to use joydev anymore :)

thanks,

greg k-h
