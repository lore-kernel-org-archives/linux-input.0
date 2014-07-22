From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH] Input: document INPUT_PROP_TOPBUTTONPAD
Date: Tue, 22 Jul 2014 10:00:18 +1000
Message-ID: <20140722000018.GA10920@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:19944 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbaGVAAV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2014 20:00:21 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 Documentation/input/event-codes.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
index f82ba9c..7ff7bf4 100644
--- a/Documentation/input/event-codes.txt
+++ b/Documentation/input/event-codes.txt
@@ -281,6 +281,19 @@ gestures can normally be extracted from it.
 If INPUT_PROP_SEMI_MT is not set, the device is assumed to be a true MT
 device.
 
+INPUT_PROP_TOPBUTTONPAD:
+-----------------------
+Some laptops, most notably the Lenovo *40 series provide a trackstick
+device but do not have physical buttons associated with the trackstick
+device. Instead, the top area of the touchpad is marked to show
+visual/haptic areas for left, middle, right buttons intended to be used
+with the trackstick.
+
+If INPUT_PROP_TOPBUTTONPAD is set, userspace should emulate buttons
+accordingly. This property does not affect kernel behavior.
+The kernel does not provide button emulation for such devices but treats
+them as any other INPUT_PROP_BUTTONPAD device.
+
 Guidelines:
 ==========
 The guidelines below ensure proper single-touch and multi-finger functionality.
-- 
1.9.3

