Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4372EEE65
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366367; cv=none; b=r5nnSdqbJTHO34WJaY5Vc//S9gteilpu8oG3ryZpQdWsMo/MAUevIAOEzJEeE05MP7JntamCnLeVc2N4FOk3zHuZ5PUJ5586dDh3+QEP4abkFFD1EAy351MEV/ESfamENPyAvHYfmqpcw5IgJWNxDN2Ac3sRju1qIp8L4t+uhZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366367; c=relaxed/simple;
	bh=lmcYCG2q4HyjbQcVcpfhAkzVYq7pPM1w9tPhTXX3IGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e8A53Mons+PL4SrZDToUDPgqzFTbXoA5zZwPsMioSsdU1locgocm7xfGH/CiVR/bbBdKYP7qFvWa4YKydQblVnap5ItncNZ+wtu0aapgPNWk/ig2oDnMoL5fQ5mnj8fmy8BghMFALIoLm4FOi8xqyvqhkJhDxu/umMP4Hk7a6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTu34oIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTu34oIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887CF1F000E9;
	Sat, 22 Aug 2026 02:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787366365;
	bh=TOszeTQMscQey4bgbB8ldZ55zuNcwEaWXdozCJq6Aa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BTu34oIuBbIej8w1uJJB0AxknHTEgJxWYNsvoGrwmYBVVg4gxW4Hg37MQmuyxpLOE
	 Y2WmFvwzTW4dBq1BX+2T+TniYhV6OL4cD+dAhEZu8EOWIjp2y7/R5gXBdjQ1s89o9R
	 co7yOOVrbOJwtpvp+sLpSAWoWdaDYKA1Pqj6TbZ2z57ItUDmA4lwItV1mfzL+O3sk5
	 jzhGD5lZHRrpZ1H0lTj8wPbOtO5fhA3lntRhS7GWNNhB40SmhKUIIaLhXq0VChaWPh
	 Gs8azb8CfBCtLPA7EY0WFKe0fT/cdf0TYhT8WHK+xDvmYvcyFwljB+rO1uxYKbOxeg
	 fDUhLx4C1+nhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/12] Input: xbox_gip - Allow sending fragmented and
 ACME messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822021140.1149546-7-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-7-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:39:25 +0000
Message-Id: <20260822023925.887CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:

New issues:
- [Critical] Missing cancellation of `send_fragment` work and OUT URBs caus=
es Use-After-Free during driver teardown.
- [High] Missing NULL check for `devm_kmalloc` allocation in `gip_send_raw_=
message`.
- [High] Unsynchronized allocation of `out_fragments` slots in `gip_send_ra=
w_message` leads to a TOCTOU race condition.
- [High] Fragment slots and memory are permanently leaked on output queue f=
ull or URB submission failures.
- [High] Unprotected read-modify-write of the `intf->has_pending_out` bitma=
sk causes data races.
- [High] Broken search logic in `gip_find_fragment` completely ignores exac=
t sequence numbers when `strict` is true.
- [High] Fragment slots for ACME messages permanently leak if the device dr=
ops the packet.
- [Medium] Improper use of managed resources (`devm_kmalloc`) for high-freq=
uency, dynamic per-message buffers.

Pre-existing issues:
- [High] AB-BA deadlock in `gip_shutdown` when canceling delayed works.
- [High] gip_receive_fragment() blindly trusts header->length when processi=
ng subsequent fragments, leading to an out-of-bounds read from the kernel h=
eap.
- [High] gip_receive_fragment() can dereference a NULL pointer if devm_kmal=
loc fails and the fragmented message sequence continues.
--

--- Patch [6]: [PATCH v4 06/12] Input: xbox_gip - Allow sending fragmented =
and ACME messages ---
commit 945e1fae94cb61e149c842cf10c67d06095eaf41
Author: Vicki Pfau <vi@endrift.com>
Subject: Input: xbox_gip - Allow sending fragmented and ACME messages

