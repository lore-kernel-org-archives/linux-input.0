From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 02/26] Input: synaptics-rmi4 - add a common input device
 in rmi_driver
Date: Tue, 10 Nov 2015 10:23:23 +0100
Message-ID: <CAN+gG=Guce5kQ+vkipmRRR9VWx_eZR=NmZPigWRs9xoehBjAGg@mail.gmail.com>
References: <1446766616-30258-1-git-send-email-aduggan@synaptics.com>
	<20151109231351.GD9155@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34864 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbKJJXZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2015 04:23:25 -0500
In-Reply-To: <20151109231351.GD9155@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Tue, Nov 10, 2015 at 12:13 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Nov 05, 2015 at 03:36:56PM -0800, Andrew Duggan wrote:
>> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> When .unified_input is set to true in the platform data, the
>> functions should rely on the common input node created by rmi_driver
>> to forward events instead of having their own input node.
>>
>> This node is named "Synaptics PRODUCT_ID" to be able to
>> differentiate the various models.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Tested-by: Andrew Duggan <aduggan@synaptics.com>
>> ---
>>  drivers/input/rmi4/rmi_driver.c | 43 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/input/rmi4/rmi_driver.h |  6 ++++++
>>  drivers/input/rmi4/rmi_f01.c    |  7 +++++++
>>  include/linux/rmi.h             |  2 ++
>>  4 files changed, 58 insertions(+)
>>
>> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
>> index b9db709..95f9386 100644
>> --- a/drivers/input/rmi4/rmi_driver.c
>> +++ b/drivers/input/rmi4/rmi_driver.c
>> @@ -310,6 +310,9 @@ static int process_interrupt_requests(struct rmi_device *rmi_dev)
>>               if (entry->irq_mask)
>>                       process_one_interrupt(data, entry);
>>
>> +     if (data->input)
>> +             input_sync(data->input);
>> +
>>       return 0;
>>  }
>>
>> @@ -330,6 +333,25 @@ static int rmi_driver_set_input_params(struct rmi_device *rmi_dev,
>>       return 0;
>>  }
>>
>> +static void rmi_driver_set_input_name(struct rmi_device *rmi_dev,
>> +                             struct input_dev *input)
>> +{
>> +     struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>> +     char *device_name = rmi_f01_get_product_ID(data->f01_container);
>> +     char *name;
>> +
>> +     if (!device_name)
>> +             return;
>
> Should we still give device some name?

Actually, I think the test is need needed. rmi_f01_get_product_ID()
returns a pointer to an array embedded in struct f01_data.
rmi_driver_set_input_name() is called after f01 has been initialized
and I think if there is an error while processing f01 we bail out. So
basically device_name can not be null. (If I read the code correctly).

>
>> +
>> +     name = devm_kasprintf(&rmi_dev->dev, GFP_KERNEL,
>> +                           "Synaptics %s", device_name);
>> +     if (!name)
>> +             return;
>
> Are we guaranteed that devm_kasprintf only called in probe() path?

Right now, yes. This function is called only in probe.

> What about errors?
>

Indeed, I should have tackled these first :(

>> +
>> +     input->name = name;
>> +}
>> +
>> +
>>  static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
>>                                  unsigned long *mask)
>>  {
>> @@ -720,6 +742,8 @@ static int rmi_driver_remove(struct device *dev)
>>       const struct rmi_device_platform_data *pdata =
>>                                       rmi_get_platform_data(rmi_dev);
>>
>> +     if (data->input)
>> +             input_unregister_device(data->input);
>
> Isn't this too early? Can sensor still be sending data here? (Looking...
> yeah, it looks like it can. Bad.)

oops, my bad.

