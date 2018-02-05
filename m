From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] HID: logitech-dj: Delete an error message for a failed
 memory allocation in two functions
Date: Mon, 5 Feb 2018 22:26:16 +0100
Message-ID: <8c8c6986-9f72-4dfd-12f6-a530c4788398@users.sourceforge.net>
References: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 21:36:18 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-logitech-dj.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 826fa1e1c8d9..4c92b2cb5768 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -418,12 +418,8 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 	strlcat(dj_hiddev->phys, tmpstr, sizeof(dj_hiddev->phys));
 
 	dj_dev = kzalloc(sizeof(struct dj_device), GFP_KERNEL);
-
-	if (!dj_dev) {
-		dev_err(&djrcv_hdev->dev, "%s: failed allocating dj_device\n",
-			__func__);
+	if (!dj_dev)
 		goto dj_device_allocate_fail;
-	}
 
 	dj_dev->reports_supported = get_unaligned_le32(
 		dj_report->report_params + DEVICE_PAIRED_RF_REPORT_TYPE);
@@ -1011,11 +1007,9 @@ static int logi_dj_probe(struct hid_device *hdev,
 	/* Treat interface 2 */
 
 	djrcv_dev = kzalloc(sizeof(struct dj_receiver_dev), GFP_KERNEL);
-	if (!djrcv_dev) {
-		dev_err(&hdev->dev,
-			"%s:failed allocating dj_receiver_dev\n", __func__);
+	if (!djrcv_dev)
 		return -ENOMEM;
-	}
+
 	djrcv_dev->hdev = hdev;
 	INIT_WORK(&djrcv_dev->work, delayedwork_callback);
 	spin_lock_init(&djrcv_dev->lock);
-- 
2.16.1
