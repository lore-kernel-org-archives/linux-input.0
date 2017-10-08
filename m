From: Christos Gkekas <chris.gekas@gmail.com>
Subject: [PATCH] Input: synaptics-rmi4: Clean up redundant check
Date: Sun,  8 Oct 2017 23:26:51 +0100
Message-ID: <1507501611-16703-1-git-send-email-chris.gekas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christos Gkekas <chris.gekas@gmail.com>
List-Id: linux-input@vger.kernel.org

Variable size_presence_reg·is unsigned so checking whether it is less
than zero is redundant.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 4f2bb59..68fcb30 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -601,7 +601,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 		return ret;
 	++addr;
 
-	if (size_presence_reg < 0 || size_presence_reg > 35)
+	if (size_presence_reg > 35)
 		return -EIO;
 
 	memset(buf, 0, sizeof(buf));
-- 
2.7.4
