From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/4] Input: elan_i2c - fix return tests of i2c_smbus_read_block_data()
Date: Wed, 28 Sep 2016 16:34:01 +0200
Message-ID: <1475073244-23068-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932670AbcI1OeL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Sep 2016 10:34:11 -0400
In-Reply-To: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Adrian Alves <aalves@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

i2c_smbus_read_block_data() returns negative errno else the number of
data bytes in the slave's response.

Checking for error not null means the function always fails if the device
answers properly.

So given that we read 3 bytes and access those, better check that we
actually read those 3 bytes.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elan_i2c_smbus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
index cb6aecb..9b43b55 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -226,7 +226,7 @@ static int elan_smbus_get_max(struct i2c_client *client,
 	u8 val[3];
 
 	error = i2c_smbus_read_block_data(client, ETP_SMBUS_RANGE_CMD, val);
-	if (error) {
+	if (error != 3) {
 		dev_err(&client->dev, "failed to get dimensions: %d\n", error);
 		return error;
 	}
@@ -245,7 +245,7 @@ static int elan_smbus_get_resolution(struct i2c_client *client,
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_RESOLUTION_CMD, val);
-	if (error) {
+	if (error != 3) {
 		dev_err(&client->dev, "failed to get resolution: %d\n", error);
 		return error;
 	}
@@ -265,7 +265,7 @@ static int elan_smbus_get_num_traces(struct i2c_client *client,
 
 	error = i2c_smbus_read_block_data(client,
 					  ETP_SMBUS_XY_TRACENUM_CMD, val);
-	if (error) {
+	if (error != 3) {
 		dev_err(&client->dev, "failed to get trace info: %d\n", error);
 		return error;
 	}
-- 
2.7.4

