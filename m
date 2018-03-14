From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 4/4] input: misc: Add Gateworks System Controller support
Date: Wed, 14 Mar 2018 10:13:59 -0700
Message-ID: <CAJ+vNU3gtvQ4WyHxg-6hd7EMSq3H-dOTQ--Wod0YcrnUj7_KWw@mail.gmail.com>
References: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
 <1520287361-12569-5-git-send-email-tharvey@gateworks.com> <20180310184502.GE260013@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180310184502.GE260013@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 10, 2018 at 10:45 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Mar 05, 2018 at 02:02:41PM -0800, Tim Harvey wrote:
>> Add support for dispatching Linux Input events for the various interrupts
>> the Gateworks System Controller provides.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>> v2:
>> - reword Kconfig
>> - revise license comment block
>> - remove unnecessary read of status register
>> - remove unnecessary setting of input->dev.parent
>> - use dt bindings for irq to keycode mapping
>> - add support for platform-data
>> - remove work-queue
>>
>>  drivers/input/misc/Kconfig              |   9 ++
>>  drivers/input/misc/Makefile             |   1 +
>>  drivers/input/misc/gsc-input.c          | 180 ++++++++++++++++++++++++++++++++
>>  include/linux/platform_data/gsc_input.h |  30 ++++++
>>  4 files changed, 220 insertions(+)
>>  create mode 100644 drivers/input/misc/gsc-input.c
>>  create mode 100644 include/linux/platform_data/gsc_input.h
>>
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index 9f082a3..e05f4fe 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -117,6 +117,15 @@ config INPUT_E3X0_BUTTON
>>         To compile this driver as a module, choose M here: the
>>         module will be called e3x0_button.
>>
>> +config INPUT_GSC
>> +     tristate "Gateworks System Controller input support"
>> +     depends on MFD_GSC
>> +     help
>> +       Support GSC events as Linux input events.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called gsc_input.
>> +
>>  config INPUT_PCSPKR
>>       tristate "PC Speaker support"
>>       depends on PCSPKR_PLATFORM
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
>> index 4b6118d..969debe 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -38,6 +38,7 @@ obj-$(CONFIG_INPUT_GP2A)            += gp2ap002a00f.o
>>  obj-$(CONFIG_INPUT_GPIO_BEEPER)              += gpio-beeper.o
>>  obj-$(CONFIG_INPUT_GPIO_TILT_POLLED) += gpio_tilt_polled.o
>>  obj-$(CONFIG_INPUT_GPIO_DECODER)     += gpio_decoder.o
>> +obj-$(CONFIG_INPUT_GSC)                      += gsc-input.o
>>  obj-$(CONFIG_INPUT_HISI_POWERKEY)    += hisi_powerkey.o
>>  obj-$(CONFIG_HP_SDC_RTC)             += hp_sdc_rtc.o
>>  obj-$(CONFIG_INPUT_IMS_PCU)          += ims-pcu.o
>> diff --git a/drivers/input/misc/gsc-input.c b/drivers/input/misc/gsc-input.c
>> new file mode 100644
>> index 0000000..27b5e93
>> --- /dev/null
>> +++ b/drivers/input/misc/gsc-input.c
>> @@ -0,0 +1,180 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (C) 2018 Gateworks Corporation
>> + *
>> + * This driver dispatches Linux input events for GSC interrupt events
>> + */
>> +#include <linux/input.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <linux/mfd/gsc.h>
>> +#include <linux/platform_data/gsc_input.h>
>> +
>> +struct gsc_input_button_priv {
>> +     struct input_dev *input;
>> +     const struct gsc_input_button *button;
>> +};
>> +
>> +struct gsc_input_data {
>> +     struct gsc_dev *gsc;
>> +     struct gsc_input_platform_data *pdata;
>> +     struct input_dev *input;
>> +     struct gsc_input_button_priv *buttons;
>> +     int nbuttons;
>> +     unsigned int irqs[];
>> +#if 0
>> +     int irq;
>> +     struct work_struct irq_work;
>> +     struct mutex mutex;
>> +#endif
>> +};
>> +
>> +static irqreturn_t gsc_input_irq(int irq, void *data)
>> +{
>> +     const struct gsc_input_button_priv *button_priv = data;
>> +     struct input_dev *input = button_priv->input;
>> +
>> +     dev_dbg(&input->dev, "irq%d code=%d\n", irq, button_priv->button->code);
>> +     input_report_key(input, button_priv->button->code, 1);
>> +     input_sync(input);
>> +     input_report_key(input, button_priv->button->code, 0);
>> +     input_sync(input);
>> +
>> +     return IRQ_HANDLED;
>
> Hmm, so in the end this is just a bunch of buttons connected to
> interrupt lines. We already have a driver for that, called gpio-keys. It
> can work in pure interrupt mode (i.e. do not need real GPIO pin, just
> interrupt, and it will generate key down and up events when interrupt
> arrives, with possible delay for the up event).
>

Dmitry,

Yes that's what it does and yes your correct the gpio-keys driver will
work perfect for that. Thanks for calling me out on that - I had not
realized the gpio-keys driver could work from 'interrupts'.

I'll remove the input driver in my next submission. At least I know
how to properly write an input driver now from your previous review :)

Thanks,

Tim
