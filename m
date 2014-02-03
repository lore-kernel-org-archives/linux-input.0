From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 7/7] Input: xpad: properly name the LED class devices
Date: Mon, 3 Feb 2014 18:39:20 +0100
Message-ID: <CANq1E4SwvEXeZ3L235PKnSKZaepDfvx+wVy7Q2o6hAA3g-2OTw@mail.gmail.com>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
	<1391173414-6199-8-git-send-email-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:62941 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbaBCRjV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 12:39:21 -0500
Received: by mail-ie0-f180.google.com with SMTP id at1so6509418iec.11
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 09:39:20 -0800 (PST)
In-Reply-To: <1391173414-6199-8-git-send-email-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

Hi

On Fri, Jan 31, 2014 at 2:03 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Don't just increment the LED device number, but use the joystick id so
> that you have a chance to associate the LED device to the correct xpad
> device by the name, instead of having to use the sysfs tree, which
> really doesn't work.
>
> Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/input/joystick/xpad.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index d342d41a7a0d..ae156de46a12 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -781,8 +781,6 @@ static void xpad_led_set(struct led_classdev *led_cdev,
>
>  static int xpad_led_probe(struct usb_xpad *xpad)
>  {
> -       static atomic_t led_seq = ATOMIC_INIT(0);
> -       long led_no;
>         struct xpad_led *led;
>         struct led_classdev *led_cdev;
>         int error;
> @@ -794,9 +792,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
>         if (!led)
>                 return -ENOMEM;
>
> -       led_no = (long)atomic_inc_return(&led_seq) - 1;
> -
> -       snprintf(led->name, sizeof(led->name), "xpad%ld", led_no);
> +       snprintf(led->name, sizeof(led->name), "xpad%d", xpad->joydev_id);

I guess that patch should be dropped, too?
Why not use the usb-interface here? It's quite common to use bt-mac
addresses for BT devices, so something similar for USB seems fine to
me.

Thanks
David

>         led->xpad = xpad;
>
>         led_cdev = &led->led_cdev;
> @@ -944,16 +940,17 @@ static int xpad_init_input(struct usb_xpad *xpad)
>         }
>
>         error = xpad_init_ff(xpad);
> -       if (error)
> -               goto fail_init_ff;
> -
> -       error = xpad_led_probe(xpad);
> -       if (error)
> -               goto fail_init_led;
> +       if (error) {
> +               input_free_device(input_dev);
> +               return error;
> +       }
>
>         error = input_register_device(xpad->dev);
> -       if (error)
> -               goto fail_input_register;
> +       if (error) {
> +               input_ff_destroy(input_dev);
> +               input_free_device(input_dev);
> +               return error;
> +       }
>
>         joydev_dev = device_find_child(&xpad->dev->dev, NULL,
>                                        xpad_find_joydev);
> @@ -966,17 +963,14 @@ static int xpad_init_input(struct usb_xpad *xpad)
>                 xpad_send_led_command(xpad, (xpad->joydev_id % 4) + 2);
>         }
>
> -       return 0;
> -
> -fail_input_register:
> -       xpad_led_disconnect(xpad);
> -
> -fail_init_led:
> -       input_ff_destroy(input_dev);
> +       error = xpad_led_probe(xpad);
> +       if (error) {
> +               input_ff_destroy(input_dev);
> +               input_unregister_device(input_dev);
> +               return error;
> +       }
>
> -fail_init_ff:
> -       input_free_device(input_dev);
> -       return error;
> +       return 0;
>  }
>
>  static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id)
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
