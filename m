Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011821DC198
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311989; cv=none; b=MVgrkVxdyG+1orFlhIy3MGQU6Oo5MbvJV0oBuBjuYjUkHg27vaLDbY/7Ag7KiVYJ1NgFmOgFtZPOS7n6smx1TAwyRD3RFPWn8zvmB906s7wJEt1dZid7u9FTI6WA3zWtZdOTp25o1D9X2NODUCNkQm4nXZYEnoOIVGgMpGXwQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311989; c=relaxed/simple;
	bh=TquPLuHA6yONnd/uJHH2rgxI3AsnNpj0zHfr5J0FjI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NKXRC1/8OpQ9roMJBt0TT2lo8iYnCNHOCtOCioqhY1tJgeQEb4VNfTW6xlEGLbvthyV62L2lyX2S+PloeADUjw3ZddtRjoMcaT6u5qO2bMhQcWbZ011cwow6CX67V+bl1/81GMVfNs5MS6dPlof3z3Lbw0hqVnQJJ7eo2zVB+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5DKZgOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5DKZgOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5607D1F000E9;
	Wed,  2 Sep 2026 01:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788311987;
	bh=Nqi+b1SCxHsavnrjDyW99fEeNIeiQWeGDIKoHXleJlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5DKZgOAeAhQWtRrGeqBkwcvxeihzF2XYYBze9yMFFEauT/IsfNX6Kf5sToU4qcn0
	 WF5nG9OWqLLxYYx80ptCe9DtWt0D1LBF2bJo84QF+rAB4HzRDk6iNGYd2wxttXsyF9
	 B01c+vfve3Hi7ufrAA9UOzlvWze0H6zt3Xlo4Vahd67LPF5FqDB7iiKiFdqTaBP88n
	 6UTz+rXl7uAOOJ866yBhNJ1LHBjEwqt6lfD2ClWjH02fDtYWxpaAdUqIWgnLFhYfZM
	 U1CBj5VUXPdUfXThDIrUW/DspFK1XMLiIuyc96D8UOyH2LnBA5HikshfaUu60xoNfi
	 kVB8ei9s2Wn3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/12] Input: xbox_gip - Allow sending fragmented and
 ACME messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902010237.865772-7-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
 <20260902010237.865772-7-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:19:46 +0000
Message-Id: <20260902011947.5607D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Unconditional dereference of NULL fragment pointer on error pa=
th for non-fragmented messages.
- [High] Missing synchronization when allocating and initializing `out_frag=
ments` slots.
- [High] Unsynchronized read-modify-write of the `intf->has_pending_out` bi=
tmask.
- [High] Dropped ACKs permanently leak `out_fragments` slots.
--

commit 317888ee9cccdc0f09f7f1c8d616d2664382777a
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Allow sending fragmented and ACME messages

This commit introduces support for sending fragmented messages that exceed =
the
MTU length and messages requiring ACKs using the ACME flag in the GIP proto=
col.
It adds queuing, processing, and acknowledgment handling logic to the xbox_=
gip
driver.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 57d638408daf4..544becf8badd6 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> +static void gip_free_fragment(struct gip_out_fragment *fragment)
> +{
> +	kfree(fragment->data);
> +	memset(fragment, 0, sizeof(*fragment));
> +}
[ ... ]
>  static int gip_send_raw_message(struct gip_attachment *attachment,
>  	uint8_t message_type, uint8_t flags, uint8_t seq, const uint8_t *bytes,
>  	int num_bytes)
> @@ -486,20 +529,25 @@ static int gip_send_raw_message(struct gip_attachme=
nt *attachment,
>  	struct gip_interface *intf;
>  	int offset =3D 3;
>  	struct gip_urb *urb =3D NULL;
> +	struct gip_out_fragment *fragment =3D NULL;
>  	int i;
>  	int rc =3D 0;
[ ... ]
> +	if (num_bytes > reduced_mtu ||
> +		(flags & (GIP_FLAG_ACME | GIP_FLAG_FRAGMENT)) =3D=3D GIP_FLAG_ACME) {
> +		for (i =3D 0; i < MAX_OUT_FRAGMENTS; i++) {
> +			if (attachment->out_fragments[i].active)
> +				continue;
> +
> +			fragment =3D &attachment->out_fragments[i];
> +			break;
> +		}

[Severity: High]
Does this code have a missing synchronization issue?

The fragment slot is claimed and initialized locklessly here. If concurrent
callers (like force feedback workers, sysfs, or incoming message handlers)
pick the same inactive slot, could this lead to double-allocation (a memory
leak) and state corruption?

> +
> +		if (!fragment) {
> +			gip_err(attachment, "Fragmented message queue is full; dropping messa=
ge\n");
> +			return -EALREADY;
> +		}
> +
> +		fragment->data =3D kmalloc(num_bytes, GFP_KERNEL);
> +		if (!fragment->data)
> +			return -ENOMEM;
> +		fragment->active =3D true;

[Severity: High]
Can these out_fragments slots permanently leak if ACKs are dropped?

When an outgoing message requires an ACK, the slot is marked active here and
relies entirely on a device-initiated ACK to be freed. Because there is no
timeout mechanism, if the device drops the message or fails to respond, cou=
ld
the slot remain locked forever? Since MAX_OUT_FRAGMENTS is only 2, a couple
of dropped packets might permanently exhaust the queue.

[ ... ]
>  	guard(spinlock_irqsave)(&attachment->device->message_lock);
>  	for (i =3D 0; i < MAX_OUT_MESSAGES && !urb; i++) {
>  		if (!intf->out_queue[i].urb)
[ ... ]
> +	if (fragment) {
> +		/*
> +		 * Sending further fragments is handled in gip_urb_out if this fragmen=
t doesn't need
> +		 * ACKing or in gip_handle_command_protocol_control if it does. The fl=
ag should also
> +		 * be cleared if we're done sending this packet.
> +		 */
> +		if (fragment->total_length > reduced_mtu && !(flags & GIP_FLAG_ACME))
> +			intf->has_pending_out |=3D gip_fragment_id(attachment, fragment);
> +		else
> +			intf->has_pending_out &=3D ~gip_fragment_id(attachment, fragment);
>  	}
> =20
>  	return rc;
> +
> +err_free_fragment:
> +	gip_free_fragment(fragment);
> +	return rc;
> +}

[Severity: Critical]
Does this error path unconditionally dereference a NULL pointer?

If gip_send_raw_message() is called for a standard, non-fragmented message,
the fragment pointer remains NULL. If the output queue is full or
usb_submit_urb() fails, the function jumps to err_free_fragment and calls
gip_free_fragment().

Since gip_free_fragment() unconditionally accesses fragment->data and calls
memset(fragment, ...), won't this immediately crash the kernel when fragment
is NULL?

[ ... ]
> +static int gip_send_next_fragment(struct gip_attachment *attachment,
> +	struct gip_out_fragment *fragment)
> +{
> +	struct gip_interface *intf;
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
Is there an unsynchronized read-modify-write data race here?

Here in gip_send_next_fragment(), intf->has_pending_out is updated without
holding message_lock. However, as seen in gip_send_raw_message(), this shar=
ed
bitmask is also modified under message_lock.

Could concurrent updates to this shared variable cause lost updates,
permanently stalling fragment transmission for any attachments whose bits g=
et
lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902010237.8657=
72-1-vi@endrift.com?part=3D6
