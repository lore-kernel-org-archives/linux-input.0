From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 03/10] HID: sony: validate HID output report details
Date: Wed, 11 Sep 2013 21:56:52 +0200
Message-ID: <1378929419-6269-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1378929419-6269-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378929419-6269-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Kees Cook <keescook@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This driver must validate the availability of the HID output report and
its size before it can write LED states via buzz_set_leds(). This stops
a heap overflow that is possible if a device provides a malicious HID
output report:

[  108.171280] usb 1-1: New USB device found, idVendor=054c, idProduct=0002
...
[  117.507877] BUG kmalloc-192 (Not tainted): Redzone overwritten

CVE-2013-2890

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
v3:
 - no changes

 drivers/hid/hid-sony.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 30dbb6b..b18320d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -537,6 +537,10 @@ static int buzz_init(struct hid_device *hdev)
 	drv_data = hid_get_drvdata(hdev);
 	BUG_ON(!(drv_data->quirks & BUZZ_CONTROLLER));
 
+	/* Validate expected report characteristics. */
+	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
+		return -ENODEV;
+
 	buzz = kzalloc(sizeof(*buzz), GFP_KERNEL);
 	if (!buzz) {
 		hid_err(hdev, "Insufficient memory, cannot allocate driver data\n");
-- 
1.8.3.1
