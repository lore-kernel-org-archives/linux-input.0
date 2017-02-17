From: Joe Perches <joe@perches.com>
Subject: [PATCH 19/35] drivers/input: Convert remaining uses of pr_warning to pr_warn
Date: Thu, 16 Feb 2017 23:11:32 -0800
Message-ID: <281e70b41ec9e57a630d81e1f1985deda76f04ab.1487314667.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

To enable eventual removal of pr_warning

This makes pr_warn use consistent for drivers/input

Prior to this patch, there were 8 uses of pr_warning and
17 uses of pr_warn in drivers/input

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/input/gameport/gameport.c | 4 ++--
 drivers/input/joystick/gamecon.c  | 3 ++-
 drivers/input/misc/apanel.c       | 3 ++-
 drivers/input/misc/xen-kbdfront.c | 8 ++++----
 drivers/input/serio/serio.c       | 8 ++++----
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 4a2a9e370be7..092cc4188b57 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -385,8 +385,8 @@ static int gameport_queue_event(void *object, struct module *owner,
 	}
 
 	if (!try_module_get(owner)) {
-		pr_warning("Can't get module reference, dropping event %d\n",
-			   event_type);
+		pr_warn("Can't get module reference, dropping event %d\n",
+			event_type);
 		kfree(event);
 		retval = -EINVAL;
 		goto out;
diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index eae14d512353..c43f087a496d 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -870,7 +870,8 @@ static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
 
 		err = gc_n64_init_ff(input_dev, idx);
 		if (err) {
-			pr_warning("Failed to initiate rumble for N64 device %d\n", idx);
+			pr_warn("Failed to initiate rumble for N64 device %d\n",
+				idx);
 			goto err_free_dev;
 		}
 
diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index 53630afab606..aad1df04c854 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -314,7 +314,8 @@ static int __init apanel_init(void)
 		if (devno >= APANEL_DEV_MAX)
 			pr_notice(APANEL ": unknown device %u found\n", devno);
 		else if (device_chip[devno] != CHIP_NONE)
-			pr_warning(APANEL ": duplicate entry for devno %u\n", devno);
+			pr_warn(APANEL ": duplicate entry for devno %u\n",
+				devno);
 
 		else if (method != 1 && method != 2 && method != 4) {
 			pr_notice(APANEL ": unknown method %u for devno %u\n",
diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 3900875dec10..1fd911d4fadf 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -84,8 +84,8 @@ static irqreturn_t input_handler(int rq, void *dev_id)
 				input_report_key(dev, event->key.keycode,
 						 event->key.pressed);
 			else
-				pr_warning("unhandled keycode 0x%x\n",
-					   event->key.keycode);
+				pr_warn("unhandled keycode 0x%x\n",
+					event->key.keycode);
 			break;
 		case XENKBD_TYPE_POS:
 			input_report_abs(dev, ABS_X, event->pos.abs_x);
@@ -133,7 +133,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		ret = xenbus_write(XBT_NIL, dev->nodename,
 				   "request-abs-pointer", "1");
 		if (ret) {
-			pr_warning("xenkbd: can't request abs-pointer");
+			pr_warn("xenkbd: can't request abs-pointer\n");
 			abs = 0;
 		}
 	}
@@ -327,7 +327,7 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
 			ret = xenbus_write(XBT_NIL, info->xbdev->nodename,
 					   "request-abs-pointer", "1");
 			if (ret)
-				pr_warning("xenkbd: can't request abs-pointer");
+				pr_warn("xenkbd: can't request abs-pointer\n");
 		}
 
 		xenbus_switch_state(dev, XenbusStateConnected);
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 1ca7f551e2da..048ae748c4d1 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -285,8 +285,8 @@ static int serio_queue_event(void *object, struct module *owner,
 	}
 
 	if (!try_module_get(owner)) {
-		pr_warning("Can't get module reference, dropping event %d\n",
-			   event_type);
+		pr_warn("Can't get module reference, dropping event %d\n",
+			event_type);
 		kfree(event);
 		retval = -EINVAL;
 		goto out;
@@ -823,8 +823,8 @@ static void serio_attach_driver(struct serio_driver *drv)
 
 	error = driver_attach(&drv->driver);
 	if (error)
-		pr_warning("driver_attach() failed for %s with error %d\n",
-			   drv->driver.name, error);
+		pr_warn("driver_attach() failed for %s with error %d\n",
+			drv->driver.name, error);
 }
 
 int __serio_register_driver(struct serio_driver *drv, struct module *owner, const char *mod_name)
-- 
2.10.0.rc2.1.g053435c
