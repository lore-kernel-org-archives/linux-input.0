From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [PATCH] HID: uhid: use strlcpy() instead of strncpy()
Date: Tue, 9 Jan 2018 20:23:32 +0800
Message-ID: <1515500612-191425-1-git-send-email-wangxiongfeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:39864 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751642AbeAIMSK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 9 Jan 2018 07:18:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@redhat.com, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com

From: Xiongfeng Wang <xiongfeng.wang@linaro.org>

gcc-8 reports

drivers/hid/uhid.c: In function 'uhid_dev_create2':
./include/linux/string.h:245:9: warning: '__builtin_strncpy' output may
be truncated copying 127 bytes from a string of length 127
[-Wstringop-truncation]

The compiler require that the input param 'len' of strncpy() should be
greater than the length of the src string, so that '\0' is copied as
well. We can just use strlcpy() to avoid this warning.

Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
---
 drivers/hid/uhid.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 6f819f1..0315ddd 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -496,12 +496,12 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 		goto err_free;
 	}
 
-	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
-	strncpy(hid->name, ev->u.create2.name, len);
-	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
-	strncpy(hid->phys, ev->u.create2.phys, len);
-	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
-	strncpy(hid->uniq, ev->u.create2.uniq, len);
+	len = min(sizeof(hid->name), sizeof(ev->u.create2.name));
+	strlcpy(hid->name, ev->u.create2.name, len);
+	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys));
+	strlcpy(hid->phys, ev->u.create2.phys, len);
+	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq));
+	strlcpy(hid->uniq, ev->u.create2.uniq, len);
 
 	hid->ll_driver = &uhid_hid_driver;
 	hid->bus = ev->u.create2.bus;
-- 
1.8.3.1

