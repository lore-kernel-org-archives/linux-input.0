From: Alex Hudson <alex@stratagia.co.uk>
Subject: [RFC] [PATCH] Add Sahara Slate i400 series touchscreen driver.
Date: Tue, 13 Sep 2011 16:50:19 +0100
Message-ID: <1315929025.23282.7.camel@desktop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bart.alcoholicsunanimous.com ([212.13.194.184]:36438 "EHLO
	bart.alcoholicsunanimous.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755159Ab1IMQMB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 12:12:01 -0400
Received: from [84.45.214.47] (helo=dunston.stratagia.co.uk)
	by bart.alcoholicsunanimous.com with esmtp (Exim 4.72)
	(envelope-from <alex@stratagia.co.uk>)
	id 1R3VFj-0004hn-7d
	for linux-input@vger.kernel.org; Tue, 13 Sep 2011 15:50:27 +0000
Received: from cpc2-croy13-0-0-cust346.croy.cable.virginmedia.com ([77.103.217.91] helo=[192.168.178.100])
	by dunston.stratagia.co.uk with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <alex@stratagia.co.uk>)
	id 1R3VFh-0008T7-81
	for linux-input@vger.kernel.org; Tue, 13 Sep 2011 16:50:25 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input list <linux-input@vger.kernel.org>

Hi all,

Find attached an initial patch to support this PS/2 based touch screen.
Sahara claim to support this with a rather ropey xfree86-era driver
which talks to serio_raw; I've written this driver to speak the protocol
directly.

I think there are potentially a couple of issues here, which I'd
appreciate feedback on. The first is that very occasionally, a touch
event is reported at the wrong location. I haven't done enough debugging
to see what the data is doing, and the input_report_* stuff looks simple
enough - but if there are any gotchas I should know about, I'd
appreciate a heads-up.

Second, should this be structured as a separate driver like this? I have
a feeling that there isn't really any way of detecting this hardware,
but this is a lot of lines for maybe ~5 lines of 'real' code...

Thanks

Alex.

---
 drivers/input/mouse/Kconfig            |    9 ++++
 drivers/input/mouse/Makefile           |    1 +
 drivers/input/mouse/psmouse-base.c     |    9 ++++
 drivers/input/mouse/psmouse.h          |    1 +
 drivers/input/mouse/sahara_slate_ps2.c |   75 ++++++++++++++++++++++++++++++++
 drivers/input/mouse/sahara_slate_ps2.h |   23 ++++++++++
 6 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/mouse/sahara_slate_ps2.c
 create mode 100644 drivers/input/mouse/sahara_slate_ps2.h

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 9c1e6ee..3c69fab 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -108,6 +108,15 @@ config MOUSE_PS2_ELANTECH
 	  entries. For further information,
 	  see <file:Documentation/input/elantech.txt>.
 
+config MOUSE_PS2_SAHARASLATE
+	bool "Sahara Slate i400 series touchscreen PS/2 protocol extension"
+	depends on MOUSE_PS2
+	help
+	  Say Y here if you have a Sahara Slate i400 series with a PS/2
+	  touchscreen connected.
+	  
+	  If unsure, say N.
+
 config MOUSE_PS2_SENTELIC
 	bool "Sentelic Finger Sensing Pad PS/2 protocol extension"
 	depends on MOUSE_PS2
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 570c84a4..95d51a6 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -27,6 +27,7 @@ psmouse-$(CONFIG_MOUSE_PS2_ELANTECH)	+= elantech.o
 psmouse-$(CONFIG_MOUSE_PS2_OLPC)	+= hgpk.o
 psmouse-$(CONFIG_MOUSE_PS2_LOGIPS2PP)	+= logips2pp.o
 psmouse-$(CONFIG_MOUSE_PS2_LIFEBOOK)	+= lifebook.o
+psmouse-$(CONFIG_MOUSE_PS2_SAHARASLATE) += sahara_slate_ps2.o
 psmouse-$(CONFIG_MOUSE_PS2_SENTELIC)	+= sentelic.o
 psmouse-$(CONFIG_MOUSE_PS2_TRACKPOINT)	+= trackpoint.o
 psmouse-$(CONFIG_MOUSE_PS2_TOUCHKIT)	+= touchkit_ps2.o
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 3f74bae..d547136 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -27,6 +27,7 @@
 #include "alps.h"
 #include "hgpk.h"
 #include "lifebook.h"
+#include "sahara_slate_ps2.h"
 #include "trackpoint.h"
 #include "touchkit_ps2.h"
 #include "elantech.h"
