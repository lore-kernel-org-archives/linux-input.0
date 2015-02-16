From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 2/5] HID: sony: Use the minimum accepted size for feature report 0xf2
Date: Mon, 16 Feb 2015 18:12:21 +0100
Message-ID: <1424106744-12872-3-git-send-email-ao2@ao2.it>
References: <20150216150659.db522f3d.cand@gmx.com>
 <1424106744-12872-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:46245 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955AbbBPRMj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 12:12:39 -0500
In-Reply-To: <1424106744-12872-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, Frank Praznik <frank.praznik@oh.rr.com>

Sixaxis devices accept feature report 0xf2 when size is >= 17, not 18.
Use the minimum accepted size.

The change is mainly for documentation purposes, the code worked fine
even before this change.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 137d1ee..303335b 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -802,7 +802,7 @@ union sixaxis_output_report_01 {
 #define DS4_REPORT_0x05_SIZE 32
 #define DS4_REPORT_0x11_SIZE 78
 #define DS4_REPORT_0x81_SIZE 7
-#define SIXAXIS_REPORT_0xF2_SIZE 18
+#define SIXAXIS_REPORT_0xF2_SIZE 17
 
 static spinlock_t sony_dev_list_lock;
 static LIST_HEAD(sony_device_list);
-- 
2.1.4

