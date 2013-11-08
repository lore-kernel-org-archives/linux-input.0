From: Denis Carikli <denis@eukrea.com>
Subject: [PATCHv9][ 2/3] ARM: dts: cpuimx51 Add touchscreen support.
Date: Fri,  8 Nov 2013 14:17:38 +0100
Message-ID: <1383916659-9988-2-git-send-email-denis@eukrea.com>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:35258 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757036Ab3KHNSN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Nov 2013 08:18:13 -0500
In-Reply-To: <1383916659-9988-1-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, Denis Carikli <denis@eukrea.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v8->v9:
- Added Grant Likely in the Cc list.
- Adapted to the removal of the pinctrl properties in the tsc2007 docum=
entation.
- Fixed the gpios property (before, it was set to active high by error)=
=2E

ChangeLog v7->v8:
- Added Shawn Guo in the cc list.
---
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/bo=
ot/dts/imx51-eukrea-cpuimx51.dtsi
index b22841a..b04c65b 100644
--- a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
+++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
@@ -42,11 +42,23 @@
 		compatible =3D "nxp,pcf8563";
 		reg =3D <0x51>;
 	};
+
+	tsc2007: tsc2007@49 {
+		compatible =3D "ti,tsc2007";
+		reg =3D <0x49>;
+		interrupt-parent =3D <&gpio4>;
+		interrupts =3D <0x0 0x8>;
+		gpios =3D <&gpio4 0 1>;
+		ti,x-plate-ohms =3D <180>;
+	};
 };
=20
 &iomuxc {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_hog>;
+
 	imx51-eukrea {
-		pinctrl_tsc2007_1: tsc2007grp-1 {
+		pinctrl_hog: hoggrp {
 			fsl,pins =3D <
 				MX51_PAD_GPIO_NAND__GPIO_NAND 0x1f5
 				MX51_PAD_NANDF_D8__GPIO4_0 0x1f5
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
