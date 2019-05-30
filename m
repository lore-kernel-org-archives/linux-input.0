From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH] drivers: input: serio: Add a module desription to the hyperv_keyboard driver
Date: Thu, 30 May 2019 13:46:45 -0400
Message-ID: <20190530174645.18147-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Joseph Salisbury <Joseph.Salisbury@microsoft.com>

This patch only adds a MODULE_DESCRIPTION statement to the driver.
This change is only cosmetic, so there should be no runtime impact.

Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/hyperv-keyboard.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index a8b9be3e28db7..7935e52b54358 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -440,5 +440,7 @@ static void __exit hv_kbd_exit(void)
 }
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic Keyboard Driver");
+
 module_init(hv_kbd_init);
 module_exit(hv_kbd_exit);
-- 
2.20.1
