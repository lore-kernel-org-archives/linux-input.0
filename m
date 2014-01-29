From: Christopher Heiny <Cheiny@synaptics.com>
Subject: RE: [PATCH] input: synaptics-rmi4 - Count IRQs before creating
 functions; save F01 container.
Date: Wed, 29 Jan 2014 22:30:48 +0000
Message-ID: <BFABBC009FBA1C43B207B15FD485ABD9302AF193@USW-MAIL1.synaptics-inc.local>
References: <1389390814-4063-1-git-send-email-cheiny@synaptics.com>,<20140127063658.GB32605@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:9659 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaA2Waf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 17:30:35 -0500
In-Reply-To: <20140127063658.GB32605@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <Vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Sorry for the delay on this.  The mail problems from earlier this week continue to plague me.

On 01/26/2014 10:36 PM, Dmitry Torokhov wrote:
> Hi Christopher,
>
> On Fri, Jan 10, 2014 at 01:53:34PM -0800, Christopher Heiny wrote:
>>
>>    err_free_data:
>> +	rmi_free_function_list(rmi_dev);
>> +	if (gpio_is_valid(pdata->attn_gpio))
>> +		gpio_free(pdata->attn_gpio);
>> +	devm_kfree(&rmi_dev->dev, data->irq_status);
>> +	devm_kfree(&rmi_dev->dev, data->current_irq_mask);
>> +	devm_kfree(&rmi_dev->dev, data->irq_mask_store);
>> +	devm_kfree(&rmi_dev->dev, data);
>
> It is rarely makes sense to explicitly free devm-managed data. In
> general I find that RMI code is very confused about when devm-managed
> resources are released (they only released after failed probe or remove,
> but we use devm_kzalloc to allocate function's interrupt masks during
> device creation and they will get freed only when parent unbinds, etc).

Yeah, we've gotten a metric ton of confusing advice/recommendations 
regarding devm_* (most of it offline from linux-input) and it shows.  At one point I 
was pretty much ready to just bag it all and write our own garbage 
collecting storage manager, but figured that would be unlikely to make 
it upstream :-)

> Given that you mentioned firmware flash in the work and I expect we'll
> be destroying and re-creating functions and other data structures at
> will I think we should limit use of devm APIs so that lifetime
> management is explicit and clear.

Sounds good.

> I tried adjusting the patch so that it works with the version of PDT
> cleanup patch I posted a few minutes ago, please let me know what you
> think.

There's some comments below.  After making those changes, I've applied this to my test tree, and it works well.

I can send updated versions of your two patches, if you'd like.

Thanks!
Chris

