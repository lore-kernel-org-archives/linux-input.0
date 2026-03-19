Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE6175A6B
	for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773896668; cv=pass; b=g2DU3vgbp4/59caXYBQtF0KsVb8bNLz97hmdzeC4n81+87zu6IUHGkxlXP4Y4JjiQA37HYgbAcSfgWh7RDyeN6eXUy7+IzBJPvb6OyDEY7qKVd1pyT1gFPkzeu/zrfi+s/+aAb0KpZbngysw9M8Av+iKU4DUBoT/+G4aAwXIItg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773896668; c=relaxed/simple;
	bh=j4LwOfreD5riTsVaD7Gb/OCJFXpoD19garNTTqeXcII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKf7+sOgX7yZZ/VNcSqg/vxRUu4rI4CX/g4A0cqvJNh2D9APSi0b/P4xuQWCBS+cCZiQQzqpfqWImM2EybhP3uKA5Y/vsfRwIvAmmrT6GC5kaMM4kAnrXryU5cU2QWbMq9xauAD5fbFax3Sp4bGl1w7Dh0AYsOx40Np65xDqD8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mFvVwijW; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mFvVwijW"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so561555b3a.0
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 22:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773896665; cv=none;
        d=google.com; s=arc-20240605;
        b=FEIKUwFZ/HFOOaMrOasVi6K2i91k8fkQ37JTAMlytZc0I/XHRIJo81+6CjGHtpd5Bj
         HswM8j0U8VbCapfttkwSTFPaPWL7enAhuMXqdKbeXVNzd0fXg7+Illc0Vlcmt4ZYWOQv
         jWTVrhhgoKk6sCDLpwRgjIoq1GXRbS1ysYOc2/8ElCA8HXHt3fnBhb8HX8STDz/mEDoT
         thOmONk6xV1n3LCJ/omcEarrmuhB+YLrDgzsHvwBE1fZYQFnUWdyWOw/1wLGMDGxOsHZ
         UFadLPFWx1A3MIfZFP33TGryfIDQnGLZTXmPabTcDgPwUbZSKO/Z0QB1kPGA6CwAmz/k
         wsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L2RA8e9dExM6rfge9s7IPYuXY2hi5jyghiykXbcUF4Y=;
        fh=JEAwRKfgUQfxCB/s8wB6u4jJCUqO6xSj6EqwtBJZ35c=;
        b=TkvNnkBpQYyvlRVwcDMwYs46/8Xj2dyK1LygYnxWHxm/X3mAoKZwccm6XJDsNPe/Pa
         iTK865n4bx0m7oCRusNXgsVwzw56CaJrbadc4b/uLGhK2VR0T9frCKiYuQKKVgJr7UZS
         ciTc3GhpWq4wCnOHGQgscFMCseNhAwSvphs9mhoiK+Ceg+cZD+dqhm3ENkVeBvSpKlNt
         8o9kVE87fMB1zYlFeYRQN4K6gGlB/cauOH6LOK3bQr4Am0PlUqpl2FK45xO37nPSTmkM
         BC/a1Kqv776wIYGXK32JavjUnpY9pYbkoISyoyRKM9tKr31u5Lj44wWIawXI3CzZsr2m
         zAYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773896665; x=1774501465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2RA8e9dExM6rfge9s7IPYuXY2hi5jyghiykXbcUF4Y=;
        b=mFvVwijWgEAUmOmrN9GTO2KGz6TN+4kkBF1VI6E8AHNsXxZmM+7ATzk2ztv1BYallv
         uEhw4T741OsHWwirqwkgsU8q4ukcueAMpTgP/z9a3BoTezfUw3NrXARVyT4i1X0kpdWE
         aCm42G/roXxS4ZMvbQkpxFLQXaedbgTebHKV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773896665; x=1774501465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L2RA8e9dExM6rfge9s7IPYuXY2hi5jyghiykXbcUF4Y=;
        b=L8YyiDnnhvF/dz0/frTaDo1nxKgNU6wXMpWfymPwOXPa88TE27r6Eh7PBefZR8drcY
         1y2iblZ3/evCLWx4jDkd1OViApSd33jAEE90VXHMUgqBZ9P+LzbdM+B73Oo+GQ0rpzYx
         WHqXWBd1SUHlJWlEjvDZXOQYkCM3i+QfKaEfXLPEL12h2bWXQrVzGhz1Oiv/s6Ol48l7
         8xa9b6P14Bo+fKvQoNoPch4LHSnP7KQCAUxVSoa+ZAYKdg7DPYwVi8zce5HL0GHyVpDb
         dqV5QQKYQBwKhN8DDMUOYSupIAUp34FNml5G3uUvQWwVspJsFcPpdBDIZI8ADza2hNsg
         HwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG0U6aQjvW7nYaqohIIxE7Wd1N11kdFv2OjAu7mckkOE3RHyKupTj1FLlq1INZx3E2ilv29kBt2mr0Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFG48Slg+YNyvnlTgM4VqCdeEGA19IXNxOCBqIFDdqrSEN31qU
	2H3PEymWEt9BZQxznxHPfkK1qLYPtXZh0z1s4ayasncQ0rEV9YStCCbQrmEScVUN4LvSQE+Mr1q
	Bf3/hGaYIrM5KE9KtNqSgdl4hoq2B0tth7Dd8+qNG
