Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E522364021
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238840; cv=pass; b=ugEy1LuVRwGylnwbIIOOOJJF8EtOW8Fd9OGVD4eH0X2/AA7MeMCDmxB7bZ6bnlgo78HE2IfYDwrpdSxzJlIQP3f+lBaHuUct9syaBwyC8XQMyDFjNbPOQF3p/CaGDyIpHt58a5ELY1Oxw3U8OXEYgh3nI/KpZTtzsueYAuntJrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238840; c=relaxed/simple;
	bh=XGZ6itGAHG/GC+y8tIx0hD5pNIjcFAkuMPxSNm5qrTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unAvdIYs/VZe3vuZedxm9VtR1GrtapfNLUhMEj9vFnTn+gbPXV2SfifNsJOcjr6/twpxEL+wFGDJ51uk5FCDYt0e3599VTaYKjVIw6WB28k594NMcFEpRMAyMv8yr8eGEJutpqo5TuEbgj9XJuFOXL/upWcqBuvCkXhGzz0tYUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpYQqgQW; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpYQqgQW"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f30a4601bbso2031621eec.1
        for <linux-input@vger.kernel.org>; Fri, 08 May 2026 04:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778238836; cv=none;
        d=google.com; s=arc-20240605;
        b=gBjtIleeeEnC5YPDI7BbvOpgQhnhwWWHPhTPHmRYgT13VM1FwCDqXpa24lQNTFkfwq
         XY3pxIEQKJQOBHy/+QPkFX4w3K0YyQom3dQ5dhfvkBDfD092YUiwbqB2k0734SLrVzDX
         bh/IsKBgLrNnXcRm4lht3eE2PdMNSazXXLVHTDoAPnBLQs46L7Wqzm6JJy2kaNGQhKvK
         cn9joeib0PIR1aR7awX43HxMfz7GJ5NEvF1xWsfwcv1lLnUiHCNiRK9wLNUI6DaKu8ol
         6sykECS36MAe3PUhdqJVkLlPMDVz2or/ZPfLluLai8tRgNVPpXk2LaOM0oMSmG/Te5ou
         HNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXvM35hoLnJ8gLhox9nKpSCWQqT2QyXjup63loF9EUQ=;
        fh=RSb4WTveq11rzAj3d8Qcz1y+PJXAMdyrumJ8DNm/GHY=;
        b=Xk6ePy8uu6MatMTISLjZaw7V8lGeGge7dKXPqAPiOveQu5fKyloX6YqGFpudjfMSll
         sFJJCc8acl+/54PsokNRPc0PYNA5cgCBG1kulxFp8tR5SA5Zeg2+hZ16mBxcqd8A4adP
         XFKN9XvefHOmCvOkZryMZ3HXjkM7jT2F/ab6KDHOuEnalsKwD6rJflrrvKU1VNTfn29P
         AcmbdK8NJlBTB7/RyXo3aXziSEGCwLSZMul1B6ekalihjI2fm5ZYFqdwhlcnhIee2rgZ
         zyL7rhfiv+/9NTMA+Fxy8WSuAHGoPBBab45RnZ+N0mW+DnKezOtuDSDVv941eieZVfIn
         9jlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778238836; x=1778843636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXvM35hoLnJ8gLhox9nKpSCWQqT2QyXjup63loF9EUQ=;
        b=BpYQqgQW2GC3ujXAtDHf2uqSpfRWcvmue8r1gGgMyPpT5Fxc1T/BhFUpgW18xkcfsY
         pWn1prTUkoQpyaW2xTDW1FvUWmTen1/VOtOtyR8Tttj6jIVWIEg4Sy3tJ6tIc7pW/3j6
         I67EwsZ07trzxBk4zCr75ByKan9QpAaDWiY7U6LsZv09sPCvgWUHrJu4r5y3HOtatBKt
         rLCtk1i4iH/CcBQr84SaoOtTCG8LdLvuICe8w8ekkCNRn6m3/2g5lBQjvXibrtWdL2Sh
         YSvV/dCuHMkH8aG2iafOogtwujejGKCV7cwlgqUVX34+WsVTcpCFaawEO1TE+Bn8YSKD
         rXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778238836; x=1778843636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXvM35hoLnJ8gLhox9nKpSCWQqT2QyXjup63loF9EUQ=;
        b=rDUE0BZI6Ed7LHHjeb7OlVcsPuI8dTFNTtwJb3wcikeYWqknTYRqN5xoS4Sowat6o5
         M+lDX7aYXJEcoN1zivZeX0+6PmLVC2uvz0bERJEEY32vdXnu/zTW2BIGP4E4DZxYFrY2
         LFqVKO9ktfysA23TIfskSvBb5M1aTgUXYoW2VL6mlFCj26O+ylQJnHzUU3o9b1basqbX
         QY2zLJriIpxb5QIpunj7Xz1MGP9W8/9QcvYnb8N29/Bq6y4YEuesOxm+vwJz3Z6j1Pif
         Qoof79JEVbipxz1CDPsjIxcoI5hyJ0QQi5s488ZKbds6zGBgNeAc48RUB9SAnBso8adV
         WfzA==
