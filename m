From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 3/5] input: touchscreen: edt-ft5x06: Add support for softbuttons
Date: Sun, 11 Sep 2016 20:44:06 +0200
Message-ID: <20160911184408.11657-4-hdegoede@redhat.com>
References: <20160911184408.11657-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932232AbcIKSoU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Sep 2016 14:44:20 -0400
In-Reply-To: <20160911184408.11657-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Add support for softbuttons to the edt-ft5x06 driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 28466e3..481d8ba 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -86,6 +86,7 @@ struct edt_reg_addr {
 struct edt_ft5x06_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input;
+	struct touchscreen_softbutton_info *buttons;
 	struct touchscreen_properties prop;
 	u16 num_x;
 	u16 num_y;
@@ -241,6 +242,9 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 		id = (buf[2] >> 4) & 0x0f;
 		down = type != TOUCH_EVENT_UP;
 
+		if (touchscreen_handle_softbuttons(tsdata->buttons, x, y, down))
+			continue;
+
 		input_mt_slot(tsdata->input, id);
 		input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
 
@@ -975,6 +979,10 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	touchscreen_parse_properties(input, true, &tsdata->prop);
 
+	tsdata->buttons = devm_touchscreen_alloc_softbuttons(input);
+	if (IS_ERR(tsdata->buttons))
+		return PTR_ERR(tsdata->buttons);
+
 	error = input_mt_init_slots(input, tsdata->max_support_points,
 				INPUT_MT_DIRECT);
 	if (error) {
-- 
2.9.3

