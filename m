Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD836C5A1
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453755; cv=none; b=dQ3i2L2qkwDpld0M15fYMUv0ityIo+En2mvvfjQGAMRHyiX37TFD/1cWR20YOhliuLqBbS0WtePBmNRl2OaErQV9+9q4WCsUbDW4zfsKwH8Loa9RfhdOQoCXmXOlXfgmA88w+vxILw8/ab9eXpmD9F6G02I6ctew+cT3jbL+7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453755; c=relaxed/simple;
	bh=6Fhe2loWrIEmoXs5kBtTJdzL1QFWpL/Eq1O8w+6ehok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PqcYHYllT2Du4hkPER4xmdze93uO75L5lgzLgw2xd5l9P95FI7lsKakkIec+ZMLcoY/Sr+JV5aqZH1O0CtWVsfOXOpD1iFj7sH6EwCnbG5ZIHQIBRN9Dq5H3vTvGxTR2eEePtsFzAaGKoRFhloc35u4nraDHGZgtYJ2U7VUthTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lolV8MB6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lolV8MB6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4837584120eso31241625e9.1
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 04:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772453752; x=1773058552; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ssVibSJO8x89C7SvZLCAJmgVodBQ0VDY8wgstkRUCZs=;
        b=lolV8MB6yuY8zHFg2Wi+FmkT96xFuzCVzNXZLLp3bG4neVTwbYvXheOKU+2eoqiR/k
         x9sOyZgSRTBEEBzNxITJVrUjHupXnQgkcmX6i1zTK72zBdAMk3QkqLfacrHl8RRyPHFC
         YTbvmKqqywcKsvEXKElvZHYkxpHXRhePUKPzXVrYuFySu1EOvZILghicLwLCfPHEFIe9
         dc8l+jh4ts1Fv/0VF5RCnVllvYkhyluH9TWq5ZkWsVkHZEWSx04BFA3DwaJiHRQnm6kR
         8vVrDm8AC97RwMUm7iTaIEd1axGt8tZsGh9y06y2hNDAFKX4zcWxMEEJ/sVy8wW7oxqF
         vtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772453752; x=1773058552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssVibSJO8x89C7SvZLCAJmgVodBQ0VDY8wgstkRUCZs=;
        b=ZbaI6IorZsTIhm98WXdRhh1T+cNwGHTVSFrironR6imKZBkGJrbQe3PTnjjIotiBMK
         WurZBEIPfOx/Dz+nuI6pNzko5l7wui3PROVpoOhxnEekJLRyOCYsQLtI9teoIpvIfU2B
         8BjzIh4XZSOZqh5cfkLtjuil/lQA7167sHOE02R6T+SMxu1JTtpRnVteoHQrrtEGaJo1
         Rn+egdCvFLoxDcvGkH86HGzG4ncdQI1qmmIK6VIsAwNOE8P24MXhdYFq+XKR0Lj0Jpnu
         5vLS3Mp/sVP+QK6Osd4Xg+q+3sHfGR5PbwHnKjmBGoMcS9+nmHf3uqZoUJsOiSD77p4i
         cY8A==
X-Forwarded-Encrypted: i=1; AJvYcCW4R33FbRM1FOZ7za6ps7bfUkeNrGfXB1WSWD00aIOSNkR5/CNfTCpkcm38O6otzcg1OjcM2dz24zGdbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VfLS/C/K9srCEfgMiSm1mFBH5VYpweZMFtycp4zuFZ0VP3EL
	5ytEoLigFAgw6TeLMRphd1j7R+sPFK+D/5RqoU/BIunaDIbVGVhxZK6G
X-Gm-Gg: ATEYQzz4csIvuOjotsI1ycbvtGwLKkvS/qBIpyuReYjYsCvKAHCFLOCxgjVOvY9ckHg
	BD0cHFlfi/GlQd0UbB0GzSyJydCeCHBRAQK/66rz/CqEKARRaA15m6+H7smjmLSu9SXsEi2Tzir
	OGsQ3ypUv2q+4yizwb1DhmCxR0OKHxwkDzmykim6eBKvsjFVq0GqyFnGgx6lA3uK43iCSQDaN11
	498Rj7l/KVNu8v1YcHLqRCzvqIg2s62cCMp9KJPZrKy2+AF7tLLPjEZCQfUnTKB8BvFOrFacCs3
	i/s6bQ/0VRk+I6oMzeRUAW26IT9e0SjymJewcuU4IklFChAbYbI0iUPqn3yGOPPLK8WTamCGDR/
	r8mFGFYL9Xo6u/uPhSuGrBkuO+++l70rCPF0b5ddiQ+WORe6G9xOCwJ+GFpBGpelmiS0F2blewz
	nPldFSaSR3l7OpDo3ikBgr2OlaZT8XrZkUeZ7mWpKZhw==
X-Received: by 2002:a05:600c:46cd:b0:483:5a29:9678 with SMTP id 5b1f17b1804b1-483c9b94247mr227376335e9.2.1772453751762;
        Mon, 02 Mar 2026 04:15:51 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f3124sm408922095e9.1.2026.03.02.04.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:15:51 -0800 (PST)