This patch adds support for sending messages that exceed the length of the =
MTU
using a fragmented message flow. It also supports sending messages requiring
ACME acknowledgments, which will be necessary for future security flows.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index d694ac5516395..a75fbcb1c02dc 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> @@ -479,6 +486,48 @@ static void gip_handle_quirks(struct gip_attachment =
*attachment)
> +static struct gip_out_fragment *gip_find_fragment(struct gip_attachment =
*attachment,
> +	uint8_t message_type, uint8_t flags, uint8_t seq, bool strict)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MAX_OUT_FRAGMENTS; i++) {
[ ... ]
> +		}
> +
> +		return &attachment->out_fragments[i];
> +	}
> +
> +	for (i =3D 0; i < MAX_OUT_FRAGMENTS; i++) {
> +		if (!attachment->out_fragments[i].active)
> +			continue;
> +		if (attachment->out_fragments[i].message !=3D message_type)
> +			continue;
> +		if ((attachment->out_fragments[i].flags ^ flags) & GIP_FLAG_SYSTEM)
> +			continue;
> +
> +
> +		return &attachment->out_fragments[i];
> +	}

[Severity: High]
Does this second loop bypass the sequence number check entirely when strict=
 is
true? If a strict search fails in the first loop, falling through to this o=
ne
might unconditionally return a fragment that matches the type but has the w=
rong
sequence number, potentially misrouting packets.

