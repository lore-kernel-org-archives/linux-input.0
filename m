From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH] Documentation: event-codes.txt: clarify we want
 BTN_TOOL_<name> on proximity
Date: Wed, 24 Feb 2016 14:12:03 +1000
Message-ID: <20160224041203.GA32566@jelly.redhat.com>
References: <20160223230855.GD30638@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:41266 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006AbcBXEMQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2016 23:12:16 -0500
Content-Disposition: inline
In-Reply-To: <20160223230855.GD30638@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Charles Mooney <charliemooney@google.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, Linux Input <linux-input@vger.kernel.org>

This explicitly states behavior we already use for some touchpads and tablet
devices.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 Documentation/input/event-codes.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
index 3f0f5ce..36ea940 100644
--- a/Documentation/input/event-codes.txt
+++ b/Documentation/input/event-codes.txt
@@ -173,6 +173,10 @@ A few EV_ABS codes have special meanings:
     proximity of the device and while the value of the BTN_TOUCH code is 0. If
     the input device may be used freely in three dimensions, consider ABS_Z
     instead.
+  - BTN_TOOL_<name> should be set to 1 when the tool comes into detectable
+    proximity and set to 0 when the tool leaves detectable proximity.
+    BTN_TOOL_<name> signals the type of tool that is currently detected by the
+    hardware and is otherwise independent of ABS_DISTANCE and/or BTN_TOUCH.
 
 * ABS_MT_<name>:
   - Used to describe multitouch input events. Please see
-- 
2.5.0