X-Gm-Gg: ATEYQzw01XnCgWjX5bUYWXk9njTQuwPAfDScdJn9kMA0oqPbKgBFc29BVVNSVU45E4R
	1/ngcbQn0IVgai39u934KDktwC26y1NaFUQBIIpe2AF0NNhAy8ilvx/ZrLd11TwZONySQS/dI1d
	Gp1F4pBm8xX+tzgqWuxDS6YsghTr5gplTb+v3EU8aqZs9lZkckZ3fGUMbflQMMLJrXlL1L6w2bO
	zlzfe6x9C5nslIcPLiFhO2cur7XiFmhDAjEKQI+c1P2EBXxmG3NIIpOlRC289ojumJGYwGzuwVf
	Y8eI6Az3O/4ImJzz0fUkckbumFoVlqexiaH9oJ5/B50Uv6pn
X-Received: by 2002:a05:6a00:71cd:b0:82a:7046:86a0 with SMTP id
 d2e1a72fcca58-82a70468ac5mr3493177b3a.20.1773896664943; Wed, 18 Mar 2026
 22:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-8-l.scorcia@gmail.com>
In-Reply-To: <20260317184507.523060-8-l.scorcia@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 19 Mar 2026 13:04:12 +0800
X-Gm-Features: AaiRm53-k1XiPsX8YHUI34_UU2ePBdJ9HT3Aqm47Bm64kJThrD_lG_tt8e77KjA
Message-ID: <CAGXv+5GmDtrtFHJXs+fDyF+dZ5YW-TSEqXnPs2xCH8cu-Xcn9w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] regulator: mt6392: Add support for MT6392 regulator
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Gary Bisson <bisson.gary@gmail.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:46=E2=80=AFAM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> From: Fabien Parent <parent.f@gmail.com>
>
> The MT6392 is a regulator found on boards based on the MediaTek
> MT8167, MT8516, and probably other SoCs. It is a so called PMIC and
> connects as a slave to a SoC using SPI, wrapped inside PWRAP.
>
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Co-developed-by: Val Packett <val@packett.cool>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  drivers/regulator/Kconfig                  |   9 +
>  drivers/regulator/Makefile                 |   1 +
>  drivers/regulator/mt6392-regulator.c       | 487 +++++++++++++++++++++
>  include/linux/regulator/mt6392-regulator.h |  40 ++
>  4 files changed, 537 insertions(+)
>  create mode 100644 drivers/regulator/mt6392-regulator.c
>  create mode 100644 include/linux/regulator/mt6392-regulator.h
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index d2335276cce5..66876d730807 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -991,6 +991,15 @@ config REGULATOR_MT6380
>           This driver supports the control of different power rails of de=
vice
>           through regulator interface.
>
> +config REGULATOR_MT6392
> +       tristate "MediaTek MT6392 PMIC"
> +       depends on MFD_MT6397
> +       help
> +         Say y here to select this option to enable the power regulator =
of
> +         MediaTek MT6392 PMIC.
> +         This driver supports the control of different power rails of de=
vice
> +         through regulator interface.
> +
>  config REGULATOR_MT6397
>         tristate "MediaTek MT6397 PMIC"
>         depends on MFD_MT6397
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 1beba1493241..db5145cfcf36 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -117,6 +117,7 @@ obj-$(CONFIG_REGULATOR_MT6360) +=3D mt6360-regulator.=
o
>  obj-$(CONFIG_REGULATOR_MT6363) +=3D mt6363-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6370) +=3D mt6370-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6380) +=3D mt6380-regulator.o
> +obj-$(CONFIG_REGULATOR_MT6392) +=3D mt6392-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6397) +=3D mt6397-regulator.o
>  obj-$(CONFIG_REGULATOR_MTK_DVFSRC) +=3D mtk-dvfsrc-regulator.o
>  obj-$(CONFIG_REGULATOR_QCOM_LABIBB) +=3D qcom-labibb-regulator.o
> diff --git a/drivers/regulator/mt6392-regulator.c b/drivers/regulator/mt6=
392-regulator.c
> new file mode 100644
> index 000000000000..50cc0019f48a
> --- /dev/null
> +++ b/drivers/regulator/mt6392-regulator.c
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2020 MediaTek Inc.
> +// Copyright (c) 2020 BayLibre, SAS.
> +// Author: Chen Zhong <chen.zhong@mediatek.com>
> +// Author: Fabien Parent <fparent@baylibre.com>
> +//
> +// Based on mt6397-regulator.c
> +
> +#include <linux/module.h>
> +#include <linux/linear_range.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6392/registers.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/mt6392-regulator.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <dt-bindings/regulator/mediatek,mt6392-regulator.h>
> +
> +/*
> + * MT6392 regulators' information
> + *
> + * @desc: standard fields of regulator description.
> + * @qi: Mask for query enable signal status of regulators
> + * @vselon_reg: Register sections for hardware control mode of bucks
> + * @vselctrl_reg: Register for controlling the buck control mode.
> + * @vselctrl_mask: Mask for query buck's voltage control mode.
> + */
> +struct mt6392_regulator_info {
> +       struct regulator_desc desc;
> +       u32 qi;
> +       u32 vselon_reg;
> +       u32 vselctrl_reg;
> +       u32 vselctrl_mask;
> +       u32 modeset_reg;
> +       u32 modeset_mask;
> +};
> +
> +#define MT6392_BUCK(match, vreg, min, max, step, volt_ranges, enreg,   \
> +               vosel, vosel_mask, voselon, vosel_ctrl,                 \
> +               _modeset_reg, _modeset_mask, rampdelay)         \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_range_ops,                         =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D ((max) - (min)) / (step) + 1,            =
 \
