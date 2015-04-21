From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input :Added Check for EV_ABS event params
Date: Tue, 21 Apr 2015 11:19:52 -0700
Message-ID: <1429640392-30471-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34862 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbbDUSUg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 14:20:36 -0400
Received: by pabtp1 with SMTP id tp1so248366731pab.2
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2015 11:20:35 -0700 (PDT)
In-Reply-To: <aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com

From: Anshul Garg <aksgarg1989@gmail.com>

while handling EV_ABS event in input_handle_abs_event
function added check for out of range event value from
input driver. As input driver sets the ABS params at
registration time so input core should ignore events out
of the range set by the input driver.

Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
---
 drivers/input/input.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index cc357f1..b1a6ff6 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -244,6 +244,11 @@ static int input_handle_abs_event(struct input_dev *dev,
 		pold = NULL;
 	}
 
+	if (dev->absinfo[code].minimum > *pval || dev->absinfo[code].maximum < *pval) {
+		/* Ignore event with out of range values */		
+		return INPUT_IGNORE_EVENT;
+	}
+
 	if (pold) {
 		*pval = input_defuzz_abs_event(*pval, *pold,
 						dev->absinfo[code].fuzz);
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

