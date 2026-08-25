Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB843CF962
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643897; cv=none; b=SaAKVKO6HPdQwfSs/7i497AaBqNPpKIRpvAUjloQpMIYlyf3uftP6oyxSmaeUYSXJhfHE6pyKNy+EJzaW4HdfeueScE2KXPIDV/OoK9LKRkiAA80xiT5mI/uzYSCtWZ/TrLbuqNEH8x73rCeEhLqQivbuFJvITQwY8+m5INcmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643897; c=relaxed/simple;
	bh=MXhoLnq+LRhIiRQ/11TrGJ+xcvi1+U6WLSSaU29aDDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kiphg8nYTiYTHg4bb7DVXGLRStpiOB0YhW+HHVuytJs+51CTpAEg4OOt/8TTclGqsTSEWDXpL93bsy1UyjPAVNuQfj6+OggkWviam/lqtt2BnlmS+grjfIm/rUYQJEIrP/CUIqEB7HACDO/aqy6EG3xdw1E3dUswRIRkPM+55XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7h05WUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7h05WUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F63A1F00A3F
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 07:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787643895;
	bh=2bSETvozYzJhnddWVJ2dWmf4Ti4aMWKiWabBBUmW6Bg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f7h05WUpbtMI68nYMwfhFelJiMgZN4EHXLXBakzvpqLg1xmQVD+u3ED+U0Jc9T7cu
	 Pfwi6dRNk42d14lNOLpn59DygHqF2M4l22EIu1ZwnscCJhJ5YOimaosN6oUu2coAIz
	 D2xOlVdXqtiHG/b38i+FYo3Uwg5FHqSHEAoLCevi2OYGaenaHHYTPFOCHdKcXXWJK8
	 Iv7efpjrJT8/kLn729L2Yw6lpPmp7e11zcB0BO9W+F1Htnv6RyrJ1bBkbY6/OJynht
	 pkNVzlaQdG7X4Wqx/QB+DYaztWNX6PDLUBNbbv5xgbp1Gi7qXFBZ2RqzVgwkxJtczZ
	 OgTTTrDJF9b8Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so4263519e87.0
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 00:44:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpfcSfG7eGjDR7t9GJIcAVIeF52Zzacp5xia0aJVHWwoT8NcWEOi1tipVTl3TKKrbZUn83hSee5qQ1WGw==@vger.kernel.org
X-Gm-Message-State: AFuF++mwtivYzRPMbxJlgaf00jzxfDHymTG1wOTNVQ9+T4AYFUT4i4q4
	VesL1ZPkFH5X01FjiZfm7bFCJh15dIbOfKSS7Zu1cCVvyyb3/AMCcxVvuI9HdHe3gSrmOL6Otxt
	In7UV/Z6ub8Dw3i0cXzGGtoPF4Xel2Tk=
X-Received: by 2002:a05:6512:3c87:b0:5ae:bf45:e3be with SMTP id
 2adb3069b0e04-5b49cdc7008mr1381010e87.21.1787643894234; Tue, 25 Aug 2026
 00:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822213941.98882-1-michael.zaidman@gmail.com> <20260822213941.98882-4-michael.zaidman@gmail.com>
In-Reply-To: <20260822213941.98882-4-michael.zaidman@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 09:44:41 +0200
X-Gmail-Original-Message-ID: <CAD++jLm3ZK-=AYCVJHMt=x3_G26CsXZhOVj4E7na1e9JK0busg@mail.gmail.com>
X-Gm-Features: AcwNN1UnCmZrQb6IraMXKriSnwj2vYM8t9RtgnkWlihfpkJyN4ZgrXEexb3V-ss
Message-ID: <CAD++jLm3ZK-=AYCVJHMt=x3_G26CsXZhOVj4E7na1e9JK0busg@mail.gmail.com>
Subject: Re: [PATCH 03/13] HID: ft260: add GPIO support on top of UART
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Germain Hebert <germain.hebert@ca.abb.com>, Rio Liu <rio@r26.me>, 
	Bruno Giacomazzi <brunoceg1@gmail.com>, Christina Quast <contact@christina-quast.de>, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

