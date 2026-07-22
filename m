Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7040411FBB
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741731; cv=none; b=n1719thWJ0ViRceh6QqdTzB3liX974ZZ0kvs7qdrAP/snuOyoBCEnEMwwJISfpd+SLh/yiP9CfzJt2OuDhXnMrxoSiiMfRBPsNtukbZMu7oFIXRgcnisNt/ntDf2kfdg33yNCiV/gtvBp0vPxvgh+QBAWscueBBJqTyJ4D1OkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741731; c=relaxed/simple;
	bh=b4v14StGYn06HIMvInDqOeDWGwVtfbliKtq+jOdiccU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GJKfW1HdjQEym/n0iD5O3XyvXv8kVucbSTvHzcPeRu/V+HpIddHDMycRtWbe2816/Iux1FOUiS6J1GiUjqfWE6l45wZJ+YQ7SYWxpA3kh7g+lvWoTDF15O5mTmX/+Qc2smRBblKJxMTDjiv2no6cmygPmCRfUTvNq9Hxwe1K+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E52SEV69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E52SEV69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAA31F00ACA;
	Wed, 22 Jul 2026 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741729;
	bh=mnZYif2FRNXUkqZtrBTveOCeVzQmyFlpRxm7Hl1N+As=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E52SEV693CvqFTcQR+12dfh7wdSLei6t/ZQFwnciPghP3lJkEmv1rXffufKXdQTP2
	 qNlrzsKOb9jPccuxCUScpkDg/eg2Sb0nSWbir0WaUFpxhCOWWTU2Kd3pz7BLsW4UR/
	 k/opZn6E5lngGdYe4v+1bVnNcVWaJFsnbB6DbFDK5q7Hv8iIcXQwMSEHNzUwGsjZd+
	 I5eMmGUnJnhXSmYbAZC6Cgg4lIQwWBoLvSgFNRRVOLAQkHgraM8JnojUdrfPDYj9xy
	 +Y0YmY72VcEAmD/BSuHcZboR5DabMbOPIa3l/deN3CwcfpZmYzh7U6kC7draKOdgSc
	 4/5iMkRHVLMsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Schaefer" <dhs@frame.work>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:35:29 +0000
Message-Id: <20260722173529.7BAA31F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch fails to expose the individual scale for the CHROMATIC=
ITY_Y channel because it still uses `info_mask_shared_by_type`.

Pre-existing issues:
- [High] The driver's IIO buffer layout uses a fixed structure, but `availa=
ble_scan_masks` is dynamically populated, causing misaligned buffer reads a=
nd data corruption.
--

--- Patch [1]: [PATCH] iio: hid-sensor: als: scale each channel individuall=
y ---
commit 6d49cfd4cf380845a584116e06dcf23fc8c25ad6
Author: Daniel Schaefer <dhs@frame.work>

iio: hid-sensor: als: scale each channel individually

This commit updates the hid-sensor-als driver to support individual scaling
factors for each channel, instead of using a single global scale. It stores
the scale attributes in arrays indexed by channel.

Link: https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_reques=
ts/413

> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index 384572844162c..232cb58e0a9ff 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -33,9 +33,9 @@ struct als_state {
>  		u32 illum[CHANNEL_SCAN_INDEX_MAX];
>  		aligned_s64 timestamp;
>  	} scan;

[Severity: High]
This is a pre-existing issue, but does this fixed struct buffer layout
cause data corruption?

The driver captures samples in als_capture_sample() into a static sparse
array (als_state->scan.illum) based on fixed channel indices. However,
indio_dev->available_scan_masks is dynamically constructed based on the
attributes present on the sensor.

The IIO core calculates scan_bytes and channel offsets assuming the buffer =
is
tightly packed.

When iio_push_to_buffers_with_ts() is called in als_proc_event(), it writes
the timestamp at the end of the tightly packed length, which overwrites val=
id
channel data in the sparse array.

The IIO demuxer then reads from incorrect offsets, scrambling the data sent=
 to
userspace.

Should the driver pack the samples sequentially instead of using fixed index
offsets?

> -	int scale_pre_decml;
> -	int scale_post_decml;
> -	int scale_precision;
> +	int scale_pre_decml[CHANNEL_SCAN_INDEX_MAX];
> +	int scale_post_decml[CHANNEL_SCAN_INDEX_MAX];
> +	int scale_precision[CHANNEL_SCAN_INDEX_MAX];
>  	int value_offset;
>  	int num_channels;
>  	s64 timestamp;

[ ... ]

> @@ -186,9 +186,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  		ret_type =3D IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val =3D als_state->scale_pre_decml;
> -		*val2 =3D als_state->scale_post_decml;
> -		ret_type =3D als_state->scale_precision;
> +		if (chan->scan_index >=3D CHANNEL_SCAN_INDEX_MAX)
> +			return -EINVAL;
> +		*val =3D als_state->scale_pre_decml[chan->scan_index];
> +		*val2 =3D als_state->scale_post_decml[chan->scan_index];
> +		ret_type =3D als_state->scale_precision[chan->scan_index];
>  		break;

[Severity: Medium]
Since the patch introduces per-channel scaling factors, can userspace actua=
lly
read the scale for the CHROMATICITY_Y channel?

The als_channels array defines both CHANNEL_SCAN_INDEX_CHROMATICITY_X and Y
with .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE).

Because of this, the IIO core will create a single in_chromaticity_scale sy=
sfs
attribute for both.

When read, IIO queries the first registered channel of that type (X), leavi=
ng
the Y scale factor completely inaccessible.

Does the info_mask_shared_by_type for these channels need to be changed to
info_mask_separate so userspace can read the newly added scale for
CHROMATICITY_Y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-chromatici=
ty-v1-1-5ef5746ace2a@frame.work?part=3D1