> +               .linear_ranges =3D volt_ranges,                          =
 \
> +               .n_linear_ranges =3D ARRAY_SIZE(volt_ranges),            =
 \
> +               .vsel_reg =3D vosel,                                     =
 \
> +               .vsel_mask =3D vosel_mask,                               =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(0),                                 =
 \
> +               .ramp_delay =3D rampdelay,                               =
 \

Please add the supply names.

> +       },                                                              \
> +       .qi =3D BIT(13),                                                 =
 \
> +       .vselon_reg =3D voselon,                                         =
 \
> +       .vselctrl_reg =3D vosel_ctrl,                                    =
 \
> +       .vselctrl_mask =3D BIT(1),                                       =
 \
> +       .modeset_reg =3D _modeset_reg,                                   =
 \
> +       .modeset_mask =3D _modeset_mask,                                 =
 \
> +}
> +
> +#define MT6392_LDO(match, vreg, ldo_volt_table, enreg, enbit, vosel,   \
> +               vosel_mask, _modeset_reg, _modeset_mask, entime)        \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_table_ops,                         =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D ARRAY_SIZE(ldo_volt_table),              =
 \
> +               .volt_table =3D ldo_volt_table,                          =
 \
> +               .vsel_reg =3D vosel,                                     =
 \
> +               .vsel_mask =3D vosel_mask,                               =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(enbit),                             =
 \
> +               .enable_time =3D entime,                                 =
 \
> +       },                                                              \
> +       .qi =3D BIT(15),                                                 =
 \
> +       .modeset_reg =3D _modeset_reg,                                   =
 \
> +       .modeset_mask =3D _modeset_mask,                                 =
 \
