From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 29/38] Input: touchscreen: atmel: remove invalid check
Date: Mon, 21 Sep 2015 15:34:01 +0200
Message-ID: <1442842450-29769-30-git-send-email-a.hajda@samsung.com>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

byte_offset is unsigned.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c562205..c577f95 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1267,7 +1267,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
 
 			byte_offset = reg + i - cfg_start_ofs;
 
-			if (byte_offset >= 0 && byte_offset < config_mem_size) {
+			if (byte_offset < config_mem_size) {
 				*(config_mem + byte_offset) = val;
 			} else {
 				dev_err(dev, "Bad object: reg:%d, T%d, ofs=%d\n",
-- 
1.9.1
