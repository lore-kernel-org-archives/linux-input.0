From: Jagan Teki <jagan@openedev.com>
Subject: [PATCH v7 3/3] ARM: dts: imx6q-icore: Add touchscreen node
Date: Wed, 22 Mar 2017 16:36:48 +0530
Message-ID: <1490180808-2856-3-git-send-email-jagan@openedev.com>
References: <1490180808-2856-1-git-send-email-jagan@openedev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1490180808-2856-1-git-send-email-jagan@openedev.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>, linux-kernel@vger.kernel.org, Domenico Acri <domenico.acri@engicam.com>, Jagan Teki <jagan@amarulasolutions.com>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

From: Jagan Teki <jagan@amarulasolutions.com>

max11801 touchscreen on Engicam iCoreM6 Quad module is
connected via i2c1, so add max11801: touchscreen@48 on i2c1.

Cc: Domenico Acri <domenico.acri@engicam.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v7:
- add vendor prefix as maxim on compatible
Changes for v6:
- Replace the lable and name of the node
   ts: max11801 => max11801: touchscreen@48
Changes for v5:
- %s/arm/ARM/g with subject prefix
Changes for v4:
- Newly added patch

 arch/arm/boot/dts/imx6q-icore.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
index 73f34d1..70cc8b2 100644
--- a/arch/arm/boot/dts/imx6q-icore.dts
+++ b/arch/arm/boot/dts/imx6q-icore.dts
@@ -58,6 +58,15 @@
 	status = "okay";
 };
 
+&i2c1 {
+	max11801: touchscreen@48 {
+		compatible = "maxim,max11801";
+		reg = <0x48>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <31 2>;
+	};
+};
+
 &ldb {
 	status = "okay";
 
-- 
1.9.1
