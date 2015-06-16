From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: rmi: Disable populating F30 when the touchpad has physical buttons
Date: Tue, 16 Jun 2015 14:08:41 -0700
Message-ID: <1434488921-11839-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:5094 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753244AbbFPVIx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 17:08:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>

Physical buttons do not use F30 to report their state and in some cases the
data reported in F30 is incorrect and inconsistent with what is reported by
the HID descriptor. When physical buttons are present, ignore F30 and let
hid-input report buttons based on what is defined in the HID descriptor.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hid-rmi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 368ffdf..721f7f9 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -1013,6 +1013,7 @@ static int rmi_populate_f30(struct hid_device *hdev)
 
 static int rmi_populate(struct hid_device *hdev)
 {
+	struct rmi_data *data = hid_get_drvdata(hdev);
 	int ret;
 
 	ret = rmi_scan_pdt(hdev);
@@ -1033,9 +1034,11 @@ static int rmi_populate(struct hid_device *hdev)
 		return ret;
 	}
 
-	ret = rmi_populate_f30(hdev);
-	if (ret)
-		hid_warn(hdev, "Error while initializing F30 (%d).\n", ret);
+	if (!(data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)) {
+		ret = rmi_populate_f30(hdev);
+		if (ret)
+			hid_warn(hdev, "Error while initializing F30 (%d).\n", ret);
+	}
 
 	return 0;
 }
-- 
2.1.4

