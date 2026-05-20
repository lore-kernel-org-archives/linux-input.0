Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D019E573
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238173; cv=none; b=BzYZi1nfHuNr8K8Y3kmMn0Mw4RqNWn14tGW79jtpcvgHK9s1dJJtV+Uol4tEFbO1M9hvFRkMBo7PHP5o7BGj23eELoEos47W/8LOFhT6QdUx/NUiHqA3vCFP3UYc1CpggGXAGDn5cuhTzcDG/Nu9FtdeqWYSH9AFaJqdvbvNmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238173; c=relaxed/simple;
	bh=1qEdqANaJ3Pd8KRhx0KH78fCwRMjFLJVMbTT4NOWU5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cxt/uSirhfnkBhoob2fdFxF3TxeJE6oFDpe1WZH7ekRGwIbAD/ucCHj+3isZok5KezpnYoW9J6qlL7PhEKSGlqb7nSl90SoocHADDSmohtPGzo5bAZyOLeSwPrePvcUtX65pyMqm/fCXK0jVJz3iUgHzyrhUFzOrdt8RM8GGtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV5xyUXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV5xyUXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97D41F000E9;
	Wed, 20 May 2026 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238171;
	bh=YbmE3TkiW6kKMCXojq/PA9OcvPHk4U/Ut1Z70nJpxLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NV5xyUXy0SFAylorruQ9nOEByiwYMginfrJ96qjOomL/k2ZjVPiUUCsUI9MYUnAZB
	 m0fRmf/Y0TqKngcfZjmzFORaJw2aiCc77IqwZrWj5lV1GynixBuLrpYCeiw3+0AL1R
	 5H/oqZXtH34xVywxqa+n2FriMRBkZieYBir5otwSl3gtITIS48ZnCODh2RSFET7JZd
	 hLD+rcbPdJYdRmGdqYe/y0U3avMdkeVyY6siPTsZAVpAtOo1g6tGk0RDyhAsHGg8us
	 mF8DUAD8dhvacAB1rAjEylXvoB1n9N6tX7VMZ+nkFC+Ko4EF7S5z68cQ/laQJ/KlAl
	 8+GVBx2YxjmqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] iio: light: HID: hid-sensor-prox: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260519234752.23911-5-natalia.andre@ime.usp.br>
References: <20260519234752.23911-5-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 00:49:31 +0000
Message-Id: <20260520004931.A97D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a compiler error by using an invalid member na=
me `.format` in a compound literal for `struct iio_scan_type`.
--

commit 79e0a9b7358ae7d1e9e80ed657afdcf93d6d8469
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: light: HID: hid-sensor-prox: Refactor channel initialization

This commit replaces the local prox_adjust_channel_bit_mask() function
with a compound literal for scan_type initialization. It aims to improve
code readability by directly assigning the struct fields.

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

[Severity: Low]
Will this cause a compiler error? struct iio_scan_type does not appear to
have a member named format. The previous code set the sign field to 's',
so perhaps this should be .sign instead of .format?

> +			.realbits =3D BYTES_TO_BITS(st->prox_attr[index].size),
> +			.storagebits =3D BITS_PER_TYPE(u32),
> +		};
>  		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
>  			st->prox_attr[index].report_id);
>  		st->scale_precision[index] =3D

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519234752.2391=
1-1-natalia.andre@ime.usp.br?part=3D4
