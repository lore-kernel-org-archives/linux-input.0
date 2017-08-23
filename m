From: Liang Yan <lyan@suse.com>
Subject: [PATCH] input/xen-kbdfront: Enable auto repeat for xen keyboard frontend driver
Date: Wed, 23 Aug 2017 14:10:26 -0400
Message-ID: <20170823181026.8084-1-lyan@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Long pressed key could not show right in XEN vncviewer after tigervnc
client changed the way how to send repeat keys, from "Down Up Down Up
..." to "Down Down ... Up". By enable EV_REP bit here, XEN keyboard
device will trigger default auto repeat process from input subsystem,
and make auto repeat keys work correctly.

Signed-off-by: Liang Yan <lyan@suse.com>
---
 drivers/input/misc/xen-kbdfront.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index fa130e7b734c..0dce9830e2f4 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -248,6 +248,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
 	kbd->id.product = 0xffff;
 
 	__set_bit(EV_KEY, kbd->evbit);
+	__set_bit(EV_REP, kbd->evbit);
 	for (i = KEY_ESC; i < KEY_UNKNOWN; i++)
 		__set_bit(i, kbd->keybit);
 	for (i = KEY_OK; i < KEY_MAX; i++)
-- 
2.14.1
