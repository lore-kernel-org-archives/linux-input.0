From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH 3/3] Input: atmel_mxt_ts - Handle objects with multiple instances
 correctly
Date: Mon, 04 Jul 2011 12:06:31 +0300
Message-ID: <4E118297.1040607@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:7565 "EHLO sjogate2.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583Ab1GDJGr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Jul 2011 05:06:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

Handle the objects with multiple instances correctly when the configuration data
is loaded.

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index da8c9ca..90f221f 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -655,7 +655,9 @@ static int mxt_check_reg_init(struct mxt_data *data)
 		if (!mxt_object_writable(object->type))
 			continue;
 
-		for (j = 0; j < object->size + 1; j++) {
+		for (j = 0;
+		     j < ((object->size + 1) * (object->instances + 1));
+		     j++) {
 			config_offset = index + j;
 			if (config_offset > pdata->config_length) {
 				dev_err(dev, "Not enough config data!\n");
@@ -664,7 +666,7 @@ static int mxt_check_reg_init(struct mxt_data *data)
 			mxt_write_object(data, object->type, j,
 					 pdata->config[config_offset]);
 		}
-		index += object->size + 1;
+		index += (object->size + 1) * (object->instances + 1);
 	}
 
 	return 0;
-- 
1.7.0.4
