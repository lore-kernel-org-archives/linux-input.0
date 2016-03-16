From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
Date: Wed, 16 Mar 2016 12:53:29 +0100
Message-ID: <1458129209-15449-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35336 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933443AbcCPLxg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 07:53:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Julien Chauveau <chauveau.julien@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED
	DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

Drop #address-cells and #size-cells, which are not required by the
gpio-keys binding documentation, as button sub-nodes are not devices.

Rename sub-nodes to avoid new dtc unit address warnings when copied.

While at it, adopt the dashes convention for the node name.

Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
Cc: Julien Chauveau <chauveau.julien@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 v1 -> v2:
 * Changed node name from underscore to dash
 * Inserted white lines
 * Renamed sub-nodes (Geert, Julien)
=20
 Documentation/devicetree/bindings/input/gpio-keys.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Do=
cumentation/devicetree/bindings/input/gpio-keys.txt
index 21641236c095..a94940481e55 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -32,17 +32,17 @@ Optional subnode-properties:
=20
 Example nodes:
=20
-	gpio_keys {
+	gpio-keys {
 			compatible =3D "gpio-keys";
-			#address-cells =3D <1>;
-			#size-cells =3D <0>;
 			autorepeat;
-			button@21 {
+
+			up {
 				label =3D "GPIO Key UP";
 				linux,code =3D <103>;
 				gpios =3D <&gpio1 0 1>;
 			};
-			button@22 {
+
+			down {
 				label =3D "GPIO Key DOWN";
 				linux,code =3D <108>;
 				interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>;
--=20
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
