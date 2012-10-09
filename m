From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 2/4] input: Convert struct i2c_msg initialization to C99 format
Date: Tue, 9 Oct 2012 17:01:18 +0530
Message-ID: <1349782278-9023-2-git-send-email-shubhrajyoti@ti.com>
References: <1349782278-9023-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44155 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab2JILbZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Oct 2012 07:31:25 -0400
In-Reply-To: <1349782278-9023-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, dmitry.torokhov@gmail.com, Shubhrajyoti D <shubhrajyoti@ti.com>

Convert the struct i2c_msg initialization to C99 format. This makes
maintaining and editing the code simpler. Also helps once other fields
like transferred are added in future.

Thanks to Julia Lawall <julia.lawall@lip6.fr>  for automating the conversion

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/input/touchscreen/cy8ctmg110_ts.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 464f1bf..f4cfedf 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -99,9 +99,19 @@ static int cy8ctmg110_read_regs(struct cy8ctmg110 *tsc,
 	int ret;
 	struct i2c_msg msg[2] = {
 		/* first write slave position to i2c devices */
-		{ client->addr, 0, 1, &cmd },
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &cmd
+		},
 		/* Second read data from position */
-		{ client->addr, I2C_M_RD, len, data }
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = len,
+			.buf = data
+		}
 	};
 
 	ret = i2c_transfer(client->adapter, msg, 2);
-- 
1.7.5.4

