From: akpm@linux-foundation.org
Subject: [patch 04/19] input/mouse/alps.c: handle touchpoints buttons correctly
Date: Wed, 11 Feb 2009 13:23:43 -0800
Message-ID: <200902112123.n1BLNhex026523@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38946 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757266AbZBKVYV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 16:24:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, uli-kernel@spamt.net, uli@spamt.net

From: Ulrich Dangel <uli-kernel@spamt.net>

When pressing any button belonging to the touchpoint, the generated click
events dont belong to the touchpoint but to the touchpad.

This patch fixes this behaviour, the events will be sent via the correct
device, so scrolling with touchpoint is possible.

The patch compiles cleanly and has been tested successfully on my machine.

Signed-off-by: Ulrich Dangel <uli@spamt.net>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/mouse/alps.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff -puN drivers/input/mouse/alps.c~input-mouse-alpsc-handle-touchpoints-buttons-correctly drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c~input-mouse-alpsc-handle-touchpoints-buttons-correctly
+++ a/drivers/input/mouse/alps.c
@@ -131,18 +131,23 @@ static void alps_process_packet(struct p
 	ges = packet[2] & 1;
 	fin = packet[2] & 2;
 
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
-	input_report_key(dev, BTN_MIDDLE, middle);
-
 	if ((priv->i->flags & ALPS_DUALPOINT) && z == 127) {
 		input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
 		input_report_rel(dev2, REL_Y, -(y > 255 ? (y - 512) : y));
+
+		input_report_key(dev2, BTN_LEFT, left);
+		input_report_key(dev2, BTN_RIGHT, right);
+		input_report_key(dev2, BTN_MIDDLE, middle);
+
 		input_sync(dev);
 		input_sync(dev2);
 		return;
 	}
 
+	input_report_key(dev, BTN_LEFT, left);
+	input_report_key(dev, BTN_RIGHT, right);
+	input_report_key(dev, BTN_MIDDLE, middle);
+
 	/* Convert hardware tap to a reasonable Z value */
 	if (ges && !fin) z = 40;
 
_
