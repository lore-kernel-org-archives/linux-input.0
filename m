From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: rmi: Check that the device is a RMI device in suspend and resume callbacks
Date: Tue, 26 Jan 2016 15:40:36 -0800
Message-ID: <1453851636-5490-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:2655 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751905AbcAZXku (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2016 18:40:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Rodrigo Gomes <rodrigo.toste.gomes@gmail.com>

Commit 092563604217 ("HID: rmi: Disable scanning if the device is not a
wake source") introduced a regression for devices which use hid-rmi to
handle composite USB devices. The suspend or resume callbacks are not
checking that the device is a RMI device before calling rmi_read or
rmi_write. This results in dereferencing uninitialized variables on
non RMI devices. This patch checks that the RMI_DEVICE flag is set before
sending RMI commands to the device.

Reported-by: Rodrigo Gomes <rodrigo.toste.gomes@gmail.com>
Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hid-rmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 67cd059..9cd2ca3 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -594,6 +594,9 @@ static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
 	int ret;
 	u8 buf[RMI_F11_CTRL_REG_COUNT];
 
+	if (!(data->device_flags & RMI_DEVICE))
+		return 0;
+
 	ret = rmi_read_block(hdev, data->f11.control_base_addr, buf,
 				RMI_F11_CTRL_REG_COUNT);
 	if (ret)
@@ -613,6 +616,9 @@ static int rmi_post_reset(struct hid_device *hdev)
 	struct rmi_data *data = hid_get_drvdata(hdev);
 	int ret;
 
+	if (!(data->device_flags & RMI_DEVICE))
+		return 0;
+
 	ret = rmi_reset_attn_mode(hdev);
 	if (ret) {
 		hid_err(hdev, "can not set rmi mode\n");
@@ -640,6 +646,11 @@ static int rmi_post_reset(struct hid_device *hdev)
 
 static int rmi_post_resume(struct hid_device *hdev)
 {
+	struct rmi_data *data = hid_get_drvdata(hdev);
+
+	if (!(data->device_flags & RMI_DEVICE))
+		return 0;
+
 	return rmi_reset_attn_mode(hdev);
 }
 #endif /* CONFIG_PM */
-- 
2.5.0

