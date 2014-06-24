From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 4/4] HID: sony: Remove an old and redundant comment
Date: Tue, 24 Jun 2014 13:28:43 +0200
Message-ID: <1403609323-27283-5-git-send-email-ao2@ao2.it>
References: <1403609323-27283-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:52962 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652AbaFXMMO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2014 08:12:14 -0400
In-Reply-To: <1403609323-27283-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

Remove an old redundant comment before sony_report_fixup(), it must have
been a leftover from the first version of the driver:
sony_report_fixup() now handles all the supported devices, not only the
Sony Vaio VGX.

The comment is also redundant as the same information provided by it is
also present in the body of the function.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 22ba5dd..bb1e969 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -875,8 +875,6 @@ static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 1;
 }
 
-
-/* Sony Vaio VGX has wrongly mouse pointer declared as constant */
 static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-- 
2.0.0

