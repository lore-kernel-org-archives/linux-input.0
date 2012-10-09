From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] input: Convert struct i2c_msg initialization to C99 format
Date: Tue, 9 Oct 2012 17:01:17 +0530
Message-ID: <1349782278-9023-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Convert the struct i2c_msg initialization to C99 format. This makes
maintaining and editing the code simpler. Also helps once other fields
like transferred are added in future.

Thanks to Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>  for automating the conversion

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/input/joystick/as5011.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index c96653b..9d869e2 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -85,7 +85,10 @@ static int as5011_i2c_write(struct i2c_client *client,
 {
 	uint8_t data[2] = { aregaddr, avalue };
 	struct i2c_msg msg = {
-		client->addr, I2C_M_IGNORE_NAK, 2, (uint8_t *)data
+		.addr = client->addr,
+		.flags = I2C_M_IGNORE_NAK,
+		.len = 2,
+		.buf = (uint8_t *)data
 	};
 	int error;
 
@@ -98,8 +101,18 @@ static int as5011_i2c_read(struct i2c_client *client,
 {
 	uint8_t data[2] = { aregaddr };
 	struct i2c_msg msg_set[2] = {
-		{ client->addr, I2C_M_REV_DIR_ADDR, 1, (uint8_t *)data },
-		{ client->addr, I2C_M_RD | I2C_M_NOSTART, 1, (uint8_t *)data }
+		{
+			.addr = client->addr,
+			.flags = I2C_M_REV_DIR_ADDR,
+			.len = 1,
+			.buf = (uint8_t *)data
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD | I2C_M_NOSTART,
+			.len = 1,
+			.buf = (uint8_t *)data
+		}
 	};
 	int error;
 
-- 
1.7.5.4
