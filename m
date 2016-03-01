From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Tue, 1 Mar 2016 22:32:40 +0000
Message-ID: <CA+V1LzpzJ1P3E_Rm4bRRegV0+ZMLs9befCXmA7PTSEn8umQsBw@mail.gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
	<56D568C7.20203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36232 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbcCAWcl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2016 17:32:41 -0500
Received: by mail-qg0-f46.google.com with SMTP id u110so25778146qge.3
        for <linux-input@vger.kernel.org>; Tue, 01 Mar 2016 14:32:41 -0800 (PST)
In-Reply-To: <56D568C7.20203@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Gregor,

Have modified (remove all besides i2c and acpi + added CHPN0001 ACPI)
from your gsl680 driver.
Main goal - to verify what is getting from ACPI for my touchChipone
icn8528 and next step add here mentioned in linux-sunxi wakeuping
procedure for the chip.


The only thing I have receive from loading it with debug option to kernel:

insmod ./myicn_ts_acpi.ko
bus: 'i2c: add driver CHPN001.

I have not received "hello from probe_ts_probe".

So, my questions are:

1) Am I right when I am registering i2c client  mentioned in .probe
function should be called immediately ?
2) how to ensure and output all info that was taken from ACPI, as
minimum i2cbus number and address,
    irq
3) how to ensure that gpios are taken? from where was taken name
"power" for gpio?  Why exactly the name "power" ?    Looks also like I
need one more gpio that is "reset".
4) How will be created i2c-dev ? is this should be done by kernel
automatically? I mean there is no any direct creation of device on
predefined i2c-bus at predefined address.

Regards,
                Serge Kolotylo.



/*
    Playing with GSL1680 by "Gregor Riepl <onitake@gmail.com>"
 */

#include <linux/module.h>
#include <linux/input.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/i2c.h>
#include <linux/delay.h>
#include <linux/firmware.h>
#include <linux/input/mt.h>
#include <linux/acpi.h>
#include <linux/of.h>
#include <linux/gpio/consumer.h>
#include <linux/version.h>

/* Device and driver information */
#define DEVICE_NAME    "CHPN001"
#define DRIVER_VERSION    "0.0.1"
#define GSL_PWR_GPIO "power"


/* Hardware API constants */
enum gsl_ts_state {
    GSL_TS_INIT,
    GSL_TS_SHUTDOWN,
    GSL_TS_GREEN,
};

/* Driver instance data structure */
struct gsl_ts_data {
    struct i2c_client *client;
    struct input_dev *input;
    struct gpio_desc *gpio;

    enum gsl_ts_state state;

    bool wake_irq_enabled;

    unsigned int x_max;
    unsigned int y_max;
    unsigned int multi_touches;
    bool x_reversed;
    bool y_reversed;
    bool xy_swapped;
    bool soft_tracking;
    int jitter;
    int deadzone;
};




#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0)
static const struct acpi_gpio_params gsl_ts_power_gpio = { 0, 0, true };
static const struct acpi_gpio_mapping gsl_ts_acpi_gpios[] = {
    { "power-gpio", &gsl_ts_power_gpio, 1 },
    { },
};
#endif

static int gsl_ts_probe(struct i2c_client *client, const struct
i2c_device_id *id)
{
    printk("Hello from probe_ts_probe");
    struct gsl_ts_data *ts;
    unsigned long irqflags;
    int error;

    dev_warn(&client->dev, "%s: got a device named %s at address 0x%x,
IRQ %d, flags 0x%x\n", __func__, client->name, client->addr,
client->irq, client->flags);

    if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
        dev_err(&client->dev, "%s: i2c check functionality error\n", __func__);
        return -ENXIO;
    }

    if (client->irq <= 0) {
        dev_err(&client->dev, "%s: missing IRQ configuration\n", __func__);
        return -ENODEV;
    }

    ts = devm_kzalloc(&client->dev, sizeof(struct gsl_ts_data), GFP_KERNEL);
    if (!ts) {
        return -ENOMEM;
    }

    ts->client = client;
    i2c_set_clientdata(client, ts);

