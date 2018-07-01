From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 2/4] HID: multitouch: don't check HID_GROUP_MULTITOUCH_WIN_8 for serial protocol
Date: Sat, 30 Jun 2018 14:19:51 -1000
Message-ID: <0aaacf083be5b68a830f9e174f9abee3b00c5a51.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org

The HID_GROUP_MULTITOUCH_WIN_8 group never needs to check for the serial
protocol, so avoid setting `td->serial_maybe = true;` in order to avoid
an unnecessary mt_post_parse_default_settings() call

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a793076139d7d0db9b..c0654db0b736543ca0 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1460,11 +1460,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!td->fields) {
 		dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
 		return -ENOMEM;
 	}
 
-	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
+	if (id->vendor == HID_ANY_ID
+			&& id->product == HID_ANY_ID
+			&& id->group != HID_GROUP_MULTITOUCH_WIN_8)
 		td->serial_maybe = true;
 
 	/* This allows the driver to correctly support devices
 	 * that emit events over several HID messages.
 	 */
-- 
2.18.0
