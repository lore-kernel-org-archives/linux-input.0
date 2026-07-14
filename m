Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0747CC7A
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037799; cv=pass; b=ZJRRKkw+7GtavPIl0JaApTIrI5tdAIN1I2duLGbfFS8iQdE2gQwUkNIsBuU6DyVgC+2lQk/DDpup0UtrS21KLEAnUDbM1tek8wG+Na5cOlvXv1qTgZ/t30/2MABC0LM1sWDqzYTtsmqsCf+QUQagGNtuHMLC4pGEcKjMsL2zdpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037799; c=relaxed/simple;
	bh=jcfCE/0TEkTsIVfXnYBhBH66bO22mTW43lzd2mIpj78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tg2hKmDKv5xk/mEIsFnkD7jNNGfAHoVgNy4/mIhQse3BK74G2YcPeK+vOAH2A049dzN9P2VX8iS1QpnzJUIbWxREhdRjMJ16ej7Smk91TFY3K+WDAaFpDlVTknszVTt0mmQFjM4irp7r/ocIr7HqZ9uxuZxUt0/i7P8i4VbWZbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAK2SoBn; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAK2SoBn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso955309a91.3
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 07:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784037795; cv=none;
        d=google.com; s=arc-20260327;
        b=PFSqVyx74H+sLcS6kQH5p3XjDY3Hp5kBqA3C22deMnWwvv/XwTkeEBXBStkxZdcytK
         FdVE/Wbpca2IMbrqI4pX0WG9EXswJPrhNw2bNEHy2sIriJa10cQ1ONdKjW0edgSX43Ay
         7BPtf6AOg10Du7ZXLOgKlYjsHc4bUlXM3Do/Vi7j5U2uhb+zYUoC/CK0+m/f+o58gDkS
         dMGqPrLbjLdPxTe/B5ex5zR/tB081dVN4MNTLp+3NqXwMe1rrmXaXdfH0Ddpksf35vHW
         2SdzuBZRRsKj7mfpNdsOo+VswjWvbQrueB4Z8AU6cuyb/lEnF8oDYM4vZITq7yQbbl+A
         kp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=myF6T21RyLYT6/CfTBKwlhYNyiiPbXPGvaRTBJcI6ZU=;
        fh=I4hKDtd00YTKLoD9sa0aSlUtOSjvYuuCfiXJ3e8ATXE=;
        b=QIJiZKufFXoGtnDj9IpAQpJIjhOjVjtA7If/LH+3AdsmIyqYt8b4F8ciffZRgZ2hul
         HsZ3BWksCVBUtet4az10RHA3rwUWrSIEii2kL7vlKg71VR7xb2u9iJegj06cnVAvxYnM
         TlwmOosdaeieDspx6xVdiSF9BEOwlb7Lb7CpTF30fgymplg2ynUyxgo4X2RxTs1Ajf8N
         z7g69DQErUYGLIY+R0RpdLkv+v0ayx96B2GQ3S/NKlc+GzI27eUtx84QAvgLOjZLgYwt
         ccAB1JnBrkQpFXhjUCsNzuX53N20eKedkSLInJk4TLe79yrT88kTo7pEhVU6+peANG4c
         /Z7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784037795; x=1784642595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=myF6T21RyLYT6/CfTBKwlhYNyiiPbXPGvaRTBJcI6ZU=;
        b=lAK2SoBneg8a79IZxLlhDsoAc5s20dBKXYEmWxNqZbpTv1QYHuXFFTg+NoFNbGZt2D
         UEVjkRmdqrTUvXv7NUo+KyP47BDLcu4h6ndNAWy8SpgCyMfHyAHNG4l4y3KQQsVM+NfO
         y3AuDDKNqrG2ji6rSNU4GXaj318V6nIpTK5NE9HzDHEqubMliMFQ/6DYBUTv7cRfhVko
         3hLr+lBtOX3eNCTXc2oxsUbuLs3l5I4wzeDq7R6fv1ZZeVGJqY1ZEmMy5Km53CIK2+gt
         sR/h7Ue36rW6UZW3hnySs1O74EAPlLqb2jBd8DkABTJgXXntJDpmIPLfyks3ke+Fgy3h
         W7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784037795; x=1784642595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myF6T21RyLYT6/CfTBKwlhYNyiiPbXPGvaRTBJcI6ZU=;
        b=GP1CFPBnrhIc8guUJHce04I37VGFeZirlL0syEd7oRWKeWtOIgeaLtyqL0SmpQuVmB
         a6t8HvTQs0JbHdhvvpjqt7f6odBKXJMvb1Fu5VwipI6QyPaYM+etW3v+q8qvjpINS1B5
         DrSdXRUol5SOyY1UmF11GCUxQUIE3MY4ezI58PXA32iTvdqDCdrVaWU8Iyu2WhC2HJNw
         UJqfLcp/25XAbVC3hiy7kbVZ8+30elMnrtJ9egzwJJivY8oZP9hOuZGDE1TsgZnVYAMa
         3LqWrLM71e+TuEMoqtdq0I/GxfmOSbETWUzRmIW7noUTW0+rz8GjtD3P0UMyAURDUNQ0
         riVQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7OqItcduSN7nBYBOEmKufCWVXrYb9+E3DjRSoF3tALdjQMM8wCLZEm/OEmIKW8oLtj5etzqusBD7g7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpn9QDeqyBg4D027q2cALzFNCfOUXv0SvcqnSScxbK+3dy4pua
	4pJn1c/kZxw8u+9XVkrk7tXsQdVnvh4Vnl1uNfXaz0aTwy6DMYc1eS+kSBZ+VfKQUG6bmIX57zk
	/bv2Q/aoMIPmXXv8XT/6ZO9Wr93sMvhA=
