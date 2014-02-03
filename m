From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 2/7] Input: xpad: set the LEDs properly on XBox Wireless controllers
Date: Mon, 3 Feb 2014 18:31:29 +0100
Message-ID: <CANq1E4QS9QVhXOAfogmWt0iQ54n7=HVvjkdE_6a=P2E+wcxD1g@mail.gmail.com>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
	<1391173414-6199-3-git-send-email-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:48376 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbaBCRba (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 12:31:30 -0500
Received: by mail-ig0-f171.google.com with SMTP id uy17so4642002igb.4
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 09:31:29 -0800 (PST)
In-Reply-To: <1391173414-6199-3-git-send-email-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

Hi

On Fri, Jan 31, 2014 at 2:03 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
>
> Add the logic to set the LEDs on XBox Wireless controllers.  Command
> sequence found by sniffing the Windows data stream when plugging the
> device in.
>
> Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/input/joystick/xpad.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 517829f6a58b..aabff9140aaa 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -715,15 +715,37 @@ struct xpad_led {
>
>  static void xpad_send_led_command(struct usb_xpad *xpad, int command)
>  {
> -       if (command >= 0 && command < 14) {
> -               mutex_lock(&xpad->odata_mutex);
> +       if (command > 15)
> +               return;

That's really weird. The "command" argument is used to control which
of the LEDs are enabled, but the underlying led_classdev passes the
brightness value here. Shouldn't we have one led_classdev device for
each LED and make "max_brightness"==1 so it's a boolean value?
I do that for wiimotes so you end up with 4 sysfs entries, one for each LED.

Anyhow, you change "command < 14" to "command > 15" here, is this
intentional also for the XTYPE_XBOX360 path?

> +
> +       mutex_lock(&xpad->odata_mutex);
> +
> +       switch (xpad->xtype) {
> +       case XTYPE_XBOX360:
>                 xpad->odata[0] = 0x01;
>                 xpad->odata[1] = 0x03;
>                 xpad->odata[2] = command;
>                 xpad->irq_out->transfer_buffer_length = 3;
> -               usb_submit_urb(xpad->irq_out, GFP_KERNEL);
> -               mutex_unlock(&xpad->odata_mutex);
> +               break;
> +       case XTYPE_XBOX360W:
> +               xpad->odata[0] = 0x00;
> +               xpad->odata[1] = 0x00;
> +               xpad->odata[2] = 0x08;
> +               xpad->odata[3] = 0x40 + (command % 0x0e);

This basically makes /sys/..../led/brightness a "circular" value here.
Seems weird, but acceptable. But if you bail-out early above with
"command > 15", this here is equivalent to "command & 0x0e", right?

How about removing the "if (command > 15)" above and make both paths
use "(command % 0x0e)"? Anyhow, besides changing the XTYPE_XBOX360
path, patch looks good.

Thanks
David

> +               xpad->odata[4] = 0x00;
> +               xpad->odata[5] = 0x00;
> +               xpad->odata[6] = 0x00;
> +               xpad->odata[7] = 0x00;
> +               xpad->odata[8] = 0x00;
> +               xpad->odata[9] = 0x00;
> +               xpad->odata[10] = 0x00;
> +               xpad->odata[11] = 0x00;
> +               xpad->irq_out->transfer_buffer_length = 12;
> +               break;
>         }
> +
> +       usb_submit_urb(xpad->irq_out, GFP_KERNEL);
> +       mutex_unlock(&xpad->odata_mutex);
>  }
>
>  static void xpad_led_set(struct led_classdev *led_cdev,
> @@ -743,7 +765,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
>         struct led_classdev *led_cdev;
>         int error;
>
> -       if (xpad->xtype != XTYPE_XBOX360)
> +       if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
>                 return 0;
>
>         xpad->led = led = kzalloc(sizeof(struct xpad_led), GFP_KERNEL);
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
