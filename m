From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] sensor-hub: Remove pointless NULL check
Date: Thu, 18 Oct 2012 11:58:14 -0700
Message-ID: <50805146.6060904@linux.intel.com>
References: <20121009142010.16433.64833.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58257 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab2JRS5f (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Oct 2012 14:57:35 -0400
In-Reply-To: <20121009142010.16433.64833.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org


Agreed. It was a mistake.

Thanks,
Srinivas

On 10/09/2012 07:20 AM, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
>
> report cannot be NULL, fortunately as we use it before we check !
>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>
>   drivers/hid/hid-sensor-hub.c |    4 ----
>   1 file changed, 4 deletions(-)
>
>
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index d9d73e9..4ff2497 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -437,9 +437,6 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
>   	ptr = raw_data;
>   	ptr++; /*Skip report id*/
>   
> -	if (!report)
> -		goto err_report;
> -
>   	spin_lock_irqsave(&pdata->lock, flags);
>   
>   	for (i = 0; i < report->maxfield; ++i) {
> @@ -485,7 +482,6 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
>   				callback->pdev);
>   	spin_unlock_irqrestore(&pdata->lock, flags);
>   
> -err_report:
>   	return 1;
>   }
>   
>
>

