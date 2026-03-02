Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE263630AE
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453000; cv=none; b=OnUijgCKLC/G4FrMTQhEuDUhM18Ju+PZ41B6GQFcio85bbWdxpY1XUAUSIn/00vnp+mTb8/Z7pamZqlpC7quUxYbauYEqXPe0CL1wIS/rfF8YI3lzZHldqKFclAa05Kpzt8F1SIWl1OdslHGShRiV8yDozTIjqCj0fp1hm0jJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453000; c=relaxed/simple;
	bh=a4wt8Vn9RF94EG9Mt5gAsLlW1nubpY1/4xbHb0qPvu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ruwf4QdI6Fi2xdctd3zsxO7Aad+iOWtXwQW9C9NMgVilhPuMZDJGm0gAkdkmTJxgQtYqsbCKC8Kvz7iSOUjj0NiT48PbKLwElOoQfYPFXUw07D5YSrXMau07UyMVtu/okc2p6cySJD5JX1yX1dDwqRPwLfKqyYiWfrl9hiDfTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqccgrex; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqccgrex"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so32504355e9.2
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 04:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772452997; x=1773057797; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SX9nI5MblHYERbWwduXl8HQ63TKdaovR/2/q0+Kg+T0=;
        b=Kqccgrexz4hslJRgxjTh9kvXdww6wKyNmyy+4FDFwMA2vBRf7QYfbWqW995AoJ9kyG
         KZ03ahUhfxQhxs9lvu8gJcypQdap6xo7PDk7Vc6Lvqb5rhjCA9duK4ykSTc0aMnM+sHw
         qGGftCUoaFKvd3xMfKIKoJxK3KPUe6FVL3GfpHVs3Z4qyfOxuDI/Sf823SkNEMlzPJaP
         5znlgN9Jjt/Nco2cbgoTohoqt/YatPKbMbHqTS264lEWXkEIP5fryKTttuHjWzLy4fbQ
         /hEU05IdmWNO5AYrwS9BAqSQLTw2sf61DIGRGUJMSQjfYsW2gCQgmXfNYP+7iwpFZOQf
         Gknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452997; x=1773057797;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX9nI5MblHYERbWwduXl8HQ63TKdaovR/2/q0+Kg+T0=;
        b=Njc2rj/DetyIVPlKLGwzq/OLLkt5+BIKy99qValYbXkQHETEcj1d/2Q8v24ZwfvFU+
         N2+WiCE9eo0LGGTLloRYnFtjaiPvw3lcZZ3h0NEwdMesa146RK90BcgVkV9HsJITy2U4
         g68hrcFl/Le9PKE1T+bK88vw3tzXyPhEmuu5a6s9p+UJxrRHJ5DGv52Btak2CYyAW0pR
         j+Z416lRJ/7SashfZb6182ATzGeTeRF2Bo03grwJ6OrM9rrfSPFB6FEmDxJh5Nmafv27
         tuataqzKNsl8AMiPg71TGpDlwRavt0yswWpK3yo44NF5dXzcu9dHBdosRm2tQZ6qDWCo
         zVvg==
X-Forwarded-Encrypted: i=1; AJvYcCXbuTL0SS9mCtmtv+NJ7BljVmFMiUYQ3G0vgyMLMIPnu/a0RnrytOy2e3By00ONuFoRbDkhXKIw23cNtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRY2mB/lcz4YkzlwyFyk19E/4Cd96AhBrxF1mNFq3Efl9f6UHx
	mGh2Oe6ki1qXsBFJsuA7L8tyzZYuXRjOlPdKazyjBbKmtGUaoHXOP4N7
X-Gm-Gg: ATEYQzy1o7UehcrlkKaljZ7w0cUkxQXkLsZdGD3p2Jc5w8lWHiIIe/zj8H11IVfUwBM
	YSiZpdRSebWo5tTvMitS9yTfQBY8jT7vuRs65p0TW147VvreMsY093HDereX6rBXHvL/sk+c0CD
	ytnysQoP2wOVjssuTsDtQ4hNO8ocPGQphUgeRQ+RMoYCqvUK4lNc26fiNsQhDs71P0KaojA0iB1
	xHgUaoqPb2w9iMcMwR7Woup+O2JKaBRwYYSyBjnbkBRBzaRDSGKNNQmJXfC4iPBfZJpV8Ph/8ef
	HVNApA+dZnq88eBHaKs/Z7+WoYnc4j5RHIzSmWPwkF9hf8Ys0X6ptRv7MrefxjZwRRwcI6DTAEQ
	D8mi3AsZftBQ48GRzTuDChlmQYYEl4LmUse7FPEWYX6tYTknxN7ZRXNKFgjvydbKMjIB2s2Fv1k
	2kh36f+YDh4QfkY2KAeIJ52+WVrhEpccs=
