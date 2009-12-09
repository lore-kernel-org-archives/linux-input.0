From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/2] input: Allow filtering of i8042 events
Date: Wed,  9 Dec 2009 13:33:28 -0500
Message-ID: <1260383609-7681-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, dtor@mail.ru, lenb@kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-input@vger.kernel.org

Some hardware (such as Dell laptops) signal a variety of events through the
i8042 controller, even if these don't map to keyboard events. Add support
for drivers to filter the i8042 event stream in order to respond to these
events and (if appropriate) block them from entering the input stream.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/input/serio/i8042.c |   73 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/i8042.h       |   24 ++++++++++++++
 2 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 1df02d2..2d02fe2 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -108,11 +108,10 @@ struct i8042_port {
 	int irq;
 	bool exists;
 	signed char mux;
+	bool (*filter)(unsigned char data, unsigned int flags,
+		       struct serio *port);
 };
 
-#define I8042_KBD_PORT_NO	0
-#define I8042_AUX_PORT_NO	1
-#define I8042_MUX_PORT_NO	2
 #define I8042_NUM_PORTS		(I8042_NUM_MUX_PORTS + 2)
 
 static struct i8042_port i8042_ports[I8042_NUM_PORTS];
@@ -139,6 +138,66 @@ void i8042_unlock_chip(void)
 }
 EXPORT_SYMBOL(i8042_unlock_chip);
 
+int i8042_install_filter(int port, bool (*filter)(unsigned char data,
+						  unsigned int flags,
+						  struct serio *port))
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&i8042_lock, flags);
+	if (port >= I8042_NUM_PORTS) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!i8042_ports[port].exists) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (i8042_ports[port].filter) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	i8042_ports[port].filter = filter;
+out:
+	spin_unlock_irqrestore(&i8042_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(i8042_install_filter);
+
+int i8042_remove_filter(int port, bool (*filter)(unsigned char data,
+						 unsigned int flags,
+						 struct serio *port))
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&i8042_lock, flags);
+	if (port >= I8042_NUM_PORTS) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!i8042_ports[port].exists) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (!i8042_ports[port].filter || i8042_ports[port].filter != filter) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	i8042_ports[port].filter = NULL;
+out:
+	spin_unlock_irqrestore(&i8042_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(i8042_remove_filter);
+
 /*
  * The i8042_wait_read() and i8042_wait_write functions wait for the i8042 to
  * be ready for reading values from it / writing values to it.
@@ -454,8 +513,12 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 			goto out;
 		}
 
-	if (likely(port->exists))
-		serio_interrupt(port->serio, data, dfl);
+	if (likely(port->exists)) {
+		if (port->filter && port->filter(data, dfl, port->serio))
+			goto out;
+		else
+			serio_interrupt(port->serio, data, dfl);
+	}
 
  out:
 	return IRQ_RETVAL(ret);
diff --git a/include/linux/i8042.h b/include/linux/i8042.h
index 60c3360..02f823b 100644
--- a/include/linux/i8042.h
+++ b/include/linux/i8042.h
@@ -33,12 +33,22 @@
 
 struct serio;
 
+#define I8042_KBD_PORT_NO       0
+#define I8042_AUX_PORT_NO       1
+#define I8042_MUX_PORT_NO       2
+
 #if defined(CONFIG_SERIO_I8042) || defined(CONFIG_SERIO_I8042_MODULE)
 
 void i8042_lock_chip(void);
 void i8042_unlock_chip(void);
 int i8042_command(unsigned char *param, int command);
 bool i8042_check_port_owner(const struct serio *);
+int i8042_install_filter(int port, bool (*filter)(unsigned char data,
+						  unsigned int flags,
+						  struct serio *port));
+int i8042_remove_filter(int port, bool (*filter)(unsigned char data,
+						 unsigned int flags,
+						 struct serio *port));
 
 #else
 
@@ -60,6 +70,20 @@ bool i8042_check_port_owner(const struct serio *serio)
 	return false;
 }
 
+int i8042_install_filter(int port, bool (*filter)(unsigned char data,
+                                                  unsigned int flags,
+						  struct serio *port))
+{
+	return -ENODEV;
+}
+
+int i8042_remove_filter(int port, bool (*filter)(unsigned char data,
+						 unsigned int flags,
+						 struct serio *port))
+{
+	return -ENODEV;
+}
+
 #endif
 
 #endif
-- 
1.6.5.2

