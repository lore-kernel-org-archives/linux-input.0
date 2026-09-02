Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED330FC33
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312528; cv=none; b=ONUz4rcnZfqS0aTMpEVWsGwev1Mwe3T2s0Wl3bCHIX20xgke1wXnC6mydyZapGQXuR8hay5EZ17kk7afhHJ2ZLFqWdewNRxl7/x8faNSXplkqMGTd6z7CDezKkBcUMx7sTgck60df/6yrvFuyG60MnU8hs93lKEQMOQhb7VL9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312528; c=relaxed/simple;
	bh=4xMA5IlJu0q9rEiXuWW63nxeYrwxGst5IlXmLYdBD90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZ9g8Y+5mrCVc2k+hG+/5Lsipc/Z2sx5g217bvSyNlIiTDpRtaDQRNrgKqjzN5J+vOwzQ6adSkXOzaGqUhP5tFtvmhKAKrG3S9zT8ixy82cAwOloEf5eCM/N6MVLpENo2cO/DlthiDiGHkDn3/rMyBal1CDIz1j5FgMwUxnRi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAO5BkDX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAO5BkDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09E71F000E9;
	Wed,  2 Sep 2026 01:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312526;
	bh=LdUYrQD85OoNqWFoJV8qBHYRv2bWCyBmHo0i7wpwuco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OAO5BkDXA6ief5iltJTKunjS9p/Qweypvaxwh8A1NG0Dl7WQu2B2TxwMOIQU/bNRt
	 WhZTVoJ1rNanOT+OImNyaFyPqWMPjRJjJ5CsjIDYXPZFl23YjsIbtdv+p1pEYJTeV3
	 5r1IYxgxttQrqYT7B3fArxSa2cdP2uHhrDKuCrt25qPJbmKQiq6NgT1MehgETRmIqE
	 GRNKR/etoG3MYh1YVDIW0Thr5yo6CLu3rMqhTxLR4BjV1X4OdvDH9fNQcq3AJpbg9f
	 M8v7+v8irtJaqQZA/3pA8BeL/NXQ+FOYUuwf992v40yxW7QXYip1M6ffwdpba23ptc
	 AxsARwUNh/66A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/12] Input: xbox_gip - Add new driver for Xbox GIP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902010237.865772-2-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
 <20260902010237.865772-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:28:45 +0000
Message-Id: <20260902012845.E09E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 17 potential issue=
(s) to consider:
- [Critical] Failed `INIT_FRAG` validation leaves state desynchronized, lea=
ding to NULL pointer dereference.
- [Critical] Kernel panic due to NULL pointer dereference in `gip_free_frag=
ment` during error handling.
- [High] Devm allocations bound to `udev->dev` instead of `intf->dev` cause=
 memory leaks.
- [High] System suspend unregisters input devices, breaking userspace file =
descriptors.
- [High] Improper workqueue teardown order relative to URB killing causes U=
se-After-Free.
- [High] Race condition between fragment reception and timeout can incorrec=
tly free a valid fragment buffer.
- [High] Undefined behavior due to unbounded bitwise shift in `gip_decode_l=
ength`.
- [High] Unreachable `goto` cleanup code in interface initialization causes=
 memory leaks on failure.
- [High] Intermediate message fragments fail to advance `fragment_offset`, =
causing an infinite transmission loop.
- [High] Manual `power_supply_unregister` on a `devm`-managed power supply =
causes a double free.
- [High] Missing bounds check in `gip_handle_elite_buttons` leads to an out=
-of-bounds array read.
- [High] Data race on attachment creation during probe leads to duplicate a=
llocation and memory leaks.
- [High] Unprotected state modifications during message transmission cause =
data races.
- [High] Manual `devm_kfree` of attachment in `gip_disconnect` causes UAF w=
hen sysfs callbacks run concurrently.
- [Medium] Early return in `gip_parse_metadata` leaks devres-allocated fiel=
ds.
- [Medium] Anti-pattern: Using devres (`devm_kmalloc`) for per-message data=
 buffers in the hot path.
- [Medium] Buffer overflow in `gip_urb_in` when copying URB data into a fix=
ed 64-byte message queue.
--

commit 6e5a9bf1d68de07f6142d692c36b2ce1b34a0cc6
Author: Vicki Pfau <vi@endrift.com>
Subject: Input: xbox_gip - Add new driver for Xbox GIP

