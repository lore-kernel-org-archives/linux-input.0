From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH v6 0/6] mc13783: add pwr button support
Date: Mon, 25 Jul 2011 15:12:01 +0800
Message-ID: <4E2D1741.6020502@cn.fujitsu.com>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:65295 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab1GYHNF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 03:13:05 -0400
In-Reply-To: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@epfl.ch>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, shawn.guo@freescale.com

On 07/22/2011 10:17 PM, Philippe R=C3=A9tornaz wrote:
> Hello
>
> This add button handling for the MC13783 PMIC.
>
> Patch 1&  2 modify the mc13xxx MFD driver to use the platform data to
> resgister the led subdevice and unconditionally register the regulato=
r
> subdevice (as suggested by Mark and Uwe).
>
> Patch 3 remove the use of the *_USE_REGULATOR and *_USE_LED macros in
> the platform files.
>
> Patch 4 must be applied after patch 1,2,3 to remove the obsolete defi=
ne.
>
> Patch 5 modify the mc13xxx MFD driver to add a button subdevice and
> also adds the mc13783-pwrbutton driver using a misc input device.
>
> The last patch adds the power on button support to the mx31moboard bo=
ards.
>
> v2: first patch modified according to comments by Dmitry Torokhov
> v3: Implement review by Uwe
> v4: Implement comments by Uwe and Mark
> v5: Reorder patchset
> v6: Minor corrections
>
> Philippe R=C3=A9tornaz (6):
>    mc13xxx: Unconditionally register regulator subdevice
>    mc13xxx: implicitly register led subdevice
>    mc13xxx: remove obsolete leds and regulators flags
>    mc13xxx: remove unused define
>    mc13783: add power button support
>    mx31moboard: Add MC13783 power button support
>
>   arch/arm/mach-imx/mach-mx27_3ds.c      |    1 -
>   arch/arm/mach-imx/mach-mx31_3ds.c      |    2 +-
>   arch/arm/mach-imx/mach-mx31lite.c      |    3 +-
>   arch/arm/mach-imx/mach-mx31moboard.c   |   11 +-
>   arch/arm/mach-imx/mach-pcm038.c        |    3 +-
>   arch/arm/mach-mx5/mx51_efika.c         |    2 +-
>   drivers/input/misc/Kconfig             |   10 +
>   drivers/input/misc/Makefile            |    1 +
>   drivers/input/misc/mc13783-pwrbutton.c |  282 +++++++++++++++++++++=
+++++++++++
>   drivers/mfd/mc13xxx-core.c             |   17 ++-
>   include/linux/mfd/mc13783.h            |    3 +-
>   include/linux/mfd/mc13xxx.h            |   19 ++-
>   12 files changed, 336 insertions(+), 18 deletions(-)
>   create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
>
Seems good now, cheers.


--=20
Thanks
Best Regards
Wanlong Gao
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
