From: Jingkui Wang <jkwang@google.com>
Subject: [PATCH v2] Input: drv260x - Add capability of playing custom waveform
Date: Thu, 12 Jan 2017 16:02:23 -0800
Message-ID: <1484265743-103285-1-git-send-email-jkwang@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35560 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdAMAD3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 12 Jan 2017 19:03:29 -0500
Received: by mail-pf0-f174.google.com with SMTP id f144so20698565pfa.2
        for <linux-input@vger.kernel.org>; Thu, 12 Jan 2017 16:03:29 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Dan Murphy <dmurphy@ti.com>, Jingkui Wang <jkwang@google.com>

When the device does not contain ROM library (device: drv2605,
drv2605l), it contains a RAM (device:drv2604, drv2605l) and support
playing custom defined waveform. This change implement the custom
waveform playback by adding a input device for those device and allowing
user to upload custom wave from through ff_custom. Waveform will loaded
to ram and later played by user.

Signed-off-by: Jingkui Wang <jkwang@google.com>
---
Changes in v2:
-Refactor to use one device
-Fix big endian bitfield memory layout

 drivers/input/misc/drv260x.c | 367 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 353 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 0ee19b9..0446b61 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -62,7 +62,10 @@
 #define DRV260X_LRA_LOOP_PERIOD	0x20
 #define DRV260X_VBAT_MON		0x21
 #define DRV260X_LRA_RES_PERIOD	0x22
-#define DRV260X_MAX_REG			0x23
+#define DRV260X_RAM_ADDR_UB		0xfd
+#define DRV260X_RAM_ADDR_LB		0xfe
+#define DRV260X_RAM_DATA		0xff
+#define DRV260X_MAX_REG			0xff
 
 #define DRV260X_GO_BIT				0x01
 
@@ -174,12 +177,78 @@
 #define DRV260X_AUTOCAL_TIME_500MS		(2 << 4)
 #define DRV260X_AUTOCAL_TIME_1000MS		(3 << 4)
 
+/* For custom effects */
+#define DRV260X_MAX_EFFECT_NUM			16
+#define DRV260X_MAX_WF_LEN			20
+
+/**
+ * struct drv260x_wf_header -
+ * @start_addr_upper - upper byte of start address
+ * @start_addr_lower - lower byte of start address
+ * @effect_size - size of the effect
+ * @waveform_repeats - waveform repeat time
+ **/
+struct drv260x_wf_header {
+	unsigned int start_addr_upper : 8;
+	unsigned int start_addr_lower : 8;
+#if defined(__BIG_ENDIAN_BITFIELD)
+	unsigned int waveform_repeats : 3;
+	unsigned int effect_size : 5;
+#else
+	unsigned int effect_size : 5;
+	unsigned int waveform_repeats : 3;
+#endif
+} __packed;
+
+/**
+ * struct drv260x_wf_data -
+ * @voltage - voltage for this time period
+ * @ramp - linear ramp between this time period and next time period
+ * @time - time for this voltage
+ **/
+struct drv260x_wf_data {
+#if defined(__BIG_ENDIAN_BITFIELD)
+	unsigned int ramp : 1;
+	unsigned int voltage : 7;
+#else
+	unsigned int voltage : 7;
+	unsigned int ramp : 1;
+#endif
+	unsigned int time : 8;
+} __packed;
+
+/**
+ * struct drv260x_wf
+ * @header - header for the waveform
+ * @data - data for the waveform
+ **/
+struct drv260x_wf {
+	struct drv260x_wf_header header;
+	struct drv260x_wf_data data[DRV260X_MAX_WF_LEN];
+};
+
+/**
+ * struct drv260x_work_params -
+ * @playback_wf_id - Id for the playback job
+ * @rtp_magnitude - Param for the rtp job
+ * @is_custom_effect - If this id is custom effect
+ **/
+struct drv260x_work_params {
+	int playback_wf_id;
+	u32 rtp_magnitude;
+	bool is_custom_effect[DRV260X_MAX_EFFECT_NUM];
+};
+
 /**
  * struct drv260x_data -
+ * @ml_upload - ff_device->upload callback for the memless device
+ * @ml_playback - ff_device->playback callback for the memless device
  * @input_dev - Pointer to the input device
  * @client - Pointer to the I2C client
  * @regmap - Register map of the device
- * @work - Work item used to off load the enable/disable of the vibration
+ * @work_params - Used to pass the parameter for the works
+ * @rtp_work - Work item used to off load the enable/disable of the vibration
+ * @wfp_playback_work - Work item used to playback custom waveform
  * @enable_gpio - Pointer to the gpio used for enable/disabling
  * @regulator - Pointer to the regulator for the IC
  * @magnitude - Magnitude of the vibration event
@@ -189,10 +258,15 @@
  * @overdriver_voltage - The over drive voltage of the actuator
 **/
 struct drv260x_data {
+	int (*ml_upload)(struct input_dev *dev, struct ff_effect *effect,
+			struct ff_effect *old);
+	int (*ml_playback)(struct input_dev *dev, int effect_id, int value);
 	struct input_dev *input_dev;
 	struct i2c_client *client;
 	struct regmap *regmap;
-	struct work_struct work;
+	struct drv260x_work_params work_params;
+	struct work_struct rtp_work;
+	struct work_struct wfp_playback_work;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
 	u32 magnitude;
@@ -238,6 +312,9 @@ static struct reg_default drv260x_reg_defs[] = {
 	{ DRV260X_LRA_LOOP_PERIOD, 0x33 },
 	{ DRV260X_VBAT_MON, 0x00 },
 	{ DRV260X_LRA_RES_PERIOD, 0x00 },
+	{ DRV260X_RAM_ADDR_UB, 0x00 },
+	{ DRV260X_RAM_ADDR_LB, 0x00 },
+	{ DRV260X_RAM_DATA, 0x00 },
 };
 
 #define DRV260X_DEF_RATED_VOLT		0x90
@@ -254,11 +331,15 @@ static int drv260x_calculate_voltage(unsigned int voltage)
 	return (voltage * 255 / 5600);
 }
 
