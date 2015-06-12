From: Dudley Du <dudl@cypress.com>
Subject: [PATCH 3/7] input: cyapa: add proximity function support for gen5 and gen6 modules
Date: Fri, 12 Jun 2015 14:56:34 +0800
Message-ID: <1434092198-13018-4-git-send-email-dudl@cypress.com>
References: <1434092198-13018-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.cypress.com ([157.95.67.100]:58018 "EHLO
	smtp1.cypress.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbFLHSU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2015 03:18:20 -0400
In-Reply-To: <1434092198-13018-1-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org, rydberg@euromail.se
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, jmmahler@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Gen5 and Gen6 trackpad devices are able to detect and report object proximity
data/events, add this function support in the cyapa driver through the
MTB protocl ABS_MT_DISTANCE event.
TEST=test on Chromebook.

Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa.c      | 19 ++++++++++++-
 drivers/input/mouse/cyapa.h      |  4 +++
 drivers/input/mouse/cyapa_gen3.c |  2 ++
 drivers/input/mouse/cyapa_gen5.c | 61 +++++++++++++++++++++++++++++++++++++++-
 drivers/input/mouse/cyapa_gen6.c | 19 +++++++++++++
 5 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index c252faf..4146ab7 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -39,6 +39,11 @@ const char product_id[] = "CYTRA";
 
 static int cyapa_reinitialize(struct cyapa *cyapa);
 
+int cyapa_set_not_supported(struct cyapa *cyapa, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
 bool cyapa_is_pip_bl_mode(struct cyapa *cyapa)
 {
 	if (cyapa->gen == CYAPA_GEN6 && cyapa->state == CYAPA_STATE_GEN6_BL)
@@ -477,6 +482,8 @@ static int cyapa_create_input_dev(struct cyapa *cyapa)
 	if (cyapa->gen >= CYAPA_GEN5) {
 		input_set_abs_params(input, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
 		input_set_abs_params(input, ABS_MT_WIDTH_MINOR, 0, 255, 0, 0);
+
+		input_set_abs_params(input, ABS_MT_DISTANCE, 0, 1, 0, 0);
 	}
 
 	input_abs_set_res(input, ABS_MT_POSITION_X,
@@ -1340,6 +1347,13 @@ static int __maybe_unused cyapa_suspend(struct device *dev)
 					error);
 	}
 
+	/*
+	 * Disable proximity interrupt when system idle, want true touch to
+	 * wake the system.
+	 */
+	if (cyapa->dev_pwr_mode != PWR_MODE_OFF)
+		cyapa->ops->set_proximity(cyapa, false);
+
 	if (device_may_wakeup(dev))
 		cyapa->irq_wake = (enable_irq_wake(client->irq) == 0);
 
@@ -1360,7 +1374,10 @@ static int __maybe_unused cyapa_resume(struct device *dev)
 		cyapa->irq_wake = false;
 	}
 
-	/* Update device states and runtime PM states. */
+	/*
+	 * Update device states and runtime PM states.
+	 * Re-Enable proximity interrupt after enter operational mode.
+	 */
 	error = cyapa_reinitialize(cyapa);
 	if (error)
 		dev_warn(dev, "failed to reinitialize TP device: %d\n", error);
diff --git a/drivers/input/mouse/cyapa.h b/drivers/input/mouse/cyapa.h
index ec41404..090d5be 100644
--- a/drivers/input/mouse/cyapa.h
+++ b/drivers/input/mouse/cyapa.h
@@ -274,6 +274,8 @@ struct cyapa_dev_ops {
 			u8 *, int *, cb_sort);
 
 	int (*set_power_mode)(struct cyapa *, u8, u16);
+
+	int (*set_proximity)(struct cyapa *, bool);
 };
 
 struct cyapa_pip_cmd_states {
@@ -420,9 +422,11 @@ int cyapa_pip_bl_deactivate(struct cyapa *cyapa);
 ssize_t cyapa_pip_do_calibrate(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count);
+int cyapa_pip_set_proximity(struct cyapa *cyapa, bool enable);
 
 bool cyapa_pip_irq_cmd_handler(struct cyapa *cyapa);
 int cyapa_pip_irq_handler(struct cyapa *cyapa);
+int cyapa_set_not_supported(struct cyapa *cyapa, bool enable);
 
 
 extern u8 pip_read_sys_info[];
diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index 5d50c0d..47004bb 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -1243,4 +1243,6 @@ const struct cyapa_dev_ops cyapa_gen3_ops = {
 	.irq_cmd_handler = cyapa_gen3_irq_cmd_handler,
 	.sort_empty_output_data = cyapa_gen3_empty_output_data,
 	.set_power_mode = cyapa_gen3_set_power_mode,
+
+	.set_proximity = cyapa_set_not_supported,
 };
diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index 4462a78..d1cd7a7 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -52,6 +52,11 @@
 #define PIP_WAKEUP_EVENT_REPORT_ID  0x04
 #define PIP_PUSH_BTN_REPORT_ID      0x06
 #define GEN5_OLD_PUSH_BTN_REPORT_ID 0x05  /* Special for old Gen5 TP. */
+#define PIP_PROXIMITY_REPORT_ID     0x07
+
+#define PIP_PROXIMITY_REPORT_SIZE	6
+#define PIP_PROXIMITY_DISTANCE_OFFSET	0x05
+#define PIP_PROXIMITY_DISTANCE_MASK	0x01
 
 #define PIP_TOUCH_REPORT_HEAD_SIZE     7
 #define PIP_TOUCH_REPORT_MAX_SIZE      127
@@ -78,6 +83,8 @@
 #define PIP_SENSING_MODE_MUTUAL_CAP_FINE   0x00
 #define PIP_SENSING_MODE_SELF_CAP          0x02
 
+#define PIP_SET_PROXIMITY	0x49
+
 /* Macro of Gen5 */
 #define GEN5_BL_MAX_OUTPUT_LENGTH     0x0100
 #define GEN5_APP_MAX_OUTPUT_LENGTH    0x00fe
@@ -1517,6 +1524,28 @@ static int cyapa_gen5_disable_pip_report(struct cyapa *cyapa)
 	return 0;
 }
 
+int cyapa_pip_set_proximity(struct cyapa *cyapa, bool enable)
+{
+	u8 cmd[] = { 0x04, 0x00, 0x06, 0x00, 0x2f, 0x00, PIP_SET_PROXIMITY,
+		     (u8)!!enable
+	};
+	u8 resp_data[6];
+	int resp_len;
+	int error;
+
+	resp_len = sizeof(resp_data);
+	error = cyapa_i2c_pip_cmd_irq_sync(cyapa, cmd, sizeof(cmd),
+			resp_data, &resp_len,
+			500, cyapa_sort_tsg_pip_app_resp_data, false);
+	if (error || !VALID_CMD_RESP_HEADER(resp_data, PIP_SET_PROXIMITY) ||
+			!PIP_CMD_COMPLETE_SUCCESS(resp_data)) {
+		error = (error == -ETIMEDOUT) ? -EOPNOTSUPP : error;
+		return error < 0 ? error : -EINVAL;
+	}
+
+	return 0;
+}
+
 int cyapa_pip_deep_sleep(struct cyapa *cyapa, u8 state)
 {
 	u8 cmd[] = { 0x05, 0x00, 0x00, 0x08};
@@ -2491,6 +2520,12 @@ static int cyapa_gen5_do_operational_check(struct cyapa *cyapa)
 			dev_warn(dev, "%s: failed to set power active mode.\n",
 				__func__);
 
+		/* By default, the trackpad proximity function is enabled. */
+		error = cyapa_pip_set_proximity(cyapa, true);
+		if (error)
+			dev_warn(dev, "%s: failed to enable proximity.\n",
+				__func__);
+
 		/* Get trackpad product information. */
 		error = cyapa_gen5_get_query_data(cyapa);
 		if (error)
@@ -2606,6 +2641,17 @@ static void cyapa_pip_report_buttons(struct cyapa *cyapa,
 	input_sync(input);
 }
 
+static void cyapa_pip_report_proximity(struct cyapa *cyapa,
+		const struct cyapa_pip_report_data *report_data)
+{
+	struct input_dev *input = cyapa->input;
+	u8 distance = report_data->report_head[PIP_PROXIMITY_DISTANCE_OFFSET] &
+			PIP_PROXIMITY_DISTANCE_MASK;
+
+	input_report_abs(input, ABS_MT_DISTANCE, distance);
+	input_sync(input);
+}
+
 static void cyapa_pip_report_slot_data(struct cyapa *cyapa,
 		const struct cyapa_pip_touch_record *touch)
 {
@@ -2627,6 +2673,7 @@ static void cyapa_pip_report_slot_data(struct cyapa *cyapa,
 		y = cyapa->max_abs_y - y;
 	input_report_abs(input, ABS_MT_POSITION_X, x);
 	input_report_abs(input, ABS_MT_POSITION_Y, y);
+	input_report_abs(input, ABS_MT_DISTANCE, 0);
 	input_report_abs(input, ABS_MT_PRESSURE,
 		touch->z);
 	input_report_abs(input, ABS_MT_TOUCH_MAJOR,
@@ -2714,7 +2761,8 @@ int cyapa_pip_irq_handler(struct cyapa *cyapa)
 	} else if (report_id != PIP_TOUCH_REPORT_ID &&
 			report_id != PIP_BTN_REPORT_ID &&
 			report_id != GEN5_OLD_PUSH_BTN_REPORT_ID &&
-			report_id != PIP_PUSH_BTN_REPORT_ID) {
+			report_id != PIP_PUSH_BTN_REPORT_ID &&
+			report_id != PIP_PROXIMITY_REPORT_ID) {
 		/* Running in BL mode or unknown response data read. */
 		dev_err(dev, "invalid report_id=0x%02x\n", report_id);
 		return -EINVAL;
@@ -2738,8 +2786,17 @@ int cyapa_pip_irq_handler(struct cyapa *cyapa)
 		return 0;
 	}
 
+	if (report_id == PIP_PROXIMITY_REPORT_ID &&
+			report_len != PIP_PROXIMITY_REPORT_SIZE) {
+		/* Invalid report data length of proximity packet. */
+		dev_err(dev, "invalid proximity data, length=%d\n", report_len);
+		return 0;
+	}
+
 	if (report_id == PIP_TOUCH_REPORT_ID)
 		cyapa_pip_report_touches(cyapa, &report_data);
+	else if (report_id == PIP_PROXIMITY_REPORT_ID)
+		cyapa_pip_report_proximity(cyapa, &report_data);
 	else
 		cyapa_pip_report_buttons(cyapa, &report_data);
 
@@ -2770,4 +2827,6 @@ const struct cyapa_dev_ops cyapa_gen5_ops = {
 	.irq_cmd_handler = cyapa_pip_irq_cmd_handler,
 	.sort_empty_output_data = cyapa_empty_pip_output_data,
 	.set_power_mode = cyapa_gen5_set_power_mode,
+
+	.set_proximity = cyapa_pip_set_proximity,
 };
diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
index 454a2fe..693d152 100644
--- a/drivers/input/mouse/cyapa_gen6.c
+++ b/drivers/input/mouse/cyapa_gen6.c
@@ -312,6 +312,17 @@ static int cyapa_gen6_config_dev_irq(struct cyapa *cyapa, u8 cmd_code)
 	return 0;
 }
 
+static int cyapa_gen6_set_proximity(struct cyapa *cyapa, bool enable)
+{
+	int error;
+
+	cyapa_gen6_config_dev_irq(cyapa, GEN6_DISABLE_CMD_IRQ);
+	error = cyapa_pip_set_proximity(cyapa, enable);
+	cyapa_gen6_config_dev_irq(cyapa, GEN6_ENABLE_CMD_IRQ);
+
+	return error;
+}
+
 static int cyapa_gen6_change_power_state(struct cyapa *cyapa, u8 power_mode)
 {
 	u8 cmd[] = { 0x04, 0x00, 0x06, 0x00, 0x2f, 0x00, 0x46, power_mode };
@@ -686,6 +697,12 @@ static int cyapa_gen6_operational_check(struct cyapa *cyapa)
 			dev_warn(dev, "%s: failed to set power active mode.\n",
 				__func__);
 
+		/* By default, the trackpad proximity function is enabled. */
+		error = cyapa_pip_set_proximity(cyapa, true);
+		if (error)
+			dev_warn(dev, "%s: failed to enable proximity.\n",
+				__func__);
+
 		/* Get trackpad product information. */
 		error = cyapa_gen6_read_sys_info(cyapa);
 		if (error)
@@ -726,4 +743,6 @@ const struct cyapa_dev_ops cyapa_gen6_ops = {
 	.irq_cmd_handler = cyapa_pip_irq_cmd_handler,
 	.sort_empty_output_data = cyapa_empty_pip_output_data,
 	.set_power_mode = cyapa_gen6_set_power_mode,
+
+	.set_proximity = cyapa_gen6_set_proximity,
 };
-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------

