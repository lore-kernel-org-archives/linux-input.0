Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F396492E5F;
	Wed,  9 Sep 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961265; cv=none; b=DVP6k5b/zQfvDOyzmkujjAJpl3SknucUWR6VL34oAgPgUofp5nul5ys5v0J0nNndIiIGsV+neLOnSkTluNDyKFvfwgiu5kVctyEVZxxL2sSENLh7ZrVqQ/a27UKRyDXw3BGk6n9TlDbZNEQmxD++6oWTHZgxOwR5PL9YRiuyMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961265; c=relaxed/simple;
	bh=Z+YGyXn8H2DYk/RJt4apSNi/RPELIq6HACHfaxYJryM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Da3f1zve2jlNd5Ds66cpZ+wui30vir0OH1m6za0p/Hy2FkISi1fYTrkg6QAFWhJ7YJrVXMJm4N8YzGfg9PFeEqc8Yud7WqILJMo98bp+ldtlUDd4Jo67p3jZL+4xs1An6N/psIOIJoQG/TB8esG5+XEqF/pND0sFNQ+ePvmLRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/mxKVZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/mxKVZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157A01F00A3A;
	Wed,  9 Sep 2026 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961263;
	bh=wxMXjNBdXbhhVdeekOL7ly4h76Cr8A1CF6EPfA72hcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/mxKVZiP6/lVyh2S0uVt5RwObq0pHb2AISuZ9ZhkQDt5uk+a7izGlK34Gbr9mdzM
	 rfOfnPojA2Am84NNqUghl5XiM7B4w5BHUDTEGkjUz8wsV2e0AwNtADXa6FsZ7dKtRs
	 B4VFLVFv4pX98WYQDE+zoiFd+zDlHUtwvzB0GqdJB64v90VbKM31NBn/ZNPSEVh3Ce
	 7Ahvh6E2Re3e3UFIaBPVPVLYB0de8NsA1tb7ULqpYHelbw7WVKutu7H7f+H3rsHMKp
	 wJMFJq+UiG186ONqmlDHzyp93h2g3CXXLZz9C7z6NSHYFwULyP0CW1kdaQ7lFpbzRl
	 66N3LgVdIyyoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, mfd@lists.linux.dev, dmitry.torokhov@gmail.com, linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, media-ci@linuxtv.org
In-Reply-To: <20260909132153.1596191-12-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-12-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:41:02 +0000
Message-Id: <20260909134103.157A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Stale documentation references to the removed wm8350 driver.
--

commit 180d02f3fe78e14ad7acf9b29e2590c4c4ee3a29
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused wm8350 driver

This commit removes the wm8350 driver entirely, as it relied on platform
data probing for development boards that have been dropped from the kernel.
It removes the core driver along with its hwmon, gpio, led, power,
regulator, rtc, watchdog, and sound codec components.

> mfd: remove unused wm8350 driver
>=20
> This driver was used on the i.MX31 ADS reference board from Freescale
> and the smdk6410 reference board from Samsung. Both used platform_data
> based driver probing and are now gone from the kernel.
>=20
> Since probing with devicetree has never been supported by wm8350,
> it is clear that nothing can use the driver on an upstream kernel,
> and it is unlikely that anyone is still interested in a devicetree
> conversion, so remove it.

[Severity: Low]
Since the wm8350 driver is being completely removed here, should we also
update the documentation files that still reference it as a working example=
?=20

Currently, there are a few places left behind that point developers to the
removed driver code. For instance, in Documentation/scheduler/completion.rst
referencing wait_for_completion_interruptible_timeout:

    why (e.g. see drivers/mfd/wm8350-core.c wm8350_read_auxadc())::

And its Chinese translation in
Documentation/translations/zh_CN/scheduler/completion.rst:

    =EF=BC=88=E4=BE=8B=E5=A6=82=EF=BC=8C=E8=A7=81drivers/mfd/wm8350-core.c =
wm8350_read_auxadc()::

Additionally, Documentation/sound/soc/jack.rst points to the removed codec:

    CODEC integrated jack detection can be see in the WM8350 driver.

Would it make sense to update these documents to point to a different,
active driver as an example to avoid confusing developers who might try
to look up the removed files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D11
