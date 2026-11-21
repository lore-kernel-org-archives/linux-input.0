Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293735;
	b=BydtJmeST70S9PUpMy2JkcfMeSH7Wp1C80grq4KYu4Y9wZs6QQdHLDWaoLIRrSWC0kr2
	 QDCiPjJTj8DrXtbYXIXch4CA29rwmKzt3nME5Lfx9YRbEVJ2xZn9nYBoUamS1lKiuwAdn
	 bFNWjeNelg+wpwsNFL5joQe8BqY17SA+hYHxK9lCi+NL8wK7nm1aJP/CDydxLuKwW/0Ae
	 yluTsmPc68AD0kdWdbSEOhwDVtq0zipEU/0cAFfC/nM1qjfZNCSw/cDehBfntGswkbfL8
	 Az0i5HJxNV8GJ92RrFTWdMznTSy96gTVrFIyxLQH4V7ewjwpIjn1SkUT2k3wAt03mSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293735;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=huxgq6e9wHfksi/drVHaTC3DOif56VffXqVT2Ec+rYg=;
	b=LRgP8rBfb3xrNogrS/Ip8/bwR5bsD71VjlnY1R5j3XGJ9uXDKcuThhsVihXbHpmy5fql
	 83+j5tRq7MZ4Wv2qMi9tO+JG2e/ETR7ZKrRZ3Xxxx2rGLa57WbV0n0cGYpNHrmvV8EdL7
	 R7DnhmPR+mtmp9nLzfmOy7paDq3rFe/AM5VdDSLqrKyHEfinmalnXsr621/Wd2cDRljYG
	 2X4N4XSP9M3MZLAwiEMKE+BJRnByCpI8Zx5xk8RhiCL4mHjBIaScUjqtzIi2bmcLx42l0
	 iHK0QcYQa9lo8PtewqWMG3bc6TmXdV2DmaW268ohYJoLhs9EmCwfgFwW/PnIAAhGnyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8pXa9Nj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456B606A333
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8pXa9Nj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78681F000D0
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795293734;
	bh=huxgq6e9wHfksi/drVHaTC3DOif56VffXqVT2Ec+rYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a8pXa9NjEx9NQ/UAZAfVgt42LplORXaYyGyB/rJCfB0Lm4Psbmc1pcOUHjwOnRF7d
	 GEg5NlA5BGM/WsTZZdqoyg2a/wPQkspqE8g1fRMtGD9zbabrEHzFAv9Hwnelx1zYsl
	 hoxYWeYg5/x/whFzryOTt86Bz4uIyhJcArYfdaHg/AZuoFQvW5XBRbFdwSEKwG/igb
	 gmY1DjUP9V0DbMtMWS8YkKlOEvxukraKf+/7QxUSJfIWUQK/rYHtJWWe/eAcqGj8Ou
	 hvBcvD8MvGmVBFAA62UuwzZoyO9MBuUFmonrilpHq9DR10KWMn7pQmDId7LIGndM35
	 ryUMk34EJmVMA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bfbc67991cso1346765e87.0
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 12:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGNfWLxewUCxrhk2jt7T7M3maXLXQpRPDoJHSdspt5CmLFLVZCvr0ZxAXA0aXvPCqSSLH7+4bUQLD0FKA==@vger.kernel.org
X-Gm-Message-State: APuU4Z92v8qLaMsdB3PDSmCtYoyk371DwqoYR7sEdAPZ6yKHlF/ZCOjz
	X4AHGNjTfhEYtB8g9DWWg5hnXLNejSGeQ01pLPNFGO7kHoiJLk7NyEaHH43JU1Le9g8knJvwQrJ
	nKJ9Ypkt5GO45pPdIoS+Vfwm1tqtQwU4=
X-Received: by 2002:a05:6512:31c3:b0:5bf:dc95:3817 with SMTP id
 2adb3069b0e04-5c1bc7bcbe9mr2121267e87.15.1795293733675; Sat, 21 Nov 2026
 12:42:13 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com> <20261112064957.1796975-6-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112064957.1796975-6-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 21:42:01 +0100
X-Gmail-Original-Message-ID: <CAD++jL=u2okiCU12RV+nC0NLJEMg49CkhtPKOguapwXBpN9OVA@mail.gmail.com>
X-Gm-Features: Aa3M54q5oFmXwdWSrTxDLECj9BANyp03LDdetIui07Q3S7mayCU0UCP9cIWP9Xk
Message-ID: <CAD++jL=u2okiCU12RV+nC0NLJEMg49CkhtPKOguapwXBpN9OVA@mail.gmail.com>
Subject: Re: [PATCH 5/5] Input: ads7846 - fix minor coding style issues
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

> Fix minor checkpatch warnings and checks across the ads7846 driver,
> cleaning up types, spacing, permissions, and macro formatting.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
