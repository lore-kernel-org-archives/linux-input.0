From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Always increment hdev refcount within wacom_get_hdev_data
Date: Mon, 18 Sep 2017 09:27:42 -0700
Message-ID: <20170918162742.10717-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36381 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756025AbdIRQ2O (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Sep 2017 12:28:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

The wacom_get_hdev_data function is used to find and return a reference to
the "other half" of a Wacom device (i.e., the touch device associated with
a pen, or vice-versa). To ensure these references are properly accounted
for, the function is supposed to automatically increment the refcount before
returning. This was not done, however, for devices which have pen & touch
on different interfaces of the same USB device. This can lead to a WARNING
("refcount_t: underflow; use-after-free") when removing the module or device
as we call kref_put() more times than kref_get(). Triggering an "actual" use-
after-free would be difficult since both devices will disappear nearly-
simultaneously. To silence this warning and prevent the potential error, we
need to increment the refcount for all cases within wacom_get_hdev_data.

Fixes: 41372d5d40 ("HID: wacom: Augment 'oVid' and 'oPid' with heuristics for HID_GENERIC")
Cc: <stable@vger.kernel.org> # v4.9+
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 735bfbbcaa82..906e654fb0ba 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -668,8 +668,10 @@ static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 
 	/* Try to find an already-probed interface from the same device */
 	list_for_each_entry(data, &wacom_udev_list, list) {
-		if (compare_device_paths(hdev, data->dev, '/'))
+		if (compare_device_paths(hdev, data->dev, '/')) {
+			kref_get(&data->kref);
 			return data;
+		}
 	}
 
 	/* Fallback to finding devices that appear to be "siblings" */
-- 
2.14.1

