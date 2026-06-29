Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8E4071CD;
	Mon, 29 Jun 2026 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739125; cv=none; b=WZWy/kcFLrbOh8DnYYLcQrYKAutfnLC/EXzwYW8qEZAfrjfTvVbQ1OavhX01+Jd+YDzTPEW9ApD3C79BBDEC31ZAt/4YXLreA7wsgczUEg/QXDSmh3vN2DyvWJfv64gDd0C7ptlYGAAClmtzJNH3U30OnJD+BKPL6V+sX+pD4Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739125; c=relaxed/simple;
	bh=6Io9H5zyDtsp8daiesBZnem1dHzaKslMO5y5DHLeTrM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=asblwp33kKzMBPbTPjgRQx5smz1OplweL9g24vUxHtUfKMw/aGLVSIv/I9fLuXcCcK3XTxVWrwXT8NQ3+jbWrOyQQsP/mwpEKwv6+qXE2/KVopZKQBBL7l2n4myNbE8RaWKnjUmYwZTXHp2BJANTZCfto9+2+4bIXGpk8aXsU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXydnBm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXydnBm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2611F000E9;
	Mon, 29 Jun 2026 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739124;
	bh=G1bZy+k/fIknGmXTuSe4aFfBxUmStfVtFOkbU0UcOac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LXydnBm0DVuoSwDD+7GykPA02e4u0B7FZzgUsY83TWX4KmmeUF5RwQzJgmwOSyvrg
	 PBU4auo2b7Hq7FyM74kVJyv3pzNuqx1QSoVHzHH2xlwQk6Wv10Z6XCAMC2YGqVa9IR
	 fwPwlgC2GHml4u65tcwMnBfyMM7BBIIc3m7cqI7CCXuG3ZVHPK6/6iRNQz1MPnJowM
	 TZMKL234qJaRqEXsY/oW80R6y+pCe9XHt87R04GUlC3k1s55dW2BiJPQ5na9WUk04H
	 hgnAvtqNy2++VPliAfSKwAYPXtx8bt96ODFG3bi3OVE0DGPYps+/SVxA13sr3LFyiB
	 Fi/IXQZpe4Alg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] [v5] Input: soc_button_array - select
 CONFIG_GPIOLIB_LEGACY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260629130329.1291953-4-arnd@kernel.org>
References: <20260629130329.1291953-1-arnd@kernel.org>
 <20260629130329.1291953-4-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:18:43 +0000
Message-Id: <20260629131843.BD2611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Duplicate inclusion of `<linux/gpio/consumer.h>`.
--

commit 2bb9f5b4a775c5b3c871a4230ef5de7eb9ac7ae6
Author: Arnd Bergmann <arnd@arndb.de>

Input: soc_button_array - select CONFIG_GPIOLIB_LEGACY

This commit adds dependencies and selects CONFIG_GPIOLIB_LEGACY for the
soc_button_array driver since it uses obsolete gpio interfaces. It also
replaces linux/gpio.h with linux/gpio/consumer.h in the driver source.

Link: https://lore.kernel.org/all/ah-1z9LhVG0wtfBw@google.com/

[ ... ]

> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/s=
oc_button_array.c
> index b8cad415c62ca..eb11bf2e94362 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -15,7 +15,7 @@
>  #include <linux/dmi.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio_keys.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>

[Severity: Low]
This isn't a bug, but is it intentional to include <linux/gpio/consumer.h>
twice here?

>  #include <linux/platform_device.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629130329.1291=
953-1-arnd@kernel.org?part=3D3
