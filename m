From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 2/2] ACPI / button: Add document for ACPI control method lid device restrictions
Date: Tue, 12 Jul 2016 18:17:15 +0800
Message-ID: <627cd0bcb5ff7fcf384089003b98be825965e7f1.1468318558.git.lv.zheng@intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1467717304.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are many AML tables reporting wrong initial lid state, and some of
them never reports lid open state. As a proxy layer acting between, ACPI
button driver is not able to handle all such cases, but need to re-define
the usage model of the ACPI lid. That is:
1. It's initial state is not reliable;
2. There may not be an open event;
3. Userspace should only take action against the close event which is
   reliable, always sent after a real lid close.
This patch adds documentation of the usage model.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
---
 Documentation/acpi/acpi-lid.txt |   89 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/acpi/acpi-lid.txt

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
new file mode 100644
index 0000000..5cf587c
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
+Linux users can switch the ACPI button driver behavior via the following
+kernel parameters:
+A. button.lid_event_type=switch:
+   When the lid state/event is reliable, the users can specify this option
+   (or nothing as this is the default option) to load the ACPI button
+   driver. The ACPI button driver will send the traditional "SW_LID" event
+   to the userspace.
+B. button.lid_event_type=key:
+   When the lid state/event is not reliable, the users can specify this
+   option to load the ACPI button driver. The ACPI button driver will send
+   the "KEY_LID_CLOSE" event instead of the "SW_LID" to the userspace.
+
+If the userspace hasn't been prepared to handle the new KEY_LID_CLOSE
+event, Linux users can use the following kernel parameters to handle the
+possible issues triggered because of the unreliable lid state/event:
+C. button.lid_init_state=method:
+   This option is only effective when the event type is "switch". When this
+   option is specified, the ACPI button driver reports the initial lid
+   state using the returning value of the _LID control method.
+   This option can be used to fix some platforms where the _LID control
+   method's returning value is reliable but the initial lid state
+   notification is missing.
+D. button.lid_init_state=open:
+   This option is only effective when the event type is "switch". When this
+   option is specified, the ACPI button driver always reports the initial
+   lid state as "opened".
+   This may fix some platforms where the returning value of the _LID
+   control method is not reliable and the initial lid state notification is
+   missing.
+
+If the userspace has been prepared to handle the new KEY_LID_CLOSE event,
+Linux users should always use the following kernel parameter:
+E. button.lid_init_state=ignore:
+   This option allows the users to switch the "event type" between the
+   "switch" and the "key". When this option is specified, the ACPI button
+   driver never reports the initial lid state. However, the platform may
+   automatically report a correct initial lid state and there is no "open"
+   event missing. When this is the case (everything is correctly
+   implemented by the platform firmware), the "event type" should be
+   "switch", otherwise, the "event type" should be "key".
-- 
1.7.10

