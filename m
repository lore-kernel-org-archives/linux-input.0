Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4741325C;
	Tue, 30 Jun 2026 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826111; cv=none; b=Bm03mvOd2c3vSV6Zev3Q/jlPKFZQQGJN77GBUUuf6hqy1J1JsFrvjlIz20zxxOw9ZmpFbS7yo2IeNICLkIpmNAEgX/bNljYdvNXJzdJcDp59fSLcem7AjJj/UOsg4a0y14P7bF5f8Dich8FY6jxtAyojDk5BoYsBGUYYPobv+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826111; c=relaxed/simple;
	bh=ITtFt7n/Op6uYotaY2Qd+smipIOkapHbT/3th+irJuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fbZSWbgR3jFPWY3Txty/zas3J+G/tZWtXecO3oJ44/TD225KNEiorPfT9VOzREYevb3UfFBqxI9vg446Ofqw9lgG2SraI7Wx5s6mT3mFTBZO7lRGRNh+YW5jWZ4fo+G8xV7+9BFq6pjuV4l86t1llh/+JhFrY5kWir2IDz8KyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDpzbJma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDpzbJma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0751F000E9;
	Tue, 30 Jun 2026 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826110;
	bh=FqYwhhXUqU7Jsf0sHkg0y9uuS5UXFaP8C98LR4+cM8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDpzbJmayqKDJ0Kq2DxxzPKJfgho1fvMIWAhu+Hvn6mwjgvlukywnTC+OAdF2X+J3
	 QY9D+PgSljZuAZJbeu1iefwLSX8v8B+iNDmVG6mz0aWc/xi70FO8lCo63Ec2xfOmZP
	 wsyOiJjLyxTH2/j6/Z/zJ5gUL6nwuzRpUYP1F1VKGEJy2b6Bt63qGlVJGXVQTzN79T
	 dEEfSHR89cvIcaQ/bncJJjqEnepy+Le4GsS0cfKRJH8VF4W6hVx+3XVJ/nswTEXjHP
	 U2rgNJUIdy7hq15js6z2H+jaHBiA/+NHcbhtLR/Wxo8eHGu1fdJEJHi9UVqv6J5zH+
	 ktPwM4yk97wEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] mfd: replace linux/gpio.h inclusions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260629132633.1300009-6-arnd@kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-6-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:28:29 +0000
Message-Id: <20260630132829.AA0751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a duplicate `#include <linux/gpio/consumer.h>`=
 in `include/linux/mfd/ti-lmu.h`.
--

commit 19751af1f4af7549cf9f140e38427847c8babbd4
Author: Arnd Bergmann <arnd@arndb.de>

mfd: replace linux/gpio.h inclusions

This commit replaces the deprecated linux/gpio.h inclusion across various M=
FD
drivers and headers, converting them to use either linux/gpio/consumer.h or
linux/gpio/legacy.h as needed.

[ ... ]

> diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
> index 0bc0e81997987..5040c7d1e1b92 100644
> --- a/include/linux/mfd/ti-lmu.h
> +++ b/include/linux/mfd/ti-lmu.h
> @@ -10,7 +10,7 @@
>  #ifndef __MFD_TI_LMU_H__
>  #define __MFD_TI_LMU_H__
> =20
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/notifier.h>
>  #include <linux/regmap.h>
>  #include <linux/gpio/consumer.h>

[Severity: Low]
This isn't a bug, but <linux/gpio/consumer.h> is now included twice. Would =
it
be better to just drop the replaced include here since the consumer header =
is
already present a few lines below?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629132633.1300=
009-1-arnd@kernel.org?part=3D5
