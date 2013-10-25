From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: fix report size
Date: Fri, 25 Oct 2013 10:01:41 +0100 (BST)
Message-ID: <alpine.LNX.2.00.1310251001170.30926@pobox.suse.cz>
References: <1382114924-25654-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37479 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab3JYJBr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Oct 2013 05:01:47 -0400
In-Reply-To: <1382114924-25654-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, 18 Oct 2013, Srinivas Pandruvada wrote:

> The number of bytes in a field needs to take account of report_count
> field. Need to multiply report_size and report_count to get total
> number of bytes.

Srinivas,

could you please elaborate a little bit more in the changelog what 
user-visible bug this is fixing? Thanks.

> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/hid-sensor-hub.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 88fc5ae..a184e19 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -326,7 +326,8 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
>  				field->logical == attr_usage_id) {
>  				sensor_hub_fill_attr_info(info, i, report->id,
>  					field->unit, field->unit_exponent,
> -					field->report_size);
> +					field->report_size *
> +							field->report_count);
>  				ret = 0;
>  			} else {
>  				for (j = 0; j < field->maxusage; ++j) {
> @@ -338,7 +339,8 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
>  							i, report->id,
>  							field->unit,
>  							field->unit_exponent,
> -							field->report_size);
> +							field->report_size *
> +							field->report_count);
>  						ret = 0;
>  						break;
>  					}
> @@ -425,9 +427,10 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
>  		hid_dbg(hdev, "%d collection_index:%x hid:%x sz:%x\n",
>  				i, report->field[i]->usage->collection_index,
>  				report->field[i]->usage->hid,
> -				report->field[i]->report_size/8);
> -
> -		sz = report->field[i]->report_size/8;
> +				(report->field[i]->report_size *
> +					report->field[i]->report_count)/8);
> +		sz = (report->field[i]->report_size *
> +					report->field[i]->report_count)/8;
>  		if (pdata->pending.status && pdata->pending.attr_usage_id ==
>  				report->field[i]->usage->hid) {
>  			hid_dbg(hdev, "data was pending ...\n");
> -- 
> 1.8.3.2
> 

-- 
Jiri Kosina
SUSE Labs
