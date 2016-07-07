From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 4/4] ACPI / button: Add document for ACPI control method lid device restrictions
Date: Thu,  7 Jul 2016 15:11:00 +0800
Message-ID: <3f24a00df89f06661a64af6b4679a99bfff09aa7.1467875143.git.lv.zheng@intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com> <cover.1467875142.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1467875142.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Bastien Nocera:" <hadess@hadess.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There are many AML tables reporting wrong initial lid state, and some of
them never reports lid state. As a proxy layer acting between, ACPI button
driver is not able to handle all such cases, but need to re-define the
usage model of the ACPI lid. That is:
1. It's initial state is not reliable;
2. There may not be open event;
3. Userspace should only take action against the close event which is
   reliable, always sent after a real lid close.
This patch adds documentation of the usage model.

Link: https://lkml.org/2016/3/7/460
Link: https://github.com/systemd/systemd/issues/2087
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Bastien Nocera: <hadess@hadess.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org
---
 Documentation/acpi/acpi-lid.txt |   62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/acpi/acpi-lid.txt

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
new file mode 100644
index 0000000..7e4f7ed
--- /dev/null
+++ b/Documentation/acpi/acpi-lid.txt
@@ -0,0 +1,62 @@
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
+changed to "opened". But it is ensured that the AML tables always notify
+"closed" when the lid state is changed to "closed". This is normally used
+to trigger some system power saving operations on Windows. Since it is
+fully tested, this notification is reliable for all AML tables.
+
+3. Expections for the userspace users of the ACPI lid device driver
+
+The userspace programs should stop relying on
+/proc/acpi/button/lid/LID0/state to obtain the lid state. This file is only
+used for the validation purpose.
+
+New userspace programs should rely on the lid "closed" notification to
+trigger some power saving operations and may stop taking actions according
+to the lid "opened" notification. A new input switch event - SW_ACPI_LID is
+prepared for the new userspace to implement this ACPI control method lid
+device specific logics.
+
+During the period the userspace hasn't been switched to use the new
+SW_ACPI_LID event, Linux users can use the following boot parameter to
+handle possible issues:
+  button.lid_init_state=method:
+   This is the default behavior of the Linux ACPI lid driver, Linux kernel
+   reports the initial lid state using the returning value of the _LID
+   control method.
+   This can be used to fix some platforms if the _LID control method's
+   returning value is reliable.
+  button.lid_init_state=open:
+   Linux kernel always reports the initial lid state as "opened".
+   This may fix some platforms if the returning value of the _LID control
+   method is not reliable.
-- 
1.7.10
