From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 1/2] Input: synaptics-rmi4 - factor out functions from
 probe
Date: Mon, 10 Oct 2016 15:04:56 +0200
Message-ID: <20161010130456.GI30411@mail.corp.redhat.com>
References: <1474404162-29357-1-git-send-email-nick@shmanahar.org>
 <1474404162-29357-2-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474404162-29357-2-git-send-email-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sep 20 2016 or thereabouts, Nick Dyer wrote:
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> ---
>  drivers/input/rmi4/rmi_driver.c | 139 +++++++++++++++++++++++++---------------
>  1 file changed, 86 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index c83bce8..f17bfe0 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -39,6 +39,8 @@ static void rmi_free_function_list(struct rmi_device *rmi_dev)
>  	struct rmi_function *fn, *tmp;
>  	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>  
> +	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
> +
>  	data->f01_container = NULL;
>  
>  	/* Doing it in the reverse order so F01 will be removed last */
> @@ -843,15 +845,90 @@ static inline int rmi_driver_of_probe(struct device *dev,
>  }
>  #endif
>  
> +static int rmi_probe_interrupts(struct rmi_driver_data *data)
> +{
> +	struct rmi_device *rmi_dev = data->rmi_dev;
> +	struct device *dev = &rmi_dev->dev;
> +	int irq_count;
> +	size_t size;
> +	void *irq_memory;
> +	int retval;
> +
> +	/*
> +	 * We need to count the IRQs and allocate their storage before scanning
> +	 * the PDT and creating the function entries, because adding a new
> +	 * function can trigger events that result in the IRQ related storage
> +	 * being accessed.
> +	 */
> +	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Counting IRQs.\n", __func__);
> +	irq_count = 0;
> +	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
> +	if (retval < 0) {
> +		dev_err(dev, "IRQ counting failed with code %d.\n", retval);
> +		return retval;
> +	}
> +	data->irq_count = irq_count;
> +	data->num_of_irq_regs = (data->irq_count + 7) / 8;
> +
> +	size = BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long);
> +	irq_memory = devm_kzalloc(dev, size * 4, GFP_KERNEL);
> +	if (!irq_memory) {
> +		dev_err(dev, "Failed to allocate memory for irq masks.\n");
> +		return retval;
> +	}
> +
> +	data->irq_status	= irq_memory + size * 0;
> +	data->fn_irq_bits	= irq_memory + size * 1;
> +	data->current_irq_mask	= irq_memory + size * 2;
> +	data->new_irq_mask	= irq_memory + size * 3;
> +
> +	return retval;
> +}
> +
> +static int rmi_init_functions(struct rmi_driver_data *data)
> +{
> +	struct rmi_device *rmi_dev = data->rmi_dev;
> +	struct device *dev = &rmi_dev->dev;
> +	int irq_count;
> +	int retval;
> +
> +	irq_count = 0;
> +	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Creating functions.\n", __func__);
> +	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
> +	if (retval < 0) {
> +		dev_err(dev, "Function creation failed with code %d.\n",
> +			retval);
> +		goto err_destroy_functions;
> +	}
> +
> +	if (!data->f01_container) {
> +		dev_err(dev, "Missing F01 container!\n");
> +		retval = -EINVAL;
> +		goto err_destroy_functions;
> +	}
> +
> +	retval = rmi_read_block(rmi_dev,
> +				data->f01_container->fd.control_base_addr + 1,
> +				data->current_irq_mask, data->num_of_irq_regs);
> +	if (retval < 0) {
> +		dev_err(dev, "%s: Failed to read current IRQ mask.\n",
> +			__func__);
> +		goto err_destroy_functions;
> +	}
> +
> +	return 0;
> +
> +err_destroy_functions:
> +	rmi_free_function_list(rmi_dev);
> +	return retval;
> +}
> +
>  static int rmi_driver_probe(struct device *dev)
>  {
>  	struct rmi_driver *rmi_driver;
>  	struct rmi_driver_data *data;
>  	struct rmi_device_platform_data *pdata;
>  	struct rmi_device *rmi_dev;
> -	size_t size;
> -	void *irq_memory;
> -	int irq_count;
>  	int retval;
>  
>  	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Starting probe.\n",
> @@ -917,35 +994,11 @@ static int rmi_driver_probe(struct device *dev)
>  			 PDT_PROPERTIES_LOCATION, retval);
>  	}
>  
> -	/*
> -	 * We need to count the IRQs and allocate their storage before scanning
> -	 * the PDT and creating the function entries, because adding a new
> -	 * function can trigger events that result in the IRQ related storage
> -	 * being accessed.
> -	 */
> -	rmi_dbg(RMI_DEBUG_CORE, dev, "Counting IRQs.\n");
> -	irq_count = 0;
> -	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
> -	if (retval < 0) {
> -		dev_err(dev, "IRQ counting failed with code %d.\n", retval);
> -		goto err;
> -	}
> -	data->irq_count = irq_count;
> -	data->num_of_irq_regs = (data->irq_count + 7) / 8;
> -
>  	mutex_init(&data->irq_mutex);

I am happy with this one, especially because it moves the initialization
of this mutex before the scan of the PDT. On the SMBus devices, when the
scan is done, this triggers some notifications from the device, and with
the mutex not being initialized, it leads to oopses in
rmi_process_interrupt().

Reviewed-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  
> -	size = BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long);
> -	irq_memory = devm_kzalloc(dev, size * 4, GFP_KERNEL);
> -	if (!irq_memory) {
> -		dev_err(dev, "Failed to allocate memory for irq masks.\n");
> +	retval = rmi_probe_interrupts(data);
> +	if (retval)
>  		goto err;
> -	}
> -
> -	data->irq_status	= irq_memory + size * 0;
> -	data->fn_irq_bits	= irq_memory + size * 1;
> -	data->current_irq_mask	= irq_memory + size * 2;
> -	data->new_irq_mask	= irq_memory + size * 3;
>  
>  	if (rmi_dev->xport->input) {
>  		/*
> @@ -962,36 +1015,16 @@ static int rmi_driver_probe(struct device *dev)
>  			dev_err(dev, "%s: Failed to allocate input device.\n",
>  				__func__);
>  			retval = -ENOMEM;
> -			goto err_destroy_functions;
> +			goto err;
>  		}
>  		rmi_driver_set_input_params(rmi_dev, data->input);
>  		data->input->phys = devm_kasprintf(dev, GFP_KERNEL,
>  						"%s/input0", dev_name(dev));
>  	}
>  
> -	irq_count = 0;
> -	rmi_dbg(RMI_DEBUG_CORE, dev, "Creating functions.");
> -	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
> -	if (retval < 0) {
> -		dev_err(dev, "Function creation failed with code %d.\n",
> -			retval);
> -		goto err_destroy_functions;
> -	}
> -
> -	if (!data->f01_container) {
> -		dev_err(dev, "Missing F01 container!\n");
> -		retval = -EINVAL;
> -		goto err_destroy_functions;
> -	}
> -
> -	retval = rmi_read_block(rmi_dev,
> -				data->f01_container->fd.control_base_addr + 1,
> -				data->current_irq_mask, data->num_of_irq_regs);
> -	if (retval < 0) {
> -		dev_err(dev, "%s: Failed to read current IRQ mask.\n",
> -			__func__);
> -		goto err_destroy_functions;
> -	}
> +	retval = rmi_init_functions(data);
> +	if (retval)
> +		goto err;
>  
>  	if (data->input) {
>  		rmi_driver_set_input_name(rmi_dev, data->input);
> -- 
> 2.7.4
> 
