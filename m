From: nick.dyer@itdev.co.uk
Subject: [PATCH] Input: atmel_mxt_ts - fix invalid return from mxt_get_bootloader_version
Date: Thu, 29 May 2014 13:34:22 +0100
Message-ID: <1401366862-6295-1-git-send-email-nick.dyer@itdev.co.uk>
References: <20140521122624.GB23396@mwanda>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:59876 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755718AbaE2MjP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 08:39:15 -0400
In-Reply-To: <20140521122624.GB23396@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>

From: Nick Dyer <nick.dyer@itdev.co.uk>

The patch e57a66aa8534: "Input: atmel_mxt_ts - read and report
bootloader version" from May 18, 2014, leads to the following static
checker warning:

	drivers/input/touchscreen/atmel_mxt_ts.c:437 mxt_get_bootloader_version()
	warn: signedness bug returning '(-5)'

drivers/input/touchscreen/atmel_mxt_ts.c
   429  static u8 mxt_get_bootloader_version(struct mxt_data *data, u8 val)
   430  {
   431          struct device *dev = &data->client->dev;
   432          u8 buf[3];
   433
   434          if (val & MXT_BOOT_EXTENDED_ID) {
   435                  if (mxt_bootloader_read(data, &buf[0], 3) != 0) {
   436                          dev_err(dev, "%s: i2c failure\n", __func__);
   437                          return -EIO;
                                       ^^^^
This gets truncated into a number from 0-255 and anyway the caller
doesn't check for errors.

(reported by Dan Carpenter)

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index fb0e006..693b163 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -435,7 +435,7 @@ static u8 mxt_get_bootloader_version(struct mxt_data *data, u8 val)
 	if (val & MXT_BOOT_EXTENDED_ID) {
 		if (mxt_bootloader_read(data, &buf[0], 3) != 0) {
 			dev_err(dev, "%s: i2c failure\n", __func__);
-			return -EIO;
+			return val;
 		}
 
 		dev_dbg(dev, "Bootloader ID:%d Version:%d\n", buf[1], buf[2]);
-- 
1.8.3.2

