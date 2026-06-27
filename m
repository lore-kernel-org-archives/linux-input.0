Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6D15A864
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782523688; cv=none; b=N9k4ridyigF0Ef5Ljz+/Vf2rVoURY5baPY1/IHNBUXDOvf2M9YoF1PzUwEzoUKm1Dd2q+kcZqy4GoTGFW9KPTX2C7U83AGHExIkD2iHGqXo089SjkFWL4qZYxYM6FUNYRe7JQcfPpD0yRqHqsXYSM1D5wWoxdSZ6gDxOzCe6y/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782523688; c=relaxed/simple;
	bh=MhzL3DztKRA2WB8Sxg3IO4s1EULMrQeV6WxJb3pXnnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsxLXmSL0IaTiR42ePEAs6HYwWNlQtw34tqU3O3ezbwcdOZ4E+FcdzyUp2ZB1ZfVc4NcOT8D1KB3wOl9fM4kpPvpZYrOLuYjXRqpeYA8OYA2wcamdWCe0MbIfGPVZfMbQpIbRawLXDUto0NsKibGW2qtBpIDqkrx3iq+zAYp2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=oU1+/orL; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="oU1+/orL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782523680; bh=MhzL3DztKRA2WB8Sxg3IO4s1EULMrQeV6WxJb3pXnnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oU1+/orLYYaWV4/9BPxICGD4zxe1eCAvVOoANKDIk+0zW0rf6FymzTG38VMe6zHDg
	 781gVpVAvwKlNU47uXoeXlrw3an4KwLoC+gpV921q68Pt4w51KmMVc1+2qiXxR5FHq
	 PalKbjfkqD7VSkMgrTgoA/TW/N0uBtXdM5ksTU2boCNh8GqG8bQuLyiN5FpFOcAv/Z
	 uz1baBJ/AdK1QfIOgz2oN6N0qdbWuTv5rItfAD4wyL/dSPKXckLc0I+aoXHT99LlSb
	 ZSW1PZATa8OEkmW90X2w6NznsXpHVaTeKN7oAaoWsT9FpHj5jZCkgckVFKMbh8qXU5
	 tgVfVo1kHqHCg==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 834E1A018;
	Fri, 26 Jun 2026 18:28:00 -0700 (PDT)
Message-ID: <7c9dacf7-b227-4e21-b94c-1da420002c27@endrift.com>
Date: Fri, 26 Jun 2026 18:27:58 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] HID: nintendo: Add preliminary Switch 2 controller
 driver
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <20260625045948.2343168-1-vi@endrift.com>
 <20260625045948.2343168-2-vi@endrift.com>
 <20260625051651.723051F000E9@smtp.kernel.org>
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
In-Reply-To: <20260625051651.723051F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

More LLM hallucinations to deal with:

