Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325BE1A6824;
	Sat, 25 Jul 2026 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785021529; cv=none; b=da33u2LOAl7X0lvlL+3uRCYo5A9vyGY2KP0KKQusvxHduGJOLibB9hYRyXx6LXQr/wjYYkBOGPdJcN1lbaGQKS1yk20ihpexLVddkyKPqID9pqRjhivPeflxt7iSzyh7DedtXVx0zl03ggsrFbLpMkI+W+l1aROCixZ5LOpjOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785021529; c=relaxed/simple;
	bh=iTgsKm/D1XVMYu/yY4/1i3pO7Kl98JX8Ce9h58E2KiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLPZN4WLqujAnuzIt6ii2rQ/lZ+ZHgAY2BWKnERa1cEdvXgaLbm83bYuWXjeRjmwastEkA+YBGzqbcKmY5j6aWqitHMWLreF7jyxZ0K3ZaQHns2gsF89f1NytKAx3le6s2FUVXq5XMbdfdKeu2er0jXqTpOdsNcv9wKOLcmhN2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbecruxV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbecruxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494951F000E9;
	Sat, 25 Jul 2026 23:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785021527;
	bh=ndmWkb+Tj51P26JmNrIdl50atd/yLXra3ibp4vnoPgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bbecruxVBr2JAiXpotfYP/Eq45Aq1Hzy3bU/j88xCMCpmLG6XSBWK8Vtr55QVWlWP
	 p6F0HxCiTjclCeMFFlLgEH6IyyCE1tVFef22xVueuL5fJWgPskCXrG5mJKlZgEsvFf
	 o52LelNY6esgMkZ/uUAWsnfQoARXoJxHYcbgRQwvmWoXSghiGYjJkxMCcigjkG/CcA
	 Ty0naH2PwGkW7XHTizekM8TOXRzZJR1QZ0U5AR4WHG/Qjki2UDVrZ0pw3KnfRnOPnv
	 bBg5T6k2nkHrpkHn2CI3RufAWa3N2W00fx4auu1+ZN9pDr10zpSvQGRDwnpJ79nX2x
	 8gtQLQI7bppxg==
Date: Sun, 26 Jul 2026 00:18:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Schaefer via B4 Relay <devnull+dhs.frame.work@kernel.org>
Cc: dhs@frame.work, Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sven
 =?UTF-8?B?VmFpbmvDvGxh?= <sven@xn--vainkla-r2a.ee>, linux@frame.work
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
Message-ID: <20260726001842.5810e4d1@jic23-huawei>
In-Reply-To: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2026 01:18:58 +0800
Daniel Schaefer via B4 Relay <devnull+dhs.frame.work@kernel.org> wrote:

> From: Daniel Schaefer <dhs@frame.work>
>=20
> Some sensors have multiple channels (not just brightness but color ALS
> sensors) with different scaling factors.
>=20
> Tested on Asus ProArt PX13 laptop by Sven.

The channels in this driver report IIO_CHAN_INFO_SCALE as shared by type.
That doesn't matter unless we get different scales on the two parts
of chromaticity and I'm assuming that isn't eh issue Sven has run into?

Assuming it is illuminance vs color temp (or both chromaticity channels tog=
ether)
then the change here looks fine to me.

I'll queue it up on the testing branch of iio.git but more eyes welcome if
anyone has time to take a look.

A few little tweaks to the commit message.  There was a bit of fuzz as well
whilst applying but all seemed like line changes due to other updates.

Thanks

Jonathan

>=20
> Signed-off-by: Daniel Schaefer <dhs@frame.work>
> Link: https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requ=
ests/413
> Cc: Sven Vaink=C3=BCla <sven@xn--vainkla-r2a.ee>
Given you say Sven tested it, I've upgraded this to a Tested-by
and included a comment after that to say what it was tested on.

> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-input@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux@frame.work
We don't really want to end up with all this list in the git log, so good
practice is to put a --- above them, so they end up in the region that is
cut out.

> ---
>  drivers/iio/light/hid-sensor-als.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index 384572844162..232cb58e0a9f 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -33,9 +33,9 @@ struct als_state {
>  		u32 illum[CHANNEL_SCAN_INDEX_MAX];
>  		aligned_s64 timestamp;
>  	} scan;
> -	int scale_pre_decml;
> -	int scale_post_decml;
> -	int scale_precision;
> +	int scale_pre_decml[CHANNEL_SCAN_INDEX_MAX];
> +	int scale_post_decml[CHANNEL_SCAN_INDEX_MAX];
> +	int scale_precision[CHANNEL_SCAN_INDEX_MAX];
>  	int value_offset;
>  	int num_channels;
>  	s64 timestamp;
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
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val =3D als_state->value_offset;
> @@ -338,6 +340,10 @@ static int als_parse_report(struct platform_device *=
pdev,
>  		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
>  		++index;
> =20
> +		st->scale_precision[i] =3D hid_sensor_format_scale(usage_id,
> +					&st->als[i], &st->scale_pre_decml[i],
> +					&st->scale_post_decml[i]);
> +
>  		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
>  			st->als[i].report_id);
>  	}
> @@ -347,10 +353,6 @@ static int als_parse_report(struct platform_device *=
pdev,
>  	if (index)
>  		ret =3D 0;
> =20
> -	st->scale_precision =3D hid_sensor_format_scale(usage_id,
> -				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
> -				&st->scale_pre_decml, &st->scale_post_decml);
> -
>  	return ret;
>  }
> =20
>=20
> ---
> base-commit: 194a48576843858afcd9c00ed4f105ec2b398e6c
> change-id: 20260723-chromaticity-88fec417f00c
>=20
> Best regards,

