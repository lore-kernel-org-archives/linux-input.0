From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 01/15] Input: synaptics-rmi4 - fix checkpatch.pl, sparse
 and GCC warnings
Date: Tue, 4 Feb 2014 15:08:12 -0800
Message-ID: <52F172DC.5090900@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:63783 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716AbaBDXIR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 18:08:17 -0500
In-Reply-To: <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> Cc: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> ---
>   drivers/input/rmi4/rmi_bus.c    |  4 ++--
>   drivers/input/rmi4/rmi_bus.h    |  2 +-
>   drivers/input/rmi4/rmi_driver.c | 17 ++++++++++++-----
>   drivers/input/rmi4/rmi_f11.c    |  4 +++-
>   4 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index 96a76e7..8a939f3 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -37,7 +37,7 @@ static void rmi_release_device(struct device *dev)
>   	kfree(rmi_dev);
>   }
>
> -struct device_type rmi_device_type = {
> +static struct device_type rmi_device_type = {
>   	.name		= "rmi_sensor",
>   	.release	= rmi_release_device,
>   };

This struct is used by diagnostic modules to identify sensor devices, so 
it cannot be static.

> @@ -145,7 +145,7 @@ static void rmi_release_function(struct device *dev)
>   	kfree(fn);
>   }
>
> -struct device_type rmi_function_type = {
> +static struct device_type rmi_function_type = {
>   	.name		= "rmi_function",
>   	.release	= rmi_release_function,
>   };

This struct is used by diagnostic modules to identify function devices, 
so it cannot be static.

> diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
> index decb479..2bad2ed 100644
> --- a/drivers/input/rmi4/rmi_bus.h
> +++ b/drivers/input/rmi4/rmi_bus.h
> @@ -103,7 +103,7 @@ int __must_check __rmi_register_function_handler(struct rmi_function_handler *,
>   #define rmi_register_function_handler(handler) \
>   	__rmi_register_function_handler(handler, THIS_MODULE, KBUILD_MODNAME)
>
> -void rmi_unregister_function_handler(struct rmi_function_handler *);
> +void rmi_unregister_function_handler(struct rmi_function_handler *handler);
>
>   /**
>    * struct rmi_driver - driver for an RMI4 sensor on the RMI bus.
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 3483e5b..5c6379c 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -32,6 +32,8 @@
>   #include "rmi_bus.h"
>   #include "rmi_driver.h"
>
> +#define RMI4_MAX_N_IRQS 256

I see what you're trying to do here, but the IRQ counting patch 
submitted previously does this in a more efficient way, though at a 
slight cost in compute time during initialization.

> +
>   #define HAS_NONSTANDARD_PDT_MASK 0x40
>   #define RMI4_MAX_PAGE 0xff
>   #define RMI4_PAGE_SIZE 0x100
> @@ -260,7 +262,7 @@ static void process_one_interrupt(struct rmi_function *fn,
>   		unsigned long *irq_status, struct rmi_driver_data *data)
>   {
>   	struct rmi_function_handler *fh;
> -	DECLARE_BITMAP(irq_bits, data->num_of_irq_regs);
> +	DECLARE_BITMAP(irq_bits, RMI4_MAX_N_IRQS);
>
>   	if (!fn || !fn->dev.driver)
>   		return;
> @@ -325,7 +327,7 @@ static int process_interrupt_requests(struct rmi_device *rmi_dev)
>   static int rmi_driver_set_input_params(struct rmi_device *rmi_dev,
>   				struct input_dev *input)
>   {
> -	// FIXME: set up parent
> +	/* FIXME: set up parent */
>   	input->name = SYNAPTICS_INPUT_DEVICE_NAME;
>   	input->id.vendor  = SYNAPTICS_VENDOR_ID;
>   	input->id.bustype = BUS_RMI;
> @@ -466,7 +468,7 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
>   /*
>    * Construct a function's IRQ mask. This should be called once and stored.
>    */
> -int rmi_driver_irq_get_mask(struct rmi_device *rmi_dev,
> +static int rmi_driver_irq_get_mask(struct rmi_device *rmi_dev,
>   		struct rmi_function *fn) {
>   	int i;
>   	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> @@ -665,7 +667,7 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev)
>   					pdt_entry.function_number, page);
>   			done = false;
>
> -			// XXX need to make sure we create F01 first...
> +			/* XXX need to make sure we create F01 first... */
>   			retval = create_function(rmi_dev,
>   					&pdt_entry, &irq_count, page_start);
>
> @@ -674,6 +676,11 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev)
>   		}
>   		done = done || data->f01_bootloader_mode;
>   	}
> +	if (irq_count > RMI4_MAX_N_IRQS) {
> +		dev_err(dev, "Too many IRQs specified\n");
> +		retval = -EINVAL;
> +		goto error_exit;
> +	}
>   	data->irq_count = irq_count;
>   	data->num_of_irq_regs = (irq_count + 7) / 8;
>   	dev_dbg(dev, "%s: Done with PDT scan.\n", __func__);
> @@ -953,7 +960,7 @@ static int rmi_driver_probe(struct device *dev)
>   	return retval;
>   }
>
> -struct rmi_driver rmi_physical_driver = {
> +static struct rmi_driver rmi_physical_driver = {
>   	.driver = {
>   		.owner	= THIS_MODULE,
>   		.name	= "rmi_physical",
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index c2be9de..4e0a296 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -610,6 +610,8 @@ static void rmi_f11_abs_pos_report(struct f11_data *f11,
>   	int temp;
>   	u8 abs_base = n_finger * RMI_F11_ABS_BYTES;
>
> +	orient = z = w_min = w_max = 0;
> +
>   	if (finger_state) {
>   		x = (data->abs_pos[abs_base] << 4) |
>   			(data->abs_pos[abs_base + 2] & 0x0F);
> @@ -1413,7 +1415,7 @@ static int rmi_f11_config(struct rmi_function *fn)
>   	return 0;
>   }
>
> -int rmi_f11_attention(struct rmi_function *fn,
> +static int rmi_f11_attention(struct rmi_function *fn,
>   						unsigned long *irq_bits)
>   {
>   	struct rmi_device *rmi_dev = fn->rmi_dev;
>

