Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB232BF41
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841976; cv=none; b=JgRtKyMCMA0oAvoNdSGe00NVcVq6jBCi1C+rLeqsIiemZ7N0NQZN4K/ZnSLaRq/nGlKCPQG87QJKjMh38+AeLgCBu8EGPr0Q3dxnM0oYSEkH8WXe0UuQC9qXqmQK/iExUw814w7DATVaOSsdtDpGodBT1EWFlpkQ+lTMO+FhSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841976; c=relaxed/simple;
	bh=3wsr4061T1xtJcMjUxkV1dlnk+J5Aohj93o6gICNKV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3L9TpZA9p6X3/Xo4U2aOhg/ISi0C4Ov/ow93Z3sa13GVj+WZ3bSSgMnatbjzVSvsefcIgGPA9MuU7Z9R7dzTrd1GaLBKMzNwIB1BxrxsUbVIPuGfsvgVSrKpdDrbnsgssMqUsTDLV26GtAT55HnfvL9Xd/38J7Vf0FrkTZ7NZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=uQrwC4Yb; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="uQrwC4Yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1781841379; bh=3wsr4061T1xtJcMjUxkV1dlnk+J5Aohj93o6gICNKV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uQrwC4YbZcb3hn1Lj7El+N34LlM5Xh/H/ZwL1GkMvK0N2vv0bS4fVidgLmLbgq/HI
	 Zm/V1BKqcxJmiMEK5oMWPabR9x6uCSjFZcvfOUQa4uq+lRnyqoG7bJ2zPvCwrRd5b1
	 hkA9cCDTtT4O2avDAVhpXTA/a4JH6g8C4qO0X/diGYHrPpi8Tyw65tLRfWut35+6Lq
	 v1kkVcKHZs6l1CsOVVy+0uX2OoX1Z4+jk5DxfOdOqDjVW6nMquoDkFhX5e5mu+J1+C
	 w1vNLbivNb9ooNCCxi8OhN6+kvnrd/UqcweSwnEWrAA7CvprY5XhgdJZ6N600/Js8G
	 Mb3A5T6XMqMDQ==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 42728A043;
	Thu, 18 Jun 2026 20:56:19 -0700 (PDT)
Message-ID: <b68d6221-1273-42c0-addb-a4966813c9a8@endrift.com>
Date: Thu, 18 Jun 2026 20:56:17 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] HID: nintendo: Add preliminary Switch 2 controller
 driver
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <20260512200051.2534081-2-vi@endrift.com>
 <20260514001510.964E7C19425@smtp.kernel.org>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
Autocrypt: addr=vi@endrift.com; keydata=
 xsBNBFtJAmYBCADmRIN9O/aBbYc93lUMvG2hPip++otLit+65EwNHB1y9BmbVr0Q8Tz7rbAM
 K2mB0EiA4Z3DesoLIOzlJq0E4fgDsAi8ok/i7aTx35d0Qeab95GEdkCMcL98xNJE0agq+KYk
 pnvFlhdyC23K32KdOijsUqqbd86GgxRZmuf/Yf932KxKAj+n0aFBw5y6i0ep7WQBF6ytpqah
 Uzy04D//smiTr6rrXg+C09MX0XZ2Fvcv3gmimnoV6C/ZCO1Zecqyhrs0YFfdIhFEBp2ItYim
 MoeU4g6y726gyRO/+wwzZkryJMU8hHootzW1gUylZeELSwx8uIJSHFiLE7AK+M5soPtDABEB
 AAHNG1ZpY2tpIFBmYXUgPHZpQGVuZHJpZnQuY29tPsLAjgQTAQoAOBYhBNj+0QMp9OPSosB4
 6X72E7X7Nb0rBQJbSQJmAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH72E7X7Nb0r
 WIcH/0GnIOkmAyy2UlgS/VKi193ZRWYJjBfUncIBf57gLt1KYY0PvUoR9MVvkLqcx8vaCxWh
 bVSqzxT6WU1ECp/URdQV2W4IGB6W4B8rT3VGw0QzbVVQRmt6vReEMFVL+vBfgHKTRBItiy7x
 Bd+JZDusiyrrGok9TqqkBYlZPWE29ajiOAe05N1UhuRq7y8w/bOkzFD36ohMtfqV4hByWV+q
 d0LujqgZm1AkM1FqpJ4j8h1Gox5rpmWfaHJmBQ8HcKqQfwACQCvDNHS2vlTXJYfxlh+mVerL
 YKZgWnyvqx4pLKqJOXQKssIaDjnDfTu6bQgXvhaKb1+piBUYuoe9/+3E15TOwE0EW0kCZgEI
 AL/KzT+NR1/LbJ7Kuv3gAHFp+S7cfyyPSamN6i6/X135vNSawG7g81iWUweAW6YahFA2haqw
 t+8/Bm9Dzc8rF6RHCElK1GoHiF4SIYQxjqPo2wwqvTad9FblWTfaYRKfVDvNz2Rz4i681JrR
 8gizvzJPX+gocH7FMzPwb1DAwL2kKA5wilgAGSv8nZqeG55hNt2t/XiT6Yd97DJv86D24UUP
 BetLTq2jUWtX+omt+JhF3QzMjnyGQYKHNXUB/ipBxNSkwnDrWg/f1EjDtNzuOHManJDC9Bqi
 qhi1abiTNlmmewI5iLEnnxzfSKS5HO9nCC1szl229DHwIMH7jA+G+z0AEQEAAcLAdgQYAQoA
 IBYhBNj+0QMp9OPSosB46X72E7X7Nb0rBQJbSQJmAhsMAAoJEH72E7X7Nb0roioIAM0oDKEU
 QH7Og4+AXm35uklIiCX6cFQPgDVlQn7M/QFLnEhhCfPTt8PkIIN4dLgs4lIJxExpgQWgOLUX
 h+ZLLupzZXoysAXfdwNLf/RqRed/zTZbUjssy4D7yeNIJThzU32kDy0Hx3pMNM/Hd9yaXmHL
 LDkfwcyQuqA9+eeOogkDC8inLNLfYQ8JtVQZuWppNcbOZkBxfMVAmPHg6C9fe2biQFojoLPe
 4nQheprKfBp5QsY2cIjP8kaWPpfJEJ5i2aNgtrfebEzjYoWWLkK78Lo8qABdxkVhH6rhAlw2
 rVf41cHNCfHF7ddvOb9IItWacXxYn7ql+dI/Se3+ISWDboQ=
