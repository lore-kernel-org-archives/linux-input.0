Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AED3A8FE8
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785416; cv=none; b=fO9DSFBhTa3/URkobBs38ZPLzmjoSs6sbkmsEyPicv6ewY1A1gjY0CCgzqSLccDHX9bEOFcsU0bVY4Xxi3c6UK9D/4+von60YM0SyZ9cB5Jtnqv+VFxJ+7cDpiibpp+zRidCpYsqeRsLob+N7KR/OtE8R0LBQH0GcjcilZpaqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785416; c=relaxed/simple;
	bh=SFRI5BFcprMUa3JpdsIZ3TCZEdjqCBcEU7UivobKvZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsbEH24tdIyVkPLjZ4AOJRRShcMihGlKoG0Q+1NrX5cLaUi+QEvBbPQ4Lm1BTradmN2I0HlB32Jm95nPT7SmyNqbHaCnIrUL8IpB3Dd6d9qIjLq1Y5qeBiXteabqqXCxgMHZB/3mZYLsJ9+PcTbEwFsSRGGYNVsLTqv6HU2C5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT7ZXANL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT7ZXANL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C801F00A3A
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783785415;
	bh=SFRI5BFcprMUa3JpdsIZ3TCZEdjqCBcEU7UivobKvZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PT7ZXANLZgjpKXKIg+w6s4U3biKinVXPnA65xlugCzroQ2zl+gfQYZcwLCF/RJEr0
	 86v6i5vLCPgVwxHaRK0/UuNkt5p5Y65PJYBIDk9rdbt+McM5FKnbYfbRV3vrUka/kt
	 3RB9dhgeviXzC6jE6vfIYvrgUM3muozuVlzV2AyJZvr0iQVXUcluIflM8RkExzjNiz
	 WHiTz66PjYEADHf4nNSmKM8HNBgke0Wr3aVe/IrWzaq8nMsKtq6Aqe8kFePHXmCVya
	 i6gQBINklRllNkFOiJXCih45/B//ZWKcW7eiJwr3f6KBVqSqoJLlT2pUYREMdCnQ5Y
	 W3VCzVMFlhNTQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b015b2d792so2051957e87.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 08:56:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpZKXuoWKVMyEmeCkfdTpkqlOEMGLCh1X89t0iyUYLUEyFauxbRDX9OBHvGFCfQXDsH1E9EAj7CH4OHoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJB1kjAXu9cCnaAouQo3KE6W7qaDZwKhXisa9VTmJhs81BfoFT
	pne1wdTWbskUq14tMasb49JjLg8yNtBE9GOeB1MamuHUkuJf1aYGCvRPqLeKjHQveH0AxGRxJGj
	6FrZDfXMKFRgtmQPLZ3b9p6eHD+TqClg=
X-Received: by 2002:a05:6512:118d:b0:5ae:b36c:81c7 with SMTP id
 2adb3069b0e04-5b02369b29bmr708700e87.35.1783785413596; Sat, 11 Jul 2026
 08:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710211954.1373336-1-arnd@kernel.org>
In-Reply-To: <20260710211954.1373336-1-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 11 Jul 2026 17:56:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLk7MWRccwuzXBLtdUk+k=Ykt_fJp-C6Sj0_2EMMEr3xxA@mail.gmail.com>
X-Gm-Features: AUfX_mwg6yb6TVVJdXhaZOS6qdtgZlShwnqqpOMB7tnZklRdo8JRbXGnpCKCf4s
Message-ID: <CAD++jLk7MWRccwuzXBLtdUk+k=Ykt_fJp-C6Sj0_2EMMEr3xxA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] treewide: replace linux/gpio.h
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Frank Li <Frank.Li@nxp.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Greg Ungerer <gerg@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 11:20=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The linux/gpio.h header used to be the global definition for the gpio
> interfaces, with 1100 users back in linux-3.17. In linux-7.2, only about
> 130 of those remain, so this series cleans out the rest.

The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
