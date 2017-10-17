From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: hid-logitech: remove redundant assignment to pointer value
Date: Tue, 17 Oct 2017 15:31:51 +0100
Message-ID: <20171017143151.23056-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer value is being assigned a value and this is never read,
and later on it is being assigned a new value.  This the first
assignment is redundant and can be removed and hence also the variables
report and report_list.  Cleans up the clang warning: Value stored to
'value' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-lg4ff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 1fc12e357035..512d67e1aae3 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -474,9 +474,7 @@ static int lg4ff_play(struct input_dev *dev, void *data, struct ff_effect *effec
 static void lg4ff_set_autocenter_default(struct input_dev *dev, u16 magnitude)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
-	struct list_head *report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	struct hid_report *report = list_entry(report_list->next, struct hid_report, list);
-	s32 *value = report->field[0]->value;
+	s32 *value;
 	u32 expand_a, expand_b;
 	struct lg4ff_device_entry *entry;
 	struct lg_drv_data *drv_data;
-- 
2.14.1
