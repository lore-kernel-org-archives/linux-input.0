From: walter harms <wharms@bfs.de>
Subject: Re: [patch] HID: logitech-dj: small cleanup in rdcat()
Date: Sat, 19 Oct 2013 11:46:32 +0200
Message-ID: <526254F8.2070100@bfs.de>
References: <20131019090859.GD9312@longonot.mountain>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20131019090859.GD9312@longonot.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org



Am 19.10.2013 11:08, schrieb Dan Carpenter:
> We could pass the "rdsec" pointer instead of the address of the "rdesc"
> and it's a little simpler.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 2e53024..a7947d8 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -542,9 +542,9 @@ static int logi_dj_output_hidraw_report(struct hid_device *hid, u8 * buf,
>  	return 0;
>  }
>  
> -static void rdcat(char **rdesc, unsigned int *rsize, const char *data, unsigned int size)
> +static void rdcat(char *rdesc, unsigned int *rsize, const char *data, unsigned int size)
>  {
> -	memcpy(*rdesc + *rsize, data, size);
> +	memcpy(rdesc + *rsize, data, size);
>  	*rsize += size;
>  }

That improves readability nicely, an other point is that the function hides the change of rsize.
IMHO it would be better either to return the new address or do the whole add on the caller
side:
suggestion 1:
    	rsize = rdcat();

suggestion 2:
	rsize += rdcat();

Here you see immediately the new offset.

i know it is a matter of taste, it is just what i would do.

re,
 wh


>  
> @@ -567,31 +567,31 @@ static int logi_dj_ll_parse(struct hid_device *hid)
>  	if (djdev->reports_supported & STD_KEYBOARD) {
>  		dbg_hid("%s: sending a kbd descriptor, reports_supported: %x\n",
>  			__func__, djdev->reports_supported);
> -		rdcat(&rdesc, &rsize, kbd_descriptor, sizeof(kbd_descriptor));
> +		rdcat(rdesc, &rsize, kbd_descriptor, sizeof(kbd_descriptor));
>  	}
>  
>  	if (djdev->reports_supported & STD_MOUSE) {
>  		dbg_hid("%s: sending a mouse descriptor, reports_supported: "
>  			"%x\n", __func__, djdev->reports_supported);
> -		rdcat(&rdesc, &rsize, mse_descriptor, sizeof(mse_descriptor));
> +		rdcat(rdesc, &rsize, mse_descriptor, sizeof(mse_descriptor));
>  	}
>  
>  	if (djdev->reports_supported & MULTIMEDIA) {
>  		dbg_hid("%s: sending a multimedia report descriptor: %x\n",
>  			__func__, djdev->reports_supported);
> -		rdcat(&rdesc, &rsize, consumer_descriptor, sizeof(consumer_descriptor));
> +		rdcat(rdesc, &rsize, consumer_descriptor, sizeof(consumer_descriptor));
>  	}
>  
>  	if (djdev->reports_supported & POWER_KEYS) {
>  		dbg_hid("%s: sending a power keys report descriptor: %x\n",
>  			__func__, djdev->reports_supported);
> -		rdcat(&rdesc, &rsize, syscontrol_descriptor, sizeof(syscontrol_descriptor));
> +		rdcat(rdesc, &rsize, syscontrol_descriptor, sizeof(syscontrol_descriptor));
>  	}
>  
>  	if (djdev->reports_supported & MEDIA_CENTER) {
>  		dbg_hid("%s: sending a media center report descriptor: %x\n",
>  			__func__, djdev->reports_supported);
> -		rdcat(&rdesc, &rsize, media_descriptor, sizeof(media_descriptor));
> +		rdcat(rdesc, &rsize, media_descriptor, sizeof(media_descriptor));
>  	}
>  
>  	if (djdev->reports_supported & KBD_LEDS) {
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
