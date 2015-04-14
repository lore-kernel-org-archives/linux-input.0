From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] alps: Document separate pointstick button bits for V2 alps devices
Date: Tue, 14 Apr 2015 09:35:47 +0200
Message-ID: <1428996947-4454-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbbDNHfv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 03:35:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Bruin <jmdebruin@xmsnet.nl>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Non interleaved dualpoint v2 devices have separate pointstick button bits,
document this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/input/alps.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.txt
index 92ae734..776a099 100644
--- a/Documentation/input/alps.txt
+++ b/Documentation/input/alps.txt
@@ -107,7 +107,7 @@ ALPS Absolute Mode - Protocol Version 1
 ALPS Absolute Mode - Protocol Version 2
 ---------------------------------------
 
- byte 0:  1    ?    ?    ?    1    ?    ?    ?
+ byte 0:  1    ?    ?    ?    1  PSM  PSR  PSL
  byte 1:  0   x6   x5   x4   x3   x2   x1   x0
  byte 2:  0  x10   x9   x8   x7    ?  fin  ges
  byte 3:  0   y9   y8   y7    1    M    R    L
@@ -115,7 +115,8 @@ ALPS Absolute Mode - Protocol Version 2
  byte 5:  0   z6   z5   z4   z3   z2   z1   z0
 
 Protocol Version 2 DualPoint devices send standard PS/2 mouse packets for
-the DualPoint Stick.
+the DualPoint Stick. For non interleaved dualpoint devices the pointingstick
+buttons get reported separately in the PSM, PSR and PSL bits.
 
 Dualpoint device -- interleaved packet format
 ---------------------------------------------
-- 
2.3.5

