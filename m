From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 1/3] HID: logitech-hidpp: use devres to manage FF private data
Date: Sun,  6 Oct 2019 22:12:38 -0700
Message-ID: <20191007051240.4410-2-andrew.smirnov@gmail.com>
References: <20191007051240.4410-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191007051240.4410-1-andrew.smirnov@gmail.com>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, Sam Bazely <sambazley@fastmail.com>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Austin Palmer <austinp@valvesoftware.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

To simplify resource management in commit that follows as well as to
save a couple of extra kfree()s and simplify hidpp_ff_deinit() switch
driver code to use devres to manage the life-cycle of FF private data.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: Sam Bazely <sambazley@fastmail.com>
Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Cc: Austin Palmer <austinp@valvesoftware.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 drivers/hid/hid-logitech-hidpp.c | 53 +++++++++++++++++---------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0179f7ed77e5..58eb928224e5 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2079,6 +2079,11 @@ static void hidpp_ff_destroy(struct ff_device *ff)
 	struct hidpp_ff_private_data *data = ff->private;
 
 	kfree(data->effect_ids);
+	/*
+	 * Set private to NULL to prevent input_ff_destroy() from
+	 * freeing our devres allocated memory
+	 */
+	ff->private = NULL;
 }
 
 static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
@@ -2090,7 +2095,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	const u16 bcdDevice = le16_to_cpu(udesc->bcdDevice);
 	struct ff_device *ff;
 	struct hidpp_report response;
-	struct hidpp_ff_private_data *data;
+	struct hidpp_ff_private_data *data = hidpp->private_data;
 	int error, j, num_slots;
 	u8 version;
 
@@ -2129,18 +2134,13 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 		return error;
 	}
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
 	data->effect_ids = kcalloc(num_slots, sizeof(int), GFP_KERNEL);
-	if (!data->effect_ids) {
-		kfree(data);
+	if (!data->effect_ids)
 		return -ENOMEM;
-	}
+
 	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
 	if (!data->wq) {
 		kfree(data->effect_ids);
-		kfree(data);
 		return -ENOMEM;
 	}
 
@@ -2199,28 +2199,15 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 	return 0;
 }
 
-static int hidpp_ff_deinit(struct hid_device *hid)
+static void hidpp_ff_deinit(struct hid_device *hid)
 {
-	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
-	struct input_dev *dev = hidinput->input;
-	struct hidpp_ff_private_data *data;
-
-	if (!dev) {
-		hid_err(hid, "Struct input_dev not found!\n");
-		return -EINVAL;
-	}
+	struct hidpp_device *hidpp = hid_get_drvdata(hid);
+	struct hidpp_ff_private_data *data = hidpp->private_data;
 
 	hid_info(hid, "Unloading HID++ force feedback.\n");
-	data = dev->ff->private;
-	if (!data) {
-		hid_err(hid, "Private data not found!\n");
-		return -EINVAL;
-	}
 
 	destroy_workqueue(data->wq);
 	device_remove_file(&hid->dev, &dev_attr_range);
-
-	return 0;
 }
 
 
@@ -2725,6 +2712,20 @@ static int k400_connect(struct hid_device *hdev, bool connected)
 
 #define HIDPP_PAGE_G920_FORCE_FEEDBACK			0x8123
 
+static int g920_allocate(struct hid_device *hdev)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct hidpp_ff_private_data *data;
+
+	data = devm_kzalloc(&hdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	hidpp->private_data = data;
+
+	return 0;
+}
+
 static int g920_get_config(struct hidpp_device *hidpp)
 {
 	u8 feature_type;
@@ -3561,6 +3562,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		ret = k400_allocate(hdev);
 		if (ret)
 			return ret;
+	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+		ret = g920_allocate(hdev);
+		if (ret)
+			return ret;
 	}
 
 	INIT_WORK(&hidpp->work, delayed_work_cb);
-- 
2.21.0
