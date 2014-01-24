From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: [PATCH 08/15] Input: synaptics-rmi4 - cleanup platform data
Date: Thu, 23 Jan 2014 16:00:16 -0800
Message-ID: <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:19804 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751001AbaAWX7s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 18:59:48 -0500
In-Reply-To: <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cheiny@synaptics.com

Update platform data documentation and remove unneeded/unused stuff in
platform data.

If these items are needed at some later point, they should be added
then.  Until that point, we should unclutter the code.

Cc: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
---
 drivers/input/rmi4/rmi_f11.c |  14 ++--
 include/linux/rmi.h          | 157 ++++++++++---------------------------------
 2 files changed, 40 insertions(+), 131 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 87d85ab..9d94b1a 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1109,7 +1109,7 @@ static void f11_set_abs_params(struct rmi_function *fn)
 	/* We assume touchscreen unless demonstrably a touchpad or specified
 	 * as a touchpad in the platform data
 	 */
-	if (sensor->sensor_type == rmi_f11_sensor_touchpad ||
+	if (sensor->sensor_type == RMI_F11_SENSOR_INDIRECT ||
 			(sensor->sens_query.has_info2 &&
 				!sensor->sens_query.is_clear))
 		input_flags = INPUT_PROP_POINTER;
@@ -1192,7 +1192,7 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 		return -ENOMEM;
 
 	fn->data = f11;
-	f11->rezero_wait_ms = pdata->f11_rezero_wait;
+	f11->rezero_wait_ms = pdata->f11_sensor_data.rezero_wait;
 
 	query_base_addr = fn->fd.query_base_addr;
 	control_base_addr = fn->fd.control_base_addr;
@@ -1225,13 +1225,9 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 		return rc;
 	}
 
