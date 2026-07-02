Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2193348C63;
	Thu,  2 Jul 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012821; cv=none; b=KsYAgUUTJSdxSShndo33BTvdx06Ca/AOY6OHY9uEF2IX6735DdwxTOsgw50SaRKFNNLcAqW89dVlO9jjx9B9ocN5DSvFjL4Ggexib+4v2ggtq/Cckkk12WV8lgRUse2cKaJuRdvQEEveD/WoHe04UFJEbARhbuKq4NfR6kZTAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012821; c=relaxed/simple;
	bh=xx1/nM+9Lm8tCi/uQ7ssG/S534M4Jhj5kdnkDdq60Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgxFsJR7hCcajSbkMZ+4PNTDyUufVY6ROk4iKoxYJ2je8tOjYFs/dbJRQVDoEN+cMUaynv69pNjoeNmRgvw1Tk0oGH97iu4pWDNXB53cmLKdZM8BJiofLssKPkX9ZW4B3REapHqp1Zn8yqZocH4HGZ5TK8RrIlhgjCTC+EdUMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaDWiBq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaDWiBq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646111F000E9;
	Thu,  2 Jul 2026 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783012819;
	bh=E4XYDA3NXtv0vhEuE0eH8DsYb9JoOzL8A1s/kUAMu84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aaDWiBq4qq6pL9/KIUEkQHdNQAaoeLMofia4BSs2A2PM+PWMhIoE6IGrP7q4qDdpy
	 8M6KCayFG4IQ77gKJoiQnMCjYm7GBIf9SmhbisgWRMWOBie3wAuGcuDTlHec4oHBw1
	 yR3xRj7YT2kN9rXP9dOtCXERDNHvv46auc+fg5KpdL38z4KNxdOjka8MqegecPV118
	 7BPkVWsySuhUwqJPnyYecssvgoxyBb3xlUfvCrfTIfFRB640wysdE5iO5epxu2+wYM
	 KCq0CvKuIMMmiQvJ+5BG62k00rk6fX+Sr/uLfMaSRlpd+bxsZ9boG8G1uX7IVphUq/
	 J0DtgHYJWewdw==
Date: Thu, 2 Jul 2026 18:20:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: hid-sensors: align function parenthesis for
 readability
Message-ID: <20260702182015.303db93c@jic23-huawei>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-2-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
	<20260702-15-jun-hid-iio-alignment-v2-2-b87f01f5efbc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Jul 2026 21:47:59 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Adjust alignment of parentheses across HID sensor IIO drivers to
> improve readability and maintain consistency with kernel coding style.
> 
> While updating the formatting, group related arguments consistently in
> multi-line function signatures where appropriate.
> 
> No functional change intended.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Hi Sanjay,

Whilst I appreciate this code isn't quite in line with standards
and usually like that stuff to be fixed up, in this particular case
this is a massive amount of churn.  That churn will make backporting
fixes etc messier, so I'd like input on whether others consider this
one worthwhile.  Jiri, Srinivas, Andy etc. What do you think?

A few comments on inconsistencies inline.

Jonathan

> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c            | 46 ++++++-----
>  .../iio/common/hid-sensors/hid-sensor-attributes.c | 88 +++++++++++-----------
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |  2 +-
>  .../iio/common/hid-sensors/hid-sensor-trigger.h    |  2 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              | 54 ++++++-------
>  drivers/iio/humidity/hid-sensor-humidity.c         | 47 ++++++------
>  drivers/iio/light/hid-sensor-als.c                 | 32 ++++----
>  drivers/iio/light/hid-sensor-prox.c                | 29 +++----
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 74 +++++++++---------
>  drivers/iio/orientation/hid-sensor-incl-3d.c       | 31 ++++----
>  drivers/iio/orientation/hid-sensor-rotation.c      | 24 +++---
>  .../iio/position/hid-sensor-custom-intel-hinge.c   | 13 ++--
>  drivers/iio/pressure/hid-sensor-press.c            | 35 ++++-----
>  drivers/iio/temperature/hid-sensor-temperature.c   | 38 +++++-----
>  14 files changed, 241 insertions(+), 274 deletions(-)


> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 2f0a1ea42f48..13fa55e966f4 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
...

