Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711B3C871D;
	Wed, 23 Sep 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161622; cv=none; b=T+e4rsMniAG8JJSmreEb07UPPez53b5zEYjwLSK745L46VX3Hd2dgxQKTmlJpqxVuVl1ci8Zeah3kn+KYo9UECkJDamhMb7X1XWJ/3rC9bL0J9qe1/F8kHpqv+Pvk/x6Yu1mDto4Cw0+Fl98xnOY3bkrfQY8aLSZPnmZzJdUgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161622; c=relaxed/simple;
	bh=ucjhQ6uU0uPpVsPtrWb7S/z2FjdMou3k8YywhLbv1Iw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZA2Q9zn//BhuB+O9ZdPEvciSaBEawxjh3LS7egYgAN5w/7BhUYqfibbrR/6Cj+Bsbf9HBZ5uRaNTf7lMXvzmgbGJB3B/bV+I9NrQWyCpP6T9Na/JkoqooJKfywdTu6R9vqMT3jRxaBQeC3ec2mAzrCNy3REWg7mlrrd97Tx4czo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONqWLeSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONqWLeSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C331F1F00898;
	Wed, 23 Sep 2026 11:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790161620;
	bh=rw+oWRXM+tKPNZbmAzawsAMTI2cSUjgqAYkEMMUPDs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONqWLeSMKhCtWb8CByTgK0k6QgFIxEHgiOFioIo2UPsB1xcZlNuQYhuG/tMt4ruEO
	 gLXo6UT1u8SjVYnAKH+khTpSE7pYTzQ+xHsSCXresl/tpEjmLgHb8DzmzHftoYUmXC
	 YC7DOa17q9AvJr1fseXYSf1lYS1lMbKcJr4Go95kZbi9JcJSbzU6SH1mMNWBTPZaN7
	 G5w17738LqP1ifVTzTLs+brDU0WK5zUgORlhYyFUGTrusnZiBn9wwmFm4BCMwCiJVD
	 FgUCx2zpKSeyjhn7OJ+y7+LTpkh25mEgFUe+2+uqHNb/awzzM6kLuHqkOEG2FDBPy7
	 opi6AUbpW8GrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: axp20x-pek - add AXP313a support
Reply-To: sashiko-reviews@lists.linux.dev
To: Vladimir <anykey196@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-sunxi@lists.linux.dev
In-Reply-To: <20260923105757.260-1-anykey196@gmail.com>
References: <20260923105757.260-1-anykey196@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 11:07:00 +0000
Message-Id: <20260923110700.C331F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: broken AXP313a sysfs attributes due to out-of-bounds regm=
ap access
--

commit fbaeccab4996537ab99d0c8423e2cf36610e4b34
Author: Vladimir <anykey196@gmail.com>

Input: axp20x-pek - add AXP313a support
   =20
This commit adds the AXP313a PMIC platform ID to the axp20x-pek driver to
enable the power button. It uses the axp20x_info generic register layout.

> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-=
pek.c
> index 24f9e9d893de3..d4e2fc9a937ff 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -393,6 +393,10 @@ static const struct platform_device_id axp_pek_id_ma=
tch[] =3D {
>  		.name =3D "axp221-pek",
>  		.driver_data =3D (kernel_ulong_t)&axp221_info,
>  	},
> +	{
> +		.name =3D "axp313a-pek",
> +		.driver_data =3D (kernel_ulong_t)&axp20x_info,
[Severity: Medium]
Will reusing axp20x_info break the sysfs attributes startup and shutdown for
the AXP313a?

When these sysfs attributes are accessed, the driver calls:

axp20x_show_attr()
  regmap_read(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, &val);

axp20x_store_attr()
  regmap_update_bits(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, mask, idx);

Since AXP20X_PEK_KEY is 0x36, but the AXP313a regmap defines max_register
as 0x21, won't the regmap core block this out-of-bounds access and return
an error?

> +	},
>  	{ /* sentinel */ }
>  };
MODULE_DEVICE_TABLE(platform, axp_pek_id_match);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923105757.260-=
1-anykey196@gmail.com?part=3D1
