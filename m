From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: [PATCH] Input: bcm5974.c initialize raw_w, raw_x and raw_y before
 it get used
Date: Sat, 12 Sep 2009 22:46:10 +0530
Message-ID: <1252775770.3687.7.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52816 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbZILRQJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Sep 2009 13:16:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org


raw_w, raw_x and raw_y is used uninitialized for !raw_n

This also fixed these compilation warnings :

 CC [M]  drivers/input/mouse/bcm5974.o
drivers/input/mouse/bcm5974.c: In function =E2=80=98report_tp_state=E2=80=
=99:
drivers/input/mouse/bcm5974.c:319: warning: =E2=80=98raw_y=E2=80=99 may=
 be used uninitialized in this function
drivers/input/mouse/bcm5974.c:319: warning: =E2=80=98raw_x=E2=80=99 may=
 be used uninitialized in this function
drivers/input/mouse/bcm5974.c:319: warning: =E2=80=98raw_w=E2=80=99 may=
 be used uninitialized in this function

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 drivers/input/mouse/bcm5974.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm597=
4.c
index 2d8fc0b..171f345 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -345,7 +345,8 @@ static int report_tp_state(struct bcm5974 *dev, int=
 size)
 		/* set the integrated button if applicable */
 		if (c->tp_type =3D=3D TYPE2)
 			ibt =3D raw2int(dev->tp_data[BUTTON_TYPE2]);
-	}
+	} else
+		raw_w =3D raw_x =3D raw_y =3D 0;
=20
 	/* while tracking finger still valid, count all fingers */
 	if (ptest > PRESSURE_LOW && origin) {
--=20
1.6.4.2


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
