From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] HID: logitech-dj: Fix check of logi_dj_recv_query_paired_devices()
Date: Thu, 25 Jul 2019 22:57:19 +0800
Message-ID: <20190725145719.8344-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

In delayedwork_callback(), logi_dj_recv_query_paired_devices
may return positive value while success now, so check it
correctly.

Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hid/hid-logitech-dj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 8cdf373..bf6b289 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -793,7 +793,7 @@ static void delayedwork_callback(struct work_struct *work)
 		break;
 	case WORKITEM_TYPE_UNKNOWN:
 		retval = logi_dj_recv_query_paired_devices(djrcv_dev);
-		if (retval) {
+		if (retval < 0) {
 			hid_err(djrcv_dev->hidpp, "%s: logi_dj_recv_query_paired_devices error: %d\n",
 				__func__, retval);
 		}
-- 
2.7.4
