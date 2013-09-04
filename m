From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 4/7] HID: steelseries: validate output report details
Date: Wed,  4 Sep 2013 09:37:22 -0700
Message-ID: <1378312645-27736-5-git-send-email-keescook@chromium.org>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.outflux.net ([198.145.64.163]:52821 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964888Ab3IDQhn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 12:37:43 -0400
In-Reply-To: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Kees Cook <keescook@chromium.org>, stable@kernel.org

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
index d164911..29f328f 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -249,6 +249,11 @@ static int steelseries_srws1_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
+	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 16)) {
+		ret = -ENODEV;
+		goto err_free;
+	}
+
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
-- 
1.7.9.5

