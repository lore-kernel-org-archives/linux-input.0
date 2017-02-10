From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v2 0/3] STM FingerTip S touchscreen support for TM2 board
Date: Fri, 10 Feb 2017 11:17:18 +0900
Message-ID: <20170210021721.12218-1-andi.shyti@samsung.com>
References: <CGME20170210021728epcas1p3864184ab4ffe6e4cf6614984e83e307a@epcas1p3.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi,

this patchset provides support for the ST-Microelectronics
FingerTip S device driver and enables it in the tm2 and tm2e
devices.

It's tested on top of next-20170210 kernel and applies on
Krzysztof's for-next branch.

Thanks,
Andi

Changelog V1-V2
===============
V1: https://marc.info/?l=linux-kernel&m=148466204431327&w=2

 - fixed Javier's, Krzysztof's and Dmitry's reviews
 - added Javier's review tag on patch 1 and 3
 - the main difference of the driver from v2 is that the driver
   generates only one input interface instead of two (one for the
   touchscreen and one for the touchkeys). The job of filtering
   the events is demanded to userspace applications that are
   accessing the device. This is done by making an ioctl call:

	ioctl(fd, EVIOCSMASK, &mask);

   where 'mask' is an 'input_mask' structure that contains the type
   variable of the EV_* that needs to be filtered out.

Andi Shyti (3):
  Input: add STMicroelectronics FingerTip touchscreen driver
  Input: add support for the STMicroelectronics FingerTip touchscreen
  arm64: dts: exynos: Add stmfts touchscreen node for TM2 and TM2E

 .../bindings/input/touchscreen/st,stmfts.txt       |  43 ++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |  15 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |   5 +
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   7 +
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/stmfts.c                 | 794 +++++++++++++++++++++
 7 files changed, 876 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
 create mode 100644 drivers/input/touchscreen/stmfts.c

-- 
2.11.0
