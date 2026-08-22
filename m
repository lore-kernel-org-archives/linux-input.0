Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75F2F7F0F
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366326; cv=none; b=nGDBQ6ohnGAd9CyYwNYb9qLIYqRRQ9Phsef9AZmrC0bNE6jk9RbEpYDLk9/EuINLtWAuVt/wrHt+9VJqWhzyKaHE11NmQZHvUB53e60QIIw7k6FmcCjiG/8XIrkC4x55Y0pIjjCOJZFrdfA3JrzfWecPF4wjSWetioRl5o4Wuic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366326; c=relaxed/simple;
	bh=5GFWeN1yGPqgzfO3ednU/YHhi6qKWnmPmVZQ1g8H20k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U8d+Nf1zVtrE+W61/PD3acwIoXjf2rTWCv5NaIpJU6AdkRca0Yw8zRCA1wf96VYpY/5UkxHSA3jit8CBLxzrt9ZA7t4LXaDZj/gLWT0fQAIrq1VIokfEAwfZjK9uQFhMTTbY97LQ5VKdgR+fCs7IGqm1kV+4docuoXg4lB2QqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEaKzeBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEaKzeBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14931F000E9;
	Sat, 22 Aug 2026 02:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787366324;
	bh=JKnTAwLldnedviPlNKUcBZXgnDO21fsxzcdKlWOEpow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kEaKzeBm1F2OeQMAvpv11GRouP4tS5Zz5+Xff9yC2fPDALofv4ei1yWg219YCeexP
	 +60eKo6vkVVXHcdL6FNbx215ppJBKoDHXbCmE9CO2Nu24L7hqYITGkdrxy9z9IkpjB
	 ZrJCmt8TyFxgvEL97qQHJlGlLllMU7s1EIuNB+4v/q6zmENLgmsa6yh1DNkxmZZ7tH
	 zSO/7mFLuJHgBsFf67n7lH6vwKCHUEXOqcMFQ69YKcaJcrQu4XCyQAZx1RRXDGpCF0
	 pBNAu7sV88ROeKN2qWNwAY7ZyqmsQUL5Xuoc+0VwTcJhnDzI76EKxa9V9L+aS9Rd9B
	 lN8pEVmdVcuog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/12] Input: xbox_gip - Add new driver for Xbox GIP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822021140.1149546-2-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:38:43 +0000
Message-Id: <20260822023843.F14931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 17 potential issue=
(s) to consider:
- [High] Deadlock caused by calling `cancel_delayed_work_sync()` while hold=
ing a mutex required by the work function.
- [High] Lifecycle mismatch causing devres memory leak due to allocating ag=
ainst the parent USB device instead of the USB interface.
- [High] Active OUT URBs are freed without being killed, causing use-after-=
free and DMA corruption.
- [High] Lock inversion during devres cleanup triggers an AB-BA deadlock be=
tween `attachment->lock` and `cancel_work_sync`.
- [High] Buffer over-read in `gip_receive_fragment` for non-initial fragmen=
ts due to missing bounds check.
- [High] Probe error path leaves an active IN URB running, leading to a Use=
-After-Free.
- [High] Dangling pointer left in `attachment->input` upon `input_register_=
device` failure.
- [High] Blind dereference of potential `ERR_PTR` returned from `gip_ensure=
_attachment`.
- [High] Undefined behavior from left shifting by 64 or more bits in `gip_d=
ecode_length`.
- [High] NULL pointer dereference when `in_fragment_data` allocation fails.
- [High] Missing NULL check after `devm_kmalloc` in `gip_send_raw_message`.
- [High] Use-After-Free due to LED/Battery callbacks operating on explicitl=
y freed `attachment` structure.
- [High] Sleeping in atomic context by calling `usb_free_coherent` while ho=
lding a spinlock.
- [High] Memory leak of URBs and DMA buffers due to `return` combined with =
dead `goto` error handling.
- [High] Heap buffer overflow in `gip_receive_fragment` due to bypassed bou=
nds check on exact offset match.
- [Medium] Bitwise OR logic typo in `gip_parse_preferred_types_metadata` ig=
nores the high byte of the string length.
- [Medium] Memory leak of `attachment->uniq` caused by repeated `HELLO_DEVI=
CE` messages.
--

