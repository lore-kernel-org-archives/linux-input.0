From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [RFC/PATCH 3/3] DT: input: adp5589: add binding documentation
Date: Wed,  7 May 2014 10:00:44 -0300
Message-ID: <1399467644-27222-4-git-send-email-guido@vanguardiasur.com.ar>
References: <1399467644-27222-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:45868 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932801AbaEGNEE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 09:04:04 -0400
Received: by mail-yh0-f43.google.com with SMTP id f10so807781yha.30
        for <linux-input@vger.kernel.org>; Wed, 07 May 2014 06:04:03 -0700 (PDT)
In-Reply-To: <1399467644-27222-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

Add documentation for the adp5589 DT binding.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 .../devicetree/bindings/input/adp5589.txt          | 63 ++++++++++++++=
++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adp5589.txt

diff --git a/Documentation/devicetree/bindings/input/adp5589.txt b/Docu=
mentation/devicetree/bindings/input/adp5589.txt
new file mode 100644
index 0000000..d4c295d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adp5589.txt
@@ -0,0 +1,63 @@
+Binding for the Analog Devices ADP5589 matrix decoder. The ADP5589 is =
a
+complex chip with many functions including matrix keypad decoding, res=
et
+event generator and gpio expansion. DT support is limited to keypad
+decoding.
+
+Required properties:
+
+- compatible: Should be "adi,adp5589"
+
+- linux,keymap: An array of packed cells each describing a mapping fro=
m
+a key to a linux keycode, as described in [1]. The macro MATRIX_KEY ca=
n
+be used to construct each mapping.
+
+Optional properties:
+
+- adp5589,scan-cycle-time-ms: The time between keymap polls in ms.
+Supported valued are 10, 20, 30 and 40. Other values are silently
+rounded down to the nearest supported value. Default: 10ms.
+
+- linux,no-autorepeat: Disable key auto repeat.
+
+- adp5589,pulldown-300k
+- adp5589,pullup-300k
+- adp5589,pullup-100k
+- adp5589,pull-disable: Set pull up/down/disable for the chip lines.
+Each is an OR'd value constructed with the macros ADP_COL and ADP_ROW.
+You can also use ~0 to specify all lines. It is an error for any two o=
f
+these values have bits in common, and the driver will not load if so.
+
+Example node:
+
+&i2c0 {
+	keyboard {
+		compatible =3D "adi,adp5589";
+		reg =3D <0x34>;
+
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&kb_pins>;
+
+		interrupt-parent =3D <&gpio1>;
+		interrupts =3D <19 GPIO_ACTIVE_HIGH>;
+
+		adp5589,scan-cycle-time-ms =3D <40>;
+
+		/* pull up all lines with a 300k resistor */
+		adp5589,pullup-300k =3D < (~0) >;
+
+		linux,no-autorepeat;
+		linux,keymap =3D <
+			MATRIX_KEY(0, 0, KEY_0)
+			MATRIX_KEY(0, 1, KEY_1)
+			MATRIX_KEY(0, 2, KEY_2)
+
+			MATRIX_KEY(1, 0, KEY_F1)
+			MATRIX_KEY(1, 1, KEY_F2)
+			MATRIX_KEY(1, 2, KEY_F3)
+		>;
+	}
+}
+
+-------
+
+[1] Documentation/devicetree/bindings/input/matrix-keymap.txt
--=20
2.0.0.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