-static void drv260x_worker(struct work_struct *work)
+static void drv260x_rtp_worker(struct work_struct *work)
 {
-	struct drv260x_data *haptics = container_of(work, struct drv260x_data, work);
+	struct drv260x_data *haptics = container_of(work,
+						struct drv260x_data,
+						rtp_work);
 	int error;
+	u32 magnitude;
 
+	magnitude = READ_ONCE(haptics->work_params.rtp_magnitude);
 	gpiod_set_value(haptics->enable_gpio, 1);
 	/* Data sheet says to wait 250us before trying to communicate */
 	udelay(250);
@@ -270,28 +351,30 @@ static void drv260x_worker(struct work_struct *work)
 			"Failed to write set mode: %d\n", error);
 	} else {
 		error = regmap_write(haptics->regmap,
-				     DRV260X_RT_PB_IN, haptics->magnitude);
+				     DRV260X_RT_PB_IN, magnitude);
 		if (error)
 			dev_err(&haptics->client->dev,
 				"Failed to set magnitude: %d\n", error);
 	}
 }
 
-static int drv260x_haptics_play(struct input_dev *input, void *data,
+static int drv260x_rtp_play(struct input_dev *input, void *data,
 				struct ff_effect *effect)
 {
+	u32 magnitude;
 	struct drv260x_data *haptics = input_get_drvdata(input);
 
 	haptics->mode = DRV260X_LRA_NO_CAL_MODE;
 
 	if (effect->u.rumble.strong_magnitude > 0)
-		haptics->magnitude = effect->u.rumble.strong_magnitude;
+		magnitude = effect->u.rumble.strong_magnitude;
 	else if (effect->u.rumble.weak_magnitude > 0)
-		haptics->magnitude = effect->u.rumble.weak_magnitude;
+		magnitude = effect->u.rumble.weak_magnitude;
 	else
-		haptics->magnitude = 0;
+		magnitude = 0;
 
-	schedule_work(&haptics->work);
+	WRITE_ONCE(haptics->work_params.rtp_magnitude, magnitude);
+	schedule_work(&haptics->rtp_work);
 
 	return 0;
 }
@@ -301,7 +384,8 @@ static void drv260x_close(struct input_dev *input)
 	struct drv260x_data *haptics = input_get_drvdata(input);
 	int error;
 
-	cancel_work_sync(&haptics->work);
+	cancel_work_sync(&haptics->rtp_work);
+	cancel_work_sync(&haptics->wfp_playback_work);
 
 	error = regmap_write(haptics->regmap, DRV260X_MODE, DRV260X_STANDBY);
 	if (error)
@@ -311,6 +395,200 @@ static void drv260x_close(struct input_dev *input)
 	gpiod_set_value(haptics->enable_gpio, 0);
 }
 