In-Reply-To: <20260514001510.964E7C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Guess I'm doing LLM review replies now.

On 5/13/26 5:15 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 11 potential issue(s) to consider:
> - [High] Sleeping in atomic context and AB-BA deadlock in `switch2_usb_disconnect`
> - [High] Race condition in IN URB tracking causes permanent starvation
> - [High] Dangling pointers and use-after-free on probe failure
> - [High] Memory corruption and double free due to incorrect devm input lifecycle management
> - [High] NULL pointer dereference in USB probe error path
> - [High] Division by zero crash from unvalidated trigger calibration data
> - [High] BUG_ON kernel panic when `ida_free` is called with U32_MAX
> - [High] Out-of-bounds read when parsing NS2_CMD_FW_INFO response
> - [High] Race condition due to URB submission before initialization of synchronization primitives
> - [Medium] Infinite USB retry storm on protocol errors
> - [Medium] Unaligned memory access on byte array casts
> --
> 
> commit 00cb7265ad5983144c6923702e2ee2c3c047d29e
> Author: Vicki Pfau <vi@endrift.com>
> Subject: HID: nintendo: Add preliminary Switch 2 controller driver
> 
> This adds a new driver for the Switch 2 controllers. The Switch 2 uses an
> unusual split-interface design such that input and rumble occur on the main
> HID interface, but all other communication occurs over a "configuration"
> interface.
> 
>> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>> index 29008c2cc5304..2193afcdefabc 100644
>> --- a/drivers/hid/hid-nintendo.c
>> +++ b/drivers/hid/hid-nintendo.c
> [ ... ]
>> +static int switch2_init_input(struct switch2_controller *ns2)
>> +{
> [ ... ]
>> +	input = devm_input_allocate_device(&hdev->dev);
>> +	if (!input)
>> +		return -ENOMEM;
> [ ... ]
>> +	ret = input_register_device(input);
>> +	if (ret < 0) {
>> +		hid_err(ns2->hdev, "Failed to register input; ret=%d\n", ret);
>> +		input_free_device(input);
> 
> Calling input_free_device or input_unregister_device on a devm-managed
> input device can cause double frees when devres cleanup fires. Can this
> lead to memory corruption?

False positive. The documentation clearly states there is no devm equivalent and input_unregister_device works fine on devm-managed devices. The source of input_free_device also clearly shows logic for handling devm, and the source of input_device_unregister calls into a static devm_input_device_unregister if needed.

> 
>> +		return ret;
>> +	}
> [ ... ]
>> +static void switch2_controller_put(struct switch2_controller *ns2)
>> +{
>> +	struct input_dev *input;
>> +	bool do_free;
> [ ... ]
>> +	if (input)
>> +		input_unregister_device(input);
> 
> Calling input_unregister_device on a devm-managed input device can cause
> issues. If the input device remains alive (tied to the HID device devres)
> and its child LEDs are not released, will reconnecting the USB cable
> allocate a new input device and corrupt the LED lists by re-registering
> the exact same ns2->leds structures?

Same false positive

> 
>> +
>> +	if (do_free) {
> [ ... ]
>> +static void switch2_report_trigger(struct input_dev *input, uint8_t zero, int abs, uint8_t data)
>> +{
>> +	int value = (NS2_TRIGGER_RANGE + 1) * (data - zero) / (232 - zero);
> 
> The zero variable is loaded directly from the controller's factory calibration
> flash. If a device reports a zero point of exactly 232, will this trigger a
> division by zero exception and crash the kernel?

Ok, an actual finding. I'll have this fixed in v6.
> 
>> +
>> +	input_report_abs(input, abs, clamp(value, 0, NS2_TRIGGER_RANGE));
>> +}
> [ ... ]
>> +static int switch2_read_flash(struct switch2_controller *ns2, uint32_t address,
>> +	uint8_t size)
>> +{
>> +	uint8_t message[8] = { size, 0x7e };
>> +
>> +	if (!ns2->cfg)
>> +		return -ENOTCONN;
>> +	*(__le32 *)&message[4] = __cpu_to_le32(address);
> 
> The driver directly casts &message[4] to __le32. Since message is a uint8_t
> array, it is only guaranteed to be 1-byte aligned. On strict architectures,
> will this unaligned memory write trigger a hardware alignment fault?

Good catch. Fixed in v6.

> 
>> +	return ns2->cfg->send_command(NS2_CMD_FLASH, NS2_SUBCMD_FLASH_READ, message,
>> +		sizeof(message), ns2->cfg);
>> +}
> [ ... ]
>> +int switch2_receive_command(struct switch2_controller *ns2,
>> +	const uint8_t *message, size_t length)
>> +{
> [ ... ]
>> +	header = (const struct switch2_cmd_header *)message;
>> +	if (!(header->flags & NS2_FLAG_OK)) {
>> +		ret = -EIO;
>> +		goto exit;
>> +	}
>> +	message = &message[8];
>> +	switch (header->command) {
> [ ... ]
>> +	case NS2_CMD_FW_INFO:
>> +		if (header->subcommand == NS2_SUBCMD_FW_INFO_GET) {
>> +			if (length < sizeof(ns2->version)) {
>> +				ret = -EINVAL;
>> +				goto exit;
>> +			}
>> +			memcpy(&ns2->version, message, sizeof(ns2->version));
> 
> The message pointer is advanced by 8 bytes to skip the header, but length
> is not decremented. The bounds check compares length against
> sizeof(ns2->version). If length is exactly sizeof(ns2->version), the check
> passes, but the advanced message pointer only has length - 8 valid bytes
> remaining. Will the memcpy over-read into uninitialized memory?

Fixed in v6.

> 
>> +			ns2->ctlr_type = ns2->version.ctlr_type;
>> +			switch2_init_step_done(ns2, NS2_INIT_GET_FIRMWARE_INFO);
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +exit:
>> +	if (ns2->init_step < NS2_INIT_DONE)
>> +		switch2_init_controller(ns2);
> 
> If a command response has the NACK flag set or encounters another error,
> the code jumps to exit and invokes switch2_init_controller. Since
> ns2->init_step has not advanced, the state machine will immediately re-send
> the exact same command. Can this cause an infinite tight feedback loop of
> failures and retries, flooding the USB bus?

This doesn't happen for problems already described in the thread previously.
> 
>> +
>> +	return ret;
>> +}
> [ ... ]
>> +int switch2_controller_attach_cfg(const char *phys, struct switch2_cfg_intf *cfg)
>> +{
> [ ... ]
>> +	guard(mutex)(&ns2->lock);
>> +	WARN_ON(ns2->cfg);
>> +	ns2->cfg = cfg;
>> +
>> +	if (ns2->hdev)
>> +		return switch2_init_controller(ns2);
> 
> If switch2_init_controller fails here or in switch2_probe, the error is
> returned immediately without unrolling the state. Will ns2->cfg or ns2->hdev
> remain set, potentially leading to a use-after-free when subsequent device
> events occur?

This is a good catch. I'm not sure what the right fix is though; obviously a half-configured state is bad, but I'm not sure a full teardown is the best approach; it can leave it in a weird state, even if it's not a UAF risk. I'll go with a full teardown for now at least.

> 
>> +	return 0;
>> +}
> [ ... ]
>> +static void switch2_remove(struct hid_device *hdev)
>> +{
>> +	struct switch2_controller *ns2 = hid_get_drvdata(hdev);
>> +
>> +	hid_hw_close(hdev);
>> +	mutex_lock(&ns2->lock);
>> +	WARN_ON(ns2->hdev != hdev);
>> +	ns2->hdev = NULL;
>> +	mutex_unlock(&ns2->lock);
>> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);
> 
> If ida_alloc fails during probe, ns2->player_id remains at its default
> value of U32_MAX. When ida_free is called, the IDA framework enforces a
> check on the ID. Casting U32_MAX to a signed integer yields -1. Will this
> trigger the BUG_ON and cause a kernel panic?

I can't find any evidence of such a BUG_ON. A negative number will just early return. This seems like a hallucination.

> 
>> +	switch2_controller_put(ns2);
>> +	hid_hw_stop(hdev);
>> +}
> [ ... ]
>> diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/input/joystick/nintendo-switch2-usb.c
>> new file mode 100644
>> index 0000000000000..ebd89d852e21a
>> --- /dev/null
>> +++ b/drivers/input/joystick/nintendo-switch2-usb.c
> [ ... ]
>> +static void switch2_bulk_in(struct urb *urb)
>> +{
> [ ... ]
>> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
>> +	for (i = 0; i < NS2_IN_URBS; i++) {
>> +		int err;
>> +		struct switch2_urb *ns2_urb;
>> +
>> +		if (ns2_usb->bulk_in[i].urb == urb) {
>> +			ns2_usb->message_in = i;
> 
> If multiple URBs complete in quick succession before the work item executes,
> the message_in index is overwritten. Will this cause the work item to only
> process the last completed URB, leaving earlier URBs indefinitely active
> and leading to starvation of the URB pool?
> 

In practice this probably won't happen but I guess it's worth fixing.

>> +			continue;
>> +		}
> [ ... ]
>> +static int switch2_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>> +{
> [ ... ]
>> +	ns2_usb->bulk_in[0].active = true;
>> +	ret = usb_submit_urb(ns2_usb->bulk_in[0].urb, GFP_ATOMIC);
>> +	if (ret < 0)
>> +		goto err_free_out;
>> +
>> +	init_usb_anchor(&ns2_usb->bulk_out_anchor);
>> +	spin_lock_init(&ns2_usb->bulk_out_lock);
>> +	init_usb_anchor(&ns2_usb->bulk_in_anchor);
>> +	spin_lock_init(&ns2_usb->bulk_in_lock);
>> +	INIT_WORK(&ns2_usb->message_in_work, switch2_usb_message_in_work);
> 
> usb_submit_urb is invoked for bulk_in[0] before the initialization of the
> spinlocks, anchors, and work struct. If the URB completes immediately, the
> completion handler will execute and attempt to use uninitialized
> synchronization primitives. Can this cause a crash?

I don't know if this is possible but I guess I'll fix it.

> 
>> +
>> +	usb_set_intfdata(intf, ns2_usb);
> [ ... ]
>> +err_kill_urb:
>> +	usb_kill_urb(ns2_usb->bulk_in[0].urb);
>> +err_free_out:
>> +	for (i = 0; i < NS2_OUT_URBS; i++) {
>> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i].data,
>> +			ns2_usb->bulk_out[i].urb->transfer_dma);
>> +		usb_free_urb(ns2_usb->bulk_out[i].urb);
>> +	}
>> +err_free_in:
>> +	for (i = 0; i < NS2_IN_URBS; i++) {
>> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_in[i].data,
>> +			ns2_usb->bulk_in[i].urb->transfer_dma);
> 
> If usb_alloc_urb fails during the loop, it jumps to err_free_in. During
> cleanup, it accesses ns2_usb->bulk_in[i].urb->transfer_dma. Since urb is
> NULL for the failed index, will this trigger a NULL pointer dereference?

I removed the NULL check due to checkpatch telling me I didn't need it but I guess I'll put it back.

> 
>> +		usb_free_urb(ns2_usb->bulk_in[i].urb);
>> +	}
>> +	devm_kfree(&intf->dev, ns2_usb);
>> +
>> +	return ret;
>> +}
>> +
>> +static void switch2_usb_disconnect(struct usb_interface *intf)
>> +{
>> +	struct switch2_usb *ns2_usb = usb_get_intfdata(intf);
>> +	unsigned long flags;
>> +	int i;
>> +
>> +	spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
>> +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);
> 
> Both usb_kill_anchored_urbs and cancel_work_sync can sleep. Is it safe to
> call them while holding a spinlock?

Fixing in v6.

> 
>> +	for (i = 0; i < NS2_OUT_URBS; i++) {
>> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i].data,
>> +			ns2_usb->bulk_out[i].urb->transfer_dma);
>> +		usb_free_urb(ns2_usb->bulk_out[i].urb);
>> +	}
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
>> +
>> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
>> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
>> +	cancel_work_sync(&ns2_usb->message_in_work);
> 
> Furthermore, cancel_work_sync waits for message_in_work which attempts to
> acquire bulk_in_lock. Does this cause a deadlock since the lock is already
> held by the disconnecting thread?

Likewise.

> 
>> +	for (i = 0; i < NS2_IN_URBS; i++) {
> 

