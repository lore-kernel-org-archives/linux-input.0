From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 08/20] Input: iforce - split into core and transport modules
Date: Mon, 17 Sep 2018 17:47:20 -0700
Message-ID: <20180918004732.9875-8-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Now that we have moved enough transport details into separate source files
we can change them into transport modules so that they are only loaded when
needed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/Kconfig         |  8 ++---
 drivers/input/joystick/iforce/Makefile        |  7 ++--
 drivers/input/joystick/iforce/iforce-main.c   | 35 ++-----------------
 .../input/joystick/iforce/iforce-packets.c    |  2 ++
 drivers/input/joystick/iforce/iforce-serio.c  |  7 ++++
 drivers/input/joystick/iforce/iforce-usb.c    |  7 ++++
 drivers/input/joystick/iforce/iforce.h        |  2 --
 7 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/drivers/input/joystick/iforce/Kconfig b/drivers/input/joystick/iforce/Kconfig
index ab4dbcbcbf50..55f6ae1da6b0 100644
--- a/drivers/input/joystick/iforce/Kconfig
+++ b/drivers/input/joystick/iforce/Kconfig
@@ -13,15 +13,15 @@ config JOYSTICK_IFORCE
 	  module will be called iforce.
 
 config JOYSTICK_IFORCE_USB
-	bool "I-Force USB joysticks and wheels"
-	depends on JOYSTICK_IFORCE && (JOYSTICK_IFORCE=m || USB=y) && USB
+	tristate "I-Force USB joysticks and wheels"
+	depends on JOYSTICK_IFORCE && USB
 	help
 	  Say Y here if you have an I-Force joystick or steering wheel
 	  connected to your USB port.
 
 config JOYSTICK_IFORCE_232
-	bool "I-Force Serial joysticks and wheels"
-	depends on JOYSTICK_IFORCE && (JOYSTICK_IFORCE=m || SERIO=y) && SERIO
+	tristate "I-Force Serial joysticks and wheels"
+	depends on JOYSTICK_IFORCE && SERIO
 	help
 	  Say Y here if you have an I-Force joystick or steering wheel
 	  connected to your serial (COM) port.
diff --git a/drivers/input/joystick/iforce/Makefile b/drivers/input/joystick/iforce/Makefile
index bc5bda22f15e..414075019a4f 100644
--- a/drivers/input/joystick/iforce/Makefile
+++ b/drivers/input/joystick/iforce/Makefile
@@ -4,8 +4,7 @@
 # By Johann Deneux <johann.deneux@gmail.com>
 #
 
-obj-$(CONFIG_JOYSTICK_IFORCE)	+= iforce.o
-
+obj-$(CONFIG_JOYSTICK_IFORCE)		+= iforce.o
 iforce-y := iforce-ff.o iforce-main.o iforce-packets.o
-iforce-$(CONFIG_JOYSTICK_IFORCE_232)	+= iforce-serio.o
-iforce-$(CONFIG_JOYSTICK_IFORCE_USB)	+= iforce-usb.o
+obj-$(CONFIG_JOYSTICK_IFORCE_232)	+= iforce-serio.o
+obj-$(CONFIG_JOYSTICK_IFORCE_USB)	+= iforce-usb.o
diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 894769d03df3..3a0698327c42 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -24,7 +24,7 @@
 #include "iforce.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>");
-MODULE_DESCRIPTION("USB/RS232 I-Force joysticks and wheels driver");
+MODULE_DESCRIPTION("Core I-Force joysticks and wheels driver");
 MODULE_LICENSE("GPL");
 
 static signed short btn_joystick[] =
@@ -411,35 +411,4 @@ int iforce_init_device(struct device *parent, u16 bustype,
  fail:	input_free_device(input_dev);
 	return error;
 }
-
-static int __init iforce_init(void)
-{
-	int err = 0;
-
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	err = usb_register(&iforce_usb_driver);
-	if (err)
-		return err;
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	err = serio_register_driver(&iforce_serio_drv);
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	if (err)
-		usb_deregister(&iforce_usb_driver);
-#endif
-#endif
-	return err;
-}
-
-static void __exit iforce_exit(void)
-{
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	usb_deregister(&iforce_usb_driver);
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	serio_unregister_driver(&iforce_serio_drv);
-#endif
-}
-
-module_init(iforce_init);
-module_exit(iforce_exit);
+EXPORT_SYMBOL(iforce_init_device);
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 8a9a152bb595..70db273e5045 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -96,6 +96,7 @@ int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data)
 
 	return 0;
 }
+EXPORT_SYMBOL(iforce_send_packet);
 
 /* Start or stop an effect */
 int iforce_control_playback(struct iforce* iforce, u16 id, unsigned int value)
@@ -203,3 +204,4 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			break;
 	}
 }
+EXPORT_SYMBOL(iforce_process_packet);
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 6ff1bbeeb494..6c6411fbdc32 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <linux/serio.h>
 #include "iforce.h"
 
 struct iforce_serio {
@@ -250,3 +251,9 @@ struct serio_driver iforce_serio_drv = {
 	.connect	= iforce_serio_connect,
 	.disconnect	= iforce_serio_disconnect,
 };
+
+module_serio_driver(iforce_serio_drv);
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>");
+MODULE_DESCRIPTION("RS232 I-Force joysticks and wheels driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index d4e7a24922cd..9d635f01cf19 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
+#include <linux/usb.h>
 #include "iforce.h"
 
 struct iforce_usb {
@@ -316,3 +317,9 @@ struct usb_driver iforce_usb_driver = {
 	.disconnect =	iforce_usb_disconnect,
 	.id_table =	iforce_usb_ids,
 };
+
+module_usb_driver(iforce_usb_driver);
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>");
+MODULE_DESCRIPTION("USB I-Force joysticks and wheels driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index d9712c48ba74..3e3df83b9d77 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -26,8 +26,6 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
-#include <linux/usb.h>
-#include <linux/serio.h>
 #include <linux/circ_buf.h>
 #include <linux/mutex.h>
 
-- 
2.19.0.397.gdd90340f6a-goog
