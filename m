From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/4] HID: wacom: remove warning while disconnecting devices
Date: Fri, 20 Jan 2017 16:20:12 +0100
Message-ID: <20170120152014.19775-3-benjamin.tissoires@redhat.com>
References: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120152014.19775-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When the LED class gets removed, it actually tries to reset the LED.
However, the device being disconnected, the set_report fails.

Previously, the attempt to cut lose this last event was through unsetting
the HID drvdata, but it was not working properly. Simply reset the LED
groups to NULL makes a more efficient solution.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 734100a..4a2c88d 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -757,9 +757,6 @@ static int wacom_led_control(struct wacom *wacom)
 	unsigned char report_id = WAC_CMD_LED_CONTROL;
 	int buf_size = 9;
 
-	if (!hid_get_drvdata(wacom->hdev))
-		return -ENODEV;
-
 	if (!wacom->led.groups)
 		return -ENOTSUPP;
 
@@ -2495,6 +2492,8 @@ static void wacom_remove(struct hid_device *hdev)
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 
+	/* make sure we don't trigger the LEDs */
+	wacom_led_groups_release(wacom);
 	wacom_release_resources(wacom);
 
 	hid_set_drvdata(hdev, NULL);
-- 
2.9.3
