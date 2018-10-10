From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 2/8] dt-bindings: olpc,ap-sp: add GPIO lines
Date: Wed, 10 Oct 2018 16:24:58 +0200
Message-ID: <20181010142504.233467-3-lkundrak@v3.sk>
References: <20181010142504.233467-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010142504.233467-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

Add properties describing the GPIO lines used by the keyboard controller.
The olpc-apsp driver will do happily without them, but they are still par=
t
of the hardware description. The driver could still reserve the lines,
so that nothing else touches them.

This makes the device node almost compatible with "ps2-gpio". I'm not
adding a compatible property, because ps2-gpio would use a different
interrupt, so that we'd need to name it. And I haven't actually tried it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/serio/olpc,ap-sp.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt b/Doc=
umentation/devicetree/bindings/serio/olpc,ap-sp.txt
index 36603419d6f8..2b1b1dbb54c1 100644
--- a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
+++ b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
@@ -7,6 +7,10 @@ Required properties:
 - clocks : phandle + clock-specifier for the clock that drives the WTM
 - clock-names:  should be "sp"
=20
+Optional properties:
+- data-gpios : GPIO line used for PS/2 interface data
+- clk-gpios : GPIO line used for PS/2 interface clock
+
 Example:
 	ap-sp@d4290000 {
 		compatible =3D "olpc,ap-sp";
@@ -14,4 +18,6 @@ Example:
 		interrupts =3D <40>;
 		clocks =3D <&soc_clocks MMP2_CLK_SP>;
 		clock-names =3D "sp";
+		data-gpios =3D <&gpio 72 GPIO_ACTIVE_HIGH>;
+		clk-gpios =3D <&gpio 71 GPIO_ACTIVE_HIGH>;
 	}
--=20
2.19.0
