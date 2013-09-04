From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 6/7] HID: lenovo-tpkbd: validate output report details
Date: Wed,  4 Sep 2013 09:37:24 -0700
Message-ID: <1378312645-27736-7-git-send-email-keescook@chromium.org>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.outflux.net ([198.145.64.163]:39559 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964880Ab3IDQhn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 12:37:43 -0400
In-Reply-To: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Kees Cook <keescook@chromium.org>, stable@kernel.org

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
 drivers/hid/hid-lenovo-tpkbd.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-tpkbd.c b/drivers/hid/hid-lenovo-tpkbd.c
index 07837f5..f458e76 100644
--- a/drivers/hid/hid-lenovo-tpkbd.c
+++ b/drivers/hid/hid-lenovo-tpkbd.c
@@ -339,7 +339,15 @@ static int tpkbd_probe_tp(struct hid_device *hdev)
 	struct tpkbd_data_pointer *data_pointer;
 	size_t name_sz = strlen(dev_name(dev)) + 16;
 	char *name_mute, *name_micmute;
-	int ret;
+	int i, ret;
+
+	/* Validate required reports. */
+	for (i = 0; i < 4; i++) {
+		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 4, i, 1))
+			return -ENODEV;
+	}
+	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 3, 0, 2))
+		return -ENODEV;
 
 	if (sysfs_create_group(&hdev->dev.kobj,
 				&tpkbd_attr_group_pointer)) {
-- 
1.7.9.5

