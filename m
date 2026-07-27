Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D40364926;
	Mon, 27 Jul 2026 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165531; cv=none; b=FUSy2EIqmLoy73NjXftNlDJ2nZ2lXWZQBqk2JdPRjeMTKfAoLa3VTW2Rl+xjLkFsYrRp1R011kDxwxtes9G9tdRRydfBVWcJoNWOiYid2+LEo24GiZPqpfl9GyBuuuxETcODUlHPYTWMeGbjZiB72/wJVJ/FeoPVwiJ38dI6WoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165531; c=relaxed/simple;
	bh=4nhhqHsdWy10c/f298WIUtXl9LQxIboutOsXwgYJL2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqrYZWTo1/GYLEdB1WbMo+6elTqxyqKnD6+q4xVFZyKXVooASN28deSnXkAwzXraNsxtfQo5IMC8ApOyt9Q/fq6qAng8kGacov6ds8DMrH88Z7ToR3WXMv29ljl+92bSLvbpVj4lQleqCbJRcwTBJ47eZEtUYxXQD4GcsIa7GyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pg1kZHPG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pg1kZHPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785165529; x=1816701529;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4nhhqHsdWy10c/f298WIUtXl9LQxIboutOsXwgYJL2g=;
  b=Pg1kZHPGK1NtBxxTGra+OIeGgMMeK4xLtGiFjVGJoW5v2nkxe4E5BS+9
   33r/VuW+cg7Xksyac3nQdLUfHMgRIaAo/dOVbFK/CD28ppd+wjAugd4JL
   Gx5/Ph0tOxM5YEuCxKlpO1x0apX8e+PwIZhRPG1WTtkKx7+uPVGgttwsE
   TSgDDGWbb1QXqg4GknaJ2qnA+vGDxkH7T7TutTVH65kbIxSKXoYVxxtx4
   TY0j8yOlfwUgzKyaU8O/TH1deyUmtxfXLn1ySywU422oruGIMYbLuxzkR
   hdkc5k76JL20Ox1R2Q9t6qw7CRJR21D0af69kIkSW2FXDsRdPqVPNdmnD
   w==;
X-CSE-ConnectionGUID: Gjz9U9Y/TgO6PUX6AYsE3A==
X-CSE-MsgGUID: +afM6lNlTb+0FHZfLHQbhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85820790"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85820790"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:18:48 -0700
X-CSE-ConnectionGUID: uaSfdDQlRayjZQISgv5IoQ==
X-CSE-MsgGUID: A3bAv1ZBQtef/qR6qdOQ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="282769243"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:18:48 -0700
Message-ID: <b6e684365758146193421ac3a36b58d55af77691.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: dhs@frame.work, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sven =?ISO-8859-1?Q?Vaink=FCla?=
	 <sven@xn--vainkla-r2a.ee>, linux@frame.work
Date: Mon, 27 Jul 2026 08:18:47 -0700
In-Reply-To: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 01:18 +0800, Daniel Schaefer via B4 Relay wrote:
> From: Daniel Schaefer <dhs@frame.work>
>=20
> Some sensors have multiple channels (not just brightness but color
> ALS
> sensors) with different scaling factors.
>=20
> Tested on Asus ProArt PX13 laptop by Sven.
>=20
> Signed-off-by: Daniel Schaefer <dhs@frame.work>
> Link:
> https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/4=
13
> Cc: Sven Vaink=C3=BCla <sven@xn--vainkla-r2a.ee>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-input@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux@frame.work

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/iio/light/hid-sensor-als.c | 22 ++++++++++++----------
> =C2=A01 file changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/light/hid-sensor-als.c
> b/drivers/iio/light/hid-sensor-als.c
> index 384572844162..232cb58e0a9f 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -33,9 +33,9 @@ struct als_state {
> =C2=A0		u32 illum[CHANNEL_SCAN_INDEX_MAX];
> =C2=A0		aligned_s64 timestamp;
> =C2=A0	} scan;
> -	int scale_pre_decml;
> -	int scale_post_decml;
> -	int scale_precision;
> +	int scale_pre_decml[CHANNEL_SCAN_INDEX_MAX];
> +	int scale_post_decml[CHANNEL_SCAN_INDEX_MAX];
> +	int scale_precision[CHANNEL_SCAN_INDEX_MAX];
> =C2=A0	int value_offset;
> =C2=A0	int num_channels;
> =C2=A0	s64 timestamp;
> @@ -186,9 +186,11 @@ static int als_read_raw(struct iio_dev
> *indio_dev,
> =C2=A0		ret_type =3D IIO_VAL_INT;
> =C2=A0		break;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> -		*val =3D als_state->scale_pre_decml;
> -		*val2 =3D als_state->scale_post_decml;
> -		ret_type =3D als_state->scale_precision;
> +		if (chan->scan_index >=3D CHANNEL_SCAN_INDEX_MAX)
> +			return -EINVAL;
> +		*val =3D als_state->scale_pre_decml[chan->scan_index];
> +		*val2 =3D als_state->scale_post_decml[chan-
> >scan_index];
> +		ret_type =3D als_state->scale_precision[chan-
> >scan_index];
> =C2=A0		break;
> =C2=A0	case IIO_CHAN_INFO_OFFSET:
> =C2=A0		*val =3D als_state->value_offset;
> @@ -338,6 +340,10 @@ static int als_parse_report(struct
> platform_device *pdev,
> =C2=A0		als_adjust_channel_bit_mask(channels, index, st-
> >als[i].size);
> =C2=A0		++index;
> =C2=A0
> +		st->scale_precision[i] =3D
> hid_sensor_format_scale(usage_id,
> +					&st->als[i], &st-
> >scale_pre_decml[i],
> +					&st->scale_post_decml[i]);
> +
> =C2=A0		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
> =C2=A0			st->als[i].report_id);
> =C2=A0	}
> @@ -347,10 +353,6 @@ static int als_parse_report(struct
> platform_device *pdev,
> =C2=A0	if (index)
> =C2=A0		ret =3D 0;
> =C2=A0
> -	st->scale_precision =3D hid_sensor_format_scale(usage_id,
> -				&st-
> >als[CHANNEL_SCAN_INDEX_INTENSITY],
> -				&st->scale_pre_decml, &st-
> >scale_post_decml);
> -
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
>=20
> ---
> base-commit: 194a48576843858afcd9c00ed4f105ec2b398e6c
> change-id: 20260723-chromaticity-88fec417f00c
>=20
> Best regards,