This introduces a new driver for the Xbox One/Series controller protocol,
officially known as the Gaming Input Protocol, or GIP for short. It is
based on the Microsoft GIP spec and provides features like fragmented
message parsing and auto-detection via metadata.

> diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gi=
p/gip.h
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip.h
> @@ -0,0 +1,344 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
[ ... ]
> +static inline struct device *gip_attachment_dev(struct gip_attachment *a=
ttachment)
> +{
> +	return &attachment->device->udev->dev;
> +}

[Severity: High]
Does this helper force all attachment devm allocations to be bound to the U=
SB
device instead of the interface?=20

If devm_input_allocate_device() or devm_kzalloc() use this device pointer,
they will be bound to the parent udev->dev. When the driver is unbound from
the interface (e.g., via sysfs), the devres actions attached to the interfa=
ce
will run, but those attached to the USB device will not, causing a persiste=
nt
memory leak of driver structures and input devices.

> +
> +static inline struct device *gip_interface_dev(struct gip_interface *int=
f)
[ ... ]
> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-core.c
> @@ -0,0 +1,2591 @@
[ ... ]
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
Can this bitwise shift result in undefined behavior?

The while loop is bounded only by num_bytes. If a malicious USB device
sends a packet with 10 or more consecutive bytes having the 0x80 bit set,
offset * 7 will equal or exceed 64, shifting a 64-bit integer out of bounds
and leading to corrupted length parsing.

> +		if (!(byte & 0x80)) {
> +			offset++;
> +			break;
> +		}
> +	}
> +	return offset;
> +}
[ ... ]
> +static uint8_t gip_sequence_next(struct gip_attachment *attachment,
> +	uint8_t command, bool system)
> +{
> +	uint8_t seq;
> +
> +	if (system) {
[ ... ]
> +	} else {
> +		seq =3D attachment->seq_vendor++;
> +		if (!seq)
> +			seq =3D attachment->seq_vendor++;
> +	}
> +	return seq;
> +}

[Severity: High]
Are these shared sequence numbers protected against concurrent modification?

Modifying shared state like seq_vendor without locks could cause data races.
Concurrent attempts to send messages (e.g., from force-feedback rumble
updates and background ACME acks) might race to increment sequence IDs and
cause sequence number duplication. This pattern of unprotected modification
also occurs in gip_send_raw_message when claiming out_fragments slots.

