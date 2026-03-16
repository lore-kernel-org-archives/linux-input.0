Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB653E95A1
	for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687826; cv=none; b=myMvl4s1QQbUWjNZE4Rnu1aZhDsVIrsFeT84RGib0hfE8HjulZY/yOSBRVcSJ4qg7yQ04KiNMFXNNyPw37pIFOT1ZGTuZqJ9Me5+s8Dj6J8AGywMuq2/HyELWakNQ8v6WQx9/sm1goP6JFsMWXt6oR1IPX23J8aGBiI9jPxn6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687826; c=relaxed/simple;
	bh=L8JZFY3lXdUOZ5qQqSJQH5xO8HLT6fm5i80Jm9kcEgc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGJf5k7Sf8nTTtWgqV0th85WPqoi95ZhbQivhnSbMMgjCERMcfyLhDAzneuSpXpwjgxSr9nDQjB2ORClFwftse85TKEIOM5diTVWPAJkRyv73YGjEurrLmE/Z6veOHHquIt6Djythq8J3rLta4TG8VjbFosSvfmQa6g0amO96Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3Z4O1o+5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Z4O1o+5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b9b190easo3493323f8f.2
        for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773687823; x=1774292623; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8JZFY3lXdUOZ5qQqSJQH5xO8HLT6fm5i80Jm9kcEgc=;
        b=3Z4O1o+5nL7xlAkkiH5C6XbrJoO4j8WsITfBUK3gGyOyC0uSx3JWlevqPtb5rWXzAO
         OVITIulO7qxGFnP4kmuZLjBAtH8YAxT2wDpuNZsQWyZ/ZE4gzn7/ed1Mi2WAovgE0IOt
         VQjlrwJgDzxdqvbIjS0Io01YXnYj3oFBx2nDzkCeIylzrCS1jQs+b5wrcYymKAp9J5y3
         gvcRaooVE6C/gHNPnGvqVq5NeZQ2brv0VWx7dXIFQordqKpD0m2XWQik7jeGTaLpAefd
         hMap/910lfLRcIuZq9roWuofeBO1eqKueQI1nuHSfystwLFn79Dw64/SNQQOfGL8rkLZ
         QnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773687823; x=1774292623;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8JZFY3lXdUOZ5qQqSJQH5xO8HLT6fm5i80Jm9kcEgc=;
        b=LcO4g2DLUPqO1CtUHspJm3MIcM8kNuc5gRyRVZvC4OMCJ/Q4xfMZ46R8wfPdBLNhX3
         aAe+0uqWXforT+swj3XFoeVQtp10AWNPJ+mqLeqA2zZ4e9W3EHzOOnfBuJFIs4J2VbmU
         EyZEYBnIdLFvdKJfnWOynIJLHkxFJoi+oYhRT5KWUfv7mHcKSPz3FrA3pSNTJ57rgrqw
         QEeQTzJjavlx/qXIQ1KCnjGCVRuZJK2vB8SCnCW5allg0ZKvh9dl4y1WVMxYSL/ycasw
         TTKIAKCIbMya1/MohH+QuP8cER1biBleYOJn6TMxa2knM+8mGQRdr3C+5cxoCMcv+oRL
         0Ykw==
X-Forwarded-Encrypted: i=1; AJvYcCVtER6TaSOfGXjO8MTdQuNPsoOCpVM8wKG4OAwGuNHvRz0+FNtTBP9xAhTuiY/IdrzMj9n/yiiO0ISgiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKV9+Smu+gB8180IzpiUQMzMK2Ra/UOBnjMgmjeqCvmf7FUFd
	KQQPq4EW7slND4myrqMslyIKNbYiRzedS+dMTTuqClTFhRyaplc9hoij60H9v1VnsWM=
