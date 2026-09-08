Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4634572B
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839086; cv=none; b=dSmRN+kUm7zHCScI45qNiz/QGjYITmBet+95A0WAzQNHT3QZIQxNZ2F/EU2Jnbk2YkDON+Kumn7Ol5YRPgyHEsr1lq6MCTUYnhFBetGlQ46ZcFbT3bx67LJj5aKhaxC97wSChLyknLFWYHVOcmAHyWTFiRoeigUDjLmtFzxyvpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839086; c=relaxed/simple;
	bh=GhF5+hd/q10p1YK6uX+30rW4MeDm2NzzMOy3t8AW39w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bKeMJXbd6TzGpqPoS4Xsuot8lcwPe0dtEWZiYE7iAuUtz87KTDgGMkMnis9ORxb92J4srxT+2wq5eQr6khSMjz9V0jjNwiG9NXrtbN5HycdFrjYMu0lxqiKvubD4F/FNfGPo+U55+WS4fbHJPZULYqB6Mrt4XuP8J+2jX0Vfm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i78Gakf8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i78Gakf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8181F00A3A;
	Tue,  8 Sep 2026 03:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788839075;
	bh=jzYdmRRSXWm3hvOsqXj5eHykEZMixq5PDTRUdQWQPJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i78Gakf8ljAHCnHV8IdUVeWJXUTd4fXG7aqQi62HrhYwzyP/k852DRxwuD82iAuNo
	 1j2kf0KYuY+5mOxA71n/+oL6aGZQovTyl17iHuImMem1sys0PPwL8q1qByK9ZkXyvd
	 xGMy3nKsV7V+FdZk+YuQkW1VM8QoMbqonCa11JZERyRdHjtWL2eUXpYxQFa9t354N7
	 cS8oE5Jn3HSWuZY2ScIGCBxpnCIp2mqXwowXaULBsFVxkgKaY+5gWKFA46SIZbjnrb
	 +oLahxiQifsnIzIPgHkrUn+XWiu2IpCVZdZra2IokUVxg6yz4t2/3edHAbybHLRfyH
	 1wC4ODMujCk8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/12] Input: xbox_gip - Add new driver for Xbox GIP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908032145.2118234-2-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:44:34 +0000
Message-Id: <20260908034435.4E8181F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] Incorrect teardown ordering in `gip_disconnect()` leaves pending `=
receive_message` work, causing a UAF.
- [High] Missing synchronous cancellation of `out_fragments` and `security`=
 works during driver teardown.
- [High] Input devices are forcefully destroyed and recreated across system=
 suspend/resume.
- [High] Use-After-Free in LED and Power Supply sysfs handlers due to devre=
s lifetime mismatch.
- [High] URB input processing does not loop over packed messages and passes=
 incorrect payload lengths.
- [High] Missing `cancel_delayed_work_sync` in `gip_probe` error path leads=
 to use-after-free of attachment memory.
- [High] Functions returning negative error codes are declared with a `bool=
` return type, causing silent failures.
- [Medium] Unreachable cleanup code in `gip_init_output` error path leaks U=
RBs and DMA buffers.
- [Medium] Devm-managed `input_dev` is leaked on dynamic device reset.
- [Medium] Concurrent modification of `attachment->seq_vendor` without hold=
ing `attachment->lock`.
- [Low] Mixing `guard()` scope-based cleanup with `goto`-based error handli=
ng in `gip_send_raw_message`.
--

commit 28d6048d8c164794e1dada5c80d56b8de14979e0
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add new driver for Xbox GIP

This patch introduces a new driver for the Xbox One/Series controller proto=
col,=20
known as the Gaming Input Protocol. It implements proper support for messag=
e=20
length parsing, fragmented messages, and metadata auto-detection. The drive=
r=20
is designed to allow for future expansion to specialized device types and=20
additional features.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 0e23811a6ecc1..0000000000000 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

