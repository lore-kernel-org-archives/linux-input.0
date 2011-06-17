From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 06/12 v2] HID: wiimote: Add wiimote send function
Date: Fri, 17 Jun 2011 16:49:16 +0200
Message-ID: <1308322162-13953-6-git-send-email-dh.herrmann@googlemail.com>
References: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50835 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759237Ab1FQOuW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2011 10:50:22 -0400
Received: by fxm17 with SMTP id 17so1796157fxm.19
        for <linux-input@vger.kernel.org>; Fri, 17 Jun 2011 07:50:20 -0700 (PDT)
In-Reply-To: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org, dh.herrmann@googlemail.com

The wiimote driver needs to send raw output reports to the wiimote
device. Otherwise we could not manage the peripherals of the wiimote
or perform memory operations on the wiimote.
We cannot use hidinput_input_event of the lowlevel hid driver, since
this does not accept raw input. Therefore, we need to use the same
function that hidraw uses to send output. Side effect is, the raw
output function is not buffered and can sleep.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V2: Allocate new buffer for every packet that is sent out to comply to DMA
constraints.

 drivers/hid/hid-wiimote.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index afae0e9..b6ae2a1 100644
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

