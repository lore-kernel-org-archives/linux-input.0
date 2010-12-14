From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 3/4] Input: Add ABS_RECT_* legacy multitouch evdev codes
Date: Tue, 14 Dec 2010 13:21:11 -0800
Message-ID: <1292361672-2581-4-git-send-email-chase.douglas@canonical.com>
References: <1292361672-2581-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292361672-2581-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The ABS_RECT_* codes allow for partial multitouch support for devices
that do not provide accurate touch coordinate pairings. For example, a
device may emit two touches at points (X1, Y1) and (X2, Y2); however,
the real touch coordinates may be (X1, Y2) and (X2, Y1). Providing a
bounding rectangle allows for panning and pinching multitouch support.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 Documentation/input/evdev-codes.txt |   10 ++++++++++
 include/linux/input.h               |    5 +++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/input/evdev-codes.txt b/Documentation/input/evdev-codes.txt
index 69c810f..65db20e 100644
--- a/Documentation/input/evdev-codes.txt
+++ b/Documentation/input/evdev-codes.txt
@@ -116,6 +116,16 @@ A few EV_ABS codes have special meanings:
     should only be used while the tool is in close proximity of the device. If
     the input device may be used freely in three dimensions, consider ABS_Z
     instead.
+* ABS_RECT_MIN_X, ABS_RECT_MIN_Y, ABS_RECT_MAX_X, ABS_RECT_MAX_Y:
+  - Used to convey partial multitouch support. Some legacy device multitouch
+    coordinates are not accurate enough to be relied on directly. For example,
+    the device may give coordinates (X1, Y1) and (X2, Y2) for two touch points,
+    but in reality the touches are at (X1, Y2) and (X2, Y1). The maximum and
+    minimum axis values are accurate, so they may be used to provide a rectangle
+    bounding box for the touches.
+    The values for these codes are undefined unless two or more touches are
+    active, designated by BTN_TOOL_DOUBLETAP or higher order code being set to
+    1.
 * ABS_MT_<name>:
   - Used to describe multitouch input events. Please see
     multi-touch-protocol.txt for details.
diff --git a/include/linux/input.h b/include/linux/input.h
index cd0618c..5acdc60 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -719,6 +719,11 @@ struct input_keymap_entry {
 
 #define ABS_VOLUME		0x20
 
+#define ABS_RECT_MIN_X		0x21
+#define ABS_RECT_MIN_Y		0x22
+#define ABS_RECT_MAX_X		0x23
+#define ABS_RECT_MAX_Y		0x24
+
 #define ABS_MISC		0x28
 
 #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
-- 
1.7.1
