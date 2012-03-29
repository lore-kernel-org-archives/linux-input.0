From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 08/16 v2] Input: atmel_mxt_ts - refactor mxt_object_show
Date: Fri, 30 Mar 2012 00:49:18 +0800
Message-ID: <1333039766-8617-9-git-send-email-djkurtz@chromium.org>
References: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:63277 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759873Ab2C2Qtb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 12:49:31 -0400
Received: by vbnl22 with SMTP id l22so275647vbn.1
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 09:49:30 -0700 (PDT)
In-Reply-To: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>

Read each object with a single i2c transaction instead of byte-by-byte.

Also, don't read T5, which is the message processor object.  Reading
it is counter-productive since it either holds garbage (there is no
pending message), or, it holds a real message which should be handled
by the messages handling code (the isr).

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   43 ++++++++++++------------------
 1 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index b6e7109..a865967 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -262,7 +262,6 @@ struct mxt_data {
 static bool mxt_object_readable(unsigned int type)
 {
 	switch (type) {
-	case MXT_GEN_MESSAGE_T5:
 	case MXT_GEN_COMMAND_T6:
 	case MXT_GEN_POWER_T7:
 	case MXT_GEN_ACQUIRE_T8:
@@ -459,6 +458,13 @@ mxt_get_object(struct mxt_data *data, u8 type)
 	return NULL;
 }
 
+static int mxt_read_object(struct mxt_data *data, struct mxt_object *object,
+			   void *val)
+{
+	return mxt_read_reg(data->client, object->start_address, object->size,
+			    val);
+}
+
 static int mxt_read_message(struct mxt_data *data,
 				 struct mxt_message *message)
 {
@@ -474,20 +480,6 @@ static int mxt_read_message(struct mxt_data *data,
 			    message);
 }
 
-static int mxt_read_object(struct mxt_data *data,
-				u8 type, u8 offset, u8 *val)
-{
-	struct mxt_object *object;
-	u16 reg;
-
-	object = mxt_get_object(data, type);
-	if (!object)
-		return -EINVAL;
-
-	reg = object->start_address;
-	return mxt_read_reg(data->client, reg + offset, 1, val);
-}
-
 static int mxt_write_object(struct mxt_data *data,
 				 u8 type, u8 offset, u8 val)
 {
@@ -885,17 +877,16 @@ static void mxt_calc_resolution(struct mxt_data *data)
 }
 
 static ssize_t mxt_object_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+			       struct device_attribute *attr, char *buf)
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
-	struct mxt_object *object;
 	int count = 0;
 	int i, j;
 	int error;
-	u8 val;
+	u8 obuf[256];
 
 	for (i = 0; i < data->info.object_num; i++) {
-		object = data->object_table + i;
+		struct mxt_object *object = &data->object_table[i];
 
 		count += snprintf(buf + count, PAGE_SIZE - count,
 				"Object[%d] (Type %d)\n",
@@ -905,20 +896,20 @@ static ssize_t mxt_object_show(struct device *dev,
 
 		if (!mxt_object_readable(object->type)) {
 			count += snprintf(buf + count, PAGE_SIZE - count,
-					"\n");
+					  "\n");
 			if (count >= PAGE_SIZE)
 				return PAGE_SIZE - 1;
 			continue;
 		}
 
-		for (j = 0; j < object->size; j++) {
-			error = mxt_read_object(data,
-						object->type, j, &val);
-			if (error)
-				return error;
+		error = mxt_read_object(data, object, obuf);
+		if (error)
+			return error;
 
+		for (j = 0; j < object->size; j++) {
 			count += snprintf(buf + count, PAGE_SIZE - count,
-					"\t[%2d]: %02x (%d)\n", j, val, val);
+					  "\t[%2d]: %02x (%d)\n", j, obuf[j],
+					  obuf[j]);
 			if (count >= PAGE_SIZE)
 				return PAGE_SIZE - 1;
 		}
-- 
1.7.7.3

