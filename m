From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH] Input: fix cobalt_btns loadable keymaps support
Date: Mon, 11 Feb 2008 21:54:04 +0900
Message-ID: <20080211215404.1c924c12.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mfo31.po.2iij.net ([210.128.50.52]:19462 "EHLO
	mfo31.po.2iij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbYBKM7P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2008 07:59:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: yoichi_yuasa@tripeaks.co.jp, linux-input@vger.kernel.org

Fix cobalt_btns loadable keymaps support.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/input/misc/cobalt_btns.c linux/drivers/input/misc/cobalt_btns.c
--- linux-orig/drivers/input/misc/cobalt_btns.c	2008-02-10 20:16:54.621304697 +0900
+++ linux/drivers/input/misc/cobalt_btns.c	2008-02-10 23:02:30.875539556 +0900
@@ -1,7 +1,7 @@
 /*
  *  Cobalt button interface driver.
  *
- *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2007-2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -15,7 +15,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 #include <linux/init.h>
 #include <linux/input-polldev.h>
@@ -55,7 +55,7 @@ static void handle_buttons(struct input_
 	status = ~readl(bdev->reg) >> 24;
 
 	for (i = 0; i < ARRAY_SIZE(bdev->keymap); i++) {
-		if (status & (1UL << i)) {
+		if (status & (1U << i)) {
 			if (++bdev->count[i] == BUTTONS_COUNT_THRESHOLD) {
 				input_event(input, EV_MSC, MSC_SCAN, i);
 				input_report_key(input, bdev->keymap[i], 1);
@@ -97,16 +97,16 @@ static int __devinit cobalt_buttons_prob
 	input->name = "Cobalt buttons";
 	input->phys = "cobalt/input0";
 	input->id.bustype = BUS_HOST;
-	input->cdev.dev = &pdev->dev;
+	input->dev.parent = &pdev->dev;
 
-	input->keycode = pdev->keymap;
-	input->keycodemax = ARRAY_SIZE(pdev->keymap);
+	input->keycode = bdev->keymap;
+	input->keycodemax = ARRAY_SIZE(bdev->keymap);
 	input->keycodesize = sizeof(unsigned short);
 
 	input_set_capability(input, EV_MSC, MSC_SCAN);
 	__set_bit(EV_KEY, input->evbit);
-	for (i = 0; i < ARRAY_SIZE(buttons_map); i++)
-		__set_bit(input->keycode[i], input->keybit);
+	for (i = 0; i < ARRAY_SIZE(cobalt_map); i++)
+		__set_bit(bdev->keymap[i], input->keybit);
 	__clear_bit(KEY_RESERVED, input->keybit);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

