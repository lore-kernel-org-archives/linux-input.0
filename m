From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v4 0/5]
Date: Fri, 06 Jan 2017 20:41:09 +0900
Message-ID: <20170106114114.19321-1-andi.shyti@samsung.com>
References: <CGME20170106114119epcas5p2c29ea8c8118db4a1fb600970ea0dafd4@epcas5p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>, Jaechul Lee <galaxyra@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

I'll send this patch on behalf of Jaechul Lee
<jcsing.lee@samsung.com> becasue it's I don't want to block
anyone who wants to make changes to the exynos5433-tm2*dts*
files.

This patches are based on Krzysztof's branch for-next [1]

    "This patchset adds support for the tm2 touchkey device.
     
     The driver has been ported from Tizen Kernel,
     originally written
     by Beomho. I ported it to the latest mainline Kernel."

Thanks,
Andi

[1] https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=for-next

Changes in v4:
 - patch 1 has been rebased on top of 7c294e002641 (arm64: dts:
   exynos: Remove unsupported regulator-always-off property from
   TM2E)
 - patch 2 has been generated with -B50% diff option using git
   2.11

Changes in v3:
 - Changed the commit ordering, the tm2-touchkey related patches
   are the last 3.
 - Added Chanwoo's patch which fixes the wrong voltage of ldo23
   and ldo25.
 - Andi (patch 3) moves the ldo31 and ldo38 in the tm2 and tm2e
   files as they have different values.

Changes in v2:
 - fixed reviews from Javier, Dmitry
 - refactored power enable/disable functions.
 - reordered signed-offs in patch 2, while patch 4 is left as it
   was as Andi copy pasted the node to the new tm2.dts file
 - added Jarvier's (patch 1,2,4) and Krzysztof's (patch 4)
   reviews
   and Rob's Ack
 - patch 3 diff has been generated with -B50%

Andi Shyti (1):
  arm64: dts: exynos: make tm2 and tm2e independent from each other

Chanwoo Choi (1):
  arm64: dts: exynos5433: TM2/E: Fix wrong information of ldo23 and
    ldo25

Jaechul Lee (3):
  input: Add support for the tm2 touchkey device driver
  input: tm2-touchkey: Add touchkey driver support for TM2
  arm64: dts: exynos: Add tm2 touchkey node

 .../bindings/input/samsung,tm2-touchkey.txt        |   27 +
 ...ynos5433-tm2.dts => exynos5433-tm2-common.dtsi} |   31 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1165 +-------------------
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   31 +-
 drivers/input/keyboard/Kconfig                     |   11 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/tm2-touchkey.c              |  280 +++++
 7 files changed, 392 insertions(+), 1154 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
 copy arch/arm64/boot/dts/exynos/{exynos5433-tm2.dts => exynos5433-tm2-common.dtsi} (97%)
 rewrite arch/arm64/boot/dts/exynos/exynos5433-tm2.dts (98%)
 create mode 100644 drivers/input/keyboard/tm2-touchkey.c

-- 
2.11.0
