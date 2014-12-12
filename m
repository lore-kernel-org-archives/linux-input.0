From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v6 0/2] Add regulator-haptic driver
Date: Fri, 12 Dec 2014 19:32:27 +0900
Message-ID: <1418380349-32588-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60334 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933677AbaLLKci (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Dec 2014 05:32:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>

This patch series adds regulator-haptic driver.
The regulator-haptic has haptic motor and it is controlled by
voltage of regulator via force feedback framework.

Changes in v6:
 - prevent racing condition

Changes in v5:
 - give preference to platform data

Changes in v4:
 - _regulator_get() -> _regulator_get_exclusive()

Changes in v3:
 - fix typo in Documentation
 - add define in header file

Changes in v2:
 - remove driver owner
 - merge enable/disable function
 - support platform data
 - fix wrong suspends_state check in regulator_haptic_resume()


Jaewon Kim (2):
  Input: add regulator haptic driver
  ARM: dts: Add regulator-haptic device node for exynos3250-rinato

 .../devicetree/bindings/input/regulator-haptic.txt |   21 ++
 arch/arm/boot/dts/exynos3250-rinato.dts            |    7 +
 drivers/input/misc/Kconfig                         |   11 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/regulator-haptic.c              |  259 ++++++++++++++++++++
 include/linux/input/regulator-haptic.h             |   31 +++
 6 files changed, 330 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/regulator-haptic.txt
 create mode 100644 drivers/input/misc/regulator-haptic.c
 create mode 100644 include/linux/input/regulator-haptic.h

-- 
1.7.9.5

