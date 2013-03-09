From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 3/4] Input: wm9712: Fix wrong pen up readings
Date: Sat,  9 Mar 2013 18:05:52 +0100
Message-ID: <1362848753-6725-4-git-send-email-mpa@pengutronix.de>
References: <1362848753-6725-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36646 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760369Ab3CIRIB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Mar 2013 12:08:01 -0500
In-Reply-To: <1362848753-6725-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, =?UTF-8?q?Teresa=20G=C3=A1mez?= <t.gamez@phytec.de>, Christian Hemp <c.hemp@phytec.de>, stable@vger.kernel.org

Often a reading can be wrong. This patch assures that this is really a
pen up event and not a false reading.

Based on wm9712: pen up by Teresa G=C3=A1mez and Christian Hemp.

Cc: Teresa G=C3=A1mez <t.gamez@phytec.de>
Cc: Christian Hemp <c.hemp@phytec.de>
Cc: stable@vger.kernel.org
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm9712.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wm9712.c b/drivers/input/touchsc=
reen/wm9712.c
index a983da1..3b4eed4 100644
--- a/drivers/input/touchscreen/wm9712.c
+++ b/drivers/input/touchscreen/wm9712.c
@@ -302,8 +302,12 @@ static int wm9712_poll_sample(struct wm97xx *wm, i=
nt adcsel, int *sample)
 	}
=20
 	if (wants_pen && !(*sample & WM97XX_PEN_DOWN)) {
-		wm->pen_probably_down =3D 0;
-		return RC_PENUP;
+		/* Sometimes it reads a wrong value the first time. */
+		*sample =3D wm97xx_reg_read(wm, AC97_WM97XX_DIGITISER_RD);
+		if (!(*sample & WM97XX_PEN_DOWN)) {
+			wm->pen_probably_down =3D 0;
+			return RC_PENUP;
+		}
 	}
=20
 	return RC_VALID;
--=20
1.8.1.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
