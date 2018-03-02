From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH] Input: trackpoint: document sysfs interface
Date: Fri, 2 Mar 2018 23:00:19 +0530
Message-ID: <20180302173019.GA27660@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Descriptions have been collected from git commit logs, code commits and
the TrackPoint System Version 4.0 Engineering Specification.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 .../ABI/testing/sysfs-devices-platform-trackpoint  | 115 +++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-trackpoint

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-trackpoint b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
new file mode 100644
index 000000000000..df11901a6b3d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
@@ -0,0 +1,115 @@
+What:		/sys/devices/platform/i8042/.../sensitivity
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Trackpoint sensitivity.
+
+What:		/sys/devices/platform/i8042/.../intertia
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Negative inertia factor. High values cause the cursor to
+		snap backward when the trackpoint is released.
+
+What:		/sys/devices/platform/i8042/.../reach
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Backup range for z-axis press.
+
+What:		/sys/devices/platform/i8042/.../draghys
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) The drag hysteresis controls how hard it is to drag with
+		z-axis pressed.
+
+What:		/sys/devices/platform/i8042/.../mindrag
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Minimum amount of force needed to trigger dragging.
+
+What:		/sys/devices/platform/i8042/.../speed
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Speed of the trackpoint cursor.
+
+What:		/sys/devices/platform/i8042/.../thresh
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Minimum value for z-axis force required to trigger a press
+		or release, relative to the running average.
+
+What:		/sys/devices/platform/i8042/.../upthresh
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) The offset from the running average required to generate a
+		select (click) on z-axis on release.
+
+What:		/sys/devices/platform/i8042/.../ztime
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) This attribute determines how sharp a press has to be in
+		order to be recognized.
+
+What:		/sys/devices/platform/i8042/.../jenks
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Minimum curvature in degrees required to generate a double
+		click without a release.
+
+What:		/sys/devices/platform/i8042/.../skipback
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) When the skipback bit is set, backup cursor movement during
+		releases from drags will be suppressed. The default value for
+		this bit is 0.
+
+What:		/sys/devices/platform/i8042/.../ext_dev
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Disable (0) or enable (1) external pointing device.
+
+What:		/sys/devices/platform/i8042/.../press_to_select
+Date:		Aug, 2005
+KernelVersion:	2.6.14
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Writing a value of 1 to this file will enable the Press to
+		Select functions like tapping the control stick to simulate a
+		left click, and writing 0 will disable it.
+
+What:		/sys/devices/platform/i8042/.../drift_time
+Date:		Dec, 2014
+KernelVersion:	3.19
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) This parameter controls the period of time to test for a
+		‘hands off’ condition (i.e. when no force is applied) before a
+		drift (noise) calibration occurs.
+
+		IBM Trackpoints have a feature to compensate for drift by
+		recalibrating themselves periodically. By default, if for 0.5
+		seconds there is no change in position, it's used as the new
+		zero. This duration is too low. Often, the calibration happens
+		when the trackpoint is in fact being used.
-- 
2.16.2
