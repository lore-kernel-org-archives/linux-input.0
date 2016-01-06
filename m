From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: rohm_bu21023 - fix handling of retrying firmware
 update
Date: Wed, 6 Jan 2016 14:51:11 -0800
Message-ID: <20160106225111.GA40396@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35598 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbcAFWvP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2016 17:51:15 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Yoichi Yuasa <yuasa@linux-mips.org>, linux-kernel@vger.kernel.org

Because of the wrong condition we'd never retry firmware update.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/rohm_bu21023.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index ba6024f..611156a 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -725,7 +725,7 @@ static int rohm_ts_load_firmware(struct i2c_client *client,
 			break;
 
 		error = -EIO;
-	} while (++retry >= FIRMWARE_RETRY_MAX);
+	} while (++retry <= FIRMWARE_RETRY_MAX);
 
 out:
 	error2 = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
