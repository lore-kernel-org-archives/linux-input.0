Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F3446AF2B
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835301; cv=none; b=gaP1PpbL6y6EujNERaViZyrm7Bx3UMO/FsAY1TlE2EtwLgc0JdUED35qJ1he8pLDlbYInLUCCpq9T/Khvi4fN+4g6cAoFzi8zJo1XRJZ5/SbKuyAj4PUA7KALRvydcIBXzGb23MetdMfY9nskihdYqjpTqJuMhAs2hukDv3qlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835301; c=relaxed/simple;
	bh=y9uuZkEeJae++MbeR+TNLsbet2X1rPdv40pKLNu47dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJRDyFKXmPL8YmauhbDHW/++exYEGNEvugF5jVbbvVFEkgN4XL2oHRf7/+aDJBz8OLw8kdjSr0JqOzS/VZzP6tqZwfC9HP+5q4gW1BGiG8IzB4oDarcLLKMsJ340LpCuKKNIPQBkZDjDLhINuLZEN5tDaQFuxN5eKvNueBf4YPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-967327a0c7dso569488241.1
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 09:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835296; x=1783440096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqnNDF5VKQ+E0vRBcJ/LtO+JWbWwBxQUs2IGvWvjH/Q=;
        b=FDZHfut8/GtGEc0uoZ7fanFCrOHB5lNeQuNN7b6EzdS8XwNBFiHGmft57S9KwAwmoH
         XsKDrC/nm8rp5TX9ky4iZg9hsLrSpziIZV2M062nIDbaJS8hVan6QS9/FKE/w6cgq8HS
         NP4gJA6klZufm3uJHT8VaBZY8uCGMKx37d62t4ykV/MIdtAGh2Y2pr+vR7zQnylF6H4C
         HiUcQ6etdRZE+XIpsaY8q1jMWFm0J96NeiQfdzp/VnRRaCMZFCchvmVs1Dy4osa9m0/q
         YD3wsZEwFGEGOQaZN1KqxP1n3cUA+XtmmMvzgxzLlH60zkhixn/hW9qAI761MaLVe1JL
         Azug==
X-Forwarded-Encrypted: i=1; AHgh+RoH6jJSRFh7SK16seDu2kn5um/hqRPqaF4+qv71an8niep7k+2rXdPDESA6HwXZubmw1yrN+vqdXHvYeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUZDdkzixOdIn0eqy199+omLlrMmKFw5oqQ8lVGN3SNy9I4Xx
	emjgzQnoNX0hYAFl1thL9N311EOU92O7mscp0R1HEfctR4i6bou56x5PQTBBsKhnl/I=
X-Gm-Gg: AfdE7cm3RM6RXgEYhIqfC4u00io26vi6u6Ew9i9wDPCS493/fmWvhCf1+WddQN1JSr3
	rRiHsBM5FSRNkUwasrpGekV+SKAdGVBjUKDz7nimCbJXjc2mqRduNBqx9iVpRp4tIXINZdwbUzK
	cJN4r1i+DIgl3jaa+YGniARRzTZliImatEvHvyUQvvRKqmdhZvtOuuUnPsIaIItwWBPZv8emlXu
	I6nZYf4UiEACviTeeuGot9gp09ZX0uo8/wnmAA+Ul9U5YpRl0AOMf+Hy3qXfcI8JlE+WzC7KBno
	SGgHLNhUK2WKQiB8Q7WcLaTcypbyQdv/cCZaxd90hFbBxaxg3Ta2GSrcYjNeMNGdLy1HDRiAf2A
	myo93tggdzDQ12yMaoOJjDtcBQz5Ytyk0vdm64V3zSPt/0TgCUq488bn5mDecEcah8BuSM6D/1i
	lvd39hnSk+f1NgrGEPlK8BXVFxHCvYAHIyTXYdS4sXw/uN5PvfFQ==
X-Received: by 2002:a05:6102:6c93:b0:73a:9949:df89 with SMTP id ada2fe7eead31-73a9949dffbmr869096137.24.1782835282175;
        Tue, 30 Jun 2026 09:01:22 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-73a83e27e6asm1376450137.8.2026.06.30.09.01.20
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 09:01:20 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-967327a0c7dso569430241.1
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 09:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpCc1y+iNXklNItJZgIYV3oViCV/b3G8Ic44J1B47t1L4wWU2v7pw/NIP+H6XrtLLkkWU5QonUC6E30jQ==@vger.kernel.org
X-Received: by 2002:a05:6102:598c:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-73a38838db6mr1792608137.20.1782835280090; Tue, 30 Jun 2026
 09:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org> <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
 <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
In-Reply-To: <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 18:01:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
X-Gm-Features: AVVi8Cc-rLKbwzFvmIKs2_rpHMNLxVULzvudUQINxHMw-KOr8IArAqRSnLCM1D8
Message-ID: <CAMuHMdWhv8i6tkmOJU_ee9LAV7mMcQHe9FXgqTHCjGiEMWvn8Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Andy Shevchenko <andy@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 19:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 29, 2026, at 17:29, Geert Uytterhoeven wrote:
> > On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Most remaining users of desc_to_gpio() only call it for printing debug
> >> information.
> >>
> >> Replace this with a new gpiod_name() helper that returns the
> >> gpio_desc->name string after checking the gpio_desc pointer.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> >> --- a/drivers/gpio/gpio-aggregator.c
> >> +++ b/drivers/gpio/gpio-aggregator.c
> >> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
> >>
> >>         fwd->descs[offset] = desc;
> >>
> >> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> >> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> >> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> >> +               gpiod_name(desc), gpiod_to_irq(desc));
> >>
> >>         return 0;
> >>  }
> >
> > Before, this printed:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189
> >
> > After, this prints:
> >
> >     gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
> >     gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189
> >
> > Same results for instantiation using sysfs or configfs[1], although
> > the latter does have optional support for specifying the name.
>
> I wonder how many of the other instances have the same problem
> then. Would it be appropriate for gpiochip_fwd_desc_add() to set
> a name itself to address this one?

I don't think it would be appropriate for the GPIO aggregator to set
that name.  What we want to print here (for debugging) is the physical
GPIO that an aggregator's GPIO is mapped to, not some consumer or line
name (which is not guaranteed to be unique).
E.g. "<chip-name>.<offset>" would be fine.  As gpiod_name() can only
return a fixed string or an existing string, it can't return such a
formatted string, though. And consumers don't have access to chip info?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
