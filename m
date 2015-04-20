From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/7] input: keyboard: lm8333: fix broken email address
Date: Mon, 20 Apr 2015 15:51:41 +0200
Message-ID: <1429537917-7433-4-git-send-email-wsa@the-dreams.de>
References: <1429537917-7433-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429537917-7433-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

My Pengutronix address is not valid anymore, redirect people to the Pengutronix
kernel team.

Reported-by: Harald Geyer <harald@ccbib.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Robert Schwebel <r.schwebel@pengutronix.de>
---
These patches shall go via the individual subsystem trees.

 drivers/input/keyboard/lm8333.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 9081cbef11ea12..0ad422b8a2607c 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -1,6 +1,6 @@
 /*
  * LM8333 keypad driver
- * Copyright (C) 2012 Wolfram Sang, Pengutronix <w.sang@pengutronix.de>
+ * Copyright (C) 2012 Wolfram Sang, Pengutronix <kernel@pengutronix.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -231,6 +231,6 @@ static struct i2c_driver lm8333_driver = {
 };
 module_i2c_driver(lm8333_driver);
 
-MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
 MODULE_DESCRIPTION("LM8333 keyboard driver");
 MODULE_LICENSE("GPL v2");
-- 
2.1.4
