From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH] drivers: hid: Add a module description line to the hid_hyperv driver
Date: Thu, 30 May 2019 13:37:20 -0400
Message-ID: <20190530173720.17994-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Joseph Salisbury <Joseph.Salisbury@microsoft.com>

This patch only adds a MODULE_DESCRIPTION statement to the driver.
This change is only cosmetic, so there should be no runtime impact.

Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-hyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 704049e62d58a..d3311d714d359 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -614,5 +614,7 @@ static void __exit mousevsc_exit(void)
 }
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic HID Driver");
+
 module_init(mousevsc_init);
 module_exit(mousevsc_exit);
-- 
2.20.1
