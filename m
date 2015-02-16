From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 4/5] HID: sony: Use __u8 * for the buffer in sixaxis_set_operational_usb()
Date: Mon, 16 Feb 2015 18:12:23 +0100
Message-ID: <1424106744-12872-5-git-send-email-ao2@ao2.it>
References: <20150216150659.db522f3d.cand@gmx.com>
 <1424106744-12872-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:59803 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbbBPRMk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 12:12:40 -0500
In-Reply-To: <1424106744-12872-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, Frank Praznik <frank.praznik@oh.rr.com>

Use the same type declared in the prototypes of functions that are going
to accept the buffer as parameter.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index a419868..4a50e65 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1134,7 +1134,7 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 	int ret;
 	const int buf_size =
 		max(SIXAXIS_REPORT_0xF2_SIZE, SIXAXIS_REPORT_0xF5_SIZE);
-	char *buf = kmalloc(buf_size, GFP_KERNEL);
+	__u8 *buf = kmalloc(buf_size, GFP_KERNEL);
 
 	if (!buf)
 		return -ENOMEM;
-- 
2.1.4

