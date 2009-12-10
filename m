From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/2] input: Allow filtering of i8042 events
Date: Thu, 10 Dec 2009 18:25:32 -0500
Message-ID: <1260487533-4960-1-git-send-email-mjg@redhat.com>
References: <20091209203939.GC10138@core.coreip.homeip.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091209203939.GC10138@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-input@vger.kernel.org

Some hardware (such as Dell laptops) signal a variety of events through the
i8042 controller, even if these don't map to keyboard events. Add support
for drivers to filter the i8042 event stream in order to respond to these
events and (if appropriate) block them from entering the input stream.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---

This version makes the filter global and just lets the filter driver handle
making sure it's only looking at the correct data.

 drivers/input/serio/i8042.c |   57 +++++++++++++++++++++++++++++++++++++++----
 include/linux/i8042.h       |   16 ++++++++++++
 2 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 1df02d2..a16d813 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -110,9 +110,9 @@ struct i8042_port {
 	signed char mux;
 };
 
-#define I8042_KBD_PORT_NO	0
-#define I8042_AUX_PORT_NO	1
-#define I8042_MUX_PORT_NO	2
+#define I8042_KBD_PORT_NO       0
+#define I8042_AUX_PORT_NO       1
+#define I8042_MUX_PORT_NO       2
 #define I8042_NUM_PORTS		(I8042_NUM_MUX_PORTS + 2)
 
 static struct i8042_port i8042_ports[I8042_NUM_PORTS];
@@ -127,6 +127,9 @@ static struct platform_device *i8042_platform_device;
 
 static irqreturn_t i8042_interrupt(int irq, void *dev_id);
 
+static 	bool (*i8042_filter)(unsigned char data, unsigned char str,
+			     struct serio *port);
+
 void i8042_lock_chip(void)
 {
 	mutex_lock(&i8042_mutex);
@@ -139,6 +142,46 @@ void i8042_unlock_chip(void)
 }
 EXPORT_SYMBOL(i8042_unlock_chip);
 
+int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
+					struct serio *port))
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&i8042_lock, flags);
+
+	if (i8042_filter) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	i8042_filter = filter;
+out:
+	spin_unlock_irqrestore(&i8042_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(i8042_install_filter);
+
+int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
+				       struct serio *port))
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&i8042_lock, flags);
+
+	if (!i8042_filter || i8042_filter != filter) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	i8042_filter = NULL;
+out:
+	spin_unlock_irqrestore(&i8042_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(i8042_remove_filter);
+
 /*
  * The i8042_wait_read() and i8042_wait_write functions wait for the i8042 to
  * be ready for reading values from it / writing values to it.
@@ -454,8 +497,12 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 			goto out;
 		}
 
-	if (likely(port->exists))
-		serio_interrupt(port->serio, data, dfl);
+	if (likely(port->exists)) {
+		if (i8042_filter && i8042_filter(data, str, port->serio))
+			goto out;
+		else
+			serio_interrupt(port->serio, data, dfl);
+	}
 
  out:
 	return IRQ_RETVAL(ret);
diff --git a/include/linux/i8042.h b/include/linux/i8042.h
index 60c3360..bf2ccaf 100644
--- a/include/linux/i8042.h
+++ b/include/linux/i8042.h
@@ -39,6 +39,10 @@ void i8042_lock_chip(void);
 void i8042_unlock_chip(void);
 int i8042_command(unsigned char *param, int command);
 bool i8042_check_port_owner(const struct serio *);
+int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
+					struct serio *port));
+int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
+				       struct serio *port));
 
 #else
 
@@ -60,6 +64,18 @@ bool i8042_check_port_owner(const struct serio *serio)
 	return false;
 }
 
+int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
+					struct serio *port))
+{
+	return -ENODEV;
+}
+
+int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
+				       struct serio *port))
+{
+	return -ENODEV;
+}
+
 #endif
 
 #endif
-- 
1.6.5.2

