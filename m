From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH 07/15] Input: xpad: move the input device creation to a
 new function
Date: Thu, 15 Oct 2015 21:19:35 +0200
Message-ID: <561FFC47.3060802@gmail.com>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
 <1443733046-29610-8-git-send-email-rojtberg@gmail.com>
 <20151010180015.GI39573@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34114 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbJOTTi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2015 15:19:38 -0400
Received: by lfaz124 with SMTP id z124so43610700lfa.1
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2015 12:19:36 -0700 (PDT)
In-Reply-To: <20151010180015.GI39573@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

Hey Dimitry,

I have seen you have also applied
"[PATCH 08/15] Input: xpad: query Wireless controller state at init".
However this change is unfortunately incomplete without
"[PATCH 09/15] Input: xpad: handle "present" and "gone" correctly".

As is both the presence as well as the LED packets are sent immediately 
at init
which triggers the the "URB xxxx submitted while active" Warning and causes
any initialization to fail.

Attached is a fixup against current input/ next of the chunk that is in
[PATCH 09/15], but should have been in [PATCH 08/15].
Sorry for the inconvenience.

do not call xpad_identify_controller at init: it conflicts with
the already sent presence packet and will be called by
xpad360w_process_packet as needed anyway.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
  drivers/input/joystick/xpad.c | 2 --
  1 file changed, 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d382d48..acb8859 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1001,8 +1001,6 @@ static int xpad_led_probe(struct usb_xpad *xpad)
      if (error)
          goto err_free_id;

-    /* Light up the segment corresponding to controller number */
-    xpad_identify_controller(xpad);
      return 0;

  err_free_id:
-- 
1.9.1


