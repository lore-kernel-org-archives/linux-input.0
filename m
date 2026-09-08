Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449F343897
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838764; cv=none; b=LXDTHiACQ2xDW0+7MrKCpyQpKjyeaJKSNDK/K6qWaInvsOd0s36d12ZVgrrhHoeBRarRsgBY7d7Fsc0O14KFPRSN1+B6nqKxuOczcxXncZe130upBEy1CFLcPUa8gzXPAO79Z3bJWJ+HXvicHDGvdSClpNdfi7bOwHfRcRYpEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838764; c=relaxed/simple;
	bh=CwhJ8gC/lcd13MNzV5dBFhzXnd/4vzOR7wlyePfXj1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YaBFz6UMFtVlWkqTCO3vB54X3JIS9gDD1+5Sn8t3snuXtaCPny7LHp13T5+jtekyaxi6bClXjbZkOovQjHcIm+8fkW927PygTJPmwbXOCQVv4FJ2jcpH8xxrqjA0nnA6eecanY0Kv57JbtMtzAX3vUxYIV+koTLPMmf5FWfs7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAZb8asp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAZb8asp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A431F00A3D;
	Tue,  8 Sep 2026 03:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788838736;
	bh=4Zoef3SrOot9EWOztkbYK2bMpKkRfmSPjs5sNjodDGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAZb8aspwrvrU2hYBtGn0AlD5P1AS+97K40dsc90jwNoLKWVpj7KKxby/Z4sI/Fts
	 WOSv7x2us8MnsKURU3YLndp+Cw78Hv+0YxqPK1GyaArjJ1y+cIdb5e6E5zDyNu0Q6r
	 vZfB2vF/p4unzndrd3WUoOEDRNKzlGcQeHa497b1vl2gAkNFAfv1Bz5BDr1z7NjpJr
	 lHuvIekkhroh4Fb+3o3PDBtsnywYZdQJ2NC5J7DxcgjFZ9eCUerxeFs9CyxhdgM6Ub
	 JI54VDjZn/DIxf3hIxVfY2ATLI28TRYhjM68q0HgXGa6rQxHj6U9RMVvAFYvgspGMh
	 QQU9lt5+tYfgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/12] Input: xbox_gip - Add security implementation
 from xone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908032145.2118234-8-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-8-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:38:55 +0000
Message-Id: <20260908033856.25A431F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Asynchronous cancellation of security workers leads to Use-After-F=
ree on disconnect. A naive synchronous fix would cause a deadlock.
- [High] The security transcript incorrectly hashes USB transport padding f=
or unfragmented messages, causing handshake failures.
- [Medium] Unselectable Kconfig dependency on hidden symbol CRYPTO_LIB_SHA2=
56.
- [Medium] Out-of-bounds read when processing unexpectedly short security m=
essages.
- [Medium] Sensitive cryptographic secrets are not cleared from stack and h=
eap memory.

Pre-existing issues:
- [High] Preexisting Use-After-Free in out_fragment timeout handlers due to=
 missing synchronous cancellation.
--

commit e5c6e1be1aac0ee61bba5f91bea05c7f0f89796f
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add security implementation from xone

This patch imports and adapts the security message implementation from the
out-of-tree xone driver. This message is necessary for most controllers that
use wireless dongles.

> diff --git a/drivers/input/joystick/gip/Kconfig b/drivers/input/joystick/=
gip/Kconfig
> --- a/drivers/input/joystick/gip/Kconfig
> +++ b/drivers/input/joystick/gip/Kconfig
> @@ -5,6 +5,7 @@
>  config JOYSTICK_XBOX_GIP
>  	tristate "Xbox One/Series controller support"
>  	depends on USB && USB_ARCH_HAS_HCD && LEDS_CLASS_MULTICOLOR
> +	depends on CRYPTO_ECDH && CRYPTO_LIB_SHA256 && CRYPTO_RSA

[Severity: Medium]
Is depends on CRYPTO_LIB_SHA256 intentional here?

CRYPTO_LIB_SHA256 is a hidden tristate symbol without a prompt, meaning use=
rs
won't be able to select JOYSTICK_XBOX_GIP via menuconfig unless another
driver accidentally selects CRYPTO_LIB_SHA256 first.

Should this use select CRYPTO_LIB_SHA256 instead?

