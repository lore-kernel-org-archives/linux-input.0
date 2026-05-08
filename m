Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4D372B23
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219899; cv=pass; b=QVDMQKZQbv8X97NYnEI3GEQUC733rOxD0wqHSqWMIt/NoRwlS1eRjLMr5fPZSwXJ9/wre4FzuTNFfvoDmRaj4TkwveR9+5aIF7zh1VMU5mdp5snGqJhu61KvoE6RDfsvFOsf6TxvC7nWDTf89W1wVPVa3k77fbzTd34YUKZntGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219899; c=relaxed/simple;
	bh=MsMBfF3Lz9wgG3hIlipB8KN/EOwo+4NtmWMGKWIiCkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6pTEqL2YsqZ0JP5RTNu3bQFHbWdOl8lE5Nqx+dWzCjtsqhPyrkrLNht50pmtRfZTSNb8yPOSyl5GW934etOOOzAcu102vTSQ+QS3GuxT1vFZpxkSnQn8KmmCnv0gfCbJSgUoq/q4BU5z6hRpEXZW5+ERXmvi7tNHZ7OLxBt3Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnqmNfnb; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnqmNfnb"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c8f9846c8so2415898c88.0
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 22:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778219882; cv=none;
        d=google.com; s=arc-20240605;
        b=JJ1HXJdST+dliD5YH52oDgx5sx6WL5mVQvnKKBkfeRfx9BTRh3zzxJcYpuNmi/E4RO
         MxBeVpujfwImzMYqz6nGtYyvSJQoIVwMwQytKK3EOo688al8T/1Y7BCnC5PbQ9mrW9KY
         9o77GzfRRXDfV1Ln3RN41+PylkVm3rsJIk47lMlCoyZ/SFeA3jQO34sALdqRn+l4ckEU
         y4UiM9JJIufkhzpLTNqCbeN2D/lQCvlKGYsRAAM2xGPkOpjhVFztgt/aMIq8j2NHjDmk
         xsAJfPcWBuHqoQRrTWrq21rSX0oJGqKWmBNLgXlySwfc4nuXFOo4FKCsSC2TsGAxH5zr
         BZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xs/nBR3dKtobleEZPJWudOpTPFw2ZtYn+hSkBqqcmXM=;
        fh=evlM82fst9/UqoeXM2dUKDqndnAwLEvhu0xA0Cc/SMI=;
        b=bQfOjuN8ULu56xgoa59IUuujXotdH8MNI1Kl5FZBGFSkeWgYx7xrY4VU/m4XwPc4qZ
         xYiiKXSD+wxr3l1qmfFaYeRKf2txrX3COPtdjUL3pZUnoMUywu1AeYm8ZDCBe79hysfo
         A3n42KR3JAqUqyX8UsygxuhtYBjstMHwauWzX9AvQ0QXFrz4IU+ND+Atra/LN6+blWTP
         fnyAoKoi+l95Tp0vpj14K8IoTwVpQnLV/mcTB5CJodhdHEpAzsZ2FankfJZ3ivWVU3OC
         EIHdDyK+2iNdZOWxOIXCpJw1K1L9VFcLSpVBbBEIYs6y1v2S4scN0I36UivycMN4tK6w
         FsiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778219882; x=1778824682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs/nBR3dKtobleEZPJWudOpTPFw2ZtYn+hSkBqqcmXM=;
        b=nnqmNfnbZb6kxSSqp9WFgSu++hZYTKH29FYQ1Z1mTeRzeV5tI1ZwD7BmBG/lIPJHZO
         MauxWoRJWsd4BFFSW0FJNlBw0NROecrBT70DdF7L6g7lsmaMzno1Fj7TR3UtZasy7tSK
         vTwyOV6hvF4waZAIEX71cRd8ikvLTLeoKYXtjowv4OE43Dcae3iGNonEU//UEycHi666
         Vw4gzAkOAJGWLWBVhD4B6TkwF9l259ahbKA34VwRhNkJSgjZwX0xUqlTCNtz0Mb5DAtY
         Y01xTksRXmNVmogWCSPamjxRis9snX6qZX3m/dqesm8QnmAroCcEbCzl8U5GMaKlXtbc
         +DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778219882; x=1778824682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xs/nBR3dKtobleEZPJWudOpTPFw2ZtYn+hSkBqqcmXM=;
        b=m0WiKr2ljVCx//UY95JbQmJkF2d3F4v/3Dji06o/y+7cfq7WxCmf9DFsTD/DqYvtEx
         DZWkU3uPgHFILU06og+hJiY5DhZ3SXxrJDToS2KJwDzRWlY2cpCxdSoiHm5PMK4wX4Y0
         S1JArU4VguxMOXKqqZWVBW/naPe1MHAKqr5Nquc4M6Y6SHC8Czz/fXsmtnDBmT1chcsi
         CrbcikXnZeTRQSPBEqjHvBkdH4GlotFQ6y0LMeIBddexUB61OvWh23QxZF6iFCTf0KYJ
         oUtqjWNV8bO94DLl5f4kzkOOhUGI2xm+pG/pM1Sa6AkvNY+ZTa06FvC+AJJwK1E7PRTy
         2GGA==