+static inline int drv260x_set_ram_addr(struct drv260x_data *haptics,
+					unsigned int addr)
+{
+	int error;
+	u8 addr_h, addr_l;
+
+	addr_h = (addr & 0xff00) >> 8;
+	addr_l = addr & 0xff;
+
+	error = regmap_write(haptics->regmap, DRV260X_RAM_ADDR_UB, addr_h);
+	if (error)
+		return error;
+
+	error = regmap_write(haptics->regmap,
+				DRV260X_RAM_ADDR_LB, addr_l);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int drv260x_write_ram(struct drv260x_data *haptics,
+				unsigned int addr, int len, const void *data)
+{
+	int error;
+	const u8 *data_byte = data;
+
+	drv260x_set_ram_addr(haptics, addr);
+
+	while (len > 0) {
+		error = regmap_write(haptics->regmap,
+					DRV260X_RAM_DATA, *data_byte++);
+		if (error) {
+			dev_err(&haptics->client->dev,
+				"Failed to write register %x\n",
+				DRV260X_RAM_DATA);
+			return error;
+		}
+		--len;
+	}
+
+	return 0;
+}
+
+static inline int get_header_addr(int effect_id)
+{
+	/* as datasheet header start from ram address 1 */
+	return 1 + sizeof(struct drv260x_wf_header) * effect_id;
+}
+
+static inline int get_wf_addr(int effect_id)
+{
+	/* waveform data start after last header */
+	return get_header_addr(DRV260X_MAX_EFFECT_NUM) +
+				effect_id *
+				sizeof(struct drv260x_wf_data) *
+				DRV260X_MAX_WF_LEN;
+}
+
+static int drv260x_upload_effect(struct input_dev *dev,
+				 struct ff_effect *effect,
+				 struct ff_effect *old)
+{
+	int error, wf_start_addr;
+	struct drv260x_wf wf;
+	struct drv260x_data *haptics = input_get_drvdata(dev);
+
+	if (effect->type != FF_PERIODIC ||
+		effect->u.periodic.waveform != FF_CUSTOM) {
+		error = haptics->ml_upload(dev, effect, old);
+		if (error)
+			return error;
+		if (effect->id < DRV260X_MAX_EFFECT_NUM) {
+			WRITE_ONCE(haptics->
+					work_params.
+					is_custom_effect[effect->id], false);
+		}
+		return 0;
+	}
+
+	if (effect->id >= DRV260X_MAX_EFFECT_NUM)
+		return -EINVAL;
+
+	error = copy_from_user(&wf, effect->u.periodic.custom_data, sizeof(wf));
+	if (error)
+		return error;
+
+	/* effect size is wf data_len * 2 since every seg is 2 bytes */
+	if (wf.header.effect_size >
+		sizeof(struct drv260x_wf_data) * DRV260X_MAX_WF_LEN)
+		return -EINVAL;
+
+	wf_start_addr = get_wf_addr(effect->id);
+	wf.header.start_addr_upper = (u8) ((wf_start_addr & 0xff00) >> 8);
+	wf.header.start_addr_lower = (u8) wf_start_addr & 0xff;
+
+	/* write header */
+	error = drv260x_write_ram(haptics,
+				get_header_addr(effect->id),
+				sizeof(struct drv260x_wf_header),
+				&wf.header);
+	if (error)
+		return error;
+
+	/* write waveform */
+	error = drv260x_write_ram(haptics,
+				wf_start_addr,
+				sizeof(wf.data),
+				&wf.data);
+	if (error)
+		return error;
+
+	WRITE_ONCE(haptics->work_params.is_custom_effect[effect->id], true);
+	return 0;
+}
+
+static void drv260x_playback_worker(struct work_struct *work)
+{
+	int error, wf_id;
+	struct drv260x_data *haptics = container_of(work,
+						struct drv260x_data,
+						wfp_playback_work);
+
+	wf_id = READ_ONCE(haptics->work_params.playback_wf_id);
+
+	/*
+	 * Setup Mode
+	 * The waveform is triggered internally by go bit
+	 */
+	error = regmap_write(haptics->regmap,
+				DRV260X_MODE, DRV260X_INTERNAL_TRIGGER);
+	if (error)
+		goto error_out;
+
+	/*
+	 * Setup sequencer
+	 * The device will play starting from seq_1 and end when it meet id = 0
+	 */
+	error = regmap_write(haptics->regmap,
+				DRV260X_WV_SEQ_1, wf_id);
+	if (error)
+		goto error_out;
+
+	error = regmap_write(haptics->regmap,
+				DRV260X_WV_SEQ_2, 0);
+	if (error)
+		goto error_out;
+
+	/*
+	 * GO bit triggers the waveform playback
+	 */
+	error = regmap_write(haptics->regmap,
+				DRV260X_GO, DRV260X_GO_BIT);
+	if (error)
+		goto error_out;
+
+	return;
+error_out:
+	dev_err(&haptics->client->dev, "playback fail to write reg\n");
+}
+
+static int drv260x_playback(struct input_dev *dev,
+				int effect_id,
+				int value)
+{
+	struct drv260x_data *haptics = input_get_drvdata(dev);
+
+	if (effect_id < DRV260X_MAX_EFFECT_NUM &&
+		!READ_ONCE(haptics->work_params.is_custom_effect[effect_id]))
+		return haptics->ml_playback(dev, effect_id, value);
+
+	/*
+	 * effect_id of input subsystem start from 0 while
+	 * waveform id of the device start from 1
+	 */
+	WRITE_ONCE(haptics->work_params.playback_wf_id, effect_id + 1);
+	schedule_work(&haptics->wfp_playback_work);
+
+	return 0;
+}
+
+static int drv260x_erase(struct input_dev *dev,
+				int effect_id)
+{
+	struct drv260x_data *haptics = input_get_drvdata(dev);
+
+	if (effect_id >= DRV260X_MAX_EFFECT_NUM)
+		return 0;
+
+	WRITE_ONCE(haptics->work_params.is_custom_effect[effect_id], false);
+
+	return 0;
+}
+
 static const struct reg_default drv260x_lra_cal_regs[] = {
 	{ DRV260X_MODE, DRV260X_AUTO_CAL },
 	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 },
@@ -466,6 +744,53 @@ static const struct regmap_config drv260x_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
+static int drv260x_ram_init(struct drv260x_data *haptics)
+{
+	int error;
+
+	/*
+	 * According to the device spec, the first byte of the ram should
+	 * be zero. This is done by first set the UB and LB of ram addr reg,
+	 * then write 0 to ram_data reg.
+	 */
+	error = drv260x_set_ram_addr(haptics, 0);
+	if (error)
+		return error;
+
+	error = regmap_write(haptics->regmap,
+				DRV260X_RAM_DATA, 0);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int drv260x_wfp_init(struct drv260x_data *haptics)
+{
+	struct ff_device *ff;
+	struct input_dev *input_dev = haptics->input_dev;
+
+	if (drv260x_ram_init(haptics))
+		return -EINVAL;
+
+	ff = input_dev->ff;
+
+	set_bit(FF_CUSTOM, input_dev->ffbit);
+	set_bit(FF_PERIODIC, input_dev->ffbit);
+
+	haptics->ml_upload = ff->upload;
+	haptics->ml_playback = ff->playback;
+
+	ff = input_dev->ff;
+	ff->upload = drv260x_upload_effect;
+	ff->playback = drv260x_playback;
+	ff->erase = drv260x_erase;
+
+	INIT_WORK(&haptics->wfp_playback_work, drv260x_playback_worker);
+
+	return 0;
+}
+
 static int drv260x_read_device_property(struct device *dev,
 			    struct drv260x_data *haptics)
 {
@@ -575,14 +900,14 @@ static int drv260x_probe(struct i2c_client *client,
 	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
 
 	error = input_ff_create_memless(haptics->input_dev, NULL,
-					drv260x_haptics_play);
+					drv260x_rtp_play);
 	if (error) {
 		dev_err(&client->dev, "input_ff_create() failed: %d\n",
 			error);
 		return error;
 	}
 
-	INIT_WORK(&haptics->work, drv260x_worker);
+	INIT_WORK(&haptics->rtp_work, drv260x_rtp_worker);
 
 	haptics->client = client;
 	i2c_set_clientdata(client, haptics);
@@ -601,6 +926,20 @@ static int drv260x_probe(struct i2c_client *client,
 		return error;
 	}
 
+	/*
+	 * For drv260x device, if there is no pre-loaded library, it should
+	 * support custom waveform
+	 */
+	if (haptics->library == DRV260X_LIB_EMPTY) {
+		error = drv260x_wfp_init(haptics);
+		if (error) {
+			dev_err(&client->dev,
+				"fail to init waveform playback device: %d\n",
+				error);
+			return error;
+		}
+	}
+
 	error = input_register_device(haptics->input_dev);
 	if (error) {
 		dev_err(&client->dev, "couldn't register input device: %d\n",
-- 
2.6.6

