Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B0394499
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641831; cv=none; b=dTnQqdsUAWDCuYRcXTDhEINa2sPhqe0Z/zEhOjsTYQfXqrwhhpJWKjAQKaFEy6FbY33W4FSsVQ4W4HlFB5E6gP5Uv7NsVcrKwAR/RPteaEAXvZ2EM141owoX0ehIl7r6APC2ZYiQczaX/Iopzu0J5G1llWM8dOBmioCGsOsPpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641831; c=relaxed/simple;
	bh=/YRsbRB3fxerZSWftRjDJgBJUfH+rUDxgCuiuPtNCRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JlG+sSR3HQNuHA2W+F+L7rXwv2AcOYdEGHIF2ZuvYTX2fOQkA5JBgmxGHLAjhjH2ZKzNwaHmxShAWBVy3wEC8mmDdhoh7BKYsOo/uQMsnvqiDdLXKXBCNL5SCnI/paQwZN9QT2Txw+T0UOlVrfkH7tWzqlzmbqZ4hgEF15TNstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcpePR2y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcpePR2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D5FC2BCF5;
	Wed, 13 May 2026 03:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778641831;
	bh=/YRsbRB3fxerZSWftRjDJgBJUfH+rUDxgCuiuPtNCRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gcpePR2yf3pYoJK+GM1QA+Z5EfNVMleHp4poQFu8bT5vPpPd6rJNn07669IMs2UWK
	 uSAQx+qUjwbeeaxpZEB7P6tHcLDFdCN7UriZWE8NdtFEGAj7nU+337D5iKKYSdsbep
	 gObYEDoaUryjnEzZg0qgU9ybqeQpcCUGHQYXlDA5lS6GOD5+zFtWrl4xyc5e3UUmmE
	 zTYhshd9YyxZDidr2wmcyxA8DvRfG0YS+Qc3jmTjc8+HQ23ozp4/v4nXgmrjdYd24B
	 XMp0EQ6qXixGRLLbQP9JW/Hy33YNvREphmRDugwjx3rCPaHjnPxKEvUtyWpR+s2/fK
	 GBfatFa59W8JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] iio: light: HID: hid-sensor-prox: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260512012302.20883-5-natalia.andre@ime.usp.br>
References: <20260512012302.20883-5-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:10:30 +0000
Message-Id: <20260513031031.44D5FC2BCF5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a compilation error by incorrectly initializin=
g a non-existent '.format' field in `struct iio_scan_type`.
--

commit b9cbff53934f8976c34e3030a4b171bfc276e140
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: light: HID: hid-sensor-prox: Refactor channel initialization

This commit refactors the initialization of the scan_type field for proximi=
ty
sensor channels by replacing the prox_adjust_channel_bit_mask() function wi=
th
a compound literal.

> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-=
sensor-prox.c
> index efa904a70d0ef..edc9274a2c076 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
[ ... ]
> @@ -250,8 +240,11 @@ static int prox_parse_report(struct platform_device =
*pdev,
>  		st->scan_mask[0] |=3D BIT(index);
>  		channels[index] =3D prox_channels[i];
>  		channels[index].scan_index =3D index;
> -		prox_adjust_channel_bit_mask(channels, index,
> -					     st->prox_attr[index].size);
> +		channels[index].scan_type =3D (struct iio_scan_type) {
> +			.format =3D 's',

Will this cause a compilation error? struct iio_scan_type does not have a
member named format. The previous code set the sign member to 's'. Should
this be .sign instead of .format?

> +			.realbits =3D BYTES_TO_BITS(st->prox_attr[index].size),
> +			.storagebits =3D BITS_PER_TYPE(u32),
> +		};
>  		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
>  			st->prox_attr[index].report_id);
>  		st->scale_precision[index] =3D

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512012302.2088=
3-1-natalia.andre@ime.usp.br?part=3D4
