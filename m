From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 3/3] ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup source
Date: Thu, 17 May 2018 11:05:52 +0200
Message-ID: <20180517090552.5704-4-daniel@zonque.org>
References: <20180517090552.5704-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180517090552.5704-1-daniel@zonque.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com
Cc: devicetree@vger.kernel.org, Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The touchscreen driver no longer configures the device as wakeup source by
default. A "wakeup-source" property is needed.

To avoid regressions, this patch changes the DTS files for the only two
users of this driver that didn't have this property yet.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/arm/boot/dts/imx28-tx28.dts      | 1 +
 arch/arm/boot/dts/imx53-tx53-x03x.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 0ebbc83852d0..094a39a67ec8 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -328,6 +328,7 @@
 		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 	};
 
 	touchscreen: tsc2007@48 {
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 0ecb43d88522..dbf0d73dc7b9 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -220,6 +220,7 @@
 		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 	};
 
 	touchscreen: tsc2007@48 {
-- 
2.14.3
