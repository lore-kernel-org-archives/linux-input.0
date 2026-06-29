Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DB7423A74
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747460; cv=none; b=gwD+VlEX1VwuNH9KDq1KrTPsvkWJ2Swtxuye0ih8bGJxOkICIP2/Rk55Ich7BwuVTaLZ3FhwNFlIdy7mK+qvDzTCWccGbvEw/oUUoNpSAf7P8Wbidk9kwzW83Bob3W4Xd1FkdkMiTuLGn+05WPIPjL3LiMts965cLyjmiHFrUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747460; c=relaxed/simple;
	bh=BODU8nH72xA0ScZ+HzwpHMr8UOUoOL0Z1xiarATGzqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxXO1HqPsm8cEMSp1npxi7+D7Rq8qtOGbxhgvMcjaGEKjYw+KvtW7RhbCFv24CVr5o35JNM3BwEvT1sdC+UHBORBdQ7ISwcO6BengYroxLjPDSkSajL9G9hKO2BxXXKiFjCYdGOyzFhYVJLRaAg/+1HtQ/kp4OB5+bFUjb1bVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so6688218a12.2
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 08:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747458; x=1783352258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PSkrSvBcOj2Vfr1tOG9HdESUGrp+uU5X3MHl1xNqsM=;
        b=rkiyFy91/87zOE7iuQvjjhl57b5Xjix9elxwhSkmK16Pr3zx9w1xkdRJom2zbnyTai
         1xebrANUd1x6k8BPOFmPf8CdCMZt3uQivCY4rSV1+5L8E9R/SAnVb3RdJ6r/fCjluNKe
         NZvCzx64TvX1XjwwRwJduYThp7FEVLL5CVEGf+prKnlmVKLglpNNwD0BUDhc4JVN09mX
         f6sETEAshY6zzsbZ2maeiMGyPJJzJ5a2ri/U2DIZTe38wCadj4gum8Jn5aoOD6TCHVAc
         WGXy3gV0oueT7rCE12GTVZQ2CrzwFoxnqv3q22KAS+70jEY0R5WX7hrTsR+V4+9Sfz2r
         HY4w==
X-Forwarded-Encrypted: i=1; AHgh+RqMk6jxBgGTB91zY089ra/p0nVd4m/ewQKl0M3ClApHcJVf/cDHRML4TWLJHyJ33djU92tK1cW32SoZtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaGgQsQTCasIP+6dpOCAuCQCPTPnTBcajW/QUBk++WxrQpEebd
	2s2GQXEG3BN1adYENONQnRJNJdDmffHyKsc3hy7MVvdfiTcPqcmn2RZDA4PQcR9+KLM=
X-Gm-Gg: AfdE7cmLLtzVGcHCbWrTS62qN6/jUIBqPfN3oGz+xeWi2CKRgV8MqVNK9EnKfnaZN3V
	ZTFj851qaKhdsq2qlqt5v8RlGk6dAr3GjemdMxEw89qKhcTCcXNptiw071/f13tVeELG7+bqlv6
	xms+/nbKxEwYmpFbz9qPJoEUunlc6Bb7LqkO6oEeCzgKPNjWtx9dHB0FgIbRyJoI1VoqFy7GJ2C
	PYqhhkCJUS+vMrWWpXnXiS422ahKlAxzDvOqryAybAWC2tWR0ttZPH8CynnKb4MD6oxT53M58R4
	FsWHOsTD1F+LchViLV6rTlIaXra0CuA5msTujs73jJZ7UamTS0LOf/cXU5TerSAvTHYkHs9KdMX
	MsBNIJ8JUIX3opdS6wXhy2FKffdzinAcfqBZGc7mRkjksh/XyBT2oitapV9MOdZ0J/+KgiKkNpJ
	zKj72O/e6NyZECROsyHF6m0k5+Xl9JwRUmMH0WscO2wW+6ew/Mg+kDAMY/q59a
X-Received: by 2002:a05:6402:d0e:b0:698:f7d:4e11 with SMTP id 4fb4d7f45d1cf-69810a17aeamr6614195a12.1.1782747457865;
        Mon, 29 Jun 2026 08:37:37 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3aec1a3sm7243225a12.11.2026.06.29.08.37.37
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:37:37 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so2607931f8f.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 08:37:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpwJzK4ErjNG0slUitSOLzovDZWBgCsnYy0QS5qcNCD2GIG55N3xEz4HNw9CJKrlm/84wX+6ORKW/SV1A==@vger.kernel.org
X-Received: by 2002:a17:907:3c8b:b0:c12:f84:85d4 with SMTP id
 a640c23a62f3a-c120f8487bamr796791266b.24.1782746977928; Mon, 29 Jun 2026
 08:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org>
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 17:29:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
X-Gm-Features: AVVi8CfSSg4DcoB7CGCYddSfqoWpUaOwYUjpkorP-3LR7U8E7vJ9ucbePhiZLD8
Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marcel Holtmann <marcel@holtmann.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andy@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most remaining users of desc_to_gpio() only call it for printing debug
> information.
>
> Replace this with a new gpiod_name() helper that returns the
> gpio_desc->name string after checking the gpio_desc pointer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> Not sure if this the way we want to take this, or if the gpio name is
> an appropriate replacement in debug printk.
>
> Since most of the callers of desc_to_gpio() and gpio_to_desc() are
> otherwise in drivers that already depend on CONFIG_GPIOLIB_LEGACY and
> include linux/gpio/legacy.h, only a handful of instances remain that
> are otherwise in files that otherwise only use the descriptor interfaces:

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
>
>         fwd->descs[offset] = desc;
>
> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> +               gpiod_name(desc), gpiod_to_irq(desc));
>
>         return 0;
>  }

Before, this printed:

    gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189

After, this prints:

    gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189

Same results for instantiation using sysfs or configfs[1], although
the latter does have optional support for specifying the name.

[1] Documentation/admin-guide/gpio/gpio-aggregator.rst

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
