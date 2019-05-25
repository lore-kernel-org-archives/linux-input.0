From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices
Date: Sat, 25 May 2019 22:09:08 +0800
Message-ID: <20190525140908.2804-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

We should return 'retval' as the correct return value
instead of always zero.

Fixes: 74808f9115ce ("HID: logitech-dj: add support for non unifying receivers")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hid/hid-logitech-dj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 41baa4dbbfcc..7f8db602eec0 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1133,7 +1133,7 @@ static int logi_dj_recv_query_hidpp_devices(struct dj_receiver_dev *djrcv_dev)
 				    HID_REQ_SET_REPORT);
 
 	kfree(hidpp_report);
-	return 0;
+	return retval;
 }
 
 static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
-- 
2.17.1
