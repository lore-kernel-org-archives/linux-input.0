From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] input: edt-ft5x06, Add i2c device ids
Date: Fri, 20 Feb 2015 16:56:25 +0100
Message-ID: <1424447785-14337-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49514 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbbBTP4a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 10:56:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, linux-input@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

These ids are necessary to use edt-ft5x06 as a kernel module. Otherwise
it is not loaded automatically in userspace because the ids do not match.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/input/touchscreen/edt-ft5x06.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d4c24fb7704f..63ad6d545bbe 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1119,6 +1119,9 @@ static SIMPLE_DEV_PM_OPS(edt_ft5x06_ts_pm_ops,
 
 static const struct i2c_device_id edt_ft5x06_ts_id[] = {
 	{ "edt-ft5x06", 0, },
+	{ "edt-ft5206", 0, },
+	{ "edt-ft5306", 0, },
+	{ "edt-ft5406", 0, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, edt_ft5x06_ts_id);
-- 
2.1.4

