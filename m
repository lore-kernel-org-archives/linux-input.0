From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: rmi4 - remove the need for artificial IRQ in case
 of HID
Date: Tue, 4 Apr 2017 16:05:31 +0200
Message-ID: <20170404140531.GA2327@mail.corp.redhat.com>
References: <20170403161821.32361-1-benjamin.tissoires@redhat.com>
 <20170403182555.GA34530@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbdDDOFi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 4 Apr 2017 10:05:38 -0400
Content-Disposition: inline
In-Reply-To: <20170403182555.GA34530@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Dmitry,

On Apr 03 2017 or thereabouts, Dmitry Torokhov wrote:
> Hi Benjamin,
> 
> On Mon, Apr 03, 2017 at 06:18:21PM +0200, Benjamin Tissoires wrote:
> > The IRQ from rmi4 may interfere with the one we currently use on i2c-hid.
> > Given that there is already a need for an external API from rmi4 to
> > forward the attention data, we can, in this particular case rely on a
> > separate workqueue to prevent cursor jumps.
> 
> Can you please walk me through how IRQ handler implemented by RMI driver
> interferes with i2c-hid interrupt and why using a workqueue produces
> better results.

Unfortunately, I can only guess what is happening as I do not have
production hardware for these touchpads.

I believe the issue come from the local_irq_save()/local_irq_restore()
calls in rmi_input_event(). The data coming out of the device seems
clean in terms of coordinates:
https://bugs.freedesktop.org/attachment.cgi?id=130522
But the timing must be wrong, which leads libinput into inserting the
jumps.

I can't find (nor did Andrew) an other explanation, but I'd gladly take
one other if you can find one.

As for walking you through the current process:
- i2c-hid receives an interrupt telling that data is available
- i2c-hid read the input register from the device, which contains both
  the rmi4 irq mask and the attn_data.
- hid-core forwards the input event to hid-rmi, which then calls
  local_irq_save(), rmi_set_attn_data(), generic_handle_irq() and
  local_irq_restore().
- rmi4-core stores the attn_data in a fifo and on an IRQ pull the
  incoming data from the fifo instead of asking the transport driver to
  read from the data register

