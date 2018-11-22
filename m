From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 1/8] Input: add `REL_WHEEL_HI_RES` and `REL_HWHEEL_HI_RES`
Date: Thu, 22 Nov 2018 16:34:02 +1000
Message-ID: <20181122063409.15816-2-peter.hutterer@who-t.net>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This event code represents scroll reports from high-resolution wheels and
is modelled after the approach Windows uses. The value 120 is one detent
(wheel click) of movement. Mice with higher-resolution scrolling can send
fractions of 120 to be accumulate in userspace. Userspace can either wait
for 120 to accumulate or scroll by fractions of one logical scroll movement
as the events come in.

For more information see
https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn613912(v=vs.85)

These new axes obsolete REL_WHEEL and REL_HWHEEL. The legacy axes are
emulated but the most accurate (and most granular) data is available
through the new axes.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 Documentation/input/event-codes.rst    | 21 ++++++++++++++++++++-
 include/uapi/linux/input-event-codes.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index a8c0873beb95..b24b5343f5eb 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -190,7 +190,26 @@ A few EV_REL codes have special meanings:
 * REL_WHEEL, REL_HWHEEL:
 
   - These codes are used for vertical and horizontal scroll wheels,
-    respectively.
+    respectively. The value is the number of detents moved on the wheel, the
+    physical size of which varies by device. For high-resolution wheels
+    this may be an approximation based on the high-resolution scroll events,
+    see REL_WHEEL_HI_RES. These event codes are legacy codes and
+    REL_WHEEL_HI_RES and REL_HWHEEL_HI_RES should be preferred where
+    available.
+
+* REL_WHEEL_HI_RES, REL_HWHEEL_HI_RES:
+
+  - High-resolution scroll wheel data. The accumulated value 120 represents
+    movement by one detent. For devices that do not provide high-resolution
+    scrolling, the value is always a multiple of 120. For devices with
+    high-resolution scrolling, the value may be a fraction of 120.
+
+    If a vertical scroll wheel supports high-resolution scrolling, this code
+    will be emitted in addition to REL_WHEEL or REL_HWHEEL. The REL_WHEEL
+    and REL_HWHEEL may be an approximation based on the high-resolution
+    scroll events. There is no guarantee that the high-resolution data
+    is a multiple of 120 at the time of an emulated REL_WHEEL or REL_HWHEEL
+    event.
 
 EV_ABS
 ------
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index ae366b87426a..7f14d4a66c28 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -716,6 +716,8 @@
  * the situation described above.
  */
 #define REL_RESERVED		0x0a
+#define REL_WHEEL_HI_RES	0x0b
+#define REL_HWHEEL_HI_RES	0x0c
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
-- 
2.19.1
