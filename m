From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: input:rohm based bu21013 touch panel controller driver support
Date: Tue, 07 Sep 2010 18:04:01 +0530
Message-ID: <4C863139.1050307@codeaurora.org>
References: <81C3A93C17462B4BBD7E272753C1057916DE6765F2@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:18593 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648Ab0IGMeI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Sep 2010 08:34:08 -0400
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057916DE6765F2@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Naveen,

On 8/31/2010 12:18 PM, Naveen Kumar GADDIPATI wrote:
> From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> 
> Added the rohm based bu21013 capacitive touch panel controller
> driver support in level mode.

What is level mode and "rohm"? Could you please add more description?

> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> ---
>  drivers/input/touchscreen/Kconfig      |   12 +
>  drivers/input/touchscreen/Makefile     |    1 +
>  drivers/input/touchscreen/bu21013_ts.c |  796 ++++++++++++++++++++++++++++++++
>  include/linux/input/bu21013.h          |  160 +++++++
>  4 files changed, 969 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 drivers/input/touchscreen/Kconfig
>  mode change 100644 => 100755 drivers/input/touchscreen/Makefile

Permission problems. I am not sure if I am repeating the comments given by Dmitry, but I will
go through again.

> diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
> new file mode 100644
> index 0000000..c2e22f3
> --- /dev/null
> +++ b/drivers/input/touchscreen/bu21013_ts.c
> @@ -0,0 +1,796 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2009

still want to keep 2009?

