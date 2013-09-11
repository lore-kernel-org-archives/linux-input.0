From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 04/10] HID: steelseries: validate output report details
Date: Wed, 11 Sep 2013 21:56:53 +0200
Message-ID: <1378929419-6269-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1378929419-6269-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378929419-6269-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Kees Cook <keescook@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

A HID device could send a malicious output report that would cause the
steelseries HID driver to write beyond the output report allocation
during initialization, causing a heap overflow:

[  167.981534] usb 1-1: New USB device found, idVendor=1038, idProduct=1410
...
[  182.050547] BUG kmalloc-256 (Tainted: G        W   ): Redzone overwritten

CVE-2013-2891

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
v3:
 - no changes

 drivers/hid/hid-steelseries.c | 5 +++++
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
1.8.3.1
