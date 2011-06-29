From: djkurtz@chromium.org
Subject: [PATCH 03/12] Input: synaptics - fix minimum reported ABS_TOOL_WIDTH
Date: Wed, 29 Jun 2011 13:07:13 +0800
Message-ID: <1309324042-22943-4-git-send-email-djkurtz@chromium.org>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, chase.douglas@canonical.com, rubini@cvml.unipv.it
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

From: Daniel Kurtz <djkurtz@chromium.org>

Synaptics touchpads report a 'w' value in each data report.
For touchpads that support palm detection, when there is a single finger
on the pad, the 'w' value reports its width in the range 4 to 15.
Thus, the minimum valid width is 4.

Note: Other values of 'w' are used to report special conditions:
 w=0: 2 fingers are on the pad
 w=1: 3 or more fingers are on the pad
 w=2: the packet contains "Advanced Gesture Mode" data.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/mouse/synaptics.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f6d0c04..a4b7801 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -706,7 +706,7 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	}
 
 	if (SYN_CAP_PALMDETECT(priv->capabilities))
-		input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
+		input_set_abs_params(dev, ABS_TOOL_WIDTH, 4, 15, 0, 0);
 
 	__set_bit(EV_KEY, dev->evbit);
 	__set_bit(BTN_TOUCH, dev->keybit);
-- 
1.7.3.1