> +
> +#define PEN_DOWN_INTR 0
> +#define PEN_UP_INTR 1
> +#define RESET_DELAY 30
> +#define POLLING_DELAY 100
> +#define MAX_TOOL_WIDTH 15
> +#define MAX_TOUCH_MAJOR 255
> +#define MAX_TOUCH_MINOR 15
> +#define MAX_PRESSURE 1
> +#define PENUP_TIMEOUT (2)
> +#define SCALE_FACTOR 1000
> +#define DELTA_MIN 16
> +#define MASK_BITS 0x03
> +#define SHIFT_8 8
> +#define SHIFT_2 2
> +#define LENGTH_OF_BUFFER 11
> +
> +static void bu21013_report_pen_down(struct bu21013_ts_data *data, int count)
> +{
> +       short pt0x;
> +       short pt0y;
> +       short pt1x;
> +       short pt1y;
> +       if (data->chip->portrait) {
> +               pt0x = data->x_pos[0];
> +               pt0y = data->y_pos[0];
> +               pt1x = data->x_pos[1];
> +               pt1y = data->y_pos[1];
> +       } else {
> +               pt0x = data->y_pos[0];
> +               pt0y = data->x_pos[0];
> +               pt1x = data->y_pos[1];
> +               pt1y = data->x_pos[1];
> +       }
> +
> +       input_report_abs(data->in_dev, ABS_X, pt0x);
> +       input_report_abs(data->in_dev, ABS_Y, pt0y);
> +       input_report_abs(data->in_dev, ABS_PRESSURE, 1);
> +       input_report_abs(data->in_dev, ABS_TOOL_WIDTH, 1);
> +       input_report_key(data->in_dev, BTN_TOUCH, 1);
> +
> +       if (count > 1) {
> +               input_report_key(data->in_dev, BTN_2, 1);
> +               input_report_abs(data->in_dev, ABS_HAT0X, pt1x);
> +               input_report_abs(data->in_dev, ABS_HAT0Y, pt1y);
> +       }

HAT0X/0Y based MT support is not allowed. Please remove this stuff.

> +/**
> + * bu21013_touch_calc() - calculates the co-ordinates delta
> + * @data: bu21013_ts_data structure pointer
> + * @x: x position
> + * @y: y position
> + * @count: touch count
> + *
> + * This function calculates the exact co-ordinates with respect to
> + * display resolution and returns none
> + */
> +static void bu21013_touch_calc
> +       (struct bu21013_ts_data *data, int x, int y, int count)
> +{
> +       data->x_pos[count] = x * data->factor_x / SCALE_FACTOR;
> +       data->y_pos[count] = y * data->factor_y / SCALE_FACTOR;

As mentioned by Dmitry, this needs to be done by the userspace and not kernel driver.
Please remove such logic.

> +       if ((data->chip->portrait) && (data->chip->x_flip))
> +               data->x_pos[count] =
> +                       data->chip->x_max_res - data->x_pos[count];
> +       if ((data->chip->portrait) && (data->chip->y_flip))
> +               data->y_pos[count] =
> +                       data->chip->y_max_res - data->y_pos[count];
> +}
> +/**
> + * bu21013_verify_delta() - verify the co-ordinates delta
> + * @x1: x1 position
> + * @y1: y1 position
> + * @x2: x2 position
> + * @y2: y2 position
> + *
> + * This function verifies the delta of the
> + * co-ordinates and returns boolean.
> + */
> +static bool bu21013_verify_delta(int x1, int y1, int x2, int y2)
> +{
> +       int delta_x, delta_y;
> +       if ((x1 != 0) && (y1 != 0)) {

Care to put empty line between start of locals and actual code?

> +               delta_x = x2 - x1;
> +               if (x1 > x2)
> +                       delta_x = x1 - x2;
> +               delta_y = y2 - y1;
> +               if (y1 > y2)
> +                       delta_y = y1 - y2;
> +               if ((delta_x < DELTA_MIN) || (delta_y < DELTA_MIN))
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +/**
> + * bu21013_do_touch_report(): Get the touch co-ordinates
> + * @data:bu21013_ts_data structure pointer
> + *
> + * Get the touch co-ordinates from touch sensor registers and writes
> + * into device structure and returns integer.
> + */
> +static int bu21013_do_touch_report(struct bu21013_ts_data *data)
> +{
> +       u8      buf[LENGTH_OF_BUFFER];
> +       int     finger1_valid = 0;
> +       int     finger2_valid = 0;
> +       unsigned int    finger1_pos_x;
> +       unsigned int    finger1_pos_y;
> +       unsigned int    finger2_pos_x;
> +       unsigned int    finger2_pos_y;
> +       int     number_of_active_x_sensors;
> +       int     number_of_active_y_sensors;
> +       int     total_number_of_active_sensors;
> +       int     finger_down_count = 0;
> +       int     ret = 0;
> +
> +       if (data->client == NULL)
> +               return -EINVAL;

Do you think that client would be NULL here?

> +
> +/**
> + * bu21013_init_chip() - power on sequence for the bu21013 controller
> + * @data: device structure pointer
> + *
> + * This function is used to power on
> + * the bu21013 controller and returns integer.
> + */
> +static int bu21013_init_chip(struct bu21013_ts_data *data)
> +{
> +       int retval;
> +       struct i2c_client *i2c = data->client;
> +
> +       retval = i2c_smbus_write_byte_data(i2c, BU21013_RESET_REG,
> +                                       BU21013_RESET_ENABLE);
> +       if (retval < 0) {
> +               dev_err(&i2c->dev, "BU21013_RESET reg write failed\n");
> +               goto err;
> +       }
> +       mdelay(RESET_DELAY);

Why can't msleep?

> +#ifdef CONFIG_PM
> +/**
> + * bu21013_suspend() - suspend the touch screen controller
> + * @client: pointer to i2c client structure
> + * @mesg: message from power manager
> + *
> + * This funtion is used to suspend the
> + * touch panel controller and returns integer
> + */
> +static int bu21013_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +       struct bu21013_ts_data *bu21013_data = i2c_get_clientdata(client);
> +
> +       if (device_may_wakeup(&client->dev))
> +               enable_irq(bu21013_data->chip->irq);

Why not enable_irq_wake(..) friends along with it? Do you think that when the
touch interrupt wakes up the system I2C would have been ON to respond queries with your
chip? 

Touch interrupt processing will start as soon as you get the wakeup interrupt from TS,
and I think the i2c transactions would start failing because i2c-core is already
in suspended mode and even the resume of this driver is not yet called. Please check.

> +
> +       if (device_may_wakeup(&client->dev))
> +               disable_irq(bu21013_data->chip->irq);

May be just wake helpers would be fine.

> +       else
> +               enable_irq(bu21013_data->chip->irq);
> +
> +       return 0;
> +err:
> +       kfree(bu21013_data);
> +       return retval;
> +}
> +#endif
> +
> +/**
> + * bu21013_probe() - initialzes the i2c-client touchscreen driver
> + * @i2c: i2c client structure pointer
> + * @id:i2c device id pointer
> + *
> + * This function used to initializes the i2c-client touchscreen
> + * driver and returns integer.
> + */
> +static int bu21013_probe(struct i2c_client *i2c,
> +                                       const struct i2c_device_id *id)
> +{
> +       int retval;
> +       struct bu21013_ts_data *bu21013_data;
> +       struct input_dev *in_dev;
> +       short x_max;
> +       short y_max;
> +       struct bu21013_platform_device *pdata = i2c->dev.platform_data;
> +
> +       if (!pdata) {
> +               dev_err(&i2c->dev, "platform data not defined\n");
> +               retval = -EINVAL;
> +               return retval;
> +       }
> +
> +       bu21013_data = kzalloc(sizeof(struct bu21013_ts_data), GFP_KERNEL);
> +       if (!bu21013_data) {
> +               dev_err(&i2c->dev, "device memory alloc failed\n");
> +               retval = -ENOMEM;
> +               return retval;
> +       }
> +
> +       /* allocate input device */
> +       in_dev = input_allocate_device();
> +       if (!in_dev) {
> +               dev_err(&i2c->dev, "input device memory alloc failed\n");
> +               retval = -ENOMEM;
> +               goto err_alloc;
> +       }
> +       bu21013_data->in_dev = in_dev;
> +       bu21013_data->chip = pdata;
> +       bu21013_data->client = i2c;
> +
> +       if (bu21013_data->chip->portrait) {
> +               x_max = pdata->x_max_res;
> +               y_max = pdata->y_max_res;
> +       } else {
> +               x_max = pdata->y_max_res;
> +               y_max = pdata->x_max_res;
> +       }

Why we have to handle the display modes here?

> +
> +       in_dev->name = DRIVER_TP;
> +       set_bit(EV_SYN, in_dev->evbit);
> +       set_bit(EV_KEY, in_dev->evbit);
> +       set_bit(EV_ABS, in_dev->evbit);
> +       set_bit(BTN_TOUCH, in_dev->keybit);

__set_bit please.

> diff --git a/include/linux/input/bu21013.h b/include/linux/input/bu21013.h
> new file mode 100644
> index 0000000..fd3cdf2
> --- /dev/null
> +++ b/include/linux/input/bu21013.h
> @@ -0,0 +1,160 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2009
> + * Author: Naveen Kumar G <naveen.gaddipati@stericsson.com> for ST-Ericsson
> + * License terms:GNU General Public License (GPL) version 2
> + */
> +
> +#ifndef _BU21013_H
> +#define _BU21013_H
> +
> +/*
> + * Touch screen register offsets
> + */
> +#define BU21013_SENSORS_BTN_0_7_REG    0x70
> +#define BU21013_SENSORS_BTN_8_15_REG   0x71
> +#define BU21013_SENSORS_BTN_16_23_REG  0x72
> +#define BU21013_X1_POS_MSB_REG         0x73
> +#define BU21013_X1_POS_LSB_REG         0x74
> +#define BU21013_Y1_POS_MSB_REG         0x75
> +#define BU21013_Y1_POS_LSB_REG         0x76
> +#define BU21013_X2_POS_MSB_REG         0x77
> +#define BU21013_X2_POS_LSB_REG         0x78
> +#define BU21013_Y2_POS_MSB_REG         0x79
> +#define BU21013_Y2_POS_LSB_REG         0x7A
> +#define BU21013_INT_CLR_REG            0xE8
> +#define BU21013_INT_MODE_REG           0xE9
> +#define BU21013_GAIN_REG               0xEA
> +#define BU21013_OFFSET_MODE_REG                0xEB
> +#define BU21013_XY_EDGE_REG            0xEC
> +#define BU21013_RESET_REG              0xED
> +#define BU21013_CALIB_REG              0xEE
> +#define BU21013_DONE_REG               0xEF
> +#define BU21013_SENSOR_0_7_REG         0xF0
> +#define BU21013_SENSOR_8_15_REG                0xF1
> +#define BU21013_SENSOR_16_23_REG       0xF2
> +#define BU21013_POS_MODE1_REG          0xF3
> +#define BU21013_POS_MODE2_REG          0xF4
> +#define BU21013_CLK_MODE_REG           0xF5
> +#define BU21013_IDLE_REG               0xFA
> +#define BU21013_FILTER_REG             0xFB
> +#define BU21013_TH_ON_REG              0xFC
> +#define BU21013_TH_OFF_REG             0xFD
> +
> +/* Touch screen register offset values */
> +#define BU21013_RESET_ENABLE           0x01
> +/* Sensors Configuration */
> +#define BU21013_SENSORS_EN_0_7         0x3F
> +#define BU21013_SENSORS_EN_8_15                0xFC
> +#define BU21013_SENSORS_EN_16_23       0x1F
> +
> +/* Position mode1 */
> +#define BU21013_POS_MODE1_0            0x02
> +#define BU21013_POS_MODE1_1            0x04
> +#define BU21013_POS_MODE1_2            0x08
> +
> +/* Position mode2 */
> +#define BU21013_POS_MODE2_ZERO         0x01
> +#define BU21013_POS_MODE2_AVG1         0x02
> +#define BU21013_POS_MODE2_AVG2         0x04
> +#define BU21013_POS_MODE2_EN_XY                0x08
> +#define BU21013_POS_MODE2_EN_RAW       0x10
> +#define BU21013_POS_MODE2_MULTI                0x80
> +
> +/* Clock mode */
> +#define BU21013_CLK_MODE_DIV           0x01
> +#define BU21013_CLK_MODE_EXT           0x02
> +#define BU21013_CLK_MODE_CALIB         0x80
> +
> +/* IDLE time */
> +#define BU21013_IDLET_0                        0x01
> +#define BU21013_IDLET_1                        0x02
> +#define BU21013_IDLET_2                        0x04
> +#define BU21013_IDLET_3                        0x08
> +#define BU21013_IDLE_INTERMIT_EN       0x10
> +
> +/* FILTER reg values */
> +#define BU21013_DELTA_0_6              0x7F
> +#define BU21013_FILTER_EN              0x80
> +
> +/* interrupt mode */
> +#define BU21013_INT_MODE_LEVEL         0x00
> +#define BU21013_INT_MODE_EDGE          0x01
> +
> +/* Gain reg values */
> +#define BU21013_GAIN_0                 0x01
> +#define BU21013_GAIN_1                 0x02
> +#define BU21013_GAIN_2                 0x04
> +
> +/* OFFSET mode */
> +#define BU21013_OFFSET_MODE_DEFAULT    0x00
> +#define BU21013_OFFSET_MODE_MOVE       0x01
> +#define BU21013_OFFSET_MODE_DISABLE    0x02
> +
> +/* Threshold ON values */
> +#define BU21013_TH_ON_0                        0x01
> +#define BU21013_TH_ON_1                        0x02
> +#define BU21013_TH_ON_2                        0x04
> +#define BU21013_TH_ON_3                        0x08
> +#define BU21013_TH_ON_4                        0x10
> +#define BU21013_TH_ON_5                        0x20
> +#define BU21013_TH_ON_6                        0x40
> +#define BU21013_TH_ON_7                        0x80
> +
> +/* Threshold OFF values */
> +#define BU21013_TH_OFF_0               0x01
> +#define BU21013_TH_OFF_1               0x02
> +#define BU21013_TH_OFF_2               0x04
> +#define BU21013_TH_OFF_3               0x08
> +#define BU21013_TH_OFF_4               0x10
> +#define BU21013_TH_OFF_5               0x20
> +#define BU21013_TH_OFF_6               0x40
> +#define BU21013_TH_OFF_7               0x80
> +
> +/* FILTER reg values */
> +#define BU21013_X_EDGE_0               0x01
> +#define BU21013_X_EDGE_1               0x02
> +#define BU21013_X_EDGE_2               0x04
> +#define BU21013_X_EDGE_3               0x08
> +#define BU21013_Y_EDGE_0               0x10
> +#define BU21013_Y_EDGE_1               0x20
> +#define BU21013_Y_EDGE_2               0x40
> +#define BU21013_Y_EDGE_3               0x80
> +
> +#define BU21013_DONE                   0x01
> +#define BU21013_NUMBER_OF_X_SENSORS    (6)
> +#define BU21013_NUMBER_OF_Y_SENSORS    (11)

I don't think that all of these #defines needs to be seen by world. Please
move private registers #defines into driver itself.

> +
> +/**
> + * struct bu21013_platform_device - Handle the platform data
> + * @cs_en:     pointer to the cs enable function
> + * @cs_dis:    pointer to the cs disable function
> + * @irq_read_val:    pointer to read the pen irq value function
> + * @x_max_res: xmax resolution
> + * @y_max_res: ymax resolution
> + * @touch_x_max: touch x max
> + * @touch_y_max: touch y max
> + * @cs_pin: chip select pin
> + * @irq: irq pin
> + * @ext_clk_en: external clock flag
> + * @portrait: portrait mode flag
> + * @x_flip: x flip flag
> + * @y_flip: y flip flag
> + * This is used to handle the platform data

One empty line between large description and last @member.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
