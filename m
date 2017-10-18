From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: rmi: Check that a device is a RMI device before calling RMI functions
Date: Tue, 17 Oct 2017 18:37:36 -0700
Message-ID: <1508290656-18871-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com ([104.47.32.62]:37546
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756726AbdJRBh6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 17 Oct 2017 21:37:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hendrik Langer <hendrik.langer@gmx.de>

The hid-rmi driver may handle non rmi devices on composite USB devices.
Callbacks need to make sure that the current device is a RMI device before
calling RMI specific functions. Most callbacks already have this check, but
this patch adds checks to the remaining callbacks.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
This is the patch which hopefully will address the X1 tablet dock freeze:
http://www.spinics.net/lists/linux-input/msg53582.html

I was not able to test on a composite USB device so I have not tested confirmed
this will fix the reported issues. But, based on the description I think it will.
I also added a check for rmi_raw_event() since it could be possible that another
hid device using one of the same report IDs as an RMI device could result in calling
into unitialized RMI functions. It was also the only callbacl left not checking the
RMI_DEVICE flag. I wonder if this explains the attach crash.

Anyway, I would appriciate it if Hendrik or someone else with the device could test this
patch to confirm it fixes the reported behavior.

Thanks,
Andrew

 drivers/hid/hid-rmi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 5b40c26..d987e02 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -368,6 +368,11 @@ static int rmi_check_sanity(struct hid_device *hdev, u8 *data, int size)
 static int rmi_raw_event(struct hid_device *hdev,
 		struct hid_report *report, u8 *data, int size)
 {
+	struct rmi_data *hdata = hid_get_drvdata(hdev);
+
+	if (!(hdata->device_flags & RMI_DEVICE))
+		return 0;
+
 	size = rmi_check_sanity(hdev, data, size);
 	if (size < 2)
 		return 0;
@@ -706,9 +711,11 @@ static void rmi_remove(struct hid_device *hdev)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
 
-	clear_bit(RMI_STARTED, &hdata->flags);
-	cancel_work_sync(&hdata->reset_work);
-	rmi_unregister_transport_device(&hdata->xport);
+	if (hdata->device_flags & RMI_DEVICE) {
+		clear_bit(RMI_STARTED, &hdata->flags);
+		cancel_work_sync(&hdata->reset_work);
+		rmi_unregister_transport_device(&hdata->xport);
+	}
 
 	hid_hw_stop(hdev);
 }
-- 
2.7.4

