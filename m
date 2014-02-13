From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input synaptics-rmi4: Use put_device() and device_type.release()
 to free storage.
Date: Wed, 12 Feb 2014 18:31:04 -0800
Message-ID: <52FC2E68.1060709@synaptics.com>
References: <1392160410-8293-1-git-send-email-cheiny@synaptics.com> <20140212064925.GC15855@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:44482 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaBMCbF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Feb 2014 21:31:05 -0500
In-Reply-To: <20140212064925.GC15855@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Courtney Cavin <courtney.cavin@sonymobile.com>

On 02/11/2014 10:49 PM, Dmitry Torokhov wrote:
> On Tue, Feb 11, 2014 at 03:13:30PM -0800, Christopher Heiny wrote:
>> For rmi_sensor and rmi_function device_types, use put_device() and
>> the assocated device_type.release() function to clean up related
>> structures and storage in the correct and safe order.
>>
>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Cc: Linux Walleij <linus.walleij@linaro.org>
>> Cc: David Herrmann <dh.herrmann@gmail.com>
>> Cc: Jiri Kosina <jkosina@suse.cz>
>> Cc: Courtney Cavin <courtney.cavin@sonymobile.com>
>>
>> ---
>>
>>   drivers/input/rmi4/rmi_bus.c    | 65 +++++++++++++++--------------------------
>>   drivers/input/rmi4/rmi_driver.c | 11 ++-----
>>   2 files changed, 25 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
>> index 96a76e7..1b9ad80 100644
>> --- a/drivers/input/rmi4/rmi_bus.c
>> +++ b/drivers/input/rmi4/rmi_bus.c

[snip]

>> @@ -185,6 +153,23 @@ static void rmi_function_teardown_debugfs(struct rmi_function *fn)
>>   }
>>
>>   #endif
>> +static void rmi_release_function(struct device *dev)
>> +{
>> +	struct rmi_function *fn = to_rmi_function(dev);
>> +	rmi_function_teardown_debugfs(fn);
>
> This is wrong, rmi_release_function should finish cleaning up resources,
> however unregistration part should happen much earlier. If someone takes
> reference to the device in debugfs the device may never go away as noone
> will kick the user out.
>
> Please put the calls to rmi_function_teardown_debugfs() back where they
> originally were.

OK.

>
>> +	kfree(fn->irq_mask);
>> +	kfree(fn);
>> +}
>> +
>> +struct device_type rmi_function_type = {
>> +	.name		= "rmi_function",
>> +	.release	= rmi_release_function,
>> +};
>> +
>> +bool rmi_is_function_device(struct device *dev)
>> +{
>> +	return dev->type == &rmi_function_type;
>> +}
>>
>>   static int rmi_function_match(struct device *dev, struct device_driver *drv)
>>   {
>> @@ -240,21 +225,17 @@ int rmi_register_function(struct rmi_function *fn)
>>   		dev_err(&rmi_dev->dev,
>>   			"Failed device_register function device %s\n",
>>   			dev_name(&fn->dev));
>> -		goto error_exit;
>> +		put_device(&fn->dev);
>> +		return error;
>>   	}
>>
>>   	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n", fn->fd.function_number);
>>
>>   	return 0;
>> -
>> -error_exit:
>> -	rmi_function_teardown_debugfs(fn);
>> -	return error;
>>   }
>>
>>   void rmi_unregister_function(struct rmi_function *fn)
>>   {
>> -	rmi_function_teardown_debugfs(fn);
>>   	device_unregister(&fn->dev);
>>   }
>>
>> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
>> index 34f19e9..43575a1 100644
>> --- a/drivers/input/rmi4/rmi_driver.c
>> +++ b/drivers/input/rmi4/rmi_driver.c
>> @@ -674,8 +674,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>>   	if (!fn->irq_mask) {
>>   		dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
>>   			__func__, pdt->function_number);
>> -		error = -ENOMEM;
>> -		goto err_free_mem;
>> +		return -ENOMEM;
>>   	}
>>
>>   	for (i = 0; i < fn->num_of_irqs; i++)
>> @@ -683,7 +682,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>>
>>   	error = rmi_register_function(fn);
>>   	if (error)
>> -		goto err_free_irq_mask;
>> +		return error;
>>
>>   	if (pdt->function_number == 0x01)
>>   		data->f01_container = fn;
>> @@ -691,12 +690,6 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>>   	list_add_tail(&fn->node, &data->function_list);
>>
>>   	return RMI_SCAN_CONTINUE;
>> -
>> -err_free_irq_mask:
>> -	kfree(fn->irq_mask);
>> -err_free_mem:
>> -	kfree(fn);
>> -	return error;
>
> Unless you create rmi_allocate_function() and do device initialization
> there (so that device and kobject are fully initialized and proper ktype
> is assigned so that ->release() is set up) you still need to free memory
> here if failure happens before calling rmi_register_function().

