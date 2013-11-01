From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 03/13] Input: remove ambigious gamepad comment
Date: Fri,  1 Nov 2013 21:16:14 +0100
Message-ID: <1383336984-26601-4-git-send-email-dh.herrmann@gmail.com>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:51873 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab3KAUQs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Nov 2013 16:16:48 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so5910eek.15
        for <linux-input@vger.kernel.org>; Fri, 01 Nov 2013 13:16:47 -0700 (PDT)
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

If only a single trigger combination is present on a device, either can be
reported. If the side of the trigger (left/right) cannot be decided (eg.,
if it's centered), then choose any side. User-space automatically notices
that only a single trigger is reported and thus doesn't care how it is
reported.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 Documentation/input/gamepad.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
index 8002c89..c40b109 100644
--- a/Documentation/input/gamepad.txt
+++ b/Documentation/input/gamepad.txt
@@ -136,8 +136,6 @@ Triggers:
   Upper trigger buttons are reported as BTN_TR or ABS_HAT1X (right) and BTN_TL
   or ABS_HAT1Y (left). Lower trigger buttons are reported as BTN_TR2 or
   ABS_HAT2X (right/ZR) and BTN_TL2 or ABS_HAT2Y (left/ZL).
-  If only one trigger-button combination is present (upper+lower), they are
-  reported as "right" triggers (BTN_TR/ABS_HAT1X).
 
 Menu-Pad:
   Menu buttons are always digital and are mapped according to their location
-- 
1.8.4.1

