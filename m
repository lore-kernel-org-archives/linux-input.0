From: Steven Whitehouse <swhiteho@redhat.com>
Subject: Doc bug in example input driver
Date: Mon, 26 Nov 2007 17:29:59 +0000
Message-ID: <1196098199.1068.863.camel@quoit>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900AbXKZRcz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2007 12:32:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org


The input example driver uses BTN_0 in the later stages of the example, so
this changes the interrupt routine to match.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>

diff --git a/Documentation/input/input-programming.txt b/Documentation/input/input-programming.txt
index 47fc868..81905e8 100644
--- a/Documentation/input/input-programming.txt
+++ b/Documentation/input/input-programming.txt
@@ -22,7 +22,7 @@ static struct input_dev *button_dev;
 
 static void button_interrupt(int irq, void *dummy, struct pt_regs *fp)
 {
-	input_report_key(button_dev, BTN_1, inb(BUTTON_PORT) & 1);
+	input_report_key(button_dev, BTN_0, inb(BUTTON_PORT) & 1);
 	input_sync(button_dev);
 }
 


