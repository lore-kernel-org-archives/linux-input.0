Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29C126C02
	for <linux-input@vger.kernel.org>; Sun,  6 Sep 2026 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715357; cv=pass; b=fex1PlGVmAtMg/ur1ecXVf3kMWU3a8TsFhob3+LB7zbw58x3Syhlwg0mP2dM95shO3OMxJDPqsiFltCeSu5hTqqWRDDRnEWxS1CJE62MZzltAr+HybJoTDZ+NOWi9MlYzLxgXkXbCQOrWQnFbnULIjgrQw2qZDPdx/5VY+l7MfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715357; c=relaxed/simple;
	bh=xlfHTmswkSpLXO/4f4jYBhuVejOLiGyJyM/ej83cLuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYHk0WogGvf32QVUyGP/FHdzhh9NiuZCXc/TP7SjsyTSUm2GepXqb9+4NwS+SN745GiGRnXr89FN8KRPWiyXuDLkZj2NJnJmFsGuey7DvLwm3vaBoJJGZfqHvnq9wNBtTjdA8CBOj6T8aq7r8E1aABgT18dyFJS7wrziWTxmwtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTvN/LN1; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTvN/LN1"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbedf433a99so2775937a12.2
        for <linux-input@vger.kernel.org>; Sun, 06 Sep 2026 10:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788715355; cv=none;
        d=google.com; s=arc-20260327;
        b=r0ltGOS/pDPxQdPEVnyRO/taUBHl2rtPOYZqctRGOBbg0A2HjeVlFeCzOEr3VnGVoY
         RhUW1xT/8lezVeplMKs2dyta0h+Zm56jUm79cGYgcXWfa7A3SpROkX1v06uRWaZrH+Vh
         8IrnwALKl+ZDkjLRpy57h9IzcSZQeiEN1x9MqvACGbo+DxEenzOtMqCB0Xt3Vrl1a1VP
         3ULTihjEUdDljZ2xy2/UQDDAy5kE4APfUdeCy5xgcbHeC9mndi8uTbgkqAPfKt1M/IpJ
         IacSl8uuYFzjQHDX+bLcXjoQpXyfOWVBAlwYcR3/IeJeeEb2BfTjPQR1GTiLNFDpVY7s
         xqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F+vIa+Qy5L/8ukG4yH01NZv4BrUlQHr2FP5xxn3kwXw=;
        fh=yS+7yUupvH12ejUp+zydmKv2mMixbaCC/iWw/DrZZdc=;
        b=abebrr9i70NQjIJEoRsqe3pf9IaqTqQKnRO2ESoEgZzhmZ1uZsuPqA/usnGaNoFjLJ
         XzrMiCrW+O6oD35tlKZDswFJuoXJITJg1qOlRp8oIwFr8f9+ZId0FFGog85zGWQj5s/x
         KZ46TUryM+dhkgTCbVzjl/4E8AW2Ia9Ak0aloiYyey6p0glb68woM6ZzMHF6G1TFm562
         VpHLtfW8TLTyaIe+4hXeUBq6xW5oPJrtP80cRsPHrT6fT4OAwhvSdclS5BITsQhbbkGr
         4fncZxDCHgbZkf/T4OsxNGgBqT8fvm0WBDBsPySB0+pxzgMDgQiN7ogH1M7+YA4VcmcT
         m75Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788715355; x=1789320155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F+vIa+Qy5L/8ukG4yH01NZv4BrUlQHr2FP5xxn3kwXw=;
        b=DTvN/LN1EdaERFqCd/Pf18xk3C2W9zOejXGnr4Zon7F3zor5rZQ344+GQ1BawH8Yia
         oxrLD6jEEaJ3VX4H9A0LkI7AjDZUBT/QzS5oBGB1SLqzR9dFcpoQQwfqMFrTwPEZaB1P
         0m3rvOHTFdLh9lLU4yfbJxyweFX42h5JIcRnl9ozmPY9sAFcxuGYjAFBsARs2CATPDls
         EhZJEkWhdvjriIJ3fwyBDu21MkwGTZDYmGjDktjCV4tKkevbckt6Pii2RruUjekLWGsV
         lYM1DxyvWC7EKZK+Cm7hvHm3hx8cVCRAWMfHElaWUrYSGogaVhj9sxCmEemyKJdrhxYS
         hjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788715355; x=1789320155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+vIa+Qy5L/8ukG4yH01NZv4BrUlQHr2FP5xxn3kwXw=;
        b=BUFE/YGlbLRNFdEEHhJ6eoQD0D8+w7K6PEKc13dwlVwAjy7pf0pfOC4TFmokGUm/Kk
         aKIkGhZ/CGa14Ih2NJLT/eoHXyTwzirMG/m6z6nNrOD/TFiyox05bVZ9tTh1nR4Lunxy
         QKiFuAT7+mcdPFfsb2B/XRLbNW+sqVEU4BN5BTWc86vTwKSf2ODVkZn0gy8nfQQZ3BwQ
         m0dva6hdZYO7kcN4EV30jPmCXuK7k73/2pYLED4CXUrxBrhjMDIiUfKLF13SPMSZ4R7N
         u3NtS8TyV1hU4G0m17OzEFiVGim9EA1xxBOhCKhK822yrTBQDGn7IXWp3Wai+OoUFf1s
         yRQg==