#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0)
    /* Set up ACPI device descriptor GPIO name mappings.
        * This is a fallback, it will only be used if the system does not
        * provide a corresponding _DSD entry.
        */
    error = acpi_dev_add_driver_gpios(ACPI_COMPANION(&client->dev),
gsl_ts_acpi_gpios);
    if (error < 0) {
        dev_warn(&client->dev, "%s: failed to register GPIO names,
continuing anyway\n", __func__);
    }
#endif

#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
    ts->gpio = devm_gpiod_get(&client->dev, GSL_PWR_GPIO);
#else
    ts->gpio = devm_gpiod_get(&client->dev, GSL_PWR_GPIO, GPIOD_OUT_LOW);
#endif
    if (IS_ERR(ts->gpio)) {
        dev_err(&client->dev, "%s: error obtaining power pin GPIO
resource\n", __func__);
        error = PTR_ERR(ts->gpio);
        goto release_gpios;
    }
#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
    error = gpiod_direction_output(ts->gpio, 0);
    if (error < 0) {
        dev_err(&client->dev, "%s: error setting GPIO pin
direction\n", __func__);
        goto release_gpios;
    }
#endif

    if (ACPI_COMPANION(&client->dev)) {
        /* Wake the device up with a power on reset */
        error = acpi_bus_set_power(ACPI_HANDLE(&client->dev), ACPI_STATE_D3);
        if (error == 0) {
            error = acpi_bus_set_power(ACPI_HANDLE(&client->dev),
ACPI_STATE_D0);
        }
        if (error) {
            dev_err(&client->dev, "%s: failed to wake up device
through ACPI: %d, continuting anyway\n", __func__, error);
        }
    }


    ts->input = devm_input_allocate_device(&client->dev);
    if (!ts->input) {
        dev_err(&client->dev, "%s: failed to allocate input device\n",
__func__);
        error = -ENOMEM;
        goto release_fw;
    }

    ts->input->name = "chipone_icn85xx Touchscreen";
    ts->input->id.bustype = BUS_I2C;
    ts->input->phys = "input/ts";

    input_set_capability(ts->input, EV_ABS, ABS_X);
    input_set_capability(ts->input, EV_ABS, ABS_Y);

    input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, ts->x_max,
ts->jitter, ts->deadzone);
    input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, ts->y_max,
ts->jitter, ts->deadzone);

    input_mt_init_slots(ts->input, ts->multi_touches, INPUT_MT_DIRECT
| INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);

    input_set_drvdata(ts->input, ts);

    error = input_register_device(ts->input);
    if (error) {
        dev_err(&client->dev, "%s: unable to register input device:
%d\n", __func__, error);
        goto release_fw;
    }

    /* Execute the controller startup sequence */

    /*
     * Systems using device tree should set up wakeup via DTS,
     * the rest will configure device as wakeup source by default.
     */

release_fw:
//    if (fw) {
//        release_firmware(fw);
//    }

release_gpios:
    if (error < 0) {
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0)
        acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
#endif

        return error;
    }
    return 0;
}

int gsl_ts_remove(struct i2c_client *client) {
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0)
    acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
#endif
    return 0;
}


static const struct i2c_device_id gsl_ts_i2c_id[] = {
    { DEVICE_NAME, 0 },
    { }
};
MODULE_DEVICE_TABLE(i2c, gsl_ts_i2c_id);


#ifdef CONFIG_ACPI
/* GSL3680 ACPI IDs are untested */
static const struct acpi_device_id gsl_ts_acpi_match[] = {
    { "CHPN0001", 0 },
    { "PNP05C0", 0 },
    { "CHIPONE",0},
    { "ICN8528",0},
    { "ICN8500",0},
    { },
};
MODULE_DEVICE_TABLE(acpi, gsl_ts_acpi_match);
#endif

