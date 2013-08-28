From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 10/14] HID: ntrig: validate feature report details
Date: Wed, 28 Aug 2013 22:31:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308282221210.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57985 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab3H1Ubb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 16:31:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Rafi Rubin <rafi@seas.upenn.edu>

From: Kees Cook <keescook@chromium.org>

A HID device could send a malicious feature report that would cause the
ntrig HID driver to trigger a NULL dereference during initialization:

[57383.031190] usb 3-1: New USB device found, idVendor=1b96, idProduct=0001
...
[57383.315193] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
[57383.315308] IP: [<ffffffffa08102de>] ntrig_probe+0x25e/0x420 [hid_ntrig]

CVE-2013-2896

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@kernel.org
---
 drivers/hid/hid-ntrig.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index ef95102..5482156 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -115,7 +115,8 @@ static inline int ntrig_get_mode(struct hid_device *hdev)
 	struct hid_report *report = hdev->report_enum[HID_FEATURE_REPORT].
 				    report_id_hash[0x0d];
 
-	if (!report)
+	if (!report || report->maxfield < 1 ||
+	    report->field[0]->report_count < 1)
 		return -EINVAL;
 
 	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);

-- 
Jiri Kosina
SUSE Labs
