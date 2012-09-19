From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH RESEND 1/2] HID: hid-sensor-hub: Remove setting hdev->claimed
 before calling hid_hw_start()
Date: Wed, 19 Sep 2012 13:46:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209191345360.31149@pobox.suse.cz>
References: <1347929533.6562.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58325 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523Ab2ISLqN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Sep 2012 07:46:13 -0400
In-Reply-To: <1347929533.6562.0.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, linux-input@vger.kernel.org

On Tue, 18 Sep 2012, Axel Lin wrote:

> Current implementation of hid_hw_start() allows connect_mask to be 0.
> Setting hdev->claimed = HID_CLAIMED_INPUT before calling hid_hw_start() is not
> necessary. Remove it.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Jonathan, please take it on top of the other changes.

Thanks.

> ---
>  drivers/hid/hid-sensor-hub.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 4ac759c..1faacf2 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -539,7 +539,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	}
>  	INIT_LIST_HEAD(&hdev->inputs);
>  
> -	hdev->claimed = HID_CLAIMED_INPUT;
>  	ret = hid_hw_start(hdev, 0);
>  	if (ret) {
>  		hid_err(hdev, "hw start failed\n");
> @@ -627,7 +626,6 @@ static void sensor_hub_remove(struct hid_device *hdev)
>  	int i;
>  
>  	hid_dbg(hdev, " hardware removed\n");
> -	hdev->claimed &= ~HID_CLAIMED_INPUT;
>  	hid_hw_stop(hdev);
>  	hid_hw_close(hdev);
>  	spin_lock_irqsave(&data->lock, flags);
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Jiri Kosina
SUSE Labs
