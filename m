From: Liu Ying <Ying.Liu@freescale.com>
Subject: [PATCH 3/3] ARM i.MX51 babbage: Add keypad support
Date: Sun, 30 Dec 2012 21:09:06 +0800
Message-ID: <1356872946-2810-3-git-send-email-Ying.Liu@freescale.com>
References: <1356872946-2810-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1356872946-2810-1-git-send-email-Ying.Liu@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com, shawn.guo@linaro.org, s.hauer@pengutronix.de, linus.walleij@linaro.org, cjb@laptop.org, broonie@opensource.wolfsonmicro.com
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, liu.y.victor@gmail.com, Liu Ying <Ying.Liu@freescale.com>
List-Id: linux-input@vger.kernel.org

The keypad is on the accessory board of i.MX51 babbage
main board and is driven by Keypad Port(KPP) in SoC.
The keymap is the same to i.MX25 3stack platform as
the accessory board schematic tells that it is designed
in this way.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 arch/arm/boot/dts/imx51-babbage.dts |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 567e7ee..a9bb799 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -281,3 +281,25 @@
 		mux-ext-port = <3>;
 	};
 };
+
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp_1>;
+	linux,keymap = <0x00000067	/* KEY_UP */
+			0x0001006c	/* KEY_DOWN */
+			0x00020072	/* KEY_VOLUMEDOWN */
+			0x00030066	/* KEY_HOME */
+			0x0100006a	/* KEY_RIGHT */
+			0x01010069	/* KEY_LEFT */
+			0x0102001c	/* KEY_ENTER */
+			0x01030073	/* KEY_VOLUMEUP */
+			0x02000040	/* KEY_F6 */
+			0x02010042	/* KEY_F8 */
+			0x02020043	/* KEY_F9 */
+			0x02030044	/* KEY_F10 */
+			0x0300003b	/* KEY_F1 */
+			0x0301003c	/* KEY_F2 */
+			0x0302003d	/* KEY_F3 */
+			0x03030074>;	/* KEY_POWER */
+	status = "okay";
+};
-- 
1.7.1


