Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1975678CA;
	Wed,  9 Sep 2026 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961145; cv=none; b=AYC13lBTTi47Cckkz3C7osKPc8QW8vP2XBUmsj09DZWIW1TnjQ2MiaNjiTqclCjxZPupAaJ8gZZNXvUqVcDZ4avbepuddMBiQXuDq+RuhuHFca93J/YsNNq7rqtQs3mpGyzTF5a8SVIwbqy7kylGAJ6lN9JqM6tD4U9X0Pl72H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961145; c=relaxed/simple;
	bh=WO8QBYmdTqahM5OgzfaMDqYaW6z6o2JDbUEJAAWqw9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fmy0a/4TApyXy4MKoL5kj6YbFnw841trqP4/yWJZLGewxlovVTdDgACG5OTdacxv5gf/uM0bSoyKq9P0FKDlT9UXkw/JmEsBDA78J7uIe7cc/HcJwlPp5en7of5Gw6zZGh5q/DyqLWbHKbSd1pgYaxUltQOVMp88EBlbXSr0TBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egJbhgfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egJbhgfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6428D1F00A3A;
	Wed,  9 Sep 2026 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961144;
	bh=SpOPfr2ReQiqwGUnnCKY8XMzRuE7it2CJR17DCuQCKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egJbhgfYu9Xcsn0rWtO8Y1mvsiMo3zEUzJocdGJ9irQKae8Ea7PNLpE65RQWhPMrY
	 KQ38HSUN2ykXprj/XiupLTY+dmBNf+KB/AA4oqQTcmYLXBLQYXRwOKEKfl2YgO2yDB
	 5uArAmpI1Gqp2i0e+ay9cw9DpGu4XQynD2YApu2/JzOkzwsfmPsO9P5ih/CWeM8zIf
	 2fmKy8Vu5psZQWVlGbxQUP+Gjr3Y3C2+dRrUoO5etH1kb5kS3i2Kij3+1SP3WOcIC0
	 2lqveHCwWm6PDvd0zp+Jx7mcw0X6z9YFiM6cSC1/0iqYOhagq1+G9AkqDTq9mzZMMB
	 jB8C7XdOixhbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/14] mfd: remove unused da903x driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: mfd@lists.linux.dev, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org, linux-leds@vger.kernel.org, linux-watchdog@vger.kernel.org, media-ci@linuxtv.org, lee@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260909132153.1596191-7-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-7-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:39:02 +0000
Message-Id: <20260909133903.6428D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete driver removal leaves behind orphaned header, MAINTAINER=
S entry, and stale defconfig options.
--

commit 5d7f5a2366c42ef6c4fd37de982c54aaa25f59e1
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused da903x driver

This driver was used on a handful of ARM/PXA boards until those
got removed a few years ago. Without devicetree support, there is
no way to use them upstream.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce681f5e08967..43355bffc6100 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7575,7 +7575,6 @@ F:	drivers/input/misc/da72??.[ch]
>  F:	drivers/input/misc/da90??_onkey.c
>  F:	drivers/input/touchscreen/da9052_tsi.c
>  F:	drivers/leds/leds-da90??.c
> -F:	drivers/mfd/da903x.c
>  F:	drivers/mfd/da90??-*.c

[Severity: Low]
Does this incomplete removal leave behind the orphaned header file
include/linux/mfd/da903x.h? It appears the header is no longer used but
was not deleted in this commit.

Additionally, should the MAINTAINERS entry for include/linux/mfd/da903x.h
(at line 7590) be removed along with it?

Finally, are there stale defconfig options (CONFIG_PMIC_DA903X=3Dy) left in
arch/arm/configs/pxa_defconfig (at line 322) and
arch/arm/configs/pxa3xx_defconfig (at line 57) that should be cleaned
up as well, to avoid minor kernel configuration warnings when running
make defconfig?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D6
