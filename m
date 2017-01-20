From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/4] HID: wacom: release the resources before leaving despite devm
Date: Fri, 20 Jan 2017 16:20:11 +0100
Message-ID: <20170120152014.19775-2-benjamin.tissoires@redhat.com>
References: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In the general case, the resources are properly released by devm without
needing to do anything. However, when unplugging the wireless receiver,
the kernel segfaults from time to time while calling devres_release_all().

I think in that case the resources attempt to access hid_get_drvdata(hdev)
which has been set to null while leaving wacom_remove().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 23b272a..734100a 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2495,6 +2495,8 @@ static void wacom_remove(struct hid_device *hdev)
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 
+	wacom_release_resources(wacom);
+
 	hid_set_drvdata(hdev, NULL);
 }
 
-- 
2.9.3
