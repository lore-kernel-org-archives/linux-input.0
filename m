From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: [PATCH v2] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Mon, 13 Jul 2015 15:23:54 -0700
Message-ID: <1436826234-2447-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33118 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbbGMWX7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 18:23:59 -0400
Received: by padck2 with SMTP id ck2so49420386pad.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 15:23:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: borneo.antonio@gmail.com, dbarksdale@uplogix.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: ellen@cumulusnetworks.com

When doing an I2C_SMBUS_BYTE write (one byte write, no address),
the data to be written is in "command" not "data->byte".

Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
---
Forgot signed-off-by tag last time, sorry.
---
 drivers/hid/hid-cp2112.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index a3703b8..7afc3fc 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -606,7 +606,7 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 		if (I2C_SMBUS_READ == read_write)
 			count = cp2112_read_req(buf, addr, read_length);
 		else
-			count = cp2112_write_req(buf, addr, data->byte, NULL,
+			count = cp2112_write_req(buf, addr, command, NULL,
 						 0);
 		break;
 	case I2C_SMBUS_BYTE_DATA:
-- 
1.9.1

