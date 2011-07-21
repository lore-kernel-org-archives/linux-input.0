From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH v5 0/6] mc13783: add pwr button support
Date: Thu, 21 Jul 2011 20:04:17 +0200
Message-ID: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.epfl.ch ([128.178.224.226]:36333 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751419Ab1GUSEr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2011 14:04:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch

Hello

This add button handling for the MC13783 PMIC.

Patch 1 & 2 modify the mc13xxx MFD driver to use the platform data to
resgister the led subdevice and unconditionally register the regulator
subdevice (as suggested by Mark and Uwe).

Patch 3 remove the use of the *_USE_REGULATOR and *_USE_LED macros in
the platform files.

Patch 4 must be applied after patch 1,2,3 to remove the obsolete define=
=2E

Patch 5 modify the mc13xxx MFD driver to add a button subdevice and
also adds the mc13783-pwrbutton driver using a misc input device.

The last patch adds the power on button support to the mx31moboard boar=
ds.

v2: first patch modified according to comments by Dmitry Torokhov
v3: Implement review by Uwe
v4: Implement comments by Uwe and Mark
v5: Reorder patchset

Philippe R=C3=A9tornaz (6):
  mc13xxx: Unconditionally register regulator subdevice
  mc13xxx: implicitly register led subdevice
  mc13xxx: remove obsolete leds and regualtors flags
  mc13xxx: remove unused define
  mc13783: add power button support
  mx31moboard: Add MC13783 power button support

 arch/arm/mach-imx/mach-mx27_3ds.c      |    1 -
 arch/arm/mach-imx/mach-mx31_3ds.c      |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c      |    3 +-
 arch/arm/mach-imx/mach-mx31moboard.c   |   11 +-
 arch/arm/mach-imx/mach-pcm038.c        |    3 +-
 arch/arm/mach-mx5/mx51_efika.c         |    2 +-
 drivers/input/misc/Kconfig             |   10 +
 drivers/input/misc/Makefile            |    1 +
 drivers/input/misc/mc13783-pwrbutton.c |  288 ++++++++++++++++++++++++=
++++++++
 drivers/mfd/mc13xxx-core.c             |   12 +-
 include/linux/mfd/mc13783.h            |    3 +-
 include/linux/mfd/mc13xxx.h            |   19 ++-
 12 files changed, 337 insertions(+), 18 deletions(-)
 create mode 100644 drivers/input/misc/mc13783-pwrbutton.c

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
