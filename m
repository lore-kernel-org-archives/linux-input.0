From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: libps2 - additional locking for i8042 ports
Date: Thu, 10 Sep 2009 22:48:06 -0700
Message-ID: <20090911054806.27150.6508.stgit@localhost.localdomain>
References: <20090911054210.27150.93405.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:39320 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZIKFsF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:48:05 -0400
Received: by mail-pz0-f184.google.com with SMTP id 14so662552pzk.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 22:48:09 -0700 (PDT)
In-Reply-To: <20090911054210.27150.93405.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rjw@sisk.pl

The serio ports on i8042 are not completely isolated; while we provide
enough locking to ensure proper serialization when accessing control
and data registers AUX and KBD ports can still have an effect on each
other on PS/2 protocol level. The most prominent effect is that
issuing a command ifor the device connected to one port may cause
abort of the command currently executing by the device connected to
another port.

Since i8042 nor serio subsystem are not aware of the details of the
PS/2 protocol (length of the commands and their replies and so on) we
have to implement The locking should be donr on libps2 level by adding
special handling when we see that we are dealing with serio port on
i8042.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/sentelic.c  |   18 ++++++++++--------
 drivers/input/serio/i8042.c     |   40 +++++++++++++++++++++++++++++++++++++++
 drivers/input/serio/libps2.c    |   28 +++++++++++++++++++++++----
 drivers/leds/leds-clevo-mail.c  |    8 ++++++++
 drivers/platform/x86/acer-wmi.c |    2 ++
 include/linux/i8042.h           |   30 +++++++++++++++++++++++++++++
 include/linux/libps2.h          |    2 ++
 7 files changed, 116 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 84e2fc0..f84cbd9 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -92,7 +92,8 @@ static int fsp_reg_read(struct psmouse *psmouse, int reg_addr, int *reg_val)
 	 */
 	ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE);
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
-	mutex_lock(&ps2dev->cmd_mutex);
+
+	ps2_begin_command(ps2dev);
 
 	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
 		goto out;
@@ -126,7 +127,7 @@ static int fsp_reg_read(struct psmouse *psmouse, int reg_addr, int *reg_val)
 	rc = 0;
 
  out:
-	mutex_unlock(&ps2dev->cmd_mutex);
+	ps2_end_command(ps2dev);
 	ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 	dev_dbg(&ps2dev->serio->dev, "READ REG: 0x%02x is 0x%02x (rc = %d)\n",
@@ -140,7 +141,7 @@ static int fsp_reg_write(struct psmouse *psmouse, int reg_addr, int reg_val)
 	unsigned char v;
 	int rc = -1;
 
-	mutex_lock(&ps2dev->cmd_mutex);
+	ps2_begin_command(ps2dev);
 
 	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
 		goto out;
@@ -179,7 +180,7 @@ static int fsp_reg_write(struct psmouse *psmouse, int reg_addr, int reg_val)
 	rc = 0;
 
  out:
-	mutex_unlock(&ps2dev->cmd_mutex);
+	ps2_end_command(ps2dev);
 	dev_dbg(&ps2dev->serio->dev, "WRITE REG: 0x%02x to 0x%02x (rc = %d)\n",
 		reg_addr, reg_val, rc);
 	return rc;
@@ -214,7 +215,8 @@ static int fsp_page_reg_read(struct psmouse *psmouse, int *reg_val)
 
 	ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE);
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
-	mutex_lock(&ps2dev->cmd_mutex);
+
+	ps2_begin_command(ps2dev);
 
 	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
 		goto out;
@@ -236,7 +238,7 @@ static int fsp_page_reg_read(struct psmouse *psmouse, int *reg_val)
 	rc = 0;
 
  out:
