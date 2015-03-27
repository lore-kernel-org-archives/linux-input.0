From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH] Documentation: input - define INPUT_PROP_ACCELEROMETER
 behavior
Date: Fri, 27 Mar 2015 10:11:06 +1000
Message-ID: <20150327001106.GA16588@jelly.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:10022 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbbC0ALW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2015 20:11:22 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pingc@wacom.com>, Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>

Spell out what this property means to userspace. If the property is set, all
directional axes must be accelerometer axes, any other axes are left as-is.
This allows an accelerometer device to e.g. have an ABS_WHEEL.

It is not permitted to mix normal directional axes and accelerometer axes on
the same device node.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
I think this is the most sensible definition of what to expect when this
property is set on a device.

 Documentation/input/event-codes.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
index 9d13600..1756b97 100644
--- a/Documentation/input/event-codes.txt
+++ b/Documentation/input/event-codes.txt
@@ -294,6 +294,12 @@ accordingly. This property does not affect kernel behavior.
 The kernel does not provide button emulation for such devices but treats
 them as any other INPUT_PROP_BUTTONPAD device.
 
+INPUT_PROP_ACCELEROMETER
+-------------------------
+Directional axes on this device (absolute and/or relative x, y, z) represent
+accelerometer data. All other axes retain their meaning. A device must not mix
+regular directional axes and accelerometer axes on the same event node.
+
 Guidelines:
 ==========
 The guidelines below ensure proper single-touch and multi-finger functionality.
-- 
2.3.3

