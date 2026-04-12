Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95CC35957;
	Sun, 12 Apr 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776004011; cv=none; b=kR1TJV0SON8C6CJ7Ff6C+h8QABTliST8yBvbCmQ1c46/xZLtHuDTh7BTSb9ikYpqLVsC7qCv3rFK+82jOifBsQ85EiDAtJbNI5jr6X2XSzKWRP8oQRFPaQQ8aiBDaV+cBgfhBT3pGmhEOM2nOQjw+e3LHjdC3ABv0QIWVYUa2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776004011; c=relaxed/simple;
	bh=JGmMGZKQy9UicNXbCVnzpYPiJB0Y61OyqAylN34+wa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Meg3w0TngRPmoR+0hhl2Z9MBTVGx1cZt/13eI0H3qrytf4eFXV+ysl7QGfDtuVBYl7uP5nNu1JcLeeMVobB720XbemvxX5A4qzL8aVFMry/QElc96guBMxWaMa7RUXHKL2tLM8ldF/a/UPPhV9IPQfuI53ZlU7GgDX6eNMcxhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORpxvH4o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORpxvH4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A17EC19424;
	Sun, 12 Apr 2026 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776004011;
	bh=JGmMGZKQy9UicNXbCVnzpYPiJB0Y61OyqAylN34+wa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORpxvH4oAeQwzHHn8xEqbEL02JAZP11BS9PKq5xNnJffTCMUM9VJWVrUlNcYRMFgR
	 ImlS/YL40s5sYS+si4Rj8NtxMtht+ybEDCn44GpI/IekYZjgbRVKtbR4VRnHiWQRCg
	 SIftJTiKfG3WIBQYLFOJg55JdVYIjuCDqQOolHpNDO9BP/JnG8/zNy9HNAd1nO2UgH
	 MWWCfOL870Ea+JCSg6WWFuUp9FYVvB9R5AGUcET/PkM9//NnVraEStw/pgq3junaYB
	 p3uDL83fjxEdxHyfEJ8DNsnlLzWQebwS2S8EsdpQlKmQHBaUNFdKM+9umJ61Z+NLBx
	 XVe0HYG4i67Nw==
Date: Sun, 12 Apr 2026 15:26:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: orientation: hid-sensor-rotation: use
 ext_scan_type
Message-ID: <20260412152643.68c8f065@jic23-huawei>
In-Reply-To: <20260301-iio-hid-sensor-rotation-cleanup-v2-1-245c6ad59afc@baylibre.com>
References: <20260301-iio-hid-sensor-rotation-cleanup-v2-1-245c6ad59afc@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 01 Mar 2026 17:46:48 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Make use of ext_scan_type to handle the dynamic realbits size of the
> quaternion data. This lets us implement it using static data rather than
> having to duplicate the channel info for each driver instance.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
I'm going to apply this now, but would welcome any additional feedback
from Srinivas or others.

Note, given this is next cycle material now I'll only push the tree out
as testing until I can rebase on rc1.

Thanks,

Jonathan

