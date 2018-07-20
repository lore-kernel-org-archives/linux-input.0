From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1 10/10] Input: atmel_mxt_ts - move completion to after config crc is updated
Date: Fri, 20 Jul 2018 22:51:22 +0100
Message-ID: <20180720215122.23558-10-nick@shmanahar.org>
References: <20180720215122.23558-1-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720215122.23558-1-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c31af790ef84..9f296a66c94e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -728,13 +728,13 @@ static void mxt_proc_t6_messages(struct mxt_data *data, u8 *msg)
 	u8 status = msg[1];
 	u32 crc = msg[2] | (msg[3] << 8) | (msg[4] << 16);
 
-	complete(&data->crc_completion);
-
 	if (crc != data->config_crc) {
 		data->config_crc = crc;
 		dev_dbg(dev, "T6 Config Checksum: 0x%06X\n", crc);
 	}
 
+	complete(&data->crc_completion);
+
 	/* Detect reset */
 	if (status & MXT_T6_STATUS_RESET)
 		complete(&data->reset_completion);
-- 
2.17.1
