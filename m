From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] alps: Document that Protocol V2 uses standard PS/2 mouse packets for the stick
Date: Thu,  2 Apr 2015 10:08:54 +0200
Message-ID: <1427962134-4871-2-git-send-email-hdegoede@redhat.com>
References: <1427962134-4871-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49160 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbbDBII6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Apr 2015 04:08:58 -0400
In-Reply-To: <1427962134-4871-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Document that Protocol V2 uses standard (bare) PS/2 mouse packets for the
DualPoint stick.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/input/alps.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.txt
index a63e5e0..92ae734 100644
--- a/Documentation/input/alps.txt
+++ b/Documentation/input/alps.txt
@@ -114,6 +114,9 @@ ALPS Absolute Mode - Protocol Version 2
  byte 4:  0   y6   y5   y4   y3   y2   y1   y0
  byte 5:  0   z6   z5   z4   z3   z2   z1   z0
 
+Protocol Version 2 DualPoint devices send standard PS/2 mouse packets for
+the DualPoint Stick.
+
 Dualpoint device -- interleaved packet format
 ---------------------------------------------
 
@@ -127,6 +130,11 @@ Dualpoint device -- interleaved packet format
  byte 7:    0   y6   y5   y4   y3   y2   y1   y0
  byte 8:    0   z6   z5   z4   z3   z2   z1   z0
 
+Devices which use the interleaving format normally send standard PS/2 mouse
+packets for the DualPoint Stick + ALPS Absolute Mode packets for the
+touchpad, switching to the interleaved packet format when both the stick and
+the touchpad are used at the same time.
+
 ALPS Absolute Mode - Protocol Version 3
 ---------------------------------------
 
-- 
2.3.4

