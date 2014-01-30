From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/4] Input: wacom: References to 'wacom->data' should use 'unsigned char*'
Date: Thu, 30 Jan 2014 10:48:47 -0800
Message-ID: <1391107728-1306-3-git-send-email-killertofu@gmail.com>
References: <1391107728-1306-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57212 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbaA3Ssp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 13:48:45 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so3465758pab.30
        for <linux-input@vger.kernel.org>; Thu, 30 Jan 2014 10:48:45 -0800 (PST)
In-Reply-To: <1391107728-1306-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net, pinglinux@gmail.com, skomra@gmail.com, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

'wacom->data' contains raw binary data and can lead to unexpected
behavior if a byte under examination happens to have its MSB set.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 05f371d..9ff5613 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -178,10 +178,9 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
 
 static int wacom_dtu_irq(struct wacom_wac *wacom)
 {
-	struct wacom_features *features = &wacom->features;
-	char *data = wacom->data;
+	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->input;
-	int prox = data[1] & 0x20, pressure;
+	int prox = data[1] & 0x20;
 
 	dev_dbg(input->dev.parent,
 		"%s: received report #%d", __func__, data[0]);
@@ -198,10 +197,7 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 	input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
 	input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
 	input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
-	pressure = ((data[7] & 0x01) << 8) | data[6];
-	if (pressure < 0)
-		pressure = features->pressure_max + pressure + 1;
-	input_report_abs(input, ABS_PRESSURE, pressure);
+	input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x01) << 8) | data[6]);
 	input_report_key(input, BTN_TOUCH, data[1] & 0x05);
 	if (!prox) /* out-prox */
 		wacom->id[0] = 0;
@@ -906,7 +902,7 @@ static int int_dist(int x1, int y1, int x2, int y2)
 static int wacom_24hdt_irq(struct wacom_wac *wacom)
 {
 	struct input_dev *input = wacom->input;
-	char *data = wacom->data;
+	unsigned char *data = wacom->data;
 	int i;
 	int current_num_contacts = data[61];
 	int contacts_to_send = 0;
@@ -959,7 +955,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 static int wacom_mt_touch(struct wacom_wac *wacom)
 {
 	struct input_dev *input = wacom->input;
-	char *data = wacom->data;
+	unsigned char *data = wacom->data;
 	int i;
 	int current_num_contacts = data[2];
 	int contacts_to_send = 0;
@@ -1038,7 +1034,7 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 
 static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 {
-	char *data = wacom->data;
+	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->input;
 	bool prox;
 	int x = 0, y = 0;
@@ -1074,10 +1070,8 @@ static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 
 static int wacom_tpc_pen(struct wacom_wac *wacom)
 {
-	struct wacom_features *features = &wacom->features;
-	char *data = wacom->data;
+	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->input;
-	int pressure;
 	bool prox = data[1] & 0x20;
 
 	if (!wacom->shared->stylus_in_proximity) /* first in prox */
@@ -1093,10 +1087,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
 		input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
 		input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
 		input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
-		pressure = ((data[7] & 0x01) << 8) | data[6];
-		if (pressure < 0)
-			pressure = features->pressure_max + pressure + 1;
-		input_report_abs(input, ABS_PRESSURE, pressure);
+		input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x01) << 8) | data[6]);
 		input_report_key(input, BTN_TOUCH, data[1] & 0x05);
 		input_report_key(input, wacom->tool[0], prox);
 		return 1;
@@ -1107,7 +1098,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
 
 static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 {
-	char *data = wacom->data;
+	unsigned char *data = wacom->data;
 
 	dev_dbg(wacom->input->dev.parent,
 		"%s: received report #%d\n", __func__, data[0]);
-- 
1.8.5.3

