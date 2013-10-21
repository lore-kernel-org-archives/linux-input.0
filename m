From: Denis Carikli <denis@eukrea.com>
Subject: [PATCHv4][ 2/4] ARM: dts: cpuimx51 Add touchscreen support.
Date: Mon, 21 Oct 2013 15:54:25 +0200
Message-ID: <1382363667-10341-2-git-send-email-denis@eukrea.com>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:54051 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600Ab3JUNys (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Oct 2013 09:54:48 -0400
In-Reply-To: <1382363667-10341-1-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Denis Carikli <denis@eukrea.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v2->v4:
- This patch was splitted, only the part enabling the audio was kept.
  Part of the rest has already been submited, and the remaining parts
  will be submited later, because they depend on changes touching other
  subsystems.
- The x-plate-ohms property was renamed to ti,x-plate-ohms.
- The tsc2007 label was added for consistency.
---
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/bo=
ot/dts/imx51-eukrea-cpuimx51.dtsi
index 8638656..34ca8d3a 100644
--- a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
+++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
@@ -42,6 +42,17 @@
 		compatible =3D "nxp,pcf8563";
 		reg =3D <0x51>;
 	};
+
+	tsc2007: tsc2007@49 {
+		compatible =3D "ti,tsc2007";
+		reg =3D <0x49>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_tsc2007_1>;
+		interrupt-parent =3D <&gpio4>;
+		interrupts =3D <0x0 0x8>;
+		gpios =3D <&gpio4 0 0>;
+		ti,x-plate-ohms =3D <180>;
+	};
 };
=20
 &iomuxc {
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
