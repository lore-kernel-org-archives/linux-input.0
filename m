Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533B33D6EA
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838807; cv=none; b=QNwWZb444bYXNpP9UP9IgeiYDavJH7U6oDdo/bMuw50kPemcR0duouE6sk3txoYQspDR+ZVZMgXGr7xB1aCmzIDXADpGGDCLjB8iFZgpvEiULoPa6f93gt+w7t7D1TfSQFtnSU8BIQntnsBzywIJPW7tTTGDCJI85lkd/6sNexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838807; c=relaxed/simple;
	bh=hD5Piomo7WrffgVlXJm73rt+pD6/bCBNFq6/fWKdWtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QGcJau6EBdSYQ19C813FHSFW/Y1O2DhXbK2/YTXST+VohBd7KSa1U9T1PI3zipj3SyIWoWBybyzRuGxws2fZVKt4jQxVrMW7kHflkb8SxyXuJNuCel+YhTRFaJ+SvYLTXXp8ln4VPu+zyaaw3F2OjA253h4Js4q06Zze0pPISss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfpD+Rzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfpD+Rzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF4B1F00A3D;
	Tue,  8 Sep 2026 03:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788838772;
	bh=laDL91VkwnT3eH1JnNXIxEpo1yLFaUDh4FWpr2YzjPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YfpD+RzpkNGMyPkLa4Pfdz+z8CGI9VgrZ8d56hcz2Jf+cDi8Pyx8j2mozwKBbWe4S
	 sdyjUy/1S8fI709YTDpsTNgQv4LEgjfk98EqX5nP+SPNoDLZL8oKFrBST10S8lRA5m
	 d/aFUbDt/P/LKeVTDfc0j7/SVzMc/t5nQbmWWWpL2rfAnrWVHn2dAMrdmtonI0lrnt
	 oUBHiTPQ4sQuljjklm4GK1s9OwB+9+S2+2n4OXmU8bqgwM+DvfBdNP5cuLf+UoxVVZ
	 cyHd2HYthLRKe8+xjiVBMByk6kqkNm3AznYa9ATLTaJzJU1gX1TR7cEkJNtbyYX3SQ
	 Bcwo/fw7A2TfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/12] Input: xbox_gip - Allow sending fragmented and
 ACME messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908032145.2118234-7-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-7-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:39:32 +0000
Message-Id: <20260908033932.7DF4B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Missing synchronous cancellation of `out_fragments[i].timeout` dur=
ing device shutdown leads to use-after-free.
- [High] Unprotected lockless access to `out_fragments` state causes data r=
aces, corruption, and potential Use-After-Free.
- [High] Infinite USB transmission loop if the first fragment of a message =
times out.
- [High] The `acked` field of `gip_out_fragment` is not cleared on slot reu=
se, breaking reliable retries.
- [Medium] Stale `has_pending_out` bit in error path causes concurrent chun=
k transmissions.
- [Low] Mixing `goto` error handling with `guard()` cleanup violates subsys=
tem guidelines.
--

commit a080933dee9387ce07bf54626ee39a087371ba35
Author: Vicki Pfau <vi@endrift.com>
Subject: Input: xbox_gip - Allow sending fragmented and ACME messages

This patch implements support for sending fragmented messages and handling =
the
reliable transmission flow (ACME messages). It adds dynamic message allocat=
ion
slots and uses background delayed work to manage ACKs and retry timeouts.

Link: https://lkml.kernel.org/r/target-patch-link

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 568877a4ce4b4..f61b5f18b819a 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

> +static void gip_free_fragment(struct gip_out_fragment *fragment)
> +{
> +	cancel_delayed_work(&fragment->timeout);
> +	kfree(fragment->data);
> +	fragment->data =3D NULL;
> +	fragment->active =3D false;
> +	fragment->message =3D 0;
> +	fragment->flags =3D 0;
> +	fragment->seq =3D 0;
> +	fragment->retries =3D 0;
> +	fragment->total_length =3D 0;
> +	fragment->fragment_offset =3D 0;
> +}

[Severity: High]
Does this code leak the acked state to future messages?

When fragment slots are released, fragment->acked is not cleared here. If a
slot is later reused, it could inherit a stale true value, causing the
timeout retry logic to immediately skip resending lost packets.

[ ... ]

> +		for (i =3D 0; i < MAX_OUT_FRAGMENTS; i++) {
> +			if (attachment->out_fragments[i].active)
> +				continue;
> +
> +			fragment =3D &attachment->out_fragments[i];
> +			break;
> +		}

[Severity: High]
Is it safe to access out_fragments locklessly here?

gip_handle_command_protocol_control() also modifies these fields locklessly.
Scanning and claiming slots concurrently without acquiring attachment->lock
can lead to data races and duplicate slot allocations.

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
> +		fragment->message =3D message_type;
> +		fragment->flags =3D flags & GIP_FLAG_SYSTEM;
> +		fragment->seq =3D seq;
> +		fragment->total_length =3D num_bytes;
> +		fragment->fragment_offset =3D 0;

[Severity: High]
Should fragment->acked be explicitly set to false here?

