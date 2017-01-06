From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v5 0/5] Add touch key driver support for TM2
Date: Fri, 06 Jan 2017 22:43:45 +0900
Message-ID: <20170106134350.32428-1-andi.shyti@samsung.com>
References: <CGME20170106134355epcas1p171f1f3b3c20c6a92e7736c1639ea2dd8@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, Jaechul Lee <galaxyra@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi,

I'll send this patch on behalf of Jaechul Lee
<jcsing.lee@samsung.com> becasue I don't want to block
anyone who wants to make changes to the exynos5433-tm2*dts*
files.

This patches are based on Krzysztof's branch for-next [1] and
this was the original Jaechul's mail:

    "This patchset adds support for the tm2 touchkey device.

     The driver has been ported from Tizen Kernel,
     originally written
     by Beomho. I ported it to the latest mainline Kernel."

Thanks and hopefully I got it right :)
Andi

[1] https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=for-next

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

Andi Shyti (1):
  arm64: dts: exynos: make tm2 and tm2e independent from each other

Andi Shyti (1):
  arm64: dts: exynos: make tm2 and tm2e independent from each other

Chanwoo Choi (1):
  arm64: dts: exynos5433: TM2/E: Fix wrong values for ldo23 and ldo25

Jaechul Lee (3):
  input: Add support for the tm2 touchkey device driver
  input: tm2-touchkey: Add touchkey driver support for TM2
  arm64: dts: exynos: Add tm2 touchkey node

 .../bindings/input/samsung,tm2-touchkey.txt        |   27 +
 ...ynos5433-tm2.dts => exynos5433-tm2-common.dtsi} |   27 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1163 +-------------------
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   11 +-
 drivers/input/keyboard/Kconfig                     |   11 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/tm2-touchkey.c              |  280 +++++
 7 files changed, 377 insertions(+), 1143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
 copy arch/arm64/boot/dts/exynos/{exynos5433-tm2.dts => exynos5433-tm2-common.dtsi} (97%)
 rewrite arch/arm64/boot/dts/exynos/exynos5433-tm2.dts (97%)
 create mode 100644 drivers/input/keyboard/tm2-touchkey.c

-- 
2.11.0
