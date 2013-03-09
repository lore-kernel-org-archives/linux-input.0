From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 1/4] Input: wm97xx: Drop out of range inputs
Date: Sat,  9 Mar 2013 18:05:50 +0100
Message-ID: <1362848753-6725-2-git-send-email-mpa@pengutronix.de>
References: <1362848753-6725-1-git-send-email-mpa@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1362848753-6725-1-git-send-email-mpa@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

With fast movements, there occured some out of screen jumps with my
touchscreen. The abs_x and abs_y module parameters should fix this by
default, but the driver doesn't actively checks the x/y coordinates.

Instead it seems that the input layer was supposed to drop out of range
inputs, as described in the comments:
"These parameters are used to help the input layer discard out of
range readings and reduce jitter etc"

The input layer documentation describes that values that are not in the
absolute range are also accepted.

So this patch adds a check within the driver.

Cc: stable@vger.kernel.org
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm97xx-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 5dbe73a..17db572 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -442,6 +442,16 @@ static int wm97xx_read_samples(struct wm97xx *wm)
 			"pen down: x=%x:%d, y=%x:%d, pressure=%x:%d\n",
 			data.x >> 12, data.x & 0xfff, data.y >> 12,
 			data.y & 0xfff, data.p >> 12, data.p & 0xfff);
+
+		if (abs_x[0] > (data.x & 0xfff) ||
+				abs_x[1] < (data.x & 0xfff) ||
+				abs_y[0] > (data.y & 0xfff) ||
+				abs_y[1] < (data.y & 0xfff)) {
+			dev_dbg(wm->dev, "Measurement out of range, dropping it\n");
+			rc = RC_AGAIN;
+			goto out;
+		}
+
 		input_report_abs(wm->input_dev, ABS_X, data.x & 0xfff);
 		input_report_abs(wm->input_dev, ABS_Y, data.y & 0xfff);
 		input_report_abs(wm->input_dev, ABS_PRESSURE, data.p & 0xfff);
@@ -455,6 +465,7 @@ static int wm97xx_read_samples(struct wm97xx *wm)
 		wm->ts_reader_interval = wm->ts_reader_min_interval;
 	}
 
+out:
 	mutex_unlock(&wm->codec_mutex);
 	return rc;
 }
-- 
1.8.1.5
