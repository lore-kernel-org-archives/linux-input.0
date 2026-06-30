Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023A31E858
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855609; cv=none; b=GqjY6t8+zIzJzn6izuTCh5bZU8/9Ex2/8jncNavWLDnwN/zHVmMkUGSBmjPCiHHBjGHrMAyfXcuHiwf/iYqvHZU6K0WIoyu2OpIK+emcz0LI84I12NNGZTzI4yFXkWYQBnb4ULvLs6P53ze6cmlApnI5Nb1SgoTAXKfbK5eZHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855609; c=relaxed/simple;
	bh=La2xNvf/TCB9nBGYKaS8YDOIJOCNSEjb9+oJx13QQCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mI3hA1st3n3wX2clCo1Ez09ElUGlI6vMzG3iHA62YggQNfuxeE9cInNpQf51nt72dTefxae8feCccbVRJjw7jzi0D36vVjgkErtDOC+C8IP7iGXvLFdj99kGchM8VVPEQBuenxYyoCLqOCJqUhtCOT3NARffZNDAl4UrcfpPoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvKTMsSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvKTMsSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65C81F00A3A
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 21:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782855606;
	bh=La2xNvf/TCB9nBGYKaS8YDOIJOCNSEjb9+oJx13QQCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hvKTMsSLWpQ7iwnKPdGvgwo9HJsX1KaQ0ubrkEyF6jRtv6mdeKaQvRSrk8mJbQzxW
	 ig6k3MT8xKA+lTAcOlkAAOJcWdXKrFmGykfXLZNsJrC4ZUwxYU8idfhr4PDNNRiJQl
	 dL4jtvbz1PpTkasUpdlMtraBeP+0Obg7Sy1MnUWXzAfKz9u+WjtyjvDJMWkxSdE48F
	 JlrnDpUpZ2kdUZnpGkFx0rw7VpM4s3JAFfKvDSckb101eyILjgH9sF32uBzeJUlAqw
	 rc0o03G7Elsp6K6Z1gVl7D5Bnr8tmbDdWDEdfx3fznr2bRRsBeoZllbucPhSQwYNf0
	 zkw1ib+Apn52w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeb36ed873so2756129e87.0
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 14:40:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrsMwgxVjxiRivYFfIMZUIhTKzopoN/VxB0ax3qA/BctFZMeTmgBn6xnRZZFBXhf0lUuNWOku0+FAtqPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCqAnoZhp8jRquspzfs2cz32y6uRfqehMMB+nWqA121GXuxTe
	MoZinc7IT+ruLV6hL0rzuY6nrW2/XHZhUTae5vdHx3HLVvzVMWB/6gCdq1qhLw3FX7D1aXYVyYb
	vqHiU+x6ClciKGWIfe6uZEtsBBFq1LJI=
X-Received: by 2002:a05:6512:3d19:b0:5ae:b604:4c9 with SMTP id
 2adb3069b0e04-5aebdbc9489mr1240118e87.65.1782855605213; Tue, 30 Jun 2026
 14:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629132633.1300009-1-arnd@kernel.org>
In-Reply-To: <20260629132633.1300009-1-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 30 Jun 2026 23:39:50 +0200
X-Gmail-Original-Message-ID: <CAD++jLkpTa4hxNRscbiFFKZTM28ThuJMo1f3SX96LheC8L5BEQ@mail.gmail.com>
X-Gm-Features: AVVi8CfBoAND9VanduyO4lm3tElbURSYx2nmpdkO8PSRH7aiVql7RmWg2jM4Qb0
Message-ID: <CAD++jLkpTa4hxNRscbiFFKZTM28ThuJMo1f3SX96LheC8L5BEQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] treewide: replace linux/gpio.h
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Frank Li <Frank.Li@nxp.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Greg Ungerer <gerg@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 3:26=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The linux/gpio.h header used to be the global definition for the gpio
> interfaces, with 1100 users back in linux-3.17. In linux-7.2, only about
> 130 of those remain, so this series cleans out the rest.
>
> In each subsystem, we can replace the header either with
> linux/gpio/consumer.h for users of the modern gpio descriptor interface,
> or linux/gpio/legacy.h for the few remaining users of the old number
> based interface.
>
> All patches in this series can get applied independently, so my
> preference would be for each subsystem maintainer to apply these
> directly, with the rest going into the gpio tree at some point.
>
> The final patch here obviously needs to wait for all the others
> to get merged first.

This is helpful.
The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
