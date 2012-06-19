From: Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH 1/2] drivers/input/mouse, drivers/platform/x86: add Lenovo
 IdeaPad Z570 support
Date: Tue, 19 Jun 2012 22:22:14 +0300
Message-ID: <1340133734.3636.10.camel@lenovo-ideapad-z570.olymp.linuxd.org>
References: <1340133637.3636.8.camel@lenovo-ideapad-z570.olymp.linuxd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1340133637.3636.8.camel@lenovo-ideapad-z570.olymp.linuxd.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Rubini <rubini@ipvvis.unipv.it>, Ike Panhc <ike.pan@canonical.com>
List-Id: linux-input@vger.kernel.org

From: Maxim Mikityanskiy <maxtram95@gmail.com>

The patch adds interface to enable/disable PS/2 mouse or touchpad from other
kernel modules.
--
As for now, the only correct way for disabling touchpad in software in Linux is
via X server driver xf86-input-synaptics. (I think that unbinding driver from
serio1 is not right way to disable touchpad.) Some laptops have special key to
disable touchpad. This key has very different behavior on different laptops.
Some laptops toggle touchpad in hardware when user presses the key, so these
ones shouldn't have any problems. Other laptops don't toggle touchpad in
hardware at all but expect that software turns it on and off when the key is
pressed. These laptops should send KEY_TOUCHPAD_TOGGLE keycode, so graphical
desktop environment could change touchpad state via xf86-input-synaptics driver.
But there is also third type of laptops. I own one of them, it's Lenovo IdeaPad
Z570. This laptop mixes hardware and software touchpad control. It has special
key for touchpad toggling and LED that should show touchpad state (glows ==
disabled). When user presses the key, touchpad doesn't become disabled in
hardware, but LED state toggles and there is no way to control the LED state
properly. So toggling touchpad state in userspace is a really bad idea, because
there isn't any unified interface to tell userspace touchpad state, so LED state
may become out of sync with real touchpad state, for example, when switching
between X sessions. So we need some low-level way to turn touchpad off directly
from platform driver. In that case ideapad-laptop driver would tell psmouse to
enable/disable touchpad and send KEY_TOUCHPAD_ON/KEY_TOUCHPAD_OFF keycode so
that LED never goes out of sync and GNOME could show graphical notifications
about touchpad state. This patch lets psmouse export functions to control
touchpad state from platform drivers.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
--- linux/drivers/input/mouse/psmouse-base.c.orig
+++ linux/drivers/input/mouse/psmouse-base.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/libps2.h>
 #include <linux/mutex.h>
+#include <linux/device.h>
 
 #include "psmouse.h"
 #include "synaptics.h"
@@ -1786,6 +1787,48 @@ static int psmouse_get_maxproto(char *bu
 	return sprintf(buffer, "%s", psmouse_protocol_by_type(type)->name);
 }
 
+static int psmouse_match(struct device *dev, void *data)
+{
+	return 1;
+}
+
+static struct psmouse *psmouse_get_struct(void)
+{
+	struct device *dev;
+	struct serio *serio;
+	struct psmouse *psmouse;
+
+	dev = driver_find_device(&psmouse_drv.driver, NULL, NULL,
+			psmouse_match);
+	if (dev == NULL)
+		return NULL;
+
+	serio = to_serio_port(dev);
+	psmouse = serio_get_drvdata(serio);
+
+	return psmouse;
+}
+
+void psmouse_enable(void)
+{
+	struct psmouse *psmouse;
+
+	psmouse = psmouse_get_struct();
+	if (psmouse != NULL)
+		psmouse_activate(psmouse);
+}
+EXPORT_SYMBOL(psmouse_enable);
+
+void psmouse_disable(void)
+{
+	struct psmouse *psmouse;
+
+	psmouse = psmouse_get_struct();
+	if (psmouse != NULL)
+		psmouse_deactivate(psmouse);
+}
+EXPORT_SYMBOL(psmouse_disable);
+
 static int __init psmouse_init(void)
 {
 	int err;
--- /dev/null
+++ linux/include/linux/input/psmouse.h
@@ -0,0 +1,7 @@
+#ifndef _INPUT_PSMOUSE_H
+#define _INPUT_PSMOUSE_H
+
+void psmouse_enable(void);
+void psmouse_disable(void);
+
+#endif
