From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH] Input: xpad - use LED API when identifying wireless controllers
Date: Thu, 24 Dec 2015 19:11:22 +0100
Message-ID: <CA+b0ujepYgvgC6tTeWBphQLEr+KXXzA48uGzxUvfO8yyXey6UA@mail.gmail.com>
References: <20151216224408.GA14261@dtor-ws> <20151219221709.5b5947ec@gromit>
 <20151220075504.GA35575@dtor-ws> <CA+b0ujeD_qV-MtPx7ktxMWw-UgxZq8d9BN6SgwA3F+RKaXz6ng@mail.gmail.com>
 <20151221200650.GB40090@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33145 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbbLXSLm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2015 13:11:42 -0500
In-Reply-To: <20151221200650.GB40090@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Clement Calmels <clement.calmels@free.fr>, linux-input@vger.kernel.org, "Pierre-Loup A. Griffais" <githubpublic@plagman.net>, linux-kernel@vger.kernel.org

2015-12-21 21:06 GMT+01:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Sun, Dec 20, 2015 at 01:49:25PM +0100, Pavel Rojtberg wrote:
>> 2015-12-20 8:55 GMT+01:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> > On Sat, Dec 19, 2015 at 10:17:09PM +0100, Clement Calmels wrote:
>> >> On Wed, 16 Dec 2015 14:44:08 -0800
>> >> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> >>
>> >> > When lighting up the segment identifying wireless controller, Instead
>> >> > of sending command directly to the controller, let's do it via LED
>> >> > API (usinf led_set_brightness) so that LED object state is in sync
>> >> > with controller state and we'll light up the correct segment on
>> >> > resume as well.
>> >> >
>> >> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> >> > ---
>> >> >
>> >> > I do not have the hardware so please try this out.
>> >> >
>> >> >  drivers/input/joystick/xpad.c | 2 +-
>> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/drivers/input/joystick/xpad.c
>> >> > b/drivers/input/joystick/xpad.c index 36328b3..00a766b 100644
>> >> > --- a/drivers/input/joystick/xpad.c
>> >> > +++ b/drivers/input/joystick/xpad.c
>> >> > @@ -1118,7 +1118,7 @@ static void xpad_send_led_command(struct
>> >> > usb_xpad *xpad, int command) */
>> >> >  static void xpad_identify_controller(struct usb_xpad *xpad)
>> >> >  {
>> >> > -   xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
>> >> > +   led_set_brightness(&xpad->led->led_cdev, (xpad->pad_nr % 4)
>> >> > + 2); }
>> >> >
>> >> >  static void xpad_led_set(struct led_classdev *led_cdev,
>> >>
>> >> Hi Dimitri,
>> >
>> > Hi Clement,
>> >
>> >>
>> >> My hardware: two wireless xpad 360 using a single usb receiver.
>> >>
>> >> Power on the first gamepad => light the "1" led.
>> >> Power on the second gamepad => light the "2" led.
>> >>
>> >> Suspend the PC (systemctl suspend): the two gamepads are "disconnected"
>> >> => blinking circle.
>> >>
>> >> Resume the PC, the two gamepads keep blinking but are working (tested
>> >> with jstest).
>> >>
>> >> Power off and on the gamepad => still blinking.
>> >> Reload (rmmod/modprobe) the xpad module => still blinking.
>> >>
>> >> That said, without your patch, the behavior is exactly the same.
>> >> It seems that the suspend/resume broke the led feature. Even using
>> >> the /sys/class/leds/xpad0/brigthness sysfs entry does not work.
>> >>
>> >
>> > OK, so the patch does work (the device is still correctly identified),
>> > but resume requires additional patches. Could you try 'xpad' branch of
>> > my tree on kernel.org [1] and let me know if it works for you?
>> at least on my machine your follow up patch was also required which I merged at:
>> https://github.com/paroj/xpad/tree/dtor
>>
>> with this patch the controllers still continue blinking after resume,
>> however the URB
>> will still work so they respond to subsequent LED commands triggered
>> via sysfs (or if they are powered off and on).
>>
>> I also verified that a LED command is triggered upon resume - however
>> the controller ignores that.
>> Maybe it is sent too early/ in the wrong order.
>
> I wonder if below helps this.

for me this one did the trick. The correct LED lights up after resume.

Integrated it here (master):
https://github.com/paroj/xpad

@Clemens:
could you try it again with the master branch from my repro? (it has
debug outputs enabled)
If it still does not work, please report back with the dmesg output.

BTW: merry Christmas everyone

Pavel

>
> --
> Dmitry
>
>
> Input: xpad - try waiting for output URB to complete
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/joystick/xpad.c |   41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 30b2fa8..dd7a2af 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -346,9 +346,10 @@ struct usb_xpad {
>         dma_addr_t idata_dma;
>
>         struct urb *irq_out;            /* urb for interrupt out report */
> +       struct usb_anchor irq_out_anchor;
>         bool irq_out_active;            /* we must not use an active URB */
> -       unsigned char *odata;           /* output data */
>         u8 odata_serial;                /* serial number for xbox one protocol */
> +       unsigned char *odata;           /* output data */
>         dma_addr_t odata_dma;
>         spinlock_t odata_lock;
>
> @@ -764,11 +765,13 @@ static int xpad_try_sending_next_out_packet(struct usb_xpad *xpad)
>         int error;
>
>         if (!xpad->irq_out_active && xpad_prepare_next_out_packet(xpad)) {
> +               usb_anchor_urb(xpad->irq_out, &xpad->irq_out_anchor);
>                 error = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
>                 if (error) {
>                         dev_err(&xpad->intf->dev,
>                                 "%s - usb_submit_urb failed with result %d\n",
>                                 __func__, error);
> +                       usb_unanchor_urb(xpad->irq_out);
>                         return -EIO;
>                 }
>
> @@ -811,11 +814,13 @@ static void xpad_irq_out(struct urb *urb)
>         }
>
>         if (xpad->irq_out_active) {
> +               usb_anchor_urb(urb, &xpad->irq_out_anchor);
>                 error = usb_submit_urb(urb, GFP_ATOMIC);
>                 if (error) {
>                         dev_err(dev,
>                                 "%s - usb_submit_urb failed with result %d\n",
>                                 __func__, error);
> +                       usb_unanchor_urb(urb);
>                         xpad->irq_out_active = false;
>                 }
>         }
> @@ -832,6 +837,8 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
>         if (xpad->xtype == XTYPE_UNKNOWN)
>                 return 0;
>
> +       init_usb_anchor(&xpad->irq_out_anchor);
> +
>         xpad->odata = usb_alloc_coherent(xpad->udev, XPAD_PKT_LEN,
>                                          GFP_KERNEL, &xpad->odata_dma);
>         if (!xpad->odata) {
> @@ -864,6 +871,18 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
>   fail1:        return error;
>  }
>
> +static void xpad_stop_output(struct usb_xpad *xpad)
> +{
> +       if (xpad->xtype != XTYPE_UNKNOWN) {
> +               if (!usb_wait_anchor_empty_timeout(&xpad->irq_out_anchor,
> +                                                  5000)) {
> +                       dev_warn(&xpad->intf->dev,
> +                                "timed out waiting for output URB to complete, killing\n");
> +                       usb_kill_anchored_urbs(&xpad->irq_out_anchor);
> +               }
> +       }
> +}
> +
>  static void xpad_deinit_output(struct usb_xpad *xpad)
>  {
>         if (xpad->xtype != XTYPE_UNKNOWN) {
> @@ -924,7 +943,15 @@ static int xpad_start_xbox_one(struct usb_xpad *xpad)
>         packet->len = 5;
>         packet->pending = true;
>
> -       retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL) ? -EIO : 0;
> +       usb_anchor_urb(xpad->irq_out, &xpad->irq_out_anchor);
> +       retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
> +       if (retval) {
> +               dev_err(&xpad->intf->dev,
> +                       "%s - usb_submit_urb failed with result %d\n",
> +                       __func__, retval);
> +               usb_unanchor_urb(xpad->irq_out);
> +               retval = -EIO;
> +       }
>
>         spin_unlock_irqrestore(&xpad->odata_lock, flags);
>
> @@ -1514,15 +1541,14 @@ static void xpad_disconnect(struct usb_interface *intf)
>          * Now that both input device and LED device are gone we can
>          * stop output URB.
>          */
> -       if (xpad->xtype == XTYPE_XBOX360W)
> -               usb_kill_urb(xpad->irq_out);
> +       xpad_stop_output(xpad);
> +
> +       xpad_deinit_output(xpad);
>
>         usb_free_urb(xpad->irq_in);
>         usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
>                         xpad->idata, xpad->idata_dma);
>
> -       xpad_deinit_output(xpad);
> -
>         kfree(xpad);
>
>         usb_set_intfdata(intf, NULL);
> @@ -1548,8 +1574,7 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
>                 mutex_unlock(&input->mutex);
>         }
>
> -       if (xpad->xtype != XTYPE_UNKNOWN)
> -               usb_kill_urb(xpad->irq_out);
> +       xpad_stop_output(xpad);
>
>         return 0;
>  }