> +}
> +
> +#define MT6392_LDO_LINEAR(match, vreg, min, max, step, volt_ranges,    \
> +               enreg, enbit, vosel, vosel_mask, _modeset_reg,          \
> +               _modeset_mask, entime)                                  \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_ldo_range_ops,                     =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D ((max) - (min)) / (step) + 1,            =
 \
> +               .linear_ranges =3D volt_ranges,                          =
 \
> +               .n_linear_ranges =3D ARRAY_SIZE(volt_ranges),            =
 \
> +               .vsel_reg =3D vosel,                                     =
 \
> +               .vsel_mask =3D vosel_mask,                               =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(enbit),                             =
 \
> +               .enable_time =3D entime,                                 =
 \
> +       },                                                              \
> +       .qi =3D BIT(15),                                                 =
 \
> +       .modeset_reg =3D _modeset_reg,                                   =
 \
> +       .modeset_mask =3D _modeset_mask,                                 =
 \
> +}
> +
> +#define MT6392_REG_FIXED(match, vreg, enreg, enbit, volt,              \
> +               _modeset_reg, _modeset_mask, entime)                    \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_fixed_ops,                         =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D 1,                                       =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(enbit),                             =
 \
> +               .enable_time =3D entime,                                 =
 \
> +               .min_uV =3D volt,                                        =
 \
> +       },                                                              \
> +       .qi =3D BIT(15),                                                 =
 \
> +       .modeset_reg =3D _modeset_reg,                                   =
 \
> +       .modeset_mask =3D _modeset_mask,                                 =
 \
> +}
> +
> +#define MT6392_REG_FIXED_NO_MODE(match, vreg, enreg, enbit, volt,      \
> +       entime)                                                         \
> +[MT6392_ID_##vreg] =3D {                                                =
 \
> +       .desc =3D {                                                      =
 \
> +               .name =3D #vreg,                                         =
 \
> +               .of_match =3D of_match_ptr(match),                       =
 \
> +               .ops =3D &mt6392_volt_fixed_no_mode_ops,                 =
 \
> +               .type =3D REGULATOR_VOLTAGE,                             =
 \
> +               .id =3D MT6392_ID_##vreg,                                =
 \
> +               .owner =3D THIS_MODULE,                                  =
 \
> +               .n_voltages =3D 1,                                       =
 \
> +               .enable_reg =3D enreg,                                   =
 \
> +               .enable_mask =3D BIT(enbit),                             =
 \
> +               .enable_time =3D entime,                                 =
 \
> +               .min_uV =3D volt,                                        =
 \
> +       },                                                              \
> +       .qi =3D BIT(15),                                                 =
 \
> +}
> +
> +static const struct linear_range buck_volt_range1[] =3D {
> +       REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250),
> +};
> +
> +static const struct linear_range buck_volt_range2[] =3D {
> +       REGULATOR_LINEAR_RANGE(1400000, 0, 0x7f, 12500),
> +};
> +
> +static const u32 ldo_volt_table1[] =3D {
> +       1800000, 1900000, 2000000, 2200000,
> +};
> +
> +static const struct linear_range ldo_volt_range2[] =3D {
> +       REGULATOR_LINEAR_RANGE(3300000, 0, 3, 100000),
> +};
> +
> +static const u32 ldo_volt_table3[] =3D {
> +       1800000, 3300000,
> +};
> +
> +static const u32 ldo_volt_table4[] =3D {
> +       3000000, 3300000,
> +};
> +
> +static const u32 ldo_volt_table5[] =3D {
> +       1200000, 1300000, 1500000, 1800000, 2000000, 2800000, 3000000, 33=
00000,
> +};
> +
> +static const u32 ldo_volt_table6[] =3D {
> +       1240000, 1390000,
> +};
> +
> +static const u32 ldo_volt_table7[] =3D {
> +       1200000, 1300000, 1500000, 1800000,
> +};
> +
> +static const u32 ldo_volt_table8[] =3D {
> +       1800000, 2000000,
> +};

If this PMIC is anything like the MT6358, then it has 0.01V fine
tuning for most if not all the LDOs. It is sometimes needed as
a rail may have a 0.04V boost that would otherwise be invisible
to the system. And then if you have something like 3.04V set in
the DT constraints, you end up with something the regulator driver
doesn't support, but the hardware does.

Please see how it's done in the MT6358 driver. I spent a lot of
time on that driver to make it actually support the full range
of voltages, and describing the supplies.


ChenYu
