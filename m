Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1655409C
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577462; cv=none; b=JdtCfP/6DUa0T2J1iVVckint2/t2XUD9xMR/syRXjofF6P80ta6QHxpN9bdvgEtupBmdMTzouD9CrYDYwd8A5kY54A227cr6NUzGI0O1/LZQIIZYgX2CtWNEAEau7muvRgL8Cr4dAhHoJyGp+iFJ6mq6h4yx48WEg2DxQKNBUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577462; c=relaxed/simple;
	bh=YbF9Hq6ip8NH9UOOHu4vU+eokzBGAvhZ+dvcT2bOj6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEF+0oKyLO03sb0O9jDk6QeeTod2EoP7aP5T9HZdmzuNtayoIxha9Jv/wMw2xMTYtdui/wCAHf3NTfQaqc0iPuVNF7gT8cNtnQhE99M5IjISqDDtglJul1gRW4FI09pQmS8R7P3DEUziB8qKlkow5kMLAVXzm74/jsyghKRoFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzyqTTzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzyqTTzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCBB1F00A00
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577435;
	bh=YbF9Hq6ip8NH9UOOHu4vU+eokzBGAvhZ+dvcT2bOj6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HzyqTTzdTWLsGmoCJP7+EXA26N7h4dqjzbXM5JPEPRmAvBShC5ylp3QJV/IjFmw2j
	 mjYxuiIBuHovU5P+xcx8DR4hs3yIUF84rFvt80tKQbbcmWfaC3EJjON9izC9FxzvdM
	 oFVfWzvRvSrFfZUjJLWso1ndlCj0t1vaf66uaca+2kSipx62tXWjn+XumW5OQJgL4j
	 T4S5S1y7EEAGt7l3v09zRQP7DTAhU8QxP8B2Vg2Tp9QhJZlqEaP1j07YpuHi9gJLJK
	 RTsbMzdFpidBi3Q6p012fOaANPqli9LviU2nv30Gm+quxkMLGJbSfeU5/2BANPeULK
	 z/AWiwO1xhFsg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16c72so1165071e87.0
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 09:50:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBztP8XvXntWts+OgI1afEOLiD2FurJ9gfm+T3ESex0pDGGMmLAbeyGOswbtM4NyQTzCJC48RYP2NMXi0w==@vger.kernel.org
X-Gm-Message-State: AFuF++kcX8WodAgvSPvr9ZS3cVD16uKqExjayAyZ9Ut0laQWMSU3xsHg
	zGUWQwY+UnCbOmkzlbVzbNnZSwHtUzp1MFmTiZ0gK7RL4gNppT5JoIq3LPMIpApPzOgRap/okZi
	wgc3Zdgahgk2Tu944NSZNkqht5mWULAE=
X-Received: by 2002:a05:6512:12cb:b0:5b5:e263:dcc7 with SMTP id
 2adb3069b0e04-5b8b660c1ebmr1008093e87.5.1789577434048; Wed, 16 Sep 2026
 09:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-6-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-6-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:50:21 +0200
X-Gmail-Original-Message-ID: <CAD++jL=8g4U-BkKH2zVuxQD1BqHNP-EseUsKzTJNpJFaR+Q6AQ@mail.gmail.com>
X-Gm-Features: AcwNN1W58wTtgVz2clQ_wz9Mlu89xpFs3b5LWAbQ7ez6ueMaGMU5iIjS17A22CM
Message-ID: <CAD++jL=8g4U-BkKH2zVuxQD1BqHNP-EseUsKzTJNpJFaR+Q6AQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] mfd: remove unused adp5520 driver
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:23=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver requires the use of platform_data definitions rather than
> devicetree, but that was last used on the blackfin architecture in
> 2018 and nothing could have used it upstream since.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
