Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887A28030E;
	Thu, 11 Jun 2026 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195697; cv=none; b=ieMvF9nxfnwKQa7AfKGyx5Ima0hBnLWU02v3COZRv0sVwwoS9FClPub2eOwtqrV2COfEGPhfVAjD9uHkHDHE40yU+j3UwJKFa/sik49aU7FeggXiEEo8wAi7njZApR1j1D7MA6/QwNaBeUuqCnZw0qy22PNnj4F8TIt63s2KEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195697; c=relaxed/simple;
	bh=I7QJft6+0YZeqvIONRC4BXDg5DK6r91lhWcQEN6m7yo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4UqyKI2uLn2i49aJX6hYJneMIybHT4FbT/x9Op3A2QlZu5JwoTi0oDhTORWxjbYdsh8F4HRf+JazvukCFnTKIbLEL3OT7s1g9m7LAznOJ7IN4u4fRsauMnkAFJMsjQyAGk/ClCG85qvLmxWQGzLE5j1ifk4UeLLe2CccLBFsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT9g5IiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT9g5IiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31EB1F00899;
	Thu, 11 Jun 2026 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195695;
	bh=t65BolN1x/ykWIs7uwEvxQNvG7qXDoERhwm+3eFJZLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bT9g5IiVUaVNX7VlNILMRyJ3VXbN+6OR73xZldfW7CzppHaKIozflrCu9Tlg+9cbZ
	 erSogN6KNcfli+VT9nkUfriJWc6qLRwp1j8xYkIW4BsOpzDgabcNin7YNr8F7LJTMc
	 woU/gVAfxVuE0Pv+9V+0MQTsMHgTJ0knMga2uSAraFFAFzNEu9Z2UvJtMJRocfviYN
	 hHgR5qT88ID44iNnkYFGx1VuIN6bylPyX9SeCWTtflj8SCpu8nShvkBq6U5Ny2onu+
	 S/IPLLElHDbNyDBeTTaVZRzsQOP0lRUlnIMVb+a6c3UAg+8Z2ZMyraC0mSFrU/G6xu
	 coKphzw+5Znog==
Date: Thu, 11 Jun 2026 17:34:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Zhang Lixu <lixu.zhang@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <bentiss@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: hid-sensor-rotation: Fix stale or zero output
 when reading raw values
Message-ID: <20260611173446.14b74365@jic23-huawei>
In-Reply-To: <20260610082911.157232-3-lixu.zhang@intel.com>
References: <20260610082911.157232-1-lixu.zhang@intel.com>
	<20260610082911.157232-3-lixu.zhang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 16:29:10 +0800
Zhang Lixu <lixu.zhang@intel.com> wrote:

> When reading the raw quaternion attribute (in_rot_quaternion_raw), the
> driver currently returns either all zeros (if the sensor was never enabled)
> or stale data (if the sensor was previously enabled) because it reads from
> the internal buffer without explicitly requesting a new sample from the
> sensor.
> 
> To fix this, power up the sensor, call sensor_hub_input_attr_read_values()
> to issue a synchronous GET_REPORT and receive the full quaternion data
> directly into a local buffer, then decode the four components.
> 
> Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Hi Zhang,

Given this is clearly a fix, can you reply to this thread with an appropriate
Fixes tag.  Otherwise looks fine to me.

Given timing and I guess that this bug is fairly old, this will probably only
go upstream after rc1.

Thanks,

Jonathan

> ---
>  drivers/iio/orientation/hid-sensor-rotation.c | 40 ++++++++++++++++++-
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index 4a11e45550991..1c6f02374f3ce 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -86,6 +86,13 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
>  				long mask)
>  {
>  	struct dev_rot_state *rot_state = iio_priv(indio_dev);
> +	struct hid_sensor_hub_device *hsdev = rot_state->common_attributes.hsdev;
> +	struct hid_sensor_hub_attribute_info *info = &rot_state->quaternion;
> +	u32 usage_id = HID_USAGE_SENSOR_ORIENT_QUATERNION;
> +	union {
> +		s16 val16[4];
> +		s32 val32[4];
> +	} raw_buf;
>  	int ret_type;
>  	int i;
>  
> @@ -95,8 +102,37 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (size >= 4) {
> -			for (i = 0; i < 4; ++i)
> -				vals[i] = rot_state->scan.sampled_vals[i];
> +			if (info->size <= 0 || info->size > sizeof(raw_buf))
> +				return -EINVAL;
> +
> +			hid_sensor_power_state(&rot_state->common_attributes, true);
> +
> +			ret_type = sensor_hub_input_attr_read_values(hsdev,
> +								     hsdev->usage,
> +								     usage_id,
> +								     info->report_id,
> +								     SENSOR_HUB_SYNC,
> +								     info->size,
> +								     (u8 *)&raw_buf);
> +
> +			hid_sensor_power_state(&rot_state->common_attributes, false);
> +
> +			if (ret_type < 0)
> +				return ret_type;
> +
> +			switch (info->size) {
> +			case sizeof(raw_buf.val16):
> +				for (i = 0; i < ARRAY_SIZE(raw_buf.val16); i++)
> +					vals[i] = raw_buf.val16[i];
> +				break;
> +			case sizeof(raw_buf.val32):
> +				for (i = 0; i < ARRAY_SIZE(raw_buf.val32); i++)
> +					vals[i] = raw_buf.val32[i];
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
>  			ret_type = IIO_VAL_INT_MULTIPLE;
>  			*val_len =  4;
>  		} else

