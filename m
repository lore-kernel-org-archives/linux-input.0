From: cpaul@redhat.com
Subject: [PATCH] i8042: Add debug_kbd option
Date: Thu, 25 Jun 2015 15:25:10 -0400
Message-ID: <1435260310-10074-1-git-send-email-cpaul@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52086 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbbFYTZf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2015 15:25:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>

From: Stephen Chandler Paul <cpaul@redhat.com>

A big problem with the current i8042 debugging option is that it outputs
data going to and from the keyboard by default. As a result, many dmesg
logs uploaded by users will unintentionally contain sensitive information
such as their password, as such it's probably a good idea not to output
data coming from the keyboard unless specifically enabled by the user.

Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 Documentation/kernel-parameters.txt |  7 +++++++
 drivers/input/serio/i8042.c         | 25 +++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index ae44749..9e00234 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1304,6 +1304,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			     <bus_id>,<clkrate>
 
 	i8042.debug	[HW] Toggle i8042 debug mode
+	i8042.debug_kbd [HW] Enable printing of interrupt data from the KBD port
+			     As a side effect, this option will mask some of the
+			     interrupts sent back from the keyboard during the
+			     initialization of the KBD port on the i8042, if you
+			     need to see this, you will need to enable this
+			     option.
+			     (disabled by default)
 	i8042.direct	[HW] Put keyboard port into non-translated mode
 	i8042.dumbkbd	[HW] Pretend that controller can only read data from
 			     keyboard and cannot control its state
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index cb5ece7..084fc05 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -88,6 +88,23 @@ MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
 static bool i8042_debug;
 module_param_named(debug, i8042_debug, bool, 0600);
 MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
+
+static bool i8042_debug_kbd;
+module_param_named(debug_kbd, i8042_debug_kbd, bool, 0600);
+MODULE_PARM_DESC(i8042_kbd, "Turn i8042 kbd debugging output on or off");
+
+#define str_dbg(str, data, format, args...)			\
+	do {							\
+		if (!i8042_debug)				\
+			break;					\
+								\
+		if (str & I8042_STR_AUXDATA || i8042_debug_kbd)	\
+			dbg("%02x " format, data, ##args);	\
+		else						\
+			dbg("** " format, ##args);		\
+	} while (0)
+#else
+#define str_dbg(str, data, format, args...) do { } while (0)
 #endif
 
 static bool i8042_bypass_aux_irq_test;
@@ -528,10 +545,10 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	port = &i8042_ports[port_no];
 	serio = port->exists ? port->serio : NULL;
 
-	dbg("%02x <- i8042 (interrupt, %d, %d%s%s)\n",
-	    data, port_no, irq,
-	    dfl & SERIO_PARITY ? ", bad parity" : "",
-	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
+	str_dbg(str, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
+		port_no, irq,
+		dfl & SERIO_PARITY ? ", bad parity" : "",
+		dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
 	filtered = i8042_filter(data, str, serio);
 
-- 
2.4.3

