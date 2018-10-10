From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 1/8] dt-bindings: olpc,ap-sp: add clock
Date: Wed, 10 Oct 2018 16:24:57 +0200
Message-ID: <20181010142504.233467-2-lkundrak@v3.sk>
References: <20181010142504.233467-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010142504.233467-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

The clock is necessary for the device operation, hence it's required.
Its name, "sp", stands for "Security Processor". It is one of several
names that are used for the processor that serves as the keyboard
controller on an OLPC and is consistent with the node name.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/serio/olpc,ap-sp.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt b/Doc=
umentation/devicetree/bindings/serio/olpc,ap-sp.txt
index 0e72183f52bc..36603419d6f8 100644
--- a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
+++ b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
@@ -4,10 +4,14 @@ Required properties:
 - compatible : "olpc,ap-sp"
 - reg : base address and length of SoC's WTM registers
 - interrupts : SP-AP interrupt
+- clocks : phandle + clock-specifier for the clock that drives the WTM
+- clock-names:  should be "sp"
=20
 Example:
 	ap-sp@d4290000 {
 		compatible =3D "olpc,ap-sp";
 		reg =3D <0xd4290000 0x1000>;
 		interrupts =3D <40>;
+		clocks =3D <&soc_clocks MMP2_CLK_SP>;
+		clock-names =3D "sp";
 	}
--=20
2.19.0
