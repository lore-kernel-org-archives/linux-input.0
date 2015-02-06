From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] input: elan: Fix wrong %p extension
Date: Fri,  6 Feb 2015 14:51:13 +0100
Message-ID: <1423230673-25877-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:42387 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbbBFNvq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 08:51:46 -0500
Received: by labhs14 with SMTP id hs14so1229917lab.9
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2015 05:51:45 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

There's no %px extension. From the context I think the intention was
to dump the five bytes which were not as expected, and for that one
should use %ph.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
I think the bug is mostly harmless, since the unrecognized extension
is simply ignored (and skipped over), and the address of the 'values'
array is simply printed as if by %5p. But since that is an address
on the kernel stack, someone might think it is worse than I do.

 drivers/input/mouse/elan_i2c_smbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
index 359bf8583d54..2a89004f3c6e 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -71,7 +71,7 @@ static int elan_smbus_initialize(struct i2c_client *client)
 
 	/* compare hello packet */
 	if (memcmp(values, check, ETP_SMBUS_HELLOPACKET_LEN)) {
-		dev_err(&client->dev, "hello packet fail [%*px]\n",
+		dev_err(&client->dev, "hello packet fail [%*ph]\n",
 			ETP_SMBUS_HELLOPACKET_LEN, values);
 		return -ENXIO;
 	}
-- 
2.1.3

