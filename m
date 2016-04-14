From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] HID: rmi: Make hid-rmi a transport driver for
 synaptics-rmi4
Date: Wed, 13 Apr 2016 17:14:14 -0700
Message-ID: <570EE0D6.6030008@synaptics.com>
References: <1458605537-19462-1-git-send-email-aduggan@synaptics.com>
 <20160412142525.GA21012@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:33959 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752108AbcDNAOV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2016 20:14:21 -0400
In-Reply-To: <20160412142525.GA21012@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>

Hi Benjamin,

On 04/12/2016 07:25 AM, Benjamin Tissoires wrote:
> On Mar 21 2016 or thereabouts, Andrew Duggan wrote:
>> The Synaptics RMI4 driver provides support for RMI4 devices. Instead of
>> duplicating the RMI4 processing code, make hid-rmi a transport driver
>> and register it with the Synaptics RMI4 core.
>>
>> Signed-off-by: Andrew Duggan<aduggan@synaptics.com>
>> ---
>> This is the patch which was originally submitted as part of the Synaptics
>> RMI4 patch series which converts hid-rmi into a transport driver. Now
>> that the core has been accepting I am resubmitting.
>>
>> The most significant change in this version of the patch is that
>> rmi_process_interrupt_requests() is now being called from a workqueue.
>> I noticed that HID/USB devices call hid_input_report() from irq context
>> or softirq context. However, rmi_process_interrupt_requests() calls
>> functions which may sleep. For instance the irq masks are protected by
>> a mutex which is acquired when processing interrupts. It is also possible
>> that some HID device may need to read additional registers when processing
>> interrupts which is another example of a call which could sleep. Calling
>> rmi_process_interrupt_requests() from a workqueue seemed like the best
>> way to guarenttee that rmi_process_interrupt_requests() isn't being
>> called in interrupt context.
> Hi Andrew,
>
> Thanks for the re-submission, and sorry for the delay.
>
> I noticed a little bikeshedding down below, but I also noticed some
> features that are currently in hid-rmi which, if I am not wrong, will be
> suppressed by the rmi4_core switch:
>
> - 5b65c2a HID: rmi: check sanity of the incoming report
> Not so sure if we need this or not. The Haswell Dell XPS 15 laptop
> used to send messed up reports and replace part of it by 'ff'.
> rmi_raw_event() checks for the sanity, but will F11 and F30 be OK in the
> core if such reports are forwarded?

I forgot that this fix was more then just adding the check sanity 
function. F11 and F30 will probably not handle those reports correctly. 
I'll look into that.

> - 05ba999 HID: rmi: disable dribble packets on Synaptics touchpads
> RMI4 core checks for it, but we do not unset it from hid-rmi after the
> change. I think we should export a parameter in the platform_data for
> 2d_sensors, and we should be good.

It is being unset in rmi_f11 on line 1196. Only touchpads use dribble 
packets so I just disabled it for every device that has them. However, 
I've been thinking we might want to enable dribble packets on certain 
devices. Like the ones where the finger lift event is being missed. I'll 
add a parameter like you suggest.

> - f097dee HID: rmi: disable palm detect gesture when present
> Looks like this one is the same

I'm also disabling this for all devices in rmi_f11. But, I should also 
add a parameter here since I'm not 100% sure that this is only used by 
touchpads.

> - 10e87dc HID: rmi: Disable populating F30 when the touchpad has
>    physical buttons
> I think this will need some change in the pdata of f30 to explicitly
> not instanciate it.

There is already a disable bool in rmi_f30_data and rmi_f30_probe will 
return 0 immediately if it is set. Also, hid-rmi is setting the disable 
if the RMI_DEVICE_HAS_PHYS_BUTTONS is set. So I think we are already 
doing what you suggest.

> I think we will all agree that removing more than 700 lines of code is a
> good thing to do. Regarding the rmi_process_interrupt_requests() from a
> workqueue, does it introduce any packet loss? Or do we need to have a
> fifo of incoming events so we do not occasionally lose events when we
> are required to do some sleeping functions?

Currently, I don't think lost packets will be an issue. The mutex which 
rmi_process_interrupt_requests() attempts to acquire is only acquired 
from the function drivers config functions (When they call 
clear_irq_bits and set_irq_bits). So it would only happened during start 
or resume. I figured a missed event at that time wouldn't have much impact.

However, if we add support for devices which do need to read data which 
is not in the attention report we would need a fifo since 
rmi_process_interrupt_requests() would be doing a lot more sleeping. I 
can add a fifo now to make sure or I can wait and add it if we do end up 
adding support for such a device.

For background, an example of a device which would need to sleep would 
be HID touchscreens. If we wanted to support them with the RMI4 driver 
we need to issue read requests in rmi_process_interrupt_requests(). The 
touchscreen firmware  doesn't currently support attentions reports with 
the finger data appended to them like our touchpads do. Instead all you 
get is the interrupt status and have to issue read commands to read the 
function data registers. But, since these devices work fine with 
hid-multitouch right now we might never need or want to do this. That's 
what I had in mind when I picked a workqueue instead of switching the 
irq lock to something like a semaphore.