Hmmm.  If we adopt the idea of allocating the irq_mask as an
array in the rmi_function structure, like you did in your
rmi_f01.c patch for the interrupt_enable mask, then there's no
point of failure bewteen allocating the storage and the call to
rmi_register_function().  rmi_register_function() doesn't have a
failure point prior to calling device_register(), and the
put_device() call in there should be able clean things up, like
Courtney proposed.

So making that change, along with some others you and Courtney
have suggested in other emails, we get the patch below.

					Chris

--

Input: synaptics-rmi4 - Use put_device() and device_type.release() to 
free storage.

From: Christopher Heiny <cheiny@synaptics.com>

For rmi_sensor and rmi_function device_types, use put_device() and
the assocated device_type.release() function to clean up related
structures and storage in the correct and safe order.

Allocate irq_mask as part of struct rmi_function.

Delete unused rmi_driver_irq_get_mask() function.

Suggested-by: Courtney Cavin <courtney.cavin@sonymobile.com>
Signed-off-by: Christopher Heiny <cheiny@synaptics.com>

---

  drivers/input/rmi4/rmi_bus.c    | 17 ++++++++-------
  drivers/input/rmi4/rmi_bus.h    |  2 +-
  drivers/input/rmi4/rmi_driver.c | 46 
+++++------------------------------------
  3 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 96a76e7..6342b45 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -34,6 +34,7 @@ static struct dentry *rmi_debugfs_root;
  static void rmi_release_device(struct device *dev)
  {
  	struct rmi_device *rmi_dev = to_rmi_device(dev);
+
  	kfree(rmi_dev);
  }

@@ -94,8 +95,7 @@ int rmi_register_transport_device(struct 
rmi_transport_dev *xport)
  		return -EINVAL;
  	}

-	rmi_dev = devm_kzalloc(xport->dev,
-				sizeof(struct rmi_device), GFP_KERNEL);
+	rmi_dev = kzalloc(sizeof(struct rmi_device), GFP_KERNEL);
  	if (!rmi_dev)
  		return -ENOMEM;

@@ -112,8 +112,10 @@ int rmi_register_transport_device(struct 
rmi_transport_dev *xport)
  	rmi_physical_setup_debugfs(rmi_dev);

  	error = device_register(&rmi_dev->dev);
-	if (error)
+	if (error) {
+		put_device(&rmi_dev->dev);
  		return error;
+	}

  	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
  		pdata->sensor_name, dev_name(&rmi_dev->dev));
@@ -142,6 +144,7 @@ EXPORT_SYMBOL(rmi_unregister_transport_device);
  static void rmi_release_function(struct device *dev)
  {
  	struct rmi_function *fn = to_rmi_function(dev);
+
  	kfree(fn);
  }

@@ -240,16 +243,14 @@ int rmi_register_function(struct rmi_function *fn)
  		dev_err(&rmi_dev->dev,
  			"Failed device_register function device %s\n",
  			dev_name(&fn->dev));
