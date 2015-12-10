From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] Input: xpad: handle "present" and "gone" correctly
Date: Wed, 9 Dec 2015 23:02:39 -0800
Message-ID: <20151210070239.GD35505@dtor-ws>
References: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
 <1446391899-24250-2-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33477 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbbLJHCn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2015 02:02:43 -0500
Received: by pabur14 with SMTP id ur14so43051256pab.0
        for <linux-input@vger.kernel.org>; Wed, 09 Dec 2015 23:02:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1446391899-24250-2-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Sun, Nov 01, 2015 at 04:31:35PM +0100, Pavel Rojtberg wrote:
> From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> 
> Handle the "a new device is present" message properly by dynamically
> creating the input device at this point in time. This means we now do
> not "preallocate" all 4 devices when a single
> wireless base station is seen. This requires a workqueue as we are in
> interrupt context when we learn about this.
> 
> Also properly disconnect any devices that we are told are removed.
> 
> Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 66 +++++++++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index fd4100d..23e5613 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -343,8 +343,12 @@ struct usb_xpad {
>  	int xtype;			/* type of xbox device */
>  	int pad_nr;			/* the order x360 pads were attached */
>  	const char *name;		/* name of the device */
> +	struct work_struct work;	/* init/remove device from callback */
>  };
>  
> +static int xpad_init_input(struct usb_xpad *xpad);
> +static void xpad_deinit_input(struct usb_xpad *xpad);
> +
>  /*
>   *	xpad_process_packet
>   *
> @@ -497,6 +501,22 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
>  
>  static void xpad_identify_controller(struct usb_xpad *xpad);
>  
> +static void presence_work_function(struct work_struct *work)
> +{
> +	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
> +	int error;
> +
> +	if (xpad->pad_present) {
> +		error = xpad_init_input(xpad);
> +		if (error) {
> +			/* complain only, not much else we can do here */
> +			dev_err(&xpad->dev->dev, "unable to init device\n");
> +		}
> +	} else {
> +		xpad_deinit_input(xpad);
> +	}
> +}
> +
>  /*
>   * xpad360w_process_packet
>   *
> @@ -513,17 +533,16 @@ static void xpad_identify_controller(struct usb_xpad *xpad);
>   */
>  static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
>  {
> +	int presence;
> +
>  	/* Presence change */
>  	if (data[0] & 0x08) {
> -		if (data[1] & 0x80) {
> -			xpad->pad_present = 1;
> -			/*
> -			 * Light up the segment corresponding to
> -			 * controller number.
> -			 */
> -			xpad_identify_controller(xpad);
> -		} else
> -			xpad->pad_present = 0;
> +		presence = (data[1] & 0x80) != 0;
> +
> +		if (xpad->pad_present != presence) {
> +			xpad->pad_present = presence;
> +			schedule_work(&xpad->work);
> +		}

I think this is racy: we'll crash if we get motion packets before we
finish creating input device. I think we should be returning whether we
want to have xpad->irq_in URB be re-submitted and in case we scheduke
work we'd return "false" and have work resubmit IRQ when it is done
creating or destroying input device.

-- 
Dmitry
