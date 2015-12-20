From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - use LED API when identifying wireless
 controllers
Date: Sat, 19 Dec 2015 23:55:04 -0800
Message-ID: <20151220075504.GA35575@dtor-ws>
References: <20151216224408.GA14261@dtor-ws>
 <20151219221709.5b5947ec@gromit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36547 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbLTHzH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Dec 2015 02:55:07 -0500
Content-Disposition: inline
In-Reply-To: <20151219221709.5b5947ec@gromit>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Clement Calmels <clement.calmels@free.fr>
Cc: linux-input@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>, "Pierre-Loup A. Griffais" <githubpublic@plagman.net>, linux-kernel@vger.kernel.org

On Sat, Dec 19, 2015 at 10:17:09PM +0100, Clement Calmels wrote:
> On Wed, 16 Dec 2015 14:44:08 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > When lighting up the segment identifying wireless controller, Instead
> > of sending command directly to the controller, let's do it via LED
> > API (usinf led_set_brightness) so that LED object state is in sync
> > with controller state and we'll light up the correct segment on
> > resume as well.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > 
> > I do not have the hardware so please try this out.
> > 
> >  drivers/input/joystick/xpad.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/joystick/xpad.c
> > b/drivers/input/joystick/xpad.c index 36328b3..00a766b 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -1118,7 +1118,7 @@ static void xpad_send_led_command(struct
> > usb_xpad *xpad, int command) */
> >  static void xpad_identify_controller(struct usb_xpad *xpad)
> >  {
> > -	xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
> > +	led_set_brightness(&xpad->led->led_cdev, (xpad->pad_nr % 4)
> > + 2); }
> >  
> >  static void xpad_led_set(struct led_classdev *led_cdev,
> 
> Hi Dimitri,

Hi Clement,

> 
> My hardware: two wireless xpad 360 using a single usb receiver.
> 
> Power on the first gamepad => light the "1" led.
> Power on the second gamepad => light the "2" led.
> 
> Suspend the PC (systemctl suspend): the two gamepads are "disconnected"
> => blinking circle.
> 
> Resume the PC, the two gamepads keep blinking but are working (tested
> with jstest).
> 
> Power off and on the gamepad => still blinking.
> Reload (rmmod/modprobe) the xpad module => still blinking.
> 
> That said, without your patch, the behavior is exactly the same.
> It seems that the suspend/resume broke the led feature. Even using
> the /sys/class/leds/xpad0/brigthness sysfs entry does not work.
> 

OK, so the patch does work (the device is still correctly identified),
but resume requires additional patches. Could you try 'xpad' branch of
my tree on kernel.org [1] and let me know if it works for you?

Thanks!

-- 
Dmitry

[1] git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
