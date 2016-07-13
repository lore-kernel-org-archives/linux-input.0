From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [linux-next] input: Fix a double word "is is" in include/linux/input.h
Date: Wed, 13 Jul 2016 12:59:45 +0900
Message-ID: <20160713035945.4761-1-standby24x7@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32915 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbcGMEAE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 00:00:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, corbet@lwn.net, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>

This patch fix a double word "is is" found in in
Documentation/DocBook/device-drivers.xml.
It is because the file was created from comments in sources,
so I have to fix the double words in include/linux/input.h

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 include/linux/input.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 1e967694e9a5..a65e3b24fb18 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -95,7 +95,7 @@ struct input_value {
  * @grab: input handle that currently has the device grabbed (via
  *	EVIOCGRAB ioctl). When a handle grabs a device it becomes sole
  *	recipient for all input events coming from the device
- * @event_lock: this spinlock is is taken when input core receives
+ * @event_lock: this spinlock is taken when input core receives
  *	and processes a new event for the device (in input_event()).
  *	Code that accesses and/or modifies parameters of a device
  *	(such as keymap or absmin, absmax, absfuzz, etc.) after device
-- 
2.9.1.200.gb1ec08f

