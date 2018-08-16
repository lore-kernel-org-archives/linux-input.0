From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 1/2] hid: microsoft: Convert private data to be a proper struct
Date: Wed, 15 Aug 2018 19:44:09 -0700
Message-ID: <20180816024410.29218-2-andrew.smirnov@gmail.com>
References: <20180816024410.29218-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180816024410.29218-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Juha Kuikka <juha.kuikka@gmail.com>
List-Id: linux-input@vger.kernel.org

In order to be able to have more than just an unsigned long worth of
private data, convert the code to allocate and use a dedicated struct.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/hid/hid-microsoft.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 96e7d3231d2f..f8868d96c0c7 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -29,10 +29,15 @@
 #define MS_NOGET		0x10
 #define MS_DUPLICATE_USAGES	0x20
 
+struct ms_data {
+	unsigned long quirks;
+};
+
 static __u8 *ms_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	/*
 	 * Microsoft Wireless Desktop Receiver (Model 1028) has
@@ -134,7 +139,8 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	if (quirks & MS_ERGONOMY) {
 		int ret = ms_ergonomy_kb_quirk(hi, usage, bit, max);
@@ -153,7 +159,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	if (quirks & MS_DUPLICATE_USAGES)
 		clear_bit(usage->code, *bit);
@@ -164,7 +171,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 static int ms_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 	struct input_dev *input;
 
 	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
@@ -222,9 +230,16 @@ static int ms_event(struct hid_device *hdev, struct hid_field *field,
 static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	unsigned long quirks = id->driver_data;
+	struct ms_data *ms;
 	int ret;
 
-	hid_set_drvdata(hdev, (void *)quirks);
+	ms = devm_kzalloc(&hdev->dev, sizeof(*ms), GFP_KERNEL);
+	if (ms == NULL)
+		return -ENOMEM;
+
+	ms->quirks = quirks;
+
+	hid_set_drvdata(hdev, ms);
 
 	if (quirks & MS_NOGET)
 		hdev->quirks |= HID_QUIRK_NOGET;
-- 
2.17.1
