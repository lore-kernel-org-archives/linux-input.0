From: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2 V4] Input: add Atmel Captouch Button driver
Date: Wed, 18 May 2016 15:17:00 -0700
Message-ID: <CANEJEGuOOAbgKkJu6bY7rP2s+P3M3+5cUVr6=cqGqqTn06=7Jw@mail.gmail.com>
References: <1463513372-87267-1-git-send-email-grundler@chromium.org> <20160518215942.GB4081@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160518215942.GB4081@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 18, 2016 at 2:59 PM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, May 17, 2016 at 12:29:32PM -0700, Grant Grundler wrote:
>> From: Daniel Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>>
>> Add I2C driver for Atmel Capacitive Touch Button device.
>>
>> Signed-off-by: Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Applied, thank you.

Awesome! Thanks for your help Dmitry! :)

grant

>
>> ---
>>  drivers/input/misc/Kconfig          |  13 ++
>>  drivers/input/misc/Makefile         |   1 +
>>  drivers/input/misc/atmel_captouch.c | 287 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 299 insertions(+)
>>  create mode 100644 drivers/input/misc/atmel_captouch.c
>>
>> V4: wordsmithing comments at top of file.
>>     Added missing semicolon to CONFIG_OF data struct.
>>
>> V3: use dash, not underscore in nodename. Wordsmith Kconfig help text.
>>
>> V2: split Documentation/devicetree/bindings from driver patch.
>>     rename "atmel,atmegaxx_captouch" to "atmel,captouch" since it's irrelevant
>>     which controller implements the register set/controller.
>>
>> V1: posted https://lkml.org/lkml/2016/5/3/613
>>
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index 838824b..d8b6620 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -82,6 +82,19 @@ config INPUT_ARIZONA_HAPTICS
>>         To compile this driver as a module, choose M here: the
>>         module will be called arizona-haptics.
>>
>> +config INPUT_ATMEL_CAPTOUCH
>> +     tristate "Atmel Capacitive Touch Button Driver"
>> +     depends on OF || COMPILE_TEST
>> +     help
>> +       Say Y here if an Atmel Capacitive Touch Button device which
>> +       implements "captouch" protocol is connected to I2C bus. Typically
>> +       this device consists of Atmel Touch sensor controlled by AtMegaXX
>> +       MCU running firmware based on Qtouch library.
>> +       One should find "atmel,captouch" node in the board specific DTS.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called atmel_captouch.
>> +
>>  config INPUT_BMA150
>>       tristate "BMA150/SMB380 acceleration sensor support"
>>       depends on I2C
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
>> index f77268e..b5ec626 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_INPUT_APANEL)          += apanel.o
>>  obj-$(CONFIG_INPUT_ARIZONA_HAPTICS)  += arizona-haptics.o
>>  obj-$(CONFIG_INPUT_ATI_REMOTE2)              += ati_remote2.o
>>  obj-$(CONFIG_INPUT_ATLAS_BTNS)               += atlas_btns.o
>> +obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)   += atmel_captouch.o
>>  obj-$(CONFIG_INPUT_BFIN_ROTARY)              += bfin_rotary.o
>>  obj-$(CONFIG_INPUT_BMA150)           += bma150.o
>>  obj-$(CONFIG_INPUT_CM109)            += cm109.o
>> diff --git a/drivers/input/misc/atmel_captouch.c b/drivers/input/misc/atmel_captouch.c
>> new file mode 100644
>> index 0000000..91bfc73
>> --- /dev/null
>> +++ b/drivers/input/misc/atmel_captouch.c
>> @@ -0,0 +1,287 @@
>> +/*
>> + * Atmel Capacitive Touch Button Driver
>> + *
>> + * Copyright (C) 2016 Google, inc.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +/*
>> + * It's irrelevant the HW used to develop captouch driver is based
>> + * on Atmega88PA part and uses QtouchADC parts for sensing touch.
>> + * Calling this driver "captouch" is an arbitrary way to distinguish
>> + * the protocol this driver supports from other atmel/qtouch drivers.
>> + *
>> + * captouch driver supports a newer/different version of the I2C
>> + * registers/commands than the qt1070.c driver.
>> + * Don't let the similarity of the general driver structure fool you. :)
>> + *
>> + * For raw i2c access from userspace, use i2cset/i2cget
>> + * to poke at /dev/i2c-N devices.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +#include <linux/input.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/slab.h>
>> +
>> +/* Maximum number of buttons supported */
>> +#define MAX_NUM_OF_BUTTONS           8
>> +
>> +/* Registers */
>> +#define REG_KEY1_THRESHOLD           0x02
>> +#define REG_KEY2_THRESHOLD           0x03
>> +#define REG_KEY3_THRESHOLD           0x04
>> +#define REG_KEY4_THRESHOLD           0x05
>> +
>> +#define REG_KEY1_REF_H                       0x20
>> +#define REG_KEY1_REF_L                       0x21
>> +#define REG_KEY2_REF_H                       0x22
>> +#define REG_KEY2_REF_L                       0x23
>> +#define REG_KEY3_REF_H                       0x24
>> +#define REG_KEY3_REF_L                       0x25
>> +#define REG_KEY4_REF_H                       0x26
>> +#define REG_KEY4_REF_L                       0x27
>> +
>> +#define REG_KEY1_DLT_H                       0x30
>> +#define REG_KEY1_DLT_L                       0x31
>> +#define REG_KEY2_DLT_H                       0x32
>> +#define REG_KEY2_DLT_L                       0x33
>> +#define REG_KEY3_DLT_H                       0x34
>> +#define REG_KEY3_DLT_L                       0x35
>> +#define REG_KEY4_DLT_H                       0x36
>> +#define REG_KEY4_DLT_L                       0x37
>> +
>> +#define REG_KEY_STATE                        0x3C
>> +
>> +/*
>> + * @i2c_client: I2C slave device client pointer
>> + * @input: Input device pointer
>> + * @num_btn: Number of buttons
>> + * @keycodes: map of button# to KeyCode
>> + * @prev_btn: Previous key state to detect button "press" or "release"
>> + * @xfer_buf: I2C transfer buffer
>> + */
>> +struct atmel_captouch_device {
>> +     struct i2c_client *client;
>> +     struct input_dev *input;
>> +     u32 num_btn;
>> +     u32 keycodes[MAX_NUM_OF_BUTTONS];
>> +     u8 prev_btn;
>> +     u8 xfer_buf[8] ____cacheline_aligned;
>> +};
>> +
>> +/*
>> + * Read from I2C slave device
>> + * The protocol is that the client has to provide both the register address
>> + * and the length, and while reading back the device would prepend the data
>> + * with address and length for verification.
>> + */
>> +static int atmel_read(struct atmel_captouch_device *capdev,
>> +                      u8 reg, u8 *data, size_t len)
>> +{
>> +     struct i2c_client *client = capdev->client;
>> +     struct device *dev = &client->dev;
>> +     struct i2c_msg msg[2];
>> +     int err;
>> +
>> +     if (len > sizeof(capdev->xfer_buf) - 2)
>> +             return -EINVAL;
>> +
>> +     capdev->xfer_buf[0] = reg;
>> +     capdev->xfer_buf[1] = len;
>> +
>> +     msg[0].addr = client->addr;
>> +     msg[0].flags = 0;
>> +     msg[0].buf = capdev->xfer_buf;
>> +     msg[0].len = 2;
>> +
>> +     msg[1].addr = client->addr;
>> +     msg[1].flags = I2C_M_RD;
>> +     msg[1].buf = capdev->xfer_buf;
>> +     msg[1].len = len + 2;
>> +
>> +     err = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
>> +     if (err != ARRAY_SIZE(msg))
>> +             return err < 0 ? err : -EIO;
>> +
>> +     if (capdev->xfer_buf[0] != reg) {
>> +             dev_err(dev, "I2C read error: register address does not match\n");
>> +             return -ECOMM;
>> +     }
>> +
>> +     memcpy(data, &capdev->xfer_buf[2], len);
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * Handle interrupt and report the key changes to the input system.
>> + * Multi-touch can be supported; however, it really depends on whether
>> + * the device can multi-touch.
>> + */
>> +static irqreturn_t atmel_captouch_isr(int irq, void *data)
>> +{
>> +     struct atmel_captouch_device *capdev = data;
>> +     struct device *dev = &capdev->client->dev;
>> +     int error;
>> +     int i;
>> +     u8 new_btn;
>> +     u8 changed_btn;
>> +
>> +     error = atmel_read(capdev, REG_KEY_STATE, &new_btn, 1);
>> +     if (error) {
>> +             dev_err(dev, "failed to read button state: %d\n", error);
>> +             goto out;
>> +     }
>> +
>> +     dev_dbg(dev, "%s: button state %#02x\n", __func__, new_btn);
>> +
>> +     changed_btn = new_btn ^ capdev->prev_btn;
>> +     capdev->prev_btn = new_btn;
>> +
>> +     for (i = 0; i < capdev->num_btn; i++) {
>> +             if (changed_btn & BIT(i))
>> +                     input_report_key(capdev->input,
>> +                                      capdev->keycodes[i],
>> +                                      new_btn & BIT(i));
>> +     }
>> +
>> +     input_sync(capdev->input);
>> +
>> +out:
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +/*
>> + * Probe function to setup the device, input system and interrupt
>> + */
>> +static int atmel_captouch_probe(struct i2c_client *client,
>> +             const struct i2c_device_id *id)
>> +{
>> +     struct atmel_captouch_device *capdev;
>> +     struct device *dev = &client->dev;
>> +     struct device_node *node;
>> +     int i;
>> +     int err;
>> +
>> +     if (!i2c_check_functionality(client->adapter,
>> +                                  I2C_FUNC_SMBUS_BYTE_DATA |
>> +                                     I2C_FUNC_SMBUS_WORD_DATA |
>> +                                     I2C_FUNC_SMBUS_I2C_BLOCK)) {
>> +             dev_err(dev, "needed i2c functionality is not supported\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     capdev = devm_kzalloc(dev, sizeof(*capdev), GFP_KERNEL);
>> +     if (!capdev)
>> +             return -ENOMEM;
>> +
>> +     capdev->client = client;
>> +     i2c_set_clientdata(client, capdev);
>> +
>> +     err = atmel_read(capdev, REG_KEY_STATE,
>> +                         &capdev->prev_btn, sizeof(capdev->prev_btn));
>> +     if (err) {
>> +             dev_err(dev, "failed to read initial button state: %d\n", err);
>> +             return err;
>> +     }
>> +
>> +     capdev->input = devm_input_allocate_device(dev);
>> +     if (!capdev->input) {
>> +             dev_err(dev, "failed to allocate input device\n");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     capdev->input->id.bustype = BUS_I2C;
>> +     capdev->input->id.product = 0x880A;
>> +     capdev->input->id.version = 0;
>> +     capdev->input->name = "ATMegaXX Capacitive Button Controller";
>> +     __set_bit(EV_KEY, capdev->input->evbit);
>> +
>> +     node = dev->of_node;
>> +     if (!node) {
>> +             dev_err(dev, "failed to find matching node in device tree\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (of_property_read_bool(node, "autorepeat"))
>> +             __set_bit(EV_REP, capdev->input->evbit);
>> +
>> +     capdev->num_btn = of_property_count_u32_elems(node, "linux,keymap");
>> +     if (capdev->num_btn > MAX_NUM_OF_BUTTONS)
>> +             capdev->num_btn = MAX_NUM_OF_BUTTONS;
>> +
>> +     err = of_property_read_u32_array(node, "linux,keycodes",
>> +                                      capdev->keycodes,
>> +                                      capdev->num_btn);
>> +     if (err) {
>> +             dev_err(dev,
>> +                     "failed to read linux,keycode property: %d\n", err);
>> +             return err;
>> +     }
>> +
>> +     for (i = 0; i < capdev->num_btn; i++)
>> +             __set_bit(capdev->keycodes[i], capdev->input->keybit);
>> +
>> +     capdev->input->keycode = capdev->keycodes;
>> +     capdev->input->keycodesize = sizeof(capdev->keycodes[0]);
>> +     capdev->input->keycodemax = capdev->num_btn;
>> +
>> +     err = input_register_device(capdev->input);
>> +     if (err)
>> +             return err;
>> +
>> +     err = devm_request_threaded_irq(dev, client->irq, NULL,
>> +                             atmel_captouch_isr, IRQF_ONESHOT,
>> +                             "atmel_captouch", capdev);
>> +     if (err) {
>> +             dev_err(dev, "failed to request irq %d: %d\n",
>> +                     client->irq, err);
>> +             return err;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id atmel_captouch_of_id[] = {
>> +     {
>> +             .compatible = "atmel,captouch",
>> +     },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, atmel_captouch_of_id);
>> +#endif
>> +
>> +static const struct i2c_device_id atmel_captouch_id[] = {
>> +     { "atmel_captouch", 0 },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, atmel_captouch_id);
>> +
>> +static struct i2c_driver atmel_captouch_driver = {
>> +     .probe          = atmel_captouch_probe,
>> +     .id_table       = atmel_captouch_id,
>> +     .driver         = {
>> +             .name   = "atmel_captouch",
>> +             .of_match_table = of_match_ptr(atmel_captouch_of_id),
>> +     },
>> +};
>> +module_i2c_driver(atmel_captouch_driver);
>> +
>> +/* Module information */
>> +MODULE_AUTHOR("Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>");
>> +MODULE_DESCRIPTION("Atmel ATmegaXX Capacitance Touch Sensor I2C Driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.1.2
>>
>
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
