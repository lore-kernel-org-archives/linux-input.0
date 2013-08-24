From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom - fix error return code in wacom_probe()
Date: Sat, 24 Aug 2013 16:41:44 -0700
Message-ID: <20130824234144.GE4454@core.coreip.homeip.net>
References: <CAPgLHd99Hc=EvmNSv6D4X=HYhDsypwHDGjN9eNJktmGZ_qOABQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60430 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab3HXXlr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Aug 2013 19:41:47 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so2022702pbc.7
        for <linux-input@vger.kernel.org>; Sat, 24 Aug 2013 16:41:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPgLHd99Hc=EvmNSv6D4X=HYhDsypwHDGjN9eNJktmGZ_qOABQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: killertofu@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com, fengguang.wu@intel.com, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

Hi Wei,

On Fri, Aug 23, 2013 at 10:53:00AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the urb submit error
> handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/input/tablet/wacom_sys.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index aaf23ae..7eeac61 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -1366,7 +1366,8 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
>  	usb_set_intfdata(intf, wacom);
>  
>  	if (features->quirks & WACOM_QUIRK_MONITOR) {
> -		if (usb_submit_urb(wacom->irq, GFP_KERNEL))
> +		error = usb_submit_urb(wacom->irq, GFP_KERNEL);
> +		if (error)
>  			goto fail5;
>  	}

If I remember correctly usb_submit_urb() uses errno definitions in a
creative way, so returning them verbatim to the upper layers is not teh
beset solution. I will change this to return -EIO instead.

Thanks.

-- 
Dmitry
