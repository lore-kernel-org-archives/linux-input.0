From: Ahmet Inan <ainan@mathematik.uni-freiburg.de>
Subject: [PATCH] Input: synaptics - give touchpad 1 second to settle after S2R
Date: Sat, 21 Jun 2014 10:33:42 +0200
Message-ID: <1403339622-9171-1-git-send-email-ainan@mathematik.uni-freiburg.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:41304 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbaFUIen (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Jun 2014 04:34:43 -0400
Received: by mail-wi0-f182.google.com with SMTP id bs8so1842415wib.15
        for <linux-input@vger.kernel.org>; Sat, 21 Jun 2014 01:34:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Ahmet Inan <ainan@mathematik.uni-freiburg.de>

Since we are resuming now in 0.5 Seconds, we have to give the touchpad
some time to settle before issuing a psmouse_reset.

This fixes the endless reconnect / resync cycle after resuming from S2R.

Signed-off-by: Ahmet Inan <ainan@mathematik.uni-freiburg.de>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c5ec703..059fca0 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1473,6 +1473,7 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 	int retry = 0;
 	int error;
 
+	ssleep(1);
 	do {
 		psmouse_reset(psmouse);
 		if (retry) {
-- 
1.8.5.5