X-Forwarded-Encrypted: i=1; AFNElJ9bc5FsiteQYexCaBSEuDqxU5n5F6iIvAMfvMppr5DewliCm3dpz5X857qkDvUbB0voELnCQfrVMK+tdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfT9HDEvQs1p+wn5TkhnTnEwAetOlU3jOTSZZuCMm7Bv1DnCpt
	pZjPJ5lNXHCtXdJoViOPaeZRkY+UHqPDGgLcwytuZktwbtabBak4iseMKSVbPeLTuye9JL32zc8
	neLQMxJ5uO3DiJF68KY8AQifmGpZhuug=
X-Gm-Gg: Acq92OEipLF/GiyugTZCt4/MH9dFBASMgXx6twk/dyUKogRMdKj1xo2fREg1fc2PPVH
	LeJZOTNiX8aFqLyeOi6teJIKrhYH7JlyGA2NO0s9a/Br+ZxcZhhJVk3/NZ/78QdX4bXcip7J497
	1i0Ie/HF0Vl9UGlR711+nk3yf/2qC4l2y7NumHabt5q5Za9x4ciICwvm4YIkJNGKfW04RCSGPpH
	f4x0L3MU2RUypyJxi0aiuq4xT3QriRelqUcL7/biRtLQpf9My9eeTHqpWUg6qg5Q8aHTJ7M/Zjw
	WQWaSOG3
X-Received: by 2002:a05:7300:ec08:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-2f549f838d8mr5006415eec.19.1778219881888; Thu, 07 May 2026
 22:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507133948.75704-1-clamor95@gmail.com> <20260507133948.75704-3-clamor95@gmail.com>
 <afzJUcvQth6v9KGC@google.com> <CAPVz0n0w98wO_iJBiyvKqATA7a6+mkZG3DfbBwHp8FEExMHPqQ@mail.gmail.com>
 <af115srC-zwjDxzq@google.com>
In-Reply-To: <af115srC-zwjDxzq@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 8 May 2026 08:57:49 +0300
X-Gm-Features: AVHnY4Ka4g5enrnsH7UdEAZTD_DVRa4Ty4Z872YK8nV-x8B03A7S0YZ9xugMFZY
Message-ID: <CAPVz0n3BCmqnZQEj+910-ZPFkh=uWfvxOUvdt8oGepQMRd5tkA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 8 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 08:40=
 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, May 08, 2026 at 08:30:19AM +0300, Svyatoslav Ryhel wrote:
> > =D1=87=D1=82, 7 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 2=
2:26 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > On Thu, May 07, 2026 at 04:39:48PM +0300, Svyatoslav Ryhel wrote:
> > > > From: Linus Walleij <linusw@kernel.org>
> > > >
> > > > The ISA1200 is a haptic feedback unit from Imagis Technology using =
two
> > > > motors for haptic feedback in mobile phones. Used in many mobile de=
vices
> > > > c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsun=
g Beam
> > > > GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> > > >
> > > > The exact datasheet for the ISA1200 is not available; all data was =
modeled
> > > > based on available downstream kernel sources for various devices an=
d
> > > > fragments of information scattered across the internet.
> > > >
> > > > Tested-by: Linus Walleij <linusw@kernel.org> # GT-I9070 Janice
> > > > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/input/misc/Kconfig   |  12 +
> > > >  drivers/input/misc/Makefile  |   1 +
> > > >  drivers/input/misc/isa1200.c | 540 +++++++++++++++++++++++++++++++=
++++
> > > >  3 files changed, 553 insertions(+)
> > > >  create mode 100644 drivers/input/misc/isa1200.c
> > > >
> > > > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfi=
g
> > > > index 94a753fcb64f..52f192104ee2 100644
> > > > --- a/drivers/input/misc/Kconfig
> > > > +++ b/drivers/input/misc/Kconfig
> > > > @@ -852,6 +852,18 @@ config INPUT_IQS7222
> > > >         To compile this driver as a module, choose M here: the
> > > >         module will be called iqs7222.
> > > >
> > > > +config INPUT_ISA1200_HAPTIC
> > > > +     tristate "Imagis ISA1200 haptic feedback unit"
> > > > +     depends on I2C
> > > > +     select INPUT_FF_MEMLESS
> > > > +     select REGMAP_I2C
> > > > +     help
> > > > +       Say Y to enable support for the Imagis ISA1200 haptic
> > > > +       feedback unit.
> > > > +
> > > > +       To compile this driver as a module, choose M here: the
> > > > +       module will be called isa1200.
> > > > +
> > > >  config INPUT_CMA3000
> > > >       tristate "VTI CMA3000 Tri-axis accelerometer"
> > > >       help
> > > > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makef=
ile
> > > > index 415fc4e2918b..d62bf2e9d85f 100644
> > > > --- a/drivers/input/misc/Makefile
> > > > +++ b/drivers/input/misc/Makefile
> > > > @@ -49,6 +49,7 @@ obj-$(CONFIG_INPUT_IMS_PCU)         +=3D ims-pcu.=
o
> > > >  obj-$(CONFIG_INPUT_IQS269A)          +=3D iqs269a.o
> > > >  obj-$(CONFIG_INPUT_IQS626A)          +=3D iqs626a.o
> > > >  obj-$(CONFIG_INPUT_IQS7222)          +=3D iqs7222.o
> > > > +obj-$(CONFIG_INPUT_ISA1200_HAPTIC)   +=3D isa1200.o
> > > >  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)   +=3D keyspan_remote.o
> > > >  obj-$(CONFIG_INPUT_KXTJ9)            +=3D kxtj9.o
> > > >  obj-$(CONFIG_INPUT_M68K_BEEP)                +=3D m68kspkr.o
> > > > diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1=
200.c
> > > > new file mode 100644
> > > > index 000000000000..f8dba8a95c7d
> > > > --- /dev/null
> > > > +++ b/drivers/input/misc/isa1200.c
> > > > @@ -0,0 +1,540 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +
> > > > +#include <linux/array_size.h>
> > > > +#include <linux/bitmap.h>
> > > > +#include <linux/bits.h>
> > > > +#include <linux/clk.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/devm-helpers.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/input.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/property.h>
> > > > +#include <linux/pwm.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/regulator/consumer.h>
> > > > +#include <linux/units.h>
> > > > +
> > > > +/*
> > > > + * System control (LDO regulator)
> > > > + *
> > > > + * LDO voltage to register mapping is linear, but it is split in t=
wo parts:
> > > > + * 2.3V - 3.0V map to 0x08 - 0x0f; 3.1V - 3.8V map to 0x00 - 0x7
> > > > + */
> > > > +
> > > > +#define ISA1200_SCTRL                        0x00
> > > > +#define ISA1200_LDO_VOLTAGE_BASE     0x08
> > > > +#define ISA1200_LDO_VOLTAGE_STEP     100000
> > > > +#define ISA1200_LDO_VOLTAGE_2V3              23
> > > > +#define ISA1200_LDO_VOLTAGE_3V1              31
> > > > +#define ISA1200_LDO_VOLTAGE_MIN              2300000
> > > > +#define ISA1200_LDO_VOLTAGE_MAX              3800000
> > > > +
> > > > +/*
> > > > + * The output frequency is calculated with this formula:
> > > > + *
> > > > + *                 base clock frequency
> > > > + * fout =3D -----------------------------------------
> > > > + *        (128 - PWM_FREQ) * 2 * PLLDIV * PWM_PERIOD
> > > > + *
> > > > + * The base clock frequency is the clock frequency provided on the
> > > > + * clock input to the chip, divided by the value in HCTRL0
> > > > + *
> > > > + * PWM_FREQ is configured in register HCTRL4, it is common to set =
this
> > > > + * to 0 to get only two variables to calculate.
> > > > + *
> > > > + * PLLDIV is configured in register HCTRL3 (bits 7..4, so 0..15)
> > > > + * PWM_PERIOD is configured in register HCTRL6
> > > > + * Further the duty cycle can be configured in HCTRL5
> > > > + */
> > > > +
> > > > +/*
> > > > + * HCTRL0 configures clock or PWM input and selects the divider fo=
r
> > > > + * the clock input.
> > > > + */
> > > > +#define ISA1200_HCTRL0                       0x30
> > > > +#define ISA1200_HCTRL0_HAP_ENABLE    BIT(7)
> > > > +#define ISA1200_HCTRL0_PWM_GEN_MODE  BIT(4)
> > > > +#define ISA1200_HCTRL0_PWM_INPUT_MODE        BIT(3)
> > > > +#define ISA1200_HCTRL0_CLKDIV_128    128
> > > > +
> > > > +/*
> > > > + * HCTRL1 configures the motor type and clock sourse
> > > > + */
> > > > +#define ISA1200_HCTRL1                       0x31
> > > > +#define ISA1200_HCTRL1_EXT_CLOCK     BIT(7)
> > > > +#define ISA1200_HCTRL1_DAC_INVERT    BIT(6)
> > > > +#define ISA1200_HCTRL1_MODE(n)               (((n) & 1) << 5)
> > >
> > > I wonder if this should simply be BIT(5) and you conditionally use it=
 in
