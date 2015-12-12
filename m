From: Karsten Merker <merker@debian.org>
Subject: [PATCH] Input: sunxi LRADC-keys: allwinner,sun4i-a10-lradc-keys binding: typo fix
Date: Sat, 12 Dec 2015 15:47:55 +0100
Message-ID: <1449931675-5775-1-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56853 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbbLLOsW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Dec 2015 09:48:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Karsten Merker <merker@debian.org>

Trivial typo fix ("mut" -> "must") in the sunxi LRADC-keys binding
documentation.

Signed-off-by: Karsten Merker <merker@debian.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
This patch was originally part of a sunxi board dts patch series
(whereby I stumbled over the typo in the binding docs), but the =20
sunxi maintainers indicated that it should go through the input
tree, so here we go ;-).

Regards,
Karsten

 Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.t=
xt b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
index b9c32f6..4357e49 100644
--- a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
+++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
@@ -12,7 +12,7 @@ Each key is represented as a sub-node of "allwinner,s=
un4i-a10-lradc-keys":
 Required subnode-properties:
 	- label: Descriptive name of the key.
 	- linux,code: Keycode to emit.
-	- channel: Channel this key is attached to, mut be 0 or 1.
+	- channel: Channel this key is attached to, must be 0 or 1.
 	- voltage: Voltage in =C2=B5V at lradc input when this key is pressed=
=2E
=20
 Example:
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
