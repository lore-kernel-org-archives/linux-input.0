Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293719;
	b=m2zn01DHbXY3kduFv8PxESsUSpV7AGtTpX8T2m0w9FTCwmpYXCbnLk4BWuk7O/gbLg9t
	 GgQV/eqjpJq48U10hXbBRYPYrJs0RNPdv1/Ze8r4GJt+FrUW0ExtIO5SmrmWcmvpQA31m
	 NeVNLpXxn2kMTrt3Z7+JFPx1h7ugeleGf3kAvPwDtBnND5z/8+4ghYFDOO8OVovtTl5D7
	 uAJ6HaNpOK1Bs3OGaXpt/Jw9hnTYHp/784cNhsVnXxYtTxR3KdQhkV2wNekVbKGGralDU
	 4eCB4yARtysRC7giauA1dP6LJru/F9IE6dpUy06lvDkki0Qgi3DTSvBtW1oFXeY5RTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293719;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S0KEtbQt8GRBQii0toPIaQocuYt1n+g/sLHZS8pvKLk=;
	b=xUUdxQoglhtE7zd8drmQrvxK2bw1m/w5ziw0kkgB8nnukab+PglRvLebHas1pIoDW6Wo
	 Yj4Qa/OveKaCf2sWVz7sM142nYGgEeTPVY+Gptr/5o2pYOR7CsVNJx1JPpcjA/TH7Uamn
	 rP2RHZxsEiAo4p0wcJelBMaBPAm9EalZ2EHGuIRrgmwB0joZQpFNeonqfhXtx18yvWmyI
	 hpq+mW+dAqXshcv3ltMLXCe8DZGXkqiXHGBPdtFMbj16BRmDBzlxxencJv43V6JIq3rSc
	 auRp53pv/x54aWgmv1FLmHkJx6IzICVYLMY2ENDQKOqUAr5PitX8GnKAigNuTfCV59w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tzy8D86J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21E606A32C
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tzy8D86J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADFD1F000E6
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795293718;
	bh=S0KEtbQt8GRBQii0toPIaQocuYt1n+g/sLHZS8pvKLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Tzy8D86JZar495yRQAG/65mVNGhyCfKZ5L+iBZCJ6QjFgum36aHL55ANEzOtPPdam
	 I27chwcNdefUyX2zCTZS0nPR7luaQk5V/m+NJgvbO0DmYUlGxykZue07+Lfwz5/x/O
	 Lt1coNjQvqDM+FNVRngzpuYv8VFp+uvQDRkZNOuZ8rSaRp29eXMp53mByE9daw0KRe
	 AkhBeKePK67El9rbzIZkcjp/DpqqLU2UqCuO20+W9HCxpTZwrGWRpiVoKjV0J6PWOC
	 +q2K6mauqv6d+Hsm6J/05vKBfV6s0AVUmo8J5djhkQqYaA53Q5zfi0vNkBePylYU45
	 dQKCQqnJkfkcw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be4fea434bso3002005e87.1
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 12:41:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGWaCzuusxQXctCXsti3FcoP1v22oVzDQ6/mHQekyrCloK7TvbKuCf5TVyEiGJGU9al/x2vj+RxxvN6vA==@vger.kernel.org
X-Gm-Message-State: APuU4Z86i9TPvSxzcJvp7pluU8GpSaakND1gQT1hHWsPdfIuv3ytwFGd
	1WSXlAmklQhWh4hdckemO7SEQD5kIUzsxQNl/1+RBVdIEz7vAG4P9aeyXRMJ/e+TtHDoTyuWYYo
	9M9ao5bK9RYt0ccYRSYqgVnpirLoO+LI=
X-Received: by 2002:a05:6512:2c9b:b0:5c1:ace3:12c1 with SMTP id
 2adb3069b0e04-5c1bc575979mr1899458e87.0.1795293717533; Sat, 21 Nov 2026
 12:41:57 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com> <20261112064957.1796975-5-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112064957.1796975-5-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 21:41:45 +0100
X-Gmail-Original-Message-ID: <CAD++jLnRGBk=kQ48AiR8nreGH5qqmgPpG9seh9nRdhsoQAO2XA@mail.gmail.com>
X-Gm-Features: Aa3M54rjP1A51PecTmry92kFaSGq6HbI8P0tn6phUpG9qNi3VmLI5ZCflHpwjkw
Message-ID: <CAD++jLnRGBk=kQ48AiR8nreGH5qqmgPpG9seh9nRdhsoQAO2XA@mail.gmail.com>
Subject: Re: [PATCH 4/5] Input: ads7846 - remove unused code
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

> Remove the pwrdown_cmd member from struct ads7846_packet, unused since
> commit 6965eece2a89 ("Input: ads7846 - convert to one message").
>
> Also remove the unused REF_OFF macro definition and drop the CS_CHANGE()
> macro along with its sole call in ads7846_read12_ser(), since the
> request structure is allocated with kzalloc_obj() and cs_change is
> already zero.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
