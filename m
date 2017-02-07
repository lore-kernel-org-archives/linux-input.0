From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] HID: hid-mf: convert list_for_each to entry variant
Date: Tue,  7 Feb 2017 15:52:18 +0000
Message-ID: <20170207155218.3296-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34951 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754564AbdBGPwY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Feb 2017 10:52:24 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so9565959pfa.2
        for <linux-input@vger.kernel.org>; Tue, 07 Feb 2017 07:52:24 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Marcel Hasler <mahasler@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

convert list_for_each() to list_for_each_entry() where
applicable.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/hid/hid-mf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hid/hid-mf.c b/drivers/hid/hid-mf.c
index 03f1051..572e378 100644
--- a/drivers/hid/hid-mf.c
+++ b/drivers/hid/hid-mf.c
@@ -68,8 +68,6 @@ static int mf_init(struct hid_device *hid)
 
 	struct list_head *report_list =
 			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-
-	struct list_head *report_ptr;
 	struct hid_report *report;
 
 	struct list_head *input_ptr = &hid->inputs;
@@ -80,9 +78,7 @@ static int mf_init(struct hid_device *hid)
 	int error;
 
 	/* Setup each of the four inputs */
-	list_for_each(report_ptr, report_list) {
-		report = list_entry(report_ptr, struct hid_report, list);
-
+	list_for_each_entry(report, report_list, list) {
 		if (report->maxfield < 1 || report->field[0]->report_count < 2) {
 			hid_err(hid, "Invalid report, this should never happen!\n");
 			return -ENODEV;

