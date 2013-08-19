From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 4/4] hid-sensor-hub: change kmalloc + memcpy by kmemdup
Date: Mon, 19 Aug 2013 08:32:22 -0700
Message-ID: <52123A86.4030509@linux.intel.com>
References: <1376467631-20857-1-git-send-email-andriy.shevchenko@linux.intel.com> <1376467631-20857-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15041 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab3HSPZN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Aug 2013 11:25:13 -0400
In-Reply-To: <1376467631-20857-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

On 08/14/2013 01:07 AM, Andy Shevchenko wrote:
> The patch substitutes kmemdup for kmalloc followed by memcpy.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/hid/hid-sensor-hub.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 4cb19df..0794e9f 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -430,11 +430,10 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
>   		if (pdata->pending.status && pdata->pending.attr_usage_id ==
>   				report->field[i]->usage->hid) {
>   			hid_dbg(hdev, "data was pending ...\n");
> -			pdata->pending.raw_data = kmalloc(sz, GFP_ATOMIC);
> -			if (pdata->pending.raw_data) {
> -				memcpy(pdata->pending.raw_data, ptr, sz);
> +			pdata->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
> +			if (pdata->pending.raw_data)
>   				pdata->pending.raw_size = sz;
> -			} else
> +			else
>   				pdata->pending.raw_size = 0;
>   			complete(&pdata->pending.ready);
>   		}
Agreed.

Thanks,
Srinivas
