From: Jaechul Lee <jcsing.lee@samsung.com>
Subject: [PATCH v6 0/3] Add touch key driver support for TM2
Date: Mon, 09 Jan 2017 16:22:12 +0900
Message-ID: <1483946535-4703-1-git-send-email-jcsing.lee@samsung.com>
References: <CGME20170109072218epcas1p38d937ae34dcd7ece7b9f092b1527a691@epcas1p3.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Jaechul Lee <jcsing.lee@samsung.com>, Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

This patch is last three patch from https://lkml.org/lkml/2017/1/6/277.
because 1 and 2 patches have already been merged by Krzysztof.

This patchset adds support for the tm2 touchkey device.

The driver has been ported from Tizen Kernel, originally written
by Beomho. I ported it to the latest mainline Kernel.

Best Regard,
Jaechul

Changes in v6:
 - changed compatible name from samsaung to cypress. 
 - updated commit tags.
 - removed first two patches from the original patchset.
 
Changes in v5:
 - patch 1: removed a spurious regulator-always-off inherited from
   a different patch. Thanks Krzysztof.
 - patch 2: fixed a slip on  the model, thanks Javier (this patch
   confuses me quite a lot, this was all right some patches ago
   and re appeared on this one).
 - patch 2: removed 'regulator' label and used the original ldo3x
   labels. Krzysztof: it looks better indeed.
 - added Javier's reviews and Krzysztof's acks on the related
   patches.

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

Jaechul Lee (3):
  input: Add support for the tm2 touchkey device driver
  input: tm2-touchkey: Add touchkey driver support for TM2
  arm64: dts: exynos: Add tm2 touchkey node

 .../bindings/input/cypress,tm2-touchkey.txt        |  27 ++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  13 +
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/tm2-touchkey.c              | 287 +++++++++++++++++++++
 5 files changed, 339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
 create mode 100644 drivers/input/keyboard/tm2-touchkey.c

-- 
2.7.4
