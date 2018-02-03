From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-rmi: Delete an error message for a failed memory
 allocation in rmi_probe()
Date: Sat, 3 Feb 2018 13:48:25 +0100
Message-ID: <07a48fd9-de27-52d5-7a53-8eb1de4de14b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:65050 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbeBCMsh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 3 Feb 2018 07:48:37 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 13:42:08 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-rmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 0f43c4292685..d92a17954b67 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -678,10 +678,8 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	alloc_size = data->output_report_size + data->input_report_size;
 
 	data->writeReport = devm_kzalloc(&hdev->dev, alloc_size, GFP_KERNEL);
-	if (!data->writeReport) {
-		hid_err(hdev, "failed to allocate buffer for HID reports\n");
+	if (!data->writeReport)
 		return -ENOMEM;
-	}
 
 	data->readReport = data->writeReport + data->output_report_size;
 
-- 
2.16.1