>
> Thanks.
>
> Input: synaptics-rmi4 - count IRQs before creating functions
>
> From: Christopher Heiny <cheiny@synaptics.com>
>
> Because creating a function can trigger events that result in the IRQ
> related
> storage being accessed, we need to count the IRQs and allocate their
> storage
> before the functions are created, rather than counting them as the
> functions
> are created and allocating them afterwards. Since we know the number of
> IRQs
> already, we can allocate the mask at function creation time, rather than in
> a post-creation loop.  Also, the F01 function_container is needed
> elsewhere,
> so we need to save it here.
>
> In order to keep the IRQ count logic sane in bootloader mode, we move the
> check for bootloader mode from F01 initialization to the IRQ counting
> routine.
>
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/rmi4/rmi_driver.c |  250
> +++++++++++++++++++++++----------------
>   drivers/input/rmi4/rmi_driver.h |    1  drivers/input/rmi4/rmi_f01.c
> |    9 -
>   3 files changed, 149 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_driver.c
> b/drivers/input/rmi4/rmi_driver.c
> index b9eb8a5..3362f58 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -184,6 +184,7 @@ static void rmi_free_function_list(struct rmi_device
> *rmi_dev)
>       list_for_each_entry_safe_reverse(fn, tmp,
>                        &data->function_list, node) {
>           list_del(&fn->node);
> +        kfree(fn->irq_mask);
>           rmi_unregister_function(fn);
>       }
>   }
> @@ -256,21 +257,20 @@ static int
> rmi_driver_process_config_requests(struct rmi_device *rmi_dev)
>       return 0;
>   }
>   -static void process_one_interrupt(struct rmi_function *fn,
> -        unsigned long *irq_status, struct rmi_driver_data *data)
> +static void process_one_interrupt(struct rmi_driver_data *data,
> +                  struct rmi_function *fn)
>   {
>       struct rmi_function_handler *fh;
> -    DECLARE_BITMAP(irq_bits, data->num_of_irq_regs);
>        if (!fn || !fn->dev.driver)
>           return;
>        fh = to_rmi_function_handler(fn->dev.driver);
>       if (fn->irq_mask && fh->attention) {
> -        bitmap_and(irq_bits, irq_status, fn->irq_mask,
> -                data->irq_count);
> -        if (!bitmap_empty(irq_bits, data->irq_count))
> -            fh->attention(fn, irq_bits);
> +        bitmap_and(data->fn_irq_bits, data->irq_status, fn->irq_mask,
> +               data->irq_count);
> +        if (!bitmap_empty(data->fn_irq_bits, data->irq_count))
> +            fh->attention(fn, data->fn_irq_bits);
>       }
>   }
>   @@ -306,11 +306,9 @@ static int process_interrupt_requests(struct
> rmi_device *rmi_dev)
>        * recent kernels (say, 3.3 and higher), this should be switched to
>        * use irq_chip.
>        */
> -    list_for_each_entry(entry, &data->function_list, node) {
> +    list_for_each_entry(entry, &data->function_list, node)
>           if (entry->irq_mask)
> -            process_one_interrupt(entry, data->irq_status,
> -                          data);
> -    }
> +            process_one_interrupt(data, entry);
>        return 0;
>   }
> @@ -469,12 +467,12 @@ static int rmi_driver_reset_handler(struct
> rmi_device *rmi_dev)
>   int rmi_driver_irq_get_mask(struct rmi_device *rmi_dev,
>                   struct rmi_function *fn)
>   {
> -    int i;
>       struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> +    int i;
>        /* call devm_kcalloc when it will be defined in kernel in future */
>       fn->irq_mask = devm_kzalloc(&rmi_dev->dev,
> -            BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
> +            BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
>               GFP_KERNEL);
>        if (fn->irq_mask) {
> @@ -604,7 +602,7 @@ static int rmi_initial_reset(struct rmi_device
> *rmi_dev,
>               return error;
>           }
>   -        mdelay(pdata->reset_delay_ms);
> +        mdelay(pdata->reset_delay_ms ?: DEFAULT_RESET_DELAY_MS);
>            return RMI_SCAN_DONE;
>       }
> @@ -613,6 +611,51 @@ static int rmi_initial_reset(struct rmi_device
> *rmi_dev,
>       return pdt->page_start == 0 ? RMI_SCAN_CONTINUE : -ENODEV;
>   }
>   +/* Indicates that flash programming is enabled (bootloader mode). */
> +#define RMI_F01_STATUS_BOOTLOADER(status)    (!!((status) & 0x40))
> +
> +/*
> + * Given the PDT entry for F01, read the device status register to
> determine
> + * if we're stuck in bootloader mode or not.
> + *
> + */
> +static int rmi_check_bootloader_mode(struct rmi_device *rmi_dev,
> +                     const struct pdt_entry *pdt)
> +{
> +    int error;
> +    u8 device_status;
> +
> +    error = rmi_read(rmi_dev, pdt->data_base_addr + pdt->page_start,
> +             &device_status);

Since this is applied after your previous patch, then this statement should be:
	error = rmi_read(rmi_dev, pdt->data_base_addr, &device_status);


> +    if (error) {
> +        dev_err(&rmi_dev->dev,
> +            "Failed to read device status: %d\n", error);
> +        return error;
> +    }
> +
> +    return RMI_F01_STATUS_BOOTLOADER(device_status);
> +}
> +
> +static int rmi_count_irqs(struct rmi_device *rmi_dev,
> +              void *ctx, const struct pdt_entry *pdt)
> +{
> +    struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> +    int *irq_count = ctx;
> +
> +    *irq_count += pdt->interrupt_source_count;
> +    if (pdt->function_number == 0x01) {
> +        data->f01_bootloader_mode =
> +            rmi_check_bootloader_mode(rmi_dev, pdt);
> +        if (data->f01_bootloader_mode) {
> +            dev_warn(&rmi_dev->dev,
> +                 "WARNING: RMI4 device is in bootloader mode!\n");
> +            return RMI_SCAN_DONE;

We can't stop the scan here, or the IRQ count for Page 0 might be 
inaccurate.

> +        }
> +    }
> +
> +    return RMI_SCAN_CONTINUE;
> +}
> +
>   static int rmi_create_function(struct rmi_device *rmi_dev,
>                      void *ctx, const struct pdt_entry *pdt)
>   {
> @@ -621,6 +664,7 @@ static int rmi_create_function(struct rmi_device
> *rmi_dev,
>       struct rmi_device_platform_data *pdata =
> to_rmi_platform_data(rmi_dev);
>       int *current_irq_count = ctx;
>       struct rmi_function *fn;
> +    int i;
>       int error;
>        dev_dbg(dev, "Initializing F%02X for %s.\n",
> @@ -634,53 +678,46 @@ static int rmi_create_function(struct rmi_device
> *rmi_dev,
>       }
>        INIT_LIST_HEAD(&fn->node);
> +    rmi_driver_copy_pdt_to_fd(pdt, &fn->fd);
>        fn->rmi_dev = rmi_dev;
> -    fn->num_of_irqs = pdt->interrupt_source_count;
>   +    fn->num_of_irqs = pdt->interrupt_source_count;
>       fn->irq_pos = *current_irq_count;
>       *current_irq_count += fn->num_of_irqs;
>   -    rmi_driver_copy_pdt_to_fd(pdt, &fn->fd);
> +    fn->irq_mask = kcalloc(BITS_TO_LONGS(data->irq_count),
> +                   sizeof(unsigned long),
> +                   GFP_KERNEL);
> +    if (!fn->irq_mask) {
> +        dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
> +            __func__, pdt->function_number);
> +        error = -ENOMEM;
> +        goto err_free_mem;
> +    }
> +
> +    for (i = 0; i < fn->num_of_irqs; i++)
> +        __set_bit(fn->irq_pos + i, fn->irq_mask);
>        error = rmi_register_function(fn);
>       if (error)
> -        goto err_free_mem;
> +        goto err_free_irq_mask;
> +
> +    if (pdt->function_number == 0x01)
> +        data->f01_container = fn;
>        list_add_tail(&fn->node, &data->function_list);
>   -    return data->f01_bootloader_mode ? RMI_SCAN_DONE :
> RMI_SCAN_CONTINUE;
> +    return pdt->function_number == 0x01 && data->f01_bootloader_mode ?
> +        RMI_SCAN_DONE : RMI_SCAN_CONTINUE;

As mentioned before, I think this logic is broken.

>   +err_free_irq_mask:
> +    kfree(fn->irq_mask);
>   err_free_mem:
>       kfree(fn);
>       return error;
>   }

[snip]