thanks for your patch!

It seems this patch title should just be
"HID: ft260: add GPIO support"
the "on top of UART" part seems to be more about
which order you did the patches and that is about
development process, not technical content, we don't
put that into Subject.

On Sat, Aug 22, 2026 at 11:40=E2=80=AFPM Michael Zaidman
<michael.zaidman@gmail.com> wrote:

> Add gpiochip support for the FT260 multifunctional pins, including
> GPIO2/GPIOA/GPIOG function selection via sysfs, and enable the
> available GPIOs according to the active UART mode.
>
> This supersedes the earlier pre-UART GPIO series:
> https://lore.kernel.org/lkml/20230211115752.26276-2-michael.zaidman@gmail=
.com/
>
> The gpio_chip.set callback returns int to match the current gpiolib
> API, based on the adaptation originally contributed by Rio Liu
> <rio@r26.me>.
>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

You probably want:

#include <linus/bits.h>

(...)
>  static int ft260_debug =3D 1;
> @@ -57,6 +58,11 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messag=
es");
>  #define FT260_RD_DATA_MAX (180)
>  #define FT260_WR_I2C_DATA_MAX (60)
>  #define FT260_WR_UART_DATA_MAX (62)
> +#define FT260_GPIOCHIP "ft260_gpio"
> +#define FT260_GPIO_MAX (6)
> +#define FT260_GPIO_EX_MAX (8)

So 6 GPIOs is "max" and then there are extended GPIOs and then there is
a new max which is 8?

I would give these defines some easier to understand name such as:

#define FT260_BASE_GPIOS 6
#define FT260_EXTENDED_GPIOS 8

> +#define FT260_GPIO_TOTAL (FT260_GPIO_MAX + FT260_GPIO_EX_MAX)
> +#define FT260_GPIO_MASK (~(0xffff << FT260_GPIO_TOTAL))

This macro seems to be using funky arithmetic with bits
rolling out on the left.

What about just:

#define FT260_GPIO_MASK GENMASK(FT260_GPIO_TOTAL, 0)

