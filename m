From: Yuasa Yoichi <yuasa@linux-mips.org>
Subject: Re: [PATCH v4] input: Add ROHM BU21023/24 Dual touch support
 resistive touchscreens
Date: Thu, 6 Aug 2015 19:10:28 +0900
Message-ID: <CACBHAeywdgzS=SbyXmR--VZop9fANeS4JRTRbDg0hKj6xV6SZw@mail.gmail.com>
References: <20141205181739.3f3da16b1573c891cf49ba68@linux-mips.org>
	<20150115013558.GA37437@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34370 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbHFKK3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2015 06:10:29 -0400
Received: by obbfr1 with SMTP id fr1so15407287obb.1
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2015 03:10:29 -0700 (PDT)
In-Reply-To: <20150115013558.GA37437@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Yoichi Yuasa <yuasa@linux-mips.org>

Hi Dmitry,

Thank you for your comments and I'm sorry for my late reply.

2015-01-15 10:35 GMT+09:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Yoichi,
>
> On Fri, Dec 05, 2014 at 06:17:39PM +0900, Yoichi Yuasa wrote:
>> v4 Changes:
>> - remove inline
>> - master_xfer checks in probe()
>> - rewrite rohm_i2c_burst_read()
>> - rohm_i2c_burst_read() transfer error returns -EIO
>> - remove unused module parameters
>> - fix prev_touch_report update
>> - pass NULL to hard_irq
>> - per-device parameters use sysfs
>> - fix errno
>> - header file is taken in .c
>
> Sorry I missed your V4 update....
>
...
>> +
>> +struct rohm_ts_data {
>> +     struct i2c_client *client;
>> +     struct input_dev *input_dev;
>> +
>> +     bool initialized;
>> +
>> +     unsigned int untouch_count;
>> +     unsigned int single_touch_count;
>> +     unsigned int dual_touch_count;
>
> Hmm, OK, so I guess the screen is very bouncy, that is why you need
> this. I think it should be an array of contact_count[MAX_CONTACTS + 1];
> and then you can do:
>
>         if (ts->finger_count != finger_count) {
>                 memset(ts->contact_count, 0, sizeof(ts->contact_count));
>                 ts->finger_count = finger_count;
>         } else {
>                 ts->contact_count[finger_count]++;
>         }

Ok, I'll update it.

>> +     unsigned int prev_touch_report;
>> +
>> +     u8 setup2;
>> +};
>> +
>> +/*
>> + * rohm_i2c_burst_read - execute combined I2C message for ROHM BU21023/24
>> + * @client: Handle to ROHM BU21023/24
>> + * @start: Where to start read address from ROHM BU21023/24
>> + * @buf: Where to store read data from ROHM BU21023/24
>> + * @len: How many bytes to read
>> + *
>> + * Returns negative errno, else zero on success.
>> + *
>> + * Note
>> + * In BU21023/24 burst read, stop condition is needed after "address write".
>> + * Therefore, transmission is performed in 2 steps.
>
> Is it in errata? I glanced through
> http://rohmfs.rohm.com/en/products/databook/datasheet/ic/sensor/touch_screen/bu21023gul-e.pdf
> and I do not see it mentioned there...

I have no information about errata.
I have only sample code that based of rohm_i2c_burst_read().

In addition, I tried normal burst read, but it didn't work on the device.

>> +
>> +#define READ_CALIB_BUF(reg)  ((u16)buf[((reg) - PRM1_X_H)])
>
> This should be get_unaligned_xx() or xx_to_cpu() to make sure it works
> on all architectures.

The cast can be removed, just remove it

>> +static unsigned int untouch_threshold[3] = { 0, 1, 5 };
>> +static unsigned int single_touch_threshold[3] = { 0, 0, 4 };
>> +static unsigned int dual_touch_threshold[3] = { 10, 8, 0 };
>> +
>> +module_param_array(untouch_threshold, uint, NULL, S_IRUGO | S_IWUSR);
>> +module_param_array(single_touch_threshold, uint, NULL, S_IRUGO | S_IWUSR);
>> +module_param_array(dual_touch_threshold, uint, NULL, S_IRUGO | S_IWUSR);
>> +
>> +MODULE_PARM_DESC(untouch_threshold, "Thresholds for un-touch detection");
>> +MODULE_PARM_DESC(single_touch_threshold,
>> +              "Thresholds for single touch detection");
>> +MODULE_PARM_DESC(dual_touch_threshold, "Thresholds for dual touch detection");
>
> DO we really need this as module parameters? Is it user preference or
> something that vendor would set for their device? I.e. maybe it belongs
> to the platform/devicetree data, along with the swaping x/y support?

OK, I remove them.

>> +#define READ_POS_BUF(reg)    ((u16)buf[((reg) - POS_X1_H)])
>
> This should be get_unaligned_xx() or xx_to_cpu() to make sure it works
> on all architectures.

The cast can be removed, just remove it

>> +
>> +     ret = rohm_i2c_burst_read(client, POS_X1_H, buf, sizeof(buf));
>> +     if (ret < 0)
>> +             return IRQ_HANDLED;
>> +
>> +     touch_flags = READ_POS_BUF(TOUCH_GESTURE) & TOUCH_MASK;
>> +     if (touch_flags) {
>> +             /* generate coordinates */
>> +             pos[0].x = (READ_POS_BUF(POS_X1_H) << 2) |
>> +                        READ_POS_BUF(POS_X1_L);
>> +             pos[0].y = (READ_POS_BUF(POS_Y1_H) << 2) |
>> +                        READ_POS_BUF(POS_Y1_L);
>> +             pos[1].x = (READ_POS_BUF(POS_X2_H) << 2) |
>> +                        READ_POS_BUF(POS_X2_L);
>> +             pos[1].y = (READ_POS_BUF(POS_Y2_H) << 2) |
>> +                        READ_POS_BUF(POS_Y2_L);
>> +
>> +             switch (touch_flags) {
>> +             case SINGLE_TOUCH:
>> +                     ts->untouch_count = 0;
>> +                     ts->single_touch_count++;
>> +                     ts->dual_touch_count = 0;
>> +
>> +                     threshold = single_touch_threshold[prev_touch_report];
>> +                     if (ts->single_touch_count > threshold)
>> +                             touch_report = 1;
>> +
>> +                     if (touch_report == 1) {
>> +                             if (pos[1].x != 0 && pos[1].y != 0) {
>> +                                     pos[0].x = pos[1].x;
>> +                                     pos[0].y = pos[1].y;
>> +                                     pos[1].x = 0;
>> +                                     pos[1].y = 0;
>> +                             }
>> +                     }
>> +                     break;
>> +             case DUAL_TOUCH:
>> +                     ts->untouch_count = 0;
>> +                     ts->single_touch_count = 0;
>> +                     ts->dual_touch_count++;
>> +
>> +                     threshold = dual_touch_threshold[prev_touch_report];
>> +                     if (ts->dual_touch_count > threshold)
>> +                             touch_report = 2;
>> +                     break;
>> +             default:
>> +                     dev_dbg(dev,
>> +                             "Three or more touches are not supported\n");
>> +                     return IRQ_HANDLED;
>> +             }
>> +     } else {
>> +             ts->untouch_count++;
>> +
>> +             threshold = untouch_threshold[prev_touch_report];
>> +             if (ts->untouch_count > threshold) {
>> +                     ts->untouch_count = 0;
>> +                     ts->single_touch_count = 0;
>> +                     ts->dual_touch_count = 0;
>> +
>> +                     touch_report = 0;
>> +             }
>
> Why do we handle "no fingers" separately? Can't we add 'case 0' to the
> switch statement above?

OK, I'll update it.

>> +static int rohm_ts_device_init(struct rohm_ts_data *ts)
>> +{
>> +     struct i2c_client *client = ts->client;
>> +     struct device *dev = &client->dev;
>> +     int ret;
>> +
>> +     /*
>> +      * Wait 200usec for reset
>> +      */
>> +     udelay(200);
>> +
>> +     /* Release analog reset */
>> +     ret = i2c_smbus_write_byte_data(client, SYSTEM, ANALOG_POWER_ON);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Waiting for the analog warm-up, max. 200usec */
>> +     udelay(200);
>> +
>> +     /* clear all interrupts */
>> +     ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, EX_WDAT, 0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, COMMON_SETUP1, 0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, COMMON_SETUP2, ts->setup2);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, COMMON_SETUP3,
>> +                                     SEL_TBL_DEFAULT | EN_MULTI);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, THRESHOLD_GESTURE,
>> +                                     THRESHOLD_GESTURE_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, INTERVAL_TIME,
>> +                                     INTERVAL_TIME_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, CPU_FREQ, CPU_FREQ_10MHZ);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, PRM_SWOFF_TIME,
>> +                                     PRM_SWOFF_TIME_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, ADC_CTRL, ADC_DIV_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, ADC_WAIT, ADC_WAIT_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /*
>> +      * Panel setup, these values change with the panel.
>> +      */
>> +     ret = i2c_smbus_write_byte_data(client, STEP_X, STEP_X_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, STEP_Y, STEP_Y_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, OFFSET_X, OFFSET_X_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, OFFSET_Y, OFFSET_Y_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, THRESHOLD_TOUCH,
>> +                                     THRESHOLD_TOUCH_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, EVR_XY, EVR_XY_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, EVR_X, EVR_X_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, EVR_Y, EVR_Y_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Fixed value settings */
>> +     ret = i2c_smbus_write_byte_data(client, CALIBRATION_ADJUST,
>> +                                     CALIBRATION_ADJUST_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, SWCONT, SWCONT_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, TEST1,
>> +                                     DUALTOUCH_STABILIZE_ON |
>> +                                     DUALTOUCH_REG_ON);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = rohm_ts_load_firmware(client, BU21023_FIRMWARE_NAME);
>> +     if (ret) {
>> +             dev_err(dev, "Failed to firmware load\n");
>> +             return ret;
>> +     }
>> +
>> +     /*
>> +      * Manual calibration results are not changed in same environment.
>> +      * If the force calibration is performed,
>> +      * the controller will not require calibration request interrupt
>> +      * when the typical values are set to the calibration registers.
>> +      */
>> +     ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG1,
>> +                                     CALIBRATION_REG1_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG2,
>> +                                     CALIBRATION_REG2_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, CALIBRATION_REG3,
>> +                                     CALIBRATION_REG3_DEFAULT);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
>> +                                     FORCE_CALIBRATION_OFF);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = i2c_smbus_write_byte_data(client, FORCE_CALIBRATION,
>> +                                     FORCE_CALIBRATION_ON);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Clear all interrupts */
>> +     ret = i2c_smbus_write_byte_data(client, INT_CLEAR, 0xff);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = devm_request_threaded_irq(dev, client->irq, NULL,
>> +                                     rohm_ts_soft_irq, IRQF_TRIGGER_FALLING,
>> +                                     client->name, ts);
>> +     if (ret) {
>> +             dev_err(dev, "Unable to request IRQ\n");
>> +             return ret;
>> +     }
>
> Preference for interrupts (and other resources) to be requested at probe
> time and just power the device down so it does not generate interrupts
> until somebody opens it.

OK, I'll update it.

>> +
>> +static int rohm_bu21023_i2c_remove(struct i2c_client *client)
>> +{
>> +     int ret;
>> +
>> +     sysfs_remove_group(&client->dev.kobj, &rohm_ts_attr_group);
>> +
>> +     ret = i2c_smbus_write_byte_data(client, SYSTEM,
>> +                                     ANALOG_POWER_ON | CPU_POWER_OFF);
>
> I wonder if this should be done in close() method.

OK, I'll update it too.

I'll send the v5 patch soon.

Thanks,

Yoichi
