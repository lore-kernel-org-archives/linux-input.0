From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: cp2112: use proper hidraw name with minor number
Date: Thu, 2 Mar 2017 15:08:48 +0100
Message-ID: <20170302140848.GM7064@mail.corp.redhat.com>
References: <1488461278-8870-1-git-send-email-climbbb.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbdCBORl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Mar 2017 09:17:41 -0500
Content-Disposition: inline
In-Reply-To: <1488461278-8870-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org

On Mar 02 2017 or thereabouts, Jaejoong Kim wrote:
> The cp2112 driver is working on hidraw not hiddev. So we need to use proper
> hidraw name with hidraw's minor number.
> 
> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

However, this one should probably be sent in the series "[PATCH 0/2]
HID: hiddev: move hiddev's minor number and refactoring" as it is a
requirement for this series.

I'd say resubmit this one in the v2 of the series (with my reviewed-by),
so that the series is consistent and Jiri knows that this one needs to
come before the rest of the series.

Cheers,
Benjamin



>  drivers/hid/hid-cp2112.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index b22d0f8..078026f 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -27,6 +27,7 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/hid.h>
> +#include <linux/hidraw.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/nls.h>
> @@ -1297,7 +1298,8 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	dev->adap.algo_data	= dev;
>  	dev->adap.dev.parent	= &hdev->dev;
>  	snprintf(dev->adap.name, sizeof(dev->adap.name),
> -		 "CP2112 SMBus Bridge on hiddev%d", hdev->minor);
> +		 "CP2112 SMBus Bridge on hidraw%d",
> +		 ((struct hidraw *)hdev->hidraw)->minor);
>  	dev->hwversion = buf[2];
>  	init_waitqueue_head(&dev->wait);
>  
> -- 
> 2.7.4
> 
