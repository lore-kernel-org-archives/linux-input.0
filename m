From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] touchscreen: elants: fix a missing check of return values
Date: Fri, 21 Dec 2018 00:59:16 -0600
Message-ID: <20181221065919.60129-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <swboyd@chromium.org>, Joe Perches <joe@perches.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

elants_i2c_send() may fail, let's check its return values. The fix does
the check and reports an error message upon the failure.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/input/touchscreen/elants_i2c.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index f2cb23121833..cb3c1470bb68 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -245,8 +245,14 @@ static int elants_i2c_calibrate(struct elants_data *ts)
 	ts->state = ELAN_WAIT_RECALIBRATION;
 	reinit_completion(&ts->cmd_done);
 
-	elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
-	elants_i2c_send(client, rek, sizeof(rek));
+	error = elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
+	error |= elants_i2c_send(client, rek, sizeof(rek));
+	if (error) {
+		dev_err(&client->dev,
+				"error in sending I2C messages for calibration: %d\n",
+				error);
+		return error;
+	}
 
 	enable_irq(client->irq);
 
-- 
2.17.2 (Apple Git-113)
