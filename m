From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 2/2] input: Convert struct i2c_msg initialization to C99 format
Date: Mon, 17 Sep 2012 19:48:01 +0530
Message-ID: <1347891481-18086-3-git-send-email-shubhrajyoti@ti.com>
References: <1347891481-18086-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347891481-18086-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-input@vger.kernel.org

        Convert the struct i2c_msg initialization to C99 format. This makes
        maintaining and editing the code simpler. Also helps once other fields
        like transferred are added in future.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/input/touchscreen/cy8ctmg110_ts.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 464f1bf..2ed0427 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -99,9 +99,9 @@ static int cy8ctmg110_read_regs(struct cy8ctmg110 *tsc,
 	int ret;
 	struct i2c_msg msg[2] = {
 		/* first write slave position to i2c devices */
-		{ client->addr, 0, 1, &cmd },
+		{ .addr = client->addr, .flags = 0, .len = 1, .buf = &cmd },
 		/* Second read data from position */
-		{ client->addr, I2C_M_RD, len, data }
+		{ .addr = client->addr, .flags = I2C_M_RD, .len = len, .buf = data }
 	};
 
 	ret = i2c_transfer(client->adapter, msg, 2);
-- 
1.7.5.4
