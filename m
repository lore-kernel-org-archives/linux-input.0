From: <mika.penttila@nextfour.com>
Subject: [PATCH v4 2/2] Input: SiS 9200 documentation parts.
Date: Tue, 1 Mar 2016 10:32:20 +0200
Message-ID: <1456821140-26720-3-git-send-email-mika.penttila@nextfour.com>
References: <1456821140-26720-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db3on0066.outbound.protection.outlook.com ([157.55.234.66]:22848
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752479AbcCAIdE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Mar 2016 03:33:04 -0500
In-Reply-To: <1456821140-26720-1-git-send-email-mika.penttila@nextfour.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>

=46rom: Mika Penttil=C3=A4 <mika.penttila@nextfour.com>

Signed-off-by: Mika Penttil=C3=A4 <mika.penttila@nextfour.com>
Acked-by: Tammy Tseng <tammy_tseng@sis.com>
Acked-by: Yuger Yu <yuger_yu@sis.com>
---
 .../bindings/input/touchscreen/sis_i2c.txt         | 22 ++++++++++++++=
++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/sis_i2c.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sis_i2=
c.txt b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
new file mode 100644
index 0000000..72f654b
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
+- irq-gpio: the gpio pin used as irq pin
+- reset-gpio: the gpio pin used to reset the controller=20
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
+                irq-gpio =3D <&gpio3 19 1>;
+                reset-gpio =3D <&gpio2 30 1>;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Do=
cumentation/devicetree/bindings/vendor-prefixes.txt
index 72e2c5a..077f8e9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -212,6 +212,7 @@ simtek
 sii	Seiko Instruments, Inc.
 silergy	Silergy Corp.
 sirf	SiRF Technology, Inc.
+sis	Silicon Integrated Systems Corp.
 sitronix	Sitronix Technology Corporation
 skyworks	Skyworks Solutions, Inc.
 smsc	Standard Microsystems Corporation
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
