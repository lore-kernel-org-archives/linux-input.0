From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 06/12] HID: wiimote: Add wiimote send function
Date: Mon, 27 Jun 2011 16:30:07 +0200
Message-ID: <1309185013-484-6-git-send-email-dh.herrmann@googlemail.com>
References: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:40385 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab1F0Oa7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 10:30:59 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so1868769fxd.11
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 07:30:59 -0700 (PDT)
In-Reply-To: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org, David Herrmann <dh.herrmann@googlemail.com>

The wiimote driver needs to send raw output reports to the wiimote
device. Otherwise we could not manage the peripherals of the wiimote
or perform memory operations on the wiimote.
We cannot use hidinput_input_event of the lowlevel hid driver, since
this does not accept raw input. Therefore, we need to use the same
function that hidraw uses to send output. Side effect is, the raw
output function is not buffered and can sleep.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 3416f69..811ed89 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -26,6 +26,25 @@ struct wiimote_data {
 	struct input_dev *input;
 };
 
+static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
+								size_t count)
+{
+	__u8 *buf;
+	ssize_t ret;
+
+	if (!hdev->hid_output_raw_report)
+		return -ENODEV;
+
+	buf = kmemdup(buffer, count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hdev->hid_output_raw_report(hdev, buf, count, HID_OUTPUT_REPORT);
+
+	kfree(buf);
+	return ret;
+}
+
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
-- 
1.7.5.2

