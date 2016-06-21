From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 5/5] Documentation/alps: Add V8 protocol documentation
Date: Tue, 21 Jun 2016 11:19:33 +0200
Message-ID: <1466500773-3470-6-git-send-email-ben@smart-cactus.org>
References: <1466500773-3470-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56548 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbcFUJUd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 05:20:33 -0400
In-Reply-To: <1466500773-3470-1-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

---
 Documentation/input/alps.txt | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.txt
index 1fec113..8d1341c 100644
--- a/Documentation/input/alps.txt
+++ b/Documentation/input/alps.txt
@@ -319,3 +319,60 @@ For touchpad packet, the format is:
                otherwise byte 0 bit 4 must be set and byte 0/4/5 are
                in NEW fmt
  F:         Number of fingers - 3, 0 means 3 fingers, 1 means 4 ...
+
+
+ALPS Absolute Mode - Protocol Version 8
+---------------------------------------
+
+Spoken by SS4 (73 03 14) and SS5 (73 03 28) hardware.
+
+The packet type is given by the APD field, bits 4-5 of byte 3.
+
+Touchpad packet (APD = 0x2):
+
+           b7   b6   b5   b4   b3   b2   b1   b0
+ byte 0:  SWM  SWR  SWL    1    1    0    0   X7
+ byte 1:    0   X6   X5   X4   X3   X2   X1   X0
+ byte 2:    0   Y6   Y5   Y4   Y3   Y2   Y1   Y0
+ byte 3:    0  T&P    1    0    1    0    0   Y7
+ byte 4:    0   Z6   Z5   Z4   Z3   Z2   Z1   Z0
+ byte 5:    0    0    0    0    0    0    0    0
+
+SWM, SWR, SWL: Middle, Right, and Left button states
+
+Touchpad 1 Finger packet (APD = 0x0):
+
+           b7   b6   b5   b4   b3   b2   b1   b0
+ byte 0:  SWM  SWR  SWL    1    1   X2   X1   X0
+ byte 1:   X9   X8   X7    1   X6   X5   X4   X3
+ byte 2:    0  X11  X10  LFB   Y3   Y2   Y1   Y0
+ byte 3:   Y5   Y4    0    0    1 TAPF2 TAPF1 TAPF0
+ byte 4:  Zv7  Y11  Y10    1   Y9   Y8   Y7   Y6
+ byte 5:  Zv6  Zv5  Zv4    0  Zv3  Zv2  Zv1  Zv0
+
+TAPF: ???
+LFB:  ???
+
+Touchpad 2 Finger packet (APD = 0x1):
+
+           b7   b6   b5   b4   b3   b2   b1   b0
+ byte 0:  SWM  SWR  SWL    1    1  AX6  AX5  AX4
+ byte 1: AX11 AX10  AX9  AX8  AX7  AZ1  AY4  AZ0
+ byte 2: AY11 AY10  AY9  CONT AY8  AY7  AY6  AY5
+ byte 3:    0    0    0    1    1  BX6  BX5  BX4
+ byte 4: BX11 BX10  BX9  BX8  BX7  BZ1  BY4  BZ0
+ byte 5: BY11 BY10  BY9    0  BY8  BY7  BY5  BY5
+
+CONT: A 3-or-4 Finger packet is to follow
+
+Touchpad 3-or-4 Finger packet (APD = 0x3):
+
+           b7   b6   b5   b4   b3   b2   b1   b0
+ byte 0:  SWM  SWR  SWL    1    1  AX6  AX5  AX4
+ byte 1: AX11 AX10  AX9  AX8  AX7  AZ1  AY4  AZ0
+ byte 2: AY11 AY10  AY9  OVF  AY8  AY7  AY6  AY5
+ byte 3:    0    0    1    1    1  BX6  BX5  BX4
+ byte 4: BX11 BX10  BX9  BX8  BX7  BZ1  BY4  BZ0
+ byte 5: BY11 BY10  BY9    0  BY8  BY7  BY5  BY5
+
+OVF: 5th finger detected
-- 
2.8.1

