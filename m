From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] Input: migor-ts: mark PM functions as __maybe_unused
Date: Thu, 19 May 2016 15:52:25 +0200
Message-ID: <1463665954-3898044-3-git-send-email-arnd@arndb.de>
References: <1463665954-3898044-1-git-send-email-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:56354 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbcESNyb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 09:54:31 -0400
In-Reply-To: <1463665954-3898044-1-git-send-email-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

The migor touchscreen driver is now available for COMPILE_TEST,
so we run into a harmless randconfig warning on ARM when CONFIG_PM
is disabled:

drivers/input/touchscreen/migor_ts.c:216:12: error: 'migor_ts_resume' defined but not used [-Werror=unused-function]
drivers/input/touchscreen/migor_ts.c:205:12: error: 'migor_ts_suspend' defined but not used [-Werror=unused-function]

This shuts up the warning by marking the two functions as __maybe_unused.
We could do the same thing by adding an #ifdef, but this version is
more reliable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/migor_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/migor_ts.c b/drivers/input/touchscreen/migor_ts.c
index e4b92c4cae3b..02fb11985819 100644
--- a/drivers/input/touchscreen/migor_ts.c
+++ b/drivers/input/touchscreen/migor_ts.c
@@ -202,7 +202,7 @@ static int migor_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int migor_ts_suspend(struct device *dev)
+static int __maybe_unused migor_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct migor_ts_priv *priv = i2c_get_clientdata(client);
@@ -213,7 +213,7 @@ static int migor_ts_suspend(struct device *dev)
 	return 0;
 }
 
-static int migor_ts_resume(struct device *dev)
+static int __maybe_unused migor_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct migor_ts_priv *priv = i2c_get_clientdata(client);
-- 
2.7.0