X-Forwarded-Encrypted: i=1; AFNElJ8fSN1ex45bgCNlZgFteghEbDx5aoaU3/JcJA5Zs1Z89jPNnZ6qJO+nmgdX/L2zhomMhJxZ6U54bz3p6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqnMOc7MR54XukeELaLDJPgzOPkb/4bvXt5vphhqm/idUJ4yKF
	W9VgB2e4fBjJsyOatOFH0/ROl+oyVgXxHqpxOYbjjAWTjk+aWawPh4F+K0n5h2wUq22iPiT/6nw
	/VKBSFZTSqUmEz+YJwyrBmeDk8wCPJsY=
X-Gm-Gg: Acq92OGFEreAXEydmJxNH7KjgUecP0uAocIqfABwjHaQzW+KqMV45nqeN/jJAKzncW+
	T5LndnKbGIYN5t0t89Liz5OA4BDC2Wth4Qe5dVp7legqIjjZWpfq377OwW3R1eLTXZZ3zED6Si4
	Mvsdwo4Xk1E3gf+CYEfwNoPR9U0vbIA9RNeyX5fO0NsscMLk9nPSXxhjd/KT4xClQA8dfAdKnLM
	i+PEcHr4fUwlUEsQDmYEszC6JEaCkiSXk+6qeCqDw6MZWZ3Wy9Ho/By1fr1AaqOs52bFHs76ahk
	O8Yvyxcxp2gxA+yYoSU=
X-Received: by 2002:a05:7301:6793:b0:2f3:986d:2d01 with SMTP id
 5a478bee46e88-2f54d79b94dmr4936134eec.19.1778238835805; Fri, 08 May 2026
 04:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507133948.75704-1-clamor95@gmail.com> <20260507133948.75704-3-clamor95@gmail.com>
 <afzJUcvQth6v9KGC@google.com>
In-Reply-To: <afzJUcvQth6v9KGC@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 8 May 2026 14:13:43 +0300
X-Gm-Features: AVHnY4KZZEeQcRms6Xprl7rHMrPeXHY4WASSgvU4i6TVxMIQC3mtzGuZ-6IRGrg
Message-ID: <CAPVz0n1wYMsLLzbQ=4HLT1+Cx8GoxY+n9Q0cJ=dYv9bF=piOVg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 7 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:26=
 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Thu, May 07, 2026 at 04:39:48PM +0300, Svyatoslav Ryhel wrote:
> > From: Linus Walleij <linusw@kernel.org>
> >
> > The ISA1200 is a haptic feedback unit from Imagis Technology using two
> > motors for haptic feedback in mobile phones. Used in many mobile device=
s
> > c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Be=
am
> > GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> >
> > The exact datasheet for the ISA1200 is not available; all data was mode=
led
> > based on available downstream kernel sources for various devices and
> > fragments of information scattered across the internet.
> >
> > Tested-by: Linus Walleij <linusw@kernel.org> # GT-I9070 Janice
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/input/misc/Kconfig   |  12 +
> >  drivers/input/misc/Makefile  |   1 +
> >  drivers/input/misc/isa1200.c | 540 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 553 insertions(+)
> >  create mode 100644 drivers/input/misc/isa1200.c
> >
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index 94a753fcb64f..52f192104ee2 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -852,6 +852,18 @@ config INPUT_IQS7222
> >         To compile this driver as a module, choose M here: the
> >         module will be called iqs7222.
> >
> > +config INPUT_ISA1200_HAPTIC
> > +     tristate "Imagis ISA1200 haptic feedback unit"
> > +     depends on I2C
> > +     select INPUT_FF_MEMLESS
> > +     select REGMAP_I2C
> > +     help
> > +       Say Y to enable support for the Imagis ISA1200 haptic
> > +       feedback unit.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called isa1200.
> > +
> >  config INPUT_CMA3000
> >       tristate "VTI CMA3000 Tri-axis accelerometer"
> >       help
> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > index 415fc4e2918b..d62bf2e9d85f 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -49,6 +49,7 @@ obj-$(CONFIG_INPUT_IMS_PCU)         +=3D ims-pcu.o
> >  obj-$(CONFIG_INPUT_IQS269A)          +=3D iqs269a.o
> >  obj-$(CONFIG_INPUT_IQS626A)          +=3D iqs626a.o
> >  obj-$(CONFIG_INPUT_IQS7222)          +=3D iqs7222.o
> > +obj-$(CONFIG_INPUT_ISA1200_HAPTIC)   +=3D isa1200.o
> >  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)   +=3D keyspan_remote.o
> >  obj-$(CONFIG_INPUT_KXTJ9)            +=3D kxtj9.o
> >  obj-$(CONFIG_INPUT_M68K_BEEP)                +=3D m68kspkr.o
> > diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1200.=
c
> > new file mode 100644
> > index 000000000000..f8dba8a95c7d
> > --- /dev/null
> > +++ b/drivers/input/misc/isa1200.c
> > @@ -0,0 +1,540 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/devm-helpers.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/property.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/units.h>
> > +
> > +/*
> > + * System control (LDO regulator)
> > + *
> > + * LDO voltage to register mapping is linear, but it is split in two p=
arts:
> > + * 2.3V - 3.0V map to 0x08 - 0x0f; 3.1V - 3.8V map to 0x00 - 0x7
> > + */
> > +
> > +#define ISA1200_SCTRL                        0x00
> > +#define ISA1200_LDO_VOLTAGE_BASE     0x08
> > +#define ISA1200_LDO_VOLTAGE_STEP     100000
> > +#define ISA1200_LDO_VOLTAGE_2V3              23
> > +#define ISA1200_LDO_VOLTAGE_3V1              31
> > +#define ISA1200_LDO_VOLTAGE_MIN              2300000
> > +#define ISA1200_LDO_VOLTAGE_MAX              3800000
> > +
> > +/*
> > + * The output frequency is calculated with this formula:
> > + *
> > + *                 base clock frequency
> > + * fout =3D -----------------------------------------
> > + *        (128 - PWM_FREQ) * 2 * PLLDIV * PWM_PERIOD
> > + *
> > + * The base clock frequency is the clock frequency provided on the
> > + * clock input to the chip, divided by the value in HCTRL0
> > + *
> > + * PWM_FREQ is configured in register HCTRL4, it is common to set this
> > + * to 0 to get only two variables to calculate.
> > + *
> > + * PLLDIV is configured in register HCTRL3 (bits 7..4, so 0..15)
> > + * PWM_PERIOD is configured in register HCTRL6
> > + * Further the duty cycle can be configured in HCTRL5
> > + */
> > +
> > +/*
> > + * HCTRL0 configures clock or PWM input and selects the divider for
> > + * the clock input.
> > + */
> > +#define ISA1200_HCTRL0                       0x30
> > +#define ISA1200_HCTRL0_HAP_ENABLE    BIT(7)
> > +#define ISA1200_HCTRL0_PWM_GEN_MODE  BIT(4)
> > +#define ISA1200_HCTRL0_PWM_INPUT_MODE        BIT(3)
> > +#define ISA1200_HCTRL0_CLKDIV_128    128
> > +
> > +/*
> > + * HCTRL1 configures the motor type and clock sourse
> > + */
> > +#define ISA1200_HCTRL1                       0x31
> > +#define ISA1200_HCTRL1_EXT_CLOCK     BIT(7)
> > +#define ISA1200_HCTRL1_DAC_INVERT    BIT(6)
> > +#define ISA1200_HCTRL1_MODE(n)               (((n) & 1) << 5)
>
> I wonder if this should simply be BIT(5) and you conditionally use it in
> the code. The macro is not really usable to disable the setting...
>
> > +
> > +/* HCTRL2 controls software reset of the chip */
> > +#define ISA1200_HCTRL2                       0x32
> > +#define ISA1200_HCTRL2_SW_RESET              BIT(0)
> > +
> > +/*
> > + * HCTRL3 controls the PLL divisor
> > + *
> > + * Bits [0,1] are always set to 1 (we don't know what they are
> > + * used for) and bit 4 and upward control the PLL divisor.
> > + */
> > +#define ISA1200_HCTRL3                       0x33
> > +#define ISA1200_HCTRL3_DEFAULT               0x03
> > +#define ISA1200_HCTRL3_PLLDIV(n)     (((n) & 0xf) << 4)
> > +
> > +/* HCTRL4 controls the PWM frequency of external channel */
> > +#define ISA1200_HCTRL4                       0x34
> > +
> > +/* HCTRL5 controls the PWM high duty cycle of internal channel */
> > +#define ISA1200_HCTRL5                       0x35
> > +
> > +/* HCTRL6 controls the PWM period of internal channel */
> > +#define ISA1200_HCTRL6                       0x36
> > +#define ISA1200_HCTRL6_PERIOD_SCALE  100
> > +
> > +/* The use for these registers is unknown but they exist */
> > +#define ISA1200_HCTRL7                       0x37
> > +#define ISA1200_HCTRL8                       0x38
> > +#define ISA1200_HCTRL9                       0x39
> > +#define ISA1200_HCTRLA                       0x3a
> > +#define ISA1200_HCTRLB                       0x3b
> > +#define ISA1200_HCTRLC                       0x3c
> > +#define ISA1200_HCTRLD                       0x3d
> > +
> > +#define ISA1200_EN_PINS_MAX          2
> > +
> > +struct isa1200_config {
> > +     u32 ldo_voltage;
> > +     u32 mode;
> > +     u32 clkdiv;
> > +     u32 plldiv;
> > +     u32 freq;
> > +     u32 period;
> > +     u32 duty;
> > +};
> > +
> > +struct isa1200 {
> > +     struct input_dev *input;
> > +     struct regmap *map;
> > +
> > +     struct clk *clk;
> > +     struct pwm_device *pwm;
> > +     struct gpio_descs *enable_gpios;
> > +
> > +     struct work_struct play_work;
> > +     struct isa1200_config config;
> > +
> > +     int level;
> > +     bool clk_on;
>
> I think you need not only clk_on, but general "active" flag that you
> would set at the end of isa1200_start().
>
> > +};
> > +
> > +static const struct regmap_config isa1200_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D ISA1200_HCTRLD,
> > +};
> > +
> > +static void isa1200_start(struct isa1200 *isa)
> > +{
> > +     struct isa1200_config *config =3D &isa->config;
> > +     struct pwm_state state;
> > +     u8 hctrl0 =3D 0, hctrl1 =3D 0;
> > +     DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
> > +     int ret;
>
> Please use "error" or "err" for all variables that only hold error codes
> (or 0) instead of a real value that is used for something.
>
> > +
> > +     if (!isa->clk_on) {
> > +             ret =3D clk_prepare_enable(isa->clk);
>
> This return 0 on success so
>
>                 if (error)
>                         return;
>
> > +             if (ret < 0)
> > +                     return;
> > +
> > +             isa->clk_on =3D true;
> > +     }
> > +
> > +     bitmap_fill(values, ISA1200_EN_PINS_MAX);
> > +     gpiod_multi_set_value_cansleep(isa->enable_gpios, values);
> > +
> > +     usleep_range(200, 300);
> > +
> > +     regmap_write(isa->map, ISA1200_SCTRL, config->ldo_voltage);
> > +
> > +     if (isa->clk) {
> > +             hctrl0 =3D ISA1200_HCTRL0_PWM_GEN_MODE;
> > +             hctrl1 =3D ISA1200_HCTRL1_EXT_CLOCK;
> > +     }
> > +
> > +     if (isa->pwm) {
> > +             hctrl0 =3D ISA1200_HCTRL0_PWM_INPUT_MODE;
> > +             hctrl1 =3D 0;
> > +     }
> > +
> > +     hctrl0 |=3D __ffs(config->clkdiv / ISA1200_HCTRL0_CLKDIV_128);
> > +     hctrl1 |=3D ISA1200_HCTRL1_DAC_INVERT;
> > +     hctrl1 |=3D ISA1200_HCTRL1_MODE(config->mode);
> > +
> > +     regmap_write(isa->map, ISA1200_HCTRL0, hctrl0);
> > +     regmap_write(isa->map, ISA1200_HCTRL1, hctrl1);
> > +
> > +     /* Make sure to de-assert software reset */
> > +     regmap_write(isa->map, ISA1200_HCTRL2, 0x00);
> > +
> > +     /* PLL divisor */
> > +     regmap_write(isa->map, ISA1200_HCTRL3,
> > +                  ISA1200_HCTRL3_PLLDIV(config->plldiv) |
> > +                  ISA1200_HCTRL3_DEFAULT);
> > +
> > +     /* Frequency */
> > +     regmap_write(isa->map, ISA1200_HCTRL4, config->freq);
> > +     /* Duty cycle */
> > +     regmap_write(isa->map, ISA1200_HCTRL5, config->period >> 1);
> > +     /* Period */
> > +     regmap_write(isa->map, ISA1200_HCTRL6, config->period);
> > +
> > +     hctrl0 |=3D ISA1200_HCTRL0_HAP_ENABLE;
> > +     regmap_write(isa->map, ISA1200_HCTRL0, hctrl0);
> > +
> > +     if (isa->clk)
> > +             regmap_write(isa->map, ISA1200_HCTRL5, config->duty);
> > +
> > +     if (isa->pwm) {
> > +             pwm_get_state(isa->pwm, &state);
> > +             state.duty_cycle =3D config->duty;
> > +             state.enabled =3D true;
> > +             pwm_apply_might_sleep(isa->pwm, &state);
> > +     }
> > +}
> > +
> > +static void isa1200_power_off(void *data)
> > +{
> > +     struct isa1200 *isa =3D data;
> > +
> > +     DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
> > +
> > +     bitmap_zero(values, ISA1200_EN_PINS_MAX);
> > +     gpiod_multi_set_value_cansleep(isa->enable_gpios, values);
> > +
> > +     if (isa->clk_on) {
> > +             clk_disable_unprepare(isa->clk);
> > +             isa->clk_on =3D false;
> > +     }
> > +}
> > +
> > +static void isa1200_stop(struct isa1200 *isa)
> > +{
> > +     struct pwm_state state;
> > +
> > +     if (isa->pwm) {
> > +             pwm_get_state(isa->pwm, &state);
> > +             state.duty_cycle =3D 0;
> > +             state.enabled =3D false;
> > +             pwm_apply_might_sleep(isa->pwm, &state);
> > +     }
> > +
> > +     regmap_write(isa->map, ISA1200_HCTRL0, 0x00);
> > +     isa1200_power_off(isa);
> > +}
> > +
> > +static void isa1200_play_work(struct work_struct *work)
> > +{
> > +     struct isa1200 *isa =3D
> > +             container_of(work, struct isa1200, play_work);
> > +
> > +     guard(mutex)(&isa->input->mutex);
>
> I think this mutex is dangerous here. You really want to stop/cancel
> work in suspend() and close() instead of blocking on the mutex and then
> continuing.
>
> > +
> > +     if (isa->level)
> > +             isa1200_start(isa);
> > +     else
> > +             isa1200_stop(isa);
> > +}
> > +
> > +static int isa1200_vibrator_play_effect(struct input_dev *input, void =
*data,
> > +                                     struct ff_effect *effect)
> > +{
> > +     struct isa1200 *isa =3D input_get_drvdata(input);
> > +     int level;
> > +
> > +     /*
> > +      * TODO: we currently only support rumble.
> > +      * The ISA1200 can control two motors and some devices
> > +      * also have two motors mounted.
> > +      */
> > +     level =3D effect->u.rumble.strong_magnitude;
> > +     if (!level)
> > +             level =3D effect->u.rumble.weak_magnitude;
> > +
> > +     dev_dbg(&input->dev, "FF effect type %d level %d\n",
> > +             effect->type, level);
> > +
> > +     if (isa->level !=3D level) {
> > +             isa->level =3D level;
> > +             schedule_work(&isa->play_work);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void isa1200_vibrator_close(struct input_dev *input)
> > +{
> > +     struct isa1200 *isa =3D input_get_drvdata(input);
> > +
> > +     cancel_work_sync(&isa->play_work);
> > +
> > +     if (isa->level)
>
> So here I think you need to check that "active" flag that would represent
> the committed state.
>
> > +             isa1200_stop(isa);
> > +
> > +     isa->level =3D 0;
> > +}
> > +
> > +static int isa1200_of_probe(struct i2c_client *client)
> > +{
> > +     static const char * const isa1200_supplies[] =3D { "vdd", "vddp" =
};
> > +     struct isa1200 *isa =3D i2c_get_clientdata(client);
> > +     struct isa1200_config *config =3D &isa->config;
> > +     struct device *dev =3D &client->dev;
> > +     struct fwnode_handle *ldo_node;
> > +     int ret;
> > +
> > +     isa->clk =3D devm_clk_get_optional(dev, NULL);
> > +     if (IS_ERR(isa->clk))
> > +             return dev_err_probe(dev, PTR_ERR(isa->clk),
> > +                                  "failed to get clock\n");
> > +
> > +     isa->pwm =3D devm_pwm_get(dev, NULL);
> > +     if (IS_ERR(isa->pwm)) {
> > +             ret =3D PTR_ERR(isa->pwm);
> > +             if (ret =3D=3D -ENODEV || ret =3D=3D -EINVAL)
> > +                     isa->pwm =3D NULL;
> > +             else
> > +                     return dev_err_probe(dev, ret, "getting PWM\n");
> > +     }
> > +
> > +     if (!isa->clk && !isa->pwm)
> > +             return dev_err_probe(dev, -EINVAL,
> > +                                  "clock or PWM are required, none wer=
e provided\n");
> > +
> > +     ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(isa1200_su=
pplies),
> > +                                          isa1200_supplies);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to set up supplies=
\n");
> > +
> > +     isa->enable_gpios =3D devm_gpiod_get_array_optional(dev, "control=
",
> > +                                                       GPIOD_OUT_LOW);
> > +     if (IS_ERR(isa->enable_gpios))
> > +             return dev_err_probe(dev, PTR_ERR(isa->enable_gpios),
> > +                                  "failed to get enable gpios\n");
> > +
> > +     ldo_node =3D device_get_named_child_node(dev, "ldo");
> > +     if (!ldo_node)
> > +             return dev_err_probe(dev, -ENODEV,
> > +                                  "failed to get embedded LDO node\n")=
;
> > +
> > +     ret =3D fwnode_property_read_u32(ldo_node, "regulator-min-microvo=
lt",
> > +                                    &config->ldo_voltage);
> > +     fwnode_handle_put(ldo_node);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                  "failed to get ldo voltage\n");
> > +
> > +     config->ldo_voltage =3D clamp(config->ldo_voltage,
> > +                                 ISA1200_LDO_VOLTAGE_MIN,
> > +                                 ISA1200_LDO_VOLTAGE_MAX);
> > +
> > +     config->ldo_voltage /=3D ISA1200_LDO_VOLTAGE_STEP;
> > +     if (config->ldo_voltage < ISA1200_LDO_VOLTAGE_3V1)
> > +             config->ldo_voltage =3D config->ldo_voltage -
> > +                                   ISA1200_LDO_VOLTAGE_2V3 +
> > +                                   ISA1200_LDO_VOLTAGE_BASE;
> > +     else
> > +             config->ldo_voltage -=3D ISA1200_LDO_VOLTAGE_3V1;
> > +
> > +     config->mode =3D 0; /* LRA_MODE */
> > +     device_property_read_u32(dev, "imagis,mode", &config->mode);
> > +
> > +     config->clkdiv =3D ISA1200_HCTRL0_CLKDIV_128;
> > +     device_property_read_u32(dev, "imagis,clk-div", &config->clkdiv);
> > +     if (!config->clkdiv)
> > +             return dev_err_probe(dev, -EINVAL, "clk-div cannot be zer=
o\n");
> > +
> > +     config->clkdiv =3D clamp(config->clkdiv, ISA1200_HCTRL0_CLKDIV_12=
8,
> > +                            ISA1200_HCTRL0_CLKDIV_128 << 3);
> > +
> > +     ret =3D device_property_read_u32(dev, "imagis,pll-div", &config->=
plldiv);
> > +     if (ret < 0 || !config->plldiv)
> > +             config->plldiv =3D 1;
> > +
> > +     config->period =3D 0;
> > +     config->freq =3D 0;
> > +     config->duty =3D 0;
> > +
> > +     if (isa->clk) {
> > +             ret =3D device_property_read_u32(dev, "imagis,period-ns",
> > +                                            &config->period);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "failed to get period\n");
> > +
> > +             /*
> > +              * TODO: The scale value is arbitrary, but it fits observ=
ations
> > +              * quite well, and the exact conversion method is unknown=
.
> > +              * The period property value returned above is the HCTRL6
> > +              * register value set by the vendor code, multiplied by 1=
00.
> > +              */
> > +             config->period /=3D ISA1200_HCTRL6_PERIOD_SCALE;
> > +             config->duty =3D config->period >> 1;
> > +     }
> > +
> > +     if (isa->pwm) {
> > +             struct pwm_state state;
> > +
> > +             pwm_init_state(isa->pwm, &state);
> > +
> > +             if (!state.period)
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                                          "PWM period cannot be zero\n=
");
> > +
> > +             config->freq =3D div64_u64(NANO, state.period * config->c=
lkdiv);
> > +             config->duty =3D state.period >> 1;
> > +
> > +             ret =3D pwm_apply_might_sleep(isa->pwm, &state);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "failed to apply initial PWM=
 state\n");
> > +     }
> > +
> > +     /*
> > +      * TODO: If device is using a clock, this property should return =
the
> > +      * value written to the HCTRL5 register by downstrem code. It lik=
ely
> > +      * needs to be converted into a meaningful duty cycle value, thou=
gh
> > +      * unfortunately the exact conversion mechanism is unknown. If th=
e
> > +      * device uses PWM, this property will return the correct duty cy=
cle
> > +      * in nanoseconds.
> > +      */
> > +     device_property_read_u32(dev, "imagis,duty-cycle-ns", &config->du=
ty);
> > +
> > +     return 0;
> > +}
> > +
> > +static int isa1200_probe(struct i2c_client *client)
> > +{
> > +     struct isa1200 *isa;
> > +     struct device *dev =3D &client->dev;
> > +     DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
> > +     u32 val;
> > +     int ret;
> > +
> > +     isa =3D devm_kzalloc(dev, sizeof(*isa), GFP_KERNEL);
> > +     if (!isa)
> > +             return -ENOMEM;
> > +
> > +     isa->input =3D devm_input_allocate_device(dev);
> > +     if (!isa->input)
> > +             return -ENOMEM;
> > +
> > +     i2c_set_clientdata(client, isa);
> > +
> > +     ret =3D isa1200_of_probe(client);
> > +     if (ret)
> > +             return ret;
> > +
> > +     isa->map =3D devm_regmap_init_i2c(client, &isa1200_regmap_config)=
;
> > +     if (IS_ERR(isa->map))
> > +             return dev_err_probe(dev, PTR_ERR(isa->map),
> > +                                  "failed to initialize register map\n=
");
> > +
> > +     ret =3D clk_prepare_enable(isa->clk);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "failed to enable clock\n"=
);
> > +
> > +     isa->clk_on =3D true;
> > +
> > +     bitmap_fill(values, ISA1200_EN_PINS_MAX);
> > +     gpiod_multi_set_value_cansleep(isa->enable_gpios, values);
>
> You should factor our isa1200_power_on() from isa1200_start() and use it
> here.
>
> > +
> > +     ret =3D devm_add_action_or_reset(dev, isa1200_power_off, isa);
> > +     if (ret)
> > +             return ret;
>
> close() is taking care of powering off the device.
>
> > +
> > +     usleep_range(200, 300);
> > +
> > +     /* Read a register so we know that regmap and I2C transport works=
 */
> > +     ret =3D regmap_read(isa->map, ISA1200_SCTRL, &val);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to read SCTRL\n");
>
> You should call isa1200_power_off() here. You do not know when the first
> effect will play. In the meantime the device should be in low power
> state.
>
> > +
> > +     ret =3D devm_work_autocancel(dev, &isa->play_work, isa1200_play_w=
ork);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to init work\n");
>
> I do not think you need it here. You supply input->close() and that
> should take care of stopping/canceling the work. Input core guarantees
> to call close() if the device is "open" whne unregistering.
>
> > +
> > +     isa->input->name =3D "isa1200-haptic";
> > +     isa->input->id.bustype =3D BUS_HOST;
>
> Not BUS_I2C?
>
> > +     isa->input->dev.parent =3D dev;
>
> Parent is already set by devm_input_allocate_device().
>
> > +     isa->input->close =3D isa1200_vibrator_close;
> > +
> > +     input_set_drvdata(isa->input, isa);
> > +
> > +     /* TODO: this hardware can likely support more than rumble */
> > +     input_set_capability(isa->input, EV_FF, FF_RUMBLE);
> > +
> > +     ret =3D input_ff_create_memless(isa->input, NULL,
> > +                                   isa1200_vibrator_play_effect);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "couldn't create FF dev\n"=
);
>
> "failed ..."
>
> > +
> > +     ret =3D input_register_device(isa->input);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "couldn't register input d=
ev\n");
>
> "failed ..."
>
> > +
> > +     return ret;
>
>         return 0;
>
> > +}
> > +
> > +static int isa1200_suspend(struct device *dev)
> > +{
> > +     struct isa1200 *isa =3D dev_get_drvdata(dev);
> > +
> > +     cancel_work_sync(&isa->play_work);
>
> Move it under input_device_enabled().
>
> > +
> > +     guard(mutex)(&isa->input->mutex);
> > +

Should I remove mutex locking from both PM functions?

> > +     if (input_device_enabled(isa->input))
> > +             if (isa->level)
> > +                     isa1200_stop(isa);
> > +
> > +     return 0;
> > +}
> > +
> > +static int isa1200_resume(struct device *dev)
> > +{
> > +     struct isa1200 *isa =3D dev_get_drvdata(dev);
> > +
> > +     guard(mutex)(&isa->input->mutex);
> > +
> > +     if (input_device_enabled(isa->input))
> > +             if (isa->level)
> > +                     isa1200_start(isa);
> > +
> > +     return 0;
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(isa1200_pm_ops, isa1200_suspend, isa12=
00_resume);
> > +
> > +static const struct of_device_id isa1200_of_match[] =3D {
> > +     { .compatible =3D "imagis,isa1200" },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, isa1200_of_match);
> > +
> > +static struct i2c_driver isa1200_i2c_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "isa1200",
> > +             .of_match_table =3D isa1200_of_match,
> > +             .pm =3D pm_sleep_ptr(&isa1200_pm_ops),
> > +     },
> > +     .probe =3D isa1200_probe,
> > +};
> > +module_i2c_driver(isa1200_i2c_driver);
> > +
> > +MODULE_AUTHOR("Linus Walleij <linusw@kernel.org>");
> > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > +MODULE_DESCRIPTION("Imagis ISA1200 haptic feedback unit");
> > +MODULE_LICENSE("GPL");
>
> Thanks.
>
> --
> Dmitry