> +/* GPIO offsets */
> +enum {

Is this *really* an enum? I feel an enum should be something like
consecutive or sparse integer ranges.
What about just using #define for those.

> +       FT260_GPIO_0                    =3D (1 << 0),
> +       FT260_GPIO_1                    =3D (1 << 1),

#define FT259_GPIO_0 BIT(0)
#define FT259_GPIO_1 BIT(1)
(...)

> +       FT260_GPIO_A                    =3D (1 << (FT260_GPIO_MAX + 0)),
> +       FT260_GPIO_B                    =3D (1 << (FT260_GPIO_MAX + 1)),

Those are the extended GPIOs I guess? Mention
that in the macro name? Also you know the bit number.
Do this:

#define FT260_GPIO_EXT_A BIT(7)
#define FT260_GPIO_EXT_B BIT(8)

> +/* GPIO groups */
> +enum {
> +       FT260_GPIO_WAKEUP               =3D (FT260_GPIO_3),
> +       FT260_GPIO_I2C_DEFAULT          =3D (FT260_GPIO_0 | FT260_GPIO_1)=
,
> +       FT260_GPIO_UART_RX_TX           =3D (FT260_GPIO_C | FT260_GPIO_D)=
,
> +       FT260_GPIO_UART_DCD_RI          =3D (FT260_GPIO_4 | FT260_GPIO_5)=
,
> +       FT260_GPIO_UART_RTS_CTS         =3D (FT260_GPIO_B | FT260_GPIO_E)=
,
> +       FT260_GPIO_UART_DTR_DSR         =3D (FT260_GPIO_F | FT260_GPIO_H)=
,
> +       FT260_GPIO_UART_MODE_0_SET      =3D (FT260_GPIO_UART_RX_TX |
> +                                          FT260_GPIO_UART_DCD_RI |
> +                                          FT260_GPIO_UART_RTS_CTS |
> +                                          FT260_GPIO_UART_DTR_DSR),
> +       FT260_GPIO_UART_MODE_1_SET      =3D (FT260_GPIO_UART_DTR_DSR),
> +       FT260_GPIO_UART_MODE_2_SET      =3D (FT260_GPIO_UART_RTS_CTS),
> +       FT260_GPIO_UART_MODE_3_SET      =3D (FT260_GPIO_UART_RTS_CTS |
> +                                          FT260_GPIO_UART_DTR_DSR),
> +       FT260_GPIO_UART_MODE_4_SET      =3D (FT260_GPIO_UART_MODE_3_SET),
> +       FT260_GPIO_UART_DEFAULT         =3D (FT260_GPIO_UART_MODE_0_SET),
> +       FT260_GPIO_UART_MODE_1_CLR      =3D (FT260_GPIO_UART_RX_TX |
> +                                          FT260_GPIO_UART_RTS_CTS),
> +       FT260_GPIO_UART_MODE_2_CLR      =3D (FT260_GPIO_UART_RX_TX |
> +                                          FT260_GPIO_UART_DTR_DSR),
> +       FT260_GPIO_UART_MODE_3_CLR      =3D (FT260_GPIO_UART_RX_TX),
> +       FT260_GPIO_UART_MODES           =3D (5),

Use #defines for all of this as well.

> +struct ft260_gpio_state {
> +       u8 vals;                /* GPIO[0-5] values in bits 0 - 5 */
> +       u8 dirs;                /* GPIO[0-5] directions, 0 - in, 1 - out =
*/
> +       u8 ex_vals;             /* GPIO[A-H] values in bits 0 - 7 */
> +       u8 ex_dirs;             /* GPIO[A-H] directions, 0 - in, 1 - out =
*/
> +} __packed;

So instead of creating your own cache of all registers,
have you considered just using regmap for this?
Regmap is essentially a register cache.

>  /* UART interface configuration */
>  enum {
> -       FT260_CFG_FLOW_CTRL_OFF         =3D 0x00,
> -       FT260_CFG_FLOW_CTRL_RTS_CTS     =3D 0x01,
> -       FT260_CFG_FLOW_CTRL_DTR_DSR     =3D 0x02,
> -       FT260_CFG_FLOW_CTRL_XON_XOFF    =3D 0x03,
> -       FT260_CFG_FLOW_CTRL_NONE        =3D 0x04,
> +       FT260_UART_CFG_FLOW_CTRL_OFF            =3D 0x00,
> +       FT260_UART_CFG_FLOW_CTRL_RTS_CTS        =3D 0x01,
> +       FT260_UART_CFG_FLOW_CTRL_DTR_DSR        =3D 0x02,
> +       FT260_UART_CFG_FLOW_CTRL_XON_XOFF       =3D 0x03,
> +       FT260_UART_CFG_FLOW_CTRL_NONE           =3D 0x04,

This looks like names you could have already assigned
in the UART patch and then the diff would be less noisy.

> -       FT260_CFG_DATA_BITS_7           =3D 0x07,
> -       FT260_CFG_DATA_BITS_8           =3D 0x08,
> +       FT260_UART_CFG_DATA_BITS_7              =3D 0x07,
> +       FT260_UART_CFG_DATA_BITS_8              =3D 0x08,

Dito.

> -#define FT260_UART_EN_PW_SAVE_BAUD     (4800)
> +#define FT260_UART_EN_PW_SAVE_BAUD (4800)

Dito.

> +static void ft260_gpio_en_set(struct ft260_device *dev, u16 bitmap)
> +{
> +       dev->gpio_en |=3D bitmap & FT260_GPIO_MASK;
> +}
> +
> +static void ft260_gpio_en_clr(struct ft260_device *dev, u16 bitmap)
> +{
> +       dev->gpio_en &=3D ~bitmap & FT260_GPIO_MASK;
> +}

Linux has bitmap manipulation functions in
<linus/bitmap.h>, use these instead of reinventing the wheel.

Yours,
Linus Walleij
