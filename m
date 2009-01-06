From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] input: input: stop autorepeat timer on key release
Date: Tue, 06 Jan 2009 12:26:24 +0100
Message-ID: <1231241184.3684.1.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:41846 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbZAFNAR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2009 08:00:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-input <linux-input@vger.kernel.org>

Whenever you press and then release a key, the CPU wakes up
three times:
 * press
 * release
 * autorepeat timer exactly 250ms after press

The autorepeat timer has nothing to do, obviously, since you already
have released the key, so stop it on key release.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Arjan van de Ven <arjan@infradead.org>
---
 drivers/input/input.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- wireless-testing.orig/drivers/input/input.c	2009-01-06 12:15:56.000000000 +0100
+++ wireless-testing/drivers/input/input.c	2009-01-06 12:17:13.000000000 +0100
@@ -132,6 +132,11 @@ static void input_start_autorepeat(struc
 	}
 }
 
+static void input_stop_autorepeat(struct input_dev *dev)
+{
+	del_timer(&dev->timer);
+}
+
 #define INPUT_IGNORE_EVENT	0
 #define INPUT_PASS_TO_HANDLERS	1
 #define INPUT_PASS_TO_DEVICE	2
@@ -167,6 +172,8 @@ static void input_handle_event(struct in
 				__change_bit(code, dev->key);
 				if (value)
 					input_start_autorepeat(dev, code);
+				else
+					input_stop_autorepeat(dev);
 			}
 
 			disposition = INPUT_PASS_TO_HANDLERS;


