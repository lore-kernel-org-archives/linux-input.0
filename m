From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] Input: ims-pcu - fix typo in an error log
Date: Fri, 24 Nov 2017 14:59:32 +0800
Message-ID: <1511506772-21412-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: linux-input@vger.kernel.org

Tiny typo fixed in an error log.

I found this when I backported the CVE-2017-16645 patch:
ea04efee7635 ("Input: ims-psu - check if CDC union descriptor is sane")

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index ae47312..253ae8e 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1651,7 +1651,7 @@ static void ims_pcu_buffers_free(struct ims_pcu *pcu)
 				return union_desc;

 			dev_err(&intf->dev,
-				"Union descriptor to short (%d vs %zd\n)",
+				"Union descriptor too short (%d vs %zd\n)",
 				union_desc->bLength, sizeof(*union_desc));
 			return NULL;
 		}
--
1.8.3