--- Patch [1]: [PATCH v4 01/12] Input: xbox_gip - Add new driver for Xbox G=
IP ---
commit 8f3bdd937c628e28382af94b64282af26f6cbd22
Author: Vicki Pfau <vi@endrift.com>
Subject: Input: xbox_gip - Add new driver for Xbox GIP

This commit introduces a new Gaming Input Protocol (GIP) driver for Xbox
One and Series controllers. It supports parsing message lengths, metadata,
and handles basic gamepad input functionality along with controller quirks.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-core.c
> @@ -0,0 +1,2569 @@
> +static int gip_decode_length(uint64_t *length, const uint8_t *bytes, int=
 num_bytes)
> +{
> +	*length =3D 0;
> +	int offset;
> +
> +	for (offset =3D 0; offset < num_bytes; offset++) {
> +		uint8_t byte =3D bytes[offset];
> +
> +		*length |=3D (byte & 0x7full) << (offset * 7);

[Severity: High]
Does this loop need a bounds check to prevent shifting by 64 or more bits?

If a device sends 10 or more consecutive bytes with the 0x80 bit set,
offset will reach 10, causing the shift to become 70. This results in
undefined behavior in C.

[ ... ]

> +static int gip_send_raw_message(struct gip_attachment *attachment,
> +	uint8_t message_type, uint8_t flags, uint8_t seq, const uint8_t *bytes,
> +	int num_bytes)
> +{
[ ... ]
> +		fragment->total_length =3D num_bytes;
> +		fragment->data =3D devm_kmalloc(to_gip_device(attachment),
> +			fragment->total_length, GFP_ATOMIC);
> +		fragment->fragment_offset =3D 0;
> +		memcpy(fragment->data, bytes, num_bytes);

[Severity: High]
Is there a missing NULL check for the devm_kmalloc() return value?

If the atomic memory allocation fails under memory pressure, the subsequent
memcpy() will result in a NULL pointer dereference.

[ ... ]

> +static int gip_parse_preferred_types_metadata(struct device *dev,
> +	struct gip_device_metadata *dev_metadata, const uint8_t *bytes,
> +	int length, int buffer_offset)
> +{
[ ... ]
> +	buffer_offset++;
> +	for (i =3D 0; i < dev_metadata->num_preferred_types; i++) {
> +		if (buffer_offset + 2 >=3D length)
> +			return -EINVAL;
> +
> +		count =3D bytes[buffer_offset];
> +		count |=3D bytes[buffer_offset];

[Severity: Medium]
Is there a typo in the bitwise OR assignment for the count?

By OR-ing the exact same byte against itself, the high byte of the 16-bit
length is ignored (it looks like it should read buffer_offset + 1). This
could cause strings larger than 255 bytes to parse incorrectly as 0,
desynchronizing the buffer offset.

[ ... ]

> +static bool gip_handle_command_hello_device(struct gip_attachment *attac=
hment,
> +	const struct gip_header *header, const uint8_t *bytes, int num_bytes)
> +{
[ ... ]
> +	attachment->firmware_major_version =3D le16_to_cpu(message->firmware_ma=
jor_version);
> +	attachment->firmware_minor_version =3D le16_to_cpu(message->firmware_mi=
nor_version);
> +	attachment->vendor_id =3D le16_to_cpu(message->vendor_id);
> +	attachment->product_id =3D le16_to_cpu(message->product_id);
> +	attachment->uniq =3D devm_kasprintf(to_gip_device(attachment),
> +		GFP_KERNEL, "%llx", le64_to_cpu(message->device_id));

[Severity: Medium]
Could this cause a memory leak if the device repeatedly sends HELLO_DEVICE
messages?

The attachment->uniq pointer is assigned a newly allocated string each time
this command is handled, but any previously allocated string is not freed
prior to being overwritten.

[ ... ]

> +int gip_setup_input_device(struct gip_attachment *attachment)
> +{
[ ... ]
> +	rcu_assign_pointer(attachment->input, input);
> +	rc =3D input_register_device(input);
> +	if (rc)
> +		goto err_free_device;
> +
> +	rc =3D gip_guide_led_probe(attachment, &input->dev);
[ ... ]
> +err_free_device:
> +	input_free_device(input);
> +	return rc;
> +}

[Severity: High]
Should attachment->input be cleared to NULL in the error path?

If input_register_device() fails, input_free_device() is called, but
attachment->input remains set. If an interrupt arrives afterwards,
gip_handle_ll_input_report() could dereference the freed dangling pointer.

[ ... ]

> +static void gip_reset_metadata(struct gip_attachment *attachment)
> +{
> +	struct input_dev *input;
> +
> +	if (attachment->got_metadata !=3D GIP_METADATA_GOT)
> +		return;
> +
> +	gip_metadata_free(to_gip_device(attachment), &attachment->metadata);
> +	rcu_read_lock();
> +	input =3D rcu_dereference(attachment->input);
> +	rcu_read_unlock();
> +	if (input) {
> +		rcu_assign_pointer(attachment->input, NULL);
> +		synchronize_rcu();
> +		input_unregister_device(input);
> +	}

[Severity: High]
Could this lead to an AB-BA deadlock between attachment->lock and
the power supply's changed_work cancelation?

When a new message fragment is processed, gip_receive_message() holds
attachment->lock. It might call into gip_reset_metadata(), which triggers
input_unregister_device(). This synchronously releases devres resources,
unregistering the battery power supply and flushing its work queue via
cancel_work_sync().

If the power supply worker thread is simultaneously executing
gip_battery_get_property(), it will attempt to acquire attachment->lock,
creating a deadlock.

[ ... ]

> +static int gip_receive_fragment(struct gip_attachment *attachment,
> +	const struct gip_header *header, int offset,
> +	uint64_t *fragment_offset, uint16_t *bytes_remaining, uint8_t *bytes,
> +	int num_bytes)
> +{
[ ... ]
> +		attachment->in_fragment_data =3D devm_kmalloc(to_gip_device(attachment=
),
> +			attachment->in_total_length, GFP_KERNEL);
> +		if (!attachment->in_fragment_data)
> +			return -ENOMEM;

[Severity: High]
Does this error path leave the attachment in an inconsistent state?

If the allocation fails, the function returns -ENOMEM but leaves
attachment->in_fragment_message set to a valid message type. A subsequent
non-initial fragment matching the type would pass validation and call
memcpy() into the NULL in_fragment_data pointer.

[ ... ]

> +		if (*fragment_offset !=3D attachment->in_fragment_offset) {
[ ... ]
> +			if (header->length && *fragment_offset !=3D attachment->in_total_leng=
th) {
> +				gip_warn_ratelimited(attachment,
> +					"Received out of sequence fragment: claimed %llu, expected %d\n",
> +					*fragment_offset, attachment->in_fragment_offset);
> +				gip_acknowledge(attachment, header,
> +					attachment->in_fragment_offset,
> +					attachment->in_total_length - attachment->in_fragment_offset);
> +				return -EPROTO;
> +			}
> +			gip_dbg_ratelimited(attachment,
> +				"Received erroneous final fragment offset, proceeding anyway\n");
> +			*bytes_remaining =3D 0;
> +		} else if (*fragment_offset + header->length > attachment->in_total_le=
ngth) {
> +			gip_warn(attachment,
> +				"Received too long fragment, %llu exceeds %d\n",
> +				*fragment_offset + header->length, attachment->in_total_length);
> +			gip_fragment_failed(attachment, header);
> +			return -EINVAL;
> +		} else {
> +			*bytes_remaining =3D attachment->in_total_length -
> +				(*fragment_offset + header->length);
> +		}
> +		if (header->length !=3D 0)
> +			memcpy(&attachment->in_fragment_data[*fragment_offset],
> +				&bytes[offset], header->length);

[Severity: High]
Can this logic result in a heap buffer overflow?

If a device provides *fragment_offset =3D=3D attachment->in_total_length and
header->length > 0, the first if block is evaluated. Since it exits the
block without returning, it skips the else if bounds check entirely and
proceeds to memcpy(), writing header->length bytes past the end of the
heap allocation.

[Severity: High]
Is there a missing bounds check for non-initial fragments?

For initial fragments (GIP_FLAG_INIT_FRAG), the driver checks if
header->length > num_bytes - offset. However, for non-initial fragments,
this validation appears to be missing before calling memcpy(). This allows
the device to specify a header->length larger than the actual received
packet, reading adjacent kernel heap memory into in_fragment_data.

[ ... ]

> +	cancel_delayed_work_sync(&attachment->in_fragment_timeout);
> +	schedule_delayed_work(&attachment->in_fragment_timeout, HZ);
> +
> +	return rc;
> +}

[Severity: High]
Can this lead to an AB-BA deadlock with the work function?

gip_receive_fragment() is called from gip_receive_message() while holding
attachment->lock. It then calls cancel_delayed_work_sync(). If the delayed
work gip_fragment_timeout() is currently executing, it will attempt to
acquire attachment->lock, deadlocking the system.

[ ... ]

> +static int gip_receive_message(struct gip_device *device, uint8_t *bytes,
> +	int num_bytes)
> +{
[ ... ]
> +	is_fragment =3D header.flags & GIP_FLAG_FRAGMENT;
> +	attachment_index =3D header.flags & GIP_FLAG_ATTACHMENT_MASK;
> +	attachment =3D gip_ensure_attachment(device, attachment_index);
> +
> +	print_hex_dump_debug(KBUILD_MODNAME ": Received message: ",
> +		DUMP_PREFIX_OFFSET, 16, 1, bytes, num_bytes, false);
> +
> +	guard(mutex)(&attachment->lock);

[Severity: High]
Does gip_ensure_attachment() need to be checked for an ERR_PTR return?

If memory allocation within gip_ensure_attachment() fails, it returns
ERR_PTR(-ENOMEM). Blindly calling guard(mutex)(&attachment->lock) with
an ERR_PTR will trigger a kernel panic.

[ ... ]

> +static int gip_init_output(struct gip_interface *intf,
> +	struct usb_endpoint_descriptor *ep_out)
> +{
[ ... ]
> +		intf->out_queue[i].data =3D usb_alloc_coherent(udev, intf->mtu, GFP_KE=
RNEL,
> +			&intf->out_queue[i].urb->transfer_dma);
> +
> +		if (!intf->out_queue[i].data) {
> +			return -ENOMEM;
> +			goto err_free_urbs;
> +		}

[Severity: High]
Does the early return cause a memory leak on the error path?

The code executes return -ENOMEM; immediately, bypassing the goto statement.
This bypasses the err_free_urbs cleanup logic, leaking all URBs and buffers
allocated in previous loop iterations.

[ ... ]

> +static int gip_probe(struct usb_interface *intf, const struct usb_device=
_id *id)
> +{
[ ... ]
> +	gip =3D devm_kzalloc(&udev->dev, sizeof(*gip), GFP_KERNEL);
> +	if (!gip)
> +		return -ENOMEM;
> +
> +	gip->udev =3D udev;
> +	gip->data.device =3D gip;

[Severity: High]
Are devres allocations incorrectly tied to the parent USB device?

The structure is allocated using devm_kzalloc(&udev->dev, ...). Since a
usb_driver is bound to the usb_interface, its devres allocations must be
tied to &intf->dev. Because they are tied to the parent device, unbinding
the driver via sysfs does not trigger devres cleanup, permanently leaking
memory until the physical device is unplugged.

[ ... ]

> +	rc =3D gip_interface_init(&gip->data);
> +	if (rc) {
> +		devm_kfree(to_gip_device(gip), gip);
> +		return rc;
> +	}
> +	/* Don't init audio interface -- we aren't using it yet */
> +
> +	usb_set_intfdata(intf, gip);
> +
> +	/* Pre-create the first attachment, as it should always exist */
> +	attachment =3D gip_ensure_attachment(gip, 0);
> +	if (IS_ERR(attachment))
> +		return PTR_ERR(attachment);
> +
> +	return 0;
> +}

[Severity: High]
Are we leaking the running URB if gip_ensure_attachment() fails?

The call to gip_interface_init() submits urb_in. If ensuring the first
attachment subsequently fails, the function returns without killing the
active URB. When the hardware interrupt fires, the USB core will attempt
to access the freed gip structure.

[ ... ]

> +static int gip_shutdown(struct gip_device *device)
> +{
[ ... ]
> +	for (i =3D 0; i < MAX_ATTACHMENTS; i++) {
> +		struct gip_attachment *attachment =3D device->attachments[i];
> +		struct input_dev *input;
> +
> +		if (!attachment)
> +			continue;
> +
> +		scoped_guard (mutex, &attachment->lock) {
> +			cancel_delayed_work_sync(&attachment->metadata_next);
> +			cancel_delayed_work_sync(&attachment->in_fragment_timeout);

[Severity: High]
Does this scoped_guard introduce a deadlock?

The scoped_guard acquires attachment->lock, and then calls
cancel_delayed_work_sync(). If the work functions (gip_retry_metadata or
gip_fragment_timeout) are running concurrently, they attempt to acquire
this same lock, causing an AB-BA deadlock during driver shutdown.

[ ... ]

> +static void gip_disconnect(struct usb_interface *intf)
> +{
[ ... ]
> +	usb_kill_urb(gip->data.urb_in);
> +	if (gip->audio.intf)
> +		usb_kill_urb(gip->audio.urb_in);
> +
> +	gip_shutdown(gip);
> +
> +	spin_lock_irqsave(&gip->message_lock, flags);
> +	gip_deinit_input(&gip->data);
> +	gip_deinit_output(&gip->data);

[Severity: High]
Should the active OUT URBs be killed before de-initializing output?

Only the IN URBs are killed via usb_kill_urb() prior to cleanup.
gip_deinit_output() frees the URBs and their DMA buffers via
usb_free_coherent(). If the host controller is actively transmitting
these buffers, it will cause DMA corruption and crash the USB core.

[Severity: High]
Is it safe to call usb_free_coherent() while holding a spinlock?

gip_deinit_input() and gip_deinit_output() invoke usb_free_coherent()
to free DMA buffers. This function can involve TLB flushes and IOMMU
operations that may sleep. Calling it while holding gip->message_lock
and with interrupts disabled violates atomic context rules.

[ ... ]

> +	for (i =3D 0; i < MAX_ATTACHMENTS; i++) {
> +		struct gip_attachment *attachment =3D gip->attachments[i];
> +
> +		if (!attachment)
> +			continue;
> +
> +		gip_reset_attachment(attachment);
> +
> +		devm_kfree(to_gip_device(attachment), attachment->uniq);
> +		devm_kfree(to_gip_device(attachment), attachment);
> +	}
> +
> +	devm_kfree(to_gip_device(gip), gip);
> +}

[Severity: High]
Can explicit freeing of the attachment cause a Use-After-Free?

The attachment memory is explicitly freed here via devm_kfree(). However,
the LED and Battery devices were registered with &input->dev as their
devres parent. If userspace holds the input device open, devres cleanup
is delayed. A subsequent sysfs modification to the LED state will invoke
gip_guide_led_set(), which dereferences the freed attachment structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D1
