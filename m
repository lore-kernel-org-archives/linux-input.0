From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: raydium_i2c_ts: fix spelling mistake in dev_err message
Date: Wed, 16 Nov 2016 18:40:30 +0000
Message-ID: <20161116184030.10486-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52128 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbcKPSkq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Nov 2016 13:40:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffrey Lin <jeffrey.lin@rad-ic.com>, Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake "failied" to "failed" in
dev_err message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index a99fb5c..2658afa 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -669,7 +669,7 @@ static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
 
 		if (ts->boot_mode == RAYDIUM_TS_MAIN) {
 			dev_err(&client->dev,
-				"failied to jump to boot loader: %d\n",
+				"failed to jump to boot loader: %d\n",
 				error);
 			return -EIO;
 		}
-- 
2.10.2

