From: Clifton Barnes <clifton.a.barnes@gmail.com>
Subject: [PATCH] Input: rotary-encoder: fix bare use of 'unsigned'
Date: Sat,  7 May 2016 15:59:18 -0400
Message-ID: <1462651158-27929-1-git-send-email-clifton.a.barnes@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33536 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbcEGUB3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 May 2016 16:01:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Clifton Barnes <clifton.a.barnes@gmail.com>

fix checkpatch.pl warning about 'Prefer 'unsigned int' to bare use of
'unsigned''

Signed-off-by: Clifton Barnes <clifton.a.barnes@gmail.com>
---
 drivers/input/misc/rotary_encoder.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 96c486d..c7fc8d4 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -47,13 +47,13 @@ struct rotary_encoder {
 	bool armed;
 	signed char dir;	/* 1 - clockwise, -1 - CCW */
 
-	unsigned last_stable;
+	unsigned int last_stable;
 };
 
-static unsigned rotary_encoder_get_state(struct rotary_encoder *encoder)
+static unsigned int rotary_encoder_get_state(struct rotary_encoder *encoder)
 {
 	int i;
-	unsigned ret = 0;
+	unsigned int ret = 0;
 
 	for (i = 0; i < encoder->gpios->ndescs; ++i) {
 		int val = gpiod_get_value_cansleep(encoder->gpios->desc[i]);
@@ -100,7 +100,7 @@ static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 {
 	struct rotary_encoder *encoder = dev_id;
-	unsigned state;
+	unsigned int state;
 
 	mutex_lock(&encoder->access_mutex);
 
-- 
1.9.1

