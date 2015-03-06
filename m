From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
	<sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] Input: sx8654 - add device tree bindings
Date: Fri,  6 Mar 2015 19:21:39 +0100
Message-ID: <1425666099-8365-2-git-send-email-sebastien.szymanski@armadeus.com>
References: <1425666099-8365-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425666099-8365-1-git-send-email-sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.c=
om>
---
 .../devicetree/bindings/input/touchscreen/sx8654.txt     | 16 ++++++++=
++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/sx8654.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sx8654=
=2Etxt b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
new file mode 100644
index 0000000..5aaa6b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
@@ -0,0 +1,16 @@
+* Semtech SX8654 I2C Touchscreen Controller
+
+Required properties:
+- compatible: must be "semtech,sx8654"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: touch controller interrupt
+
+Example:
+
+	sx8654@48 {
+		compatible =3D "semtech,sx8654";
+		reg =3D <0x48>;
+		interrupt-parent =3D <&gpio6>;
+		interrupts =3D <3 IRQ_TYPE_EDGE_FALLING>;
+	};
--=20
2.0.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
