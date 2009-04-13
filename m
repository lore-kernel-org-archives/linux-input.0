From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH 3/3] input: add Bin Yang as co-author of da9034 touchscreen
	driver
Date: Mon, 13 Apr 2009 12:09:43 +0800
Message-ID: <f17812d70904122109h65036a47g6fd51de925a3f16d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:34532 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbZDMEJp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2009 00:09:45 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2200974qwh.37
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2009 21:09:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Bin Yang <bin.yang@marvell.com>

>From c44f02c6d676a0fbde5b889a8214f4f7ed8dd04b Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Mon, 13 Apr 2009 11:56:29 +0800
Subject: [PATCH 3/3] input: add Bin Yang as co-author of da9034
touchscreen driver

Bin did a lot of work on this driver, without his help, this driver
will not be possible.

Signed-off-by: Bin Yang <bin.yang@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/input/touchscreen/da9034-ts.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/da9034-ts.c
b/drivers/input/touchscreen/da9034-ts.c
index 37f5df2..7c83058 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2006-2008 Marvell International Ltd.
  *	Fengwei Yin <fengwei.yin@marvell.com>
+ *	Bin Yang  <bin.yang@marvell.com>
  *	Eric Miao <eric.miao@marvell.com>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -393,6 +394,6 @@ static void __exit da9034_touch_exit(void)
 module_exit(da9034_touch_exit);

 MODULE_DESCRIPTION("Touchscreen driver for Dialog Semiconductor DA9034");
-MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
+MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>, Bin Yang
<bin.yang@marvell.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:da9034-touch");
-- 
1.6.0.4
