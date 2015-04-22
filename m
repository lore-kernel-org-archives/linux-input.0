From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] Input - elantech: fix semi-mt protocol for v3 HW
Date: Wed, 22 Apr 2015 11:45:08 -0400
Message-ID: <1429717509-27396-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48841 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932245AbbDVPpN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2015 11:45:13 -0400
In-Reply-To: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

When the v3 hardware sees more than one finger, it uses
the semi-mt protocol to report the touches. However, it
currently works when num_fingers is 0, 1 or 2, but when
it is 3 and above, it sends only 1 finger as if num_fingers
was 1.

This confuses userspace which knows how to deal with extra
fingers when all the slots are used, but not when some are
missing.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=90101

CC: stable@vger.kernel.org

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 991dc6b..79363b6 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -315,7 +315,7 @@ static void elantech_report_semi_mt_data(struct input_dev *dev,
 					 unsigned int x2, unsigned int y2)
 {
 	elantech_set_slot(dev, 0, num_fingers != 0, x1, y1);
-	elantech_set_slot(dev, 1, num_fingers == 2, x2, y2);
+	elantech_set_slot(dev, 1, num_fingers >= 2, x2, y2);
 }
 
 /*
-- 
2.1.0

