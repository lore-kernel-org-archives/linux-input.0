From: Christos Gkekas <chris.gekas@gmail.com>
Subject: [PATCH] Input: atmel_mxt_ts - Remove unnecessary byte_offset check
Date: Sun,  8 Oct 2017 19:44:18 +0100
Message-ID: <1507488258-22409-1-git-send-email-chris.gekas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christos Gkekas <chris.gekas@gmail.com>
List-Id: linux-input@vger.kernel.org

Variable byte_offset is unsigned so checking whether it is greater or
equal to zero is redundant.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7659bc4..baafaed 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1356,7 +1356,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
 
 			byte_offset = reg + i - cfg_start_ofs;
 
-			if (byte_offset >= 0 && byte_offset < config_mem_size) {
+			if (byte_offset < config_mem_size) {
 				*(config_mem + byte_offset) = val;
 			} else {
 				dev_err(dev, "Bad object: reg:%d, T%d, ofs=%d\n",
-- 
2.7.4