-		goto error_exit;
+		rmi_function_teardown_debugfs(fn);
+		put_device(&fn->dev);
+		return error;
  	}

  	dev_dbg(&rmi_dev->dev, "Registered F%02X.\n", fn->fd.function_number);

  	return 0;
-
-error_exit:
-	rmi_function_teardown_debugfs(fn);
-	return error;
  }

  void rmi_unregister_function(struct rmi_function *fn)
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index decb479..a544c9c 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -47,13 +47,13 @@ struct rmi_function {
  	struct device dev;
  	int num_of_irqs;
  	int irq_pos;
-	unsigned long *irq_mask;
  	void *data;
  	struct list_head node;

  #ifdef CONFIG_RMI4_DEBUG
  	struct dentry *debugfs_root;
  #endif
+	unsigned long irq_mask[];
  };

  #define to_rmi_function(d)	container_of(d, struct rmi_function, dev)
diff --git a/drivers/input/rmi4/rmi_driver.c 
b/drivers/input/rmi4/rmi_driver.c
index 34f19e9..a6a1aea 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -185,7 +185,6 @@ static void rmi_free_function_list(struct rmi_device 
*rmi_dev)
  	list_for_each_entry_safe_reverse(fn, tmp,
  					 &data->function_list, node) {
  		list_del(&fn->node);
-		kfree(fn->irq_mask);
  		rmi_unregister_function(fn);
  	}
  }
@@ -456,28 +455,6 @@ static int rmi_driver_reset_handler(struct 
rmi_device *rmi_dev)
  	return 0;
  }

-/*
- * Construct a function's IRQ mask. This should be called once and stored.
- */
-int rmi_driver_irq_get_mask(struct rmi_device *rmi_dev,
-			   struct rmi_function *fn)
-{
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	int i;
-
-	/* call devm_kcalloc when it will be defined in kernel in future */
-	fn->irq_mask = devm_kzalloc(&rmi_dev->dev,
-			BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
-			GFP_KERNEL);
-
-	if (fn->irq_mask) {
-		for (i = 0; i < fn->num_of_irqs; i++)
-			set_bit(fn->irq_pos+i, fn->irq_mask);
-		return 0;
-	} else
-		return -ENOMEM;
-}
-
  int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry 
*entry,
  			u16 pdt_address)
  {
@@ -652,7 +629,10 @@ static int rmi_create_function(struct rmi_device 
*rmi_dev,
  	dev_dbg(dev, "Initializing F%02X for %s.\n",
  		pdt->function_number, pdata->sensor_name);

-	fn = kzalloc(sizeof(struct rmi_function), GFP_KERNEL);
+	fn = kzalloc(sizeof(struct rmi_function) +
+			(BITS_TO_LONGS(data->irq_count) *
+				sizeof(unsigned long)),
+			GFP_KERNEL);
  	if (!fn) {
  		dev_err(dev, "Failed to allocate memory for F%02X\n",
  			pdt->function_number);
@@ -668,22 +648,12 @@ static int rmi_create_function(struct rmi_device 
*rmi_dev,
  	fn->irq_pos = *current_irq_count;
  	*current_irq_count += fn->num_of_irqs;

-	fn->irq_mask = kzalloc(
-		BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
-		GFP_KERNEL);
-	if (!fn->irq_mask) {
-		dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
-			__func__, pdt->function_number);
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
-
  	for (i = 0; i < fn->num_of_irqs; i++)
  		set_bit(fn->irq_pos + i, fn->irq_mask);

  	error = rmi_register_function(fn);
  	if (error)
-		goto err_free_irq_mask;
+		return error;

  	if (pdt->function_number == 0x01)
  		data->f01_container = fn;
@@ -691,12 +661,6 @@ static int rmi_create_function(struct rmi_device 
*rmi_dev,
  	list_add_tail(&fn->node, &data->function_list);

  	return RMI_SCAN_CONTINUE;
-
-err_free_irq_mask:
-	kfree(fn->irq_mask);
-err_free_mem:
-	kfree(fn);
-	return error;
  }

  #ifdef CONFIG_PM_SLEEP


