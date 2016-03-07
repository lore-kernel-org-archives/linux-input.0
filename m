From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys example
Date: Mon,  7 Mar 2016 19:24:15 +0100
Message-ID: <1457375055-5544-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43060 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152AbcCGSYh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Mar 2016 13:24:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Julien Chauveau <chauveau.julien@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED
	DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Drop #address-cells and #size-cells, which are not required by the
gpio-keys binding documentation, as button sub-nodes are not devices.

Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/input/gpio-keys.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Do=
cumentation/devicetree/bindings/input/gpio-keys.txt
index 21641236c095..1552a11f6786 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -34,8 +34,6 @@ Example nodes:
=20
 	gpio_keys {
 			compatible =3D "gpio-keys";
-			#address-cells =3D <1>;
-			#size-cells =3D <0>;
 			autorepeat;
 			button@21 {
 				label =3D "GPIO Key UP";
--=20
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
