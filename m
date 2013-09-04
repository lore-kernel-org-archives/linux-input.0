From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 3/7] HID: sony: validate HID output report details
Date: Wed,  4 Sep 2013 09:37:21 -0700
Message-ID: <1378312645-27736-4-git-send-email-keescook@chromium.org>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.outflux.net ([198.145.64.163]:37135 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964885Ab3IDQhn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 12:37:43 -0400
In-Reply-To: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Kees Cook <keescook@chromium.org>, stable@kernel.org

This driver must validate the availability of the HID output report and
its size before it can write LED states via buzz_set_leds(). This stops
a heap overflow that is possible if a device provides a malicious HID
output report:

[  108.171280] usb 1-1: New USB device found, idVendor=054c, idProduct=0002
...
[  117.507877] BUG kmalloc-192 (Not tainted): Redzone overwritten

CVE-2013-2890

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@kernel.org
---
 drivers/hid/hid-sony.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 87fbe29..334a4b5 100644
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
1.7.9.5