> > > the code. The macro is not really usable to disable the setting...
> > >
> >
> > That was the initial idea but mode is not boolean it is an enum and
> > macro fits better to handle enum. Code does not enable/disable this
> > field, this field is configured with every start call.
>
> OK.
>
> >
> > > > +
> > > > +/* HCTRL2 controls software reset of the chip */
> > > > +#define ISA1200_HCTRL2                       0x32
> > > > +#define ISA1200_HCTRL2_SW_RESET              BIT(0)
> > > > +
> > > > +/*
> > > > + * HCTRL3 controls the PLL divisor
> > > > + *
> > > > + * Bits [0,1] are always set to 1 (we don't know what they are
> > > > + * used for) and bit 4 and upward control the PLL divisor.
> > > > + */
> > > > +#define ISA1200_HCTRL3                       0x33
> > > > +#define ISA1200_HCTRL3_DEFAULT               0x03
> > > > +#define ISA1200_HCTRL3_PLLDIV(n)     (((n) & 0xf) << 4)
> > > > +
> > > > +/* HCTRL4 controls the PWM frequency of external channel */
> > > > +#define ISA1200_HCTRL4                       0x34
> > > > +
> > > > +/* HCTRL5 controls the PWM high duty cycle of internal channel */
> > > > +#define ISA1200_HCTRL5                       0x35
> > > > +
> > > > +/* HCTRL6 controls the PWM period of internal channel */
> > > > +#define ISA1200_HCTRL6                       0x36
> > > > +#define ISA1200_HCTRL6_PERIOD_SCALE  100
> > > > +
> > > > +/* The use for these registers is unknown but they exist */
> > > > +#define ISA1200_HCTRL7                       0x37
> > > > +#define ISA1200_HCTRL8                       0x38
> > > > +#define ISA1200_HCTRL9                       0x39
> > > > +#define ISA1200_HCTRLA                       0x3a
> > > > +#define ISA1200_HCTRLB                       0x3b
> > > > +#define ISA1200_HCTRLC                       0x3c
> > > > +#define ISA1200_HCTRLD                       0x3d
> > > > +
> > > > +#define ISA1200_EN_PINS_MAX          2
> > > > +
> > > > +struct isa1200_config {
> > > > +     u32 ldo_voltage;
> > > > +     u32 mode;
> > > > +     u32 clkdiv;
> > > > +     u32 plldiv;
> > > > +     u32 freq;
> > > > +     u32 period;
> > > > +     u32 duty;
> > > > +};
> > > > +
> > > > +struct isa1200 {
> > > > +     struct input_dev *input;
> > > > +     struct regmap *map;
> > > > +
> > > > +     struct clk *clk;
> > > > +     struct pwm_device *pwm;
> > > > +     struct gpio_descs *enable_gpios;
> > > > +
> > > > +     struct work_struct play_work;
> > > > +     struct isa1200_config config;
> > > > +
> > > > +     int level;
> > > > +     bool clk_on;
> > >
> > > I think you need not only clk_on, but general "active" flag that you
> > > would set at the end of isa1200_start().
> > >
> >
> > Acknowledged.
> >
> > > > +};
> > > > +
> > > > +static const struct regmap_config isa1200_regmap_config =3D {
> > > > +     .reg_bits =3D 8,
> > > > +     .val_bits =3D 8,
> > > > +     .max_register =3D ISA1200_HCTRLD,
> > > > +};
> > > > +
> > > > +static void isa1200_start(struct isa1200 *isa)
> > > > +{
> > > > +     struct isa1200_config *config =3D &isa->config;
> > > > +     struct pwm_state state;
> > > > +     u8 hctrl0 =3D 0, hctrl1 =3D 0;
> > > > +     DECLARE_BITMAP(values, ISA1200_EN_PINS_MAX);
> > > > +     int ret;
> > >
> > > Please use "error" or "err" for all variables that only hold error co=
des
> > > (or 0) instead of a real value that is used for something.
> > >
> >
> > Not real value, but return value. Why I cannot use ret aka return
> > value? It is much more versatile since it can hold any function return
> > value including errors.
>
> This is my preference for input. I do not want versatility, I want the
> opposite: if I see error I do not need to consider whether it holds
> something of value besides an error code. And if I see "ret" or "retval"
> I know that caller might be interested the value. And also
>
>         if (error) {
>                 // handle error
>         }
>
> looks neat.
>

Ok, noted

> >
> > > > +
> > > > +     if (!isa->clk_on) {
> > > > +             ret =3D clk_prepare_enable(isa->clk);
> > >
> > > This return 0 on success so
> > >
> > >                 if (error)
> > >                         return;
> > >
> >
> > No, code is correct. If clock enable fails, further function execution
> > should stop since regmap operations on unconfigured device is not
> > desirable. Since this function is void using general "active" flag as
> > you suggested to indicate that start reached end would be beneficial.
>
> I am simply saying that you do not need to check if value is negative,
> checking that it is non-zero is sufficient.
>

I have poorly worded. I meant that err < 0 specifically checks for
error code regardless of function you are checking (in most cases) and
you don't have to check if the original function documentation. But if
(err) is fine by me as well.

> Thanks.
>
> --
> Dmitry
