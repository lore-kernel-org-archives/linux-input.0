From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 0/3] STM FingerTip S touchscreen support for TM2 board
Date: Tue, 17 Jan 2017 22:54:38 +0900
Message-ID: <20170117135441.31450-1-andi.shyti@samsung.com>
References: <CGME20170117135456epcas5p25968e1781a9cee833b350940ae7af70b@epcas5p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi,

this patchset provides support for the ST-Microelectronics
FingerTip S device driver and enables it in the tm2 and tm2e
devices.

It's tested on top of next-20170117 kernel and applies on
Krzysztof's for-next branch.

Thanks,
Andi

Andi Shyti (3):
  Input: add STMicroelectronics FingerTip touchscreen driver
  Input: add support for the STMicroelectronics FingerTip touchscreen
  arm64: dts: exynos: Add stmfts touchscreen node for TM2 and TM2E

 .../bindings/input/touchscreen/st,stmfts.txt       |  43 ++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |  13 +
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |   5 +
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   7 +
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/stmfts.c                 | 759 +++++++++++++++++++++
 7 files changed, 840 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
 create mode 100644 drivers/input/touchscreen/stmfts.c

-- 
2.11.0
