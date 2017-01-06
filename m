From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v5 5/5] arm64: dts: exynos: Add tm2 touchkey node
Date: Fri, 06 Jan 2017 22:43:50 +0900
Message-ID: <20170106134350.32428-6-andi.shyti@samsung.com>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134356epcas1p1aee9f715c58b50f6056bf0b43b849497@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20170106134350.32428-1-andi.shyti@samsung.com>
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

From: Jaechul Lee <jcsing.lee@samsung.com>

Add DT node support for TM2 touchkey device.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index 2449266b268f..92fcc4ec8319 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -18,6 +18,19 @@
 	compatible = "samsung,tm2", "samsung,exynos5433";
 };
 
+&hsi2c_9 {
+	status = "okay";
+
+	touchkey@20 {
+		compatible = "samsung,tm2-touchkey";
+		reg = <0x20>;
+		interrupt-parent = <&gpa3>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		vcc-supply = <&ldo32_reg>;
+		vdd-supply = <&ldo33_reg>;
+	};
+};
+
 &ldo31_reg {
 	regulator-name = "TSP_VDD_1.85V_AP";
 	regulator-min-microvolt = <1850000>;
-- 
2.11.0
