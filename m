From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 46/51] Input: atmel_mxt_ts - Initialize power config before and after downloading cfg
Date: Thu, 27 Jun 2013 13:49:21 +0100
Message-ID: <1372337366-9286-47-git-send-email-nick.dyer@itdev.co.uk>
References: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

If the power configuration is zero then the configuration download may fail to
work properly, so initialize T7 before config download. The downloaded
configuration may reset the T7 power configuration so it must be
re-initialized afterwards.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index b4ecd1d..5ab3861 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1226,6 +1226,8 @@ static int mxt_check_retrigen(struct mxt_data *data)
 	return 0;
 }
 
+static int mxt_init_t7_power_cfg(struct mxt_data *data);
+
 /*
  * mxt_check_reg_init - download configuration to chip
  *
@@ -1485,6 +1487,9 @@ static int mxt_check_reg_init(struct mxt_data *data)
 
 	dev_info(dev, "Config written\n");
 
+	/* T7 config may have changed */
+	mxt_init_t7_power_cfg(data);
+
 release_mem:
 	kfree(config_mem);
 release:
@@ -1883,17 +1888,17 @@ retry_bootloader:
 	if (error)
 		goto err_free_object_table;
 
-	/* Check register init values */
-	error = mxt_check_reg_init(data);
+	error = mxt_init_t7_power_cfg(data);
 	if (error) {
-		dev_err(&client->dev, "Error %d initialising configuration\n",
-			error);
+		dev_err(&client->dev, "Failed to initialize power cfg\n");
 		goto err_free_object_table;
 	}
 
-	error = mxt_init_t7_power_cfg(data);
+	/* Check register init values */
+	error = mxt_check_reg_init(data);
 	if (error) {
-		dev_err(&client->dev, "Failed to initialize power cfg\n");
+		dev_err(&client->dev, "Error %d initialising configuration\n",
+			error);
 		goto err_free_object_table;
 	}
 
-- 
1.7.10.4
