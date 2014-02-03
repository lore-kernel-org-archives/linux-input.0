From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 6/7] Input: xpad: handle "present" and "gone" correctly
Date: Mon, 3 Feb 2014 18:37:13 +0100
Message-ID: <CANq1E4QcTBDoTbyJrQSVPz8SNs+wa1ONhi8U1pqwJSxPZo18uQ@mail.gmail.com>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
	<1391173414-6199-7-git-send-email-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45944 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbaBCRhO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 12:37:14 -0500
Received: by mail-ie0-f173.google.com with SMTP id e14so6515616iej.32
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 09:37:13 -0800 (PST)
In-Reply-To: <1391173414-6199-7-git-send-email-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

Hi

On Fri, Jan 31, 2014 at 2:03 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
>
> Handle the "a new device is present" message properly by dynamically
> creating the input device at this point in time.  This requires a
> workqueue as we are in interrupt context when we learn about this.
>
> Also properly disconnect any devices that we are told are removed.
>
> Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/input/joystick/xpad.c | 50 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 7a07b95790d7..d342d41a7a0d 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -293,8 +293,11 @@ struct usb_xpad {
>         int xtype;                      /* type of xbox device */
>         int joydev_id;                  /* the minor of the device */
>         const char *name;               /* name of the device */
> +       struct work_struct work;        /* to init/remove device from callback */
>  };
>
> +static int xpad_init_input(struct usb_xpad *xpad);
> +
>  /*
>   *     xpad_process_packet
>   *
> @@ -437,6 +440,22 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
>         input_sync(dev);
>  }
>
> +static void presence_work_function(struct work_struct *work)
> +{
> +       struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
> +       int error;
> +
> +       if (xpad->pad_present) {
> +               error = xpad_init_input(xpad);
> +               if (error) {
> +                       /* complain only, not much else we can do here */
> +                       dev_err(&xpad->dev->dev, "unable to init device\n");
> +               }
> +       } else {
> +               input_unregister_device(xpad->dev);
> +       }
> +}
> +
>  /*
>   * xpad360w_process_packet
>   *
> @@ -451,16 +470,22 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
>   * 01.1 - Pad state (Bytes 4+) valid
>   *
>   */
> -
>  static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
>  {
>         /* Presence change */
>         if (data[0] & 0x08) {
>                 if (data[1] & 0x80) {
> -                       xpad->pad_present = 1;
> -                       usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
> -               } else
> -                       xpad->pad_present = 0;
> +                       if (!xpad->pad_present) {
> +                               xpad->pad_present = 1;
> +                               usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
> +                               schedule_work(&xpad->work);
> +                       }
> +               } else {
> +                       if (xpad->pad_present) {
> +                               xpad->pad_present = 0;
> +                               schedule_work(&xpad->work);
> +                       }
> +               }
>         }
>
>         /* Valid pad data */
> @@ -507,10 +532,13 @@ static void xpad_irq_in(struct urb *urb)
>         }
>
>  exit:
> -       retval = usb_submit_urb(urb, GFP_ATOMIC);
> -       if (retval)
> -               dev_err(dev, "%s - usb_submit_urb failed with result %d\n",
> -                       __func__, retval);
> +       if (xpad->pad_present) {
> +               retval = usb_submit_urb(urb, GFP_ATOMIC);
> +               if (retval)
> +                       dev_err(dev,
> +                               "%s - usb_submit_urb failed with result %d\n",
> +                               __func__, retval);
> +       }
>  }
>
>  static void xpad_bulk_out(struct urb *urb)
> @@ -991,6 +1019,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>         xpad->mapping = xpad_device[i].mapping;
>         xpad->xtype = xpad_device[i].xtype;
>         xpad->name = xpad_device[i].name;
> +       INIT_WORK(&xpad->work, presence_work_function);
>
>         if (xpad->xtype == XTYPE_UNKNOWN) {
>                 if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
> @@ -1136,7 +1165,8 @@ static void xpad_disconnect(struct usb_interface *intf)
>         struct usb_xpad *xpad = usb_get_intfdata (intf);
>
>         xpad_led_disconnect(xpad);
> -       input_unregister_device(xpad->dev);

You need cancel_work_sync(&xpad->work) here.
And I think you need to do that *after* killing the urbs. Otherwise,
the work might get rescheduled in parallel to this disconnect
callback.

Thanks
David

> +       if (xpad->pad_present)
> +               input_unregister_device(xpad->dev);
>         xpad_deinit_output(xpad);
>
>         if (xpad->xtype == XTYPE_XBOX360W) {
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
