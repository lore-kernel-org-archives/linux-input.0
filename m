From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: Synaptics RMI4 touchpad regression in 4.11-rc1
Date: Fri, 31 Mar 2017 15:23:32 -0700
Message-ID: <7852131c-51a6-51ba-dd64-dd0568272ad6@synaptics.com>
References: <20170313131537.GI4378@mail.corp.redhat.com>
 <07543e67-efef-a764-02e6-d81d30b89a1c@synaptics.com>
 <03d8e6ac-1ba4-36a6-cc07-0c07e61f754f@gmail.com>
 <86d9e1c0-8e2b-acdd-64a1-774fc7a4d778@synaptics.com>
 <CAN+gG=Eak7oCXPiwR+NPT12pcx45qeYojemxauepdyyFgdShEA@mail.gmail.com>
 <4685193c-1512-44ad-bfde-1455becb9db4@synaptics.com>
 <20170320050009.GA20783@jelly>
 <f23fbe37-d611-163f-9f1b-79771cbfa368@synaptics.com>
 <20170329085006.GK4009@mail.corp.redhat.com>
 <0711305d-28d8-c51b-16cb-f389f1a4610d@synaptics.com>
 <20170331085751.GF22683@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:4171 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933334AbdCaWXd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 18:23:33 -0400
