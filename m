From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] hid: usbhid: Return -ENOMEM instead of -1 for memory
 allocation failure
Date: Thu, 22 Nov 2012 22:03:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211222202530.4609@pobox.suse.cz>
References: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43609 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754346Ab2KVVDs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Nov 2012 16:03:48 -0500
In-Reply-To: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, jic23@kernel.org, patches@linaro.org

On Wed, 21 Nov 2012, Sachin Kamat wrote:

> Silences the following smatch warning:
> drivers/hid/usbhid/hiddev.c:897 hiddev_connect() warn:
> returning -1 instead of -ENOMEM is sloppy
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/hid/usbhid/hiddev.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index 14599e2..50e2ab8 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -894,7 +894,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>  	}
>  
>  	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
> -		return -1;
> +		return -ENOMEM;
>  
>  	init_waitqueue_head(&hiddev->wait);
>  	INIT_LIST_HEAD(&hiddev->list);

Well, this would make sense only if the callers would be actualling doing 
something useful with that return value. But the only check we are 
performing at callsites is non-zero test ...

Thanks,

-- 
Jiri Kosina
SUSE Labs
