From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 05/14] HID: steelseries: validate output report details
Date: Wed, 28 Aug 2013 22:30:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308282201070.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57942 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222Ab3H1Uak (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 16:30:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Simon Wood <simon@mungewell.org>

From: Kees Cook <keescook@chromium.org>

A HID device could send a malicious output report that would cause the
steelseries HID driver to write beyond the output report allocation
during initialization, causing a heap overflow:

[  167.981534] usb 1-1: New USB device found, idVendor=1038, idProduct=1410
...
[  182.050547] BUG kmalloc-256 (Tainted: G        W   ): Redzone overwritten

CVE-2013-2891

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@kernel.org
---
 drivers/hid/hid-steelseries.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index d164911..ef42e86 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -249,6 +249,11 @@ static int steelseries_srws1_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
+	if (!hid_validate_report(hdev, HID_OUTPUT_REPORT, 0, 1, 16)) {
+		ret = -ENODEV;
+		goto err_free;
+	}
+
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");

-- 
Jiri Kosina
SUSE Labs
