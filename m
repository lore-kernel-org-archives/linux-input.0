From: Dan Carpenter <error27@gmail.com>
Subject: [patch] input: cy8ctmg100_ts: signedness bug
Date: Fri, 6 Aug 2010 08:30:06 +0200
Message-ID: <20100806063006.GM9031@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41890 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab0HFGaY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Aug 2010 02:30:24 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

"ret" should be signed here or the error handling doesn't work.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 4eb7df0..f4e893f 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -96,7 +96,7 @@ static int cy8ctmg110_read_regs(struct cy8ctmg110 *tsc,
 		unsigned char *data, unsigned char len, unsigned char cmd)
 {
 	struct i2c_client *client = tsc->client;
-	unsigned int ret;
+	int ret;
 	struct i2c_msg msg[2] = {
 		/* first write slave position to i2c devices */
 		{ client->addr, 0, 1, &cmd },