X-Forwarded-Encrypted: i=1; AKwUvBzZc1TfcELkpdxo9VZlGQFAMAB4OUB48uL9cj1vB0OyyWZuGtkToh9L+5olJUXt7EORiYDR6xdd9XV2yQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kz4wwFeuoURyWm8AdP7ztzsqDnKQqR3cf03a+lLs9FE1Db218K
	SNb4s6iueYlIovaDeiEIUmuwGBPvPPIXV4tJ+T0eMlc2Cp3FdzAKSvYKZEKzLsSYA9nMele/4bo
	XJwVD+HZiPiHiBSqcbl/ULJDm1JrCOIA=
X-Gm-Gg: AYBFou2QFRAuMc593H/iymFJ2KtAaGuvdM9jwEgN1+XvOeRplbUoN3MCgha04EQmpc/
	H/o+NvP+VO/M8ufOdJwo6+vSp1gyC0Y8HekRRyP3WtE1do1jM43mzmfhhTXzikHa04rqwHORWOT
	iVHUAmrHxq5nz6bLcQem8afC1o722pWDx6Ef7At1p8ZWrLKwB+M4KP6kTDmbvutLrImHe495HQO
	kxbg0iAmxFd8t6ZW9cNGlZkL0JRr9kMAvnUQeSS9nZmO3OSeusjmL2AT8aJmYZ8nocUQvbH4PCa
	QXv9UdTvGAtsyJfXZIN5QgowWKIrDLcBGcfwXxB+fN9e6+exUU6NoS5aGY7Eh/5pj/QWDYt5Tu0
	2lQ==
X-Received: by 2002:a05:6a20:e607:b0:3d3:ae50:97c6 with SMTP id
 adf61e73a8af0-3da3a154de6mr29258954637.19.1788715355297; Sun, 06 Sep 2026
 10:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260721095233.420823-5-clamor95@gmail.com>
 <CAPVz0n2rhZk0fjM06u=C5H4LgVOsN6ACriO1o+byx0dyqTwGzQ@mail.gmail.com>
In-Reply-To: <CAPVz0n2rhZk0fjM06u=C5H4LgVOsN6ACriO1o+byx0dyqTwGzQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 6 Sep 2026 20:22:23 +0300
X-Gm-Features: AcwNN1XDTtBNxGlzLOpLQ3w1y2Et6HgHVsvlBacLuEsWHZNblAyHEWGt7R_cBqA
Message-ID: <CAPVz0n2mzwp-ffUu7tw5ojXgM=+G-PT3V9pHN--dT=dnYw5hHw@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 19 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:2=
0 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=B2=D1=82, 21 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:53 Sv=
yatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Add support for multimedia top button row of ASUS Transformer's Mobile
> > Dock keyboard. Driver is made that function keys (F1-F12) are used by
> > default which suits average Linux use better and with pressing
> > ScreenLock + AltGr function keys layout is switched to multimedia keys.
> > Only Dock keyboard input events are tracked for AltGr pressing.
> >
> > Co-developed-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/input/keyboard/Kconfig                |  10 +
> >  drivers/input/keyboard/Makefile               |   1 +
> >  .../input/keyboard/asus-transformer-ec-keys.c | 310 ++++++++++++++++++
> >  3 files changed, 321 insertions(+)
> >  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
> >
>
> Hello Dmitry!
>
> May you please take a look? ATM only ACK on input patches left.
>
> Thank you!

Hello Dmitry!

May you please take a look? ATM only ACK on input patches left. I
would like this patch set to move forward.

Thank you!
