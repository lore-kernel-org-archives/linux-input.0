From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 24/26] Input: synaptics-rmi4: use device managed memory for the data packet buffer
Date: Thu, 5 Nov 2015 15:42:53 -0800
Message-ID: <1446766973-31304-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

The data packet should use device managed memory since the buffer is
retained until the device goes away.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f11.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index ee4b155..10a0c11 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -683,7 +683,8 @@ static int f11_2d_construct_data(struct f11_data *f11)
 		sensor->pkt_size +=
 			DIV_ROUND_UP(query->nr_touch_shapes + 1, 8);
 
-	sensor->data_pkt = kzalloc(sensor->pkt_size, GFP_KERNEL);
+	sensor->data_pkt = devm_kzalloc(&sensor->fn->dev, sensor->pkt_size,
+					GFP_KERNEL);
 	if (!sensor->data_pkt)
 		return -ENOMEM;
 
-- 
2.1.4