> This is something I noticed we could do while looking at an unrelated
> bug. I've tested this using the same script from [1] and confirmed that
> that the scan type didn't change. Before and after are both:
> 
> $ cat in_rot_quaternion_type
> le:s16/32X4>>0  
> 
> [1]: https://lore.kernel.org/linux-iio/20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com/
> ---
> Changes in v2:
> - Dropped DEV_ROT_SCAN_TYPE_8BIT.
> - Tested using /dev/uhid.
> - Link to v1: https://lore.kernel.org/r/20260214-iio-hid-sensor-rotation-cleanup-v1-1-3aec9a533c0f@baylibre.com
> ---
>  drivers/iio/orientation/hid-sensor-rotation.c | 71 ++++++++++++++++-----------
>  1 file changed, 43 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index e759f91a710a..3cfd0b323514 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -34,6 +34,27 @@ static const u32 rotation_sensitivity_addresses[] = {
>  	HID_USAGE_SENSOR_ORIENT_QUATERNION,
>  };
>  
> +enum {
> +	DEV_ROT_SCAN_TYPE_16BIT,
> +	DEV_ROT_SCAN_TYPE_32BIT,
> +};
> +
> +static const struct iio_scan_type dev_rot_scan_types[] = {
> +	[DEV_ROT_SCAN_TYPE_16BIT] = {
> +		.sign = 's',
> +		.realbits = 16,
> +		/* Storage bits has to stay 32 to not break userspace. */
> +		.storagebits = 32,
> +		.repeat = 4,
> +	},
> +	[DEV_ROT_SCAN_TYPE_32BIT] = {
> +		.sign = 's',
> +		.realbits = 32,
> +		.storagebits = 32,
> +		.repeat = 4,
> +	},
> +};
> +
>  /* Channel definitions */
>  static const struct iio_chan_spec dev_rot_channels[] = {
>  	{
> @@ -45,23 +66,14 @@ static const struct iio_chan_spec dev_rot_channels[] = {
>  					BIT(IIO_CHAN_INFO_OFFSET) |
>  					BIT(IIO_CHAN_INFO_SCALE) |
>  					BIT(IIO_CHAN_INFO_HYSTERESIS),
> -		.scan_index = 0
> +		.scan_index = 0,
> +		.has_ext_scan_type = 1,
> +		.ext_scan_type = dev_rot_scan_types,
> +		.num_ext_scan_type = ARRAY_SIZE(dev_rot_scan_types),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(1)
>  };
>  
> -/* Adjust channel real bits based on report descriptor */
> -static void dev_rot_adjust_channel_bit_mask(struct iio_chan_spec *chan,
> -						int size)
> -{
> -	chan->scan_type.sign = 's';
> -	/* Real storage bits will change based on the report desc. */
> -	chan->scan_type.realbits = size * 8;
> -	/* Maximum size of a sample to capture is u32 */
> -	chan->scan_type.storagebits = sizeof(u32) * 8;
> -	chan->scan_type.repeat = 4;
> -}
> -
>  /* Channel read_raw handler */
>  static int dev_rot_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
> @@ -136,9 +148,25 @@ static int dev_rot_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int dev_rot_get_current_scan_type(const struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan)
> +{
> +	struct dev_rot_state *rot_state = iio_priv(indio_dev);
> +
> +	switch (rot_state->quaternion.size / 4) {
> +	case sizeof(s16):
> +		return DEV_ROT_SCAN_TYPE_16BIT;
> +	case sizeof(s32):
> +		return DEV_ROT_SCAN_TYPE_32BIT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct iio_info dev_rot_info = {
>  	.read_raw_multi = &dev_rot_read_raw,
>  	.write_raw = &dev_rot_write_raw,
> +	.get_current_scan_type = &dev_rot_get_current_scan_type,
>  };
>  
>  /* Callback handler to send event after all samples are received and captured */
> @@ -196,7 +224,6 @@ static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
>  /* Parse report which is specific to an usage id*/
>  static int dev_rot_parse_report(struct platform_device *pdev,
>  				struct hid_sensor_hub_device *hsdev,
> -				struct iio_chan_spec *channels,
>  				unsigned usage_id,
>  				struct dev_rot_state *st)
>  {
> @@ -210,9 +237,6 @@ static int dev_rot_parse_report(struct platform_device *pdev,
>  	if (ret)
>  		return ret;
>  
> -	dev_rot_adjust_channel_bit_mask(&channels[0],
> -		st->quaternion.size / 4);
> -
>  	dev_dbg(&pdev->dev, "dev_rot %x:%x\n", st->quaternion.index,
>  		st->quaternion.report_id);
>  
> @@ -271,22 +295,13 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->channels = devm_kmemdup(&pdev->dev, dev_rot_channels,
> -					   sizeof(dev_rot_channels),
> -					   GFP_KERNEL);
> -	if (!indio_dev->channels) {
> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
> -		return -ENOMEM;
> -	}
> -
> -	ret = dev_rot_parse_report(pdev, hsdev,
> -				   (struct iio_chan_spec *)indio_dev->channels,
> -					hsdev->usage, rot_state);
> +	ret = dev_rot_parse_report(pdev, hsdev, hsdev->usage, rot_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		return ret;
>  	}
>  
> +	indio_dev->channels = dev_rot_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(dev_rot_channels);
>  	indio_dev->info = &dev_rot_info;
>  	indio_dev->name = name;
> 
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260214-iio-hid-sensor-rotation-cleanup-84e8410926ef
> 
> Best regards,

