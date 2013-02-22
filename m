From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 29/40] Input: atmel_mxt_ts - Use wait_for_chg in soft_reset
Date: Fri, 22 Feb 2013 17:58:16 +0000
Message-ID: <1361555907-19840-30-git-send-email-nick.dyer@itdev.co.uk>
References: <1361555907-19840-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361555907-19840-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan.Bowens@atmel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, bleung@chromium.org, olofj@chromium.org
Cc: Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index f182228..96c961e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1044,7 +1044,6 @@ static int mxt_t6_command(struct mxt_data *data, u16 cmd_offset, u8 value, bool
 static int mxt_soft_reset(struct mxt_data *data, u8 value)
 {
 	int ret;
-	int timeout_counter = 0;
 	struct device *dev = &data->client->dev;
 
 	dev_info(dev, "Resetting chip\n");
@@ -1057,14 +1056,7 @@ static int mxt_soft_reset(struct mxt_data *data, u8 value)
 		msleep(MXT_RESET_NOCHGREAD);
 	} else {
 		msleep(MXT_RESET_TIME);
-
-		timeout_counter = 0;
-		while ((timeout_counter++ <= 100) && data->pdata->read_chg())
-			msleep(20);
-		if (timeout_counter > 100) {
-			dev_err(dev, "No response after reset!\n");
-			return -EIO;
-		}
+		mxt_wait_for_chg(data);
 	}
 
 	return 0;
-- 
1.7.10.4