In-Reply-To: <20170331085751.GF22683@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jason Ekstrand <jason@jlekstrand.net>, Cameron Gutman <aicommander@gmail.com>, Thorsten Leemhuis <linux@leemhuis.info>, Jiri Kosina <jikos@kernel.org>, Nick Dyer <nick@shmanahar.org>, Christopher Heiny <cheiny@synaptics.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 03/31/2017 01:57 AM, Benjamin Tissoires wrote:
> On Mar 29 2017 or thereabouts, Andrew Duggan wrote:
>>
>> On 03/29/2017 01:50 AM, Benjamin Tissoires wrote:
>>> On Mar 28 2017 or thereabouts, Andrew Duggan wrote:
>>>> On 03/19/2017 10:00 PM, Peter Hutterer wrote:
>>>>> On Fri, Mar 17, 2017 at 12:23:36PM -0700, Andrew Duggan wrote:
>>>>>> On 03/17/2017 09:57 AM, Benjamin Tissoires wrote:
>>>>>>> On Wed, Mar 15, 2017 at 2:19 AM, Andrew Duggan<aduggan@synaptics.com>  wrote:
>>>>>>>> On 03/13/2017 10:10 PM, Cameron Gutman wrote:
>>>>>>>>> On 03/13/2017 06:35 PM, Andrew Duggan wrote:
>>>>>>>>>> On 03/13/2017 06:15 AM, Benjamin Tissoires wrote:
>>>>>>>>>>> [Resending, forgot to add Jiri in CC]
>>>>>>>>>>>
>>>>>>>>>>> On Mar 13 2017 or thereabouts, Benjamin Tissoires wrote:
>>>>>>>>>>>> On Mar 13 2017 or thereabouts, Thorsten Leemhuis wrote:
>>>>>>>>>>>>> Lo! On 12.03.2017 02:55, Cameron Gutman wrote:
>>>>>>>>>>>>>> Beginning in 4.11-rc1, it looks like RMI4 is binding to my XPS 13
>>>>>>>>>>>>>> 9343's
>>>>>>>>>>>>>> Synaptics touchpad and dropping some errors into dmesg. Here are the
>>>>>>>>>>>>>> messages that seem RMI-related:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader
>>>>>>>>>>>>>> version
>>>>>>>>>>>>>> rmi4_f34: probe of rmi4-00.fn34 failed with error -22
>>>>>>>>>>>>>> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
>>>>>>>>>>>>>> product: TM3038-001, fw id: 1832324
>>>>>>>>>>>>>> input: Synaptics TM3038-001 as
>>>>>>>>>>>>>> /devices/pci0000:00/INT3433:00/i2c-7/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input19
>>>>>>>>>>>>>> hid-rmi 0018:06CB:76AD.0001: input,hidraw0: I2C HID v1.00 Mouse
>>>>>>>>>>>>>> [DLL0665:01 06CB:76AD] on i2c-DLL0665:01
>>>>>>>>>>>>> FWIW, I get this on my XPS 13 DE (9360) with 4.11-rc1:
>>>>>>>>>>>>>
>>>>>>>>>>>>> input: SynPS/2 Synaptics TouchPad as
>>>>>>>>>>>>> /devices/platform/i8042/serio1/input/input6
>>>>>>>>>>>>> rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader
>>>>>>>>>>>>> version
>>>>>>>>>>>>> rmi4_f34: probe of rmi4-00.fn34 failed with error -22
>>>>>>>>>>>>> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
>>>>>>>>>>>>> product: TM3038-003, fw id: 2375007
>>>>>>>>>>>>> input: Synaptics TM3038-003 as
>>>>>>>>>>>>>
>>>>>>>>>>>>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input20
>>>>>>>>>>>>> hid-rmi 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse
>>>>>>>>>>>>> [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
>>>>>>>>>>>>>
>>>>>>>>>>>>>> […]
>>>>>>>>>>>>>> Compared to hid-multitouch, the RMI stack seems to have completely
>>>>>>>>>>>>>> broken
>>>>>>>>>>>>>> palm rejection and introduced some random jumpiness during fine
>>>>>>>>>>>>>> pointing
>>>>>>>>>>>>>> motions. I don't know if these issues are caused by the above errors
>>>>>>>>>>>>>> or
>>>>>>>>>>>>>> are a separate issue.
>>>>>>>>>> The error about the bootloader version not being recognized just means
>>>>>>>>>> that updating the firmware is not supported on this touchpad. It is only the
>>>>>>>>>> F34 firmware update functionality which is failing to load. The palm
>>>>>>>>>> rejection and jumps are not related to this error.
>>>>>>>>>>
>>>>>>>>> Maybe that code path should be changed to not make as much noise when it
>>>>>>>>> runs
>>>>>>>>> on known unsupported hardware. Something like the attached patch?
>>>>>>>>>
>>>>>>>>>> Looking at how hid-multitouch handles palms it looks like palms should
>>>>>>>>>> not be reported as active when calling input_mt_report_slot_state(). I'm
>>>>>>>>>> setting the tool type to MT_TOOL_PALM when the firmware determines that a
>>>>>>>>>> contact is a palm. But, that does not seem to be sufficient enough to have
>>>>>>>>>> the palms filtered out. After some quick testing it looks like the change
>>>>>>>>>> below will restore palm rejection similar to that provided by
>>>>>>>>>> hid-multitouch.
>>>>>>>>>>
>>>>>>>>> It looks like your email client ate the tabs, but if I apply the change
>>>>>>>>> myself it seems to fix the palm rejection regression for me.
>>>>>>>>>
>>>>>>>>> Tested-by: Cameron Gutman<aicommander@gmail.com>
>>>>>>>> Sorry, I was short on time and just copied the diff into the email. I'll
>>>>>>>> submit a proper patch soon with your tested-by included. Thanks for testing.
>>>>>>>>
>>>>>>>>
>>>>>>> I just pointed out this patch (well the actual submission) to Jason
>>>>>>> (Cc-ed). Given that there is no proper handling of MT_TOOL_PALM yet in
>>>>>>> userspace, I thought it was the easiest way.
>>>>>>> However, it seems that this doesn't enhance the jumps and just make it worse.
>>>>>> I was assuming that the jumps and palm rejection where two separate issues.
>>>>>> But, the palm rejection patch makes things worse?
>>>>>>
>>>>>>> Is there anything we can do to fix it (besides temporary disabling the
>>>>>>> automatic loading of hid-rmi)?
>>>>>> I do not have a fix for the jumps yet. My next step is to file a bug against
>>>>>> libinput or the kernel. I used evemu-record to capture a log with jumps, but
>>>>>> when I play it back with a different userspace input stack with an older
>>>>>> version of libinput I do not see the jumps. I see the jumps on Fedora 25
>>>>>> with libinput 1.6.3 vs Ubuntu 16.10 with libinput 1.4.3 with X). Or at least
>>>>>> the jumps are not as significant. But, its possible there is an issue with
>>>>>> how the events are being reported which is incorrect and confusing libinput.
>>>>>> The X and Y coordinates being reported by the firmware seem correct and I
>>>>>> haven't found a problem yet. I thought a bug would be a better place to
>>>>>> collect evemu-record logs and compare.
>>>>> fwiw, there's a fairly easy way to quickly check libinput for changes and
>>>>> that's by having the gtk3-headers installed at configure time and then
>>>>> running sudo ./tools/event-gui to visualize the movement (Esc quits)
>>>>>
>>>>> That tool uses libinput data directly to draw pointer motion etc, so it's a
>>>>> way to quickly bisect to where changes happen. Without anything else to go
>>>>> on, I'd say it's the new touchpad acceleration code from libinput 1.5 - the
>>>>> max accel factor has changed so depending on the speed of the jumps, you can
>>>>> now get stronger pointer movement.
>>>>>
>>>>> Cheers,
>>>>>       Peter
>>>> I have been looking into this on and off and I found a couple things, but
>>>> nothing conclusive yet. I think Peter is right that versions of libinput 1.5
>>>> and later do make the jump more pronounced. But, the new acceleration code
>>>> my simply be amplifying the jumps. I went ahead and filed a libinput bug
>>>> since the jumps are more significant in newer versions of libinput and I
>>>> attached some evemu-record logs.
>>>>
>>>> https://bugs.freedesktop.org/show_bug.cgi?id=100436
>>>>
>>>> I also spent time looking into the kernel drivers to see if they were
>>>> causing or contributing to the jumps. One of the things that I tried was
>>>> calling rmi_irq_fn() from a workqueue instead of calling
>>>> generic_handle_irq(). Originally, we were using a workqueue before interrupt
>>>> handling was added to the rmi core. I also tried moving the call to
>>>> generic_handle_irq() to a workqueue. In both cases the jumps seemed to
>>>> disappear or at least be reduced. I looked through the irq handling code and
>>>> I did not see anything which should cause an issue. The only difference
>>>> between irq thread and the workqueue that I could think of is that the irq
>>>> thread runs at a higher priority. But, I didn't really see much of a
>>>> difference between the timing of the events in the evemu-record logs.
>>> Despite libinput having issues has reported by Peter, I wonder if the
>>> priority of the IRQ thread isn't the one interfering with the data here.
>>> In the workqueue version, the processing of the events didn't interfere
>>> with the retrieval of the I2C values. But with the IRQ thread, we might
>>> be delaying the retrieval of the values, and we might not be reading the
>>> correct value at the right time (oversimplifying it, but I think you get
>>> the gist of it). The 2 IRQ threads from I2C to read the data and the
>>> other one from RMI4 might simply be interfering.
>>>
>>> I am sure you have something equivalent in your tree, but could you
>>> confirm that the following patch removes the jumps?
>> Yes, this patch does remove the jumps. My version just restored the old
>> functionality which was to call rmi_process_interrupts from a workqueue
>> inside hid-rmi. Your patch seems more complete.
>>
>> I did look to see if I could find something in the threaded IRQ code which
>> would confirm that there was some interference going on. But, I didn't find
>> anything. I also see jumps with USB devices and since USB devices do not use
>> threaded IRQs that did not seem to be the source. Looking at the call stack
>> in which rmi_input_event() gets called they seem quite different between USB
>> and I2C.
>>
>> I also tried calling generic_handle_irq() from a workqueue and that also
>> seemed to remove the jumps. That led me to look into if there were any side
>> affects from calling local_irq_save / restore or generic_handle_irq() from
>> inside the IRQ thread or IRQ handler. But, I could not find anything which
>> would indicate that doing this was unsafe.
>>
>> This is what I tried:
>> https://github.com/aduggan/linux/commit/d484e423e7375f1a6564f735f44a1246f6c0ee84
> Thanks. Your patch looks smaller than mine :)
>
> Jiri, Dmitry, which patch would you prefer having upstream?
>
> Andrew's patch is smaller but requires a workqueue in hid-rmi, which
> then reinject the IRQ in RMI4. Mine has the workqueue in RMI4 and
> ditches the IRQ in hid-rmi all together (so no need to call
> local_irq_save() anymore).
>
>>> ---
>>>
>>>   From b60c0b4f145e171e55ffd861a852a49f5104d59f Mon Sep 17 00:00:00 2001
>>> From: Benjamin Tissoires<benjamin.tissoires@redhat.com>
>>> Date: Wed, 29 Mar 2017 10:41:34 +0200
>>> Subject: [PATCH] Input: rmi4 - remove the need for artificial IRQ in case of
>>>    HID
>>>
>>> The IRQ from rmi4 may interfere with the one we currently use on i2c-hid.
>>> Given that there is already a need for an external API from rmi4 to
>>> forward the attention data, we can, in this particular case rely on a
>>> separate workqueue to prevent cursor jumps.
>>>
>>> Signed-off-by: Benjamin Tissoires<benjamin.tissoires@redhat.com>
>> Tested-by: Andrew Duggan <aduggan@synaptics.com>
> Great :)
>
> Just to be sure, does suspend/resume still works?

