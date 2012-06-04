From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] input: mt: Fix null pointer warning
Date: Mon,  4 Jun 2012 16:28:48 +0530
Message-ID: <1338807528-1171-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58872 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab2FDLJr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 07:09:47 -0400
Received: by dady13 with SMTP id y13so5687823dad.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jun 2012 04:09:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, sachin.kamat@linaro.org, patches@linaro.org

Fixes the following sparse warning:
drivers/input/input-mt.c:138:40: warning: Using plain integer as NULL pointer

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/input-mt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index f658086..70a16c7 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -135,7 +135,7 @@ EXPORT_SYMBOL(input_mt_report_finger_count);
  */
 void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
 {
-	struct input_mt_slot *oldest = 0;
+	struct input_mt_slot *oldest = NULL;
 	int oldid = dev->trkid;
 	int count = 0;
 	int i;
-- 
1.7.4.1