> Now for my bikeshedding:
>
>>   drivers/hid/Kconfig   |   2 +-
>>   drivers/hid/hid-rmi.c | 895 +++++---------------------------------------------
>>   2 files changed, 89 insertions(+), 808 deletions(-)
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 513a16c..9cba717 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -740,7 +740,7 @@ config HID_SUNPLUS
>>   
>>   config HID_RMI
>>   	tristate "Synaptics RMI4 device support"
>> -	depends on HID
>> +	depends on HID && RMI4_CORE
>>   	---help---
>>   	Support for Synaptics RMI4 touchpads.
>>   	Say Y here if you have a Synaptics RMI4 touchpads over i2c-hid or usbhid
>> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
>> index 9cd2ca3..c80e7c7 100644
>> --- a/drivers/hid/hid-rmi.c
>> +++ b/drivers/hid/hid-rmi.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/wait.h>
>>   #include <linux/sched.h>
>> +#include <linux/rmi.h>
>>   #include "hid-ids.h"
>>   
>>   #define RMI_MOUSE_REPORT_ID		0x01 /* Mouse emulation Report */
>> @@ -32,9 +33,7 @@
>>   #define RMI_READ_REQUEST_PENDING	0
>>   #define RMI_READ_DATA_PENDING		1
>>   #define RMI_STARTED			2
>> -
>> -#define RMI_SLEEP_NORMAL		0x0
>> -#define RMI_SLEEP_DEEP_SLEEP		0x1
>> +#define RMI_PROCESS_ATTN_PENDING	3
>>   
>>   /* device flags */
>>   #define RMI_DEVICE			BIT(0)
>> @@ -54,20 +53,6 @@ enum rmi_mode_type {
>>   	RMI_MODE_NO_PACKED_ATTN_REPORTS	= 2,
>>   };
>>   
>> -struct rmi_function {
>> -	unsigned page;			/* page of the function */
>> -	u16 query_base_addr;		/* base address for queries */
>> -	u16 command_base_addr;		/* base address for commands */
>> -	u16 control_base_addr;		/* base address for controls */
>> -	u16 data_base_addr;		/* base address for datas */
>> -	unsigned int interrupt_base;	/* cross-function interrupt number
>> -					 * (uniq in the device)*/
>> -	unsigned int interrupt_count;	/* number of interrupts */
>> -	unsigned int report_size;	/* size of a report */
>> -	unsigned long irq_mask;		/* mask of the interrupts
>> -					 * (to be applied against ATTN IRQ) */
>> -};
>> -
>>   /**
>>    * struct rmi_data - stores information for hid communication
>>    *
>> @@ -104,6 +89,7 @@ struct rmi_function {
>>   struct rmi_data {
>>   	struct mutex page_mutex;
>>   	int page;
>> +	struct rmi_transport_dev xport;
>>   
>>   	wait_queue_head_t wait;
>>   
>> @@ -115,34 +101,11 @@ struct rmi_data {
>>   
>>   	unsigned long flags;
>>   
>> -	struct rmi_function f01;
>> -	struct rmi_function f11;
>> -	struct rmi_function f30;
>> -
>> -	unsigned int max_fingers;
>> -	unsigned int max_x;
>> -	unsigned int max_y;
>> -	unsigned int x_size_mm;
>> -	unsigned int y_size_mm;
>> -	bool read_f11_ctrl_regs;
>> -	u8 f11_ctrl_regs[RMI_F11_CTRL_REG_COUNT];
>> -
>> -	unsigned int gpio_led_count;
>> -	unsigned int button_count;
>> -	unsigned long button_mask;
>> -	unsigned long button_state_mask;
>> -
>> -	struct input_dev *input;
>> -
>>   	struct work_struct reset_work;
>> +	struct work_struct attn_work;
>>   	struct hid_device *hdev;
>>   
>>   	unsigned long device_flags;
>> -	unsigned long firmware_id;
>> -
>> -	u8 f01_ctrl0;
>> -	u8 interrupt_enable_mask;
>> -	bool restore_interrupt_mask;
>>   };
>>   
>>   #define RMI_PAGE(addr) (((addr) >> 8) & 0xff)
>> @@ -214,10 +177,11 @@ static int rmi_write_report(struct hid_device *hdev, u8 *report, int len)
>>   	return ret;
>>   }
>>   
>> -static int rmi_read_block(struct hid_device *hdev, u16 addr, void *buf,
>> -		const int len)
>> +static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
>> +		void *buf, size_t len)
>>   {
>> -	struct rmi_data *data = hid_get_drvdata(hdev);
>> +	struct rmi_data *data = container_of(xport, struct rmi_data, xport);
>> +	struct hid_device *hdev = data->hdev;
>>   	int ret;
>>   	int bytes_read;
>>   	int bytes_needed;
>> @@ -286,15 +250,11 @@ exit:
>>   	return ret;
>>   }
>>   
>> -static inline int rmi_read(struct hid_device *hdev, u16 addr, void *buf)
>> +static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
>> +		const void *buf, size_t len)
>>   {
>> -	return rmi_read_block(hdev, addr, buf, 1);
>> -}
>> -
>> -static int rmi_write_block(struct hid_device *hdev, u16 addr, void *buf,
>> -		const int len)
>> -{
>> -	struct rmi_data *data = hid_get_drvdata(hdev);
>> +	struct rmi_data *data = container_of(xport, struct rmi_data, xport);
>> +	struct hid_device *hdev = data->hdev;
>>   	int ret;
>>   
>>   	mutex_lock(&data->page_mutex);
>> @@ -326,62 +286,20 @@ exit:
>>   	return ret;
>>   }
>>   
>> -static inline int rmi_write(struct hid_device *hdev, u16 addr, void *buf)
>> -{
>> -	return rmi_write_block(hdev, addr, buf, 1);
>> -}
>> -
>> -static void rmi_f11_process_touch(struct rmi_data *hdata, int slot,
>> -		u8 finger_state, u8 *touch_data)
>> -{
>> -	int x, y, wx, wy;
>> -	int wide, major, minor;
>> -	int z;
>> -
>> -	input_mt_slot(hdata->input, slot);
>> -	input_mt_report_slot_state(hdata->input, MT_TOOL_FINGER,
>> -			finger_state == 0x01);
>> -	if (finger_state == 0x01) {
>> -		x = (touch_data[0] << 4) | (touch_data[2] & 0x0F);
>> -		y = (touch_data[1] << 4) | (touch_data[2] >> 4);
>> -		wx = touch_data[3] & 0x0F;
>> -		wy = touch_data[3] >> 4;
>> -		wide = (wx > wy);
>> -		major = max(wx, wy);
>> -		minor = min(wx, wy);
>> -		z = touch_data[4];
>> -
>> -		/* y is inverted */
>> -		y = hdata->max_y - y;
>> -
>> -		input_event(hdata->input, EV_ABS, ABS_MT_POSITION_X, x);
>> -		input_event(hdata->input, EV_ABS, ABS_MT_POSITION_Y, y);
>> -		input_event(hdata->input, EV_ABS, ABS_MT_ORIENTATION, wide);
>> -		input_event(hdata->input, EV_ABS, ABS_MT_PRESSURE, z);
>> -		input_event(hdata->input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
>> -		input_event(hdata->input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
>> -	}
>> -}
>> -
>>   static int rmi_reset_attn_mode(struct hid_device *hdev)
>>   {
>>   	struct rmi_data *data = hid_get_drvdata(hdev);
>> +	struct rmi_device *rmi_dev = data->xport.rmi_dev;
>>   	int ret;
>>   
>>   	ret = rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (data->restore_interrupt_mask) {
>> -		ret = rmi_write(hdev, data->f01.control_base_addr + 1,
>> -				&data->interrupt_enable_mask);
>> -		if (ret) {
>> -			hid_err(hdev, "can not write F01 control register\n");
>> -			return ret;
>> -		}
>> -	}
>> +	if (test_bit(RMI_STARTED, &data->flags))
>> +		ret = rmi_dev->driver->reset_handler(rmi_dev);
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static void rmi_reset_work(struct work_struct *work)
>> @@ -399,96 +317,34 @@ static inline int rmi_schedule_reset(struct hid_device *hdev)
>>   	return schedule_work(&hdata->reset_work);
>>   }
> rmi_schedule_reset() is now ()was it ever ued more?) used only once, so
> how about we just kill the helper and directly schedule the work from
> rmi_event()?