Suspend / resume work without any issues.

> And also, could you send to Peter a new evemu-record of the device
> without the jumps? (attaching it on the fdo bug should be sufficient I
> guess).

I attached one to the bug.

Andrew

> Cheers,
> Benjamin
>
>>> ---
>>>    drivers/hid/hid-rmi.c           |  64 ---------------------
>>>    drivers/input/rmi4/rmi_driver.c | 122 ++++++++++++++++++++++++----------------
>>>    include/linux/rmi.h             |   1 +
>>>    3 files changed, 75 insertions(+), 112 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
>>> index 5b40c26..4aa882c 100644
>>> --- a/drivers/hid/hid-rmi.c
>>> +++ b/drivers/hid/hid-rmi.c
>>> @@ -316,19 +316,12 @@ static int rmi_input_event(struct hid_device *hdev, u8 *data, int size)
>>>    {
>>>    	struct rmi_data *hdata = hid_get_drvdata(hdev);
>>>    	struct rmi_device *rmi_dev = hdata->xport.rmi_dev;
>>> -	unsigned long flags;
>>>    	if (!(test_bit(RMI_STARTED, &hdata->flags)))
>>>    		return 0;
>>> -	local_irq_save(flags);
>>> -
>>>    	rmi_set_attn_data(rmi_dev, data[1], &data[2], size - 2);
>>> -	generic_handle_irq(hdata->rmi_irq);
>>> -
>>> -	local_irq_restore(flags);
>>> -
>>>    	return 1;
>>>    }
>>> @@ -556,56 +549,6 @@ static const struct rmi_transport_ops hid_rmi_ops = {
>>>    	.reset		= rmi_hid_reset,
>>>    };
>>> -static void rmi_irq_teardown(void *data)
>>> -{
>>> -	struct rmi_data *hdata = data;
>>> -	struct irq_domain *domain = hdata->domain;
>>> -
>>> -	if (!domain)
>>> -		return;
>>> -
>>> -	irq_dispose_mapping(irq_find_mapping(domain, 0));
>>> -
>>> -	irq_domain_remove(domain);
>>> -	hdata->domain = NULL;
>>> -	hdata->rmi_irq = 0;
>>> -}
>>> -
>>> -static int rmi_irq_map(struct irq_domain *h, unsigned int virq,
>>> -		       irq_hw_number_t hw_irq_num)
>>> -{
>>> -	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -static const struct irq_domain_ops rmi_irq_ops = {
>>> -	.map = rmi_irq_map,
>>> -};
>>> -
>>> -static int rmi_setup_irq_domain(struct hid_device *hdev)
>>> -{
>>> -	struct rmi_data *hdata = hid_get_drvdata(hdev);
>>> -	int ret;
>>> -
>>> -	hdata->domain = irq_domain_create_linear(hdev->dev.fwnode, 1,
>>> -						 &rmi_irq_ops, hdata);
>>> -	if (!hdata->domain)
>>> -		return -ENOMEM;
>>> -
>>> -	ret = devm_add_action_or_reset(&hdev->dev, &rmi_irq_teardown, hdata);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>> -	hdata->rmi_irq = irq_create_mapping(hdata->domain, 0);
>>> -	if (hdata->rmi_irq <= 0) {
>>> -		hid_err(hdev, "Can't allocate an IRQ\n");
>>> -		return hdata->rmi_irq < 0 ? hdata->rmi_irq : -ENXIO;
>>> -	}
>>> -
>>> -	return 0;
>>> -}
>>> -
>>>    static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>>    {
>>>    	struct rmi_data *data = NULL;
>>> @@ -677,18 +620,11 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>>    	mutex_init(&data->page_mutex);
>>> -	ret = rmi_setup_irq_domain(hdev);
>>> -	if (ret) {
>>> -		hid_err(hdev, "failed to allocate IRQ domain\n");
>>> -		return ret;
>>> -	}
>>> -
>>>    	if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)
>>>    		rmi_hid_pdata.f30_data.disable = true;
>>>    	data->xport.dev = hdev->dev.parent;
>>>    	data->xport.pdata = rmi_hid_pdata;
>>> -	data->xport.pdata.irq = data->rmi_irq;
>>>    	data->xport.proto_name = "hid";
>>>    	data->xport.ops = &hid_rmi_ops;
>>> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
>>> index d64fc92..5e65cba 100644
>>> --- a/drivers/input/rmi4/rmi_driver.c
>>> +++ b/drivers/input/rmi4/rmi_driver.c
>>> @@ -209,32 +209,46 @@ void rmi_set_attn_data(struct rmi_device *rmi_dev, unsigned long irq_status,
>>>    	attn_data.data = fifo_data;
>>>    	kfifo_put(&drvdata->attn_fifo, attn_data);
>>> +
>>> +	schedule_work(&drvdata->attn_work);
>>>    }
>>>    EXPORT_SYMBOL_GPL(rmi_set_attn_data);
>>> -static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
>>> +static void attn_callback(struct work_struct *work)
>>>    {
>>> -	struct rmi_device *rmi_dev = dev_id;
>>> -	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
>>> +	struct rmi_driver_data *drvdata = container_of(work,
>>> +							struct rmi_driver_data,
>>> +							attn_work);
>>>    	struct rmi4_attn_data attn_data = {0};
>>>    	int ret, count;
>>>    	count = kfifo_get(&drvdata->attn_fifo, &attn_data);
>>> -	if (count) {
>>> -		*(drvdata->irq_status) = attn_data.irq_status;
>>> -		drvdata->attn_data = attn_data;
>>> -	}
>>> +	if (!count)
>>> +		return;
>>> -	ret = rmi_process_interrupt_requests(rmi_dev);
>>> +	*(drvdata->irq_status) = attn_data.irq_status;
>>> +	drvdata->attn_data = attn_data;
>>> +
>>> +	ret = rmi_process_interrupt_requests(drvdata->rmi_dev);
>>>    	if (ret)
>>> -		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
>>> +		rmi_dbg(RMI_DEBUG_CORE, &drvdata->rmi_dev->dev,
>>>    			"Failed to process interrupt request: %d\n", ret);
>>> -	if (count)
>>> -		kfree(attn_data.data);
>>> +	kfree(attn_data.data);
>>>    	if (!kfifo_is_empty(&drvdata->attn_fifo))
>>> -		return rmi_irq_fn(irq, dev_id);
>>> +		schedule_work(&drvdata->attn_work);
>>> +}
>>> +
>>> +static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
>>> +{
>>> +	struct rmi_device *rmi_dev = dev_id;
>>> +	int ret;
>>> +
>>> +	ret = rmi_process_interrupt_requests(rmi_dev);
>>> +	if (ret)
>>> +		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
>>> +			"Failed to process interrupt request: %d\n", ret);
>>>    	return IRQ_HANDLED;
>>>    }
>>> @@ -242,7 +256,6 @@ static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
>>>    static int rmi_irq_init(struct rmi_device *rmi_dev)
>>>    {
>>>    	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
>>> -	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>>>    	int irq_flags = irq_get_trigger_type(pdata->irq);
>>>    	int ret;
>>> @@ -260,8 +273,6 @@ static int rmi_irq_init(struct rmi_device *rmi_dev)
>>>    		return ret;
>>>    	}
>>> -	data->enabled = true;
>>> -
>>>    	return 0;
>>>    }
>>> @@ -910,23 +921,27 @@ void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake)
>>>    	if (data->enabled)
>>>    		goto out;
>>> -	enable_irq(irq);
>>> -	data->enabled = true;
>>> -	if (clear_wake && device_may_wakeup(rmi_dev->xport->dev)) {
>>> -		retval = disable_irq_wake(irq);
>>> -		if (retval)
>>> -			dev_warn(&rmi_dev->dev,
>>> -				 "Failed to disable irq for wake: %d\n",
>>> -				 retval);
>>> -	}
>>> +	if (irq) {
>>> +		enable_irq(irq);
>>> +		data->enabled = true;
>>> +		if (clear_wake && device_may_wakeup(rmi_dev->xport->dev)) {
>>> +			retval = disable_irq_wake(irq);
>>> +			if (retval)
>>> +				dev_warn(&rmi_dev->dev,
>>> +					 "Failed to disable irq for wake: %d\n",
>>> +					 retval);
>>> +		}
>>> -	/*
>>> -	 * Call rmi_process_interrupt_requests() after enabling irq,
>>> -	 * otherwise we may lose interrupt on edge-triggered systems.
>>> -	 */
>>> -	irq_flags = irq_get_trigger_type(pdata->irq);
>>> -	if (irq_flags & IRQ_TYPE_EDGE_BOTH)
>>> -		rmi_process_interrupt_requests(rmi_dev);
>>> +		/*
>>> +		 * Call rmi_process_interrupt_requests() after enabling irq,
>>> +		 * otherwise we may lose interrupt on edge-triggered systems.
>>> +		 */
>>> +		irq_flags = irq_get_trigger_type(pdata->irq);
>>> +		if (irq_flags & IRQ_TYPE_EDGE_BOTH)
>>> +			rmi_process_interrupt_requests(rmi_dev);
>>> +	} else {
>>> +		data->enabled = true;
>>> +	}
>>>    out:
>>>    	mutex_unlock(&data->enabled_mutex);
>>> @@ -946,20 +961,22 @@ void rmi_disable_irq(struct rmi_device *rmi_dev, bool enable_wake)
>>>    		goto out;
>>>    	data->enabled = false;
>>> -	disable_irq(irq);
>>> -	if (enable_wake && device_may_wakeup(rmi_dev->xport->dev)) {
>>> -		retval = enable_irq_wake(irq);
>>> -		if (retval)
>>> -			dev_warn(&rmi_dev->dev,
>>> -				 "Failed to enable irq for wake: %d\n",
>>> -				 retval);
>>> -	}
>>> -
>>> -	/* make sure the fifo is clean */
>>> -	while (!kfifo_is_empty(&data->attn_fifo)) {
>>> -		count = kfifo_get(&data->attn_fifo, &attn_data);
>>> -		if (count)
>>> -			kfree(attn_data.data);
>>> +	if (irq) {
>>> +		disable_irq(irq);
>>> +		if (enable_wake && device_may_wakeup(rmi_dev->xport->dev)) {
>>> +			retval = enable_irq_wake(irq);
>>> +			if (retval)
>>> +				dev_warn(&rmi_dev->dev,
>>> +					 "Failed to enable irq for wake: %d\n",
>>> +					 retval);
>>> +		}
>>> +	} else {
>>> +		/* make sure the fifo is clean */
>>> +		while (!kfifo_is_empty(&data->attn_fifo)) {
>>> +			count = kfifo_get(&data->attn_fifo, &attn_data);
>>> +			if (count)
>>> +				kfree(attn_data.data);
>>> +		}
>>>    	}
>>>    out:
>>> @@ -998,9 +1015,12 @@ EXPORT_SYMBOL_GPL(rmi_driver_resume);
>>>    static int rmi_driver_remove(struct device *dev)
>>>    {
>>>    	struct rmi_device *rmi_dev = to_rmi_device(dev);
>>> +	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>>>    	rmi_disable_irq(rmi_dev, false);
>>> +	cancel_work_sync(&data->attn_work);
>>> +
>>>    	rmi_f34_remove_sysfs(rmi_dev);
>>>    	rmi_free_function_list(rmi_dev);
>>> @@ -1230,9 +1250,15 @@ static int rmi_driver_probe(struct device *dev)
>>>    		}
>>>    	}
>>> -	retval = rmi_irq_init(rmi_dev);
>>> -	if (retval < 0)
>>> -		goto err_destroy_functions;
>>> +	if (pdata->irq) {
>>> +		retval = rmi_irq_init(rmi_dev);
>>> +		if (retval < 0)
>>> +			goto err_destroy_functions;
>>> +	}
>>> +
>>> +	data->enabled = true;
>>> +
>>> +	INIT_WORK(&data->attn_work, attn_callback);
>>>    	if (data->f01_container->dev.driver)
>>>    		/* Driver already bound, so enable ATTN now. */
>>> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
>>> index 64125443..dc90178 100644
>>> --- a/include/linux/rmi.h
>>> +++ b/include/linux/rmi.h
>>> @@ -364,6 +364,7 @@ struct rmi_driver_data {
>>>    	struct rmi4_attn_data attn_data;
>>>    	DECLARE_KFIFO(attn_fifo, struct rmi4_attn_data, 16);
>>> +	struct work_struct attn_work;
>>>    };
>>>    int rmi_register_transport_device(struct rmi_transport_dev *xport);
>>> -- 2.9.3 I only tested this on a prototype attached to a cp2112 USB to
>>> I2C, so I haven't tested suspend/resume and can't check on the jumps
>>> here.
>>>> At this point I am still not sure if the issue is that the events are being
>>>> reported incorrectly by the kernel or if the new touchpad acceleration code
>>>> in libinput is just not handling the events correctly. I would appreciate
>>>> any suggestions. I'm not sure how much time we have left before we need to
>>>> decide if we need to go back to hid-multitouch or not.
>>> If we can get the confirmation that removing the IRQ handling from
>>> hid-rmi solves the issue, it would be a matter of submitting this patch
>>> to upstream. I also wonder if currently non PTP touchpads are affected
>>> by the jumps or not. If not, I'd say it's safer to delay the HID
>>> catchall for v4.12, if they are, then we should probably make sure this
>>> patch (or any fix) gets into v4.11.
>> Yes, I was able to reproduce the jumps on non PTP touchpads so all touchpads
>> seem to be affected by this.
>>
>> Andrew
>>
>>> Cheers,
>>> Benjamin
>>>
>>>> Thanks,
>>>> Andrew
>>>>
>>>>>> Hopefully, this will end up being a quick fix in the kernel and we can get
>>>>>> it applied to 4.11 without having to hold off on disabling hid-rmi for PTPs.
>>>>>>
>>>>>> Andrew
>>>>>>
>>>>>>> Cheers,
>>>>>>> Benjamin
>>>>>>>
>>>>>>>>>>>>> Just to confirm: I noticed "jumpiness during fine pointing motions" as
>>>>>>>>>>>>> well since switching to 4.11-rc.
>>>>>>>>>> One of my test systems is a XPS 13 9343 and I have not really seen any
>>>>>>>>>> jumpiness. But, based on the data I am seeing that if I lift my finger and
>>>>>>>>>> place it again in a short period of time the first event or so will be at
>>>>>>>>>> the location of the previous contact. Then it will switch over to the
>>>>>>>>>> current location. When switching over to hid-multitouch I was unable to
>>>>>>>>>> reproduce this behavior. This definitely could be the source of the jumps.
>>>>>>>>>>
>>>>>>>>> The jumpiness definitely happens without lifting my finger, but I'm
>>>>>>>>> willing
>>>>>>>>> to test any patch you think would improve the situation. Moving one finger
>>>>>>>>> slowly in a figure-8 across my touchpad shows the issue clearly for me.
>>>>>>>>> The
>>>>>>>>> small variations in speed of my finger due to the friction on the trackpad
>>>>>>>>> get magnified to relatively large jumpy pointer movements on screen. It
>>>>>>>>> seems much more noticeable in diagonal movements than completely vertical
>>>>>>>>> or horizontal movements.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Cameron
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> diff --git a/drivers/input/rmi4/rmi_f34v7.c
>>>>>>>>> b/drivers/input/rmi4/rmi_f34v7.c
>>>>>>>>> index 56c6c39..1291d9a 100644
>>>>>>>>> --- a/drivers/input/rmi4/rmi_f34v7.c
>>>>>>>>> +++ b/drivers/input/rmi4/rmi_f34v7.c
>>>>>>>>> @@ -1369,9 +1369,9 @@ int rmi_f34v7_probe(struct f34_data *f34)
>>>>>>>>>             } else if (f34->bootloader_id[1] == 7) {
>>>>>>>>>                     f34->bl_version = 7;
>>>>>>>>>             } else {
>>>>>>>>> -               dev_err(&f34->fn->dev, "%s: Unrecognized bootloader
>>>>>>>>> version\n",
>>>>>>>>> -                               __func__);
>>>>>>>>> -               return -EINVAL;
>>>>>>>>> +               dev_info(&f34->fn->dev, "%s: Unsupported bootloader
>>>>>>>>> version: %u\n",
>>>>>>>>> +                               __func__, f34->bootloader_id[1]);
>>>>>>>>> +               return -ENODEV;
>>>>>>>>>             }
>>>>>>>>>             memset(&f34->v7.blkcount, 0x00, sizeof(f34->v7.blkcount));


