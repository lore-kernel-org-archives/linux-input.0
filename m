Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A54192F6;
	Tue, 30 Jun 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826113; cv=none; b=FT2pyxOOO3YbzW0tXtvXeZML3b0/DMWpRDYFAbia4QmtakCLe7iEdJQyKO9/oUBQsbwlxf1uf1U6oJ+N3Z51LQ8Y9mqlKdfRiUTG9tt10SAiJbAox5K0G9sLLKts0wX0xd7P/chzxnJPiFLtNS3D20Dn5XEtbduO+Ka7yy2Lqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826113; c=relaxed/simple;
	bh=CnKS1HSwVcqQokNqyGJhU6syuLsuh1mjGIwRBdW/BOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ClJGb5X18VQTTKPw8+g5jb6O/pjT97H2y30EQ+yc/Iwh/hAEZrLGoTyIzUklorb9BuRxh8neAJLHsKdIhlDV3TRedt57ddGvfBpDJ5I24ev82EC88r3lCOzWCqJjl35bwSo/mXKWqOL80N4Z3E1I5FdkfoGk7PF918w5Q3xjoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIX6wAuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIX6wAuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9C51F000E9;
	Tue, 30 Jun 2026 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826112;
	bh=e2NTsoPtc4Ih6RALL6+PVycCsLek2TBHF0lUvpy3RoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TIX6wAuXFfBZv90wBYlbOQdmfg7Eg0X+THSNseCtbfXPGPHrKRAe2lYy5bTuuhexd
	 G7K79powpWYszSyqxhCW6qVuR45J0EAql8sy+zPEsFa7I4Kivv/5puEk8sXytxdIe0
	 5JOSjc7M9MG4j3exhvmkb4G15KUfBzFx/tJoK5Kv1Fx5T008zbn+6yFvV3DQgi9iW5
	 Zs7DnDcd5DjmkxeKdq/J0NjxZ0ciQ3ZDQSMChWoTlq0MR73osY9RtTZyT5FBz3frHm
	 9jNfZkcRBg48VzX7HP8TyLZvBU91zHXkcjFU+TA3osQ2hXVwOmefG0kcnTFzolyDSu
	 YGDueAE2j5wjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] ASoC: replace linux/gpio.h inclusions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org, linux-input@vger.kernel.org, olteanv@gmail.com, vkoul@kernel.org, neil.armstrong@linaro.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260629132633.1300009-8-arnd@kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-8-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:28:31 +0000
Message-Id: <20260630132832.3B9C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces duplicate `#include <linux/gpio/consumer.h>` d=
irectives in `cs42l84.c` and `dmic.c`.
--

commit 5e88ad9a5863dbafbe414c688b31a85827de20da
Author: Arnd Bergmann <arnd@arndb.de>

ASoC: replace linux/gpio.h inclusions

This commit updates multiple ASoC codecs to use linux/gpio/consumer.h inste=
ad
of the deprecated linux/gpio.h header.

> diff --git a/sound/soc/codecs/cs42l84.c b/sound/soc/codecs/cs42l84.c
> index f2a58163de0ed..36c3abc21fedc 100644
> --- a/sound/soc/codecs/cs42l84.c
> +++ b/sound/soc/codecs/cs42l84.c
> @@ -16,7 +16,7 @@
>  #include <linux/init.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>

[Severity: Low]
This isn't a bug, but does this create a duplicate include? It appears
linux/gpio/consumer.h is already included further down in this file. Could =
we
simply drop the linux/gpio.h include entirely?

>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>

[ ... ]

> diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
> index 61e1bf1b3c9e6..8b05d6f9b429b 100644
> --- a/sound/soc/codecs/dmic.c
> +++ b/sound/soc/codecs/dmic.c
> @@ -6,7 +6,7 @@
>   */
> =20
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/consumer.h>

[Severity: Low]
This isn't a bug, but should we just delete the old include line? Replacing
it leaves two identical includes back-to-back.

>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629132633.1300=
009-1-arnd@kernel.org?part=3D7