This patch removes the artificial irq handling and should theorically be
equivalent. The results show that they are not :(

> 
> Frankly, I do not like the whole attn_data business. OI wonder if we
> we could have hidden it in HID transport code.

Yes, ideally, that would be nice, but the issue is that hid-rmi is just
a transport driver and we don't know where the attn_data would be stored
in the device. So we can't hide this in the rmi_read_block operation.
And given the way you retrieve the data from the device over HID
(write of an input event, read of one other), it's a long operation,
which explains why the data is embedded in the interrupt data itself.

Cheers,
Benjamin

> 
> Thanks.
> 
> > 
> > Reported-by: Cameron Gutman <aicommander@gmail.com>
> > Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> > Reported-by: Jason Ekstrand <jason@jlekstrand.net>
> > Tested-by: Andrew Duggan <aduggan@synaptics.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> > 
> > Hi Dmitry, Jiri,
> > 
> > This is a regression introduced by my code in v4.11.
> > I do not think it is worth splitting between HID and input, there hasn't
> > been any development in hid-rmi since v4.11-rc1.
> > 
> > Cheers,
> > Benjamin
> > 
> >  drivers/hid/hid-rmi.c           |  64 ---------------------
> >  drivers/input/rmi4/rmi_driver.c | 122 ++++++++++++++++++++++++----------------
> >  include/linux/rmi.h             |   1 +
> >  3 files changed, 75 insertions(+), 112 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> > index 5b40c26..4aa882c 100644
> > --- a/drivers/hid/hid-rmi.c
> > +++ b/drivers/hid/hid-rmi.c
> > @@ -316,19 +316,12 @@ static int rmi_input_event(struct hid_device *hdev, u8 *data, int size)
> >  {
> >  	struct rmi_data *hdata = hid_get_drvdata(hdev);
> >  	struct rmi_device *rmi_dev = hdata->xport.rmi_dev;
> > -	unsigned long flags;
> >  
> >  	if (!(test_bit(RMI_STARTED, &hdata->flags)))
> >  		return 0;
> >  
> > -	local_irq_save(flags);
> > -
> >  	rmi_set_attn_data(rmi_dev, data[1], &data[2], size - 2);
> >  
> > -	generic_handle_irq(hdata->rmi_irq);
> > -
> > -	local_irq_restore(flags);
> > -
> >  	return 1;
> >  }
> >  
> > @@ -556,56 +549,6 @@ static const struct rmi_transport_ops hid_rmi_ops = {
> >  	.reset		= rmi_hid_reset,
> >  };
> >  
> > -static void rmi_irq_teardown(void *data)
> > -{
> > -	struct rmi_data *hdata = data;
> > -	struct irq_domain *domain = hdata->domain;
> > -
> > -	if (!domain)
> > -		return;
> > -
> > -	irq_dispose_mapping(irq_find_mapping(domain, 0));
> > -
> > -	irq_domain_remove(domain);
> > -	hdata->domain = NULL;
> > -	hdata->rmi_irq = 0;
> > -}
> > -
> > -static int rmi_irq_map(struct irq_domain *h, unsigned int virq,
> > -		       irq_hw_number_t hw_irq_num)
> > -{
> > -	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
> > -
> > -	return 0;
> > -}
> > -
> > -static const struct irq_domain_ops rmi_irq_ops = {
> > -	.map = rmi_irq_map,
> > -};
> > -
> > -static int rmi_setup_irq_domain(struct hid_device *hdev)
> > -{
> > -	struct rmi_data *hdata = hid_get_drvdata(hdev);
> > -	int ret;
> > -
> > -	hdata->domain = irq_domain_create_linear(hdev->dev.fwnode, 1,
> > -						 &rmi_irq_ops, hdata);
> > -	if (!hdata->domain)
> > -		return -ENOMEM;
> > -
> > -	ret = devm_add_action_or_reset(&hdev->dev, &rmi_irq_teardown, hdata);
> > -	if (ret)
> > -		return ret;
> > -
> > -	hdata->rmi_irq = irq_create_mapping(hdata->domain, 0);
> > -	if (hdata->rmi_irq <= 0) {
> > -		hid_err(hdev, "Can't allocate an IRQ\n");
> > -		return hdata->rmi_irq < 0 ? hdata->rmi_irq : -ENXIO;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> >  static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  {
> >  	struct rmi_data *data = NULL;
> > @@ -677,18 +620,11 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  
> >  	mutex_init(&data->page_mutex);
> >  
> > -	ret = rmi_setup_irq_domain(hdev);
> > -	if (ret) {
> > -		hid_err(hdev, "failed to allocate IRQ domain\n");
> > -		return ret;
> > -	}
> > -
> >  	if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)
> >  		rmi_hid_pdata.f30_data.disable = true;
> >  
> >  	data->xport.dev = hdev->dev.parent;
> >  	data->xport.pdata = rmi_hid_pdata;
> > -	data->xport.pdata.irq = data->rmi_irq;
> >  	data->xport.proto_name = "hid";
> >  	data->xport.ops = &hid_rmi_ops;
> >  
> > diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> > index d64fc92..5e65cba 100644
> > --- a/drivers/input/rmi4/rmi_driver.c
> > +++ b/drivers/input/rmi4/rmi_driver.c
> > @@ -209,32 +209,46 @@ void rmi_set_attn_data(struct rmi_device *rmi_dev, unsigned long irq_status,
> >  	attn_data.data = fifo_data;
> >  
> >  	kfifo_put(&drvdata->attn_fifo, attn_data);
> > +
> > +	schedule_work(&drvdata->attn_work);
> >  }
> >  EXPORT_SYMBOL_GPL(rmi_set_attn_data);
> >  
> > -static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
> > +static void attn_callback(struct work_struct *work)
> >  {
> > -	struct rmi_device *rmi_dev = dev_id;
> > -	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
> > +	struct rmi_driver_data *drvdata = container_of(work,
> > +							struct rmi_driver_data,
> > +							attn_work);
> >  	struct rmi4_attn_data attn_data = {0};
> >  	int ret, count;
> >  
> >  	count = kfifo_get(&drvdata->attn_fifo, &attn_data);
> > -	if (count) {
> > -		*(drvdata->irq_status) = attn_data.irq_status;
> > -		drvdata->attn_data = attn_data;
> > -	}
> > +	if (!count)
> > +		return;
> >  
> > -	ret = rmi_process_interrupt_requests(rmi_dev);
> > +	*(drvdata->irq_status) = attn_data.irq_status;
> > +	drvdata->attn_data = attn_data;
> > +
> > +	ret = rmi_process_interrupt_requests(drvdata->rmi_dev);
> >  	if (ret)
> > -		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
> > +		rmi_dbg(RMI_DEBUG_CORE, &drvdata->rmi_dev->dev,
> >  			"Failed to process interrupt request: %d\n", ret);
> >  
> > -	if (count)
> > -		kfree(attn_data.data);
> > +	kfree(attn_data.data);
> >  
> >  	if (!kfifo_is_empty(&drvdata->attn_fifo))
> > -		return rmi_irq_fn(irq, dev_id);
> > +		schedule_work(&drvdata->attn_work);
> > +}
> > +
> > +static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
> > +{
> > +	struct rmi_device *rmi_dev = dev_id;
> > +	int ret;
> > +
> > +	ret = rmi_process_interrupt_requests(rmi_dev);
> > +	if (ret)
> > +		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
> > +			"Failed to process interrupt request: %d\n", ret);
> >  
> >  	return IRQ_HANDLED;
> >  }
> > @@ -242,7 +256,6 @@ static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
> >  static int rmi_irq_init(struct rmi_device *rmi_dev)
> >  {
> >  	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
> > -	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> >  	int irq_flags = irq_get_trigger_type(pdata->irq);
> >  	int ret;
> >  
> > @@ -260,8 +273,6 @@ static int rmi_irq_init(struct rmi_device *rmi_dev)
> >  		return ret;
> >  	}
> >  
> > -	data->enabled = true;
> > -
> >  	return 0;
> >  }
> >  
> > @@ -910,23 +921,27 @@ void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake)
> >  	if (data->enabled)
> >  		goto out;
> >  
> > -	enable_irq(irq);
> > -	data->enabled = true;
> > -	if (clear_wake && device_may_wakeup(rmi_dev->xport->dev)) {
> > -		retval = disable_irq_wake(irq);
> > -		if (retval)
> > -			dev_warn(&rmi_dev->dev,
> > -				 "Failed to disable irq for wake: %d\n",
> > -				 retval);
> > -	}
> > +	if (irq) {
> > +		enable_irq(irq);
> > +		data->enabled = true;
> > +		if (clear_wake && device_may_wakeup(rmi_dev->xport->dev)) {
> > +			retval = disable_irq_wake(irq);
> > +			if (retval)
> > +				dev_warn(&rmi_dev->dev,
> > +					 "Failed to disable irq for wake: %d\n",
> > +					 retval);
> > +		}
> >  
> > -	/*
> > -	 * Call rmi_process_interrupt_requests() after enabling irq,
> > -	 * otherwise we may lose interrupt on edge-triggered systems.
> > -	 */
> > -	irq_flags = irq_get_trigger_type(pdata->irq);
> > -	if (irq_flags & IRQ_TYPE_EDGE_BOTH)
> > -		rmi_process_interrupt_requests(rmi_dev);
> > +		/*
> > +		 * Call rmi_process_interrupt_requests() after enabling irq,
> > +		 * otherwise we may lose interrupt on edge-triggered systems.
> > +		 */
> > +		irq_flags = irq_get_trigger_type(pdata->irq);
> > +		if (irq_flags & IRQ_TYPE_EDGE_BOTH)
> > +			rmi_process_interrupt_requests(rmi_dev);
> > +	} else {
> > +		data->enabled = true;
> > +	}
> >  
> >  out:
> >  	mutex_unlock(&data->enabled_mutex);
> > @@ -946,20 +961,22 @@ void rmi_disable_irq(struct rmi_device *rmi_dev, bool enable_wake)
> >  		goto out;
> >  
> >  	data->enabled = false;
> > -	disable_irq(irq);
> > -	if (enable_wake && device_may_wakeup(rmi_dev->xport->dev)) {
> > -		retval = enable_irq_wake(irq);
> > -		if (retval)
> > -			dev_warn(&rmi_dev->dev,
> > -				 "Failed to enable irq for wake: %d\n",
> > -				 retval);
> > -	}
> > -
> > -	/* make sure the fifo is clean */
> > -	while (!kfifo_is_empty(&data->attn_fifo)) {
> > -		count = kfifo_get(&data->attn_fifo, &attn_data);
> > -		if (count)
> > -			kfree(attn_data.data);
> > +	if (irq) {
> > +		disable_irq(irq);
> > +		if (enable_wake && device_may_wakeup(rmi_dev->xport->dev)) {
> > +			retval = enable_irq_wake(irq);
> > +			if (retval)
> > +				dev_warn(&rmi_dev->dev,
> > +					 "Failed to enable irq for wake: %d\n",
> > +					 retval);
> > +		}
> > +	} else {
> > +		/* make sure the fifo is clean */
> > +		while (!kfifo_is_empty(&data->attn_fifo)) {
> > +			count = kfifo_get(&data->attn_fifo, &attn_data);
> > +			if (count)
> > +				kfree(attn_data.data);
> > +		}
> >  	}
> >  
> >  out:
> > @@ -998,9 +1015,12 @@ EXPORT_SYMBOL_GPL(rmi_driver_resume);
> >  static int rmi_driver_remove(struct device *dev)
> >  {
> >  	struct rmi_device *rmi_dev = to_rmi_device(dev);
> > +	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> >  
> >  	rmi_disable_irq(rmi_dev, false);
> >  
> > +	cancel_work_sync(&data->attn_work);
> > +
> >  	rmi_f34_remove_sysfs(rmi_dev);
> >  	rmi_free_function_list(rmi_dev);
> >  
> > @@ -1230,9 +1250,15 @@ static int rmi_driver_probe(struct device *dev)
> >  		}
> >  	}
> >  
> > -	retval = rmi_irq_init(rmi_dev);
> > -	if (retval < 0)
> > -		goto err_destroy_functions;
> > +	if (pdata->irq) {
> > +		retval = rmi_irq_init(rmi_dev);
> > +		if (retval < 0)
> > +			goto err_destroy_functions;
> > +	}
> > +
> > +	data->enabled = true;
> > +
> > +	INIT_WORK(&data->attn_work, attn_callback);
> >  
> >  	if (data->f01_container->dev.driver)
> >  		/* Driver already bound, so enable ATTN now. */
> > diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> > index 64125443..dc90178 100644
> > --- a/include/linux/rmi.h
> > +++ b/include/linux/rmi.h
> > @@ -364,6 +364,7 @@ struct rmi_driver_data {
> >  
> >  	struct rmi4_attn_data attn_data;
> >  	DECLARE_KFIFO(attn_fifo, struct rmi4_attn_data, 16);
> > +	struct work_struct attn_work;
> >  };
> >  
> >  int rmi_register_transport_device(struct rmi_transport_dev *xport);
> > -- 
> > 2.9.3
> > 
> 
> -- 
> Dmitry
