From: Harry Cutts <hcutts@chromium.org>
Subject: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Date: Thu, 23 Aug 2018 11:30:55 -0700
Message-ID: <20180823183057.247630-2-hcutts@chromium.org>
References: <20180823183057.247630-1-hcutts@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823183057.247630-1-hcutts@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jiri.kosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Harry Cutts <hcutts@chromium.org>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This event code represents scroll reports from high-resolution wheels,
and will be used by future patches in this series. See the linux-input
"Reporting high-resolution scroll events" thread [0] for more details.

[0]: https://www.spinics.net/lists/linux-input/msg57380.html

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

 Documentation/input/event-codes.rst    | 11 ++++++++++-
 include/uapi/linux/input-event-codes.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index a8c0873beb95..df024cb82829 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -190,7 +190,16 @@ A few EV_REL codes have special meanings:
 * REL_WHEEL, REL_HWHEEL:
 
   - These codes are used for vertical and horizontal scroll wheels,
-    respectively.
+    respectively. The value is the number of "notches" moved on the wheel, the
+    physical size of which varies by device. For high-resolution wheels (which
+    report multiple events for each notch of movement, or do not have notches)
+    this may be an approximation based on the high-resolution scroll events.
+
+* REL_WHEEL_HI_RES:
+
+  - If a vertical scroll wheel supports high-resolution scrolling, this code
+    will be emitted in addition to REL_WHEEL. The value is the (approximate)
+    distance travelled by the user's finger, in 256ths of a millimeter.
 
 EV_ABS
 ------
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 53fbae27b280..dad8d3890a3a 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -708,6 +708,7 @@
 #define REL_DIAL		0x07
 #define REL_WHEEL		0x08
 #define REL_MISC		0x09
+#define REL_WHEEL_HI_RES	0x0a
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
-- 
2.18.0.1017.ga543ac7ca45-goog
