From: <mika.penttila@nextfour.com>
Subject: [PATCH RESEND 2/2] Input: Documentation and MAINTAINERS parts.
Date: Wed, 13 Jan 2016 07:51:55 +0200
Message-ID: <1452664315-28078-5-git-send-email-mika.penttila@nextfour.com>
References: <1452664315-28078-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:15184
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750772AbcAMG0V (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 01:26:21 -0500
In-Reply-To: <1452664315-28078-1-git-send-email-mika.penttila@nextfour.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>

=46rom: Mika Penttil=C3=A4 <mika.penttila@nextfour.com>

---
 .../bindings/input/touchscreen/sis_i2c.txt         | 22 ++++++++++++++=
++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 MAINTAINERS                                        |  7 +++++++
 3 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/sis_i2c.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sis_i2=
c.txt b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
new file mode 100644
index 0000000..b0e9980
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
@@ -0,0 +1,22 @@
+* SiS I2C Multiple Touch Controller
+
+Required properties:
+- compatible: must be "sis,9200_ts"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: touch controller interrupt
+- irq-gpios: the gpio pin used as irq pin
+- reset-gpios: the gpio pin used to reset the controller=20
+
+Example:
+
+	sis9255@5c  {
+                compatible =3D "sis,9200_ts";
+                reg =3D <0x5c>;
+                pinctrl-names =3D "default";
+                pinctrl-0 =3D <&pinctrl_sis>;
+                interrupt-parent =3D <&gpio3>;
+                interrupts =3D <19 2>;
+                irq-gpios =3D <&gpio3 19 0>;
+                reset-gpios =3D <&gpio2 30 0>;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Do=
cumentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..a6ed5f9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -207,6 +207,7 @@ simtek
 sii	Seiko Instruments, Inc.
 silergy	Silergy Corp.
 sirf	SiRF Technology, Inc.
+sis	Silicon Integrated Systems Corp.
 sitronix	Sitronix Technology Corporation
 skyworks	Skyworks Solutions, Inc.
 smsc	Standard Microsystems Corporation
diff --git a/MAINTAINERS b/MAINTAINERS
index 233f834..fbf9470 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9809,6 +9809,13 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/sis/sis900.*
=20
+SIS 9200 I2C TOUCHSCREEN DRIVER
+M:	Mika Penttil=C3=A4 <mika.penttila@nextfour.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
+F:	drivers/input/touchscreen/sis_i2c.c
+
 SIS FRAMEBUFFER DRIVER
 M:	Thomas Winischhofer <thomas@winischhofer.net>
 W:	http://www.winischhofer.net/linuxsisvga.shtml
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
