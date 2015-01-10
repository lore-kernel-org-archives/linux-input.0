From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/4] iio: hid_sensor_hub: update parameters to get feature
 report
Date: Sat, 10 Jan 2015 22:28:06 +0000
Message-ID: <54B1A776.2070507@kernel.org>
References: <1420655508-6736-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420655508-6736-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60051 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbbAJW2I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Jan 2015 17:28:08 -0500
In-Reply-To: <1420655508-6736-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, jkosina@suse.cz
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org

On 07/01/15 18:31, Srinivas Pandruvada wrote:
> The new sensor_hub_get_feature can return multiple values, this
> resulted in the change in API. Update the API usage here.
So the build will break between the previous patch and this one?
Thus making the kernel unbisectable.

Please merge the two patches to avoid that issue.

Same is true of the last two patches in this series.

Jonathan
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 13 +++++++------
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c    |  4 ++--
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 25b01e1..e1435e9 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -153,8 +153,8 @@ s32 hid_sensor_read_poll_value(struct hid_sensor_common *st)
>  	int ret;
>  
>  	ret = sensor_hub_get_feature(st->hsdev,
> -		st->poll.report_id,
> -		st->poll.index, &value);
> +				     st->poll.report_id,
> +				     st->poll.index, sizeof(value), &value);
>  
>  	if (ret < 0 || value < 0) {
>  		return -EINVAL;
> @@ -174,8 +174,8 @@ int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
>  	int ret;
>  
>  	ret = sensor_hub_get_feature(st->hsdev,
> -		st->poll.report_id,
> -		st->poll.index, &value);
> +				     st->poll.report_id,
> +				     st->poll.index, sizeof(value), &value);
>  	if (ret < 0 || value < 0) {
>  		*val1 = *val2 = 0;
>  		return -EINVAL;
> @@ -229,8 +229,9 @@ int hid_sensor_read_raw_hyst_value(struct hid_sensor_common *st,
>  	int ret;
>  
>  	ret = sensor_hub_get_feature(st->hsdev,
> -		st->sensitivity.report_id,
> -		st->sensitivity.index, &value);
> +				     st->sensitivity.report_id,
> +				     st->sensitivity.index, sizeof(value),
> +				     &value);
>  	if (ret < 0 || value < 0) {
>  		*val1 = *val2 = 0;
>  		return -EINVAL;
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 92068cd..ef0c495 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -76,8 +76,8 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  	}
>  
>  	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
> -					st->power_state.index,
> -					&state_val);
> +			       st->power_state.index,
> +			       sizeof(state_val), &state_val);
>  	return 0;
>  }
>  EXPORT_SYMBOL(hid_sensor_power_state);
> 