> @@ -391,5 +391,5 @@ static uint8_t gip_sequence_next(struct gip_attachmen=
t *attachment,
>  		}
>  	} else {
>  		seq =3D attachment->seq_vendor++;

[Severity: Medium]
Can this modification to the shared sequence state race with other callers?

Calling gip_send_vendor_message() from softirq context, like in gip_play_ef=
fect(),
increments attachment->seq_vendor without holding attachment->lock. This mi=
ght
race with other message senders executing in process context and cause corr=
upted
sequence numbers.

[ ... ]

> @@ -533,5 +533,5 @@ static void gip_free_fragment(struct gip_out_fragment=
 *fragment)
>  {
>  	cancel_delayed_work(&fragment->timeout);

[ ... ]

> @@ -3142,5 +3142,5 @@ static void gip_shutdown(struct gip_device *device)
> =20
>  		guard(mutex)(&attachment->lock);
>  		gip_reset_attachment(attachment);

[Severity: High]
Does this non-synchronous cancellation allow the fragment timeout work to s=
urvive
driver teardown?

Because gip_reset_attachment() invokes gip_free_fragment() while holding
attachment->lock, a concurrently executing gip_out_fragment_timeout() will =
block
trying to acquire the same lock.=20

Since cancel_delayed_work() does not wait for the blocked work to finish, t=
he=20
work item could resume after gip_disconnect() frees the attachment structur=
e,=20
leading to a use-after-free.

[ ... ]

> @@ -677,5 +677,5 @@ static int gip_send_raw_message(struct gip_attachment=
 *attachment,
> =20
>  	guard(spinlock_irqsave)(&attachment->device->message_lock);

[ ... ]

>  	return rc;
> =20
>  err_free_fragment:
>  	if (fragment)
>  		gip_free_fragment(fragment);
>  	return rc;
>  }

[Severity: Low]
Does this mix guard scope-based cleanup with goto error handling?

The cleanup subsystem guidelines recommend avoiding goto-based cleanup labe=
ls
in the same function that uses guard declarations, as it creates confusing
ownership and resource lifecycle semantics.

[ ... ]

> @@ -1151,5 +1151,5 @@ static int gip_parse_message_metadata(struct device=
 *dev,
> =20
>  static bool gip_parse_metadata(struct device *dev,
>  	struct gip_metadata *metadata, const uint8_t *bytes, int num_bytes)
>  {

[ ... ]

>  	if (offset >=3D num_bytes)
>  		goto parse_err;

[ ... ]

>  parse_err:
>  	gip_metadata_free(dev, metadata);
>  	return rc;
>  }

[Severity: High]
Can this function return a false success on error conditions?

The function is declared with a bool return type but uses and returns negat=
ive
error codes like -EINVAL and -ENOMEM. If the offset bounds check is hit, rc=
 is
exactly 0, causing the function to return false (0).=20

Upstream callers like gip_handle_command_hello_device will implicitly cast =
this
to success, proceeding to use the freed metadata structure and risking=20
out-of-bounds accesses.

[ ... ]

> @@ -1388,5 +1388,5 @@ static int gip_guide_led_probe(struct gip_attachmen=
t *attachment, struct device
>  		if (!rc)
>  			rc =3D devm_led_classdev_multicolor_register(dev,
>  				mc_cdev);

[ ... ]

> @@ -1473,5 +1473,5 @@ static int gip_battery_create(struct gip_attachment=
 *attachment, struct device *
> =20
>  	attachment->battery =3D devm_power_supply_register(dev,
>  		&attachment->battery_desc, &supply_config);

[ ... ]

> @@ -3183,5 +3183,5 @@ static void gip_disconnect(struct usb_interface *in=
tf)
> =20
>  		devm_kfree(to_gip_device(attachment), attachment->uniq);
>  		devm_kfree(to_gip_device(attachment), attachment);
>  	}

[Severity: High]
Is there a lifetime mismatch between the devres-managed sysfs interfaces and
the attachment structure?

The battery and LED class devices are registered using the input device
dev pointer as the devres owner. However, the attachment structure, which
is used as the driver data for these callbacks, is explicitly freed via
devm_kfree() in gip_disconnect().=20

If a userspace process holds an open file descriptor on the input event nod=
e,=20
the input device memory and devres cleanup callbacks are deferred, leaving=
=20
dangling pointers that can be dereferenced by userspace sysfs reads or writ=
es.

[ ... ]

> @@ -1602,5 +1602,5 @@ int gip_setup_input_device(struct gip_attachment *a=
ttachment)
>  		return 0;
> =20
>  	input =3D devm_input_allocate_device(to_gip_device(attachment));
>  	if (!input)

[ ... ]

> @@ -1861,5 +1861,5 @@ static void gip_free_devices(struct gip_attachment =
*attachment)
> =20
>  	if (input)
>  		input_unregister_device(input);

[Severity: Medium]
Will this leak the devm-managed input device during a dynamic reset?

The input device is allocated with devm_input_allocate_device(), tying its
memory to the USB interface. When the device is reset dynamically, such as =
upon
receiving a new hello message, gip_reset_attachment() calls gip_free_device=
s()
and unregisters the device.=20

Because the memory is devm-managed, it is not freed until the parent USB de=
vice
unbinds, resulting in a memory leak on every internal reset.

[Severity: High]
Also, does this forcefully destroy and recreate input devices across system=
=20
suspend?

When the system suspends, gip_suspend() calls gip_shutdown(), which invokes
gip_reset_attachment() and gip_free_devices(). This unregisters the input d=
evice,
completely destroying the node.=20

Applications will receive an EPOLLHUP and lose the controller permanently u=
ntil=20
restarted. Standard input drivers typically persist the input device across=
=20
suspend and only pause I/O.

[ ... ]

> @@ -1902,5 +1902,5 @@ static void gip_reset_attachment(struct gip_attachm=
ent *attachment)
>  	cancel_delayed_work(&attachment->metadata_next);
>  	cancel_delayed_work(&attachment->in_fragment_timeout);

[ ... ]

> @@ -3108,5 +3108,5 @@ static int gip_probe(struct usb_interface *intf, co=
nst struct usb_device_id *id)
>  	if (rc) {
>  		gip_reset_attachment(attachment);
>  		gip_reset_metadata(attachment);
> =20
>  		devm_kfree(to_gip_device(attachment), attachment->uniq);
>  		devm_kfree(to_gip_device(attachment), attachment);

[Severity: High]
Does this non-synchronous cancellation in the probe error path allow the
metadata work item to access freed memory?

If gip_interface_init() fails, gip_reset_attachment() uses cancel_delayed_w=
ork()
for metadata_next, and then the attachment memory is immediately freed by
devm_kfree().=20

If the delayed work was scheduled, such as for devices with the GIP_QUIRK_N=
O_HELLO=20
quirk, it could execute concurrently and access the freed attachment struct=
ure.

[ ... ]

> @@ -2801,5 +2801,5 @@ static int gip_receive_message(struct gip_device *d=
evice, uint8_t *bytes,
>  		guard(mutex)(&attachment->lock);
>  		num_bytes -=3D offset;
>  		bytes +=3D offset;
>  		fragment_offset =3D header.length;
>  		if (header.flags & GIP_FLAG_ACME)
>  			gip_acknowledge(attachment, &header, fragment_offset, bytes_remaining=
);
>  		rc =3D gip_handle_message(attachment, &header, bytes, num_bytes);

[Severity: High]
Does this code fail to handle multiple packed messages and pass incorrect=20
payload lengths?

For non-fragmented messages, the function passes the entire remaining buffe=
r size
(num_bytes) to gip_handle_message() instead of the actual payload size defi=
ned by
header.length. It also lacks a loop to process subsequent messages in the t=
ransfer.

Because Xbox controllers often pack multiple messages or include trailing p=
adding,
strict length validation checks in downstream handlers will fail, causing v=
alid
messages to be dropped.

[ ... ]

> @@ -2977,6 +2977,5 @@ static int gip_init_output(struct gip_interface *in=
tf,
>  		intf->out_queue[i].data =3D usb_alloc_coherent(udev, intf->mtu, GFP_KE=
RNEL,
>  			&intf->out_queue[i].urb->transfer_dma);
> =20
>  		if (!intf->out_queue[i].data) {
>  			return -ENOMEM;
>  			goto err_free_urbs;
>  		}

[Severity: Medium]
Will this unreachable cleanup code leak URBs and DMA buffers on failure?

The return statement is placed immediately before the goto err_free_urbs la=
bel,
making the cleanup path completely unreachable if the coherent allocation f=
ails.

[ ... ]

> @@ -3157,5 +3157,5 @@ static void gip_disconnect(struct usb_interface *in=
tf)
>  		return;
> =20
>  	gip_shutdown(gip);
> =20
>  	usb_kill_urb(gip->data.urb_in);

[Severity: High]
Does the teardown ordering here leave a window for a use-after-free?

Calling gip_shutdown() invokes cancel_work_sync(&device->receive_message).=
=20
However, usb_kill_urb() is not called until after gip_shutdown() returns.=20

In that window, the hardware can complete a pending URB, triggering gip_urb=
_in(),=20
which will successfully reschedule the receive_message work item. After=20
gip_disconnect() completes and frees the gip_device structure, the pending=
=20
work will execute and dereference the freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D1
