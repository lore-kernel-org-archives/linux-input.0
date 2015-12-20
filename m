From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH] Input: xpad - use LED API when identifying wireless controllers
Date: Sun, 20 Dec 2015 13:49:25 +0100
Message-ID: <CA+b0ujeD_qV-MtPx7ktxMWw-UgxZq8d9BN6SgwA3F+RKaXz6ng@mail.gmail.com>
References: <20151216224408.GA14261@dtor-ws> <20151219221709.5b5947ec@gromit> <20151220075504.GA35575@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35597 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbbLTMtp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Dec 2015 07:49:45 -0500
In-Reply-To: <20151220075504.GA35575@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Clement Calmels <clement.calmels@free.fr>, linux-input@vger.kernel.org, "Pierre-Loup A. Griffais" <githubpublic@plagman.net>, linux-kernel@vger.kernel.org

2015-12-20 8:55 GMT+01:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Sat, Dec 19, 2015 at 10:17:09PM +0100, Clement Calmels wrote:
>> On Wed, 16 Dec 2015 14:44:08 -0800
>> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>>
>> > When lighting up the segment identifying wireless controller, Instead
>> > of sending command directly to the controller, let's do it via LED
>> > API (usinf led_set_brightness) so that LED object state is in sync
>> > with controller state and we'll light up the correct segment on
>> > resume as well.
>> >
>> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> > ---
>> >
>> > I do not have the hardware so please try this out.
>> >
>> >  drivers/input/joystick/xpad.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/input/joystick/xpad.c
>> > b/drivers/input/joystick/xpad.c index 36328b3..00a766b 100644
>> > --- a/drivers/input/joystick/xpad.c
>> > +++ b/drivers/input/joystick/xpad.c
>> > @@ -1118,7 +1118,7 @@ static void xpad_send_led_command(struct
>> > usb_xpad *xpad, int command) */
>> >  static void xpad_identify_controller(struct usb_xpad *xpad)
>> >  {
>> > -   xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
>> > +   led_set_brightness(&xpad->led->led_cdev, (xpad->pad_nr % 4)
>> > + 2); }
>> >
>> >  static void xpad_led_set(struct led_classdev *led_cdev,
>>
>> Hi Dimitri,
>
> Hi Clement,
>
>>
>> My hardware: two wireless xpad 360 using a single usb receiver.
>>
>> Power on the first gamepad => light the "1" led.
>> Power on the second gamepad => light the "2" led.
>>
>> Suspend the PC (systemctl suspend): the two gamepads are "disconnected"
>> => blinking circle.
>>
>> Resume the PC, the two gamepads keep blinking but are working (tested
>> with jstest).
>>
>> Power off and on the gamepad => still blinking.
>> Reload (rmmod/modprobe) the xpad module => still blinking.
>>
>> That said, without your patch, the behavior is exactly the same.
>> It seems that the suspend/resume broke the led feature. Even using
>> the /sys/class/leds/xpad0/brigthness sysfs entry does not work.
>>
>
> OK, so the patch does work (the device is still correctly identified),
> but resume requires additional patches. Could you try 'xpad' branch of
> my tree on kernel.org [1] and let me know if it works for you?
at least on my machine your follow up patch was also required which I merged at:
https://github.com/paroj/xpad/tree/dtor

with this patch the controllers still continue blinking after resume,
however the URB
will still work so they respond to subsequent LED commands triggered
via sysfs (or if they are powered off and on).

I also verified that a LED command is triggered upon resume - however
the controller ignores that.
Maybe it is sent too early/ in the wrong order.

>
> Thanks!
>
> --
> Dmitry
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
