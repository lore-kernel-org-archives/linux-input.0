Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6D4C0408;
	Fri, 15 May 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863718; cv=none; b=HVn9iFbdwX0KrRiSoCNx82/8HaqDQzaHgmbN9HkaU9S3t0e47Q7kB7/xOAoyI9sZSxR1/FJ5OV5mOHIKQ2mNRwqV2tckykqWztsRqRwXsJW0cOd3L5R6Se8AoNw0Gdh9YlO5vRFWlcBuEyRoWfYjjQ9eim4znBYxO5RRCDiE7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863718; c=relaxed/simple;
	bh=0z/7MPC7cDzPuD+TXUN8q2ab9tjd61U+LxsMgtE4YDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=prTB2Sz6UVHMfbQVwhw8OaT55IO1O1GhYgCEwjxRT5FtK7dDoYCPIm157WFP8sLtJOjQhaxmkslHKqqkvlEVrSqOGwOIN4FjEYdO01f+r1zSXHn/Nnz+J2kds4iOybBPbyl6MA3mbTKwwOKZ7LDazE4snApQnF2PGFYTl4UyBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVC+caWY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVC+caWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778863715; x=1810399715;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0z/7MPC7cDzPuD+TXUN8q2ab9tjd61U+LxsMgtE4YDU=;
  b=dVC+caWYtrT2D61VI+Y4QQAclApfsyus2rCgR7UR729wtH5hoCV0QKdW
   H1FmpB9ipJNFf2ZCaqn8XnBqANEcBDBulmswOq7sEiuJJpVvPeNwYXPcx
   ht0uScnmgFaX/NdKW8myPro5uYGlHsKmvClAs3PbczvssmJ0Rlt30a19A
   1TyCEELmnU52h+MlYbiyTC3538kfx1jn85lOU29Zv3RIe/ACHK/HWWUbX
   QXfQev3jxJ/n17Y0vzEY6rpdOu0f5zBSCaN+Q5Lpq/vQ3QSpwoa9TkBMe
   Ivfx53gepxVcZQN6WGyknoUFyb2+981V+oHbactmWJEivKdABEgqTDgBg
   w==;
X-CSE-ConnectionGUID: NebYlhw9RJOBp6oR1GQjRQ==
X-CSE-MsgGUID: Fpl6V2rbQ5ODEuNiBlSsXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="78846428"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="78846428"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 09:48:34 -0700
X-CSE-ConnectionGUID: yAd87xEVTV2VaZKwwbztUg==
X-CSE-MsgGUID: 7NXHeSrxR0SIiOsLR69bdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="269101211"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 09:48:34 -0700
Message-ID: <873e576772dc7b283bb4f01b3c838894cc7a35de.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/6] iio: gyro: HID: hid-sensor-gyro-3d: Refactor
 channel initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: =?ISO-8859-1?Q?Nat=E1lia?= Salvino =?ISO-8859-1?Q?Andr=E9?=
	 <natalia.andre@ime.usp.br>, andy@kernel.org, dlechner@baylibre.com, 
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com
Cc: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Date: Fri, 15 May 2026 09:48:34 -0700
In-Reply-To: <20260512012302.20883-3-natalia.andre@ime.usp.br>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
	 <20260512012302.20883-3-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-05-11 at 22:16 -0300, Nat=C3=A1lia Salvino Andr=C3=A9 wrote:
> Replace the local gyro_3d_adjust_channel_bit_mask() function with a
> compound literal for scan_type initialization to improve code
> readability.
>=20
> Signed-off-by: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>
> Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> ---
> =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c | 24 +++++++++---------------
> =C2=A01 file changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index c340cc899a7c..4cbe4d93a0a1 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -3,6 +3,7 @@
> =C2=A0 * HID Sensors Driver
> =C2=A0 * Copyright (c) 2012, Intel Corporation.
> =C2=A0 */
> +#include <linux/bitops.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/module.h>
> @@ -82,17 +83,6 @@ static const struct iio_chan_spec
> gyro_3d_channels[] =3D {
> =C2=A0	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> =C2=A0};
> =C2=A0
> -/* Adjust channel real bits based on report descriptor */
> -static void gyro_3d_adjust_channel_bit_mask(struct iio_chan_spec
> *channels,
> -						int channel, int
> size)
> -{
> -	channels[channel].scan_type.sign =3D 's';
> -	/* Real storage bits will change based on the report desc.
> */
> -	channels[channel].scan_type.realbits =3D size * 8;
> -	/* Maximum size of a sample to capture is u32 */
> -	channels[channel].scan_type.storagebits =3D sizeof(u32) * 8;
> -}
> -
> =C2=A0/* Channel read_raw handler */
> =C2=A0static int gyro_3d_read_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> @@ -251,16 +241,20 @@ static int gyro_3d_parse_report(struct
> platform_device *pdev,
> =C2=A0	int i;
> =C2=A0
> =C2=A0	for (i =3D 0; i <=3D CHANNEL_SCAN_INDEX_Z; ++i) {
> +		unsigned int ch =3D CHANNEL_SCAN_INDEX_X + i;
> +

When you do code change more than what you described, then you should
add to commit description that you are also doing this at the same
time.

Thanks,
Srinivas

> =C2=A0		ret =3D sensor_hub_input_get_attribute_info(hsdev,
> =C2=A0				HID_INPUT_REPORT,
> =C2=A0				usage_id,
> =C2=A0				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXI
> S + i,
> -				&st->gyro[CHANNEL_SCAN_INDEX_X +
> i]);
> +				&st->gyro[ch]);
> =C2=A0		if (ret < 0)
> =C2=A0			break;
> -		gyro_3d_adjust_channel_bit_mask(channels,
> -				CHANNEL_SCAN_INDEX_X + i,
> -				st->gyro[CHANNEL_SCAN_INDEX_X +
> i].size);
> +		channels[ch].scan_type =3D (struct iio_scan_type) {
> +			.format =3D 's',
> +			.realbits =3D BYTES_TO_BITS(st-
> >gyro[ch].size),
> +			.storagebits =3D BITS_PER_TYPE(u32),
> +		};
> =C2=A0	}
> =C2=A0	dev_dbg(&pdev->dev, "gyro_3d %x:%x, %x:%x, %x:%x\n",
> =C2=A0			st->gyro[0].index,
