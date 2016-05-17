From: Ricky Liang <jcliang@chromium.org>
Subject: [PATCH] Input: uinput - handle compat ioctl for UI_SET_PHYS
Date: Tue, 17 May 2016 23:39:45 +0800
Message-ID: <1463499587-21346-1-git-send-email-jcliang@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Ricky Liang <jcliang@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Elias Vanderstuyft <elias.vds@gmail.com>, Anshul Garg <aksgarg1989@gmail.com>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK
	, TOUCHSCREEN..." <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

When running a 32-bit userspace on a 64-bit kernel, the UI_SET_PHYS
ioctl needs to be treated with special care, as it has the pointer
size encoded in the command.

Signed-off-by: Ricky Liang <jcliang@chromium.org>
---
 drivers/input/misc/uinput.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index abe1a92..b4d1b1d 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -984,6 +984,15 @@ static long uinput_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static long uinput_compat_ioctl(struct file *file,
 				unsigned int cmd, unsigned long arg)
 {
+	switch (_IOC_NR(cmd)) {
+		case _IOC_NR(UI_SET_PHYS):
+			if (_IOC_SIZE(cmd) == sizeof(compat_uptr_t)) {
+				cmd &= ~IOCSIZE_MASK;
+				cmd |= sizeof(void *) << IOCSIZE_SHIFT;
+			}
+			break;
+	}
+
 	return uinput_ioctl_handler(file, cmd, arg, compat_ptr(arg));
 }
 #endif
-- 
2.1.2
