From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] HID: alps: fix error return code in alps_input_configured()
Date: Wed, 21 Sep 2016 15:12:05 +0000
Message-ID: <1474470725-4789-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34362 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755814AbcIUPNc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Sep 2016 11:13:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id 21so2521433pfy.1
        for <linux-input@vger.kernel.org>; Wed, 21 Sep 2016 08:12:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/hid/hid-alps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 2808da9..507372e 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -384,7 +384,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 		input2 = input_allocate_device();
 		if (!input2) {
-			input_free_device(input2);
+			ret = -ENOMEM;
 			goto exit;
 		}
 
@@ -426,7 +426,8 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		__set_bit(INPUT_PROP_POINTER, input2->propbit);
 		__set_bit(INPUT_PROP_POINTING_STICK, input2->propbit);
 
-		if (input_register_device(data->input2)) {
+		ret = input_register_device(data->input2);
+		if (ret) {
 			input_free_device(input2);
 			goto exit;
 		}