#ifdef CONFIG_OF
/* This should take care of OpenFirmware and DeviceTree instantiations,
 * but they're completely untested. Volunteers welcome.
 * Is anyone using DeviceTree with this touch screen at all?
 */
static const struct of_device_id gsl_ts_of_match[] = {
    { .compatible = "chipone,icn85xx" },
    { .compatible = "chipone,icn8528" },
    { .compatible = "chipone,icn8500" },
    { }
};
MODULE_DEVICE_TABLE(of, gsl_ts_of_match);
#endif

static struct i2c_driver gslx680_ts_driver = {
    .probe = gsl_ts_probe,
    .remove = gsl_ts_remove,
    .id_table = gsl_ts_i2c_id,
    .driver = {
        .name = DEVICE_NAME,
        .owner = THIS_MODULE,
#ifdef CONFIG_ACPI
        .acpi_match_table = ACPI_PTR(gsl_ts_acpi_match),
#endif
#ifdef CONFIG_OF
        .of_match_table = of_match_ptr(gsl_ts_of_match),
#endif
    },
};
module_i2c_driver(gslx680_ts_driver);

MODULE_DESCRIPTION("MyICN touchscreen controller driver");
MODULE_AUTHOR("Gregor Riepl <onitake@gmail.com> & Serge Kolotylo
sergk.admin@gmail.com>");
MODULE_VERSION(DRIVER_VERSION);
MODULE_LICENSE("GPL");

On Tue, Mar 1, 2016 at 10:02 AM, Gregor Riepl <onitake@gmail.com> wrote:
> Hi Serge,
>
>> Howto use ACPI for touchscreen:
>>
>>   1) is it possible to detect via ACPI GPIO pin to INT/WAKE Touch?
>>    2) If yes how to find out equivalent of this gpio pin in
>> /sys/class/gpio? (to have userspace interface to it via export
>> gpioPINNUMBER> /sys/class/gpio/export
>> 3) From the bellow DSDT table touch is dependant from I2C5  while
>> i2c-dev creates devices i2c-0...i2c-4. Does this mean that in ACPI
>> base is 1 and I2C5 is identical to i2c-4 dev ?
>
> In a kernel driver, you don't have to do all of this yourself, as the kernel
> will take care of ACPI parsing and device configuration when you request it.
>
> If your driver lives in user space, you need to do this mapping yourself.
>
> This is all the relevant information:
>
>>                        I2cSerialBus (0x0030, ControllerInitiated, 0x00061A80,
>>                             AddressingMode7Bit, "\\_SB.I2C4",
>>                             0x00, ResourceConsumer, ,
>>                             )
>>                         Interrupt (ResourceConsumer, Level,
>> ActiveHigh, Exclusive, ,, )
>>                         {
>>                             0x00000044,
>>                         }
>>                         GpioIo (Exclusive, PullDefault, 0x0000,
>> 0x0000, IoRestrictionOutputOnly,
>>                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>>                             )
>>                             {   // Pin list
>>                                 0x001A
>>                             }
>>
>
> Device on I2C address 0x30 (with 7-bit addressing), on I2C controller I2C4
> (not I2C5, I believe this dependency is a bug in the DSDT entry of many
> touchscreen devices), speed 400kHz.
> One IRQ line (pin number 0x44), high level triggered. This maps directly to
> the physical pin on Baytrail AFAIK. I'm not sure how to access it from user
> space. Perhaps GPIO works, and perhaps it's not needed at all if you do polling.
> One output GPIO pin, number 0x1a on GPO1 with default pullup settings. This is
> most likely the "wakeup" pin on the controller.
>
> I don't quite remember how the GPIO pin mapping works on Baytrail. Usually,
> each "chip" has a base pin number, and the pin number from the DSDT entry is
> added to that. Maybe check all /sys/class/gpio/gpiochip*/label entries and see
> if you can find GPO1? You can then map the logical pin number (base + 0x1a)
> using /sys/class/gpio/export
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
