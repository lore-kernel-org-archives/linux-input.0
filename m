From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [rtc-linux] [PATCH 3/3] drivers: rtc: Add support for Qualcomm
 PMIC8xxx RTC
Date: Fri, 1 Apr 2011 00:48:03 +0800
Message-ID: <AANLkTi=Wteb54qBkLwRTOBr81=3da_FExOmUYE9-3-yX@mail.gmail.com>
References: <1301158345-22206-1-git-send-email-aghayal@codeaurora.org>
	<1301158345-22206-4-git-send-email-aghayal@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f66.google.com ([74.125.82.66]:37528 "EHLO
	mail-ww0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab1CaQsG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2011 12:48:06 -0400
In-Reply-To: <1301158345-22206-4-git-send-email-aghayal@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rtc-linux@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Anirudh Ghayal <aghayal@codeaurora.org>, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, Lars-Peter Clausen <lars@metafoo.de>

Hi Anirudh,

Some advice below:

2011/3/27 Anirudh Ghayal <aghayal@codeaurora.org>:
> PMIC8xxx is Qualcomm's power management IC. A
> 32-bit RTC is housed inside this PMIC. The RTC driver
> uses SSBI to communicate with the RTC module.
>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Anirudh Ghayal <aghayal@codeaurora.org>
> ---
> =C2=A0drivers/rtc/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A09 +
> =C2=A0drivers/rtc/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A01 +
> =C2=A0drivers/rtc/rtc-pm8xxx.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0567 +++++=
+++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/mfd/pm8xxx/rtc.h | =C2=A0 25 ++
> =C2=A04 files changed, 602 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 drivers/rtc/rtc-pm8xxx.c
> =C2=A0create mode 100644 include/linux/mfd/pm8xxx/rtc.h
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index e187887..a66672a 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -995,4 +995,13 @@ config RTC_DRV_TEGRA
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This drive can also be built as a m=
odule. If so, the module
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be called rtc-tegra.
>
> +config RTC_DRV_PM8XXX
> + =C2=A0 =C2=A0 =C2=A0 tristate "Qualcomm PMIC8XXX RTC"
> + =C2=A0 =C2=A0 =C2=A0 depends on MFD_PM8XXX
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say Y here if you want to support the Q=
ualcomm PMIC8XXX RTC.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, cho=
ose M here: the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 module will be called rtc-pm8xxx.
> +
> =C2=A0endif # RTC_CLASS
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index ca91c3c..ff40366 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_RTC_DRV_PCF8563) +=3D rtc-pcf8563.o
> =C2=A0obj-$(CONFIG_RTC_DRV_PCF8583) =C2=A0+=3D rtc-pcf8583.o
> =C2=A0obj-$(CONFIG_RTC_DRV_PCF2123) =C2=A0+=3D rtc-pcf2123.o
> =C2=A0obj-$(CONFIG_RTC_DRV_PCF50633) +=3D rtc-pcf50633.o
> +obj-$(CONFIG_RTC_DRV_PM8XXX) =C2=A0 =C2=A0+=3D rtc-pm8xxx.o
> =C2=A0obj-$(CONFIG_RTC_DRV_PL030) =C2=A0 =C2=A0+=3D rtc-pl030.o
> =C2=A0obj-$(CONFIG_RTC_DRV_PL031) =C2=A0 =C2=A0+=3D rtc-pl031.o
> =C2=A0obj-$(CONFIG_RTC_DRV_PS3) =C2=A0 =C2=A0 =C2=A0+=3D rtc-ps3.o
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> new file mode 100644
> index 0000000..ce2dad3
> --- /dev/null
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -0,0 +1,567 @@
> +/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See th=
e
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +

 why add pr_fmt here?

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rtc.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include<linux/spinlock.h>
> +
> +#include <linux/mfd/pm8xxx/core.h>
> +#include <linux/mfd/pm8xxx/rtc.h>
> +
> +/* RTC Register offsets from RTC CTRL REG */
> +#define PM8XXX_ALARM_CTRL_OFFSET 0x01
> +#define PM8XXX_RTC_WRITE_OFFSET 0x02
> +#define PM8XXX_RTC_READ_OFFSET 0x06
> +#define PM8XXX_ALARM_RW_OFFSET 0x0A
> +
> +/* RTC_CTRL register bit fields */
> +#define PM8xxx_RTC_ENABLE =C2=A0 =C2=A0 =C2=A0BIT(7)
> +#define PM8xxx_RTC_ALARM_ENABLE =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(1)
> +#define PM8xxx_RTC_ALARM_CLEAR =C2=A0BIT(0)
> +
> +#define NUM_8_BIT_RTC_REGS =C2=A0 =C2=A0 0x4
> +
> +/**
> + * struct pm8xxx_rtc - rtc driver internal structure
> + * @rtc: rtc device for this driver
> + * @rtc_alarm_irq: rtc alarm irq number
> + */
> +struct pm8xxx_rtc {
> + =C2=A0 =C2=A0 =C2=A0 struct rtc_device *rtc;
> + =C2=A0 =C2=A0 =C2=A0 int rtc_alarm_irq;
> + =C2=A0 =C2=A0 =C2=A0 int rtc_base;
> + =C2=A0 =C2=A0 =C2=A0 int rtc_read_base;
> + =C2=A0 =C2=A0 =C2=A0 int rtc_write_base;
> + =C2=A0 =C2=A0 =C2=A0 int alarm_rw_base;
> + =C2=A0 =C2=A0 =C2=A0 u8 =C2=A0ctrl_reg;
> + =C2=A0 =C2=A0 =C2=A0 struct device *parent;
> + =C2=A0 =C2=A0 =C2=A0 spinlock_t ctrl_reg_lock;
> +};
> +
> +/*
> + * The RTC registers need to be read/written one byte at a time. Thi=
s is a
> + * hardware limitation.
> + */
> +static int pm8xxx_read_wrapper(struct pm8xxx_rtc *rtc_dd, u8 *rtc_va=
l,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int base, int count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i, rc;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < count; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_read=
b(rtc_dd->parent, base + i, &rtc_val[i]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pr_err("PM8xxx read failed\n");

All pr_err are not so good, please try to use dev_err.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return rc;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int pm8xxx_write_wrapper(struct pm8xxx_rtc *rtc_dd, u8 *rtc_v=
al,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int base, int count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int i, rc;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < count; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_writ=
eb(rtc_dd->parent, base + i, rtc_val[i]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pr_err("PM8xxx write failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return rc;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +
> +/*
> + * Steps to write the RTC registers.
> + * 1. Disable alarm if enabled.
> + * 2. Write 0x00 to LSB.
> + * 3. Write Byte[1], Byte[2], Byte[3] then Byte[0].
> + * 4. Enable alarm if disabled in step 1.
> + */
> +static int
> +pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int rc;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long secs, irq_flags;
> + =C2=A0 =C2=A0 =C2=A0 u8 value[4], reg =3D 0, alarm_enabled =3D 0, c=
trl_reg;
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd =3D dev_get_drvdata(=
dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_tm_to_time(tm, &secs);
> +
> + =C2=A0 =C2=A0 =C2=A0 value[0] =3D secs & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 value[1] =3D (secs >> 8) & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 value[2] =3D (secs >> 16) & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 value[3] =3D (secs >> 24) & 0xFF;
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(dev, "Seconds value to be written to R=
TC =3D %lu\n", secs);
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_=
flags);
> + =C2=A0 =C2=A0 =C2=A0 ctrl_reg =3D rtc_dd->ctrl_reg;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ctrl_reg & PM8xxx_RTC_ALARM_ENABLE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm_enabled =3D =
1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctrl_reg &=3D ~PM8=
xxx_RTC_ALARM_ENABLE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_writ=
e_wrapper(rtc_dd, &ctrl_reg, rtc_dd->rtc_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(dev, "PM8xxx write failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto rtc_rw_fail;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqres=
tore(&rtc_dd->ctrl_reg_lock, irq_flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Write Byte[1], Byte[2], Byte[3], Byte[0] */
> + =C2=A0 =C2=A0 =C2=A0 /* Write 0 to Byte[0] */
> + =C2=A0 =C2=A0 =C2=A0 reg =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_write_wrapper(rtc_dd, &reg, rtc_=
dd->rtc_write_base, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "PM8x=
xx write failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto rtc_rw_fail;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Write Byte[1], Byte[2], Byte[3] */
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_write_wrapper(rtc_dd, value + 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtc_dd-=
>rtc_write_base + 1, 3);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Writ=
e to RTC registers failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto rtc_rw_fail;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Write Byte[0] */
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_write_wrapper(rtc_dd, value, rtc=
_dd->rtc_write_base, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Writ=
e to RTC register failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto rtc_rw_fail;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (alarm_enabled) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctrl_reg |=3D PM8x=
xx_RTC_ALARM_ENABLE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_writ=
e_wrapper(rtc_dd, &ctrl_reg, rtc_dd->rtc_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(dev, "PM8xxx write failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto rtc_rw_fail;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->ctrl_reg =3D ctrl_reg;
> +
> +rtc_rw_fail:
> + =C2=A0 =C2=A0 =C2=A0 if (alarm_enabled)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqres=
tore(&rtc_dd->ctrl_reg_lock, irq_flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 return rc;
> +}
> +
> +static int
> +pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int rc;
> + =C2=A0 =C2=A0 =C2=A0 u8 value[4], reg;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long secs;
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd =3D dev_get_drvdata(=
dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_read_wrapper(rtc_dd, value, rtc_=
dd->rtc_read_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NUM_8_BIT_RTC_REGS);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "RTC =
time read failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Read the LSB again and check if there =
has been a carry over.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* If there is, redo the read operation.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_read_wrapper(rtc_dd, &reg, rtc_d=
d->rtc_read_base, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "PM8x=
xx read failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (unlikely(reg < value[0])) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_read=
_wrapper(rtc_dd, value,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtc_dd->rtc_read_base, NUM_8_BIT_RT=
C_REGS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(dev, "RTC time read failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return rc;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 secs =3D value[0] | (value[1] << 8) | (value[2=
] << 16) \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | (value[3] << 24);
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_time_to_tm(secs, tm);
> +
> + =C2=A0 =C2=A0 =C2=A0 rc =3D rtc_valid_tm(tm);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Inva=
lid time read from PM8xxx\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(dev, "secs =3D %lu, h:m:s =3D=3D %d:%d=
:%d, d/m/y =3D %d/%d/%d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 secs, tm->tm_hour, tm->tm_min, tm->tm_sec,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 tm->tm_mday, tm->tm_mon, tm->tm_year);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int
> +pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int rc;
> + =C2=A0 =C2=A0 =C2=A0 u8 value[4], ctrl_reg;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long secs, secs_rtc, irq_flags;
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd =3D dev_get_drvdata(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 struct rtc_time rtc_tm;
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_tm_to_time(&alarm->time, &secs);
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Read the current RTC time and verify i=
f the alarm time is in the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* past. If yes, return invalid.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_rtc_read_time(dev, &rtc_tm);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Unam=
ble to read RTC time\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_tm_to_time(&rtc_tm, &secs_rtc);
> + =C2=A0 =C2=A0 =C2=A0 if (secs < secs_rtc) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Tryi=
ng to set alarm in the past\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 value[0] =3D secs & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 value[1] =3D (secs >> 8) & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 value[2] =3D (secs >> 16) & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 value[3] =3D (secs >> 24) & 0xFF;
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_=
flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_write_wrapper(rtc_dd, value, rtc=
_dd->alarm_rw_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NUM_8_BIT_RTC_REGS);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Writ=
e to RTC ALARM registers failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto rtc_rw_fail;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ctrl_reg =3D rtc_dd->ctrl_reg;
> + =C2=A0 =C2=A0 =C2=A0 ctrl_reg =3D (alarm->enabled) ? (ctrl_reg | PM=
8xxx_RTC_ALARM_ENABLE) :
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ctrl_r=
eg & ~PM8xxx_RTC_ALARM_ENABLE);
> +
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_write_wrapper(rtc_dd, &ctrl_reg,=
 rtc_dd->rtc_base, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "PM8x=
xx write failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto rtc_rw_fail;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->ctrl_reg =3D ctrl_reg;
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(dev, "Alarm Set for h:r:s=3D%d:%d:%d, =
d/m/y=3D%d/%d/%d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 alarm->time.tm_hour, alarm->time.tm_min,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 alarm->time.tm_sec, alarm->time.tm_mday,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 alarm->time.tm_mon, alarm->time.tm_year);
> +rtc_rw_fail:
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock,=
 irq_flags);
> + =C2=A0 =C2=A0 =C2=A0 return rc;
> +}
> +
> +static int
> +pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int rc;
> + =C2=A0 =C2=A0 =C2=A0 u8 value[4];
> + =C2=A0 =C2=A0 =C2=A0 unsigned long secs;
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd =3D dev_get_drvdata(=
dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_read_wrapper(rtc_dd, value, rtc_=
dd->alarm_rw_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 NUM_8_BIT_RTC_REGS);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "RTC =
alarm time read failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 secs =3D value[0] | (value[1] << 8) | (value[2=
] << 16) | \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(value[3] << 24);
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_time_to_tm(secs, &alarm->time);
> +
> + =C2=A0 =C2=A0 =C2=A0 rc =3D rtc_valid_tm(&alarm->time);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "Inva=
lid time read from PM8xxx\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(dev, "Alarm set for - h:r:s=3D%d:%d:%d=
, d/m/y=3D%d/%d/%d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_hou=
r, alarm->time.tm_min,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_sec, alarm->time.tm_=
mday,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm->time.tm_mon, alarm->time.tm_=
year);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +
> +static int
> +pm8xxx_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int rc;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long irq_flags;
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd =3D dev_get_drvdata(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 u8 ctrl_reg;
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_=
flags);
> + =C2=A0 =C2=A0 =C2=A0 ctrl_reg =3D rtc_dd->ctrl_reg;
> + =C2=A0 =C2=A0 =C2=A0 ctrl_reg =3D (enabled) ? (ctrl_reg | PM8xxx_RT=
C_ALARM_ENABLE) :
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ctrl_reg & ~PM8xxx_RTC_ALARM_ENABL=
E);
> +
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_write_wrapper(rtc_dd, &ctrl_reg,=
 rtc_dd->rtc_base, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "PM8x=
xx write failed\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto rtc_rw_fail;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->ctrl_reg =3D ctrl_reg;
> +
> +rtc_rw_fail:
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock,=
 irq_flags);
> + =C2=A0 =C2=A0 =C2=A0 return rc;
> +}
> +
> +static struct rtc_class_ops pm8xxx_rtc_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 .read_time =C2=A0 =C2=A0 =C2=A0=3D pm8xxx_rtc_=
read_time,
> + =C2=A0 =C2=A0 =C2=A0 .set_alarm =C2=A0 =C2=A0 =C2=A0=3D pm8xxx_rtc_=
set_alarm,
> + =C2=A0 =C2=A0 =C2=A0 .read_alarm =C2=A0 =C2=A0 =3D pm8xxx_rtc_read_=
alarm,
> + =C2=A0 =C2=A0 =C2=A0 .alarm_irq_enable =3D pm8xxx_rtc_alarm_irq_ena=
ble,
> +};
> +
> +static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd =3D dev_id;
> + =C2=A0 =C2=A0 =C2=A0 u8 ctrl_reg;
> + =C2=A0 =C2=A0 =C2=A0 int rc;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long irq_flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_update_irq(rtc_dd->rtc, 1, RTC_IRQF | RTC_=
AF);
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_=
flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Clear the alarm enable bit */
> + =C2=A0 =C2=A0 =C2=A0 ctrl_reg =3D rtc_dd->ctrl_reg;
> + =C2=A0 =C2=A0 =C2=A0 ctrl_reg &=3D ~PM8xxx_RTC_ALARM_ENABLE;
> +
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_write_wrapper(rtc_dd, &ctrl_reg,=
 rtc_dd->rtc_base, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqres=
tore(&rtc_dd->ctrl_reg_lock, irq_flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("PM8xxx wri=
te failed!\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto rtc_alarm_han=
dled;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->ctrl_reg =3D ctrl_reg;
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock,=
 irq_flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Clear RTC alarm register */
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_read_wrapper(rtc_dd, &ctrl_reg, =
rtc_dd->rtc_base +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 PM8XXX_ALARM_CTRL_OFFSET, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("PM8xxx wri=
te failed!\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto rtc_alarm_han=
dled;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ctrl_reg &=3D ~PM8xxx_RTC_ALARM_CLEAR;
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_write_wrapper(rtc_dd, &ctrl_reg,=
 rtc_dd->rtc_base +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 PM8XXX_ALARM_CTRL_OFFSET, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("PM8xxx wri=
te failed!\n");
> +
> +rtc_alarm_handled:
> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> +}
> +
> +static int __devinit pm8xxx_rtc_probe(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int rc;
> + =C2=A0 =C2=A0 =C2=A0 u8 ctrl_reg;
> + =C2=A0 =C2=A0 =C2=A0 bool rtc_write_enable =3D false;
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd;
> + =C2=A0 =C2=A0 =C2=A0 struct resource *rtc_resource;
> + =C2=A0 =C2=A0 =C2=A0 const struct pm8xxx_rtc_platform_data *pdata =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev->dev.platform=
_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (pdata !=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtc_write_enable =3D=
 pdata->rtc_write_enable;
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd =3D kzalloc(sizeof(*rtc_dd), GFP_KERNEL=
);
> + =C2=A0 =C2=A0 =C2=A0 if (rtc_dd =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "Unable to allocate memory!\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Initialise spinlock to protect RTC cntrol r=
egister */
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&rtc_dd->ctrl_reg_lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->rtc_alarm_irq =3D platform_get_irq(pde=
v, 0);
> + =C2=A0 =C2=A0 =C2=A0 if (!rtc_dd->rtc_alarm_irq) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "Alarm IRQ resource absent!\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D -ENXIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail_rtc_enab=
le;
> + =C2=A0 =C2=A0 =C2=A0 }
> +

In fact, the 'platform_get_irq' maybe return -ENXIO, so you should use
the 'if (rtc_dd->rtc_alarm_irq < 0)' instead of  '!' to judge
the get irq action.

> + =C2=A0 =C2=A0 =C2=A0 rtc_resource =3D platform_get_resource_byname(=
pdev, IORESOURCE_IO,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "pmic_rtc_base");
> + =C2=A0 =C2=A0 =C2=A0 if (rtc_resource)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtc_dd->rtc_base =3D=
 rtc_resource->start;
> + =C2=A0 =C2=A0 =C2=A0 if (!rtc_dd->rtc_base) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "RTC IO resource absent!\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D -ENXIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail_rtc_enab=
le;
> + =C2=A0 =C2=A0 =C2=A0 }


      rtc_resource =3D platform_get_resource_byname(pdev, IORESOURCE_IO=
,
                                                       "pmic_rtc_base")=
;
       if !(rtc_resource && rtc_resource->start) {
               dev_err(&pdev->dev, "RTC IO resource absent!\n");
               rc =3D -ENXIO;
               goto fail_rtc_enable;
       }
     rtc_dd->rtc_base =3D rtc_resource->start;

Do you think above code style is better?

> +
> + =C2=A0 =C2=A0 =C2=A0 /* Setup RTC register addresses */
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->rtc_write_base =3D rtc_dd->rtc_base + =
PM8XXX_RTC_WRITE_OFFSET;
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->rtc_read_base =3D rtc_dd->rtc_base + P=
M8XXX_RTC_READ_OFFSET;
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->alarm_rw_base =3D rtc_dd->rtc_base + P=
M8XXX_ALARM_RW_OFFSET;
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->parent =3D pdev->dev.parent;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Check if the RTC is on, else turn it on */
> + =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_read_wrapper(rtc_dd, &ctrl_reg, =
rtc_dd->rtc_base, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "PM8xxx read failed!\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail_rtc_enab=
le;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!(ctrl_reg & PM8xxx_RTC_ENABLE)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctrl_reg |=3D PM8x=
xx_RTC_ENABLE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D pm8xxx_writ=
e_wrapper(rtc_dd, &ctrl_reg, rtc_dd->rtc_base,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(&pdev->dev, "PM8xxx write failed!\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto fail_rtc_enable;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->ctrl_reg =3D ctrl_reg;
> + =C2=A0 =C2=A0 =C2=A0 if (rtc_write_enable =3D=3D true)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm8xxx_rtc_ops.set=
_time =3D pm8xxx_rtc_set_time,
> +
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, rtc_dd);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Register the RTC device */
> + =C2=A0 =C2=A0 =C2=A0 rtc_dd->rtc =3D rtc_device_register("pm8xxx_rt=
c", &pdev->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &pm8xxx_rtc_ops, THIS_MODULE);
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(rtc_dd->rtc)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "%s: RTC registration failed (%ld)\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func_=
_, PTR_ERR(rtc_dd->rtc));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D PTR_ERR(rtc=
_dd->rtc);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail_rtc_enab=
le;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Request the alarm IRQ */
> + =C2=A0 =C2=A0 =C2=A0 rc =3D request_any_context_irq(rtc_dd->rtc_ala=
rm_irq,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm8xxx_alarm_trigger, IRQF_TR=
IGGER_RISING,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"pm8xxx_rtc_alarm", rtc_dd);
> + =C2=A0 =C2=A0 =C2=A0 if (rc < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "Request IRQ failed (%d)\n", rc);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail_req_irq;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 device_init_wakeup(&pdev->dev, 1);
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(&pdev->dev, "Probe success !!\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +fail_req_irq:
> + =C2=A0 =C2=A0 =C2=A0 rtc_device_unregister(rtc_dd->rtc);
> +fail_rtc_enable:
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
> + =C2=A0 =C2=A0 =C2=A0 kfree(rtc_dd);
> + =C2=A0 =C2=A0 =C2=A0 return rc;
> +}
> +
> +#ifdef CONFIG_PM
> +static int pm8xxx_rtc_resume(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd =3D dev_get_drvdata(=
dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (device_may_wakeup(dev))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disable_irq_wake(r=
tc_dd->rtc_alarm_irq);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int pm8xxx_rtc_suspend(struct device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd =3D dev_get_drvdata(=
dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (device_may_wakeup(dev))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_irq_wake(rt=
c_dd->rtc_alarm_irq);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static const struct dev_pm_ops pm8xxx_rtc_pm_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 .suspend =3D pm8xxx_rtc_suspend,
> + =C2=A0 =C2=A0 =C2=A0 .resume =3D pm8xxx_rtc_resume,
> +};
> +#endif
> +static int __devexit pm8xxx_rtc_remove(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct pm8xxx_rtc *rtc_dd =3D platform_get_drv=
data(pdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 device_init_wakeup(&pdev->dev, 0);
> + =C2=A0 =C2=A0 =C2=A0 free_irq(rtc_dd->rtc_alarm_irq, rtc_dd);
> + =C2=A0 =C2=A0 =C2=A0 rtc_device_unregister(rtc_dd->rtc);
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
> + =C2=A0 =C2=A0 =C2=A0 kfree(rtc_dd);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct platform_driver pm8xxx_rtc_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D p=
m8xxx_rtc_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __deve=
xit_p(pm8xxx_rtc_remove),
> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D P=
M8XXX_RTC_DEV_NAME,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =C2=A0=3D T=
HIS_MODULE,
> +#ifdef CONFIG_PM
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pm =C2=A0 =C2=A0 =
=3D &pm8xxx_rtc_pm_ops,
> +#endif
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +static int __init pm8xxx_rtc_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&pm8xxx_rtc_dr=
iver);
> +}
> +module_init(pm8xxx_rtc_init);
> +
> +static void __exit pm8xxx_rtc_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&pm8xxx_rtc_driver)=
;
> +}
> +module_exit(pm8xxx_rtc_exit);
> +
> +MODULE_ALIAS("platform:rtc-pm8xxx");
> +MODULE_DESCRIPTION("PMIC8xxx RTC driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Anirudh Ghayal <aghayal@codeaurora.org>");
> diff --git a/include/linux/mfd/pm8xxx/rtc.h b/include/linux/mfd/pm8xx=
x/rtc.h
> new file mode 100644
> index 0000000..2528e1d
> --- /dev/null
> +++ b/include/linux/mfd/pm8xxx/rtc.h
> @@ -0,0 +1,25 @@
> +/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See th=
e
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __RTC_PM8XXX_H__
> +#define __RTC_PM8XXX_H__
> +
> +#define PM8XXX_RTC_DEV_NAME =C2=A0 =C2=A0 "rtc-pm8xxx"
> +/**
> + * struct pm8058_rtc_pdata - RTC driver platform data
> + * @rtc_write_enable: variable stating RTC write capability
> + */
> +struct pm8xxx_rtc_platform_data {
> + =C2=A0 =C2=A0 =C2=A0 bool rtc_write_enable;
> +};
> +
> +#endif /* __RTC_PM8XXX_H__ */
> --
> 1.7.3.5
>
> --
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.



--=20
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel@lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900@googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
