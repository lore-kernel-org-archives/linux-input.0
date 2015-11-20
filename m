From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] Input: atmel_mxt_ts - Add maxtouch to I2C table for module autoload
Date: Fri, 20 Nov 2015 15:57:31 -0300
Message-ID: <1448045851-7262-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38177 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbbKTS5k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 13:57:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The Atmel maxtouch DT binding documents that the compatible string for
the device is "atmel,maxtouch" but the I2C core always reports a module
alias of the form i2c:alias where alias is the compatible string model:

MODALIAS=i2c:maxtouch

But there isn't maxtouch entry in the I2C device ID table so when the
i2c:maxtouch MODALIAS uevent is reported, kmod is not able to match the
alias with a module to load:

alias:          of:N*T*Catmel,maxtouch
alias:          i2c:mXT224
alias:          i2c:atmel_mxt_tp
alias:          i2c:atmel_mxt_ts
alias:          i2c:qt602240_ts

So add this entry to the I2C device ID table to allow the module to be
autoloaded when the device is registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/atmel_mxt_ts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c5622058c22b..b6e53b97244c 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2701,6 +2701,7 @@ static const struct i2c_device_id mxt_id[] = {
 	{ "qt602240_ts", 0 },
 	{ "atmel_mxt_ts", 0 },
 	{ "atmel_mxt_tp", 0 },
+	{ "maxtouch", 0 },
 	{ "mXT224", 0 },
 	{ }
 };
-- 
2.4.3

