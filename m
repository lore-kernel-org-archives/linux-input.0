From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 08/20] Input: atmel_mxt_ts - store actual size and instance
Date: Tue, 13 Mar 2012 20:04:11 +0800
Message-ID: <1331640263-18935-9-git-send-email-djkurtz@chromium.org>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:45412 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab2CMMLH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 08:11:07 -0400
Received: by eaaq10 with SMTP id q10so24358eaa.1
        for <linux-input@vger.kernel.org>; Tue, 13 Mar 2012 05:11:06 -0700 (PDT)
In-Reply-To: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>

These two object table entry fields are reported 1 less than their value.
So add 1 once, when building the object table, instead of every time
these fields are accessed.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index e988dc0..c422fad 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -676,7 +676,7 @@ static int mxt_check_reg_init(struct mxt_data *data)
 	struct mxt_object *object;
 	struct device *dev = &data->client->dev;
 	int index = 0;
-	int i, j, config_offset;
+	int i, j, config_offset, config_size;
 
 	if (!pdata->config) {
 		dev_dbg(dev, "No cfg data defined, skipping reg init\n");
@@ -689,9 +689,8 @@ static int mxt_check_reg_init(struct mxt_data *data)
 		if (!mxt_object_writable(object->type))
 			continue;
 
-		for (j = 0;
-		     j < (object->size + 1) * (object->instances + 1);
-		     j++) {
+		config_size = object->size * object->instances;
+		for (j = 0; j < config_size; j++) {
 			config_offset = index + j;
 			if (config_offset > pdata->config_length) {
 				dev_err(dev, "Not enough config data!\n");
@@ -700,7 +699,7 @@ static int mxt_check_reg_init(struct mxt_data *data)
 			mxt_write_object(data, object->type, j,
 					 pdata->config[config_offset]);
 		}
-		index += (object->size + 1) * (object->instances + 1);
+		index += config_size;
 	}
 
 	return 0;
@@ -829,13 +828,12 @@ static int mxt_get_object_table(struct mxt_data *data)
 
 		object->type = buf[0];
 		object->start_address = (buf[2] << 8) | buf[1];
-		object->size = buf[3];
-		object->instances = buf[4];
+		object->size = buf[3] + 1;
+		object->instances = buf[4] + 1;
 		object->num_report_ids = buf[5];
 
 		if (object->num_report_ids) {
-			reportid += object->num_report_ids *
-					(object->instances + 1);
+			reportid += object->num_report_ids * object->instances;
 			object->max_reportid = reportid;
 		}
 	}
@@ -950,7 +948,7 @@ static ssize_t mxt_object_show(struct device *dev,
 			continue;
 		}
 
-		for (j = 0; j < object->size + 1; j++) {
+		for (j = 0; j < object->size; j++) {
 			error = mxt_read_object(data,
 						object->type, j, &val);
 			if (error)
-- 
1.7.7.3

