Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6736B905;
	Mon, 27 Jul 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186836; cv=none; b=HbucMeORQvlfFRDZbHKIzC1XZWMmYdhbERwX/WXWHntYCobpvVRtR/a/AZe2aPbWxKsQbtaZEHzkH/nX4wMcD56UPVQ6mVlcUWeEl2XE1AQMiWEt0gy4CprVPwgRA1PwFX1Qw/XmrYeYv6VtHj6p0vTQrdvmDTCocf0sxE13Ofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186836; c=relaxed/simple;
	bh=6OuHhWkr5k5h73x3L6NngBFNSF4CMb8qsuVefnRkODc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxEbNL/nV4y2qdyNhPTy3uQcJvi6ogKb4qy8NBa9QGKlYgY3SOzBsy0nQU1LA7UiJUZhwe2rRQVCLA+493TzonMifj6g2CP8qTI/IB57vlG86OkPeOJCZuyPmiVixEaPKOOIKNqprgMDQ23RvxWH4+IWe5dzYiRQMX2IGvqSFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owTX40ur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owTX40ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6AE1F000E9;
	Mon, 27 Jul 2026 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186833;
	bh=31eF4FIh5kuxF/IJfqgmBo72pJnFnFPz7WY5RTWXcR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=owTX40urXVVnl0C1DkxoDi1zLMnKr36uPT5vh11dGcVGscQg0jybGu2VYZff3+nzx
	 HVtC2GX4GyUXAF865lQK19pHqSlSaN1CU7di6eZe5ziAexZ+nGidvFBcI2RiDjGEJi
	 quIb3g7W4IzpEpEgXI+4e8IubiS7UOZjMsYJhP69UjXnFV1NFisGLoKSJNCHz36mhd
	 uoWGvGSt9sH5FvqpsIA6qwe6shhqyNBn5yi5m+ecWXeoxCEpF7okJ++j9jR8h+LZwx
	 FVE9F8SNCTKAMM0ys/eF71m+0yicwMVFR83tgrMkmV4SxNsSdU/+q3i1i18j8hiIEL
	 DBVOQyWulufcw==
Date: Mon, 27 Jul 2026 22:13:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: dhs@frame.work, Jiri Kosina <jikos@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=  <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sven
 =?UTF-8?B?VmFpbmvDvGxh?=  <sven@xn--vainkla-r2a.ee>, linux@frame.work
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
Message-ID: <20260727221338.29f1da9b@jic23-huawei>
In-Reply-To: <b6e684365758146193421ac3a36b58d55af77691.camel@linux.intel.com>
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
	<b6e684365758146193421ac3a36b58d55af77691.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jul 2026 08:18:47 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Thu, 2026-07-23 at 01:18 +0800, Daniel Schaefer via B4 Relay wrote:
> > From: Daniel Schaefer <dhs@frame.work>
> >=20
> > Some sensors have multiple channels (not just brightness but color
> > ALS
> > sensors) with different scaling factors.
> >=20
> > Tested on Asus ProArt PX13 laptop by Sven.
> >=20
> > Signed-off-by: Daniel Schaefer <dhs@frame.work>
> > Link:
> > https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests=
/413
> > Cc: Sven Vaink=C3=BCla <sven@xn--vainkla-r2a.ee>
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: linux-input@vger.kernel.org
> > Cc: linux-iio@vger.kernel.org
> > Cc: linux@frame.work =20
>=20
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Added.  Thanks Srinivas!
J
>=20
> > ---
> > =C2=A0drivers/iio/light/hid-sensor-als.c | 22 ++++++++++++----------
> > =C2=A01 file changed, 12 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/iio/light/hid-sensor-als.c
> > b/drivers/iio/light/hid-sensor-als.c
> > index 384572844162..232cb58e0a9f 100644
> > --- a/drivers/iio/light/hid-sensor-als.c
> > +++ b/drivers/iio/light/hid-sensor-als.c
> > @@ -33,9 +33,9 @@ struct als_state {
> > =C2=A0		u32 illum[CHANNEL_SCAN_INDEX_MAX];
> > =C2=A0		aligned_s64 timestamp;
> > =C2=A0	} scan;
> > -	int scale_pre_decml;
> > -	int scale_post_decml;
> > -	int scale_precision;
> > +	int scale_pre_decml[CHANNEL_SCAN_INDEX_MAX];
> > +	int scale_post_decml[CHANNEL_SCAN_INDEX_MAX];
> > +	int scale_precision[CHANNEL_SCAN_INDEX_MAX];
> > =C2=A0	int value_offset;
> > =C2=A0	int num_channels;
> > =C2=A0	s64 timestamp;
> > @@ -186,9 +186,11 @@ static int als_read_raw(struct iio_dev
> > *indio_dev,
> > =C2=A0		ret_type =3D IIO_VAL_INT;
> > =C2=A0		break;
> > =C2=A0	case IIO_CHAN_INFO_SCALE:
> > -		*val =3D als_state->scale_pre_decml;
> > -		*val2 =3D als_state->scale_post_decml;
> > -		ret_type =3D als_state->scale_precision;
> > +		if (chan->scan_index >=3D CHANNEL_SCAN_INDEX_MAX)
> > +			return -EINVAL;
> > +		*val =3D als_state->scale_pre_decml[chan->scan_index];
> > +		*val2 =3D als_state->scale_post_decml[chan- =20
> > >scan_index]; =20
> > +		ret_type =3D als_state->scale_precision[chan- =20
> > >scan_index]; =20
> > =C2=A0		break;
> > =C2=A0	case IIO_CHAN_INFO_OFFSET:
> > =C2=A0		*val =3D als_state->value_offset;
> > @@ -338,6 +340,10 @@ static int als_parse_report(struct
> > platform_device *pdev,
> > =C2=A0		als_adjust_channel_bit_mask(channels, index, st- =20
> > >als[i].size); =20
> > =C2=A0		++index;
> > =C2=A0
> > +		st->scale_precision[i] =3D
> > hid_sensor_format_scale(usage_id,
> > +					&st->als[i], &st- =20
> > >scale_pre_decml[i], =20
> > +					&st->scale_post_decml[i]);
> > +
> > =C2=A0		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
> > =C2=A0			st->als[i].report_id);
> > =C2=A0	}
> > @@ -347,10 +353,6 @@ static int als_parse_report(struct
> > platform_device *pdev,
> > =C2=A0	if (index)
> > =C2=A0		ret =3D 0;
> > =C2=A0
> > -	st->scale_precision =3D hid_sensor_format_scale(usage_id,
> > -				&st- =20
> > >als[CHANNEL_SCAN_INDEX_INTENSITY], =20
> > -				&st->scale_pre_decml, &st- =20
> > >scale_post_decml); =20
> > -
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> >=20
> > ---
> > base-commit: 194a48576843858afcd9c00ed4f105ec2b398e6c
> > change-id: 20260723-chromaticity-88fec417f00c
> >=20
> > Best regards, =20
>=20

