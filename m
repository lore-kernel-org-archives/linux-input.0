From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: gtco: fix crash on detecting device without
 endpoints
Date: Thu, 31 Mar 2016 10:57:35 -0700
Message-ID: <20160331175735.GD39098@dtor-ws>
References: <1458326100-14899-1-git-send-email-vdronov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458326100-14899-1-git-send-email-vdronov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladis Dronov <vdronov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 18, 2016 at 07:35:00PM +0100, Vladis Dronov wrote:
> The gtco driver expects at least one valid endpoint. If given
> malicious descriptors that specify 0 for the number of endpoints,
> it will crash in the probe function. Ensure there is at least
> one endpoint on the interface before using it. Fix minor coding
> style issue.
> 
> The full report of this issue can be found here:
> http://seclists.org/bugtraq/2016/Mar/86
> 
> Reported-by: Ralf Spenneberg <ralf-bSzMNvQHHtybz89kn3q7ow@public.gmane.org>
> Signed-off-by: Vladis Dronov <vdronov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/tablet/gtco.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
> index 3a7f3a4..7c18249 100644
> --- a/drivers/input/tablet/gtco.c
> +++ b/drivers/input/tablet/gtco.c
> @@ -858,6 +858,14 @@ static int gtco_probe(struct usb_interface *usbinterface,
>  		goto err_free_buf;
>  	}
>  
> +	/* Sanity check that a device has an endpoint */
> +	if (usbinterface->altsetting[0].desc.bNumEndpoints < 1) {
> +		dev_err(&usbinterface->dev,
> +			"Invalid number of endpoints\n");
> +		error = -EINVAL;
> +		goto err_free_urb;
> +	}
> +
>  	/*
>  	 * The endpoint is always altsetting 0, we know this since we know
>  	 * this device only has one interrupt endpoint
> @@ -879,7 +887,7 @@ static int gtco_probe(struct usb_interface *usbinterface,
>  	 * HID report descriptor
>  	 */
>  	if (usb_get_extra_descriptor(usbinterface->cur_altsetting,
> -				     HID_DEVICE_TYPE, &hid_desc) != 0){
> +				     HID_DEVICE_TYPE, &hid_desc) != 0) {
>  		dev_err(&usbinterface->dev,
>  			"Can't retrieve exta USB descriptor to get hid report descriptor length\n");
>  		error = -EIO;
> -- 
> 2.5.0

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
