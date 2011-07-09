From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH v3 0/3] mc13783: add pwr button support
Date: Sun, 10 Jul 2011 01:06:33 +0200
Message-ID: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:44241 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754868Ab1GIWhb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Jul 2011 18:37:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch

Hello

This add button handling for the MC13783 PMIC.
The first patch modify the mc13783 MFD driver to add a button
subdevice and also adds the mc13783-pwrbutton driver using a misc
input device.

The second patch adds the power on button support to the mx31moboard bo=
ards.

The third patch is optional and modify the mc13xxx driver to use the pl=
atform=20
data to check if the leds and buttons subdevices should be enabled.

We need to keep the regulator flags as the regulator platform data can =
be NULL
on mc13892.

v2: first patch modified according to comments by Dmitry Torokhov
v3: Implement review by Uwe

Philippe R=C3=A9tornaz (3):
  mc13783: add power button support
  mx31moboard: Add MC13783 power button support
  mc13xxx: implicitly enable leds and buttons

 arch/arm/mach-imx/mach-mx31moboard.c   |   10 +-
 drivers/input/misc/Kconfig             |   10 +
 drivers/input/misc/Makefile            |    1 +
 drivers/input/misc/mc13783-pwrbutton.c |  288 ++++++++++++++++++++++++=
++++++++
 drivers/mfd/mc13xxx-core.c             |    6 +-
 include/linux/mfd/mc13783.h            |    2 +-
 include/linux/mfd/mc13xxx.h            |   18 ++-
 7 files changed, 331 insertions(+), 4 deletions(-)
 create mode 100644 drivers/input/misc/mc13783-pwrbutton.c

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
