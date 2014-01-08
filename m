From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4 trivial: rmi_f01.c tidy-up
Date: Tue, 7 Jan 2014 16:07:42 -0800
Message-ID: <1389139662-6590-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:25987 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014AbaAHAHq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jan 2014 19:07:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This has two trivial changes:

1) use CONFIG_PM_SLEEP instead of CONFIG_PM for consistency.

2) Update the copyright date.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
 drivers/input/rmi4/rmi_f01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 628b082..d547633 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011-2012 Synaptics Incorporated
+ * Copyright (c) 2011-2014 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -138,7 +138,7 @@ struct f01_data {
 	int irq_count;
 	int num_of_irq_regs;
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	bool suspended;
 	bool old_nosleep;
 #endif
