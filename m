From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Enable pad device for older Bamboo Touch tablets
Date: Wed,  1 Jul 2015 13:01:00 -0700
Message-ID: <1435780860-3647-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35959 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbbGAUB3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jul 2015 16:01:29 -0400
Received: by paceq1 with SMTP id eq1so27794872pac.3
        for <linux-input@vger.kernel.org>; Wed, 01 Jul 2015 13:01:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Commit 862cf55 neglected to set the WACOM_DEVICETYPE_PAD flag for older
two-finger Bamboo Touch tablets. Not only does this result in the pad
device not appearing when such a tablet is plugged in, but also causes a
segfault when 'wacom_bpt_touch' tries to send pad events. This patch
adds the flag to resolve these issues.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 232da89..0d24423 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2213,6 +2213,9 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 			features->x_max = 4096;
 			features->y_max = 4096;
 		}
+		else if (features->pktlen == WACOM_PKGLEN_BBTOUCH) {
+			features->device_type |= WACOM_DEVICETYPE_PAD;
+		}
 	}
 
 	/*
-- 
2.4.4

