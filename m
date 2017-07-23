From: Lyude <lyude@redhat.com>
Subject: [PATCH] HID: rmi: Make sure the HID device is opened on resume
Date: Sat, 22 Jul 2017 21:15:09 -0400
Message-ID: <20170723011509.23651-1-lyude@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbdGWBPi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 22 Jul 2017 21:15:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Lyude <lyude@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, stable@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org

So it looks like that suspend/resume has actually always been broken on
hid-rmi. The fact it worked was a rather silly coincidence that was
relying on the HID device to already be opened upon resume. This means
that so long as anything was reading the /dev/input/eventX node for for
an RMI device, it would suspend and resume correctly. As well, if
nothing happened to be keeping the HID device away it would shut off,
then the RMI driver would get confused on resume when it stopped
responding and explode.

So, call hid_hw_open() in rmi_post_resume() so we make sure that the
device is alive before we try talking to it.

This fixes RMI device suspend/resume over HID.

Signed-off-by: Lyude <lyude@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>
Cc: stable@vger.kernel.org
---
 drivers/hid/hid-rmi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 5b40c2614599..e7d124f9a27f 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -431,22 +431,29 @@ static int rmi_post_resume(struct hid_device *hdev)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
 	struct rmi_device *rmi_dev = data->xport.rmi_dev;
-	int ret;
+	int ret = 0;
 
 	if (!(data->device_flags & RMI_DEVICE))
 		return 0;
 
-	ret = rmi_reset_attn_mode(hdev);
+	/* Make sure the HID device is ready to receive events */
+	ret = hid_hw_open(hdev);
 	if (ret)
 		return ret;
 
+	ret = rmi_reset_attn_mode(hdev);
+	if (ret)
+		goto out;
+
 	ret = rmi_driver_resume(rmi_dev, false);
 	if (ret) {
 		hid_warn(hdev, "Failed to resume device: %d\n", ret);
-		return ret;
+		goto out;
 	}
 
-	return 0;
+out:
+	hid_hw_close(hdev);
+	return ret;
 }
 #endif /* CONFIG_PM */
 
-- 
2.13.3

