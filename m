From: Aishwarya Pant <aishpant@gmail.com>
Subject: [PATCH] HID: logitech-hidpp: document sysfs interface
Date: Fri, 2 Mar 2018 18:46:53 +0530
Message-ID: <20180302131653.GA24934@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Descriptions have been collected from git commit logs.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 .../ABI/testing/sysfs-driver-hid-logitech-hidpp       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
new file mode 100644
index 000000000000..d8f831f2d6b5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
@@ -0,0 +1,19 @@
+What:		/sys/bus/hid/drivers/logitech-hidpp-device/<dev>/range
+Date:		Jan, 2016
+KernelVersion:	4.6
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) This attribute controls the amount of 'turn' permitted in
+		Logitech G920 wheel. Reading from the file shows the current
+		range of the steering wheel. Writing a value within the min and
+		max boundary sets the range of the wheel.
+
+What:		/sys/bus/hid/drivers/logitech-hidpp-device/<dev>/builtin_power_supply
+Date:		Apr, 2017
+KernelVersion:	4.12
+Contact:	linux-input@vger.kernel.org
+Description:
+		Presence of this file indicates that HID++ driver is capable of
+		handling battery properties in the kernel. This way, upower can
+		add a udev rule to decide whether or not it should use the
+		internal unifying support or the generic kernel one.
-- 
2.16.2