I'm not sure it was ever called more then once. I'll call schedule directly.

Andrew

>>   
>> -static int rmi_f11_input_event(struct hid_device *hdev, u8 irq, u8 *data,
>> -		int size)
>> -{
>> -	struct rmi_data *hdata = hid_get_drvdata(hdev);
>> -	int offset;
>> -	int i;
>> -
>> -	if (!(irq & hdata->f11.irq_mask) || size <= 0)
>> -		return 0;
>> -
>> -	offset = (hdata->max_fingers >> 2) + 1;
>> -	for (i = 0; i < hdata->max_fingers; i++) {
>> -		int fs_byte_position = i >> 2;
>> -		int fs_bit_position = (i & 0x3) << 1;
>> -		int finger_state = (data[fs_byte_position] >> fs_bit_position) &
>> -					0x03;
>> -		int position = offset + 5 * i;
>> -
>> -		if (position + 5 > size) {
>> -			/* partial report, go on with what we received */
>> -			printk_once(KERN_WARNING
>> -				"%s %s: Detected incomplete finger report. Finger reports may occasionally get dropped on this platform.\n",
>> -				 dev_driver_string(&hdev->dev),
>> -				 dev_name(&hdev->dev));
>> -			hid_dbg(hdev, "Incomplete finger report\n");
>> -			break;
>> -		}
>> -
>> -		rmi_f11_process_touch(hdata, i, finger_state, &data[position]);
>> -	}
>> -	input_mt_sync_frame(hdata->input);
>> -	input_sync(hdata->input);
>> -	return hdata->f11.report_size;
>> -}
>> -
>> -static int rmi_f30_input_event(struct hid_device *hdev, u8 irq, u8 *data,
>> -		int size)
>> +static void rmi_attn_work(struct work_struct *work)
>>   {
>> -	struct rmi_data *hdata = hid_get_drvdata(hdev);
>> -	int i;
>> -	int button = 0;
>> -	bool value;
>> -
>> -	if (!(irq & hdata->f30.irq_mask))
>> -		return 0;
>> +	 struct rmi_data *hdata = container_of(work, struct rmi_data,
>> +						attn_work);
>> +	 struct rmi_device *rmi_dev = hdata->xport.rmi_dev;
>>   
>> -	if (size < (int)hdata->f30.report_size) {
>> -		hid_warn(hdev, "Click Button pressed, but the click data is missing\n");
>> -		return 0;
>> -	}
>> +	 rmi_process_interrupt_requests(rmi_dev);
>>   
>> -	for (i = 0; i < hdata->gpio_led_count; i++) {
>> -		if (test_bit(i, &hdata->button_mask)) {
>> -			value = (data[i / 8] >> (i & 0x07)) & BIT(0);
>> -			if (test_bit(i, &hdata->button_state_mask))
>> -				value = !value;
>> -			input_event(hdata->input, EV_KEY, BTN_LEFT + button++,
>> -					value);
>> -		}
>> -	}
>> -	return hdata->f30.report_size;
>> +	 clear_bit(RMI_PROCESS_ATTN_PENDING, &hdata->flags);
>>   }
>>   
>>   static int rmi_input_event(struct hid_device *hdev, u8 *data, int size)
>>   {
>>   	struct rmi_data *hdata = hid_get_drvdata(hdev);
>> -	unsigned long irq_mask = 0;
>> -	unsigned index = 2;
>> +	struct rmi_device *rmi_dev = hdata->xport.rmi_dev;
>> +	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
>>   
>>   	if (!(test_bit(RMI_STARTED, &hdata->flags)))
>>   		return 0;
>>   
>> -	irq_mask |= hdata->f11.irq_mask;
>> -	irq_mask |= hdata->f30.irq_mask;
>> -
>> -	if (data[1] & ~irq_mask)
>> -		hid_dbg(hdev, "unknown intr source:%02lx %s:%d\n",
>> -			data[1] & ~irq_mask, __FILE__, __LINE__);
>> -
>> -	if (hdata->f11.interrupt_base < hdata->f30.interrupt_base) {
>> -		index += rmi_f11_input_event(hdev, data[1], &data[index],
>> -				size - index);
>> -		index += rmi_f30_input_event(hdev, data[1], &data[index],
>> -				size - index);
>> -	} else {
>> -		index += rmi_f30_input_event(hdev, data[1], &data[index],
>> -				size - index);
>> -		index += rmi_f11_input_event(hdev, data[1], &data[index],
>> -				size - index);
>> -	}
>> +	if (test_and_set_bit(RMI_PROCESS_ATTN_PENDING, &hdata->flags))
>> +		return 1;
>> +
>> +	*(drvdata->irq_status) = data[1];
>> +	hdata->xport.attn_data = &data[2];
>> +	hdata->xport.attn_size = hdata->input_report_size - 2;
>> +
>> +	schedule_work(&hdata->attn_work);
>>   
>>   	return 1;
>>   }
>> @@ -570,637 +426,71 @@ static int rmi_event(struct hid_device *hdev, struct hid_field *field,
>>   }
>>   
>>   #ifdef CONFIG_PM
>> -static int rmi_set_sleep_mode(struct hid_device *hdev, int sleep_mode)
>> -{
>> -	struct rmi_data *data = hid_get_drvdata(hdev);
>> -	int ret;
>> -	u8 f01_ctrl0;
>> -
>> -	f01_ctrl0 = (data->f01_ctrl0 & ~0x3) | sleep_mode;
>> -
>> -	ret = rmi_write(hdev, data->f01.control_base_addr,
>> -			&f01_ctrl0);
>> -	if (ret) {
>> -		hid_err(hdev, "can not write sleep mode\n");
>> -		return ret;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>   static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
>>   {
>>   	struct rmi_data *data = hid_get_drvdata(hdev);
>> -	int ret;
>> -	u8 buf[RMI_F11_CTRL_REG_COUNT];
>> -
>> -	if (!(data->device_flags & RMI_DEVICE))
>> -		return 0;
>> -
>> -	ret = rmi_read_block(hdev, data->f11.control_base_addr, buf,
>> -				RMI_F11_CTRL_REG_COUNT);
>> -	if (ret)
>> -		hid_warn(hdev, "can not read F11 control registers\n");
>> -	else
>> -		memcpy(data->f11_ctrl_regs, buf, RMI_F11_CTRL_REG_COUNT);
>> -
>> -
>> -	if (!device_may_wakeup(hdev->dev.parent))
>> -		return rmi_set_sleep_mode(hdev, RMI_SLEEP_DEEP_SLEEP);
>> -
>> -	return 0;
>> -}
>> -
>> -static int rmi_post_reset(struct hid_device *hdev)
>> -{
>> -	struct rmi_data *data = hid_get_drvdata(hdev);
>> +	struct rmi_device *rmi_dev = data->xport.rmi_dev;
>>   	int ret;
>>   
>>   	if (!(data->device_flags & RMI_DEVICE))
>>   		return 0;
>>   
>> -	ret = rmi_reset_attn_mode(hdev);
>> +	ret = rmi_driver_suspend(rmi_dev);
>>   	if (ret) {
>> -		hid_err(hdev, "can not set rmi mode\n");
>> +		hid_warn(hdev, "Failed to suspend device: %d\n", ret);
>>   		return ret;
>>   	}
>>   
>> -	if (data->read_f11_ctrl_regs) {
>> -		ret = rmi_write_block(hdev, data->f11.control_base_addr,
>> -				data->f11_ctrl_regs, RMI_F11_CTRL_REG_COUNT);
>> -		if (ret)
>> -			hid_warn(hdev,
>> -				"can not write F11 control registers after reset\n");
>> -	}
>> -
>> -	if (!device_may_wakeup(hdev->dev.parent)) {
>> -		ret = rmi_set_sleep_mode(hdev, RMI_SLEEP_NORMAL);
>> -		if (ret) {
>> -			hid_err(hdev, "can not write sleep mode\n");
>> -			return ret;
>> -		}
>> -	}
>> -
>> -	return ret;
>> +	return 0;
>>   }
>>   
>>   static int rmi_post_resume(struct hid_device *hdev)
>>   {
>>   	struct rmi_data *data = hid_get_drvdata(hdev);
>> +	struct rmi_device *rmi_dev = data->xport.rmi_dev;
>> +	int ret;
>>   
>>   	if (!(data->device_flags & RMI_DEVICE))
>>   		return 0;
>>   
>> -	return rmi_reset_attn_mode(hdev);
>> -}
>> -#endif /* CONFIG_PM */
>> -
>> -#define RMI4_MAX_PAGE 0xff
>> -#define RMI4_PAGE_SIZE 0x0100
>> -
>> -#define PDT_START_SCAN_LOCATION 0x00e9
>> -#define PDT_END_SCAN_LOCATION	0x0005
>> -#define RMI4_END_OF_PDT(id) ((id) == 0x00 || (id) == 0xff)
>> -
>> -struct pdt_entry {
>> -	u8 query_base_addr:8;
>> -	u8 command_base_addr:8;
>> -	u8 control_base_addr:8;
>> -	u8 data_base_addr:8;
>> -	u8 interrupt_source_count:3;
>> -	u8 bits3and4:2;
>> -	u8 function_version:2;
>> -	u8 bit7:1;
>> -	u8 function_number:8;
>> -} __attribute__((__packed__));
>> -
>> -static inline unsigned long rmi_gen_mask(unsigned irq_base, unsigned irq_count)
>> -{
>> -	return GENMASK(irq_count + irq_base - 1, irq_base);
>> -}
>> -
>> -static void rmi_register_function(struct rmi_data *data,
>> -	struct pdt_entry *pdt_entry, int page, unsigned interrupt_count)
>> -{
>> -	struct rmi_function *f = NULL;
>> -	u16 page_base = page << 8;
>> -
>> -	switch (pdt_entry->function_number) {
>> -	case 0x01:
>> -		f = &data->f01;
>> -		break;
>> -	case 0x11:
>> -		f = &data->f11;
>> -		break;
>> -	case 0x30:
>> -		f = &data->f30;
>> -		break;
>> -	}
>> -
>> -	if (f) {
>> -		f->page = page;
>> -		f->query_base_addr = page_base | pdt_entry->query_base_addr;
>> -		f->command_base_addr = page_base | pdt_entry->command_base_addr;
>> -		f->control_base_addr = page_base | pdt_entry->control_base_addr;
>> -		f->data_base_addr = page_base | pdt_entry->data_base_addr;
>> -		f->interrupt_base = interrupt_count;
>> -		f->interrupt_count = pdt_entry->interrupt_source_count;
>> -		f->irq_mask = rmi_gen_mask(f->interrupt_base,
>> -						f->interrupt_count);
>> -		data->interrupt_enable_mask |= f->irq_mask;
>> -	}
>> -}
>> -
>> -static int rmi_scan_pdt(struct hid_device *hdev)
>> -{
>> -	struct rmi_data *data = hid_get_drvdata(hdev);
>> -	struct pdt_entry entry;
>> -	int page;
>> -	bool page_has_function;
>> -	int i;
>> -	int retval;
>> -	int interrupt = 0;
>> -	u16 page_start, pdt_start , pdt_end;
>> -
>> -	hid_info(hdev, "Scanning PDT...\n");
>> -
>> -	for (page = 0; (page <= RMI4_MAX_PAGE); page++) {
>> -		page_start = RMI4_PAGE_SIZE * page;
>> -		pdt_start = page_start + PDT_START_SCAN_LOCATION;
>> -		pdt_end = page_start + PDT_END_SCAN_LOCATION;
>> -
>> -		page_has_function = false;
>> -		for (i = pdt_start; i >= pdt_end; i -= sizeof(entry)) {
>> -			retval = rmi_read_block(hdev, i, &entry, sizeof(entry));
>> -			if (retval) {
>> -				hid_err(hdev,
>> -					"Read of PDT entry at %#06x failed.\n",
>> -					i);
>> -				goto error_exit;
>> -			}
>> -
>> -			if (RMI4_END_OF_PDT(entry.function_number))
>> -				break;
>> -
>> -			page_has_function = true;
>> -
>> -			hid_info(hdev, "Found F%02X on page %#04x\n",
>> -					entry.function_number, page);
>> -
>> -			rmi_register_function(data, &entry, page, interrupt);
>> -			interrupt += entry.interrupt_source_count;
>> -		}
>> -
>> -		if (!page_has_function)
>> -			break;
>> -	}
>> -
>> -	hid_info(hdev, "%s: Done with PDT scan.\n", __func__);
>> -	retval = 0;
>> -
>> -error_exit:
>> -	return retval;
>> -}
>> -
>> -#define RMI_DEVICE_F01_BASIC_QUERY_LEN	11
>> -
>> -static int rmi_populate_f01(struct hid_device *hdev)
>> -{
>> -	struct rmi_data *data = hid_get_drvdata(hdev);
>> -	u8 basic_queries[RMI_DEVICE_F01_BASIC_QUERY_LEN];
>> -	u8 info[3];
>> -	int ret;
>> -	bool has_query42;
>> -	bool has_lts;
>> -	bool has_sensor_id;
>> -	bool has_ds4_queries = false;
>> -	bool has_build_id_query = false;
>> -	bool has_package_id_query = false;
>> -	u16 query_offset = data->f01.query_base_addr;
>> -	u16 prod_info_addr;
>> -	u8 ds4_query_len;
>> -
>> -	ret = rmi_read_block(hdev, query_offset, basic_queries,
>> -				RMI_DEVICE_F01_BASIC_QUERY_LEN);
>> -	if (ret) {
>> -		hid_err(hdev, "Can not read basic queries from Function 0x1.\n");
>> -		return ret;
>> -	}
>> -
>> -	has_lts = !!(basic_queries[0] & BIT(2));
>> -	has_sensor_id = !!(basic_queries[1] & BIT(3));
>> -	has_query42 = !!(basic_queries[1] & BIT(7));
>> -
>> -	query_offset += 11;
>> -	prod_info_addr = query_offset + 6;
>> -	query_offset += 10;
>> -
>> -	if (has_lts)
>> -		query_offset += 20;
>> -
>> -	if (has_sensor_id)
>> -		query_offset++;
>> -
>> -	if (has_query42) {
>> -		ret = rmi_read(hdev, query_offset, info);
>> -		if (ret) {
>> -			hid_err(hdev, "Can not read query42.\n");
>> -			return ret;
>> -		}
>> -		has_ds4_queries = !!(info[0] & BIT(0));
>> -		query_offset++;
>> -	}
>> -
>> -	if (has_ds4_queries) {
>> -		ret = rmi_read(hdev, query_offset, &ds4_query_len);
>> -		if (ret) {
>> -			hid_err(hdev, "Can not read DS4 Query length.\n");
>> -			return ret;
>> -		}
>> -		query_offset++;
>> -
>> -		if (ds4_query_len > 0) {
>> -			ret = rmi_read(hdev, query_offset, info);
>> -			if (ret) {
>> -				hid_err(hdev, "Can not read DS4 query.\n");
>> -				return ret;
>> -			}
>> -
>> -			has_package_id_query = !!(info[0] & BIT(0));
>> -			has_build_id_query = !!(info[0] & BIT(1));
>> -		}
>> -	}
>> -
>> -	if (has_package_id_query)
>> -		prod_info_addr++;
>> -
>> -	if (has_build_id_query) {
>> -		ret = rmi_read_block(hdev, prod_info_addr, info, 3);
>> -		if (ret) {
>> -			hid_err(hdev, "Can not read product info.\n");
>> -			return ret;
>> -		}
>> -
>> -		data->firmware_id = info[1] << 8 | info[0];
>> -		data->firmware_id += info[2] * 65536;
>> -	}
>> -
>> -	ret = rmi_read_block(hdev, data->f01.control_base_addr, info,
>> -				2);
>> -
>> -	if (ret) {
>> -		hid_err(hdev, "can not read f01 ctrl registers\n");
>> -		return ret;
>> -	}
>> -
>> -	data->f01_ctrl0 = info[0];
>> -
>> -	if (!info[1]) {
>> -		/*
>> -		 * Do to a firmware bug in some touchpads the F01 interrupt
>> -		 * enable control register will be cleared on reset.
>> -		 * This will stop the touchpad from reporting data, so
>> -		 * if F01 CTRL1 is 0 then we need to explicitly enable
>> -		 * interrupts for the functions we want data for.
>> -		 */
>> -		data->restore_interrupt_mask = true;
>> -
>> -		ret = rmi_write(hdev, data->f01.control_base_addr + 1,
>> -				&data->interrupt_enable_mask);
>> -		if (ret) {
>> -			hid_err(hdev, "can not write to control reg 1: %d.\n",
>> -				ret);
>> -			return ret;
>> -		}
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>> -static int rmi_populate_f11(struct hid_device *hdev)
>> -{
>> -	struct rmi_data *data = hid_get_drvdata(hdev);
>> -	u8 buf[20];
>> -	int ret;
>> -	bool has_query9;
>> -	bool has_query10 = false;
>> -	bool has_query11;
>> -	bool has_query12;
>> -	bool has_query27;
>> -	bool has_query28;
>> -	bool has_query36 = false;
>> -	bool has_physical_props;
>> -	bool has_gestures;
>> -	bool has_rel;
>> -	bool has_data40 = false;
>> -	bool has_dribble = false;
>> -	bool has_palm_detect = false;
>> -	unsigned x_size, y_size;
>> -	u16 query_offset;
>> -
>> -	if (!data->f11.query_base_addr) {
>> -		hid_err(hdev, "No 2D sensor found, giving up.\n");
>> -		return -ENODEV;
>> -	}
>> -
>> -	/* query 0 contains some useful information */
>> -	ret = rmi_read(hdev, data->f11.query_base_addr, buf);
>> -	if (ret) {
>> -		hid_err(hdev, "can not get query 0: %d.\n", ret);
>> -		return ret;
>> -	}
>> -	has_query9 = !!(buf[0] & BIT(3));
>> -	has_query11 = !!(buf[0] & BIT(4));
>> -	has_query12 = !!(buf[0] & BIT(5));
>> -	has_query27 = !!(buf[0] & BIT(6));
>> -	has_query28 = !!(buf[0] & BIT(7));
>> -
>> -	/* query 1 to get the max number of fingers */
>> -	ret = rmi_read(hdev, data->f11.query_base_addr + 1, buf);
>> -	if (ret) {
>> -		hid_err(hdev, "can not get NumberOfFingers: %d.\n", ret);
>> -		return ret;
>> -	}
>> -	data->max_fingers = (buf[0] & 0x07) + 1;
>> -	if (data->max_fingers > 5)
>> -		data->max_fingers = 10;
>> -
>> -	data->f11.report_size = data->max_fingers * 5 +
>> -				DIV_ROUND_UP(data->max_fingers, 4);
>> -
>> -	if (!(buf[0] & BIT(4))) {
>> -		hid_err(hdev, "No absolute events, giving up.\n");
>> -		return -ENODEV;
>> -	}
>> -
>> -	has_rel = !!(buf[0] & BIT(3));
>> -	has_gestures = !!(buf[0] & BIT(5));
>> -
>> -	ret = rmi_read(hdev, data->f11.query_base_addr + 5, buf);
>> -	if (ret) {
>> -		hid_err(hdev, "can not get absolute data sources: %d.\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	has_dribble = !!(buf[0] & BIT(4));
>> -
>> -	/*
>> -	 * At least 4 queries are guaranteed to be present in F11
>> -	 * +1 for query 5 which is present since absolute events are
>> -	 * reported and +1 for query 12.
>> -	 */
>> -	query_offset = 6;
>> -
>> -	if (has_rel)
>> -		++query_offset; /* query 6 is present */
>> -
>> -	if (has_gestures) {
>> -		/* query 8 to find out if query 10 exists */
>> -		ret = rmi_read(hdev,
>> -			data->f11.query_base_addr + query_offset + 1, buf);
>> -		if (ret) {
>> -			hid_err(hdev, "can not read gesture information: %d.\n",
>> -				ret);
>> -			return ret;
>> -		}
>> -		has_palm_detect = !!(buf[0] & BIT(0));
>> -		has_query10 = !!(buf[0] & BIT(2));
>> -
>> -		query_offset += 2; /* query 7 and 8 are present */
>> -	}
>> -
>> -	if (has_query9)
>> -		++query_offset;
>> -
>> -	if (has_query10)
>> -		++query_offset;
>> -
>> -	if (has_query11)
>> -		++query_offset;
>> -
>> -	/* query 12 to know if the physical properties are reported */
>> -	if (has_query12) {
>> -		ret = rmi_read(hdev, data->f11.query_base_addr
>> -				+ query_offset, buf);
>> -		if (ret) {
>> -			hid_err(hdev, "can not get query 12: %d.\n", ret);
>> -			return ret;
>> -		}
>> -		has_physical_props = !!(buf[0] & BIT(5));
>> -
>> -		if (has_physical_props) {
>> -			query_offset += 1;
>> -			ret = rmi_read_block(hdev,
>> -					data->f11.query_base_addr
>> -						+ query_offset, buf, 4);
>> -			if (ret) {
>> -				hid_err(hdev, "can not read query 15-18: %d.\n",
>> -					ret);
>> -				return ret;
>> -			}
>> -
>> -			x_size = buf[0] | (buf[1] << 8);
>> -			y_size = buf[2] | (buf[3] << 8);
>> -
>> -			data->x_size_mm = DIV_ROUND_CLOSEST(x_size, 10);
>> -			data->y_size_mm = DIV_ROUND_CLOSEST(y_size, 10);
>> -
>> -			hid_info(hdev, "%s: size in mm: %d x %d\n",
>> -				 __func__, data->x_size_mm, data->y_size_mm);
>> -
>> -			/*
>> -			 * query 15 - 18 contain the size of the sensor
>> -			 * and query 19 - 26 contain bezel dimensions
>> -			 */
>> -			query_offset += 12;
>> -		}
>> -	}
>> -
>> -	if (has_query27)
>> -		++query_offset;
>> -
>> -	if (has_query28) {
>> -		ret = rmi_read(hdev, data->f11.query_base_addr
>> -				+ query_offset, buf);
>> -		if (ret) {
>> -			hid_err(hdev, "can not get query 28: %d.\n", ret);
>> -			return ret;
>> -		}
>> -
>> -		has_query36 = !!(buf[0] & BIT(6));
>> -	}
>> -
>> -	if (has_query36) {
>> -		query_offset += 2;
>> -		ret = rmi_read(hdev, data->f11.query_base_addr
>> -				+ query_offset, buf);
>> -		if (ret) {
>> -			hid_err(hdev, "can not get query 36: %d.\n", ret);
>> -			return ret;
>> -		}
>> -
>> -		has_data40 = !!(buf[0] & BIT(5));
>> -	}
>> -
>> -
>> -	if (has_data40)
>> -		data->f11.report_size += data->max_fingers * 2;
>> -
>> -	ret = rmi_read_block(hdev, data->f11.control_base_addr,
>> -			data->f11_ctrl_regs, RMI_F11_CTRL_REG_COUNT);
>> -	if (ret) {
>> -		hid_err(hdev, "can not read ctrl block of size 11: %d.\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	/* data->f11_ctrl_regs now contains valid register data */
>> -	data->read_f11_ctrl_regs = true;
>> -
>> -	data->max_x = data->f11_ctrl_regs[6] | (data->f11_ctrl_regs[7] << 8);
>> -	data->max_y = data->f11_ctrl_regs[8] | (data->f11_ctrl_regs[9] << 8);
>> -
>> -	if (has_dribble) {
>> -		data->f11_ctrl_regs[0] = data->f11_ctrl_regs[0] & ~BIT(6);
>> -		ret = rmi_write(hdev, data->f11.control_base_addr,
>> -				data->f11_ctrl_regs);
>> -		if (ret) {
>> -			hid_err(hdev, "can not write to control reg 0: %d.\n",
>> -				ret);
>> -			return ret;
>> -		}
>> -	}
>> -
>> -	if (has_palm_detect) {
>> -		data->f11_ctrl_regs[11] = data->f11_ctrl_regs[11] & ~BIT(0);
>> -		ret = rmi_write(hdev, data->f11.control_base_addr + 11,
>> -				&data->f11_ctrl_regs[11]);
>> -		if (ret) {
>> -			hid_err(hdev, "can not write to control reg 11: %d.\n",
>> -				ret);
>> -			return ret;
>> -		}
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>> -static int rmi_populate_f30(struct hid_device *hdev)
>> -{
>> -	struct rmi_data *data = hid_get_drvdata(hdev);
>> -	u8 buf[20];
>> -	int ret;
>> -	bool has_gpio, has_led;
>> -	unsigned bytes_per_ctrl;
>> -	u8 ctrl2_addr;
>> -	int ctrl2_3_length;
>> -	int i;
>> -
>> -	/* function F30 is for physical buttons */
>> -	if (!data->f30.query_base_addr) {
>> -		hid_err(hdev, "No GPIO/LEDs found, giving up.\n");
>> -		return -ENODEV;
>> -	}
>> -
>> -	ret = rmi_read_block(hdev, data->f30.query_base_addr, buf, 2);
>> -	if (ret) {
>> -		hid_err(hdev, "can not get F30 query registers: %d.\n", ret);
>> +	ret = rmi_reset_attn_mode(hdev);
>> +	if (ret)
>>   		return ret;
>> -	}
>>   
>> -	has_gpio = !!(buf[0] & BIT(3));
>> -	has_led = !!(buf[0] & BIT(2));
>> -	data->gpio_led_count = buf[1] & 0x1f;
>> -
>> -	/* retrieve ctrl 2 & 3 registers */
>> -	bytes_per_ctrl = (data->gpio_led_count + 7) / 8;
>> -	/* Ctrl0 is present only if both has_gpio and has_led are set*/
>> -	ctrl2_addr = (has_gpio && has_led) ? bytes_per_ctrl : 0;
>> -	/* Ctrl1 is always be present */
>> -	ctrl2_addr += bytes_per_ctrl;
>> -	ctrl2_3_length = 2 * bytes_per_ctrl;
>> -
>> -	data->f30.report_size = bytes_per_ctrl;
>> -
>> -	ret = rmi_read_block(hdev, data->f30.control_base_addr + ctrl2_addr,
>> -				buf, ctrl2_3_length);
>> +	ret = rmi_driver_resume(rmi_dev);
>>   	if (ret) {
>> -		hid_err(hdev, "can not read ctrl 2&3 block of size %d: %d.\n",
>> -			ctrl2_3_length, ret);
>> +		hid_warn(hdev, "Failed to resume device: %d\n", ret);
>>   		return ret;
>>   	}
>>   
>> -	for (i = 0; i < data->gpio_led_count; i++) {
>> -		int byte_position = i >> 3;
>> -		int bit_position = i & 0x07;
>> -		u8 dir_byte = buf[byte_position];
>> -		u8 data_byte = buf[byte_position + bytes_per_ctrl];
>> -		bool dir = (dir_byte >> bit_position) & BIT(0);
>> -		bool dat = (data_byte >> bit_position) & BIT(0);
>> -
>> -		if (dir == 0) {
>> -			/* input mode */
>> -			if (dat) {
>> -				/* actual buttons have pull up resistor */
>> -				data->button_count++;
>> -				set_bit(i, &data->button_mask);
>> -				set_bit(i, &data->button_state_mask);
>> -			}
>> -		}
>> -
>> -	}
>> -
>>   	return 0;
>>   }
>> +#endif /* CONFIG_PM */
>>   
>> -static int rmi_populate(struct hid_device *hdev)
>> +static int rmi_hid_reset(struct rmi_transport_dev *xport, u16 reset_addr)
>>   {
>> -	struct rmi_data *data = hid_get_drvdata(hdev);
>> -	int ret;
>> -
>> -	ret = rmi_scan_pdt(hdev);
>> -	if (ret) {
>> -		hid_err(hdev, "PDT scan failed with code %d.\n", ret);
>> -		return ret;
>> -	}
>> +	struct rmi_data *data = container_of(xport, struct rmi_data, xport);
>> +	struct hid_device *hdev = data->hdev;
>>   
>> -	ret = rmi_populate_f01(hdev);
>> -	if (ret) {
>> -		hid_err(hdev, "Error while initializing F01 (%d).\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	ret = rmi_populate_f11(hdev);
>> -	if (ret) {
>> -		hid_err(hdev, "Error while initializing F11 (%d).\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	if (!(data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)) {
>> -		ret = rmi_populate_f30(hdev);
>> -		if (ret)
>> -			hid_warn(hdev, "Error while initializing F30 (%d).\n", ret);
>> -	}
>> -
>> -	return 0;
>> +	return rmi_reset_attn_mode(hdev);
>>   }
>>   
>>   static int rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>   {
>>   	struct rmi_data *data = hid_get_drvdata(hdev);
>>   	struct input_dev *input = hi->input;
>> -	int ret;
>> -	int res_x, res_y, i;
>> +	int ret = 0;
>> +
>> +	if (!(data->device_flags & RMI_DEVICE))
>> +		return 0;
>>   
>> -	data->input = input;
>> +	data->xport.input = input;
>>   
>>   	hid_dbg(hdev, "Opening low level driver\n");
>>   	ret = hid_hw_open(hdev);
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (!(data->device_flags & RMI_DEVICE))
>> -		return 0;
>> -
>>   	/* Allow incoming hid reports */
>>   	hid_device_io_start(hdev);
>>   
>> @@ -1216,40 +506,10 @@ static int rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>   		goto exit;
>>   	}
>>   
>> -	ret = rmi_populate(hdev);
>> -	if (ret)
>> -		goto exit;
>> -
>> -	hid_info(hdev, "firmware id: %ld\n", data->firmware_id);
>> -
>> -	__set_bit(EV_ABS, input->evbit);
>> -	input_set_abs_params(input, ABS_MT_POSITION_X, 1, data->max_x, 0, 0);
>> -	input_set_abs_params(input, ABS_MT_POSITION_Y, 1, data->max_y, 0, 0);
>> -
>> -	if (data->x_size_mm && data->y_size_mm) {
>> -		res_x = (data->max_x - 1) / data->x_size_mm;
>> -		res_y = (data->max_y - 1) / data->y_size_mm;
>> -
>> -		input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
>> -		input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
>> -	}
>> -
>> -	input_set_abs_params(input, ABS_MT_ORIENTATION, 0, 1, 0, 0);
>> -	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 0xff, 0, 0);
>> -	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 0x0f, 0, 0);
>> -	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 0x0f, 0, 0);
>> -
>> -	ret = input_mt_init_slots(input, data->max_fingers, INPUT_MT_POINTER);
>> -	if (ret < 0)
>> +	ret = rmi_register_transport_device(&data->xport);
>> +	if (ret < 0) {
>> +		dev_err(&hdev->dev, "failed to register transport driver\n");
>>   		goto exit;
>> -
>> -	if (data->button_count) {
>> -		__set_bit(EV_KEY, input->evbit);
>> -		for (i = 0; i < data->button_count; i++)
>> -			__set_bit(BTN_LEFT + i, input->keybit);
>> -
>> -		if (data->button_count == 1)
>> -			__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>>   	}
>>   
>>   	set_bit(RMI_STARTED, &data->flags);
>> @@ -1298,6 +558,26 @@ static int rmi_check_valid_report_id(struct hid_device *hdev, unsigned type,
>>   	return 0;
>>   }
>>   
>> +static struct rmi_2d_sensor_platform_data rmi_hid_2d_sensor_data = {
>> +	.sensor_type = rmi_sensor_touchpad,
>> +	.axis_align.flip_y = true,
>> +	.kernel_tracking = true,
>> +};
>> +
>> +static struct rmi_f30_data rmi_hid_f30_data = {
>> +};
>> +
>> +static struct rmi_device_platform_data rmi_hid_pdata = {
>> +	.sensor_pdata = &rmi_hid_2d_sensor_data,
>> +	.f30_data = &rmi_hid_f30_data,
>> +};
>> +
>> +static const struct rmi_transport_ops hid_rmi_ops = {
>> +	.write_block	= rmi_hid_write_block,
>> +	.read_block	= rmi_hid_read_block,
>> +	.reset		= rmi_hid_reset,
>> +};
>> +
>>   static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>   {
>>   	struct rmi_data *data = NULL;
>> @@ -1312,6 +592,7 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>   		return -ENOMEM;
>>   
>>   	INIT_WORK(&data->reset_work, rmi_reset_work);
>> +	INIT_WORK(&data->attn_work, rmi_attn_work);
>>   	data->hdev = hdev;
>>   
>>   	hid_set_drvdata(hdev, data);
>> @@ -1369,6 +650,14 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>   
>>   	mutex_init(&data->page_mutex);
>>   
>> +	if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)
>> +		rmi_hid_pdata.f30_data->disable = true;
>> +
>> +	data->xport.dev = hdev->dev.parent;
>> +	data->xport.pdata = rmi_hid_pdata;
>> +	data->xport.proto_name = "hid";
>> +	data->xport.ops = &hid_rmi_ops;
>> +
>>   start:
>>   	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>>   	if (ret) {
>> @@ -1376,17 +665,6 @@ start:
>>   		return ret;
>>   	}
>>   
>> -	if ((data->device_flags & RMI_DEVICE) &&
>> -	    !test_bit(RMI_STARTED, &data->flags))
>> -		/*
>> -		 * The device maybe in the bootloader if rmi_input_configured
>> -		 * failed to find F11 in the PDT. Print an error, but don't
>> -		 * return an error from rmi_probe so that hidraw will be
>> -		 * accessible from userspace. That way a userspace tool
>> -		 * can be used to reload working firmware on the touchpad.
>> -		 */
>> -		hid_err(hdev, "Device failed to be properly configured\n");
>> -
>>   	return 0;
>>   }
>>   
>> @@ -1395,6 +673,9 @@ static void rmi_remove(struct hid_device *hdev)
>>   	struct rmi_data *hdata = hid_get_drvdata(hdev);
>>   
>>   	clear_bit(RMI_STARTED, &hdata->flags);
>> +	cancel_work_sync(&hdata->reset_work);
>> +	cancel_work_sync(&hdata->attn_work);
>> +	rmi_unregister_transport_device(&hdata->xport);
>>   
>>   	hid_hw_stop(hdev);
>>   }
>> @@ -1419,7 +700,7 @@ static struct hid_driver rmi_driver = {
>>   #ifdef CONFIG_PM
>>   	.suspend		= rmi_suspend,
>>   	.resume			= rmi_post_resume,
>> -	.reset_resume		= rmi_post_reset,
>> +	.reset_resume		= rmi_post_resume,
>>   #endif
>>   };
>>   
>> -- 
>> 2.5.0
>>

