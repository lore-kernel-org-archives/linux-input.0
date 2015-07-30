From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/8] Input: xpad: handle "present" and "gone" correctly
Date: Thu, 30 Jul 2015 00:06:29 -0700
Message-ID: <20150730070629.GE35939@dtor-ws>
References: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
 <1436572068-10661-6-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34747 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbbG3HGd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 03:06:33 -0400
Received: by pdbbh15 with SMTP id bh15so19387907pdb.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2015 00:06:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436572068-10661-6-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Sat, Jul 11, 2015 at 01:47:45AM +0200, Pavel Rojtberg wrote:
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
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 43 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 3349861..a9ff4c2 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -343,8 +343,12 @@ struct usb_xpad {
>  	int xtype;			/* type of xbox device */
>  	unsigned long pad_nr;		/* the order x360 pads were attached */
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
> @@ -488,6 +492,22 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
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
> @@ -504,13 +524,16 @@ static void xpad_identify_controller(struct usb_xpad *xpad);
>   */
>  static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
>  {
> +	int presence;
> +
>  	/* Presence change */
>  	if (data[0] & 0x08) {
> -		if (data[1] & 0x80) {
> -			xpad->pad_present = 1;
> -			xpad_identify_controller(xpad);
> -		} else
> -			xpad->pad_present = 0;
> +		presence = (data[1] & 0x80) != 0;
> +
> +		if (xpad->pad_present != presence) {
> +			xpad->pad_present = presence;
> +			schedule_work(&xpad->work);
> +		}
>  	}

So what happens if we start without the input device, schedule it to be
added and then receive a valid pad data packet before work item had a
chance to run and input device is still not created? We are going crash
and burn :(

Thanks.

-- 
Dmitry
