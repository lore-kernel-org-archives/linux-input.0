From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: input:rohm based bu21013 touch panel controller driver support
Date: Tue, 31 Aug 2010 08:48:04 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C1057916DE6765F2@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:47500 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755998Ab0HaGsY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 02:48:24 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

Added the rohm based bu21013 capacitive touch panel controller
driver support in level mode.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
---
 drivers/input/touchscreen/Kconfig      |   12 +
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/bu21013_ts.c |  796 ++++++++++++++++++++++++++++++++
 include/linux/input/bu21013.h          |  160 +++++++
 4 files changed, 969 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 drivers/input/touchscreen/Kconfig
 mode change 100644 => 100755 drivers/input/touchscreen/Makefile
 create mode 100644 drivers/input/touchscreen/bu21013_ts.c
 create mode 100644 include/linux/input/bu21013.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
old mode 100644
new mode 100755
index 0069d97..d560e21
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -638,4 +638,16 @@ config TOUCHSCREEN_STMPE
          To compile this driver as a module, choose M here: the
          module will be called stmpe-ts.

+config TOUCHSCREEN_BU21013
+       tristate "BU21013 based touch panel controllers"
+       depends on I2C
+       help
+         Say Y here if you have a bu21013 touchscreen connected to
+         your system.
+
+         If unsure, say N.
+
+         To compile this driver as a module, choose M here: the
+         module will be called bu21013_ts.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
old mode 100644
new mode 100755
index 28217e1..77615e1
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)    += mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)      += zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)      += w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)     += tps6507x-ts.o
+obj-$(CONFIG_TOUCHSCREEN_BU21013)      += bu21013_ts.o
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
new file mode 100644
index 0000000..c2e22f3
--- /dev/null
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -0,0 +1,796 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2009
+ * Author: Naveen Kumar G <naveen.gaddipati@stericsson.com> for ST-Ericsson
+ * License terms:GNU General Public License (GPL) version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+#include <linux/input.h>
+#include <linux/types.h>
+#include <linux/timer.h>
+#include <linux/input/bu21013.h>
+#include <linux/slab.h>
+
+#define PEN_DOWN_INTR 0
+#define PEN_UP_INTR 1
+#define RESET_DELAY 30
+#define POLLING_DELAY 100
+#define MAX_TOOL_WIDTH 15
+#define MAX_TOUCH_MAJOR 255
+#define MAX_TOUCH_MINOR 15
+#define MAX_PRESSURE 1
+#define PENUP_TIMEOUT (2)
+#define SCALE_FACTOR 1000
+#define DELTA_MIN 16
+#define MASK_BITS 0x03
+#define SHIFT_8 8
+#define SHIFT_2 2
+#define LENGTH_OF_BUFFER 11
+
+#define DRIVER_TP "bu21013_tp"
+
+/**
+ * struct bu21013_ts_data - touch panel data structure
+ * @client:    pointer to the i2c client
+ * @chip:      pointer to the touch panel controller
+ * @in_dev:    pointer to the input device structure
+ * @penirq_timer: variable to the timer list structure
+ * @timer_wq_handler: variable to work structure for timer
+ * @gpio_wq_handler: work structure variable for gpio interrupt
+ * @intr_pin: interrupt pin value
+ * @x_pos: x position for two co-ordinates
+ * @y_pos: y position for two co-ordinates
+ * @factor_x: x scale factor
+ * @factor_y: y scale factor
+ * @previous_press_reported: last reported flag
+ *
+ * Tocuh panel device data structure
+ */
+struct bu21013_ts_data {
+       struct i2c_client *client;
+       struct bu21013_platform_device *chip;
+       struct input_dev *in_dev;
+       struct timer_list penirq_timer;
+       struct work_struct timer_wq_handler;
+       struct work_struct gpio_wq_handler;
+       unsigned int intr_pin;
+       signed short    x_pos[2];
+       signed short    y_pos[2];
+       int     factor_x;
+       int     factor_y;
+       bool previous_press_reported;
+};
+
+/*
+ * bu21013_get_number_of_bits() - count the bits in given value
+ * @val: read bits from this value
+ * @range: maximum number of bits
+ *
+ * Read the number of bits from the given value
+ * and returns integer
+ */
+static inline int bu21013_get_number_of_bits(unsigned int val, int range)
+{
+       int i;
+       int num = 0;
+       unsigned int mask = 1;
+
+       for (i = 0; i < range; i++) {
+               if (val & mask)
+                       num++;
+               mask = mask << 1;
+       }
+       return num;
+}
+/**
+ * bu21013_report_pen_down() - reports the pen down event
+ * @data:bu21013_ts_data structure pointer
+ * @count:touch count
+ *
+ * This function used to report the pen down interrupt to
+ * input subsystem and returns none
+ */
+static void bu21013_report_pen_down(struct bu21013_ts_data *data, int count)
+{
+       short pt0x;
+       short pt0y;
+       short pt1x;
+       short pt1y;
+       if (data->chip->portrait) {
+               pt0x = data->x_pos[0];
+               pt0y = data->y_pos[0];
+               pt1x = data->x_pos[1];
+               pt1y = data->y_pos[1];
+       } else {
+               pt0x = data->y_pos[0];
+               pt0y = data->x_pos[0];
+               pt1x = data->y_pos[1];
+               pt1y = data->x_pos[1];
+       }
+
+       input_report_abs(data->in_dev, ABS_X, pt0x);
+       input_report_abs(data->in_dev, ABS_Y, pt0y);
+       input_report_abs(data->in_dev, ABS_PRESSURE, 1);
+       input_report_abs(data->in_dev, ABS_TOOL_WIDTH, 1);
+       input_report_key(data->in_dev, BTN_TOUCH, 1);
+
+       if (count > 1) {
+               input_report_key(data->in_dev, BTN_2, 1);
+               input_report_abs(data->in_dev, ABS_HAT0X, pt1x);
+               input_report_abs(data->in_dev, ABS_HAT0Y, pt1y);
+       }
+       input_report_abs(data->in_dev, ABS_MT_TOUCH_MAJOR, 1);
+       input_report_abs(data->in_dev, ABS_MT_TOUCH_MINOR, 1);
+       input_report_key(data->in_dev, ABS_MT_WIDTH_MAJOR, 1);
+       input_report_abs(data->in_dev, ABS_MT_POSITION_X, pt0x);
+       input_report_abs(data->in_dev, ABS_MT_POSITION_Y, pt0y);
+       input_mt_sync(data->in_dev);
+
+       if (count > 1) {
+               input_report_abs(data->in_dev, ABS_MT_TOUCH_MAJOR, 1);
+               input_report_key(data->in_dev, ABS_MT_WIDTH_MAJOR, 1);
+               input_report_abs(data->in_dev, ABS_MT_POSITION_X, pt1x);
+               input_report_abs(data->in_dev, ABS_MT_POSITION_Y, pt1y);
+               input_mt_sync(data->in_dev);
+       }
+       input_sync(data->in_dev);
+       data->previous_press_reported = count;
+}
+/**
+ * bu21013_report_pen_up() - reports the pen up event
+ * @data:bu21013_ts_data structure pointer
+ *
+ * This function used to report the pen up interrupt
+ * to input subsystem and returns none
+ */
+static void bu21013_report_pen_up(struct bu21013_ts_data *data)
+{
+       input_report_abs(data->in_dev, ABS_PRESSURE, 0);
+       input_report_abs(data->in_dev, ABS_TOOL_WIDTH, 0);
+       input_report_key(data->in_dev, BTN_TOUCH, 0);
+       input_report_key(data->in_dev, BTN_2, 0);
+       input_report_abs(data->in_dev, ABS_MT_TOUCH_MAJOR, 0);
+       input_report_key(data->in_dev, ABS_MT_WIDTH_MAJOR, 0);
+       input_mt_sync(data->in_dev);
+       input_sync(data->in_dev);
+       data->previous_press_reported = 0;
+}
+/**
+ * bu21013_touch_calc() - calculates the co-ordinates delta
+ * @data: bu21013_ts_data structure pointer
+ * @x: x position
+ * @y: y position
+ * @count: touch count
+ *
+ * This function calculates the exact co-ordinates with respect to
+ * display resolution and returns none
+ */
+static void bu21013_touch_calc
+       (struct bu21013_ts_data *data, int x, int y, int count)
+{
+       data->x_pos[count] = x * data->factor_x / SCALE_FACTOR;
+       data->y_pos[count] = y * data->factor_y / SCALE_FACTOR;
+       if ((data->chip->portrait) && (data->chip->x_flip))
+               data->x_pos[count] =
+                       data->chip->x_max_res - data->x_pos[count];
+       if ((data->chip->portrait) && (data->chip->y_flip))
+               data->y_pos[count] =
+                       data->chip->y_max_res - data->y_pos[count];
+}
+/**
+ * bu21013_verify_delta() - verify the co-ordinates delta
+ * @x1: x1 position
+ * @y1: y1 position
+ * @x2: x2 position
+ * @y2: y2 position
+ *
+ * This function verifies the delta of the
+ * co-ordinates and returns boolean.
+ */
+static bool bu21013_verify_delta(int x1, int y1, int x2, int y2)
+{
+       int delta_x, delta_y;
+       if ((x1 != 0) && (y1 != 0)) {
+               delta_x = x2 - x1;
+               if (x1 > x2)
+                       delta_x = x1 - x2;
+               delta_y = y2 - y1;
+               if (y1 > y2)
+                       delta_y = y1 - y2;
+               if ((delta_x < DELTA_MIN) || (delta_y < DELTA_MIN))
+                       return false;
+       }
+       return true;
+}
+
+/**
+ * bu21013_do_touch_report(): Get the touch co-ordinates
+ * @data:bu21013_ts_data structure pointer
+ *
+ * Get the touch co-ordinates from touch sensor registers and writes
+ * into device structure and returns integer.
+ */
+static int bu21013_do_touch_report(struct bu21013_ts_data *data)
+{
+       u8      buf[LENGTH_OF_BUFFER];
+       int     finger1_valid = 0;
+       int     finger2_valid = 0;
+       unsigned int    finger1_pos_x;
+       unsigned int    finger1_pos_y;
+       unsigned int    finger2_pos_x;
+       unsigned int    finger2_pos_y;
+       int     number_of_active_x_sensors;
+       int     number_of_active_y_sensors;
+       int     total_number_of_active_sensors;
+       int     finger_down_count = 0;
+       int     ret = 0;
+
+       if (data->client == NULL)
+               return -EINVAL;
+
+       ret = i2c_smbus_read_i2c_block_data(data->client,
+                                               BU21013_SENSORS_BTN_0_7_REG,
+                                                       LENGTH_OF_BUFFER, buf);
+       if (ret < LENGTH_OF_BUFFER)
+               return -EINVAL;
+
+       number_of_active_x_sensors =
+               bu21013_get_number_of_bits((buf[0] & BU21013_SENSORS_EN_0_7),
+                                               BU21013_NUMBER_OF_X_SENSORS);
+
+       number_of_active_y_sensors = bu21013_get_number_of_bits
+               ((((buf[1] & BU21013_SENSORS_EN_8_15) |
+               ((buf[2] & BU21013_SENSORS_EN_16_23) << SHIFT_8)) >> SHIFT_2),
+                                               BU21013_NUMBER_OF_Y_SENSORS);
+
+       if (((number_of_active_x_sensors != 0) &&
+               (number_of_active_y_sensors == 0)) ||
+               ((number_of_active_x_sensors == 0) &&
+               (number_of_active_y_sensors != 0)))
+               return 0;
+
+       total_number_of_active_sensors =
+               number_of_active_x_sensors + number_of_active_y_sensors;
+
+       finger1_pos_x = buf[3] << SHIFT_2 | (buf[4] & MASK_BITS);
+       finger1_pos_y = buf[5] << SHIFT_2 | (buf[6] & MASK_BITS);
+       finger2_pos_x = buf[7] << SHIFT_2 | (buf[8] & MASK_BITS);
+       finger2_pos_y = buf[9] << SHIFT_2 | (buf[10] & MASK_BITS);
+
+       if (total_number_of_active_sensors) {
+               if ((finger2_pos_x != 0) && (finger2_pos_y != 0)) {
+                       if ((finger1_pos_x == 0) || (finger1_pos_y == 0))
+                               return 0;
+                       ret = bu21013_verify_delta(finger1_pos_x,
+                               finger1_pos_y, finger2_pos_x, finger2_pos_y);
+                       if (!ret)
+                               total_number_of_active_sensors = 0;
+               }
+       }
+
+       if (total_number_of_active_sensors) {
+               finger1_valid = 1;
+               if ((finger1_pos_x == 0) || (finger1_pos_y == 0) ||
+                       (finger1_pos_x >= data->chip->touch_x_max) ||
+                       (finger1_pos_y >= data->chip->touch_y_max))
+                       finger1_valid = 0;
+               finger2_valid = 1;
+               if ((finger2_pos_x == 0) || (finger2_pos_y == 0) ||
+                       (finger2_pos_x >= data->chip->touch_x_max) ||
+                       (finger2_pos_y >= data->chip->touch_y_max))
+                       finger2_valid = 0;
+               if ((finger1_valid == 0) && (finger2_valid == 0))
+                       return 0;
+               if (finger1_valid) {
+                       bu21013_touch_calc(data, finger1_pos_x,
+                               finger1_pos_y, finger_down_count);
+                       finger_down_count++;
+               }
+               if (finger2_valid) {
+                       bu21013_touch_calc(data, finger2_pos_x,
+                               finger2_pos_y, finger_down_count);
+                       finger_down_count++;
+               }
+       }
+
+       if (finger_down_count > 0)
+               bu21013_report_pen_down(data, finger_down_count);
+       else {
+               if (data->previous_press_reported)
+                       bu21013_report_pen_up(data);
+       }
+
+       return ret;
+}
+
+/**
+ * bu21013_timer_start() - start the timer
+ * @data:bu21013_ts_data structure pointer
+ *
+ * This function used to run the mod timer for every timeout period
+ * and returns none
+ */
+static inline void bu21013_timer_start(struct bu21013_ts_data *data)
+{
+       mod_timer(&data->penirq_timer,
+               jiffies + msecs_to_jiffies(PENUP_TIMEOUT));
+}
+
+/**
+ * bu21013_timer_wq() - work queue for timer handler
+ * @work:work_struct structure pointer
+ *
+ * This timer work queue used during polling of the co-ordinates
+ * for every timeout period and returns none
+ */
+static void bu21013_timer_wq(struct work_struct *work)
+{
+       struct bu21013_ts_data *data =
+               container_of(work, struct bu21013_ts_data, timer_wq_handler);
+       struct task_struct *tsk = current;
+       struct i2c_client *i2c = data->client;
+       int retval;
+
+       set_task_state(tsk, TASK_INTERRUPTIBLE);
+       retval = bu21013_do_touch_report(data);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "get co-ordinates failed\n");
+               return;
+       }
+       data->intr_pin = data->chip->irq_read_val();
+       if (data->intr_pin == PEN_DOWN_INTR)
+               bu21013_timer_start(data);
+       else
+               enable_irq(data->chip->irq);
+}
+/**
+ * bu21013_gpio_int_wq() - work queue for gpio interrupt handler
+ * @work:work_struct structure pointer
+ *
+ * This gpio work queue used to get the co-ordinates
+ * of the pen down interrupt and returns none
+ */
+static void bu21013_gpio_int_wq(struct work_struct *work)
+{
+       struct bu21013_ts_data *data =
+               container_of(work, struct bu21013_ts_data, gpio_wq_handler);
+       struct i2c_client *i2c = data->client;
+       struct task_struct *tsk = current;
+       int retval;
+
+       set_task_state(tsk, TASK_INTERRUPTIBLE);
+       disable_irq(data->chip->irq);
+       retval = bu21013_do_touch_report(data);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "get co-ordinates failed\n");
+               return;
+       }
+       bu21013_timer_start(data);
+}
+
+/**
+ * bu21013_gpio_irq() - gpio callback handler for touch interrupt
+ * @irq: irq value
+ * @device_data:void pointer
+ *
+ * This gpio callback handler for gpio interrupt
+ * and assigns the task and returns irqreturn_t.
+ */
+static irqreturn_t bu21013_gpio_irq(int irq, void *device_data)
+{
+       struct bu21013_ts_data *data = (struct bu21013_ts_data *)device_data;
+
+       schedule_work(&data->gpio_wq_handler);
+
+       return IRQ_HANDLED;
+}
+
+/**
+ * bu21013_timer_callback() - callback handler for timer
+ * @dev_data:touch screen data
+ *
+ * This timer callback handler used to schedule the work during
+ * polling of pen down interrupts and returns none
+ */
+static void bu21013_timer_callback(unsigned long dev_data)
+{
+       struct bu21013_ts_data *data = (struct bu21013_ts_data *)dev_data;
+       schedule_work(&data->timer_wq_handler);
+}
+
+/**
+ * bu21013_init_chip() - power on sequence for the bu21013 controller
+ * @data: device structure pointer
+ *
+ * This function is used to power on
+ * the bu21013 controller and returns integer.
+ */
+static int bu21013_init_chip(struct bu21013_ts_data *data)
+{
+       int retval;
+       struct i2c_client *i2c = data->client;
+
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_RESET_REG,
+                                       BU21013_RESET_ENABLE);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_RESET reg write failed\n");
+               goto err;
+       }
+       mdelay(RESET_DELAY);
+
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_SENSOR_0_7_REG,
+                                       BU21013_SENSORS_EN_0_7);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_SENSOR_0_7 reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_SENSOR_8_15_REG,
+                                       BU21013_SENSORS_EN_8_15);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_SENSOR_8_15 reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_SENSOR_16_23_REG,
+                                       BU21013_SENSORS_EN_16_23);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_SENSOR_16_23 reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_POS_MODE1_REG,
+                               (BU21013_POS_MODE1_0 | BU21013_POS_MODE1_1));
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_POS_MODE1 reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_POS_MODE2_REG,
+                       (BU21013_POS_MODE2_ZERO | BU21013_POS_MODE2_AVG1 |
+                       BU21013_POS_MODE2_AVG2 | BU21013_POS_MODE2_EN_RAW |
+                       BU21013_POS_MODE2_MULTI));
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_POS_MODE2 reg write failed\n");
+               goto err;
+       }
+       if (data->chip->ext_clk)
+               retval = i2c_smbus_write_byte_data(i2c, BU21013_CLK_MODE_REG,
+                       (BU21013_CLK_MODE_EXT | BU21013_CLK_MODE_CALIB));
+       else
+               retval = i2c_smbus_write_byte_data(i2c, BU21013_CLK_MODE_REG,
+                       (BU21013_CLK_MODE_DIV | BU21013_CLK_MODE_CALIB));
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_CLK_MODE reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_IDLE_REG,
+                               (BU21013_IDLET_0 | BU21013_IDLE_INTERMIT_EN));
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_IDLE reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_INT_MODE_REG,
+                                               BU21013_INT_MODE_LEVEL);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_INT_MODE reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_FILTER_REG,
+                                               (BU21013_DELTA_0_6 |
+                                                       BU21013_FILTER_EN));
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_FILTER reg write failed\n");
+               goto err;
+       }
+
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_TH_ON_REG,
+                                               (BU21013_TH_ON_3 |
+                                                       BU21013_TH_ON_4));
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_TH_ON reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_TH_OFF_REG,
+                                                       BU21013_TH_OFF_4);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_TH_OFF reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_GAIN_REG,
+                                               (BU21013_GAIN_0 |
+                                                       BU21013_GAIN_1));
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_GAIN reg write failed\n");
+               goto err;
+       }
+
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_OFFSET_MODE_REG,
+                                       BU21013_OFFSET_MODE_DEFAULT);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_OFFSET_MODE reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_XY_EDGE_REG,
+                       (BU21013_X_EDGE_0 | BU21013_X_EDGE_2 |
+                               BU21013_Y_EDGE_1 | BU21013_Y_EDGE_3));
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_XY_EDGE reg write failed\n");
+               goto err;
+       }
+       retval = i2c_smbus_write_byte_data(i2c, BU21013_DONE_REG,
+                                                       BU21013_DONE);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "BU21013_REG_DONE reg write failed\n");
+               goto err;
+       }
+
+       data->x_pos[0] = 0;
+       data->x_pos[1] = 0;
+       data->y_pos[0] = 0;
+       data->y_pos[1] = 0;
+       data->previous_press_reported = 0;
+
+       data->factor_x = (data->chip->x_max_res * SCALE_FACTOR /
+                                       data->chip->touch_x_max);
+       data->factor_y = (data->chip->y_max_res * SCALE_FACTOR /
+                                       data->chip->touch_y_max);
+err:
+       return retval;
+}
+
+#ifdef CONFIG_PM
+/**
+ * bu21013_suspend() - suspend the touch screen controller
+ * @client: pointer to i2c client structure
+ * @mesg: message from power manager
+ *
+ * This funtion is used to suspend the
+ * touch panel controller and returns integer
+ */
+static int bu21013_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+       struct bu21013_ts_data *bu21013_data = i2c_get_clientdata(client);
+
+       if (device_may_wakeup(&client->dev))
+               enable_irq(bu21013_data->chip->irq);
+       else
+               disable_irq(bu21013_data->chip->irq);
+
+       return 0;
+}
+
+/**
+ * bu21013_resume() - resume the touch screen controller
+ * @client: pointer to i2c client structure
+ *
+ * This funtion is used to resume the touch panel
+ * controller and returns integer.
+ */
+static int bu21013_resume(struct i2c_client *client)
+{
+       int retval;
+       struct bu21013_ts_data *bu21013_data = i2c_get_clientdata(client);
+
+       retval = bu21013_init_chip(bu21013_data);
+       if (retval < 0) {
+               dev_err(&client->dev, "tsc config failed\n");
+               goto err;
+       }
+
+       if (device_may_wakeup(&client->dev))
+               disable_irq(bu21013_data->chip->irq);
+       else
+               enable_irq(bu21013_data->chip->irq);
+
+       return 0;
+err:
+       kfree(bu21013_data);
+       return retval;
+}
+#endif
+
+/**
+ * bu21013_probe() - initialzes the i2c-client touchscreen driver
+ * @i2c: i2c client structure pointer
+ * @id:i2c device id pointer
+ *
+ * This function used to initializes the i2c-client touchscreen
+ * driver and returns integer.
+ */
+static int bu21013_probe(struct i2c_client *i2c,
+                                       const struct i2c_device_id *id)
+{
+       int retval;
+       struct bu21013_ts_data *bu21013_data;
+       struct input_dev *in_dev;
+       short x_max;
+       short y_max;
+       struct bu21013_platform_device *pdata = i2c->dev.platform_data;
+
+       if (!pdata) {
+               dev_err(&i2c->dev, "platform data not defined\n");
+               retval = -EINVAL;
+               return retval;
+       }
+
+       bu21013_data = kzalloc(sizeof(struct bu21013_ts_data), GFP_KERNEL);
+       if (!bu21013_data) {
+               dev_err(&i2c->dev, "device memory alloc failed\n");
+               retval = -ENOMEM;
+               return retval;
+       }
+
+       /* allocate input device */
+       in_dev = input_allocate_device();
+       if (!in_dev) {
+               dev_err(&i2c->dev, "input device memory alloc failed\n");
+               retval = -ENOMEM;
+               goto err_alloc;
+       }
+       bu21013_data->in_dev = in_dev;
+       bu21013_data->chip = pdata;
+       bu21013_data->client = i2c;
+
+       if (bu21013_data->chip->portrait) {
+               x_max = pdata->x_max_res;
+               y_max = pdata->y_max_res;
+       } else {
+               x_max = pdata->y_max_res;
+               y_max = pdata->x_max_res;
+       }
+
+       INIT_WORK(&bu21013_data->timer_wq_handler, bu21013_timer_wq);
+       INIT_WORK(&bu21013_data->gpio_wq_handler, bu21013_gpio_int_wq);
+
+       init_timer(&bu21013_data->penirq_timer);
+       bu21013_data->penirq_timer.data = (unsigned long)bu21013_data;
+       bu21013_data->penirq_timer.function = bu21013_timer_callback;
+       i2c_set_clientdata(i2c, bu21013_data);
+
+       /* configure the gpio pins */
+       if (pdata->cs_en) {
+               retval = pdata->cs_en(pdata->cs_pin);
+               if (retval < 0) {
+                       dev_err(&i2c->dev, "chip init failed\n");
+                       goto err_init_cs;
+               }
+       }
+
+       /* configure the touch panel controller */
+       retval = bu21013_init_chip(bu21013_data);
+       if (retval < 0) {
+               dev_err(&i2c->dev, "error in bu21013 config\n");
+               goto err_init_config;
+       }
+
+       in_dev->name = DRIVER_TP;
+       set_bit(EV_SYN, in_dev->evbit);
+       set_bit(EV_KEY, in_dev->evbit);
+       set_bit(EV_ABS, in_dev->evbit);
+       set_bit(BTN_TOUCH, in_dev->keybit);
+
+       input_set_abs_params(in_dev, ABS_X, 0, x_max, 0, 0);
+       input_set_abs_params(in_dev, ABS_Y, 0, y_max, 0, 0);
+       input_set_abs_params(in_dev, ABS_PRESSURE, 0, MAX_PRESSURE, 0, 0);
+       input_set_abs_params(in_dev, ABS_TOOL_WIDTH, 0, MAX_TOOL_WIDTH, 0, 0);
+
+       set_bit(BTN_2, in_dev->keybit);
+       input_set_abs_params(in_dev, ABS_HAT0X, 0, x_max, 0, 0);
+       input_set_abs_params(in_dev, ABS_HAT0Y, 0, y_max, 0, 0);
+       input_set_abs_params(in_dev, ABS_MT_POSITION_X, 0, x_max, 0, 0);
+       input_set_abs_params(in_dev, ABS_MT_POSITION_Y, 0, y_max, 0, 0);
+       input_set_abs_params(in_dev, ABS_MT_TOUCH_MAJOR, 0, MAX_TOUCH_MAJOR,
+                                                                       0, 0);
+       input_set_abs_params
+               (in_dev, ABS_MT_TOUCH_MINOR, 0, MAX_TOUCH_MINOR, 0, 0);
+       input_set_abs_params(in_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
+       input_set_abs_params(in_dev, ABS_MT_WIDTH_MAJOR, 0, MAX_TOOL_WIDTH,
+                                                                       0, 0);
+       retval = input_register_device(in_dev);
+       if (retval)
+               goto err_input_register;
+
+       retval = request_irq(pdata->irq, bu21013_gpio_irq,
+                                       (IRQF_TRIGGER_FALLING | IRQF_SHARED),
+                                       DRIVER_TP, bu21013_data);
+       if (retval) {
+               dev_err(&i2c->dev, "request irq %d failed\n", pdata->irq);
+               goto err_init_irq;
+       }
+
+       dev_dbg(&i2c->dev, "init done");
+
+       return retval;
+
+err_init_irq:
+       input_unregister_device(bu21013_data->in_dev);
+       bu21013_data->in_dev = NULL;
+err_input_register:
+err_init_config:
+       pdata->cs_dis(pdata->cs_pin);
+err_init_cs:
+       del_timer_sync(&bu21013_data->penirq_timer);
+       cancel_work_sync(&bu21013_data->timer_wq_handler);
+       cancel_work_sync(&bu21013_data->gpio_wq_handler);
+       input_free_device(bu21013_data->in_dev);
+err_alloc:
+       kfree(bu21013_data);
+       return retval;
+}
+
+/**
+ * bu21013_remove() - removes the i2c-client touchscreen driver
+ * @client: i2c client structure pointer
+ *
+ * This function uses to remove the i2c-client
+ * touchscreen driver and returns integer.
+ */
+static int __devexit bu21013_remove(struct i2c_client *client)
+{
+       struct bu21013_ts_data *data = i2c_get_clientdata(client);
+
+       del_timer_sync(&data->penirq_timer);
+       cancel_work_sync(&data->timer_wq_handler);
+       cancel_work_sync(&data->gpio_wq_handler);
+
+       if (data->chip != NULL) {
+               free_irq(data->chip->irq, data);
+               data->chip->cs_dis(data->chip->cs_pin);
+       }
+       input_unregister_device(data->in_dev);
+       kfree(data);
+
+       return 0;
+}
+
+static const struct i2c_device_id bu21013_id[] = {
+       { DRIVER_TP, 0 },
+       { DRIVER_TP, 0 },
+       { }
+};
+MODULE_DEVICE_TABLE(i2c, bu21013_id);
+
+static struct i2c_driver bu21013_driver = {
+       .driver = {
+               .name   =       DRIVER_TP,
+               .owner  =       THIS_MODULE,
+       },
+       .probe          =       bu21013_probe,
+#ifdef CONFIG_PM
+       .suspend        =       bu21013_suspend,
+       .resume         =       bu21013_resume,
+#endif
+       .remove         =       __devexit_p(bu21013_remove),
+       .id_table       =       bu21013_id,
+};
+
+/**
+ * bu21013_init() - initializes the bu21013 touchscreen driver
+ *
+ * This function used to initializes the bu21013
+ * touchscreen driver and returns integer.
+ */
+static int __init bu21013_init(void)
+{
+       return i2c_add_driver(&bu21013_driver);
+}
+
+/**
+ * bu21013_exit() - de-initializes the bu21013 touchscreen driver
+ *
+ * This function uses to de-initializes the bu21013
+ * touchscreen driver and returns none.
+ */
+static void __exit bu21013_exit(void)
+{
+       i2c_del_driver(&bu21013_driver);
+}
+
+module_init(bu21013_init);
+module_exit(bu21013_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("NAVEEN KUMAR G");
+MODULE_DESCRIPTION("bu21013 touch screen controller driver");
diff --git a/include/linux/input/bu21013.h b/include/linux/input/bu21013.h
new file mode 100644
index 0000000..fd3cdf2
--- /dev/null
+++ b/include/linux/input/bu21013.h
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2009
+ * Author: Naveen Kumar G <naveen.gaddipati@stericsson.com> for ST-Ericsson
+ * License terms:GNU General Public License (GPL) version 2
+ */
+
+#ifndef _BU21013_H
+#define _BU21013_H
+
+/*
+ * Touch screen register offsets
+ */
+#define BU21013_SENSORS_BTN_0_7_REG    0x70
+#define BU21013_SENSORS_BTN_8_15_REG   0x71
+#define BU21013_SENSORS_BTN_16_23_REG  0x72
+#define BU21013_X1_POS_MSB_REG         0x73
+#define BU21013_X1_POS_LSB_REG         0x74
+#define BU21013_Y1_POS_MSB_REG         0x75
+#define BU21013_Y1_POS_LSB_REG         0x76
+#define BU21013_X2_POS_MSB_REG         0x77
+#define BU21013_X2_POS_LSB_REG         0x78
+#define BU21013_Y2_POS_MSB_REG         0x79
+#define BU21013_Y2_POS_LSB_REG         0x7A
+#define BU21013_INT_CLR_REG            0xE8
+#define BU21013_INT_MODE_REG           0xE9
+#define BU21013_GAIN_REG               0xEA
+#define BU21013_OFFSET_MODE_REG                0xEB
+#define BU21013_XY_EDGE_REG            0xEC
+#define BU21013_RESET_REG              0xED
+#define BU21013_CALIB_REG              0xEE
+#define BU21013_DONE_REG               0xEF
+#define BU21013_SENSOR_0_7_REG         0xF0
+#define BU21013_SENSOR_8_15_REG                0xF1
+#define BU21013_SENSOR_16_23_REG       0xF2
+#define BU21013_POS_MODE1_REG          0xF3
+#define BU21013_POS_MODE2_REG          0xF4
+#define BU21013_CLK_MODE_REG           0xF5
+#define BU21013_IDLE_REG               0xFA
+#define BU21013_FILTER_REG             0xFB
+#define BU21013_TH_ON_REG              0xFC
+#define BU21013_TH_OFF_REG             0xFD
+
+/* Touch screen register offset values */
+#define BU21013_RESET_ENABLE           0x01
+/* Sensors Configuration */
+#define BU21013_SENSORS_EN_0_7         0x3F
+#define BU21013_SENSORS_EN_8_15                0xFC
+#define BU21013_SENSORS_EN_16_23       0x1F
+
+/* Position mode1 */
+#define BU21013_POS_MODE1_0            0x02
+#define BU21013_POS_MODE1_1            0x04
+#define BU21013_POS_MODE1_2            0x08
+
+/* Position mode2 */
+#define BU21013_POS_MODE2_ZERO         0x01
+#define BU21013_POS_MODE2_AVG1         0x02
+#define BU21013_POS_MODE2_AVG2         0x04
+#define BU21013_POS_MODE2_EN_XY                0x08
+#define BU21013_POS_MODE2_EN_RAW       0x10
+#define BU21013_POS_MODE2_MULTI                0x80
+
+/* Clock mode */
+#define BU21013_CLK_MODE_DIV           0x01
+#define BU21013_CLK_MODE_EXT           0x02
+#define BU21013_CLK_MODE_CALIB         0x80
+
+/* IDLE time */
+#define BU21013_IDLET_0                        0x01
+#define BU21013_IDLET_1                        0x02
+#define BU21013_IDLET_2                        0x04
+#define BU21013_IDLET_3                        0x08
+#define BU21013_IDLE_INTERMIT_EN       0x10
+
+/* FILTER reg values */
+#define BU21013_DELTA_0_6              0x7F
+#define BU21013_FILTER_EN              0x80
+
+/* interrupt mode */
+#define BU21013_INT_MODE_LEVEL         0x00
+#define BU21013_INT_MODE_EDGE          0x01
+
+/* Gain reg values */
+#define BU21013_GAIN_0                 0x01
+#define BU21013_GAIN_1                 0x02
+#define BU21013_GAIN_2                 0x04
+
+/* OFFSET mode */
+#define BU21013_OFFSET_MODE_DEFAULT    0x00
+#define BU21013_OFFSET_MODE_MOVE       0x01
+#define BU21013_OFFSET_MODE_DISABLE    0x02
+
+/* Threshold ON values */
+#define BU21013_TH_ON_0                        0x01
+#define BU21013_TH_ON_1                        0x02
+#define BU21013_TH_ON_2                        0x04
+#define BU21013_TH_ON_3                        0x08
+#define BU21013_TH_ON_4                        0x10
+#define BU21013_TH_ON_5                        0x20
+#define BU21013_TH_ON_6                        0x40
+#define BU21013_TH_ON_7                        0x80
+
+/* Threshold OFF values */
+#define BU21013_TH_OFF_0               0x01
+#define BU21013_TH_OFF_1               0x02
+#define BU21013_TH_OFF_2               0x04
+#define BU21013_TH_OFF_3               0x08
+#define BU21013_TH_OFF_4               0x10
+#define BU21013_TH_OFF_5               0x20
+#define BU21013_TH_OFF_6               0x40
+#define BU21013_TH_OFF_7               0x80
+
+/* FILTER reg values */
+#define BU21013_X_EDGE_0               0x01
+#define BU21013_X_EDGE_1               0x02
+#define BU21013_X_EDGE_2               0x04
+#define BU21013_X_EDGE_3               0x08
+#define BU21013_Y_EDGE_0               0x10
+#define BU21013_Y_EDGE_1               0x20
+#define BU21013_Y_EDGE_2               0x40
+#define BU21013_Y_EDGE_3               0x80
+
+#define BU21013_DONE                   0x01
+#define BU21013_NUMBER_OF_X_SENSORS    (6)
+#define BU21013_NUMBER_OF_Y_SENSORS    (11)
+
+/**
+ * struct bu21013_platform_device - Handle the platform data
+ * @cs_en:     pointer to the cs enable function
+ * @cs_dis:    pointer to the cs disable function
+ * @irq_read_val:    pointer to read the pen irq value function
+ * @x_max_res: xmax resolution
+ * @y_max_res: ymax resolution
+ * @touch_x_max: touch x max
+ * @touch_y_max: touch y max
+ * @cs_pin: chip select pin
+ * @irq: irq pin
+ * @ext_clk_en: external clock flag
+ * @portrait: portrait mode flag
+ * @x_flip: x flip flag
+ * @y_flip: y flip flag
+ * This is used to handle the platform data
+ **/
+struct bu21013_platform_device {
+       int (*cs_en)(int reset_pin);
+       int (*cs_dis)(int reset_pin);
+       int (*irq_read_val)(void);
+       int x_max_res;
+       int y_max_res;
+       int touch_x_max;
+       int touch_y_max;
+       unsigned int cs_pin;
+       unsigned int irq;
+       bool portrait;
+       bool ext_clk;
+       bool x_flip;
+       bool y_flip;
+};
+
+#endif
--
1.7.2.dirty

