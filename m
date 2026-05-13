Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61F2DC783
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642355; cv=none; b=WpzwYhj1qAlmwFGlEZmWRhzZgBQH70mMev9Z/UCuUK0OK1mpT7KmVuTv1X0KWOxGYZBS/nSbN+T3EA6aVllYDBtuV2Uq7j1ALHtvDenA180GQX51H7mzdE+VjJHfNk7bl8fiyoXgkuYFPn/bzxOduODpCtDS+a40YJJ5/IthB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642355; c=relaxed/simple;
	bh=K9Dahvg4DTgS3w8wqzeJmh+/BF1HjIai4XKrJqTGrGk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SOFa+Lr/d8TttVYvUTbVyk8Cxl57o7qQn9DQug3ehqVhNqnnE/CqDWnZX84aMbe5dLvMmKCVuEuaWgSa9zKeBNHAThdWhZDmNbfgbuMlof6skpUTH83SKfDK4QXyPoE+rcqfGfXfYwEUsVZQF+iJk1GQomaNyfIjef0qgj/yRHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKM4Al2H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKM4Al2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3B4C2BCB0;
	Wed, 13 May 2026 03:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778642354;
	bh=K9Dahvg4DTgS3w8wqzeJmh+/BF1HjIai4XKrJqTGrGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mKM4Al2HwBrAfiQ8fYWhhxETUupNt3e/UaAhQyOTy4bBR8rI/PJYuDmUK/Nf3b32H
	 qSRlKxfdvSydQ6JQ+qLroZWXUohzFehpFZpovY+tWyB8qfXsKlZY7wrIXqLdDOUtUu
	 clsZ2z9X4PhvyOE4aJ1tBtsKTDkqX2vzWOdSZI+hWf/szOjRN0lPj+HaoBAh6iCqxN
	 mmKHzwacX1taSMYtxx31N11vXTA9hkFZQIPn4DHZiG5r0sMHx3pNVcQXJJPeCausY6
	 45oLMQ07BKeL7MNeIuVNUPhOh0xXd+BERyLJIm9xezvtlgDpj/8X2w+TEYvsgG3xHz
	 HBJHEPMaEuUZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] iio: magnetometer: HID: hid-sensor-magn-3d:
 Refactor channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260512012302.20883-6-natalia.andre@ime.usp.br>
References: <20260512012302.20883-6-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:19:14 +0000
Message-Id: <20260513031914.AE3B4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The refactored code uses a non-existent member `.format` in `struct=
 iio_scan_type` instead of `.sign`, leading to a compilation error.
--

commit 579bb9f2450aced0e3f18e7e7316e70845e6e72b
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel initialization

This commit replaces the local magn_3d_adjust_channel_bit_mask() function
with a compound literal for scan_type initialization to improve code
readability.

> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/=
magnetometer/hid-sensor-magn-3d.c
> index c673f9323e476..3b26dc41dd4cf 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c

[ ... ]

> @@ -418,9 +408,11 @@ static int magn_3d_parse_report(struct platform_devi=
ce *pdev,
>  			if (i !=3D CHANNEL_SCAN_INDEX_TIMESTAMP) {
>  				/* Set magn_val_addr to iio value address */
>  				st->magn_val_addr[i] =3D &st->iio_vals[*chan_count];
> -				magn_3d_adjust_channel_bit_mask(_channels,
> -								*chan_count,
> -								st->magn[i].size);
> +				_channels[*chan_count].scan_type =3D (struct iio_scan_type) {
> +					.format =3D 's',

Will this regression cause a compilation error?

Looking at struct iio_scan_type in include/linux/iio/iio.h, there is a memb=
er
named sign, but no member named format.

For example, other channel setups use sign:

include/linux/iio/iio.h:
#define IIO_CHAN_SOFT_TIMESTAMP(_si) {                                  \
        ...                                                             \
        .scan_type =3D {                                                  \
                .sign =3D 's',                                            \
                .realbits =3D 64,                                         \
                .storagebits =3D 64,                                      \
                },                                                      \
}

Should this compound literal be updated to use .sign =3D 's' instead?

> +					.realbits =3D BYTES_TO_BITS(st->magn[i].size),
> +					.storagebits =3D BITS_PER_TYPE(u32),
> +				};
>  			}
>  			(*chan_count)++;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512012302.2088=
3-1-natalia.andre@ime.usp.br?part=3D5
