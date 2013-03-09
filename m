From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 2/4] Input: wm9712: Fix returncode for wrong sample
Date: Sat,  9 Mar 2013 18:05:51 +0100
Message-ID: <1362848753-6725-3-git-send-email-mpa@pengutronix.de>
References: <1362848753-6725-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1362848753-6725-1-git-send-email-mpa@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, =?UTF-8?q?Teresa=20G=C3=A1mez?= <t.gamez@phytec.de>, Christian Hemp <c.hemp@phytec.de>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of interpreting a wrong measurement as pen up, we should try to=
 read
again.

Based on wm9712: pen up by Teresa G=C3=A1mez and Christian Hemp.

Cc: Teresa G=C3=A1mez <t.gamez@phytec.de>
Cc: Christian Hemp <c.hemp@phytec.de>
Cc: stable@vger.kernel.org
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm9712.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wm9712.c b/drivers/input/touchsc=
reen/wm9712.c
index 6e743e3..a983da1 100644
--- a/drivers/input/touchscreen/wm9712.c
+++ b/drivers/input/touchscreen/wm9712.c
@@ -298,7 +298,7 @@ static int wm9712_poll_sample(struct wm97xx *wm, in=
t adcsel, int *sample)
 		dev_dbg(wm->dev, "adc wrong sample, wanted %x got %x",
 			adcsel & WM97XX_ADCSEL_MASK,
 			*sample & WM97XX_ADCSEL_MASK);
-		return RC_PENUP;
+		return RC_AGAIN;
 	}
=20
 	if (wants_pen && !(*sample & WM97XX_PEN_DOWN)) {
--=20
1.8.1.5
