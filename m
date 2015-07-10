From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [PATCH v1] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Thu,  9 Jul 2015 22:07:51 -0700
Message-ID: <1436504871-3676-1-git-send-email-ellen@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org
List-Id: linux-input@vger.kernel.org

When doing an I2C_SMBUS_BYTE write (one byte write, no address),
the data to be written is in "command" not "data->byte".
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