[ ... ]

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> @@ -1932,7 +1922,6 @@ static void gip_reset_attachment(struct gip_attachm=
ent *attachment)
>  	}
> =20
>  	gip_free_devices(attachment);
> -
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
involving out_fragments during shutdown.

When the controller is unplugged, the teardown path calls
gip_reset_attachment(), which loops through out_fragments and calls
gip_free_fragment(). However, gip_free_fragment() uses the non-blocking
cancel_delayed_work().

If the out_fragment timeout worker is running, it will block on
guard(mutex)(&attachment->lock). After the disconnect path finishes and
frees the attachment, the worker could unblock and access the freed memory.

[ ... ]

> diff --git a/drivers/input/joystick/gip/gip-security.c b/drivers/input/jo=
ystick/gip/gip-security.c
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-security.c
[ ... ]
> +static void gip_security2_exchange_ecdh(struct work_struct *work)
> +{
> +	struct gip_security *security =3D container_of(work, typeof(*security),=
 work_exchange_ecdh);
> +	struct gip_attachment *attachment =3D container_of(security, struct gip=
_attachment, security);
> +	struct gip_security2_host_pubkey message =3D {};
> +	u8 random[GIP_SECURITY_RANDOM_LEN * 2];
> +	u8 secret[GIP_SECURITY2_SECRET_LEN];

[Severity: Medium]
Does this leave the derived hashed ECDH shared secret on the stack?

The 32-byte secret is allocated here but never explicitly cleared with
memzero_explicit() before the function returns.

> +	int err;
> +
> +	guard(mutex)(&attachment->lock);

[Severity: High]
Can this lock acquisition cause a use-after-free if the controller is
disconnected during a handshake?

When gip_disconnect() triggers shutdown, it acquires attachment->lock and
calls gip_security_release(), which uses the non-blocking cancel_work() on
these security workers.

If this worker is running, it blocks here. After the teardown path completes
and frees the attachment via devm_kfree(), this worker would unblock and
access the freed memory. (Note that simply switching to cancel_work_sync() =
in
gip_security_release() while holding the mutex might deadlock).

[ ... ]
> +int gip_security_handle_message(struct gip_security *security, const voi=
d *bytes, int num_bytes)
> +{
> +	const struct gip_security_header_handshake *handshake =3D bytes;
> +	const struct gip_security_header_full *hdr;
> +	int err;
> +
> +	if (security->status !=3D GIP_SECURITY_SENT) {
> +		gip_err(security, "%s: security message received when none expected: 0=
x%02x\n",
> +			__func__, handshake->command);

[Severity: Medium]
Could this dereference handshake->command out-of-bounds?

We haven't verified that the payload length num_bytes is at least
sizeof(*handshake) before trying to read the command field for this error
message.

A malformed USB message might cause an out-of-bounds read and information
disclosure in the kernel log.

> +		return -EPROTO;
> +	}
> +
> +	if (num_bytes < sizeof(*handshake))
> +		return -EINVAL;
> +
[ ... ]
> +	err =3D gip_security_dispatch_message(security, hdr->data.command,
> +		bytes + sizeof(*hdr), num_bytes - sizeof(*hdr));
> +	if (err)
> +		return err;
> +
> +	sha256_update(&security->transcript, bytes + sizeof(hdr->handshake),
> +		num_bytes - sizeof(hdr->handshake));

[Severity: High]
Does the transcript hash include trailing padding bytes?

The core receive path in gip_receive_message() passes num_bytes (the full
USB packet length minus header offset) to gip_handle_message() without
truncating it to header.length.

If the USB host controller pads the interrupt transfer packet, these traili=
ng
padding bytes will be included in the sha256_update() call here, causing the
handshake to fail.

[ ... ]
> +void gip_security_release(struct gip_security *security)
> +{
> +	if (security->status < GIP_SECURITY_SENT)
> +		return;
> +
> +	cancel_work(&security->work_exchange_rsa);
> +	cancel_work(&security->work_exchange_ecdh);
> +	cancel_work(&security->work_complete);
> +
> +	memzero_explicit(&security->transcript, sizeof(security->transcript));

[Severity: Medium]
While the transcript is explicitly cleared here, should we also zero out the
long-term session keys (security->pms and security->master_secret)?

Leaving these on the heap could lead to a leak of cryptographic secrets if
combined with an out-of-bounds read vulnerability.

> +
> +	security->status =3D GIP_SECURITY_PENDING;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D7
