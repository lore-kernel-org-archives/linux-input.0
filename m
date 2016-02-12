From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6/6] HID: wacom: close the wireless receiver on remove()
Date: Fri, 12 Feb 2016 17:27:45 +0100
Message-ID: <1455294465-13694-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

rmmod/insmod the wacom.ko module does not work for the receiver because
it was not previously closed. Now, we can hack with the wireless receiver
without having to unplug/replug it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 9a41035..68a5609 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1853,6 +1853,11 @@ fail_parse:
 static void wacom_remove(struct hid_device *hdev)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
+
+	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
+		hid_hw_close(hdev);
 
 	hid_hw_stop(hdev);
 
-- 
2.5.0
