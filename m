From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH] Input: Fix typo in MT documentation
Date: Thu, 17 Sep 2015 17:01:40 +0200
Message-ID: <1442502100-21039-1-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:42581 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbbIQPB4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 11:01:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Martin <daniel.martin@secunet.com>, Daniel Martin <consume.noise@gmail.com>

Section "Event Computation" had this:
    ...
    ABS_MT_TOOL_X := C_X
    ABS_MT_TOOL_X := C_Y

Replace the second ABS_MT_TOOL_X with ABS_MT_TOOL_Y.

Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 Documentation/input/multi-touch-protocol.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.txt
index b85d000..c51f114 100644
--- a/Documentation/input/multi-touch-protocol.txt
+++ b/Documentation/input/multi-touch-protocol.txt
@@ -361,7 +361,7 @@ For win8 devices with both T and C coordinates, the position mapping is
    ABS_MT_POSITION_X := T_X
    ABS_MT_POSITION_Y := T_Y
    ABS_MT_TOOL_X := C_X
-   ABS_MT_TOOL_X := C_Y
+   ABS_MT_TOOL_Y := C_Y
 
 Unfortunately, there is not enough information to specify both the touching
 ellipse and the tool ellipse, so one has to resort to approximations.  One
-- 
2.1.4

