From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: misc: powermate: Replace GFP_ATOMIC with GFP_KERNEL in powermate_alloc_buffers()
Date: Fri, 27 Jul 2018 10:17:23 +0800
Message-ID: <20180727021723.709-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, arvind.yadav.cs@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-input@vger.kernel.org

powermate_alloc_buffers() is never called in atomic context.
It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/misc/powermate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 5c8c79623c87..e8de3aaf9f63 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -277,7 +277,7 @@ static int powermate_input_event(struct input_dev *dev, unsigned int type, unsig
 static int powermate_alloc_buffers(struct usb_device *udev, struct powermate_device *pm)
 {
 	pm->data = usb_alloc_coherent(udev, POWERMATE_PAYLOAD_SIZE_MAX,
-				      GFP_ATOMIC, &pm->data_dma);
+				      GFP_KERNEL, &pm->data_dma);
 	if (!pm->data)
 		return -1;
 
-- 
2.17.0