Am 10.10.2015 um 20:00 schrieb Dmitry Torokhov:
> On Thu, Oct 01, 2015 at 10:57:18PM +0200, Pavel Rojtberg wrote:
>> From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
>>
>> To allow us to later create / destroy the input device from the urb
>> callback, we need to initialize/ deinitialize the input device from a
>> separate function.  So pull that logic out now to make later patches
>> more "obvious" as to what they do.
>>
>> Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
>> ---
>>   drivers/input/joystick/xpad.c | 199 +++++++++++++++++++++++++++++++++++++----------------------------
>>   1 file changed, 113 insertions(+), 86 deletions(-)
>>
>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>> index 15da2a3..43490ea 100644
>> --- a/drivers/input/joystick/xpad.c
>> +++ b/drivers/input/joystick/xpad.c
>> @@ -343,6 +343,7 @@ struct usb_xpad {
>>   	int mapping;			/* map d-pad to buttons or to axes */
>>   	int xtype;			/* type of xbox device */
>>   	unsigned long pad_nr;		/* the order x360 pads were attached */
>> +	const char *name;		/* name of the device */
>>   };
>>   
>>   /*
>> @@ -1044,11 +1045,101 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
>>   	}
>>   }
>>   
>> +static int xpad_init_input(struct usb_xpad *xpad)
>> +{
>> +	struct input_dev *input_dev;
>> +	int i, error;
>> +
>> +	input_dev = input_allocate_device();
>> +	if (!input_dev)
>> +		return -ENOMEM;
>> +
>> +	xpad->dev = input_dev;
>> +	input_dev->name = xpad->name;
>> +	input_dev->phys = xpad->phys;
>> +	usb_to_input_id(xpad->udev, &input_dev->id);
>> +	input_dev->dev.parent = &xpad->intf->dev;
>> +
>> +	input_set_drvdata(input_dev, xpad);
>> +
>> +	input_dev->open = xpad_open;
>> +	input_dev->close = xpad_close;
>> +
>> +	input_dev->evbit[0] = BIT_MASK(EV_KEY);
>> +
>> +	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
>> +		input_dev->evbit[0] |= BIT_MASK(EV_ABS);
>> +		/* set up axes */
>> +		for (i = 0; xpad_abs[i] >= 0; i++)
>> +			xpad_set_up_abs(input_dev, xpad_abs[i]);
>> +	}
>> +
>> +	/* set up standard buttons */
>> +	for (i = 0; xpad_common_btn[i] >= 0; i++)
>> +		__set_bit(xpad_common_btn[i], input_dev->keybit);
>> +
>> +	/* set up model-specific ones */
>> +	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX360W ||
>> +	    xpad->xtype == XTYPE_XBOXONE) {
>> +		for (i = 0; xpad360_btn[i] >= 0; i++)
>> +			__set_bit(xpad360_btn[i], input_dev->keybit);
>> +	} else {
>> +		for (i = 0; xpad_btn[i] >= 0; i++)
>> +			__set_bit(xpad_btn[i], input_dev->keybit);
>> +	}
>> +
>> +	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
>> +		for (i = 0; xpad_btn_pad[i] >= 0; i++)
>> +			__set_bit(xpad_btn_pad[i], input_dev->keybit);
>> +	}
>> +	/* this should be a simple else block. However historically xbox360w
>> +	 * has mapped DPAD to buttons while xbox360 did not.
>> +	 * This made no sense, but now we can not just switch back and have to
>> +	 * support both behaviors.
>> +	 */
>> +	if(!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
>> +			xpad->xtype == XTYPE_XBOX360W) {
>> +		for (i = 0; xpad_abs_pad[i] >= 0; i++)
>> +			xpad_set_up_abs(input_dev, xpad_abs_pad[i]);
>> +	}
>> +
>> +	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
>> +		for (i = 0; xpad_btn_triggers[i] >= 0; i++)
>> +			__set_bit(xpad_btn_triggers[i], input_dev->keybit);
>> +	} else {
>> +		for (i = 0; xpad_abs_triggers[i] >= 0; i++)
>> +			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
>> +	}
>> +
>> +	error = xpad_init_ff(xpad);
>> +	if (error)
>> +		goto fail_init_ff;
>> +
>> +	error = xpad_led_probe(xpad);
>> +	if (error)
>> +		goto fail_init_led;
>> +
>> +	error = input_register_device(xpad->dev);
>> +	if (error)
>> +		goto fail_input_register;
>> +
>> +	return 0;
>> +
>> +fail_input_register:
>> +	xpad_led_disconnect(xpad);
>> +
>> +fail_init_led:
>> +	input_ff_destroy(input_dev);
>> +
>> +fail_init_ff:
>> +	input_free_device(input_dev);
>> +	return error;
>> +}
>> +
>>   static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id)
>>   {
>>   	struct usb_device *udev = interface_to_usbdev(intf);
>>   	struct usb_xpad *xpad;
>> -	struct input_dev *input_dev;
>>   	struct usb_endpoint_descriptor *ep_irq_in;
>>   	int ep_irq_in_idx;
>>   	int i, error;
>> @@ -1070,12 +1161,14 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>>   	}
>>   
>>   	xpad = kzalloc(sizeof(struct usb_xpad), GFP_KERNEL);
>> -	input_dev = input_allocate_device();
>> -	if (!xpad || !input_dev) {
>> +	if (!xpad) {
>>   		error = -ENOMEM;
>>   		goto fail1;
>>   	}
>>   
>> +	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
>> +	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
>> +
>>   	xpad->idata = usb_alloc_coherent(udev, XPAD_PKT_LEN,
>>   					 GFP_KERNEL, &xpad->idata_dma);
>>   	if (!xpad->idata) {
>> @@ -1093,6 +1186,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>>   	xpad->intf = intf;
>>   	xpad->mapping = xpad_device[i].mapping;
>>   	xpad->xtype = xpad_device[i].xtype;
>> +	xpad->name = xpad_device[i].name;
>>   
>>   	if (xpad->xtype == XTYPE_UNKNOWN) {
>>   		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
>> @@ -1111,78 +1205,10 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>>   			xpad->mapping |= MAP_STICKS_TO_NULL;
>>   	}
>>   
>> -	xpad->dev = input_dev;
>> -	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
>> -	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
>> -
>> -	input_dev->name = xpad_device[i].name;
>> -	input_dev->phys = xpad->phys;
>> -	usb_to_input_id(udev, &input_dev->id);
>> -	input_dev->dev.parent = &intf->dev;
>> -
>> -	input_set_drvdata(input_dev, xpad);
>> -
>> -	input_dev->open = xpad_open;
>> -	input_dev->close = xpad_close;
>> -
>> -	input_dev->evbit[0] = BIT_MASK(EV_KEY);
>> -
>> -	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
>> -		input_dev->evbit[0] |= BIT_MASK(EV_ABS);
>> -		/* set up axes */
>> -		for (i = 0; xpad_abs[i] >= 0; i++)
>> -			xpad_set_up_abs(input_dev, xpad_abs[i]);
>> -	}
>> -
>> -	/* set up standard buttons */
>> -	for (i = 0; xpad_common_btn[i] >= 0; i++)
>> -		__set_bit(xpad_common_btn[i], input_dev->keybit);
>> -
>> -	/* set up model-specific ones */
>> -	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX360W ||
>> -	    xpad->xtype == XTYPE_XBOXONE) {
>> -		for (i = 0; xpad360_btn[i] >= 0; i++)
>> -			__set_bit(xpad360_btn[i], input_dev->keybit);
>> -	} else {
>> -		for (i = 0; xpad_btn[i] >= 0; i++)
>> -			__set_bit(xpad_btn[i], input_dev->keybit);
>> -	}
>> -
>> -	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
>> -		for (i = 0; xpad_btn_pad[i] >= 0; i++)
>> -			__set_bit(xpad_btn_pad[i], input_dev->keybit);
>> -	}
>> -	/* this should be a simple else block. However historically xbox360w
>> -	 * has mapped DPAD to buttons while xbox360 did not.
>> -	 * This made no sense, but now we can not just switch back and have to
>> -	 * support both behaviors.
>> -	 */
>> -	if(!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
>> -			xpad->xtype == XTYPE_XBOX360W) {
>> -		for (i = 0; xpad_abs_pad[i] >= 0; i++)
>> -			xpad_set_up_abs(input_dev, xpad_abs_pad[i]);
>> -	}
>> -
>> -	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
>> -		for (i = 0; xpad_btn_triggers[i] >= 0; i++)
>> -			__set_bit(xpad_btn_triggers[i], input_dev->keybit);
>> -	} else {
>> -		for (i = 0; xpad_abs_triggers[i] >= 0; i++)
>> -			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
>> -	}
>> -
>>   	error = xpad_init_output(intf, xpad);
>>   	if (error)
>>   		goto fail3;
>>   
>> -	error = xpad_init_ff(xpad);
>> -	if (error)
>> -		goto fail4;
>> -
>> -	error = xpad_led_probe(xpad);
>> -	if (error)
>> -		goto fail5;
>> -
>>   	/* Xbox One controller has in/out endpoints swapped. */
>>   	ep_irq_in_idx = xpad->xtype == XTYPE_XBOXONE ? 1 : 0;
>>   	ep_irq_in = &intf->cur_altsetting->endpoint[ep_irq_in_idx].desc;
>> @@ -1194,10 +1220,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>>   	xpad->irq_in->transfer_dma = xpad->idata_dma;
>>   	xpad->irq_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
>>   
>> -	error = input_register_device(xpad->dev);
>> -	if (error)
>> -		goto fail6;
>> -
>>   	usb_set_intfdata(intf, xpad);
>>   
>>   	if (xpad->xtype == XTYPE_XBOX360W) {
>> @@ -1210,32 +1232,37 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>>   		 */
>>   		xpad->irq_in->dev = xpad->udev;
>>   		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
>> -		if (error)
>> -			goto fail7;
>> +		if (error) {
>> +			usb_kill_urb(xpad->irq_in);
> Why do we need to kill urb if its submission failed?
>
>> +			goto fail4;
>> +		}
>>   	}
>> +	xpad->pad_present = 1;
>> +	error = xpad_init_input(xpad);
> This is too late, at least in the context of this patch. The packets may
> already be flowing.
>
> I moved this chunk up.
>
>> +	if (error)
>> +		goto fail4;
>>   
>>   	return 0;
>>   
>> - fail7:	input_unregister_device(input_dev);
>> -	input_dev = NULL;
>> - fail6:	xpad_led_disconnect(xpad);
>> - fail5:	if (input_dev)
>> -		input_ff_destroy(input_dev);
>>    fail4:	xpad_deinit_output(xpad);
>>    fail3:	usb_free_urb(xpad->irq_in);
>>    fail2:	usb_free_coherent(udev, XPAD_PKT_LEN, xpad->idata, xpad->idata_dma);
>> - fail1:	input_free_device(input_dev);
>> -	kfree(xpad);
>> + fail1:	kfree(xpad);
>>   	return error;
>>   
>>   }
>>   
>> +static void xpad_deinit_input(struct usb_xpad *xpad)
>> +{
>> +	xpad_led_disconnect(xpad);
>> +	input_unregister_device(xpad->dev);
>> +}
>> +
>>   static void xpad_disconnect(struct usb_interface *intf)
>>   {
>>   	struct usb_xpad *xpad = usb_get_intfdata (intf);
>>   
>> -	xpad_led_disconnect(xpad);
>> -	input_unregister_device(xpad->dev);
>> +	xpad_deinit_input(xpad);
>>   	xpad_deinit_output(xpad);
>>   
>>   	if (xpad->xtype == XTYPE_XBOX360W) {
>> -- 
>> 1.9.1
>>
> Thanks.
>

