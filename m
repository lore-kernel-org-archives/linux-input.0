From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 3/3] ACPI / button: Add document for ACPI control method lid device restrictions
Date: Fri, 22 Jul 2016 14:24:59 +0800
Message-ID: <5b0a4f3ace68c66dfd0fdbbc3e2a88aaa72c7c34.1469168549.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:24428 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbcGVGZG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2016 02:25:06 -0400
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org

This patch adds documentation for the usage model of the control method lid
device.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
---
 Documentation/acpi/acpi-lid.txt |   89 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/acpi/acpi-lid.txt

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
new file mode 100644
index 0000000..2addedc
--- /dev/null
+++ b/Documentation/acpi/acpi-lid.txt
@@ -0,0 +1,89 @@
+Usage Model of the ACPI Control Method Lid Device
+
+Copyright (C) 2016, Intel Corporation
+Author: Lv Zheng <lv.zheng@intel.com>
+
+
+Abstract:
+
+Platforms containing lids convey lid state (open/close) to OSPMs using a
+control method lid device. To implement this, the AML tables issue
+Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
+changed. The _LID control method for the lid device must be implemented to
+report the "current" state of the lid as either "opened" or "closed".
+
+This document describes the restrictions and the expections of the Linux
+ACPI lid device driver.
+
+
+1. Restrictions of the returning value of the _LID control method
+
+The _LID control method is described to return the "current" lid state.
+However the word of "current" has ambiguity, many AML tables return the lid
+state upon the last lid notification instead of returning the lid state
+upon the last _LID evaluation. There won't be difference when the _LID
+control method is evaluated during the runtime, the problem is its initial
+returning value. When the AML tables implement this control method with
+cached value, the initial returning value is likely not reliable. There are
+simply so many examples always retuning "closed" as initial lid state.
+
+2. Restrictions of the lid state change notifications
+
+There are many AML tables never notifying when the lid device state is
+changed to "opened". Thus the "opened" notification is not guaranteed.
+
+But it is guaranteed that the AML tables always notify "closed" when the
+lid state is changed to "closed". The "closed" notification is normally
+used to trigger some system power saving operations on Windows. Since it is
+fully tested, the "closed" notification is reliable for all AML tables.
+
+3. Expections for the userspace users of the ACPI lid device driver
+
+The ACPI button driver exports the lid state to the userspace via the
+following file:
+  /proc/acpi/button/lid/LID0/state
+This file actually calls the _LID control method described above. And given
+the previous explanation, it is not reliable enough on some platforms. So
+it is advised for the userspace program to not to solely rely on this file
+to determine the actual lid state.
+
+The ACPI button driver emits 2 kinds of events to the user space:
+  SW_LID
+   When the lid state/event is reliable, the userspace can behave
+   according to this input switch event.
+   This is a mode prepared for backward compatiblity.
+  KEY_EVENT_OPEN/KEY_EVENT_CLOSE
+   When the lid state/event is not reliable, the userspace should behave
+   according to these 2 input key events.
+   New userspace programs may only be prepared for the input key events.
+
+If the userspace hasn't been prepared to handle the new input lid key
+events, Linux users can use the following kernel parameters to handle the
+possible issues triggered because of the unreliable lid state/event:
+A. button.lid_init_state=method:
+   When this option is specified, the ACPI button driver reports the
+   initial lid state using the returning value of the _LID control method.
+   This option can be used to fix some platforms where the _LID control
+   method's returning value is reliable but the initial lid state
+   notification is missing.
+   This option is the default behavior during the period the userspace
+   isn't ready to handle the new usage model.
+B. button.lid_init_state=open:
+   When this option is specified, the ACPI button driver always reports the
+   initial lid state as "opened".
+   This may fix some platforms where the returning value of the _LID
+   control method is not reliable and the initial lid state notification is
+   missing.
+
+If the userspace has been prepared to handle the new input lid key events,
+Linux users should always use the following kernel parameter:
+C. button.lid_init_state=ignore:
+   When this option is specified, the ACPI button driver never reports the
+   initial lid state. However, the platform may automatically report a
+   correct initial lid state and there is no "open" event missing. When
+   this is the case (everything is correctly implemented by the platform
+   firmware), the old input switch event based userspace can still work.
+   Otherwise, the userspace programs may only work based on the input key
+   events.
+   This option will be the default behavior after the userspace is ready to
+   handle the new usage model.
-- 
1.7.10

