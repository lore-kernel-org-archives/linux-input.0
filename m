From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] input: ti_am33x_tsc: make the documentation for the
 ti,wire-config parameter clear
Date: Tue, 12 Nov 2013 18:40:01 +0100
Message-ID: <20131112174001.GA21881@linutronix.de>
References: <1384273323-15329-1-git-send-email-bigeasy@linutronix.de>
 <5C68A2CC-A8C8-4B56-A414-B9EBE438F767@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48757 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab3KLRkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Nov 2013 12:40:03 -0500
Content-Disposition: inline
In-Reply-To: <5C68A2CC-A8C8-4B56-A414-B9EBE438F767@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, o2g.org.ru@gmail.com

The document says "first four bits" and means the upper nibble. Most
people would probably agree that the first four bits are bits 0=E2=80=A6=
3 and
that is the lower nibble.
This patch updates the documentation so it is clear what is meant.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
	- use most/least significant instead of upper/ lower nibble
	- add an example.

 .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt    | 13 +++++=
+++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc=
-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-a=
dc.txt
index 491c97b..b25a2fe 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.tx=
t
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.tx=
t
@@ -17,13 +17,16 @@
 				remaining 4 can be used by the ADC.
 	ti,wire-config: Different boards could have a different order for
 			connecting wires on touchscreen. We need to provide an
-			8 bit number where in the 1st four bits represent the
-			analog lines and the next 4 bits represent positive/
-			negative terminal on that input line. Notations to
-			represent the input lines and terminals resoectively
-			is as follows:
+			8 bit number where the most significant nibble represent
+			the analog lines and the least significant nibble
+			represent positive/ negative terminal on that input
+			line. Notations to represent the input lines and
+			terminals resoectively is as follows:
 			AIN0 =3D 0, AIN1 =3D 1 and so on till AIN7 =3D 7.
 			XP  =3D 0, XN =3D 1, YP =3D 2, YN =3D 3.
+
+			Example: ti,wire-config =3D <0x71>;
+			=3D> line AIN7, configuration XN
 - child "adc"
 	ti,adc-channels: List of analog inputs available for ADC.
 			 AIN0 =3D 0, AIN1 =3D 1 and so on till AIN7 =3D 7.
--=20
1.8.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
