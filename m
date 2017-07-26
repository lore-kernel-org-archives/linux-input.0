From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 2/2] HID: wacom: Improve generic name generation
Date: Wed, 26 Jul 2017 13:02:56 +0200
Message-ID: <20170726110256.GA24543@mail.corp.redhat.com>
References: <alpine.LSU.2.20.1707201540560.4705@cbobk.fhfr.pm>
 <20170724164619.29228-1-killertofu@gmail.com>
 <20170724164619.29228-2-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbdGZLDD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Jul 2017 07:03:03 -0400
Content-Disposition: inline
In-Reply-To: <20170724164619.29228-2-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Jul 24 2017 or thereabouts, Jason Gerecke wrote:
> The 'wacom_update_name' function is responsible for producing names for
> the input device nodes based on the hardware device name. Commit f2209d4
> added the ability to strip off prefixes like "Wacom Co.,Ltd." where the
> prefix was immediately (and redundantly) followed by "Wacom". The
> 2nd-generation Intuos Pro 2 has such a prefix, but with a small error
> (the period and comma are swapped) that prevents the existing code from
> matching it. We're loath to extend the number of cases out endlessly and
> so instead try to be smarter about name generation.
> 
> We observe that the cause of the redundant prefixes is HID combining the
> manufacturer and product strings of USB devices together. By using the
> original product name (with "Wacom" prefixed, if it does not already
> exist in the string) we can bypass the gyrations to find and remove
> redundant prefixes. Other devices either don't have a manufacturer string
> that needs to be removed (Bluetooth, uhid) or should have their name
> generated from scratch (I2C).
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---

For the series:
Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/wacom_sys.c | 58 +++++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0022c0dac88a..236fd54aa938 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2026,41 +2026,37 @@ static void wacom_update_name(struct wacom *wacom, const char *suffix)
>  
>  	/* Generic devices name unspecified */
>  	if ((features->type == HID_GENERIC) && !strcmp("Wacom HID", features->name)) {
> -		if (strstr(wacom->hdev->name, "Wacom") ||
> -		    strstr(wacom->hdev->name, "wacom") ||
> -		    strstr(wacom->hdev->name, "WACOM")) {
> -			/* name is in HID descriptor, use it */
> -			strlcpy(name, wacom->hdev->name, sizeof(name));
> -
> -			/* strip out excess whitespaces */
> -			while (1) {
> -				char *gap = strstr(name, "  ");
> -				if (gap == NULL)
> -					break;
> -				/* shift everything including the terminator */
> -				memmove(gap, gap+1, strlen(gap));
> -			}
> +		char *product_name = wacom->hdev->name;
>  
> -			/* strip off excessive prefixing */
> -			if (strstr(name, "Wacom Co.,Ltd. Wacom ") == name) {
> -				int n = strlen(name);
> -				int x = strlen("Wacom Co.,Ltd. ");
> -				memmove(name, name+x, n-x+1);
> -			}
> -			if (strstr(name, "Wacom Co., Ltd. Wacom ") == name) {
> -				int n = strlen(name);
> -				int x = strlen("Wacom Co., Ltd. ");
> -				memmove(name, name+x, n-x+1);
> -			}
> +		if (hid_is_using_ll_driver(wacom->hdev, &usb_hid_driver)) {
> +			struct usb_interface *intf = to_usb_interface(wacom->hdev->dev.parent);
> +			struct usb_device *dev = interface_to_usbdev(intf);
> +			product_name = dev->product;
> +		}
>  
> -			/* get rid of trailing whitespace */
> -			if (name[strlen(name)-1] == ' ')
> -				name[strlen(name)-1] = '\0';
> +		if (wacom->hdev->bus == BUS_I2C) {
> +			snprintf(name, sizeof(name), "%s %X",
> +				 features->name, wacom->hdev->product);
> +		} else if (strstr(product_name, "Wacom") ||
> +			   strstr(product_name, "wacom") ||
> +			   strstr(product_name, "WACOM")) {
> +			strlcpy(name, product_name, sizeof(name));
>  		} else {
> -			/* no meaningful name retrieved. use product ID */
> -			snprintf(name, sizeof(name),
> -				 "%s %X", features->name, wacom->hdev->product);
> +			snprintf(name, sizeof(name), "Wacom %s", product_name);
>  		}
> +
> +		/* strip out excess whitespaces */
> +		while (1) {
> +			char *gap = strstr(name, "  ");
> +			if (gap == NULL)
> +				break;
> +			/* shift everything including the terminator */
> +			memmove(gap, gap+1, strlen(gap));
> +		}
> +
> +		/* get rid of trailing whitespace */
> +		if (name[strlen(name)-1] == ' ')
> +			name[strlen(name)-1] = '\0';
>  	} else {
>  		strlcpy(name, features->name, sizeof(name));
>  	}
> -- 
> 2.13.3
> 
