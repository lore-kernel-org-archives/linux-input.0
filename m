From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/3] HID: wacom: Fail probe if HID_GENERIC device has unknown device_type
Date: Thu, 30 Apr 2015 17:51:55 -0700
Message-ID: <1430441515-30122-3-git-send-email-killertofu@gmail.com>
References: <1430441515-30122-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430441515-30122-1-git-send-email-killertofu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

The last patch was careful to maintain backwards-compatible behavior
by forcing device_type to BTN_TOOL_PEN (and printing a warning) if it
were still uninitialized after scanning the HID descriptor and applying
quirks. We should be more strict with HID_GENERIC devices, however,
since there is no a priori guarantee that it is a tablet or touchpad.
If the device_type is still uninitialized for a HID_GENERIC device then
we assume that it isn't something the driver can work with and so fail
the probe.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 157aa7a..7abf52c 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1528,8 +1528,14 @@ static int wacom_probe(struct hid_device *hdev,
 	wacom_setup_device_quirks(wacom);
 
 	if (!features->device_type && features->type != WIRELESS) {
+		error = features->type == HID_GENERIC ? -ENODEV : 0;
+
 		dev_warn(&hdev->dev, "Unknown device_type for '%s'. %s.",
-			 hdev->name, "Assuming pen");
+			 hdev->name,
+			 error ? "Ignoring" : "Assuming pen");
+
+		if (error)
+			goto fail_shared_data;
 
 		features->device_type = BTN_TOOL_PEN;
 	}
-- 
2.3.5
