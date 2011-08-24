From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch -next] HID: unlock on error path in hid_device_probe()
Date: Wed, 24 Aug 2011 16:40:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108241640010.13644@pobox.suse.cz>
References: <20110824112745.GB5975@shale.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48195 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab1HXOkN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Aug 2011 10:40:13 -0400
In-Reply-To: <20110824112745.GB5975@shale.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: dh.herrmann@googlemail.com, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Wed, 24 Aug 2011, Dan Carpenter wrote:

> We recently introduced locking into this function, but we missed an
> error path which needs an unlock.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 582be00..ed0cd09 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1643,8 +1643,10 @@ static int hid_device_probe(struct device *dev)
>  
>  	if (!hdev->driver) {
>  		id = hid_match_device(hdev, hdrv);
> -		if (id == NULL)
> -			return -ENODEV;
> +		if (id == NULL) {
> +			ret = -ENODEV;
> +			goto unlock;
> +		}
>  
>  		hdev->driver = hdrv;
>  		if (hdrv->probe) {
> @@ -1657,7 +1659,7 @@ static int hid_device_probe(struct device *dev)
>  		if (ret)
>  			hdev->driver = NULL;
>  	}
> -
> +unlock:
>  	up(&hdev->driver_lock);
>  	return ret;
>  }

Good catch Dan, thanks. Applied.

-- 
Jiri Kosina
SUSE Labs
