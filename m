From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 08/18] HID: Adjust five checks for null pointers
Date: Tue, 7 Feb 2017 20:50:24 +0100
Message-ID: <8dbffcc9-34e2-5e1d-e4f5-342786f91c53@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 7 Feb 2017 19:15:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script "checkpatch.pl" pointed information out like the following.

Comparison to NULL could be written !…

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1f75c1c022f0..f4ea3590954c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -959,7 +959,7 @@ int hid_open_report(struct hid_device *device)
 	size = device->dev_rsize;
 
 	buf = kmemdup(start, size, GFP_KERNEL);
-	if (buf == NULL)
+	if (!buf)
 		return -ENOMEM;
 
 	if (device->driver->report_fixup)
@@ -969,7 +969,7 @@ int hid_open_report(struct hid_device *device)
 
 	start = kmemdup(start, size, GFP_KERNEL);
 	kfree(buf);
-	if (start == NULL)
+	if (!start)
 		return -ENOMEM;
 
 	device->rdesc = start;
@@ -1414,7 +1414,7 @@ static struct hid_report *hid_get_report(struct hid_report_enum *report_enum,
 		n = *data;
 
 	report = report_enum->report_id_hash[n];
-	if (report == NULL)
+	if (!report)
 		dbg_hid("undefined report_id %u received\n", n);
 
 	return report;
@@ -2222,7 +2222,7 @@ static int hid_device_probe(struct device *dev)
 
 	if (!hdev->driver) {
 		id = hid_match_device(hdev, hdrv);
-		if (id == NULL) {
+		if (!id) {
 			ret = -ENODEV;
 			goto unlock;
 		}
@@ -2719,7 +2719,7 @@ struct hid_device *hid_allocate_device(void)
 	int ret = -ENOMEM;
 
 	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
-	if (hdev == NULL)
+	if (!hdev)
 		return ERR_PTR(ret);
 
 	device_initialize(&hdev->dev);
-- 
2.11.1