>
>>       disable_sensor(rmi_dev);
>>       rmi_free_function_list(rmi_dev);
>>
>> @@ -832,6 +856,15 @@ static int rmi_driver_probe(struct device *dev)
>>       data->current_irq_mask  = irq_memory + size * 2;
>>       data->new_irq_mask      = irq_memory + size * 3;
>>
>> +     if (pdata->unified_input) {
>> +             data->input = input_allocate_device();
>> +             if (data->input) {
>> +                     rmi_driver_set_input_params(rmi_dev, data->input);
>> +                     sprintf(data->input_phys, "%s/input0", dev_name(dev));
>> +                     data->input->phys = data->input_phys;
>> +             }
>
> Bail if error?

yes, we need to change it

>
>> +     }
>> +
>>       irq_count = 0;
>>       dev_dbg(dev, "Creating functions.");
>>       retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
>> @@ -866,6 +899,15 @@ static int rmi_driver_probe(struct device *dev)
>>               mutex_init(&data->suspend_mutex);
>>       }
>>
>> +     if (data->input) {
>> +             rmi_driver_set_input_name(rmi_dev, data->input);
>> +             if (input_register_device(data->input)) {
>> +                     dev_err(dev, "%s: Failed to register input device.\n",
>> +                             __func__);
>> +                     goto err_destroy_functions;
>> +             }
>> +     }
>> +
>>       if (gpio_is_valid(pdata->attn_gpio)) {
>>               static const char GPIO_LABEL[] = "attn";
>>               unsigned long gpio_flags = GPIOF_DIR_IN;
>> @@ -921,6 +963,7 @@ static int rmi_driver_probe(struct device *dev)
>>       return 0;
>>
>>  err_destroy_functions:
>> +     input_free_device(data->input);
>>       rmi_free_function_list(rmi_dev);
>>       kfree(irq_memory);
>>  err_free_mem:
>> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
>> index dda564f..36ca34b 100644
>> --- a/drivers/input/rmi4/rmi_driver.h
>> +++ b/drivers/input/rmi4/rmi_driver.h
>> @@ -13,6 +13,7 @@
>>  #include <linux/ctype.h>
>>  #include <linux/hrtimer.h>
>>  #include <linux/ktime.h>
>> +#include <linux/input.h>
>>  #include "rmi_bus.h"
>>
>>  #define RMI_DRIVER_VERSION "1.6"
>> @@ -29,6 +30,8 @@
>>
>>  #define RMI_PDT_PROPS_HAS_BSR 0x02
>>
>> +#define NAME_BUFFER_SIZE 256
>> +
>>  struct rmi_driver_data {
>>       struct list_head function_list;
>>
>> @@ -49,6 +52,8 @@ struct rmi_driver_data {
>>       unsigned long *current_irq_mask;
>>       unsigned long *new_irq_mask;
>>       struct mutex irq_mutex;
>> +     struct input_dev *input;
>> +     char input_phys[NAME_BUFFER_SIZE];
>>
>>       /* Following are used when polling. */
>>       struct hrtimer poll_timer;
>> @@ -112,6 +117,7 @@ void rmi_unregister_physical_driver(void);
>>
>>  int rmi_register_f01_handler(void);
>>  void rmi_unregister_f01_handler(void);
>> +char *rmi_f01_get_product_ID(struct rmi_function *fn);
>>
>>  #ifdef CONFIG_RMI4_F11
>>  int rmi_register_f11_handler(void);
>> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
>> index ee5f4a1..2d72dc8 100644
>> --- a/drivers/input/rmi4/rmi_f01.c
>> +++ b/drivers/input/rmi4/rmi_f01.c
>> @@ -176,6 +176,13 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
>>       return 0;
>>  }
>>
>> +char *rmi_f01_get_product_ID(struct rmi_function *fn)
>> +{
>> +     struct f01_data *f01 = dev_get_drvdata(&fn->dev);
>> +
>> +     return f01->properties.product_id;
>> +}
>
> Should we have something like rmi_to_input_id() that is similar to
> usb_to_input_id()?

Works for me.

>
>> +
>>  static int rmi_f01_probe(struct rmi_function *fn)
>>  {
>>       struct rmi_device *rmi_dev = fn->rmi_dev;
>> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
>> index ca35b2f..1d22985 100644
>> --- a/include/linux/rmi.h
>> +++ b/include/linux/rmi.h
>> @@ -277,6 +277,8 @@ struct rmi_device_platform_data {
>>       struct rmi_f30_gpioled_map *gpioled_map;
>>       struct rmi_button_map *f41_button_map;
>>
>> +     bool unified_input;
>> +
>>  #ifdef CONFIG_RMI4_FWLIB
>>       char *firmware_name;
>>  #endif
>> --
>> 2.1.4
>>
>
> Thanks.
>

Thanks for the review!

Cheers,
Benjamin
