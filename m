Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293610;
	b=QGY0LeUkKGJCD3RKi6EktcAep+GH4OHpJNtSa2bMP0YYlbMM7+ItAb+1BLCXCk0RFOLK
	 J3qabXOdOAd9d7RsXr5X6F+qJzBed5wX182N+kAYTbnqH/3zW13R2SimgOALzYrDB3n1j
	 ySuOO1y9C1g4p9UMRxCbf+HZYlBvYUI8sZWCsTFI/QZbrZoyLlJpe+45Hn4ohLM/Ko0YI
	 VbEOSCJ/38d3EoOHgjrY8gMK8sMpGzySOEwKIZhHGOodqjchNWq1gNh2k7h7dhs92N3Qf
	 HZ/Q8FUxsQ3f+CL6shUsc29J4DT+gPnyyS0x5St7D7xPc4qB8z/7u8J+J2GWKLfcVNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293610;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TBjlLLaSMdptS1qSf1sy2MeZrQefDkAIXeGwS3xNDrU=;
	b=JcTyVrb3VjT0VohNcwjvCF5VmLjYB465Y303yra3ZcP4dZqwunFVBhXPSozFP9z/NiSd
	 NHTUxSF82XakZU1+6zyh+Z8vtrNNmLmUAUItJj7UEw37CzBN38kNqfa7QQ4yuDJ+dOByk
	 AUQdbPyHn8J0vozCyfDpd0xTpFeOc1USjyaFjrhUh4ij9+VyF7k1Pi84hQ0RECBE64ktx
	 LWZtRfkzxJOevKbEZ8b81NUuqCRqUIB4VCDs6Tsh6rpje/MsNWlAKM3nz61gqxxbOeCfF
	 o/DRd3LyKsSuklWkSvb9RguTWPLXX7c/+IeA1PjRoQNdVd9fbFTzt6rpikSGu/n5Mdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2ICUGWl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52E606A320
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2ICUGWl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4778E1F000C4
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795293610;
	bh=TBjlLLaSMdptS1qSf1sy2MeZrQefDkAIXeGwS3xNDrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T2ICUGWlgRPchPUIQ+snZtdHmoEPJlYmXRuIWM2+7qMxZIlvBCJrzjTXVxZgCIuOS
	 ygV5zB9T/a/BXUUN5D1Ua9irV1wgk8khz2Ed5wJG1l+tw/TKbLFs2TclDlVOHf4keG
	 zhfeOIhuGmJyMd/6QgHDnCggwAPS8flD2uxh8EaQiq+++vVweWsOAru9rbf1EoRT0a
	 YuCQw2jJ+hyvE4IWqe2nF6iVwkTRcIcJMdFwTaulrrTGzVzas9YmEswKX5Olu1Ps+C
	 +nY64hZEYEW9UutqbeW1HSUfdJ1aE/GKm42Nie2xhlgdYGB7LcsoWyOYvc7GGe8Gca
	 /3zyilDJuASkg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c1479a959aso1462268e87.2
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 12:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGDU0SIozYufdVIvCWYjS2q4D9+bmovtOzYWjYcmzaa59TX+mmbdCDjQ36QAbPsUNxiAoR22TbZbtWYLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+GNVGMMgWulDsvv+DMoGLcJSdEzSSRbcx0zpxUqvEEA7c0GrJf
	/yBQRxYMXAaWiv/mONCFj8OevEDrNoT+uFmWx4IhfzVGlPPyNmg5ARR4BZG9900xi6zz/ZXAsKc
	MrgQWj5sC09OPk77s60HHsZOTPZZa7IU=
X-Received: by 2002:a05:6512:33ca:b0:5c1:57b6:5ffd with SMTP id
 2adb3069b0e04-5c1bc552d9emr2306559e87.0.1795293609072; Sat, 21 Nov 2026
 12:40:09 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com> <20261112064957.1796975-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112064957.1796975-2-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 21:39:57 +0100
X-Gmail-Original-Message-ID: <CAD++jL=ww5ujTR8rL8htZ6APrbKqD0K+N6J6-LeMZsPSOhUtew@mail.gmail.com>
X-Gm-Features: Aa3M54rUPZzCG9ojMkF6fiFvoquOOcY_PUVJLfl5nrRmYMblL1z9xSrx8VOuWKs
Message-ID: <CAD++jL=ww5ujTR8rL8htZ6APrbKqD0K+N6J6-LeMZsPSOhUtew@mail.gmail.com>
Subject: Re: [PATCH 1/5] Input: ads7846 - drop platform data support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, Kris Bahnsen <kris@embeddedts.com>, 
	Mark Featherston <mark@embeddedts.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-input@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 7:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Now that all in-tree board files (including board-nokia770, spitz, and
> db1000) have been converted to Device Tree or software nodes, legacy
> platform data support is no longer needed.
>
> Remove struct ads7846_platform_data and associated callbacks, parse
> device properties directly without allocating a temporary structure,
> and delete the unused header file.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Good riddance!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