Since gip_free_fragment() does not clear the acked flag, explicitly setting
it to false here would ensure the new message does not skip retry handling
if the previous message finished successfully.

[ ... ]

>  	guard(spinlock_irqsave)(&attachment->device->message_lock);
>  	for (i =3D 0; i < MAX_OUT_MESSAGES && !urb; i++) {
>  		if (!intf->out_queue[i].urb)
>  			continue;
>  		if (!intf->out_queue[i].urb->anchor)
>  			urb =3D &intf->out_queue[i];
>  	}
>  	if (!urb) {
>  		gip_err(attachment, "Output queue is full; dropping message\n");
> -		return -ENOSPC;
> +		rc =3D -ENOSPC;
> +		goto err_free_fragment;
>  	}

[Severity: Low]
Is it permitted to mix goto error handling with guard() in this function?

The cleanup subsystem guidelines strictly mandate that functions must not m=
ix
goto-based cleanup labels with guard() declarations, as it causes confusing
ownership semantics and resource leaks.

[ ... ]

> +err_free_fragment:
> +	if (fragment)
> +		gip_free_fragment(fragment);
>  	return rc;
>  }

[Severity: Medium]
If usb_submit_urb() fails and we jump to err_free_fragment, does this leave=
 a
stale bit in intf->has_pending_out?

If the has_pending_out bit was previously set from an intermediate chunk
submission, failing to clear it here leaves it active. When a new message
claims this slot, gip_send_fragment_work() could see the stale bit and
prematurely send the new message's second chunk.

[ ... ]

> +static int gip_send_next_fragment(struct gip_attachment *attachment,
> +	struct gip_out_fragment *fragment)
> +{
[ ... ]
> +	} else if (fragment->fragment_offset + mtu >=3D fragment->total_length)=
 {
> +		next_bytes =3D fragment->total_length - fragment->fragment_offset;
> +		flags |=3D GIP_FLAG_ACME;
> +	} else {
> +		next_bytes =3D mtu;
> +	}

[Severity: High]
How does this sequence handle retries for the first chunk?

If the first chunk of a fragmented message times out and this function
retries it, GIP_FLAG_ACME is not appended because it is not the final
fragment. This bypasses the reliable ACME timeout logic, which causes
the worker thread to immediately and repeatedly resend offset 0 without
waiting for ACKs, resulting in an infinite USB transmission loop.

[ ... ]

>  static void gip_reset_attachment(struct gip_attachment *attachment)
>  {
> +	int i;
> +	int pending_out_bits =3D
> +		BIT((attachment->attachment_index + 1) * MAX_OUT_FRAGMENTS) -
> +		BIT(attachment->attachment_index * MAX_OUT_FRAGMENTS);
> +	unsigned long flags;
> +
>  	cancel_delayed_work(&attachment->metadata_next);
>  	cancel_delayed_work(&attachment->in_fragment_timeout);
> =20
>  	if (attachment->in_fragment_data)
>  		gip_free_in_fragment(attachment);
> =20
> +	spin_lock_irqsave(&attachment->device->message_lock, flags);
> +	attachment->device->data.has_pending_out &=3D ~pending_out_bits;
> +	attachment->device->audio.has_pending_out &=3D ~pending_out_bits;
> +	spin_unlock_irqrestore(&attachment->device->message_lock, flags);
> +
> +	for (i =3D 0; i < MAX_OUT_FRAGMENTS; i++) {
> +		if (attachment->out_fragments[i].active)
> +			gip_free_fragment(&attachment->out_fragments[i]);
> +	}
> +
>  	gip_free_devices(attachment);
> +
>  }

[Severity: High]
Could the loop in gip_reset_attachment() introduce a use-after-free during
teardown?

During gip_shutdown(), the device teardown path correctly uses
cancel_delayed_work_sync() for other background workers, but relies on this
loop which uses the non-synchronous cancel_delayed_work() via
gip_free_fragment().

If gip_out_fragment_timeout() is executing and waiting on attachment->lock
during shutdown, it could resume after devres frees the attachment
structure, resulting in a use-after-free.

[ ... ]

>  static int gip_handle_command_protocol_control(struct gip_attachment *at=
tachment,
>  	const struct gip_header *header, const uint8_t *bytes, int num_bytes)
>  {
[ ... ]
> +	fragment->acked =3D true;
> +	fragment->retries =3D 0;
> +	cancel_delayed_work(&fragment->timeout);
> +	if (fragment->flags & GIP_FLAG_FRAGMENT) {
> +		fragment->fragment_offset =3D fragment_offset;
> +		rc =3D gip_send_next_fragment(attachment, fragment);
> +		if (rc < 0)
> +			return rc;
> +	} else {
> +		gip_free_fragment(fragment);
> +	}
> +
> +	return 0;

[Severity: High]
Are modifications to the fragment state thread-safe here without
attachment->lock?

This path modifies fragment->acked and fragment->fragment_offset, and calls
gip_free_fragment() entirely locklessly. Doing so can race concurrently
with gip_out_fragment_timeout() and gip_send_raw_message(), leading to
corrupted fragment offsets or duplicated USB submissions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D6
