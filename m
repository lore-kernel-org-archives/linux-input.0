From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] Input: clarify gamepad API ABS values
Date: Thu,  3 Oct 2013 15:27:09 +0200
Message-ID: <1380806829-11824-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:52093 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab3JCN1L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Oct 2013 09:27:11 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so1100224ead.35
        for <linux-input@vger.kernel.org>; Thu, 03 Oct 2013 06:27:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

It wasn't really clear from the gamepad-API description how ABS values are
mapped exactly. Clarify that negative is left/up and positive is
right/down. Unfortunately, this means I screwed up the Wii U ProController
ABI. Anyhow, this just means we continue to have 0 compatible gamepad
drivers in the kernel. User-space needs to fix them up, anyway, as all
other gamepads are also incompatible.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 Documentation/input/gamepad.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
index 8002c89..31bb6a4 100644
--- a/Documentation/input/gamepad.txt
+++ b/Documentation/input/gamepad.txt
@@ -122,12 +122,14 @@ D-Pad:
       BTN_DPAD_*
     Analog buttons are reported as:
       ABS_HAT0X and ABS_HAT0Y
+      (for ABS values negative is left/up, positive is right/down)
 
 Analog-Sticks:
   The left analog-stick is reported as ABS_X, ABS_Y. The right analog stick is
   reported as ABS_RX, ABS_RY. Zero, one or two sticks may be present.
   If analog-sticks provide digital buttons, they are mapped accordingly as
   BTN_THUMBL (first/left) and BTN_THUMBR (second/right).
+    (for ABS values negative is left/up, positive is right/down)
 
 Triggers:
   Trigger buttons can be available as digital or analog buttons or both. User-
@@ -138,6 +140,7 @@ Triggers:
   ABS_HAT2X (right/ZR) and BTN_TL2 or ABS_HAT2Y (left/ZL).
   If only one trigger-button combination is present (upper+lower), they are
   reported as "right" triggers (BTN_TR/ABS_HAT1X).
+    (ABS trigger values start at 0, pressure is reported as positive values)
 
 Menu-Pad:
   Menu buttons are always digital and are mapped according to their location
-- 
1.8.4

