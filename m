From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] input: misc: bma150: use sign_extend32() for sign extending
Date: Fri,  3 Jul 2015 01:13:01 +0200
Message-ID: <1435878781-1828-1-git-send-email-martink@posteo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:48620 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091AbbGBXOc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jul 2015 19:14:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

Despite it's name, sign_extend32() is used for 16 bit values aswell.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/misc/bma150.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index b36831c..c278049 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -333,10 +333,9 @@ static void bma150_report_xyz(struct bma150_data *bma150)
 	y = ((0xc0 & data[2]) >> 6) | (data[3] << 2);
 	z = ((0xc0 & data[4]) >> 6) | (data[5] << 2);
 
-	/* sign extension */
-	x = (s16) (x << 6) >> 6;
-	y = (s16) (y << 6) >> 6;
-	z = (s16) (z << 6) >> 6;
+	x = sign_extend32(x, 9);
+	y = sign_extend32(y, 9);
+	z = sign_extend32(z, 9);
 
 	input_report_abs(bma150->input, ABS_X, x);
 	input_report_abs(bma150->input, ABS_Y, y);
-- 
2.1.4

