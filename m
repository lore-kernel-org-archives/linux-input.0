From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 2/6] Haptic: Documentation for haptic class
Date: Wed, 07 Oct 2009 15:17:54 +0900
Message-ID: <20091007061754.GA7588@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757429AbZJGGSm@vger.kernel.org>
Content-disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: soni.trilok@gmail.com
List-Id: linux-input@vger.kernel.org

Describe the haptic class and how to use

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/haptic-class.txt |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/haptic-class.txt

diff --git a/Documentation/haptic-class.txt b/Documentation/haptic-class.txt
new file mode 100644
index 0000000..6bee82a
--- /dev/null
+++ b/Documentation/haptic-class.txt
@@ -0,0 +1,20 @@
+
+Haptic handling under Linux
+========================
+
+In its simplest form, the haptic class just allows control of Haptics from
+userspace. Haptic appears in /sys/class/haptic/. The maximum level of the
+haptic is defined in max_level file.
+
+To use simple. it provides the oneshot mode. Give millisecond time to this
+property. It working at given time with pre-defined level.
+Of course, you can adjust the level by setting level property
+
+# echo ${millisecond} > /sys/class/haptic/<device>/oneshot
+
+# echo ${level} > /sys/class/haptic/<device>/level
+
+Also you can enable/disable by setting enable property
+
+# echo 1 > /sys/class/haptic/<device>/level	-> Enable
+# echo 0 > /sys/class/haptic/<device>/level	-> Disable
-- 
1.5.3.3
