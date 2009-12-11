From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Allow filtering of i8042 events
Date: Thu, 10 Dec 2009 23:59:10 -0800
Message-ID: <20091211075910.GC30274@core.coreip.homeip.net>
References: <20091209203939.GC10138@core.coreip.homeip.net> <1260487533-4960-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1260487533-4960-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 10, 2009 at 06:25:32PM -0500, Matthew Garrett wrote:
> Some hardware (such as Dell laptops) signal a variety of events through the
> i8042 controller, even if these don't map to keyboard events. Add support
> for drivers to filter the i8042 event stream in order to respond to these
> events and (if appropriate) block them from entering the input stream.
> 

Locking is screwed (sorry, did not notice it forst time around). In fact
it was screwed in i8042 itself as well. What do you think about the
following 2 patchs (one prepares i8042 and the other is your vesion,
adapted).

Thanks.

-- 
Dmitry


Input: i8042 - fix locking in interrupt routine

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We need to protect not only i8042 status and data register from concurrent
access from IRQ 1 and 12 but the rest of the shared state as well, so let's
move release of i8042_lock in i8042_interrupt() a little bit further down.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)


diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 1df02d2..773ff11 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -369,6 +369,25 @@ static void i8042_stop(struct serio *serio)
 }
 
 /*
+ * i8042_filter() filters out unwanted bytes from the input data stream.
+ * It is called from i8042_interrupt and thus is running with interrupts
+ * off and i8042_lock held.
+ */
+static bool i8042_filter(unsigned char data, unsigned char str)
+{
+	if (unlikely(i8042_suppress_kbd_ack)) {
+		if ((~str & I8042_STR_AUXDATA) &&
+		    (data == 0xfa || data == 0xfe)) {
+			i8042_suppress_kbd_ack--;
+			dbg("Filtering extra keyboard ACK\n");
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
  * i8042_interrupt() is the most important function in this driver -
  * it handles the interrupts from the i8042, and sends incoming bytes
  * to the upper layers.
@@ -381,9 +400,11 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	unsigned char str, data;
 	unsigned int dfl;
 	unsigned int port_no;
+	bool filtered;
 	int ret = 1;
 
 	spin_lock_irqsave(&i8042_lock, flags);
+
 	str = i8042_read_status();
 	if (unlikely(~str & I8042_STR_OBF)) {
 		spin_unlock_irqrestore(&i8042_lock, flags);
@@ -391,8 +412,8 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 		ret = 0;
 		goto out;
 	}
+
 	data = i8042_read_data();
-	spin_unlock_irqrestore(&i8042_lock, flags);
 
 	if (i8042_mux_present && (str & I8042_STR_AUXDATA)) {
 		static unsigned long last_transmit;
@@ -447,14 +468,11 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	    dfl & SERIO_PARITY ? ", bad parity" : "",
 	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-	if (unlikely(i8042_suppress_kbd_ack))
-		if (port_no == I8042_KBD_PORT_NO &&
-		    (data == 0xfa || data == 0xfe)) {
-			i8042_suppress_kbd_ack--;
-			goto out;
-		}
+	filtered = i8042_filter(data, str);
+
+	spin_unlock_irqrestore(&i8042_lock, flags);
 
-	if (likely(port->exists))
+	if (likely(port->exists && !filtered))
 		serio_interrupt(port->serio, data, dfl);
 
  out:


Input: i8042 - allow installing platform filters for incoming data

From: Matthew Garrett <mjg@redhat.com>

Some hardware (such as Dell laptops) signal a variety of events through
the i8042 controller, even if these don't map to keyboard events. Add
support for drivers to filter the i8042 event stream in order to respond
to these events and (if appropriate) block them from entering the input
stream.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |   60 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/i8042.h       |   18 ++++++++++++-
 2 files changed, 73 insertions(+), 5 deletions(-)


diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 773ff11..d84a36e 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -126,6 +126,8 @@ static unsigned char i8042_suppress_kbd_ack;
 static struct platform_device *i8042_platform_device;
 
 static irqreturn_t i8042_interrupt(int irq, void *dev_id);
+static bool (*i8042_platform_filter)(unsigned char data, unsigned char str,
+				     struct serio *serio);
 
 void i8042_lock_chip(void)
 {
@@ -139,6 +141,48 @@ void i8042_unlock_chip(void)
 }
 EXPORT_SYMBOL(i8042_unlock_chip);
 
+int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
+					struct serio *serio))
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&i8042_lock, flags);
+
+	if (i8042_platform_filter) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	i8042_platform_filter = filter;
+
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
+	if (i8042_platform_filter != filter) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i8042_platform_filter = NULL;
+
+out:
+	spin_unlock_irqrestore(&i8042_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(i8042_remove_filter);
+
 /*
  * The i8042_wait_read() and i8042_wait_write functions wait for the i8042 to
  * be ready for reading values from it / writing values to it.
@@ -373,17 +417,23 @@ static void i8042_stop(struct serio *serio)
  * It is called from i8042_interrupt and thus is running with interrupts
  * off and i8042_lock held.
  */
-static bool i8042_filter(unsigned char data, unsigned char str)
+static bool i8042_filter(unsigned char data, unsigned char str,
+			 struct serio *serio)
 {
 	if (unlikely(i8042_suppress_kbd_ack)) {
 		if ((~str & I8042_STR_AUXDATA) &&
 		    (data == 0xfa || data == 0xfe)) {
 			i8042_suppress_kbd_ack--;
-			dbg("Filtering extra keyboard ACK\n");
+			dbg("Extra keyboard ACK - filtered out\n");
 			return true;
 		}
 	}
 
+	if (i8042_platform_filter && i8042_platform_filter(data, str, serio)) {
+		dbg("Filtered out by platfrom filter\n");
+		return true;
+	}
+
 	return false;
 }
 
@@ -396,6 +446,7 @@ static bool i8042_filter(unsigned char data, unsigned char str)
 static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 {
 	struct i8042_port *port;
+	struct serio *serio;
 	unsigned long flags;
 	unsigned char str, data;
 	unsigned int dfl;
@@ -462,18 +513,19 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	}
 
 	port = &i8042_ports[port_no];
+	serio = port->exists ? port->serio : NULL;
 
 	dbg("%02x <- i8042 (interrupt, %d, %d%s%s)",
 	    data, port_no, irq,
 	    dfl & SERIO_PARITY ? ", bad parity" : "",
 	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-	filtered = i8042_filter(data, str);
+	filtered = i8042_filter(data, str, serio);
 
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
 	if (likely(port->exists && !filtered))
-		serio_interrupt(port->serio, data, dfl);
+		serio_interrupt(serio, data, dfl);
 
  out:
 	return IRQ_RETVAL(ret);
diff --git a/include/linux/i8042.h b/include/linux/i8042.h
index 60c3360..9bf6870 100644
--- a/include/linux/i8042.h
+++ b/include/linux/i8042.h
@@ -39,6 +39,10 @@ void i8042_lock_chip(void);
 void i8042_unlock_chip(void);
 int i8042_command(unsigned char *param, int command);
 bool i8042_check_port_owner(const struct serio *);
+int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
+					struct serio *serio));
+int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
+				       struct serio *serio));
 
 #else
 
@@ -52,7 +56,7 @@ void i8042_unlock_chip(void)
 
 int i8042_command(unsigned char *param, int command)
 {
-	return -ENOSYS;
+	return -ENODEV;
 }
 
 bool i8042_check_port_owner(const struct serio *serio)
@@ -60,6 +64,18 @@ bool i8042_check_port_owner(const struct serio *serio)
 	return false;
 }
 
+int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
+					struct serio *serio))
+{
+	return -ENODEV;
+}
+
+int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
+				       struct serio *serio))
+{
+	return -ENODEV;
+}
+
 #endif
 
 #endif
