From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: fix an Oops caused by wacom_wac_finger_count_touches
Date: Tue, 19 May 2015 17:42:02 -0700
Message-ID: <1432082522-4107-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33508 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbETAmM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2015 20:42:12 -0400
Received: by padbw4 with SMTP id bw4so45802454pad.0
        for <linux-input@vger.kernel.org>; Tue, 19 May 2015 17:42:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, tasos@tasossah.com, Ping Cheng <pingc@wacom.com>

We assumed all touch interfaces report touch data. But, Bamboo
and Intuos non-touch devices report express keys on touch
interface. We need to check touch_max before counting touches.

Reported-by: Tasos Sahanidis <tasos@tasossah.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
Hi Jiri, this patch is based on for-4.1/wacom. The issue was
initially introduced in 4.1.
---
 drivers/hid/wacom_wac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 69c7df7..1cd80d2 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1072,6 +1072,9 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 	int count = 0;
 	int i;
 
+	if (!touch_max)
+		return 0;
+
 	/* non-HID_GENERIC single touch input doesn't call this routine */
 	if ((touch_max == 1) && (wacom->features.type == HID_GENERIC))
 		return wacom->hid_data.tipswitch &&
-- 
1.9.1

