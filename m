From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: [PATCH] Input: ALPS - fix TrackStick Y axis handling for SS5 hardware
Date: Tue,  3 Jan 2017 07:45:29 -0500
Message-ID: <1483447529-13565-1-git-send-email-linux-kernel@PaulSD.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:45831 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932857AbdACMvO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2017 07:51:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Paul Donohue <linux-kernel@PaulSD.com>

A minus character was lost in commit 23fce365, causing the Y axis to be
inverted for SS5 TrackStick events.  (Pushing the TrackStick up caused
the pointer to move down, and vice versa.)  Restore the lost minus.

Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>
---
 drivers/input/mouse/alps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index cde6f4b..6d279aa 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -114,7 +114,7 @@ enum SS4_PACKET_ID {
 				 (_b[1] & 0x7F)		\
 				)
 
-#define SS4_TS_Y_V2(_b)		(s8)(				\
+#define SS4_TS_Y_V2(_b)		-(s8)(				\
 				 ((_b[3] & 0x01) << 7) |	\
 				 (_b[2] & 0x7F)		\
 				)
-- 
2.9.3

