From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] HID: sony: Fix uninitialized spinlocks
Date: Sun, 22 Feb 2015 20:42:46 -0500
Message-ID: <1424655766-2102-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:57164 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752157AbbBWBoG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Feb 2015 20:44:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, pavel@ucw.cz, Frank Praznik <frank.praznik@oh.rr.com>

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 9e0987d..27f67e7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -805,7 +805,7 @@ union sixaxis_output_report_01 {
 #define SIXAXIS_REPORT_0xF2_SIZE 17
 #define SIXAXIS_REPORT_0xF5_SIZE 8
 
-static spinlock_t sony_dev_list_lock;
+static DEFINE_SPINLOCK(sony_dev_list_lock);
 static LIST_HEAD(sony_device_list);
 static DEFINE_IDA(sony_device_id_allocator);
 
@@ -1965,6 +1965,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -ENOMEM;
 	}
 
+	spin_lock_init(&sc->lock);
+
 	sc->quirks = quirks;
 	hid_set_drvdata(hdev, sc);
 	sc->hdev = hdev;
-- 
2.1.0