X-Gm-Gg: AfdE7cl1j8X32cHsoU7KREF32NXq0SyVNBiTHoaF6YMn31mBezUujK40R6xYSybj5f4
	nGoCUWnagO7sRi+K+hlDoBWJLrLDyDaYvzVQ6CXr5WS8mLJEvCkQot8R7mAQVsYcFxCODcDd1tx
	tW3N1hzkXKLPSVJCwahnrwdc/21bx8l+ODQuHsJkGmNn7QKFYKO8TjV0GyQ1+1RamCK1s4a1+tH
	vnc8m5GDSJ71mJAUjiNln5C3TNsJXEmdgb90jVuABRlF+S4wvaLKpGiFKmNC35PZ5u4+TgVgRx5
	L5xwALprCjQRaH5BlpAbTSctmkkhAA==
X-Received: by 2002:a17:90b:5863:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-38dc73bcfdfmr12462942a91.1.1784037794156; Tue, 14 Jul 2026
 07:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625081529.22447-1-clamor95@gmail.com> <20260625081529.22447-5-clamor95@gmail.com>
 <CAPVz0n1o+2NRQrLfbCMT0JdeFhhD4PS4UzSt3L6-QQ2ywHL+mA@mail.gmail.com>
In-Reply-To: <CAPVz0n1o+2NRQrLfbCMT0JdeFhhD4PS4UzSt3L6-QQ2ywHL+mA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 17:03:02 +0300
X-Gm-Features: AUfX_myvMCwvq1yA3I4zoSr0hddrF32oflvRuyg70zCnHs7uf8DcWagE6S5UHa4
Message-ID: <CAPVz0n3FkzoXJBffsOJzd4Rq9HmA0n1oFCU-9Xt=URmpXhY2UA@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 11:53 Svyat=
oslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=87=D1=82, 25 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11=
:16 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
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
> >  .../input/keyboard/asus-transformer-ec-keys.c | 314 ++++++++++++++++++
> >  3 files changed, 325 insertions(+)
> >  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
> >
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
> > index 9d1019ba0245..913cb4900565 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -89,6 +89,16 @@ config KEYBOARD_APPLESPI
> >           To compile this driver as a module, choose M here: the
> >           module will be called applespi.
> >
> > +config KEYBOARD_ASUS_TRANSFORMER_EC
> > +       tristate "Asus Transformer's Mobile Dock multimedia keys"
> > +       depends on MFD_ASUS_TRANSFORMER_EC
> > +       help
> > +         Say Y here if you want to use multimedia keys present on Asus
> > +         Transformer's Mobile Dock.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called asus-transformer-ec-keys.
> > +
> >  config KEYBOARD_ATARI
> >         tristate "Atari keyboard"
> >         depends on ATARI
> > diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/M=
akefile
> > index 60bb7baf802f..0d81096887ad 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_KEYBOARD_ADP5585)                +=3D ad=
p5585-keys.o
> >  obj-$(CONFIG_KEYBOARD_ADP5588)         +=3D adp5588-keys.o
> >  obj-$(CONFIG_KEYBOARD_AMIGA)           +=3D amikbd.o
> >  obj-$(CONFIG_KEYBOARD_APPLESPI)                +=3D applespi.o
> > +obj-$(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC)     +=3D asus-transformer-e=
c-keys.o
> >  obj-$(CONFIG_KEYBOARD_ATARI)           +=3D atakbd.o
> >  obj-$(CONFIG_KEYBOARD_ATKBD)           +=3D atkbd.o
> >  obj-$(CONFIG_KEYBOARD_BCM)             +=3D bcm-keypad.o
> > diff --git a/drivers/input/keyboard/asus-transformer-ec-keys.c b/driver=
s/input/keyboard/asus-transformer-ec-keys.c
> > new file mode 100644
> > index 000000000000..53aff3ce7146
> > --- /dev/null
> > +++ b/drivers/input/keyboard/asus-transformer-ec-keys.c
> > @@ -0,0 +1,314 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/mfd/asus-transformer-ec.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define ASUSEC_EXT_KEY_CODES           0x20
> > +
> > +struct asus_ec_keys_data {
> > +       struct notifier_block nb;
> > +       struct asusec_core *ec;
> > +       struct input_dev *xidev;
> > +       struct input_handler input_handler;
> > +       unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
> > +       const char *kbc_phys;
> > +       bool special_key_pressed;
> > +       bool special_key_mode;
> > +};
> > +
> > +static void asus_ec_input_event(struct input_handle *handle,
> > +                               unsigned int event_type,
> > +                               unsigned int event_code, int value)
> > +{
> > +       struct asus_ec_keys_data *priv =3D handle->handler->private;
> > +
> > +       /* Store special key state */
> > +       if (event_type =3D=3D EV_KEY && event_code =3D=3D KEY_RIGHTALT)
> > +               priv->special_key_pressed =3D !!value;
> > +}
> > +
> > +static int asus_ec_input_connect(struct input_handler *handler,
> > +                                struct input_dev *dev,
> > +                                const struct input_device_id *id)
> > +{
> > +       struct asus_ec_keys_data *priv =3D handler->private;
> > +       struct input_handle *handle;
> > +       int error;
> > +
> > +       if (!dev->phys || !strstr(dev->phys, priv->kbc_phys))
> > +               return -ENODEV;
> > +
>
> Hello Dmitry!
>
> Would this approach be acceptable? Handler links strictly to asus-ec keyb=
oard.
>

Hello Dmitry! May you please take a look? ATM only ACK on input patches lef=
t.
