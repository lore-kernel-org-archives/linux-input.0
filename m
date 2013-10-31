From: Kang Hu <hukangustc@gmail.com>
Subject: [PATCH 1/1] Input: remove a redundant max() call.
Date: Thu, 31 Oct 2013 15:26:34 +0800
Message-ID: <1383204394-15399-1-git-send-email-hukangustc@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kang Hu <hukangustc@gmail.com>
List-Id: linux-input@vger.kernel.org

dev->hint_events_per_packet is guaranteed to be >= packet_size.
so an extra max() call is not needed.

Signed-off-by: Kang Hu <hukangustc@gmail.com>
---
 drivers/input/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c044699..fb513da 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2048,7 +2048,7 @@ int input_register_device(struct input_dev *dev)
 	if (dev->hint_events_per_packet < packet_size)
 		dev->hint_events_per_packet = packet_size;
 
-	dev->max_vals = max(dev->hint_events_per_packet, packet_size) + 2;
+	dev->max_vals = dev->hint_events_per_packet + 2;
 	dev->vals = kcalloc(dev->max_vals, sizeof(*dev->vals), GFP_KERNEL);
 	if (!dev->vals) {
 		error = -ENOMEM;
-- 
1.8.3.1
