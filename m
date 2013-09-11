From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 06/10] HID: lenovo-tpkbd: validate output report details
Date: Wed, 11 Sep 2013 21:56:55 +0200
Message-ID: <1378929419-6269-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1378929419-6269-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378929419-6269-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Kees Cook <keescook@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

From: Kees Cook <keescook@chromium.org>

A HID device could send a malicious output report that would cause the
lenovo-tpkbd HID driver to write just beyond the output report allocation
during initialization, causing a heap overflow:

[   76.109807] usb 1-1: New USB device found, idVendor=17ef, idProduct=6009
...
[   80.462540] BUG kmalloc-192 (Tainted: G        W   ): Redzone overwritten

CVE-2013-2894

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
v3:
 - fix feature report check for report ID 4

 drivers/hid/hid-lenovo-tpkbd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-tpkbd.c b/drivers/hid/hid-lenovo-tpkbd.c
index 07837f5..762d988 100644
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
+		if (!hid_validate_values(hdev, HID_FEATURE_REPORT, 4, i, 1))
+			return -ENODEV;
+	}
+	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 3, 0, 2))
+		return -ENODEV;
 
 	if (sysfs_create_group(&hdev->dev.kobj,
 				&tpkbd_attr_group_pointer)) {
-- 
1.8.3.1
