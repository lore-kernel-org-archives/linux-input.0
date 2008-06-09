From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make q40kbd_lock static
Date: Tue, 10 Jun 2008 01:23:06 +0300
Message-ID: <20080609222306.GL1987@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:40985 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760625AbYFIWYA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Jun 2008 18:24:00 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This patch makes the needlessly global q40kbd_lock static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
1bf64b91d180438d8810ea49a02687657d3a488e diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index d962a8d..52a531b 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -49,7 +49,7 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Q40 PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
 
-DEFINE_SPINLOCK(q40kbd_lock);
+static DEFINE_SPINLOCK(q40kbd_lock);
 static struct serio *q40kbd_port;
 static struct platform_device *q40kbd_device;
 

