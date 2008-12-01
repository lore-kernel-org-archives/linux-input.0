From: akpm@linux-foundation.org
Subject: [patch 3/8] input: ads7846.c sparse lock annotation
Date: Mon, 01 Dec 2008 14:20:14 -0800
Message-ID: <200812012220.mB1MKERa012626@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56036 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752756AbYLAWVI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Dec 2008 17:21:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, harvey.harrison@gmail.com

From: Harvey Harrison <harvey.harrison@gmail.com>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/touchscreen/ads7846.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/input/touchscreen/ads7846.c~input-ads7846c-sparse-lock-annotation drivers/input/touchscreen/ads7846.c
--- a/drivers/input/touchscreen/ads7846.c~input-ads7846c-sparse-lock-annotation
+++ a/drivers/input/touchscreen/ads7846.c
@@ -761,6 +761,8 @@ static irqreturn_t ads7846_irq(int irq, 
 
 /* Must be called with ts->lock held */
 static void ads7846_disable(struct ads7846 *ts)
+__acquires(&ts->lock)
+__releases(&ts->lock)
 {
 	if (ts->disabled)
 		return;
_
