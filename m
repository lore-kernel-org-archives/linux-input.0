From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] Input: rotary_encoder - use input_set_capability()
Date: Mon, 18 Jan 2016 09:41:41 -0800
Message-ID: <1453138902-11657-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>, Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of manipulating capability bits directly let's use appropriate
helpers. Also there is no need to explicitly set EV_ABS when calling
input_set_abs_params().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/rotary_encoder.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index e913bfb64..1882e65 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -318,14 +318,10 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	input->id.bustype = BUS_HOST;
 	input->dev.parent = dev;
 
-	if (pdata->relative_axis) {
-		input->evbit[0] = BIT_MASK(EV_REL);
-		input->relbit[0] = BIT_MASK(pdata->axis);
-	} else {
-		input->evbit[0] = BIT_MASK(EV_ABS);
-		input_set_abs_params(encoder->input,
-				     pdata->axis, 0, pdata->steps, 0, 1);
-	}
+	if (pdata->relative_axis)
+		input_set_capability(input, EV_REL, pdata->axis);
+	else
+		input_set_abs_params(input, pdata->axis, 0, pdata->steps, 0, 1);
 
 	switch (pdata->steps_per_period) {
 	case 4:
-- 
2.6.0.rc2.230.g3dd15c0
