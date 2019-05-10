From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/3] Input: wistron_btns: avoid panic if ioreamp fails
Date: Fri, 10 May 2019 11:03:19 +0800
Message-ID: <20190510030320.109154-2-wangkefeng.wang@huawei.com>
References: <20190510030320.109154-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510030320.109154-1-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Miloslav Trmac <mitr@volny.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
List-Id: linux-input@vger.kernel.org

If ioremap fails, NULL pointer dereference will happen and
leading to a kernel panic when access the virtual address
in check_signature().

Fix it by check the return value of ioremap.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miloslav Trmac <mitr@volny.cz>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-input@vger.kernel.org
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/input/misc/wistron_btns.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 43e67f546366..a82ec3d102b4 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -107,7 +107,10 @@ static int __init map_bios(void)
 	ssize_t offset;
 	u32 entry_point;
 
-	base = ioremap(0xF0000, 0x10000); /* Can't fail */
+	base = ioremap(0xF0000, 0x10000);
+	if (!base)
+		return -ENOMEM;
+
 	offset = locate_wistron_bios(base);
 	if (offset < 0) {
 		printk(KERN_ERR "wistron_btns: BIOS entry point not found\n");
-- 
2.20.1