X-Gm-Gg: ATEYQzxioh1lh1vYivEieydlQuZgJU3zRhRmNkAy38ScGSCSVd8DUaue57CYLOrXUri
	VduuloDvUc1jVXUxEDnsKjQlox46sxw9cDkj2zpjhsZZ3W7Uwjli5oVotxhjGV41gLnH2dsXw9e
	mIhfV+MDfLiEsGWN1Gm0Zx5SXaaqojZa09p0RfM8fpDScG4MxiPFfeMA1P4ONxckqyHmTjkG7th
	8bJO3J5VByM2ITaprt5JLo+QR3GG99FG31bvxNFPMTPeuuohXbLFF640fd84L9oPqL5gmyU2dvr
	fz3H3VdZ4cyzEusoP1ryiGqRhb5UAQvukd1bvM6e5uyYVigsLrhRS1/RTry+LNmhz+4Cp0UErmX
	Wqu3e3snX3U44w5B6E5wtxS404ZpXiwx0CwGyNh3gx8cQbsLLpSyKIimWRUgvbxYSqHNYgOHcUV
	/ByqwTTnY=
X-Received: by 2002:a05:6000:4310:b0:43b:492c:8349 with SMTP id ffacd0b85a97d-43b492c8602mr2940929f8f.3.1773687822919;
        Mon, 16 Mar 2026 12:03:42 -0700 (PDT)
Received: from [10.128.148.30] ([151.37.210.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b4389321csm11688656f8f.29.2026.03.16.12.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:03:42 -0700 (PDT)
Message-ID: <0b9ac137f52c2c279e07b2d1d8f7379ca9631cef.camel@baylibre.com>
Subject: Re: [PATCH v2 1/2] iio: add IIO_DECLARE_QUATERNION() macro
From: Francesco Lavra <flavra@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>
Date: Mon, 16 Mar 2026 20:03:40 +0100
In-Reply-To: <7f000ea5-1a41-4da8-aad5-04aa875fa4bc@baylibre.com>
References: 
	<20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
	 <20260228-iio-fix-repeat-alignment-v2-1-d58bfaa2920d@baylibre.com>
	 <7f000ea5-1a41-4da8-aad5-04aa875fa4bc@baylibre.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-07 at 18:35 -0600, David Lechner wrote:
> On 2/28/26 2:02 PM, David Lechner wrote:
> > Add a new IIO_DECLARE_QUATERNION() macro that is used to declare the
> > field in an IIO buffer struct that contains a quaternion vector.
> >=20
> > Quaternions are currently the only IIO data type that uses the .repeat
> > feature of struct iio_scan_type. This has an implicit rule that the
> > element in the buffer must be aligned to the entire size of the
> > repeated
> > element. This macro will make that requirement explicit. Since this is
> > the only user, we just call the macro IIO_DECLARE_QUATERNION() instead
> > of something more generic.

...


> Hi Francesco,
>=20
> I should have cc'ed you on this one. We'll want to add another macro
> like this for IIO_DECLARE_QUATERNION_AXIS(), I imagine. (This has been
> applied to the fixes-togreg branch since it is a dependency to a fix.)
>=20
> What to do on that for the alignment though is an open question since
> we've never had a repeat of 3 before. The question is if it is OK to
> have an alignment that isn't a power of two bytes. For your case, since
> the data is 3 x 16-bit, it would be 3 * 2 =3D 6 bytes.

Hi David. Differently from the hid-sensor driver (where the `scan` field in
struct dev_rot_state is used exclusively for quaternion data), the lsm6dsx
driver uses a data structure (see the `iio_buff` variable in
st_lsm6dsx_buffer.c:st_lsm6dsx_read_tagged_fifo()) that is shared between
all the different data types that can be read from the hardware FIFO
(accel, gyro, quaternion, external sensor data), so changing this structure
to a quaternion-specific type is not ideal. So I think for the time being
there wouldn't be any users of an IIO_DECLARE_QUATERNION_AXIS() macro.

As for the alignment, according to your patch at [1], when the repeat
number is not a power of two, it is (will be) rounded up to the next power
of two (and this is consistent with what the lsm6dsx driver expects), so
the alignment will be 8 bytes.

[1]
https://lore.kernel.org/linux-iio/20260307-iio-fix-timestamp-alignment-v2-4=
-d1d48fbadbbf@baylibre.com/