>  }
>  
>  int hid_sensor_format_scale(u32 usage_id,
> -			struct hid_sensor_hub_attribute_info *attr_info,
> -			int *val0, int *val1)
> +			    struct hid_sensor_hub_attribute_info *attr_info,
> +			    int *val0, int *val1)
>  {
>  	int i;
>  	int exp;
> @@ -414,9 +413,8 @@ int hid_sensor_format_scale(u32 usage_id,
>  
>  	for (i = 0; i < ARRAY_SIZE(unit_conversion); ++i) {
>  		if (unit_conversion[i].usage_id == usage_id &&
> -			unit_conversion[i].unit == attr_info->units) {
> -			exp  = hid_sensor_convert_exponent(
> -						attr_info->unit_expo);
> +		    unit_conversion[i].unit == attr_info->units) {
> +			exp  = hid_sensor_convert_exponent(attr_info->unit_expo);
>  			adjust_exponent_nano(val0, val1,
>  					unit_conversion[i].scale_val0,
>  					unit_conversion[i].scale_val1, exp);
Why did this one get left alone?

> @@ -511,14 +510,14 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  	hid_sensor_get_reporting_interval(hsdev, usage_id, st);
>  
>  	sensor_hub_input_get_attribute_info(hsdev,
> -					HID_FEATURE_REPORT, usage_id,
> -					HID_USAGE_SENSOR_PROP_REPORT_STATE,
> -					&st->report_state);
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_PROP_REPORT_STATE,
> +			&st->report_state);
>  
>  	sensor_hub_input_get_attribute_info(hsdev,
> -					HID_FEATURE_REPORT, usage_id,
> -					HID_USAGE_SENSOR_PROY_POWER_STATE,
> -					&st->power_state);
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_PROY_POWER_STATE,
> +			&st->power_state);

See below.

> @@ -526,7 +525,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  	sensor_hub_input_get_attribute_info(hsdev,
>  			HID_FEATURE_REPORT, usage_id,
>  			HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS,
> -			 &st->sensitivity);
> +			&st->sensitivity);

Some cases like this one are locally inconsistent so we'd want to fix those
even if leaving the majority alone.

> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index bbca2111e79b..0dba475845d7 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c

> @@ -240,11 +235,12 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
>  	int ret;
>  
>  	for (unsigned int ch = CHANNEL_SCAN_INDEX_X; ch <= CHANNEL_SCAN_INDEX_Z; ch++) {
> -		ret = sensor_hub_input_get_attribute_info(hsdev,
> -				HID_INPUT_REPORT,
> -				usage_id,
> -				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + ch,
> -				&st->gyro[ch]);
> +		ret = sensor_hub_input_get_attribute_info(
> +			hsdev,
> +			HID_INPUT_REPORT,
> +			usage_id,
> +			HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + ch,
> +			&st->gyro[ch]);

See below.

> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index 23884825eb00..ad10fa20fae0 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
...
> @@ -353,11 +348,12 @@ static int magn_3d_parse_report(struct platform_device *pdev,
>  		u32 address = magn_3d_addresses[i];
>  
>  		/* Check if usage attribute exists in the sensor hub device */
> -		status = sensor_hub_input_get_attribute_info(hsdev,
> -			HID_INPUT_REPORT,
> -			usage_id,
> -			address,
> -			&(st->magn[i]));
> +		status = sensor_hub_input_get_attribute_info(
> +				hsdev,
> +				HID_INPUT_REPORT,
> +				usage_id,
> +				address,
> +				&(st->magn[i]));

See below.

> @@ -442,7 +436,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
>  			&st->rot_attr.scale_post_decml);
>  
>  	if (st->rot_attributes.sensitivity.index < 0) {
> -		sensor_hub_input_get_attribute_info(hsdev,
> +		sensor_hub_input_get_attribute_info(
> +			hsdev,
>  			HID_FEATURE_REPORT, usage_id,
>  			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
>  			HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH,
See below.
> @@ -477,11 +472,12 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
>  	magn_state->magn_flux_attributes.hsdev = hsdev;
>  	magn_state->magn_flux_attributes.pdev = pdev;
>  
> -	ret = hid_sensor_parse_common_attributes(hsdev,
> -				HID_USAGE_SENSOR_COMPASS_3D,
> -				&magn_state->magn_flux_attributes,
> -				magn_3d_sensitivity_addresses,
> -				ARRAY_SIZE(magn_3d_sensitivity_addresses));
> +	ret = hid_sensor_parse_common_attributes(
> +		hsdev,
> +		HID_USAGE_SENSOR_COMPASS_3D,
> +		&magn_state->magn_flux_attributes,
> +		magn_3d_sensitivity_addresses,
> +		ARRAY_SIZE(magn_3d_sensitivity_addresses));

See below - the movement of hsdev and the single tab vs two tab
difference was why I pointed out that this patch is inconsistent.
As noted there, I'd be tempted to leave these ones alone, even
if we are cleaning up most of the other indentation.

> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
> index a8d3a15f9c53..18da85e6c60e 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c

...

> @@ -206,10 +206,10 @@ static int hid_temperature_probe(struct platform_device *pdev)
>  	temp_st->common_attributes.pdev = pdev;
>  
>  	ret = hid_sensor_parse_common_attributes(hsdev,
> -					HID_USAGE_SENSOR_TEMPERATURE,
> -					&temp_st->common_attributes,
> -					temperature_sensitivity_addresses,
> -					ARRAY_SIZE(temperature_sensitivity_addresses));
> +			HID_USAGE_SENSOR_TEMPERATURE,
> +			&temp_st->common_attributes,
> +			temperature_sensitivity_addresses,
> +			ARRAY_SIZE(temperature_sensitivity_addresses));

There aren't hard rules on how to format these cases where a break is needed.
That is kind of reflected in inconsistency in this set.  I'd be tempted
to leave these ones alone.

Jonathan

> 

