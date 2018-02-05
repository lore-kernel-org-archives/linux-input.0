From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] HID: logitech-dj: Improve a size determination in four
 functions
Date: Mon, 5 Feb 2018 22:27:24 +0100
Message-ID: <59f8d1c6-c282-b521-9472-990038862052@users.sourceforge.net>
References: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 21:47:45 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-logitech-dj.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 4c92b2cb5768..0da00d256ca7 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -417,7 +417,7 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 	snprintf(tmpstr, sizeof(tmpstr), ":%d", dj_report->device_index);
 	strlcat(dj_hiddev->phys, tmpstr, sizeof(dj_hiddev->phys));
 
-	dj_dev = kzalloc(sizeof(struct dj_device), GFP_KERNEL);
+	dj_dev = kzalloc(sizeof(*dj_dev), GFP_KERNEL);
 	if (!dj_dev)
 		goto dj_device_allocate_fail;
 
@@ -611,7 +611,7 @@ static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
 	if (djrcv_dev->querying_devices)
 		return 0;
 
-	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
+	dj_report = kzalloc(sizeof(*dj_report), GFP_KERNEL);
 	if (!dj_report)
 		return -ENOMEM;
 	dj_report->report_id = REPORT_ID_DJ_SHORT;
@@ -627,11 +627,10 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 					  unsigned timeout)
 {
 	struct hid_device *hdev = djrcv_dev->hdev;
-	struct dj_report *dj_report;
 	u8 *buf;
 	int retval;
+	struct dj_report *dj_report = kzalloc(sizeof(*dj_report), GFP_KERNEL);
 
-	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
 	if (!dj_report)
 		return -ENOMEM;
 	dj_report->report_id = REPORT_ID_DJ_SHORT;
@@ -1005,8 +1004,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 	}
 
 	/* Treat interface 2 */
-
-	djrcv_dev = kzalloc(sizeof(struct dj_receiver_dev), GFP_KERNEL);
+	djrcv_dev = kzalloc(sizeof(*djrcv_dev), GFP_KERNEL);
 	if (!djrcv_dev)
 		return -ENOMEM;
 
-- 
2.16.1

