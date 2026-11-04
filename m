Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797173;
	b=TOKkk8i8P/vNvY5oc7c6hiVAjjI380fsuquc9+lhph4avMFiF/DCtnQkVG5yrlwykDyz
	 qmDm3g+Sp75z9Uh8dKLpNCCmCv/FpRxRVmP/8YpRy7cBTy7YCF6hoGnpiGa2mTdheVtHE
	 9yEP4nLm173JWj7jop6uRYWLwuxV9lRI1K9VF7Qk88Cdfir4yhmMVGPzrp3g5BFgj/X4Z
	 2zbn6O/jZQBH8bQ6Pa84rukhArv12zA0lDJgxSzUm+Sr6ud+T5ublRMl55is3UCYy2dwt
	 OY93daXfAw2invg6HQQXme3+4YD9PvKLwmp9SVtTk0SgS/h/BEdMEWWv3QEsvGxHNYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797173;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FXIxVU2ErnALAGekxCaTow6hX1frtF5kYcG5ZZqHi8U=;
	b=HQSeiC3GkFzRqXh7arbtqnXPgqEsKFLqNqz1fCxTIWuqXpuSXPB4UBg2rVhnVGPH1rAo
	 04CJXSokRNQL4/Rj7Q7f9p/RXQHdwUMIAqguY1ZLcVrpzw51k1RYkbFz6TYGY/U9dAKaG
	 BoPi9D1YXIofQgo0SE89/E2HblgmyQoqI+Vkaaxszs4N9JCF0p6EM/AOe3eko2X3cCAVJ
	 5OJIHZN9JuyHs6fXmBHCO6frVjFhy/cITLT3V5B0K2BxfGlklYXaQVM6/ZEWG10Jg/Vpu
	 4l03euUyfhPogukHOJUp7yu5iaNVl5WjFI8DgyOpWbw97AQgD7+5TCCki86sB8KA9uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDFAnskj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C4606A32C
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDFAnskj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7C51F0093A
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797173;
	bh=FXIxVU2ErnALAGekxCaTow6hX1frtF5kYcG5ZZqHi8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aDFAnskjLaH9szPZ+eelP8i0JxzV/ADplIik6LrHEHu3VibxmCnue2v8685Le0+dK
	 cobUa9XuLqBS2tW+SnBCUvh8cQhdHgxXdtvxqY6d481KmL2ng4MFnFV/wR8o0C6o01
	 btC+5MRcc1xptAPJOMRCwpQXGVWkLgyO7aE/qFzQZmJnA/7uvOuTZ5cXFi4TtKRbdN
	 uQpNzORgEbX5APoBw/97Us7h3e9+6hbuS+tn9irYEqJKgjXIEhDnZGwPpRl8fw+BDJ
	 cMQ6mZyfqIT1yNPf27APP/9/R6NH1INYXZdj6jZY+QL5rJzmmIH1EVVn/QwwX7d8pI
	 Ffe0NU/NIRZ6Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso2106733e87.0
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 04:59:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBynQQwjwv8Rq3OLWYTH+/ST7Xaa6BJV+uTie+XE95V7MaTJSg/tUwlQ5WVf5gmnbdCYFaehG1N5rYX/Wg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9IV2MIRxPlPIv25UyHw8Q8uBEG0cSAA25XMc3kKzJndPLR7cDe
	3FDTPm7edbKYlks8B4r/Xq8WiBpTAOvTA+DjeWBCxC/5JtVX73fJQR39WbghLnw8CGRgfnYQG0U
	QGbgLMIJHBdUqrk7AYkWo5sNK4BW0AyU=
X-Received: by 2002:a05:6512:104b:b0:5bf:e241:cd4e with SMTP id
 2adb3069b0e04-5bfe241ce90mr4030103e87.13.1793797171870; Wed, 04 Nov 2026
 04:59:31 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 4 Nov 2026 13:59:17 +0100
X-Gmail-Original-Message-ID: <CAD++jLkRkeftTeknrSVT9MGqA2Ep7rJ01eW+s2oFw2rj+h5HJg@mail.gmail.com>
X-Gm-Features: AclHuK9FrROF_lbQblFxEWPuulWTuq7jZ-GLjM6cpqXKsEAap45D_vvWiQC8Ya4
Message-ID: <CAD++jLkRkeftTeknrSVT9MGqA2Ep7rJ01eW+s2oFw2rj+h5HJg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Input: soc_button_array - use resources to set up IRQ
 info for gpio-keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 3:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> In preparation for transitioning the driver to use static device
> properties instead of platform data to configure gpio-keys driver,
> switch to using IRQ resources attached to the gpio-keys platform device
> to communicate the IRQ selection.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
