From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv5 2/2] arm/dts: omap4-sdp: Add keypad data
Date: Wed, 23 May 2012 19:25:50 +0530
Message-ID: <1337781350-1411-2-git-send-email-sourav.poddar@ti.com>
References: <1337781350-1411-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1337781350-1411-1-git-send-email-sourav.poddar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, linux-input@vger.kernel.org, sourav.poddar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Add keypad data node in omap4 device tree file.
Also fill the device tree binding parameters
with the required value in "omap4-sdp" dts file.

Tested on omap4430 sdp with dmitry's 'next' branch.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   63 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi    |    5 +++
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 63c6b2b..0c9b3bf 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -17,4 +17,67 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+
+	keypad@4ae1c000 {
+		keypad,num-rows = <8>;
+		keypad,num-columns = <8>;
+		linux,keymap = < 0x00000012
+			0x00010013
+			0x00020014
+			0x00030066
+			0x0004003f
+			0x00060017
+			0x0007002a
+			0x01000020
+			0x01010021
+			0x01020022
+			0x01030054
+			0x01040040
+			0x01060025
+			0x0107001c
+			0x0200002d
+			0x0201002e
+			0x0202002f
+			0x0203006b
+			0x02040041
+			0x02060034
+			0x0207003a
+			0x0300002c
+			0x0301004e
+			0x03020030
+			0x0303003b
+			0x03040042
+			0x03060018
+			0x03070039
+			0x04000011
+			0x04010015
+			0x04020016
+			0x0403003c
+			0x04040073
+			0x04060026
+			0x04070069
+			0x0500001f
+			0x05010023
+			0x05020024
+			0x0503003d
+			0x05040043
+			0x05050072
+			0x05060032
+			0x0507006a
+			0x06000010
+			0x0601001e
+			0x06020031
+			0x0603005c
+			0x0604000e
+			0x06060019
+			0x06070067
+			0x07000094
+			0x07010095
+			0x070200ca
+			0x070300cb
+			0x0704003e
+			0x07060160
+			0x0707006c >;
+		linux,input-no-autorepeat;
+	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3d35559..e0f678a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -156,4 +156,9 @@
 			ti,hwmods = "i2c4";
 		};
 	};
+
+	keypad@4ae1c000 {
+		compatible = "ti,omap4-keypad";
+		ti,hwmods = "kbd";
+	};
 };
-- 
1.7.1
