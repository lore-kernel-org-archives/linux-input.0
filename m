From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: Add rmi_version.h
Date: Tue, 7 Jan 2014 13:37:37 -0800
Message-ID: <1389130657-4695-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:26768 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbaAGVhm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jan 2014 16:37:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Adds a file containing driver versioning #defines, allowing convenient
script-based tweakage of various versioning info.  This is helpful to
differentiate various custom and/or development versions of the driver from
the main branch of the code.

Since rmi_driver.h changes as a result, its copyright date gets updated.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_driver.h  |  5 ++---
 drivers/input/rmi4/rmi_version.h | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index df9ddd8..4438b20 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011-2013 Synaptics Incorporated
+ * Copyright (c) 2011-2014 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -14,8 +14,7 @@
 #include <linux/hrtimer.h>
 #include <linux/ktime.h>
 #include "rmi_bus.h"
-
-#define RMI_DRIVER_VERSION "1.6"
+#include "rmi_version.h"
 
 #define SYNAPTICS_INPUT_DEVICE_NAME "Synaptics RMI4 Touch Sensor"
 #define SYNAPTICS_VENDOR_ID 0x06cb
diff --git a/drivers/input/rmi4/rmi_version.h b/drivers/input/rmi4/rmi_version.h
new file mode 100644
index 0000000..ed001fa
--- /dev/null
+++ b/drivers/input/rmi4/rmi_version.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2014 Synaptics Incorporated
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef RMI_VERSION_H
+#define RMI_VERSION_H
+
+#define RMI_VERSION_MAJOR "1"
+#define RMI_VERSION_MINOR "19"
+#define RMI_VERSION_SUBMINOR "0"
+
+#define RMI_VERSION_BRANCH "synaptics-rmi4"
+#define RMI_EXTRA_NUMBER "0"
+#define RMI_EXTRA_STRING "0"
+
+#define RMI_DRIVER_VERSION RMI_VERSION_MAJOR "." \
+	RMI_VERSION_MINOR "." RMI_VERSION_SUBMINOR "-" \
+	RMI_EXTRA_STRING
+
+#endif