> +
> +static void gip_handle_quirks_array(struct gip_attachment *attachment,
[ ... ]
> +static int gip_send_raw_message(struct gip_attachment *attachment,
> +	uint8_t message_type, uint8_t flags, uint8_t seq, const uint8_t *bytes,
> +	int num_bytes)
> +{
[ ... ]
> +	if (!urb) {
> +		gip_err(attachment, "Output queue is full; dropping message\n");
> +		rc =3D -ENOSPC;
> +		goto err_free_fragment;
> +	}

[Severity: Critical]
Is it possible for error paths in fragment sending to cause a NULL pointer
dereference?

If a fragment pointer is initialized to NULL, and the output queue is full =
or
usb_submit_urb() fails, jumping to an error path that unconditionally calls
memset(fragment, 0, ...) (like in a gip_free_fragment function) would
immediately panic the kernel.

> +	urb->data[0] =3D message_type;
[ ... ]
> +static bool gip_parse_metadata(struct device *dev,
> +	struct gip_metadata *metadata, const uint8_t *bytes, int num_bytes)
> +{
[ ... ]
> +	metadata->num_messages =3D bytes[offset];
> +	offset++;
> +	if (metadata->num_messages > 0) {
> +		metadata->message_metadata =3D devm_kcalloc(dev,
> +			metadata->num_messages,
> +			sizeof(*metadata->message_metadata), GFP_KERNEL);
> +		if (!metadata->message_metadata)
> +			return -ENOMEM;

[Severity: Medium]
Will this early return leak previously allocated devres fields?

If devm_kcalloc fails here, returning -ENOMEM directly bypasses the
parse_err cleanup label, which is responsible for freeing previously alloca=
ted
structures like audio formats and preferred types, causing a persistent mem=
ory
leak.

> +
> +		for (i =3D 0; i < metadata->num_messages; i++) {
[ ... ]
> +static int gip_handle_elite_buttons(struct gip_attachment *attachment,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	bool grip[4] =3D { 0, 0, 0, 0 };
> +	int profile =3D -1;
> +
> +	if (attachment->xbe_format =3D=3D GIP_BTN_FMT_XBE1
> +		&& num_bytes > GIP_BTN_OFFSET_XBE1) {
[ ... ]
> +	} else if ((attachment->xbe_format =3D=3D GIP_BTN_FMT_XBE2_4
> +		|| attachment->xbe_format =3D=3D GIP_BTN_FMT_XBE2_5)
> +		&& num_bytes > GIP_BTN_OFFSET_XBE2) {
> +		int profile_offset;
> +
> +		if (attachment->xbe_format =3D=3D GIP_BTN_FMT_XBE2_4)
> +			profile_offset =3D 15;
> +		else
> +			profile_offset =3D 20;
> +		profile =3D bytes[profile_offset] & 3;

[Severity: High]
Is it possible to encounter an out-of-bounds read here due to insufficient
bounds checking?

For GIP_BTN_FMT_XBE2_5 layouts, profile_offset is set to 20. The preceding
bounds check only validates that num_bytes > 14 (GIP_BTN_OFFSET_XBE2). If a
malicious USB packet arrives with a length of 15 to 20 bytes, reading
bytes[profile_offset] causes an out-of-bounds array access.

> +
> +		if (!profile) {
[ ... ]
> +static struct gip_attachment *gip_ensure_attachment(struct gip_device *d=
evice,
> +	uint8_t attachment_index)
> +{
> +	struct gip_attachment *attachment =3D device->attachments[attachment_in=
dex];
> +
> +	if (!attachment) {
> +		attachment =3D devm_kzalloc(to_gip_device(device), sizeof(*attachment)=
, GFP_KERNEL);

[Severity: High]
Does this attachment creation suffer from a data race during probe?

This uses a check-and-allocate pattern for device->attachments[attachment_i=
ndex]
without locking. If gip_probe starts URB reception before ensuring the
attachment exists, a racing USB packet could trigger the receive worker. Bo=
th
threads could concurrently execute gip_ensure_attachment, allocating multip=
le
instances, causing state corruption and memory leaks.

> +		if (!attachment)
> +			return ERR_PTR(-ENOMEM);
[ ... ]
> +static int gip_receive_fragment(struct gip_attachment *attachment,
> +	const struct gip_header *header, int offset,
> +	uint64_t *fragment_offset, uint16_t *bytes_remaining, uint8_t *bytes,
> +	int num_bytes)
> +{
> +	int rc =3D 0;
> +
> +	if (header->flags & GIP_FLAG_INIT_FRAG) {
> +		uint64_t total_length;
> +
> +		guard(mutex)(&attachment->lock);
> +		if (attachment->in_fragment_message >=3D 0) {
> +			/*
> +			 * Reset fragment buffer if we get a new initial
> +			 * fragment before finishing the last message.
> +			 * TODO: Is this the correct behavior?
> +			 */
> +			devm_kfree(to_gip_device(attachment), attachment->in_fragment_data);
> +			attachment->in_fragment_data =3D NULL;
> +		}
> +		offset +=3D gip_decode_length(&total_length, &bytes[offset],
> +			num_bytes - offset);
> +		if (total_length > MAX_MESSAGE_LENGTH)
> +			return -EINVAL;

[Severity: Critical]
Could this early return leave the state desynchronized if length validation
fails?

If an INIT_FRAG arrives while in_fragment_message >=3D 0, in_fragment_data
is freed and set to NULL. If it then fails the total_length validation, the
function returns early without resetting in_fragment_message. A subsequent
fragment of the same type would skip initialization checks and call memcpy
into the NULL in_fragment_data pointer, causing an immediate kernel panic.

> +
> +		if (header->length > num_bytes - offset) {
[ ... ]
> +		if (header->length > total_length) {
[ ... ]
> +		attachment->in_fragment_data =3D devm_kmalloc(to_gip_device(attachment=
),
> +			total_length, GFP_KERNEL);

[Severity: Medium]
Should devres be used for per-message data buffers in the hot path?

Allocating and freeing dynamic buffers for every fragmented message using
devm_kmalloc and devm_kfree causes performance degradation and lock content=
ion.
Devres is designed for device lifecycle management, not high-frequency data
path allocations.

> +		if (!attachment->in_fragment_data)
[ ... ]
> +		if (*fragment_offset + header->length > attachment->in_total_length) {
[ ... ]
> +		if (header->length !=3D 0)
> +			memcpy(&attachment->in_fragment_data[*fragment_offset],
> +				&bytes[offset], header->length);
> +		*fragment_offset +=3D header->length;
> +		attachment->in_fragment_offset =3D *fragment_offset;
> +
> +		if (header->flags & GIP_FLAG_ACME)
> +			gip_acknowledge(attachment, header, *fragment_offset, *bytes_remainin=
g);
> +		if (header->length =3D=3D 0 && !*bytes_remaining) {
> +			rc =3D gip_handle_message(attachment, header,
> +				attachment->in_fragment_data,
> +				attachment->in_total_length);
> +			devm_kfree(to_gip_device(attachment), attachment->in_fragment_data);
> +			attachment->in_fragment_data =3D NULL;
> +			attachment->in_fragment_message =3D -1;
> +		}
> +	}
> +	cancel_delayed_work(&attachment->in_fragment_timeout);

[Severity: High]
Can this asynchronous cancellation race with the timeout handler?

Because cancel_delayed_work is called outside the attachment->lock, it
can race with gip_fragment_timeout. If the timeout fires and blocks on the
lock while gip_receive_fragment is running, it will acquire the lock right
after the new buffer is installed and wrongfully devm_kfree the actively
used buffer.

> +	schedule_delayed_work(&attachment->in_fragment_timeout, HZ);
> +
> +	return rc;
> +}
[ ... ]
> +static void gip_urb_in(struct urb *urb)
> +{
[ ... ]
> +	spin_lock_irqsave(&gip->message_lock, flags);
> +	if (gip->pending_in_messages >=3D MAX_IN_MESSAGES) {
> +		gip_err(gip, "Input queue is full; dropping message\n");
> +	} else {
> +		message_id =3D (gip->next_in_message + gip->pending_in_messages) % MAX=
_IN_MESSAGES;
> +		message =3D &gip->in_queue[message_id];
> +		gip->pending_in_messages++;
> +		memcpy(message->bytes, intf->in_data, urb->actual_length);

[Severity: Medium]
Might this copy overflow the fixed-size message queue buffer?

message->bytes is hardcoded to 64 bytes (BASE_GIP_MTU). The data is
copied using urb->actual_length without validation against the destination
size. If a quirky USB device returns more than 64 bytes (or if the audio
interface with an MTU of 2048 bytes is ever enabled), this will trigger an
out-of-bounds write and corrupt the in_queue ring buffer.

> +		message->num_bytes =3D urb->actual_length;
> +	}
> +	spin_unlock_irqrestore(&gip->message_lock, flags);
> +	schedule_work(&gip->receive_message);
> +
> +exit:
> +	status =3D usb_submit_urb(urb, GFP_ATOMIC);
[ ... ]
> +static int gip_init_input(struct gip_interface *intf,
> +	struct usb_endpoint_descriptor *ep_in)
> +{
[ ... ]
> +	intf->in_data =3D usb_alloc_coherent(udev, intf->mtu, GFP_KERNEL,
> +		&intf->urb_in->transfer_dma);
> +
> +	if (!intf->in_data) {
> +		return -ENOMEM;
> +		goto err_free_urb;
> +	}

[Severity: High]
Are these goto cleanup paths unreachable?

Returning -ENOMEM directly prevents the cleanup code from executing,
leaking the allocated URB on failure. The same unreachable pattern exists
in gip_init_output for err_free_urbs, where it leaks all previously allocat=
ed
URBs and DMA buffers in the output queue if memory allocation fails mid-loo=
p.

> +
> +	usb_fill_int_urb(intf->urb_in, udev,
[ ... ]
> +static int gip_probe(struct usb_interface *intf, const struct usb_device=
_id *id)
> +{
> +	struct usb_device *udev =3D interface_to_usbdev(intf);
> +	struct gip_device *gip =3D NULL;
> +	struct gip_attachment *attachment;
> +	int rc;
> +
> +	if (intf->cur_altsetting->desc.bInterfaceNumber !=3D GIP_WIRED_INTF_DAT=
A) {
[ ... ]
> +	}
> +
> +	gip =3D devm_kzalloc(&udev->dev, sizeof(*gip), GFP_KERNEL);

[Severity: High]
Should this devm allocation be bound to the interface device (&intf->dev)
instead of the USB device (&udev->dev)?

By binding driver state to the USB device instead of the interface, the mem=
ory
is not freed when the driver unbinds from the interface (e.g., via sysfs).
This causes a persistent memory leak of driver structures and input devices
since devres actions attached to udev->dev will not fire on driver unbind.

> +	if (!gip)
> +		return -ENOMEM;
[ ... ]
> +static void gip_disconnect(struct usb_interface *intf)
> +{
> +	struct gip_device *gip =3D usb_get_intfdata(intf);
> +	int i;
> +
> +	if (!gip)
> +		return;
> +
> +	gip_shutdown(gip);
> +
> +	usb_kill_urb(gip->data.urb_in);

[Severity: High]
Does this workqueue teardown order introduce a Use-After-Free?

gip_shutdown(gip) synchronously cancels the receive workqueue, but the input
URBs are killed afterward. If an input URB completes in the window between
cancel_work_sync and usb_kill_urb, the completion handler gip_urb_in
will reschedule the work again. gip_disconnect will proceed to free the
structures, leading to a UAF when the rescheduled work executes.

> +	usb_kill_anchored_urbs(&gip->data.out_anchor);
[ ... ]
> +	for (i =3D 0; i < MAX_ATTACHMENTS; i++) {
> +		struct gip_attachment *attachment =3D gip->attachments[i];
> +
> +		if (!attachment)
> +			continue;
> +
> +		gip_reset_attachment(attachment);
> +		gip_reset_metadata(attachment);
> +
> +		devm_kfree(to_gip_device(attachment), attachment->uniq);
> +		devm_kfree(to_gip_device(attachment), attachment);
> +	}

[Severity: High]
Can manually freeing the attachment struct cause a UAF with concurrent sysf=
s access?

Since input_dev devres was bound to &udev->dev, sysfs nodes (such as battery
or LED properties) remain active even after unbind. Manually freeing the co=
ntainer
structure here creates a window where a concurrent sysfs read could access =
the freed
attachment structure (e.g., locking the freed battery_lock).

> +
> +	devm_kfree(to_gip_device(gip), gip);
> +}
> +
> +static int gip_suspend(struct usb_interface *intf, pm_message_t message)
> +{
> +	struct gip_device *gip =3D usb_get_intfdata(intf);
> +
> +	if (!gip)
> +		return 0;
> +
> +	usb_kill_urb(gip->data.urb_in);
[ ... ]
> +	if (gip->attachments[0]) {
> +		struct gip_attachment *attachment =3D gip->attachments[0];
> +
> +		guard(mutex)(&attachment->lock);
> +		gip_send_set_device_state(attachment, GIP_STATE_OFF);
> +		attachment->device_state =3D GIP_STATE_OFF;
> +	}
> +
> +	return gip_shutdown(gip);
> +}

[Severity: High]
Is it intended that system suspend destroys the userspace-visible nodes?

Calling gip_shutdown(gip) completely destroys the driver state and uncondit=
ionally
unregisters the input_dev and hid_device via gip_free_devices(). When the
system resumes, these devices are not recreated, permanently breaking any r=
unning
applications holding evdev or hidraw file descriptors.

[Severity: High]
Does intermediate message fragment transmission fail to advance fragment_of=
fset?

If an intermediate fragment is sent, it will not have GIP_FLAG_ACME set, so
the device never sends an ACK, and the fragment might not be marked as acke=
d.
If the offset is only advanced when fragment->acked is true, the driver will
repeatedly resend the identical chunk indefinitely, causing an infinite loop
that stalls transmission for any message exceeding the MTU limit.

[Severity: High]
Can a manual power_supply_unregister on a devm-managed resource cause a dou=
ble free?

If the power supply is created with devm_power_supply_register() and later
manually unregistered in an error path (e.g., if power_supply_powers() fail=
s),
the devres framework remains unaware and will attempt to unregister it again
during teardown, resulting in a double-free kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902010237.8657=
72-1-vi@endrift.com?part=3D1
