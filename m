From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 2/2] HID: input: optionally use device id in battery name
Date: Tue,  1 Aug 2017 15:38:02 -0700
Message-ID: <20170801223802.30521-2-dmitry.torokhov@gmail.com>
References: <20170801223802.30521-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801223802.30521-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Manufacturers do not always populate serial number in their devices, so
let's fall back to device ID when forming the battery device name. As a
result, batteries in devices without serial number will be named like
this:

	hid-0018:2D1F:510E.0001-battery

(as opposed to hid--battery for the first one, and failing to create
batteries for the subsequent ones).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2158ec766dd5..27d8442b017d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -456,7 +456,9 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (!psy_desc)
 		return -ENOMEM;
 
-	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery", dev->uniq);
+	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
+				   strlen(dev->uniq) ?
+					dev->uniq : dev_name(&dev->dev));
 	if (!psy_desc->name) {
 		error = -ENOMEM;
 		goto err_free_mem;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
