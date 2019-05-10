From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] Input: apanel: avoid panic if ioreamp fails
Date: Fri, 10 May 2019 11:03:18 +0800
Message-ID: <20190510030320.109154-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
List-Id: linux-input@vger.kernel.org

If ioremap fails, NULL pointer dereference will happen and
leading to a kernel panic when access the virtual address
in check_signature().

Fix it by check the return value of ioremap.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/input/misc/apanel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index c1e66f45d552..1c7262ad4b5b 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -259,7 +259,9 @@ static int __init apanel_init(void)
 	unsigned char i2c_addr;
 	int found = 0;
 
-	bios = ioremap(0xF0000, 0x10000); /* Can't fail */
+	bios = ioremap(0xF0000, 0x10000);
+	if (!bios)
+		return -ENOMEM;
 
 	p = bios_signature(bios);
 	if (!p) {
-- 
2.20.1
