From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 14/22] Input: atmel_mxt_ts - read and report bootloader version
Date: Mon, 17 Mar 2014 17:26:47 +0000
Message-ID: <1395077215-10922-15-git-send-email-nick.dyer@itdev.co.uk>
References: <1395077215-10922-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395077215-10922-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
Acked-by: Yufeng Shen <miletus@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 09f8b18..1ed3804 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -202,6 +202,8 @@
 #define MXT_FRAME_CRC_PASS	0x04
 #define MXT_APP_CRC_FAIL	0x40	/* valid 7 8 bit only */
 #define MXT_BOOT_STATUS_MASK	0x3f
+#define MXT_BOOT_EXTENDED_ID	(1 << 5)
+#define MXT_BOOT_ID_MASK	0x1f
 
 /* Touch status */
 #define MXT_UNGRIP		(1 << 0)
@@ -422,6 +424,27 @@ static int mxt_lookup_bootloader_address(struct mxt_data *data)
 	return 0;
 }
 
+static u8 mxt_get_bootloader_version(struct mxt_data *data, u8 val)
+{
+	struct device *dev = &data->client->dev;
+	u8 buf[3];
+
+	if (val & MXT_BOOT_EXTENDED_ID) {
+		if (mxt_bootloader_read(data, &buf[0], 3) != 0) {
+			dev_err(dev, "%s: i2c failure\n", __func__);
+			return -EIO;
+		}
+
+		dev_dbg(dev, "Bootloader ID:%d Version:%d\n", buf[1], buf[2]);
+
+		return buf[0];
+	} else {
+		dev_dbg(dev, "Bootloader ID:%d\n", val & MXT_BOOT_ID_MASK);
+
+		return val;
+	}
+}
+
 static int mxt_check_bootloader(struct mxt_data *data, unsigned int state)
 {
 	struct device *dev = &data->client->dev;
@@ -454,6 +477,9 @@ recheck:
 	if (ret)
 		return ret;
 
+	if (state == MXT_WAITING_BOOTLOAD_CMD)
+		val = mxt_get_bootloader_version(data, val);
+
 	switch (state) {
 	case MXT_WAITING_BOOTLOAD_CMD:
 	case MXT_WAITING_FRAME_DATA:
-- 
1.8.3.2