X-Received: by 2002:a05:600c:4e94:b0:483:6fc6:1e20 with SMTP id 5b1f17b1804b1-483c9bc0291mr196168025e9.9.1772452996801;
        Mon, 02 Mar 2026 04:03:16 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm170851635e9.5.2026.03.02.04.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:03:16 -0800 (PST)
Message-ID: <f481f4ae4d9545bbb186e51a1204ca2d65b74a26.camel@gmail.com>
Subject: Re: [PATCH 4/4] iio: buffer: fix timestamp alignment when
 quaternion in scan
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
Date: Mon, 02 Mar 2026 12:04:00 +0000
In-Reply-To: <20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
References: 
	<20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
	 <20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
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
> Fix timestamp alignment when a scan buffer contains an element larger
> than sizeof(int64_t). Currently s32 quaternions are the only such
> element, and the one driver that has this (hid-sensor-rotation) has a
> workaround in place already so this change does not affect it.
>=20
> Previously, we assumed that the timestamp would always be 8-byte aligned
> relative to the end of the scan buffer, but in the case of a scan buffer
> a 16-byte quaternion vector, scan_bytes =3D=3D 32, but the timestamp need=
s
> to be placed at offset 16, not 24.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> To test this, I used hid-sensor-rotation minus the first patch in the
> series so that we can see that the timestamp actually moved to the
> correct location.
>=20
> Before this patch, the timestamp (8 bytes ending with "98 18") is in the
> wrong location.
>=20
> 00000000=C2=A0 6a 18 00 00 ac f3 ff ff=C2=A0 83 2d 00 00 02 d3 ff ff=C2=
=A0 |j........-......|
> 00000010=C2=A0 00 00 00 00 00 00 00 00=C2=A0 5a 17 a0 2a 73 cb 98 18=C2=
=A0 |........Z..*s...|
>=20
> 00000020=C2=A0 ad 17 00 00 6a f4 ff ff=C2=A0 35 2b 00 00 ca d0 ff ff=C2=
=A0 |....j...5+......|
> 00000030=C2=A0 00 00 00 00 00 00 00 00=C2=A0 2a a6 bb 30 73 cb 98 18=C2=
=A0 |........*..0s...|
>=20
> 00000040=C2=A0 92 1e 00 00 50 ec ff ff=C2=A0 ea c1 ff ff 78 f0 ff ff=C2=
=A0 |....P.......x...|
> 00000050=C2=A0 00 00 00 00 00 00 00 00=C2=A0 8f 3b a7 39 77 cb 98 18=C2=
=A0 |.........;.9w...|
>=20
> After this patch, timestamp is now in the correct location.
>=20
> 00000000=C2=A0 55 0f 00 00 dd 1f 00 00=C2=A0 af 0b 00 00 ec 3e 00 00=C2=
=A0 |U............>..|
> 00000010=C2=A0 c7 17 68 42 6d d0 98 18=C2=A0 00 00 00 00 00 00 00 00=C2=
=A0 |..hBm...........|
>=20
> 00000020=C2=A0 57 0e 00 00 c8 1f 00 00=C2=A0 d1 0e 00 00 42 3e 00 00=C2=
=A0 |W...........B>..|
> 00000030=C2=A0 56 a2 87 48 6d d0 98 18=C2=A0 00 00 00 00 00 00 00 00=C2=
=A0 |V..Hm...........|
>=20
> 00000040=C2=A0 a3 e2 ff ff d3 1b 00 00=C2=A0 0b c9 ff ff cc 20 00 00=C2=
=A0 |............. ..|
> 00000050=C2=A0 27 59 4d b3 72 d0 98 18=C2=A0 00 00 00 00 00 00 00 00=C2=
=A0 |'YM.r...........|
>=20
> I also tested this with a different driver not affected by this bug to
> make sure that the timestamp is still in the correct location for all
> other drivers.
> ---
> =C2=A0include/linux/iio/buffer.h | 12 ++++++++++--
> =C2=A01 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index d37f82678f71..ac19b39bdbe4 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -34,8 +34,16 @@ static inline int iio_push_to_buffers_with_timestamp(s=
truct iio_dev *indio_dev,
> =C2=A0	void *data, int64_t timestamp)
> =C2=A0{
> =C2=A0	if (ACCESS_PRIVATE(indio_dev, scan_timestamp)) {
> -		size_t ts_offset =3D indio_dev->scan_bytes / sizeof(int64_t) - 1;
> -		((int64_t *)data)[ts_offset] =3D timestamp;
> +		size_t ts_offset =3D indio_dev->scan_bytes -
> +			ACCESS_PRIVATE(indio_dev, largest_scan_element_size);

Given that we're adding a new private member, maybe we could just directly =
cache the ts_offset
in iio_compute_scan_bytes()? Would make the code a bit easier to follow IMH=
O

- Nuno S=C3=A1
>=20