-	mutex_unlock(&ps2dev->cmd_mutex);
+	ps2_end_command(ps2dev);
 	ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 	dev_dbg(&ps2dev->serio->dev, "READ PAGE REG: 0x%02x (rc = %d)\n",
@@ -250,7 +252,7 @@ static int fsp_page_reg_write(struct psmouse *psmouse, int reg_val)
 	unsigned char v;
 	int rc = -1;
 
-	mutex_lock(&ps2dev->cmd_mutex);
+	ps2_begin_command(ps2dev);
 
 	if (ps2_sendbyte(ps2dev, 0xf3, FSP_CMD_TIMEOUT) < 0)
 		goto out;
@@ -275,7 +277,7 @@ static int fsp_page_reg_write(struct psmouse *psmouse, int reg_val)
 	rc = 0;
 
  out:
-	mutex_unlock(&ps2dev->cmd_mutex);
+	ps2_end_command(ps2dev);
 	dev_dbg(&ps2dev->serio->dev, "WRITE PAGE REG: to 0x%02x (rc = %d)\n",
 		reg_val, rc);
 	return rc;
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index eb3ff94..7e74b99 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -87,8 +87,22 @@ static bool i8042_bypass_aux_irq_test;
 
 #include "i8042.h"
 
+/*
+ * i8042_lock protects serialization between i8042_command and
+ * the interrupt handler.
+ */
 static DEFINE_SPINLOCK(i8042_lock);
 
+/*
+ * Writers to AUX and KBD ports as well as users issuing i8042_command
+ * directly should acquire i8042_mutex (by means of calling
+ * i8042_lock_chip() and i8042_unlock_ship() helpers) to ensure that
+ * they do not disturb each other (unfortunately in many i8042
+ * implementations write to one of the ports will immediately abort
+ * command that is being processed by another port).
+ */
+static DEFINE_MUTEX(i8042_mutex);
+
 struct i8042_port {
 	struct serio *serio;
 	int irq;
@@ -113,6 +127,18 @@ static struct platform_device *i8042_platform_device;
 
 static irqreturn_t i8042_interrupt(int irq, void *dev_id);
 
+void i8042_lock_chip(void)
+{
+	mutex_lock(&i8042_mutex);
+}
+EXPORT_SYMBOL(i8042_lock_chip);
+
+void i8042_unlock_chip(void)
+{
+	mutex_unlock(&i8042_mutex);
+}
+EXPORT_SYMBOL(i8042_unlock_chip);
+
 /*
  * The i8042_wait_read() and i8042_wait_write functions wait for the i8042 to
  * be ready for reading values from it / writing values to it.
@@ -1161,6 +1187,20 @@ static void __devexit i8042_unregister_ports(void)
 	}
 }
 
+/*
+ * Checks whether port belongs to i8042 controller.
+ */
+bool i8042_check_port_owner(const struct serio *port)
+{
+	int i;
+
+	for (i = 0; i < I8042_NUM_PORTS; i++)
+		if (i8042_ports[i].serio == port)
+			return true;
+
+	return false;
+}
+
 static void i8042_free_irqs(void)
 {
 	if (i8042_aux_irq_registered)
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 3a95b50..769ba65 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/serio.h>
+#include <linux/i8042.h>
 #include <linux/init.h>
 #include <linux/libps2.h>
 
@@ -54,6 +55,24 @@ int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout)
 }
 EXPORT_SYMBOL(ps2_sendbyte);
 
+void ps2_begin_command(struct ps2dev *ps2dev)
+{
+	mutex_lock(&ps2dev->cmd_mutex);
+
+	if (i8042_check_port_owner(ps2dev->serio))
+		i8042_lock_chip();
+}
+EXPORT_SYMBOL(ps2_begin_command);
+
+void ps2_end_command(struct ps2dev *ps2dev)
+{
+	if (i8042_check_port_owner(ps2dev->serio))
+		i8042_unlock_chip();
+
+	mutex_unlock(&ps2dev->cmd_mutex);
+}
+EXPORT_SYMBOL(ps2_end_command);
+
 /*
  * ps2_drain() waits for device to transmit requested number of bytes
  * and discards them.
@@ -66,7 +85,7 @@ void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout)
 		maxbytes = sizeof(ps2dev->cmdbuf);
 	}
 
-	mutex_lock(&ps2dev->cmd_mutex);
+	ps2_begin_command(ps2dev);
 
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->flags = PS2_FLAG_CMD;
@@ -76,7 +95,8 @@ void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout)
 	wait_event_timeout(ps2dev->wait,
 			   !(ps2dev->flags & PS2_FLAG_CMD),
 			   msecs_to_jiffies(timeout));
-	mutex_unlock(&ps2dev->cmd_mutex);
+
+	ps2_end_command(ps2dev);
 }
 EXPORT_SYMBOL(ps2_drain);
 
@@ -237,9 +257,9 @@ int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
 {
 	int rc;
 
-	mutex_lock(&ps2dev->cmd_mutex);
+	ps2_begin_command(ps2dev);
 	rc = __ps2_command(ps2dev, param, command);
-	mutex_unlock(&ps2dev->cmd_mutex);
+	ps2_end_command(ps2dev);
 
 	return rc;
 }
diff --git a/drivers/leds/leds-clevo-mail.c b/drivers/leds/leds-clevo-mail.c
index 1813c84..f2242db 100644
--- a/drivers/leds/leds-clevo-mail.c
+++ b/drivers/leds/leds-clevo-mail.c
@@ -93,6 +93,8 @@ static struct dmi_system_id __initdata mail_led_whitelist[] = {
 static void clevo_mail_led_set(struct led_classdev *led_cdev,
 				enum led_brightness value)
 {
+	i8042_lock_chip();
+
 	if (value == LED_OFF)
 		i8042_command(NULL, CLEVO_MAIL_LED_OFF);
 	else if (value <= LED_HALF)
@@ -100,6 +102,8 @@ static void clevo_mail_led_set(struct led_classdev *led_cdev,
 	else
 		i8042_command(NULL, CLEVO_MAIL_LED_BLINK_1HZ);
 
+	i8042_unlock_chip();
+
 }
 
 static int clevo_mail_led_blink(struct led_classdev *led_cdev,
@@ -108,6 +112,8 @@ static int clevo_mail_led_blink(struct led_classdev *led_cdev,
 {
 	int status = -EINVAL;
 
+	i8042_lock_chip();
+
 	if (*delay_on == 0 /* ms */ && *delay_off == 0 /* ms */) {
 		/* Special case: the leds subsystem requested us to
 		 * chose one user friendly blinking of the LED, and
@@ -135,6 +141,8 @@ static int clevo_mail_led_blink(struct led_classdev *led_cdev,
 		       *delay_on, *delay_off);
 	}
 
+	i8042_unlock_chip();
+
 	return status;
 }
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index fb45f5e..454970d 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -746,7 +746,9 @@ static acpi_status WMID_set_u32(u32 value, u32 cap, struct wmi_interface *iface)
 			return AE_BAD_PARAMETER;
 		if (quirks->mailled == 1) {
 			param = value ? 0x92 : 0x93;
+			i8042_lock_chip();
 			i8042_command(&param, 0x1059);
+			i8042_unlock_chip();
 			return 0;
 		}
 		break;
diff --git a/include/linux/i8042.h b/include/linux/i8042.h
index 7907a72..1f6d7d5 100644
--- a/include/linux/i8042.h
+++ b/include/linux/i8042.h
@@ -7,6 +7,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/types.h>
 
 /*
  * Standard commands.
@@ -30,6 +31,35 @@
 #define I8042_CMD_MUX_PFX	0x0090
 #define I8042_CMD_MUX_SEND	0x1090
 
+struct serio;
+
+#ifdef CONFIG_SERIO_I8042
+
+void i8042_lock_chip(void);
+void i8042_unlock_chip(void);
 int i8042_command(unsigned char *param, int command);
+bool i8042_check_port_owner(const struct serio *);
+
+#else
+
+void i8042_lock_chip(void)
+{
+}
+
+void i8042_unlock_chip(void)
+{
+}
+
+int i8042_command(unsigned char *param, int command)
+{
+	return -ENOSYS;
+}
+
+bool i8042_check_port_owner(const struct serio *)
+{
+	return false;
+}
+
+#endif
 
 #endif
diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index fcf5fbe..79603a6 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -44,6 +44,8 @@ struct ps2dev {
 void ps2_init(struct ps2dev *ps2dev, struct serio *serio);
 int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout);
 void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout);
+void ps2_begin_command(struct ps2dev *ps2dev);
+void ps2_end_command(struct ps2dev *ps2dev);
 int __ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data);

