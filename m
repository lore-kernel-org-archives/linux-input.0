From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Input: melfas_mip4 - remove set but not used variables
Date: Fri, 26 Jul 2019 22:22:16 +0800
Message-ID: <20190726142216.35212-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jeesw@melfas.com, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/input/touchscreen/melfas_mip4.c: In function 'mip4_report_touch':
drivers/input/touchscreen/melfas_mip4.c:474:5: warning: variable 'size' set but not used [-Wunused-but-set-variable]
drivers/input/touchscreen/melfas_mip4.c:472:5: warning: variable 'pressure_stage' set but not used [-Wunused-but-set-variable]
drivers/input/touchscreen/melfas_mip4.c:469:7: warning: variable 'palm' set but not used [-Wunused-but-set-variable]
drivers/input/touchscreen/melfas_mip4.c:468:7: warning: variable 'hover' set but not used [-Wunused-but-set-variable]

They are never used so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 247c3aa..d291a82 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -465,13 +465,9 @@ static void mip4_report_keys(struct mip4_ts *ts, u8 *packet)
 static void mip4_report_touch(struct mip4_ts *ts, u8 *packet)
 {
 	int id;
-	bool hover;
-	bool palm;
 	bool state;
 	u16 x, y;
-	u8 pressure_stage = 0;
 	u8 pressure;
-	u8 size;
 	u8 touch_major;
 	u8 touch_minor;
 
@@ -480,14 +476,11 @@ static void mip4_report_touch(struct mip4_ts *ts, u8 *packet)
 	case 1:
 		/* Touch only */
 		state = packet[0] & BIT(7);
-		hover = packet[0] & BIT(5);
-		palm = packet[0] & BIT(4);
 		id = (packet[0] & 0x0F) - 1;
 		x = ((packet[1] & 0x0F) << 8) | packet[2];
 		y = (((packet[1] >> 4) & 0x0F) << 8) |
 			packet[3];
 		pressure = packet[4];
-		size = packet[5];
 		if (ts->event_format == 0) {
 			touch_major = packet[5];
 			touch_minor = packet[5];
@@ -501,14 +494,10 @@ static void mip4_report_touch(struct mip4_ts *ts, u8 *packet)
 	default:
 		/* Touch + Force(Pressure) */
 		id = (packet[0] & 0x0F) - 1;
-		hover = packet[1] & BIT(2);
-		palm = packet[1] & BIT(1);
 		state = packet[1] & BIT(0);
 		x = ((packet[2] & 0x0F) << 8) | packet[3];
 		y = (((packet[2] >> 4) & 0x0F) << 8) |
 			packet[4];
-		size = packet[6];
-		pressure_stage = (packet[7] & 0xF0) >> 4;
 		pressure = ((packet[7] & 0x0F) << 8) |
 			packet[8];
 		touch_major = packet[9];
-- 
2.7.4
