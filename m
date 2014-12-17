From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v7 0/3] Add regulator-haptic driver
Date: Wed, 17 Dec 2014 12:35:05 +0900
Message-ID: <1418787308-29019-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

This patch series adds regulator-haptic driver.
The regulator-haptic has haptic motor and it is controlled by
voltage of regulator via force feedback framework.

Changes in v7:
 - move platform_data or of_node check.
 - prevent to start playing effect when kernel entering suspend state.

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

Jaewon Kim (3):
  Input: add regulator haptic driver
  ARM: dts: exynos3250-rinato: Add regulator-haptic node for haptics
  ARM: dts: exynos3250-monk: Add regulator-haptic node for haptics

 .../devicetree/bindings/input/regulator-haptic.txt |   21 ++
 arch/arm/boot/dts/exynos3250-monk.dts              |    7 +
 arch/arm/boot/dts/exynos3250-rinato.dts            |    7 +
 drivers/input/misc/Kconfig                         |   11 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/regulator-haptic.c              |  247 ++++++++++++++++++++
 include/linux/platform_data/regulator-haptic.h     |   29 +++
 7 files changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/regulator-haptic.txt
 create mode 100644 drivers/input/misc/regulator-haptic.c
 create mode 100644 include/linux/platform_data/regulator-haptic.h

-- 
1.7.9.5
