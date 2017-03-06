From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] HID: usbhid: Use pr_<level> and remove unnecessary OOM
 messages
Date: Mon, 6 Mar 2017 10:50:53 +0100
Message-ID: <20170306095053.GX7064@mail.corp.redhat.com>
References: <17564e41463d71d65783b11cb0b337363f90eecc.1488418441.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <17564e41463d71d65783b11cb0b337363f90eecc.1488418441.git.joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mar 01 2017 or thereabouts, Joe Perches wrote:
> Use a more common logging style and remove the unnecessary
> OOM messages as there is default dump_stack when OOM.
> 
> Miscellanea:
> 
> o Hoist an assignment in an if
> o Realign arguments
> o Realign a deeply indented if descendent above a printk
> 
> Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Cheers,
Benjamin

> ---
>  drivers/hid/usbhid/hid-core.c   | 16 +++++++---------
>  drivers/hid/usbhid/hid-quirks.c | 11 ++++-------
>  2 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 961bc6fdd2d9..cd98db6cf94f 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1004,10 +1004,9 @@ static int usbhid_parse(struct hid_device *hid)
>  		return -EINVAL;
>  	}
>  
> -	if (!(rdesc = kmalloc(rsize, GFP_KERNEL))) {
> -		dbg_hid("couldn't allocate rdesc memory\n");
> +	rdesc = kmalloc(rsize, GFP_KERNEL);
> +	if (!rdesc)
>  		return -ENOMEM;
> -	}
>  
>  	hid_set_idle(dev, interface->desc.bInterfaceNumber, 0, 0);
>  
> @@ -1077,8 +1076,8 @@ static int usbhid_start(struct hid_device *hid)
>  		if (hid->quirks & HID_QUIRK_FULLSPEED_INTERVAL &&
>  		    dev->speed == USB_SPEED_HIGH) {
>  			interval = fls(endpoint->bInterval*8);
> -			printk(KERN_INFO "%s: Fixing fullspeed to highspeed interval: %d -> %d\n",
> -			       hid->name, endpoint->bInterval, interval);
> +			pr_info("%s: Fixing fullspeed to highspeed interval: %d -> %d\n",
> +				hid->name, endpoint->bInterval, interval);
>  		}
>  
>  		/* Change the polling interval of mice. */
> @@ -1456,10 +1455,9 @@ static int hid_post_reset(struct usb_interface *intf)
>  	 * the size of the HID report descriptor has not changed.
>  	 */
>  	rdesc = kmalloc(hid->dev_rsize, GFP_KERNEL);
> -	if (!rdesc) {
> -		dbg_hid("couldn't allocate rdesc memory (post_reset)\n");
> +	if (!rdesc)
>  		return -ENOMEM;
> -	}
> +
>  	status = hid_get_class_descriptor(dev,
>  				interface->desc.bInterfaceNumber,
>  				HID_DT_REPORT, rdesc, hid->dev_rsize);
> @@ -1637,7 +1635,7 @@ static int __init hid_init(void)
>  	retval = usb_register(&hid_driver);
>  	if (retval)
>  		goto usb_register_fail;
> -	printk(KERN_INFO KBUILD_MODNAME ": " DRIVER_DESC "\n");
> +	pr_info(KBUILD_MODNAME ": " DRIVER_DESC "\n");
>  
>  	return 0;
>  usb_register_fail:
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index d6847a664446..9287ab03e117 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -237,10 +237,8 @@ static int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct,
>  	}
>  
>  	q_new = kmalloc(sizeof(struct quirks_list_struct), GFP_KERNEL);
> -	if (!q_new) {
> -		dbg_hid("Could not allocate quirks_list_struct\n");
> +	if (!q_new)
>  		return -ENOMEM;
> -	}
>  
>  	q_new->hid_bl_item.idVendor = idVendor;
>  	q_new->hid_bl_item.idProduct = idProduct;
> @@ -306,10 +304,9 @@ int usbhid_quirks_init(char **quirks_param)
>  				&idVendor, &idProduct, &quirks);
>  
>  		if (m != 3 ||
> -				usbhid_modify_dquirk(idVendor, idProduct, quirks) != 0) {
> -			printk(KERN_WARNING
> -					"Could not parse HID quirk module param %s\n",
> -					quirks_param[n]);
> +		    usbhid_modify_dquirk(idVendor, idProduct, quirks) != 0) {
> +			pr_warn("Could not parse HID quirk module param %s\n",
> +				quirks_param[n]);
>  		}
>  	}
>  
> -- 
> 2.10.0.rc2.1.g053435c
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
