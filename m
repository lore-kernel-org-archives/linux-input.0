From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 10/10] HID: lenovo-tpkbd: fix leak if tpkbd_probe_tp fails
Date: Wed, 11 Sep 2013 21:56:59 +0200
Message-ID: <1378929419-6269-11-git-send-email-benjamin.tissoires@redhat.com>
References: <1378929419-6269-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378929419-6269-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Kees Cook <keescook@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If tpkbd_probe_tp() bails out, the probe() function return an error,
but hid_hw_stop() is never called.

fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1003998

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
v3:
 - new patch

 drivers/hid/hid-lenovo-tpkbd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-lenovo-tpkbd.c b/drivers/hid/hid-lenovo-tpkbd.c
index 762d988..31cf29a 100644
--- a/drivers/hid/hid-lenovo-tpkbd.c
+++ b/drivers/hid/hid-lenovo-tpkbd.c
@@ -414,22 +414,27 @@ static int tpkbd_probe(struct hid_device *hdev,
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "hid_parse failed\n");
-		goto err_free;
+		goto err;
 	}
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "hid_hw_start failed\n");
-		goto err_free;
+		goto err;
 	}
 
 	uhdev = (struct usbhid_device *) hdev->driver_data;
 
-	if (uhdev->ifnum == 1)
-		return tpkbd_probe_tp(hdev);
+	if (uhdev->ifnum == 1) {
+		ret = tpkbd_probe_tp(hdev);
+		if (ret)
+			goto err_hid;
+	}
 
 	return 0;
-err_free:
+err_hid:
+	hid_hw_stop(hdev);
+err:
 	return ret;
 }
 
-- 
1.8.3.1
