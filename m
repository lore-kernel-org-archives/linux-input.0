Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26EB29B8D0
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238866; cv=none; b=Kp7fkyqRdBm7RHy/KRJRK5BN4PNlIeNQUlQpYfRGMQ9BXPkVwDTl8UAmbvY4ZKj3XLUIwo3SkkCJWDmG1iaqX//NfsgHUhxcf8cFRvddIg9ShnmRz/2//Azh10z1yYKjbVyF4GbOpXsPzu1VjtwGA0JAcFQ5EpE+6U1VvBS+GqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238866; c=relaxed/simple;
	bh=NTialwTmRHxZfb9ID4klNoDiCrCM+G2liO0c5j6fnNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tOgr0zvnNYZyphMYWsNQ0L2nRXA8Sz154OtYNjrc6bF58CCSbSB3XSuvywZqURxItyB7Rm6pJ1PqpWANj22cLwwVamkh+UkBwO3tnCx860Zwy46Gnt02azhVPUs5dqqiIxU0yHgb8GnOPaAHHqxlzpOFcpqiFIv9TQnpHL1aKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnIHXOqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnIHXOqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7B01F000E9;
	Wed, 20 May 2026 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238865;
	bh=ejU0RGVPaZWoaz8fJ0PwNcR0JC4cB7TO+omcbWoQZ28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HnIHXOqPwVmk392VhlxLE+iN75XuTLV0R1L9Ub35xeIvCfA0T8n6WWaEqULAZ97pU
	 v/6kcbUHpXm6R2Ioxm3LincpqiAR1W5u/LKvHOWztiMYjXX9oLxpyh6YWw+u+tl2WI
	 JbNPChIGbDc8PkkyVarDvNLIFJzc0NZfJ5MERvAqyNFRtZZcEPeBm4LgaFEUuL4A6q
	 H9ZPpgXO3sdRZIbb8kbH1+iC7+26XsKngcIbVf1qdNoJ2M7AAcK7g39oLBh762xhkl
	 2FQTnHhOg+JGJJAZiTNTVeY34NBmyQJG1o1uXlVHeX06t9O8rDE2xcaAfuYWI3qSto
	 R2moA1HG/MK5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] iio: magnetometer: HID: hid-sensor-magn-3d:
 Refactor channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260519234752.23911-6-natalia.andre@ime.usp.br>
References: <20260519234752.23911-6-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 01:01:04 +0000
Message-Id: <20260520010105.5C7B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Invalid struct member name '.format' used in compound literal for s=
truct iio_scan_type.
--

commit a348ae7b1670bf238471e69df7f224b48282264e
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

[Severity: Low]
Will this cause a build failure? Looking at struct iio_scan_type, there
is no .format member. The correct field for the sign indicator appears to
be .sign, which was used in the original magn_3d_adjust_channel_bit_mask()
function.

> +					.realbits =3D BYTES_TO_BITS(st->magn[i].size),
> +					.storagebits =3D BITS_PER_TYPE(u32),
> +				};
>  			}
>  			(*chan_count)++;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519234752.2391=
1-1-natalia.andre@ime.usp.br?part=3D5
