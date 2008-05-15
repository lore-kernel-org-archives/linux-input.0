From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] fix migor_ts dependency and compile warning
Date: Thu, 15 May 2008 20:38:21 +0900
Message-ID: <20080515113821.18971.12147.sendpatchset@rx1.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:23014 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbYEOLiJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 May 2008 07:38:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so350877wfd.4
        for <linux-input@vger.kernel.org>; Thu, 15 May 2008 04:38:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com

This patch adds I2C dependencies to the MigoR touchscreen driver,
and while at it kills off a compile warning.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies to the git input tree b92b4853a19498f17ae802b382e3deee8cb01bc8.

 drivers/input/touchscreen/Kconfig    |    2 +-
 drivers/input/touchscreen/migor_ts.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- 0001/drivers/input/touchscreen/Kconfig
+++ work/drivers/input/touchscreen/Kconfig	2008-05-15 19:42:16.000000000 +0900
@@ -148,7 +148,7 @@ config TOUCHSCREEN_PENMOUNT
 
 config TOUCHSCREEN_MIGOR
 	tristate "Renesas MIGO-R touchscreen"
-	depends on SH_MIGOR
+	depends on SH_MIGOR && I2C
 	help
 	  Say Y here to enable MIGO-R touchscreen support.
 
--- 0001/drivers/input/touchscreen/migor_ts.c
+++ work/drivers/input/touchscreen/migor_ts.c	2008-05-15 19:41:37.000000000 +0900
@@ -144,7 +144,8 @@ static void migor_ts_close(struct input_
 	enable_irq(priv->irq);
 }
 
-static int migor_ts_probe(struct i2c_client *client)
+static int migor_ts_probe(struct i2c_client *client,
+			  const struct i2c_device_id *idp)
 {
 	struct migor_ts_priv *priv;
 	struct input_dev *input;
