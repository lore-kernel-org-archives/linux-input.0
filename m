From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] Input: uinput - add compat ioctl number translation for UI_*_FF_UPLOAD
Date: Tue, 21 May 2019 18:39:22 -0700
Message-ID: <20190522013922.25538-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In the case of compat syscall ioctl numbers for UI_BEGIN_FF_UPLOAD and
UI_END_FF_UPLOAD need to be adjusted before being passed on
uinput_ioctl_handler() since code built with -m32 will be passing
slightly different values. Extend the code already covering
UI_SET_PHYS to cover UI_BEGIN_FF_UPLOAD and UI_END_FF_UPLOAD as well.

Reported-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/input/misc/uinput.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 1a6762fc38f9..1116d4cd5695 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -1051,13 +1051,24 @@ static long uinput_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 #ifdef CONFIG_COMPAT
 
-#define UI_SET_PHYS_COMPAT	_IOW(UINPUT_IOCTL_BASE, 108, compat_uptr_t)
+#define UI_SET_PHYS_COMPAT		_IOW(UINPUT_IOCTL_BASE, 108, compat_uptr_t)
+#define UI_BEGIN_FF_UPLOAD_COMPAT	_IOWR(UINPUT_IOCTL_BASE, 200, struct uinput_ff_upload_compat)
+#define UI_END_FF_UPLOAD_COMPAT		_IOW(UINPUT_IOCTL_BASE, 201, struct uinput_ff_upload_compat)
 
 static long uinput_compat_ioctl(struct file *file,
 				unsigned int cmd, unsigned long arg)
 {
-	if (cmd == UI_SET_PHYS_COMPAT)
+	switch (cmd) {
+	case UI_SET_PHYS_COMPAT:
 		cmd = UI_SET_PHYS;
+		break;
+	case UI_BEGIN_FF_UPLOAD_COMPAT:
+		cmd = UI_BEGIN_FF_UPLOAD;
+		break;
+	case UI_END_FF_UPLOAD_COMPAT:
+		cmd = UI_END_FF_UPLOAD;
+		break;
+	}
 
 	return uinput_ioctl_handler(file, cmd, arg, compat_ptr(arg));
 }
-- 
2.21.0
