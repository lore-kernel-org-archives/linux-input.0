From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 0/2] Add regulator-haptic driver
Date: Mon, 24 Nov 2014 23:50:49 +0900
Message-ID: <1416840651-17141-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Dan Murphy <dmurphy@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, Hyunhee Kim <hyunhee.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Jaewon Kim <jaewon02.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

This patch series adds regulator-haptic driver.
The regulator-haptic has haptic motor and it is controlled by
voltage of regulator via force feedback framework.

Changes in v2:
  - remove driver owner
  - merge enable/disable function
  - support platform data
  - fix wrong suspends_state check in regulator_haptic_resume()

Jaewon Kim (2):
  Input: add regulator haptic driver
  ARM: dts: Add regulator-haptic device node for exynos3250-rinato

 .../devicetree/bindings/input/regulator-haptic.txt |   24 ++
 arch/arm/boot/dts/exynos3250-rinato.dts            |    7 +
 drivers/input/misc/Kconfig                         |   11 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/regulator-haptic.c              |  247 ++++++++++++++++++++
 include/linux/input/regulator-haptic.h             |   30 +++
 6 files changed, 320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/regulator-haptic.txt
 create mode 100644 drivers/input/misc/regulator-haptic.c
 create mode 100644 include/linux/input/regulator-haptic.h

-- 
1.7.9.5
