From: Ricky Liang <jcliang@chromium.org>
Subject: [PATCH v2] Input: uinput - handle compat ioctl for UI_SET_PHYS
Date: Sat, 21 May 2016 01:50:46 +0800
Message-ID: <1463766648-2392-1-git-send-email-jcliang@chromium.org>
References: <1463499587-21346-1-git-send-email-jcliang@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35224 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbcETRvF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 May 2016 13:51:05 -0400
Received: by mail-pf0-f180.google.com with SMTP id b66so22509718pfb.2
        for <linux-input@vger.kernel.org>; Fri, 20 May 2016 10:51:05 -0700 (PDT)
In-Reply-To: <1463499587-21346-1-git-send-email-jcliang@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Ricky Liang <jcliang@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Anshul Garg <aksgarg1989@gmail.com>, Elias Vanderstuyft <elias.vds@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK
	, TOUCHSCREEN..." <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

When running a 32-bit userspace on a 64-bit kernel, the UI_SET_PHYS
ioctl needs to be treated with special care, as it has the pointer
size encoded in the command.

Signed-off-by: Ricky Liang <jcliang@chromium.org>
---
 drivers/input/misc/uinput.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index abe1a92..65ebbd1 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -981,9 +981,15 @@ static long uinput_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 #ifdef CONFIG_COMPAT
+
+#define UI_SET_PHYS_COMPAT	_IOW(UINPUT_IOCTL_BASE, 108, compat_uptr_t)
+
 static long uinput_compat_ioctl(struct file *file,
 				unsigned int cmd, unsigned long arg)
 {
+	if (cmd == UI_SET_PHYS_COMPAT)
+		cmd = UI_SET_PHYS;
+
 	return uinput_ioctl_handler(file, cmd, arg, compat_ptr(arg));
 }
 #endif
-- 
2.1.2

