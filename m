From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch 2/2] usbhid: fix some error codes in hiddev_connect()
Date: Thu, 26 May 2011 14:07:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105261406260.28291@pobox.suse.cz>
References: <20110526085018.GE14591@shale.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34371 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757295Ab1EZMHC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2011 08:07:02 -0400
In-Reply-To: <20110526085018.GE14591@shale.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: "open list:USB HID/HIDBP DRI..." <linux-usb@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Thu, 26 May 2011, Dan Carpenter wrote:

> Returning -1 is -EPERM which is inappropriate here.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index b2f9a3a..80b8e76 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -890,8 +890,9 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>  			return -1;
>  	}
>  
> -	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
> -		return -1;
> +	hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL);
> +	if (!hiddev)
> +		return -ENOMEM;
>  
>  	init_waitqueue_head(&hiddev->wait);
>  	INIT_LIST_HEAD(&hiddev->list);
> @@ -905,7 +906,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>  		hid_err(hid, "Not able to get a minor for this device\n");
>  		hid->hiddev = NULL;
>  		kfree(hiddev);
> -		return -1;
> +		return retval;
>  	}
>  	return 0;
>  }

Why would that matter?

hid_connect() (which is the only caller) only checks for the return value 
being (non-)zero.

-- 
Jiri Kosina
SUSE Labs
