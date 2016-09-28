From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/4] Input: elan_i2c - always output the device information
Date: Wed, 28 Sep 2016 16:34:02 +0200
Message-ID: <1475073244-23068-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932679AbcI1OeM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Sep 2016 10:34:12 -0400
In-Reply-To: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Adrian Alves <aalves@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

it's always easier to retrieve these information in bug reports when
it is always printed in the dmesg.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elan_i2c_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index d15b338..2de1f75 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1093,7 +1093,7 @@ static int elan_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	dev_dbg(&client->dev,
+	dev_info(&client->dev,
 		"Elan Touchpad Information:\n"
 		"    Module product ID:  0x%04x\n"
 		"    Firmware Version:  0x%04x\n"
-- 
2.7.4