-	if (pdata->f11_sensor_data) {
-		sensor->axis_align =
-			pdata->f11_sensor_data->axis_align;
-		sensor->type_a = pdata->f11_sensor_data->type_a;
-		sensor->sensor_type =
-				pdata->f11_sensor_data->sensor_type;
-	}
+	sensor->axis_align = pdata->f11_sensor_data.axis_align;
+	sensor->type_a = pdata->f11_sensor_data.type_a;
+	sensor->sensor_type = pdata->f11_sensor_data.sensor_type;
 
 	rc = rmi_read_block(rmi_dev,
 		control_base_addr + F11_CTRL_SENSOR_MAX_X_POS_OFFSET,
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index f3775eb..60ddd98 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -37,8 +37,8 @@
  *               the specified value
  * @offset_x - this value will be added to all reported X coordinates
  * @offset_y - this value will be added to all reported Y coordinates
- * @rel_report_enabled - if set to true, the relative reporting will be
- *               automatically enabled for this sensor.
+ * @delta_x_threshold - delta X movement required before reporting event
+ * @delta_y_threshold - delta Y movement required before reporting event
  */
 struct rmi_f11_2d_axis_alignment {
 	bool swap_axes;
@@ -57,34 +57,36 @@ struct rmi_f11_2d_axis_alignment {
 /** This is used to override any hints an F11 2D sensor might have provided
  * as to what type of sensor it is.
  *
- * @rmi_f11_sensor_default - do not override, determine from F11_2D_QUERY14 if
- * available.
- * @rmi_f11_sensor_touchscreen - treat the sensor as a touchscreen (direct
- * pointing).
- * @rmi_f11_sensor_touchpad - thread the sensor as a touchpad (indirect
- * pointing).
+ * @RMI_F11_SENSOR_DEFAULT - determine from F11_2D_QUERY14 if available.
+ * @RMI_F11_SENSOR_DIRECT - direct pointing sensor (e.g. touchscreen)
+ * @RMI_F11_SENSOR_INDIRECT - indirect pointing sensor (e.g touchpad)
  */
 enum rmi_f11_sensor_type {
-	rmi_f11_sensor_default = 0,
-	rmi_f11_sensor_touchscreen,
-	rmi_f11_sensor_touchpad
+	RMI_F11_SENSOR_DEFAULT = 0,
+	RMI_F11_SENSOR_DIRECT,
+	RMI_F11_SENSOR_INDIRECT
 };
 
 /**
  * struct rmi_f11_sensor_data - overrides defaults for a single F11 2D sensor.
+ *
  * @axis_align - provides axis alignment overrides (see above).
  * @type_a - all modern RMI F11 firmwares implement Multifinger Type B
- * protocol.  Set this to true to force MF Type A behavior, in case you find
- * an older sensor.
+ *           protocol.  Set this to true to force MF Type A behavior, in case
+ *           you find an older sensor.
  * @sensor_type - Forces the driver to treat the sensor as an indirect
- * pointing device (touchpad) rather than a direct pointing device
- * (touchscreen).  This is useful when F11_2D_QUERY14 register is not
- * available.
+ *                pointing device (touchpad) rather than a direct pointing
+ *                device (touchscreen).  This is useful when F11_2D_QUERY14
+ *                register is not available.
+ * @rezero_wait - if non-zero, this is how may milliseconds the sensor will
+ *                wait before being be re-zeroed on exit from suspend.  If this
+ *                value is zero, the sensor will not be re-zeroed on resume.
  */
 struct rmi_f11_sensor_data {
 	struct rmi_f11_2d_axis_alignment axis_align;
 	bool type_a;
 	enum rmi_f11_sensor_type sensor_type;
+	u16 rezero_wait;
 };
 
 /**
@@ -98,20 +100,22 @@ enum rmi_f01_nosleep {
 };
 
 /**
- * struct rmi_f01_power_management -When non-zero, these values will be written
- * to the touch sensor to override the default firmware settigns.  For a
- * detailed explanation of what each field does, see the corresponding
- * documention in the RMI4 specification.
+ * struct rmi_f01_power_management - touch sensor power settings
+ *
+ * When non-zero, these values will be written to the touch sensor to override
+ * the default firmware settings.  For a detailed explanation of what each
+ * field does, see the corresponding documentation in the RMI4 specification.
  *
  * @nosleep - specifies whether the device is permitted to sleep or doze (that
- * is, enter a temporary low power state) when no fingers are touching the
- * sensor.
+ *            is, enter a temporary low power state) when no fingers are
+ *            touching the sensor.
  * @wakeup_threshold - controls the capacitance threshold at which the touch
- * sensor will decide to wake up from that low power state.
+ *                     sensor will decide to wake up from that low power state.
  * @doze_holdoff - controls how long the touch sensor waits after the last
- * finger lifts before entering the doze state, in units of 100ms.
+ *                 finger lifts before entering the doze state, in units of
+ *                 100ms.
  * @doze_interval - controls the interval between checks for finger presence
- * when the touch sensor is in doze mode, in units of 10ms.
+ *                  when the touch sensor is in doze mode, in units of 10ms.
  */
 struct rmi_f01_power_management {
 	enum rmi_f01_nosleep nosleep;
@@ -121,114 +125,23 @@ struct rmi_f01_power_management {
 };
 
 /**
- * struct rmi_button_map - used to specify the initial input subsystem key
- * event codes to be generated by buttons (or button like entities) on the
- * touch sensor.
- * @nbuttons - length of the button map.
- * @map - the key event codes for the corresponding buttons on the touch
- * sensor.
- */
-struct rmi_button_map {
-	u8 nbuttons;
-	u8 *map;
-};
-
-struct rmi_f30_gpioled_map {
-	u8 ngpioleds;
-	u8 *map;
-};
-
-/**
- * struct rmi_device_platform_data_spi - provides parameters used in SPI
- * communications.  All Synaptics SPI products support a standard SPI
- * interface; some also support what is called SPI V2 mode, depending on
- * firmware and/or ASIC limitations.  In V2 mode, the touch sensor can
- * support shorter delays during certain operations, and these are specified
- * separately from the standard mode delays.
- *
- * @block_delay - for standard SPI transactions consisting of both a read and
- * write operation, the delay (in microseconds) between the read and write
- * operations.
- * @split_read_block_delay_us - for V2 SPI transactions consisting of both a
- * read and write operation, the delay (in microseconds) between the read and
- * write operations.
- * @read_delay_us - the delay between each byte of a read operation in normal
- * SPI mode.
- * @write_delay_us - the delay between each byte of a write operation in normal
- * SPI mode.
- * @split_read_byte_delay_us - the delay between each byte of a read operation
- * in V2 mode.
- * @pre_delay_us - the delay before the start of a SPI transaction.  This is
- * typically useful in conjunction with custom chip select assertions (see
- * below).
- * @post_delay_us - the delay after the completion of an SPI transaction.  This
- * is typically useful in conjunction with custom chip select assertions (see
- * below).
- * @cs_assert - For systems where the SPI subsystem does not control the CS/SSB
- * line, or where such control is broken, you can provide a custom routine to
- * handle a GPIO as CS/SSB.  This routine will be called at the beginning and
- * end of each SPI transaction.  The RMI SPI implementation will wait
- * pre_delay_us after this routine returns before starting the SPI transfer;
- * and post_delay_us after completion of the SPI transfer(s) before calling it
- * with assert==FALSE.
- */
-struct rmi_device_platform_data_spi {
-	u32 block_delay_us;
-	u32 split_read_block_delay_us;
-	u32 read_delay_us;
-	u32 write_delay_us;
-	u32 split_read_byte_delay_us;
-	u32 pre_delay_us;
-	u32 post_delay_us;
-
-	void *cs_assert_data;
-	int (*cs_assert) (const void *cs_assert_data, const bool assert);
-};
-
-/**
  * struct rmi_device_platform_data - system specific configuration info.
  *
  * @irq - attention IRQ
- * @firmware_name - if specified will override default firmware name,
- * for reflashing.
- *
  * @reset_delay_ms - after issuing a reset command to the touch sensor, the
- * driver waits a few milliseconds to give the firmware a chance to
- * to re-initialize.  You can override the default wait period here.
- *
- * @spi_data - override default settings for SPI delays and SSB management (see
- * above).
- *
+ *                   driver waits a few milliseconds to give the firmware a
+ *                   chance to to re-initialize.  You can override the default
+ *                   wait period here.
  * @f11_sensor_data - platform data for the F11 2D sensor.
- * @f11_rezero_wait - if non-zero, this is how may milliseconds the F11 2D
- * sensor will wait before being be rezeroed on exit from suspend.  If
- * this value is zero, the F11 2D sensor will not be rezeroed on resume.
- * @power_management - overrides default touch sensor doze mode settings (see
- * above)
- * @f19_button_map - provide initial input subsystem key mappings for F19.
- * @f1a_button_map - provide initial input subsystem key mappings for F1A.
- * @gpioled_map - provides initial settings for GPIOs and LEDs controlled by
- * F30.
- * @f41_button_map - provide initial input subsystem key mappings for F41.
+ * @power_management - touch sensor power settings (see above)
  */
 struct rmi_device_platform_data {
 	int irq;
-	int reset_delay_ms;
-
-	struct rmi_device_platform_data_spi spi_data;
+	u32 reset_delay_ms;
 
 	/* function handler pdata */
-	struct rmi_f11_sensor_data *f11_sensor_data;
-	u16 f11_rezero_wait;
+	struct rmi_f11_sensor_data f11_sensor_data;
 	struct rmi_f01_power_management power_management;
-	struct rmi_button_map *f19_button_map;
-	struct rmi_button_map *f1a_button_map;
-	struct rmi_f30_gpioled_map *gpioled_map;
-	struct rmi_button_map *f41_button_map;
-
-#ifdef CONFIG_RMI4_FWLIB
-	char *firmware_name;
-#endif
 };
 
 /**
-- 
1.8.1.5

