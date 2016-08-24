From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] input: pegasus_notetaker - directly include workqueue header
Date: Wed, 24 Aug 2016 11:52:05 +0200
Message-ID: <1472032325-11432-1-git-send-email-martink@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

According to the kernel's guidelines, let's directly include the
workqueue functions we use.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
I don't know if it's worth it, but I should have included this according to
the guidelines :)


 drivers/input/tablet/pegasus_notetaker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 949dacc..47de5a8 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -40,6 +40,7 @@
 #include <linux/input.h>
 #include <linux/usb/input.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 /* USB HID defines */
 #define USB_REQ_GET_REPORT		0x01
-- 
2.1.4
