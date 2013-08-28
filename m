From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 08/14] HID: lenovo-tpkbd: validate output report details
Date: Wed, 28 Aug 2013 22:31:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308282219570.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57965 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab3H1UbN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 16:31:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Bernhard Seibold <mail@bernhard-seibold.de>

From: Kees Cook <keescook@chromium.org>

A HID device could send a malicious output report that would cause the
lenovo-tpkbd HID driver to write just beyond the output report allocation
during initialization, causing a heap overflow:

[   76.109807] usb 1-1: New USB device found, idVendor=17ef, idProduct=6009
...
[   80.462540] BUG kmalloc-192 (Tainted: G        W   ): Redzone overwritten

CVE-2013-2894

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@kernel.org
---
 drivers/hid/hid-lenovo-tpkbd.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-lenovo-tpkbd.c b/drivers/hid/hid-lenovo-tpkbd.c
index 07837f5..b697ada 100644
--- a/drivers/hid/hid-lenovo-tpkbd.c
+++ b/drivers/hid/hid-lenovo-tpkbd.c
@@ -341,6 +341,11 @@ static int tpkbd_probe_tp(struct hid_device *hdev)
 	char *name_mute, *name_micmute;
 	int ret;
 
+	/* Validate required reports. */
+	if (!hid_validate_report(hdev, HID_OUTPUT_REPORT, 4, 4, 1) ||
+	    !hid_validate_report(hdev, HID_OUTPUT_REPORT, 3, 1, 2))
+		return -ENODEV;
+
 	if (sysfs_create_group(&hdev->dev.kobj,
 				&tpkbd_attr_group_pointer)) {
 		hid_warn(hdev, "Could not create sysfs group\n");
-- 
Jiri Kosina
SUSE Labs