On 6/24/26 10:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 14 potential issue(s) to consider:
> - [High] Early HID start before driver data is set causes NULL pointer dereference in event handler.
> - [High] Explicitly unregistering and freeing a devm-allocated input device violates input subsystem rules and causes double-frees.
> - [High] LEDs registered with devm tied to `input->dev` lead to Use-After-Free when the parent `ns2` structure is dynamically freed.
> - [High] USB bulk input pipeline permanently stalls if URBs complete before the workqueue processes them.
> - [High] Lockless modification of `urb->state` before unanchoring in USB output error path causes UAF and DMA corruption.
> - [High] Concurrent driver unbind causes a Use-After-Free of `struct switch2_controller`.
> - [High] Teardown ordering in `switch2_usb_disconnect()` frees `bulk_out` URBs before cancelling `message_in_work`.
> - [High] Missing `cancel_work_sync()` in `switch2_usb_probe` error path leads to UAF of `ns2_usb`.
> - [High] Calling `hid_hw_close(hdev)` after `hid_hw_open(hdev)` fails corrupts `ll_open_count`.
> - [High] `usb_free_coherent()` is called while holding a spinlock with IRQs disabled.
> - [Medium] Calling `ida_free()` with an unallocated player ID (`U32_MAX`) triggers a kernel warning.
> - [Medium] Leaking OUT URBs on memory allocation failure in `switch2_usb_probe`.
> - [Medium] Mixing `goto` error handling with `guard()` cleanup violates subsystem anti-pattern rules.
> - [Low] Calling `usb_make_path()` introduces an undeclared hard dependency on the USB core.
> --
> 
> commit 322f53e1d34ab62127ead48da7aeff5c1763e2a2
> Author: Vicki Pfau <vi@endrift.com>
> 
> HID: nintendo: Add preliminary Switch 2 controller driver
> 
> This commit introduces support for the Nintendo Switch 2 Joy-Cons,
> Pro Controller, and GameCube controllers. It implements a split-interface
> design using a main HID driver and a secondary configuration interface.
> Initial support handles general input and USB communications.
> 
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -843,10 +843,13 @@ config HID_NINTENDO
>>  	depends on LEDS_CLASS
>>  	select POWER_SUPPLY
> 
> [Severity: Low]
> Does this new configuration introduce an undeclared dependency?
> 
> The newly added switch2_probe() function in hid-nintendo.c calls
> usb_make_path(), which is an exported symbol from the USB core. However,
> CONFIG_HID_NINTENDO does not specify depends on USB.

No it's not. It's a static inline function in a header and has been since 2.4.20 over 20 years ago.

