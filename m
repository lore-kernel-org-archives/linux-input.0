From: "founder.fang" <founder.fang@gmail.com>
Subject: [PATCH] HID: hidraw: fix nonblock read return EAGAIN after device removed
Date: Wed, 21 Nov 2012 15:20:31 +0800
Message-ID: <CAHLfQU=Hrufny=652k2mM7OcjxnRMH-kgj510FZrrKtiKNxdgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55482 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab2KUHUc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 02:20:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

when nonblock read the condition check (file->f_flags & O_NONBLOCK)
always be true,
signal_pending and device exist checking never get a chance to run, so
the user mode code always
get EAGAIN even if device removed. move nonblock mode checking to the
last can fix this problem.

Signed-off-by: Founder Fang <founder.fang@gmail.com>

--- hid-git/drivers/hid/hidraw.c.orig	2012-11-21 14:37:04.977106383 +0800
+++ hid-git/drivers/hid/hidraw.c	2012-11-21 14:40:35.882152200 +0800
@@ -57,10 +57,6 @@ static ssize_t hidraw_read(struct file *
 			set_current_state(TASK_INTERRUPTIBLE);

 			while (list->head == list->tail) {
-				if (file->f_flags & O_NONBLOCK) {
-					ret = -EAGAIN;
-					break;
-				}
 				if (signal_pending(current)) {
 					ret = -ERESTARTSYS;
 					break;
@@ -69,6 +65,10 @@ static ssize_t hidraw_read(struct file *
 					ret = -EIO;
 					break;
 				}
+				if (file->f_flags & O_NONBLOCK) {
+					ret = -EAGAIN;
+					break;
+				}

 				/* allow O_NONBLOCK to work well from other threads */
 				mutex_unlock(&list->read_mutex);
