From: nick.dyer@itdev.co.uk
Subject: [PATCH 1/2] Input: atmel_mxt_ts - Fix double free of input device
Date: Thu,  7 Aug 2014 15:07:17 +0100
Message-ID: <1407420438-6289-2-git-send-email-nick.dyer@itdev.co.uk>
References: <1407420438-6289-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407420438-6289-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Sekhar Nori <nsekhar@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

From: Stephen Warren <swarren@wwwdotorg.org>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 03b8571..da497db 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1353,8 +1353,10 @@ static int mxt_get_info(struct mxt_data *data)
 
 static void mxt_free_object_table(struct mxt_data *data)
 {
-	input_unregister_device(data->input_dev);
-	data->input_dev = NULL;
+	if (data->input_dev) {
+		input_unregister_device(data->input_dev);
+		data->input_dev = NULL;
+	}
 
 	kfree(data->object_table);
 	data->object_table = NULL;
@@ -2194,7 +2196,6 @@ static int mxt_remove(struct i2c_client *client)
 
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	free_irq(data->irq, data);
-	input_unregister_device(data->input_dev);
 	mxt_free_object_table(data);
 	kfree(data);
 
-- 
1.9.1
