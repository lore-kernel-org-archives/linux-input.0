From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH] HID: ntrig: document sysfs interface
Date: Fri, 2 Mar 2018 11:00:17 +0530
Message-ID: <20180302053017.GA23123@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add sysfs documentation for N-Trig touchscreens under Documentation/ABI.
Descriptions have been collected from code comments.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-ntrig | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-ntrig

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-ntrig b/Documentation/ABI/testing/sysfs-driver-hid-ntrig
new file mode 100644
index 000000000000..e574a5625efe
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-ntrig
@@ -0,0 +1,70 @@
+What:		/sys/bus/hid/drivers/ntrig/<dev>/activate_slack
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Number of contact frames ignored before acknowledging the
+		start of activity (activating touch).
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/decativate_slack
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Number of empty (no contact) frames ignored before
+		acknowledging the end of activity (deactivating touch).
+
+		When the last finger is removed from the device, it sends a
+		number of empty frames. By holding off on deactivation for a few
+		frames false erroneous disconnects can be tolerated, where the
+		sensor may mistakenly not detect a finger that is still present.
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/activation_width
+What:		/sys/bus/hid/drivers/ntrig/<dev>/activation_height
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		Threholds to override activation slack.
+
+		activation_width:	(RW) Width threshold to immediately
+					start processing touch events.
+
+		activation_height:	(RW) Height threshold to immediately
+					start processing touch events.
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/min_width
+What:		/sys/bus/hid/drivers/ntrig/<dev>/min_height
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		Minimum size contact accepted.
+
+		min_width:	(RW) Minimum touch contact width to decide
+				activation and activity.
+
+		min_height:	(RW) Minimum touch contact height to decide
+				activation and activity.
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/sensor_physical_width
+What:		/sys/bus/hid/drivers/ntrig/<dev>/sensor_physical_height
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RO) These are internal ranges not used for normal events but
+		useful for tuning.
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/sensor_logical_width
+What:		/sys/bus/hid/drivers/ntrig/<dev>/sensor_logical_height
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RO) The range for positions reported during activity.
-- 
2.16.2
