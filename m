From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] alps: Do not divide trackpoint deltas reported by hardware by 2 for v7 devices
Date: Thu,  4 Jun 2015 13:57:42 +0200
Message-ID: <1433419062-7477-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34194 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbbFDL5q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Jun 2015 07:57:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rico Moorman <rico.moorman@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org

On some v7 devices (e.g. Lenovo-E550) the deltas reported are typically
only in the 0-1 range dividing this by 2 results in a range of 0-0.

And even for v7 devices where this does not lead to making the trackstick
entirely unusable, it makes it twice as slow as before we added v7 support
and were using the ps/2 mouse emulation of the dual point setup.

If some kind of generic slowdown is actually necessary for some devices,
then that belongs in userspace, not in the kernel.

Cc: stable@vger.kernel.org
Reported-and-tested-by: Rico Moorman <rico.moorman@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 9bc4343..c195b3a 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1072,8 +1072,8 @@ static void alps_process_trackstick_packet_v7(struct psmouse *psmouse)
 	middle = (packet[1] & 0x04) >> 2;
 
 	/* Divide 2 since trackpoint's speed is too fast */
-	input_report_rel(dev2, REL_X, (char)x / 2);
-	input_report_rel(dev2, REL_Y, -((char)y / 2));
+	input_report_rel(dev2, REL_X, (char)x);
+	input_report_rel(dev2, REL_Y, -((char)y));
 
 	input_report_key(dev2, BTN_LEFT, left);
 	input_report_key(dev2, BTN_RIGHT, right);
-- 
2.4.2

