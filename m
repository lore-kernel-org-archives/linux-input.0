Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708295;
	b=AceP05dMQgy8DZ+agN56tjQVdVya4n4wpHY86MJskJj/KMOO07+U6BGZOpjzXlVjxGSJ
	 dk7OrEKKfxa562c1AjtYILPqsG3O9JGGUSzBfdh7CQInvk+qf5lGmJowzoyWeaDjSE1xq
	 vTydxhJFUUNKrYVMnnZDlaPhB89V6qopB5TL0QmjKPBrM+bOWQdMGrm3EOBhFbIJ2HBwW
	 YZgaVTCs3AEFS47167nq92ZhxyptR+nnj3hXBfIPLt3aomfA9XcmRsgoSQBYitKk6brhR
	 PyH8dP2CR+Sa54Bdxjr02wLdzXyzyJrz5il/oJcvN1GEP8mH2CXQnpHxuFiqRKZeEBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708295;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B1WwCGuVbeY82praMeWc/+ACDP7ru0LaXrl/EZpDpRI=;
	b=N6Ltifa0nmCCZj38dPcb9qyQhhvomP8TNhigerEGOHfHFmGPxmjc7g4N6KOrko8QKY3I
	 9YTlD/HRBLnWFsC7MqvPb23gig6asebDSfrDC4YLNg/yDhSEnZyBaYHZvMxCI2thpowrp
	 kPBM/a82IoEikqLEXYJk1424V1ya3blp0dPdxrGx6+FepQRQR9/8sk70xoeau2xdlTtSJ
	 +RSQa0/9328cX8q+Y5arElw4QMMGa7/wt1txGD9B5RXH+DgM3Id/boFGdi0zBedABTcDX
	 Ozl+YaemaY8/6frsK1zlci+ljt4w2GyXTVD8e7b+7yWlCNAglasLcN7KocfjONDTthg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYMyBBmu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048AD606A327
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYMyBBmu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DBC1F000C4;
	Sun, 15 Nov 2026 02:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794708294;
	bh=B1WwCGuVbeY82praMeWc/+ACDP7ru0LaXrl/EZpDpRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DYMyBBmuaZKG2Cvdmpdk9Sky0JCqDgOzHhvQOU7C795JQzjdMZwvQX3joX3ZZ0TAS
	 hfE9OgXK/pn+ekDa7tE2on4zcGE6kYFVOqsn4TgW49RRC2sDmWISmqKNpIK1QRgZ3+
	 wZEkb7GaaNozFCOxcoFM1ETwMe2Qa2py7M8wi9BOqHAXH/JVAZtLrkBeuS3wH6Lo0k
	 uuBxKiprQPsbJ6RxOO80c1EQglGchyBOahoXIYSb0zSUPIaH4/NeuUfFTpst/fNT0t
	 5HclxmDkWFolwTLJW0WIeFLDfe2gB+ya6AEu/paB5j3gWAaIptV/lOfaOqSl4ED/8H
	 qkGWCh7w5izRg==
Message-ID: <sashiko-outbox-215182@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13] Input: xpad - overhaul device data for wireless
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261115015219.476559-3-sanjay.govind9@gmail.com>
References: <20261115015219.476559-3-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 02:04:53 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] Input: xpad: suppressed error in xpad_inquiry_pad_capabilities()
--

commit 5282eadaef0f6daaa8a82974e8e887e15c4815b3
Author: Sanjay Govind <sanjay.govind9@gmail.com>

Input: xpad - overhaul device data for wireless devices

This commit updates Xbox 360 wireless controller discovery to populate
input device names and IDs from link and capabilities reports, deferring
registration until capabilities arrive or a 500ms timeout expires.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index d2eb48d98fead..46290197dbd1a 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -1488,6 +1688,31 @@ static int xpad_inquiry_pad_presence(struct usb_xp=
ad *xpad)
>  	return xpad_try_sending_next_out_packet(xpad);
>  }
> =20
> +static int xpad_inquiry_pad_capabilities(struct usb_xpad *xpad)
> +{
> +	struct xpad_output_packet *packet =3D
> +			&xpad->out_packets[XPAD_OUT_CAPS_IDX];
> +	static const u8 caps_inquiry[] =3D {
> +		0x00, 0x00, 0x02, 0x80, 0x00, 0x00,
> +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +	};
> +	int error;
> +
> +	guard(spinlock_irqsave)(&xpad->odata_lock);
> +
> +	packet->len =3D sizeof(caps_inquiry);
> +	memcpy(packet->data, caps_inquiry, packet->len);
> +	packet->pending =3D true;
> +
> +	error =3D xpad_try_sending_next_out_packet(xpad);
> +
> +	/*
> +	 * The failed submission may have been for another pending packet.
> +	 * Only report an error if the capabilities request was dropped.
> +	 */
> +	return packet->pending ? 0 : error;
> +}

[Severity: Low]
Does returning 0 when packet->pending is true mask a failed submission in
xpad_try_sending_next_out_packet()?

xpad_try_sending_next_out_packet() only calls usb_submit_urb() when
xpad->irq_out_active is false, so a non-zero error means no output URB is
in flight to drain the ring.  If an earlier slot in xpad->out_packets was
prepared first and its usb_submit_urb() failed, packet->pending remains
true here, causing xpad360w_process_packet() to wait for the 500ms
discovery timeout instead of finishing immediately, and leaving a stale
capabilities request pending in out_packets[XPAD_OUT_CAPS_IDX].

If error is non-zero, should packet->pending be cleared and error returned
unconditionally?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115015219.4765=
59-3-sanjay.govind9@gmail.com?part=3D1