@@ -829,6 +830,14 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.init		= lifebook_init,
 	},
 #endif
+#ifdef CONFIG_MOUSE_PS2_SAHARASLATE
+	{
+		.type		= PSMOUSE_SAHARA_SLATE_PS2,
+		.name		= "saharaslatePS/2",
+		.alias		= "saharaslate",
+		.detect		= saharaslate_ps2_detect
+	},
+#endif
 #ifdef CONFIG_MOUSE_PS2_TRACKPOINT
 	{
 		.type		= PSMOUSE_TRACKPOINT,
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 593e910..79eb9e4 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -93,6 +93,7 @@ enum psmouse_type {
 	PSMOUSE_HGPK,
 	PSMOUSE_ELANTECH,
 	PSMOUSE_FSP,
+	PSMOUSE_SAHARA_SLATE_PS2,
 	PSMOUSE_AUTO		/* This one should always be last */
 };
 
diff --git a/drivers/input/mouse/sahara_slate_ps2.c b/drivers/input/mouse/sahara_slate_ps2.c
new file mode 100644
index 0000000..c8a9770
--- /dev/null
+++ b/drivers/input/mouse/sahara_slate_ps2.c
@@ -0,0 +1,75 @@
+/* ----------------------------------------------------------------------------
+ * sahara_slate_ps2.c  --  Driver for Sahara Slate i400 series PS/2 Touchscreens
+ *
+ * Copyright (C) 2011 Alex Hudson
+ * 
+ * Parts inspired by touchkit_ps2.c 
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/libps2.h>
+
+#include "psmouse.h"
+#include "sahara_slate_ps2.h"
+
+#define SAHARASLATE_GET_TOUCH(packet)	((((packet)[0]) & 0x04) >> 2)
+#define SAHARASLATE_GET_X(packet)	(((packet)[1] << 2) | (((packet)[0] & 0xc0) >> 6))
+#define SAHARASLATE_GET_Y(packet)	(((packet)[2] << 2) | (((packet)[0] & 0x30) >> 4))
+
+static psmouse_ret_t saharaslate_ps2_process_byte(struct psmouse *psmouse)
+{
+	struct input_dev *dev = psmouse->dev;
+	unsigned char *packet = psmouse->packet;
+
+	if (psmouse->pktcnt != 3)
+		return PSMOUSE_GOOD_DATA;
+
+	input_report_abs(dev, ABS_X, SAHARASLATE_GET_X(packet));
+	input_report_abs(dev, ABS_Y, SAHARASLATE_GET_Y(packet));
+	input_report_key(dev, BTN_TOUCH, SAHARASLATE_GET_TOUCH(packet));
+	input_sync(dev);
+
+	return PSMOUSE_FULL_PACKET;
+}
+
+int saharaslate_ps2_detect(struct psmouse *psmouse, bool set_properties)
+{
+	struct input_dev *dev = psmouse->dev;
+
+	if (set_properties) {
+		dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+		dev->relbit[0] = 0;
+		
+		dev->keybit[BIT_WORD(BTN_MOUSE)] = 0;
+		dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+		
+		input_set_abs_params(dev, ABS_X, 0, 0x03FF, 0, 0);
+		input_set_abs_params(dev, ABS_Y, 0, 0x03FF, 0, 0);
+
+		psmouse->vendor = "Sahara";
+		psmouse->name = "Slate i400 series touchscreen";
+		psmouse->protocol_handler = saharaslate_ps2_process_byte;
+		psmouse->pktsize = 3;
+	}
+	
+	return 0;
+}
diff --git a/drivers/input/mouse/sahara_slate_ps2.h b/drivers/input/mouse/sahara_slate_ps2.h
new file mode 100644
index 0000000..5c1c912
--- /dev/null
+++ b/drivers/input/mouse/sahara_slate_ps2.h
@@ -0,0 +1,23 @@
+/* ----------------------------------------------------------------------------
+ * sahara_slate_ps2.h  --  Driver for Sahara Slate i400 series PS/2 Touchscreens
+ *
+ * Copyright (C) 2011 Alex Hudson
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _SAHARA_SLATE_PS2_H
+#define _SAHARA_SLATE_PS2_H
+
+#ifdef CONFIG_MOUSE_PS2_SAHARASLATE
+int saharaslate_ps2_detect(struct psmouse *psmouse, bool set_properties);
+#else
+static inline int saharaslate_ps2_detect(struct psmouse *psmouse, bool set_properties)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_MOUSE_PS2_SAHARASLATE */
+
+#endif
-- 
1.7.6