[ ... ]
> @@ -486,20 +535,25 @@ static int gip_send_raw_message(struct gip_attachme=
nt *attachment,
[ ... ]
> +	if (num_bytes > reduced_mtu ||
> +		(flags & (GIP_FLAG_ACME | GIP_FLAG_FRAGMENT)) =3D=3D GIP_FLAG_ACME) {
> +		for (i =3D 0; i < MAX_OUT_FRAGMENTS; i++) {

[Severity: High]
Are fragment slots permanently consumed if an ACME message is sent but the
device drops the packet and never ACKs it? Since there doesn't appear to be=
 a
timeout or cleanup mechanism for pending fragments, a couple of dropped pac=
kets
might permanently exhaust the queue.

> +			if (attachment->out_fragments[i].active)
> +				continue;
> +
> +			fragment =3D &attachment->out_fragments[i];
> +			break;
> +		}
> +
> +		if (!fragment) {
> +			gip_err(attachment, "Fragmented message queue is full; dropping messa=
ge\n");
> +			return -EALREADY;
> +		}
> +
> +		fragment->active =3D true;

[Severity: High]
Can multiple threads race to claim the same fragment slot here? This loop a=
nd
the subsequent assignment to fragment->active appear to occur without holdi=
ng
attachment->lock or device->message_lock.

> +		fragment->message =3D message_type;
[ ... ]
> +		fragment->data =3D devm_kmalloc(to_gip_device(attachment),
> +			fragment->total_length, GFP_ATOMIC);
> +		fragment->fragment_offset =3D 0;
> +		memcpy(fragment->data, bytes, num_bytes);

[Severity: High]
Could this memcpy dereference a NULL pointer if the devm_kmalloc allocation
fails? The GFP_ATOMIC flag means the allocation can fail under memory
pressure, but there is no check before accessing the returned pointer.

[Severity: Medium]
Is devm_kmalloc the right choice for dynamic, per-message buffers? Since
devm_kfree requires a linear scan of the device's devres linked list under a
spinlock, frequent allocations and frees here might cause noticeable overhe=
ad
and list fragmentation. Would standard kmalloc and kfree be better suited?

[ ... ]
> @@ -522,15 +659,10 @@ static int gip_send_raw_message(struct gip_attachme=
nt *attachment,
[ ... ]
>  	for (i =3D 0; i < MAX_OUT_MESSAGES && !urb; i++) {
>  		if (!intf->out_queue[i].urb)
>  			continue;
>  		if (!intf->out_queue[i].urb->anchor)
>  			urb =3D &intf->out_queue[i];
>  	}
>  	if (!urb) {
>  		gip_err(attachment, "Output queue is full; dropping message\n");
>  		return -ENOSPC;
>  	}
[ ... ]
> +	rc =3D usb_submit_urb(urb->urb, GFP_ATOMIC);
> +	if (rc) {
> +		dev_err(&intf->intf->dev,
> +			"%s - usb_submit_urb failed with result %d\n",
> +			__func__, rc);
> +		usb_unanchor_urb(urb->urb);
> +		rc =3D -EIO;
> +	}

[Severity: High]
If the function returns early due to a full output queue (-ENOSPC) or a fai=
lure
in usb_submit_urb() (-EIO), does the fragment slot remain permanently activ=
e?
It looks like the allocated memory and the active slot aren't freed on these
error paths.

[ ... ]
> +static int gip_send_next_fragment(struct gip_attachment *attachment,
> +	struct gip_out_fragment *fragment)
> +{
[ ... ]
> +	if (fragment->fragment_offset =3D=3D fragment->total_length) {
> +		if ((fragment->message & GIP_DATA_CLASS_MASK) =3D=3D GIP_DATA_CLASS_AU=
DIO)
> +			intf =3D &attachment->device->audio;
> +		else
> +			intf =3D &attachment->device->data;
> +
> +		next_bytes =3D 0;
> +		intf->has_pending_out &=3D ~gip_fragment_id(attachment, fragment);

[Severity: High]
Is it safe to perform an unprotected read-modify-write on intf->has_pending=
_out
here? In gip_send_raw_message(), this same bitmask is modified while holding
the message_lock spinlock. Concurrent modifications could lead to a data ra=
ce
and cause the driver to lose track of pending output.

[ ... ]
> @@ -2476,6 +2771,7 @@ static void gip_urb_out(struct urb *urb)
>  	switch (status) {
>  	case 0:
>  		/* success */
> +		schedule_work(&intf->send_fragment);
>  		break;

[Severity: High]
Could this result in a use-after-free during driver teardown?

If gip_disconnect() frees the out_queue URBs using usb_free_urb() instead of
usb_kill_urb(), in-flight URBs might complete after the device structures a=
re
freed. The completion handler here would then schedule the send_fragment wo=
rk
using a freed intf context.

[ ... ]

A few additional observations in the surrounding codebase:

> static void gip_shutdown(struct gip_device *gip)
> {
[ ... ]
>       scoped_guard (mutex, &attachment->lock) {
>               cancel_delayed_work_sync(&attachment->metadata_next);
>               cancel_delayed_work_sync(&attachment->in_fragment_timeout);

[Severity: High]
This isn't a bug introduced by this patch, but could this cause an AB-BA
deadlock? gip_shutdown() acquires attachment->lock before waiting synchrono=
usly
on these works, but the callbacks for both works (gip_retry_metadata() and
gip_fragment_timeout()) begin by acquiring the same attachment->lock.

> static int gip_receive_fragment(...)
> {
[ ... ]
>       if (header->length !=3D 0)
>               memcpy(&attachment->in_fragment_data[*fragment_offset],
>                       &bytes[offset], header->length);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to blindly trust
header->length here? There doesn't appear to be a check ensuring that
offset + header->length <=3D num_bytes (the actual size of the received USB
packet). A malicious device could send a short packet with a large length f=
ield,
potentially causing an out-of-bounds read from the kernel heap.

> static int gip_receive_fragment(...)
> {
[ ... ]
>       attachment->in_fragment_message =3D header->message_type;
>       ...
>       attachment->in_fragment_data =3D devm_kmalloc(to_gip_device(attachm=
ent),
>               attachment->in_total_length, GFP_KERNEL);
>       if (!attachment->in_fragment_data)
>               return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does an allocation failure l=
eave
the state inconsistent? By updating in_fragment_message before a failing
devm_kmalloc(), a subsequent fragment from the device might pass the message
type check and blindly memcpy into a NULL in_fragment_data pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D6