> 
> If the kernel is built with CONFIG_HID_NINTENDO=y and CONFIG_USB=m, will
> the build fail during linking due to an unresolved reference to
> usb_make_path?> 
>> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>> --- a/drivers/hid/hid-nintendo.c
>> +++ b/drivers/hid/hid-nintendo.c
> [ ... ]
>> +static int switch2_init_input(struct switch2_controller *ns2)
>> +{
>> +	struct input_dev *input;
> [ ... ]
>> +	input = devm_input_allocate_device(&hdev->dev);
>> +	if (!input)
>> +		return -ENOMEM;
>> +
>> +	input_set_drvdata(input, ns2);
>> +	input->dev.parent = &hdev->dev;
> 
> [Severity: High]
> Does explicitly unregistering and freeing a devm-allocated input device
> violate input subsystem rules and cause double-frees?
> 
> The driver allocates the input device using devm_input_allocate_device().
> The input subsystem automatically handles cleanup when the provider device is
> unbound. However, the driver explicitly calls input_free_device() on failure
> paths in switch2_init_input() and input_unregister_device() in its teardown
> path switch2_controller_put().
> 
> Can this cause a double-free or double-unregister when the devres callbacks
> later attempt to clean up the same device? Additionally, is manually setting
> input->dev.parent redundant and prohibited for devm-allocated input devices?

I've already explained why this is wrong.

> 
> [ ... ]
>> +	for (i = 0; i < JC_NUM_LEDS; i++) {
>> +		struct led_classdev *led = &ns2->leds[i];
> [ ... ]
>> +		ret = devm_led_classdev_register(&input->dev, led);
>> +		if (ret < 0) {
>> +			dev_err(&input->dev, "Failed to register player %d LED; ret=%d\n",
>> +				i + 1, ret);
>> +			input_unregister_device(input);
>> +			return ret;
>> +		}
>> +	}
> 
> [Severity: High]
> Can tying the devm-managed LEDs to input->dev lead to a Use-After-Free
> when the parent ns2 structure is dynamically freed?
> 
> The LEDs are registered using devm_led_classdev_register() with input->dev.
> The ns2 structure containing the LEDs is manually freed via kfree(ns2) in
> switch2_controller_put().
> 
> The devres callbacks for input->dev execute when its refcount drops to zero.
> If userspace holds an open file descriptor to the input device, this
> cleanup can be arbitrarily delayed.
> 
> Will the driver free ns2 immediately while the LEDs remain registered and
> pointing to freed memory until the fd is closed, resulting in a
> Use-After-Free if sysfs LED attributes are accessed?

While there is an exceedingly narrow window for this I think it is theoretically possible. I'll just treat issues creating the LEDs as non-fatal and continue onwards. They can get torn down at the end like everything else.

> 
> [ ... ]
>> +static void switch2_controller_put(struct switch2_controller *ns2)
>> +{
>> +	struct input_dev *input;
>> +	bool do_free;
>> +
>> +	guard(mutex)(&switch2_controllers_lock);
>> +	mutex_lock(&ns2->lock);
>> +
>> +	rcu_read_lock();
>> +	input = rcu_dereference(ns2->input);
>> +	rcu_read_unlock();
>> +
>> +	rcu_assign_pointer(ns2->input, NULL);
>> +	synchronize_rcu();
>> +
>> +	ns2->init_step = 0;
>> +	do_free = !ns2->hdev && !ns2->cfg;
>> +	mutex_unlock(&ns2->lock);
>> +
>> +	if (input)
>> +		input_unregister_device(input);
>> +
>> +	if (do_free) {
>> +		list_del_init(&ns2->entry);
>> +		mutex_destroy(&ns2->lock);
>> +		kfree(ns2);
>> +	}
>> +}
> 
> [Severity: High]
> Could a concurrent driver unbind cause a Use-After-Free of the ns2 structure?
> 
> The guard(mutex)(&switch2_controllers_lock) holds the global lock for the
> entire function scope. If HID and USB disconnect concurrently, both clear
> their pointers and call switch2_controller_put().
> 
> If the first thread evaluates do_free as true, destroys the mutex, frees
> ns2, and returns, it releases the global lock.
> 
> Will the second thread, which was blocked waiting on the global lock,
> wake up and immediately call mutex_lock(&ns2->lock) using the pointer
> that was just freed?

I'm unsure if that re-entry is possible from an external subsystem perspective, but if it is then this narrow hole also exists. I'll convert this to just a basic ref count.

> 
> [ ... ]
>> +static int switch2_event(struct hid_device *hdev, struct hid_report *report, uint8_t *raw_data,
>> +	int size)
>> +{
>> +	struct switch2_controller *ns2 = hid_get_drvdata(hdev);
>> +	struct input_dev *input;
>> +
>> +	if (report->type != HID_INPUT_REPORT)
>> +		return 0;
>> +
>> +	if (size < 15)
>> +		return -EINVAL;
>> +
>> +	guard(rcu)();
>> +	input = rcu_dereference(ns2->input);
> 
> [Severity: High]
> Could this event handler dereference uninitialized driver data during early
> hardware I/O startup?
> 
> The switch2_probe() function calls hid_hw_start(hdev, HID_CONNECT_HIDRAW)
> before assigning its private data with hid_set_drvdata(). This connects the
> device to hidraw, allowing userspace to immediately open it and trigger input
> events, or the underlying transport can send events.
> 
> If an event arrives during this race window, will switch2_event() call
> hid_get_drvdata(hdev) and receive a NULL pointer, leading to a kernel crash
> when calling rcu_dereference(ns2->input)?

Seems I've misunderstood the difference between hid_hw_start and hid_hw_open. Fixing in v7.

> 
> [ ... ]
>> +int switch2_receive_command(struct switch2_controller *ns2,
>> +	const uint8_t *message, size_t length)
>> +{
>> +	const struct switch2_cmd_header *header;
>> +	int ret = 0;
>> +
>> +	if (length < 8)
>> +		return -EINVAL;
>> +
>> +	print_hex_dump_debug("got cmd: ", DUMP_PREFIX_OFFSET, 16, 1, message, length, false);
>> +
>> +	guard(mutex)(&ns2->lock);
>> +
>> +	header = (const struct switch2_cmd_header *)message;
>> +	if (!(header->flags & NS2_FLAG_OK)) {
>> +		dev_warn(ns2->cfg->dev, "Packet error %02x replying to command %x:%x",
>> +			header->flags, header->command, header->subcommand);
>> +		ret = -EIO;
>> +		goto exit;
>> +	}
> [ ... ]
>> +exit:
>> +	if (ns2->init_step < NS2_INIT_DONE)
>> +		switch2_init_controller(ns2);
>> +
>> +	return ret;
>> +}
> 
> [Severity: Medium]
> Does mixing goto error handling with guard() cleanup violate subsystem rules?
> 
> This function utilizes guard(mutex)(&ns2->lock) to acquire the lock using
> scope-based cleanup, but later uses goto exit to jump to a cleanup label
> on error paths.
> 
> The core kernel cleanup guidelines explicitly forbid mixing goto-based
> cleanup labels and guard() declarations in the same routine, as it
> creates confusing ownership semantics.

Ah, I guess I misunderstood the how this was forbidden. Easy enough to clean up now that I have a single exit.> 
> [ ... ]
>> +static int switch2_probe(struct hid_device *hdev, const struct hid_device_id *id)
>> +{
> [ ... ]
>> +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>> +	if (ret) {
>> +		hid_err(hdev, "hw_start failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ns2 = switch2_get_controller(phys);
> [ ... ]
>> +	ns2->player_id = U32_MAX;
>> +	ret = ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
>> +	if (ret < 0)
>> +		hid_warn(hdev, "Failed to allocate player ID, skipping; ret=%d\n", ret);
>> +	else
>> +		ns2->player_id = ret;
> [ ... ]
>> +	hid_set_drvdata(hdev, ns2);
>> +
>> +	ret = hid_hw_open(hdev);
>> +	if (ret) {
>> +		hid_err(hdev, "hw_open failed %d\n", ret);
>> +		goto err_cleanup;
>> +	}
>> +
>> +	ret = 0;
>> +	if (ns2->cfg)
>> +		ret = switch2_init_controller(ns2);
>> +
>> +	if (!ret) {
>> +		mutex_unlock(&ns2->lock);
>> +		return 0;
>> +	}
>> +
>> +err_cleanup:
>> +	hid_hw_close(hdev);
>> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);
>> +	ns2->hdev = NULL;
>> +	mutex_unlock(&ns2->lock);
> 
> [Severity: High]
> If hid_hw_open() fails, does the unconditional call to hid_hw_close(hdev)
> corrupt the ll_open_count tracking?
> 
> If hid_hw_open(hdev) fails, execution jumps to the err_cleanup label, which
> unconditionally calls hid_hw_close(hdev).
> 
> Since hid_hw_open() does not increment ll_open_count on failure, will
> hid_hw_close() decrement the count from 0, wrapping it around to UINT_MAX
> and permanently silently preventing any future opens of the device?

Fixing as part of other cleanup.

> 
> [Severity: Medium]
> Does this error path trigger a WARN_ON when trying to free an unallocated
> player ID?
> 
> The code initializes ns2->player_id to U32_MAX. If ida_alloc() fails,
> it skips allocation but retains the U32_MAX value.
> 
> In the err_cleanup path, or during switch2_remove(), the driver
> unconditionally calls ida_free(&nintendo_player_id_allocator, ns2->player_id).
> 
> Will passing -1 (U32_MAX) to ida_free() trigger a WARN_ON within the IDA
> framework?

Already shown to be a hallucination in the last reply.

> 
>> diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/input/joystick/nintendo-switch2-usb.c
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
>> +			ns2_usb->bulk_in[i].state = NS2_URB_IN;
>> +			continue;
>> +		}
>> +
>> +		if (ns2_usb->bulk_in[i].state != NS2_URB_FREE)
>> +			continue;
>> +
>> +		ns2_urb = &ns2_usb->bulk_in[i];
>> +		usb_anchor_urb(ns2_urb->urb, &ns2_usb->bulk_in_anchor);
>> +		err = usb_submit_urb(ns2_urb->urb, GFP_ATOMIC);
>> +		if (err) {
>> +			usb_unanchor_urb(ns2_urb->urb);
>> +			dev_dbg(&ns2_usb->udev->dev, "failed to queue input urb: %d\n", err);
>> +		} else {
>> +			ns2_urb->state = NS2_URB_OUT;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
>> +
>> +	if (schedule)
>> +		schedule_work(&ns2_usb->message_in_work);
>> +}
> [ ... ]
>> +static void switch2_usb_message_in_work(struct work_struct *work)
>> +{
> [ ... ]
>> +		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
>> +		urb->state = NS2_URB_FREE;
>> +	}
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
>> +}
> 
> [Severity: High]
> Does this input URB handling stall the USB bulk input pipeline permanently
> if the URBs complete too quickly?
> 
> The driver manages IN URBs via a ping-pong mechanism. switch2_bulk_in()
> submits URBs in the NS2_URB_FREE state. The worker
> switch2_usb_message_in_work() clears processed URBs to NS2_URB_FREE but
> does not re-submit them.
> 
> If all active URBs complete in quick succession before the workqueue
> thread runs, they will all be marked NS2_URB_IN. The worker will process
> them and mark them FREE, but since no URBs are left active in the USB core
> to trigger the completion handler, will switch2_bulk_in() never be called
> again, permanently halting input?

In theory, the Switch 2 controller should only send a bulk IN in reply to a bulk OUT, and we don't tend to schedule more than one of those at a time, but it'd be good to fix this anyway.> 
> [ ... ]
>> +static int switch2_usb_send_cmd(enum switch2_cmd command, uint8_t subcommand,
>> +	const void *message, size_t size, struct switch2_cfg_intf *cfg)
>> +{
> [ ... ]
>> +	usb_anchor_urb(urb->urb, &ns2_usb->bulk_out_anchor);
>> +	ret = usb_submit_urb(urb->urb, GFP_ATOMIC);
>> +	if (ret) {
>> +		if (ret != -ENODEV)
>> +			dev_warn(&ns2_usb->udev->dev, "failed to submit output urb: %i", ret);
>> +		urb->state = NS2_URB_FREE;
>> +		usb_unanchor_urb(urb->urb);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> [Severity: High]
> Can this lockless modification of urb->state lead to a data race and
> potential DMA corruption?
> 
> If usb_submit_urb() fails, urb->state = NS2_URB_FREE is set without
> re-acquiring ns2_usb->bulk_out_lock. Additionally, it is marked FREE
> before calling usb_unanchor_urb().
> 
> Could a concurrent thread acquire the lock, claim this supposedly free
> URB, write to its DMA buffer, and submit it, right as the original
> thread unanchors it? During teardown, usb_kill_anchored_urbs() would not
> wait for this unanchored URB, potentially leading to its DMA buffer being
> freed while the hardware is still accessing it.

Missed this. Fixing in v7. Wish the stochastic parrot had found this on v5.

> 
> [ ... ]
>> +static int switch2_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>> +{
> [ ... ]
>> +	for (i = 0; i < NS2_OUT_URBS; i++) {
>> +		struct urb *urb;
>> +		uint8_t *data;
>> +
>> +		urb = usb_alloc_urb(0, GFP_KERNEL);
>> +		if (!urb) {
>> +			ret = -ENOMEM;
>> +			goto err_free_in;
>> +		}
> [ ... ]
>> +	ret = switch2_controller_attach_cfg(phys, &ns2_usb->cfg);
>> +	if (ret < 0)
>> +		goto err_free_out;
>> +
>> +	return 0;
>> +
>> +err_free_out:
>> +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);
>> +	spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
>> +	for (i = 0; i < NS2_OUT_URBS; i++) {
>> +		if (!ns2_usb->bulk_out[i].urb)
>> +			continue;
>> +
>> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i].data,
>> +			ns2_usb->bulk_out[i].urb->transfer_dma);
>> +		usb_free_urb(ns2_usb->bulk_out[i].urb);
>> +	}
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
>> +err_free_in:
>> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
> [ ... ]
>> +	devm_kfree(&intf->dev, ns2_usb);
>> +
>> +	return ret;
>> +}
> 
> [Severity: Medium]
> Does this error handling skip cleaning up successfully allocated OUT URBs?
> 
> During the loop allocating OUT URBs, if usb_alloc_urb() fails, the code
> branches to goto err_free_in. This skips the err_free_out block entirely.
> 
> Will this permanently leak the OUT URBs and their DMA buffers from
> any preceding successful loop iterations?

Fixed.

> 
> [Severity: High]
> Does calling usb_free_coherent() inside the atomic critical section violate
> DMA API rules?
> 
> In the err_free_out block, usb_free_coherent() is called while the
> bulk_out_lock spinlock is held with IRQs disabled (using spin_lock_irqsave).
> 
> Since usb_free_coherent() is a wrapper for dma_free_coherent() and freeing
> memory allocated with GFP_KERNEL may sleep, will this cause deadlocks or
> kernel panics under CONFIG_DEBUG_ATOMIC_SLEEP?

Fixed.

> 
> [Severity: High]
> Is a cancel_work_sync() missing from this error path, potentially causing
> a Use-After-Free?
> 
> An IN URB is submitted before calling switch2_controller_attach_cfg().
> If the device responds immediately, switch2_bulk_in() will schedule
> ns2_usb->message_in_work.
> 
> If attach_cfg fails, the error path frees ns2_usb via devm_kfree() but
> never calls cancel_work_sync(&ns2_usb->message_in_work).
> 
> Could the scheduled work execute later on the freed memory footprint of
> ns2_usb?

Fixed.

> 
> [ ... ]
>> +static void switch2_usb_disconnect(struct usb_interface *intf)
>> +{
>> +	struct switch2_usb *ns2_usb = usb_get_intfdata(intf);
>> +	unsigned long flags;
>> +	int i;
>> +
>> +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);
>> +	spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
>> +	for (i = 0; i < NS2_OUT_URBS; i++) {
>> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i].data,
>> +			ns2_usb->bulk_out[i].urb->transfer_dma);
>> +		usb_free_urb(ns2_usb->bulk_out[i].urb);
>> +	}
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
>> +
>> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
>> +	cancel_work_sync(&ns2_usb->message_in_work);
> 
> [Severity: High]
> Does freeing the bulk_out URBs before cancelling the worker lead to
> a Use-After-Free and DMA corruption?
> 
> All bulk_out URBs and their DMA buffers are freed before the driver
> invokes cancel_work_sync(&ns2_usb->message_in_work).
> 
> Can the globally scheduled workqueue run concurrently during this gap,
> process incoming messages, and trigger a reply via switch2_usb_send_cmd()?
> 
> If so, will the send function claim a freed URB and write to the freed DMA
> buffer, leading to a Use-After-Free and submitting corrupted DMA to the
> USB controller?
> 
> [Severity: High]
> Does calling usb_free_coherent() inside the atomic critical section violate
> DMA API rules?
> 
> Similar to the probe error path, usb_free_coherent() is called while the
> bulk_out_lock spinlock is held with IRQs disabled (using spin_lock_irqsave).
> 
> Since freeing memory allocated with GFP_KERNEL may sleep, will this cause
> deadlocks or kernel panics under CONFIG_DEBUG_ATOMIC_SLEEP?
> 

Fixed a bunch of things in this too.

I'm noticing a bunch of ordering stuff in this file that's rough to get right. Hopefully I've fixed it now and will be submitting v7 on Monday probably. Still need to review patch 2 and retest everything.

