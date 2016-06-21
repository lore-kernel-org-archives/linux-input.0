From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 2/5] input/alps: Handle 0-pressure 1F events
Date: Tue, 21 Jun 2016 11:19:30 +0200
Message-ID: <1466500773-3470-3-git-send-email-ben@smart-cactus.org>
References: <1466500773-3470-1-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56531 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcFUJUa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 05:20:30 -0400
In-Reply-To: <1466500773-3470-1-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

While a button is held SS5 hardware will give us single-finger packets
with x, y, and pressure equal to zero. This causes annoying jumps in
pointer position if a touch is released while the button is held. Handl=
e
this by claiming zero contacts to ensure that no position events are
provided to the user.

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index b8454af..7874f4f 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1197,7 +1197,12 @@ static int alps_decode_ss4_v2(struct alps_fields=
 *f,
 		f->mt[0].x =3D SS4_1F_X_V2(p);
 		f->mt[0].y =3D SS4_1F_Y_V2(p);
 		f->pressure =3D ((SS4_1F_Z_V2(p)) * 2) & 0x7f;
-		f->fingers =3D 1;
+		/*
+		 * When a button is held the device will give us events with x, y, a=
nd
+		 * pressure of 0. This causes annoying jumps if a touch is released =
while
+		 * the button is held. Handle this by claiming zero contacts.
+		 */
+		f->fingers =3D f->pressure > 0 ? 1 : 0;
 		f->first_mp =3D 0;
 		f->is_mp =3D 0;
 		break;
--=20
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
