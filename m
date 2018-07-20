From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1 08/10] Input: atmel_mxt_ts - don't report zero pressure from T9
Date: Fri, 20 Jul 2018 22:51:20 +0100
Message-ID: <20180720215122.23558-8-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

If T9.CTRL DISAMP is set, then pressure is reported as zero. This means
some app layers (eg tslib) will ignore the contact.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2d1fddafb7f9..d7023d261458 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -843,6 +843,10 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 			mxt_input_sync(data);
 		}
 
+		/* if active, pressure must be non-zero */
+		if (!amplitude)
+			amplitude = MXT_PRESSURE_DEFAULT;
+
 		/* Touch active */
 		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 1);
 		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
-- 
2.17.1