Message-ID: <091936ced74a1eb051dfda009e27bdb8f32426b2.camel@gmail.com>
Subject: Re: [PATCH 3/4] iio: buffer: cache largest scan element size
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Cameron	 <jic23@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars
 =?ISO-8859-1?Q?M=F6llendorf?=	 <lars.moellendorf@plating.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lixu Zhang	
 <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 02 Mar 2026 12:16:35 +0000
In-Reply-To: <20260301-iio-fix-timestamp-alignment-v1-3-1a54980bfb90@baylibre.com>
References: 
	<20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
	 <20260301-iio-fix-timestamp-alignment-v1-3-1a54980bfb90@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-03-01 at 14:24 -0600, David Lechner wrote:
> Cache the largest scan element size of elements enabled in a scan
> buffer. This will be used later to ensure proper alignment of the
> timestamp element in the scan buffer.
>=20
> The new field could not be placed in struct iio_dev_opaque because we
> will need to access it in a static inline function later, so we make it
> __private instead. It is only intended to be used by core IIO code.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/iio/industrialio-buffer.c | 14 +++++++++++---
> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A02 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index 71dfc81cb9e5..83e9392f949f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -765,7 +765,8 @@ static int iio_storage_bytes_for_timestamp(struct iio=
_dev *indio_dev)
> =C2=A0
> =C2=A0static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
> =C2=A0				=C2=A0 const unsigned long *mask, bool timestamp,
> -				=C2=A0 unsigned int *scan_bytes)
> +				=C2=A0 unsigned int *scan_bytes,
> +				=C2=A0 unsigned int *largest_element_size)
> =C2=A0{
> =C2=A0	unsigned int bytes =3D 0;
> =C2=A0	int length, i, largest =3D 0;
> @@ -793,6 +794,9 @@ static int iio_compute_scan_bytes(struct iio_dev *ind=
io_dev,
> =C2=A0
> =C2=A0	*scan_bytes =3D ALIGN(bytes, largest);
> =C2=A0
> +	if (largest_element_size)
> +		*largest_element_size =3D largest;

I might be missing something but it seems we now have two paths:

1. Go with 32 bytes
2. Go with 24 bytes (natural alignment)

ABI was not clear so I'm not sure if we do want to enforce/treat repeated v=
alues as one single
element? If so, nothing to change. But if not, we could re-think the approa=
ch and save some bytes.=C2=A0
Marginal savings though so If having the smaller buffer is not straight eno=
ugh I would be ok with
the simplicity tradeoff.

- Nuno S=C3=A1

> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -848,7 +852,7 @@ static int iio_buffer_update_bytes_per_datum(struct i=
io_dev *indio_dev,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	ret =3D iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 buffer->scan_timestamp, &bytes);
> +				=C2=A0=C2=A0=C2=A0=C2=A0 buffer->scan_timestamp, &bytes, NULL);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -892,6 +896,7 @@ struct iio_device_config {
> =C2=A0	unsigned int watermark;
> =C2=A0	const unsigned long *scan_mask;
> =C2=A0	unsigned int scan_bytes;
> +	unsigned int largest_scan_element_size;
> =C2=A0	bool scan_timestamp;
> =C2=A0};
> =C2=A0
> @@ -997,7 +1002,8 @@ static int iio_verify_update(struct iio_dev *indio_d=
ev,
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D iio_compute_scan_bytes(indio_dev, scan_mask, scan_timestam=
p,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 &config->scan_bytes);
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &config->scan_bytes,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &config->largest_scan_element_size);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -1155,6 +1161,8 @@ static int iio_enable_buffers(struct iio_dev *indio=
_dev,
> =C2=A0	indio_dev->active_scan_mask =3D config->scan_mask;
> =C2=A0	ACCESS_PRIVATE(indio_dev, scan_timestamp) =3D config->scan_timesta=
mp;
> =C2=A0	indio_dev->scan_bytes =3D config->scan_bytes;
> +	ACCESS_PRIVATE(indio_dev, largest_scan_element_size) =3D
> +		config->largest_scan_element_size;
> =C2=A0	iio_dev_opaque->currentmode =3D config->mode;
> =C2=A0
> =C2=A0	iio_update_demux(indio_dev);
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a9ecff191bd9..85bcb5f8ae15 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -584,6 +584,8 @@ struct iio_buffer_setup_ops {
> =C2=A0 *			and owner
> =C2=A0 * @buffer:		[DRIVER] any buffer present
> =C2=A0 * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer de=
mux
> + * @largest_scan_element_size: [INTERN] cache of the largest scan elemen=
t size
> + *			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 among the channels selected in=
 the scan mask
> =C2=A0 * @available_scan_masks: [DRIVER] optional array of allowed bitmas=
ks. Sort the
> =C2=A0 *			=C2=A0=C2=A0 array in order of preference, the most preferred
> =C2=A0 *			=C2=A0=C2=A0 masks first.
> @@ -610,6 +612,7 @@ struct iio_dev {
> =C2=A0
> =C2=A0	struct iio_buffer		*buffer;
> =C2=A0	int				scan_bytes;
> +	unsigned int			__private largest_scan_element_size;
> =C2=A0
> =C2=A0	const unsigned long		*available_scan_masks;
> =C2=A0	unsigned int			__private masklength;
