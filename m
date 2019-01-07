From: Donghoon Han <nazgul33@gmail.com>
Subject: [PATCH V2 1/2] Input: rotary_encoder - Support key events
Date: Tue,  8 Jan 2019 01:42:48 +0900
Message-ID: <20190107164249.2342-2-nazgul33@gmail.com>
References: <20190107164249.2342-1-nazgul33@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107164249.2342-1-nazgul33@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, Steven Han <nazgul33@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Steven Han <nazgul33@gmail.com>

Support generating EV_KEY pair, instead of EV_REL.

Signed-off-by: Donghoon Han <nazgul33@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>
To: linux-input@vger.kernel.org
---
V2: added missing input_sync()
---
 drivers/input/misc/rotary_encoder.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 72eee6d55527..0014a7d9f8f9 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -41,6 +41,8 @@ struct rotary_encoder {
 	u32 steps;
 	u32 axis;
 	bool relative_axis;
+	bool relative_keys;
+	u32 keycodes[2];
 	bool rollover;
 	enum rotary_encoder_encoding encoding;
 
@@ -79,6 +81,11 @@ static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 	if (encoder->relative_axis) {
 		input_report_rel(encoder->input,
 				 encoder->axis, encoder->dir);
+	} else if (encoder->relative_keys) {
+		u32 keycode = encoder->keycodes[encoder->dir > 0];
+		input_event(encoder->input, EV_KEY, keycode, 1);
+		input_sync(encoder->input);
+		input_event(encoder->input, EV_KEY, keycode, 0);
 	} else {
 		unsigned int pos = encoder->pos;
 
@@ -237,6 +244,16 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	device_property_read_u32(dev, "linux,axis", &encoder->axis);
 	encoder->relative_axis =
 		device_property_read_bool(dev, "rotary-encoder,relative-axis");
+	encoder->relative_keys =
+		device_property_read_bool(dev, "rotary-encoder,relative-keys");
+	if (encoder->relative_keys) {
+		err = device_property_read_u32_array(dev,
+					"rotary-encoder,relative-keycodes",
+					encoder->keycodes, 2);
+		if (err)
+			dev_err(dev, "unable to get keycodes: %d\n", err);
+		return err;
+	}
 
 	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
 	if (IS_ERR(encoder->gpios)) {
@@ -260,9 +277,12 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	input->id.bustype = BUS_HOST;
 	input->dev.parent = dev;
 
-	if (encoder->relative_axis)
+	if (encoder->relative_axis) {
 		input_set_capability(input, EV_REL, encoder->axis);
-	else
+	} else if (encoder->relative_keys) {
+		input_set_capability(input, EV_KEY, encoder->keycodes[0]);
+		input_set_capability(input, EV_KEY, encoder->keycodes[1]);
+	} else
 		input_set_abs_params(input,
 				     encoder->axis, 0, encoder->steps, 0, 1);
 
-- 
2.17.1
