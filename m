From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/6] Input: uinput - fold header into the driver proper
Date: Wed,  6 Sep 2017 17:21:12 -0700
Message-ID: <20170907002112.14097-6-dmitry.torokhov@gmail.com>
References: <20170907002112.14097-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907002112.14097-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>, Elias Vanderstuyft <elias.vds@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There is nothing in the uinput kernel header that is of use to anyone in
the kernel besides the uinput driver itself, so let's fold it into the
driver code (leaving uapi part intact).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/uinput.c | 40 +++++++++++++++++++++-
 include/linux/uinput.h      | 81 ---------------------------------------------
 2 files changed, 39 insertions(+), 82 deletions(-)
 delete mode 100644 include/linux/uinput.h

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 06f3ac67dde1..7b41aad7ec27 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -31,6 +31,7 @@
  *	0.1	20/06/2002
  *		- first public version
  */
+#include <uapi/linux/uinput.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -38,10 +39,47 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
-#include <linux/uinput.h>
 #include <linux/input/mt.h>
 #include "../input-compat.h"
 
+#define UINPUT_NAME		"uinput"
+#define UINPUT_BUFFER_SIZE	16
+#define UINPUT_NUM_REQUESTS	16
+
+enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED };
+
+struct uinput_request {
+	unsigned int		id;
+	unsigned int		code;	/* UI_FF_UPLOAD, UI_FF_ERASE */
+
+	int			retval;
+	struct completion	done;
+
+	union {
+		unsigned int	effect_id;
+		struct {
+			struct ff_effect *effect;
+			struct ff_effect *old;
+		} upload;
+	} u;
+};
+
+struct uinput_device {
+	struct input_dev	*dev;
+	struct mutex		mutex;
+	enum uinput_state	state;
+	wait_queue_head_t	waitq;
+	unsigned char		ready;
+	unsigned char		head;
+	unsigned char		tail;
+	struct input_event	buff[UINPUT_BUFFER_SIZE];
+	unsigned int		ff_effects_max;
+
+	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];
+	wait_queue_head_t	requests_waitq;
+	spinlock_t		requests_lock;
+};
+
 static int uinput_dev_event(struct input_dev *dev,
 			    unsigned int type, unsigned int code, int value)
 {
diff --git a/include/linux/uinput.h b/include/linux/uinput.h
deleted file mode 100644
index 75de43da2301..000000000000
--- a/include/linux/uinput.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- *  User level driver support for input subsystem
- *
- * Heavily based on evdev.c by Vojtech Pavlik
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Author: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
- *
- * Changes/Revisions:
- *	0.5	08/13/2015 (David Herrmann <dh.herrmann@gmail.com> &
- *			    Benjamin Tissoires <benjamin.tissoires@redhat.com>)
- *		- add UI_DEV_SETUP ioctl
- *		- add UI_ABS_SETUP ioctl
- *		- add UI_GET_VERSION ioctl
- *	0.4	01/09/2014 (Benjamin Tissoires <benjamin.tissoires@redhat.com>)
- *		- add UI_GET_SYSNAME ioctl
- *	0.3	24/05/2006 (Anssi Hannula <anssi.hannulagmail.com>)
- *		- update ff support for the changes in kernel interface
- *		- add UINPUT_VERSION
- *	0.2	16/10/2004 (Micah Dowty <micah@navi.cx>)
- *		- added force feedback support
- *             - added UI_SET_PHYS
- *	0.1	20/06/2002
- *		- first public version
- */
-#ifndef __UINPUT_H_
-#define __UINPUT_H_
-
-#include <uapi/linux/uinput.h>
-
-#define UINPUT_NAME		"uinput"
-#define UINPUT_BUFFER_SIZE	16
-#define UINPUT_NUM_REQUESTS	16
-
-enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED };
-
-struct uinput_request {
-	unsigned int		id;
-	unsigned int		code;	/* UI_FF_UPLOAD, UI_FF_ERASE */
-
-	int			retval;
-	struct completion	done;
-
-	union {
-		unsigned int	effect_id;
-		struct {
-			struct ff_effect *effect;
-			struct ff_effect *old;
-		} upload;
-	} u;
-};
-
-struct uinput_device {
-	struct input_dev	*dev;
-	struct mutex		mutex;
-	enum uinput_state	state;
-	wait_queue_head_t	waitq;
-	unsigned char		ready;
-	unsigned char		head;
-	unsigned char		tail;
-	struct input_event	buff[UINPUT_BUFFER_SIZE];
-	unsigned int		ff_effects_max;
-
-	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];
-	wait_queue_head_t	requests_waitq;
-	spinlock_t		requests_lock;
-};
-#endif	/* __UINPUT_H_ */
-- 
2.14.1.581.gf28d330327-goog
