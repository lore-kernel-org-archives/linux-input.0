From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 06/16 v2] Input: atmel_mxt_ts - do not read extra (checksum) byte
Date: Fri, 30 Mar 2012 00:49:16 +0800
Message-ID: <1333039766-8617-7-git-send-email-djkurtz@chromium.org>
References: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:51964 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759708Ab2C2Qt3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 12:49:29 -0400
Received: by yenq2 with SMTP id q2so282371yen.1
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 09:49:29 -0700 (PDT)
In-Reply-To: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>

atmel_mxt devices will send a checksum byte at the end of a message if
the MSB of the object address is set.
However, since this driver does not set this bit, the checksum byte
isn't actually sent, so don't even try to read it.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 242976d..ea3ee5a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -236,7 +236,6 @@ struct mxt_object {
 struct mxt_message {
 	u8 reportid;
 	u8 message[7];
-	u8 checksum;
 };
 
 struct mxt_finger {
@@ -336,7 +335,6 @@ static void mxt_dump_message(struct device *dev,
 	dev_dbg(dev, "message5:\t0x%x\n", message->message[4]);
 	dev_dbg(dev, "message6:\t0x%x\n", message->message[5]);
 	dev_dbg(dev, "message7:\t0x%x\n", message->message[6]);
-	dev_dbg(dev, "checksum:\t0x%x\n", message->checksum);
 }
 
 static int mxt_check_bootloader(struct i2c_client *client,
-- 
1.7.7.3

