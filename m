From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Remove hdev->claimed setting
Date: Sat, 22 Sep 2012 10:35:18 +0100
Message-ID: <505D8656.6020204@kernel.org>
References: <1348068650-1723-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52978 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400Ab2IVJfR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Sep 2012 05:35:17 -0400
In-Reply-To: <1348068650-1723-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, Axel Lin <axel.lin@gmail.com>

On 09/19/2012 04:30 PM, Srinivas Pandruvada wrote:
> From: Axel Lin <[mailto:axel.lin@gmail.com]>
> 
> Current implementation of hid_hw_start() allows connect_mask to be 0.
> Setting hdev->claimed = HID_CLAIMED_INPUT before calling hid_hw_start()
> is not necessary. Remove it.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
added to togreg branch of

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

> ---
>  drivers/hid/hid-sensor-hub.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 80033dc..ffa91cf 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -530,7 +530,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	}
>  	INIT_LIST_HEAD(&hdev->inputs);
>  
> -	hdev->claimed = HID_CLAIMED_INPUT;
>  	ret = hid_hw_start(hdev, 0);
>  	if (ret) {
>  		hid_err(hdev, "hw start failed\n");
> @@ -618,7 +617,6 @@ static void sensor_hub_remove(struct hid_device *hdev)
>  	int i;
>  
>  	hid_dbg(hdev, " hardware removed\n");
> -	hdev->claimed &= ~HID_CLAIMED_INPUT;
>  	hid_hw_stop(hdev);
>  	hid_hw_close(hdev);
>  	spin_lock_irqsave(&data->lock, flags);
> 
