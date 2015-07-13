From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH v3 0/9] regulator: Merge max77843 into max77693
Date: Mon, 13 Jul 2015 13:12:16 +0900
Message-ID: <CAJKOXPc94465zp2xToXUPFMDeCU9T017F04eqhh39uxyE4xVtA@mail.gmail.com>
References: <1436353217-1141-1-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1436353217-1141-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

2015-07-08 20:00 GMT+09:00 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>:
> Dear Mark,
>
>
> The patchset merges max77843 regulator driver into max77693.
>
> It touches multiple subsystems so I think the best way would be to
> merge it through one tree. I already got acks from extcon, input
> mfd and power maintainers.
>
> If there are no objections then everything could go through regulator
> tree.

The rebasing was insufficient. A new driver was recently added -
leds-nax77693 which I did not update. I will post an fixed version.

Krzysztof

>
>
> Changes since v2
> ================
> 1. Rebase on v4.2-rc1.
> 2. Add acks: Chanwoo Choi, Dmitry Torokhov, Lee Jones. Thanks!
>
>
> Changes since v1
> ================
> 1. Drop patch "regulator: max77693: Use core code for charger's
>    is_enabled" because Mark Brown picked it up.
> 2. Patch 2: remove some more old IRQ extcon stuff (suggested by Chanwoo
>    Choi).
> 3. Patch 6: minor fixes over defines (suggested by Lee Jones).
> 4. Send last patch, previously it slipped during "git send-email".
> 5. Add acks obtained for v1. I still need more of them.
>
>
> Rationale
> =========
> The recently added max77843 regulator driver is very similar to
> its older brother: the max77693. Both devices provide two safeouts
> and a charger.
>
> The main difference is in charger's output capabilities and related
> registry values.
>
> With some code additions the max77693 regulator driver can support both
> chipsets. This reduces overall code duplication and is a first step
> toward integrating other drivers for these devices. I plan to merge
> also input/haptic drivers.
>
>
> Patchset description
> ====================
> Patches 1-2 do various cleanup.
> Patch 3 prepares max77694 regulator driver for supporting different
> devices.
> Patch 4 switches max77693 drivers to common state container.
> Patch 5 updates max77843 drivers to common state container.
> Patches 6-7 do final cleanup before merging.
> Patches 8-9 do the merge of max77843 regulator into max77693.
>
>
> Dependencies
> ============
> Everything is bisectable but next patches depend on previous ones.
> So probably the easiest way would be picking picked up by one
> maintainer.
>
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (9):
>   mfd/extcon: max77693: Remove unused extern declarations and
>     max77693_dev members
>   mfd: max77693: Store I2C device type as enum and add default unknown
>   regulator: max77693: Support different register configurations
>   extcon/input/mfd/power/regulator: max77693: Move state container to
>     common header
>   extcon/input/mfd/regulator: max77843: Switch to common max77693 state
>     container
>   mfd/extcon: max77693: Rename defines to allow inclusion with max77843
>   mfd/extcon: max77843: Rename defines to allow inclusion with max77693
>   regulator: max77693: Add support for MAX77843 device
>   regulator: Remove the max77843 driver
>
>  drivers/extcon/extcon-max77693.c     |  94 +++++++---------
>  drivers/extcon/extcon-max77843.c     |  66 +++++++-----
>  drivers/input/misc/max77693-haptic.c |   1 +
>  drivers/input/misc/max77843-haptic.c |   3 +-
>  drivers/mfd/max77693.c               |  31 +++---
>  drivers/mfd/max77843.c               |  20 ++--
>  drivers/power/max77693_charger.c     |   1 +
>  drivers/regulator/Kconfig            |  16 +--
>  drivers/regulator/Makefile           |   1 -
>  drivers/regulator/max77693.c         | 161 ++++++++++++++++++++++++----
>  drivers/regulator/max77843.c         | 201 -----------------------------------
>  include/linux/mfd/max77693-common.h  |  49 +++++++++
>  include/linux/mfd/max77693-private.h | 134 +++++++++--------------
>  include/linux/mfd/max77843-private.h | 174 ++++++++++++++----------------
>  14 files changed, 432 insertions(+), 520 deletions(-)
>  delete mode 100644 drivers/regulator/max77843.c
>  create mode 100644 include/linux/mfd/max77693-common.h
>
> --
> 2.1.4
>
