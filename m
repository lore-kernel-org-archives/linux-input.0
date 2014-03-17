From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 17/22] Input: atmel_mxt_ts - add check for incorrect firmware file format
Date: Mon, 17 Mar 2014 17:26:50 +0000
Message-ID: <1395077215-10922-18-git-send-email-nick.dyer@itdev.co.uk>
References: <1395077215-10922-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395077215-10922-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

Atmel supplies firmware files in ASCII HEX format (.enc) which must be
converted before they can be loaded by kernel driver. Try to detect
the error and print a friendly error message rather than feeding junk
to the bootloader.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
Acked-by: Yufeng Shen <miletus@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index b263ec3..b5c3f8e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1425,6 +1425,30 @@ done:
 	return error ?: count;
 }
 
+static int mxt_check_firmware_format(struct device *dev,
+				     const struct firmware *fw)
+{
+	unsigned int pos = 0;
+	char c;
+
+	while (pos < fw->size) {
+		c = *(fw->data + pos);
+
+		if (c < '0' || (c > '9' && c < 'A') || c > 'F')
+			return 0;
+
+		pos++;
+	}
+
+	/*
+	 * To convert file try:
+	 * xxd -r -p mXTXXX__APP_VX-X-XX.enc > maxtouch.fw
+	 */
+	dev_err(dev, "Aborting: firmware file must be in binary format\n");
+
+	return -EINVAL;
+}
+
 static int mxt_load_fw(struct device *dev, const char *fn)
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
@@ -1441,6 +1465,11 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 		return ret;
 	}
 
+	/* Check for incorrect enc file */
+	ret = mxt_check_firmware_format(dev, fw);
+	if (ret)
+		goto release_firmware;
+
 	ret = mxt_lookup_bootloader_address(data);
 	if (ret)
 		goto release_firmware;
-- 
1.8.3.2
