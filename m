Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1C3203B4
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312009; cv=none; b=CpynB4Nk7bd8eixnqdvnmgh41LFbCIDUe0o1m/fMD0h3NcwNSIpXZZ6hnPxDS2zvgXZhTpAr5I48DSJjCu826fTWSiSdmM8jnJoaKn2CJowAhuVwhS7tY4tHEJmDhOrt5fMjM9w1vub8wDFkZCzW22dCqjPbb7SjSbeMZkhQAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312009; c=relaxed/simple;
	bh=ecj7bEIa2OT7a9rseQXPtayPIiSehH/Dcs93aU1qfd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovH8XRmJOzLaumwk9qJk+4uSa1TpjEU5bpOx2pHnFZ/PzgXsMLLGH1J1SJVP7ytdYY+OVmPktqVgHQW9QzY8JfJMj5o8D4mDjZv5UdY2/5SS5x8udbvckll1j2/Cw/oBoFFCRb4Ye+Vi2FFUO7oAPpemwWXp09sTFZGZUU3MKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBQwFq1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBQwFq1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5951F000E9;
	Wed,  2 Sep 2026 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312008;
	bh=st5v9KjlPHB4ddzEu2v6tf009HKucqpf9K3aviMwfpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBQwFq1sxs0g7b7TIoSeuxLG8xoglA2EBnqhtx4xUOTR/SxzUjtOyMmPK7OVn2JTU
	 oZv08RHptqXI5mrIiCeIVJPrJo1rsvLrj4Kd8ZRArAiVsawVhIkTg27mDjlZrkHVMg
	 mHD95IrX1szCxZa+F8WR7g9r0u5p/6TOMAt0YvS8WQ9+EFaPyFhV4ml8Ejc3ATFoWb
	 iJFg4wRb7yKHfzbNYlDF114wW9bqBYuiVM3jPRFuf00VvqIOUjY8Bg5o3RMLcf9V2C
	 mj0J/aDEOtxQS/GLtLgak8EgebgPNdmgOGRRAyXBP31e8uaVs0PP2BsRSWp1yqBmJK
	 /zDE7bkb5tXFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/12] Input: xbox_gip - Add security implementation
 from xone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902010237.865772-8-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
 <20260902010237.865772-8-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:20:07 +0000
Message-Id: <20260902012008.1F5951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Stack-allocated buffers are used for cryptographic scatterlists, v=
iolating DMA constraints and causing kernel panics on architectures with vi=
rtually mapped stacks.
- [High] An ABBA deadlock occurs between `attachment->lock` and `cancel_wor=
k_sync()` during device teardown or reset.
- [Medium] The driver utilizes CRYPTO_LIB_SHA256 and CRYPTO_RSA but lacks t=
he required Kconfig declarations, which can lead to build and runtime failu=
res.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but incorrect teardo=
wn order in `gip_disconnect()` allows the URB completion handler to re-queu=
e a work item after it was cancelled, leading to a Use-After-Free.
--

commit 0028f224002448741826a03077075da976d732d6
Author: Vicki Pfau <vi@endrift.com>
Subject: Input: xbox_gip - Add security implementation from xone
   =20
This patch imports and adapts the security message implementation from the
out-of-tree xone driver. This message is necessary for most controllers that
use wireless dongles. The implementation hooks into the xbox_gip driver to
handle security commands.

> diff --git a/drivers/input/joystick/gip/Kconfig b/drivers/input/joystick/=
gip/Kconfig
> index 3422bf84cb895..b933583d325f7 100644
> --- a/drivers/input/joystick/gip/Kconfig
> +++ b/drivers/input/joystick/gip/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  config JOYSTICK_XBOX_GIP
>  	tristate "Xbox One/Series controller support"
> -	depends on USB && USB_ARCH_HAS_HCD && LEDS_CLASS_MULTICOLOR
> +	depends on USB && USB_ARCH_HAS_HCD && LEDS_CLASS_MULTICOLOR && CRYPTO_E=
CDH

[Severity: Medium]
This patch introduces a dependency on CRYPTO_LIB_SHA256 and CRYPTO_RSA (used
in gip-security.c), but these are missing from the Kconfig depends block.
Can this lead to build and runtime failures when compiling without these
crypto options, or when a device requiring the security handshake connects?

>  	help
>  	  Say Y here if you want to use Xbox One and Series controllers with yo=
ur
>  	  computer. Make sure to say Y to "Joystick support" (CONFIG_INPUT_JOYD=
EV)

[ ... ]

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 544becf8badd6..db4d2956e7d9b 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

> @@ -1809,6 +1797,8 @@ static void gip_free_devices(struct gip_attachment =
*attachment)
>  	struct input_dev *input;
>  	struct hid_device *hdev;
> =20
> +	gip_security_release(&attachment->security);
> +

[Severity: High]
This is a pre-existing issue, but the teardown order in the pre-existing
gip_disconnect() function appears to cancel work items before stopping the
USB URB.=20

gip_disconnect() calls gip_shutdown() (which eventually calls
gip_security_release() here), and only afterwards calls usb_kill_urb(). If
the incoming URB completes in this window, it can process messages and
re-queue the cancelled work items (e.g., work_exchange_rsa).

After the device is freed by devres, can the re-queued work item execute and
dereference freed pointers, leading to a Use-After-Free?

>  	if (attachment->driver && attachment->driver->remove)
>  		attachment->driver->remove(attachment);

[ ... ]

> diff --git a/drivers/input/joystick/gip/gip-security.c b/drivers/input/jo=
ystick/gip/gip-security.c
> new file mode 100644
> index 0000000000000..58de547aa1dd1
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-security.c

[ ... ]

> +static int gip_security_ecdh_get_secret(struct crypto_kpp *tfm, u8 *pubk=
ey,
> +	int pubkey_len, u8 *secret, int secret_len)
> +{
> +	struct kpp_request *req;
> +	struct scatterlist src, dest;
> +	DECLARE_CRYPTO_WAIT(wait);
> +	int err;
> +
> +	req =3D kpp_request_alloc(tfm, GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	sg_init_one(&src, pubkey, pubkey_len);
> +	sg_init_one(&dest, secret, secret_len);

[Severity: High]
Does this code use a stack-allocated buffer (secret) for a cryptographic
scatterlist? Passing stack memory to sg_init_one() violates DMA constraints
and can cause a kernel panic/Oops (due to BUG_ON(!virt_addr_valid(buf))) on
architectures with virtually mapped stacks.

> +	kpp_request_set_input(req, &src, pubkey_len);
> +	kpp_request_set_output(req, &dest, secret_len);

[ ... ]

> +static int gip_security_compute_ecdh(u8 *pubkey_in, u8 *pubkey_out, int =
pubkey_len, u8 *secret_hash)
> +{
> +	struct crypto_kpp *tfm_ecdh;
> +	u8 secret[GIP_SECURITY_ECDH_SECRET_LEN] =3D {0};
> +	int err;
> +
> +	tfm_ecdh =3D crypto_alloc_kpp("ecdh-nist-p256", 0, 0);
> +	if (IS_ERR(tfm_ecdh)) {
> +		err =3D PTR_ERR(tfm_ecdh);
> +		goto err_free_secret;
> +	}
> +
> +	err =3D gip_security_ecdh_get_pubkey(tfm_ecdh, pubkey_out, pubkey_len);
> +	if (err)
> +		goto err_free_ecdh;
> +
> +	err =3D gip_security_ecdh_get_secret(tfm_ecdh, pubkey_in, pubkey_len,
> +		secret, sizeof(secret));

[ ... ]

> +static void gip_security_exchange_rsa(struct work_struct *work)
> +{
> +	struct gip_security *security =3D container_of(work, typeof(*security),=
 work_exchange_rsa);
> +	struct gip_attachment *attachment =3D container_of(security, struct gip=
_attachment, security);
> +	struct gip_security_host_secret message =3D {};
> +	u8 random[GIP_SECURITY_RANDOM_LEN * 2];
> +	int err;
> +
> +	guard(mutex)(&attachment->lock);

[ ... ]

> +void gip_security_release(struct gip_security *security)
> +{
> +	if (security->status < GIP_SECURITY_SENT)
> +		return;
> +
> +	cancel_work_sync(&security->work_exchange_rsa);

[Severity: High]
Can this cause an ABBA deadlock during device teardown?

During hot-unplug, gip_shutdown() in gip-core.c acquires attachment->lock
and then calls gip_security_release(), which synchronously waits for the
work item using cancel_work_sync().=20

Simultaneously, the running gip_security_exchange_rsa() work item blocks
trying to acquire the same attachment->lock mutex.

> +	cancel_work_sync(&security->work_exchange_ecdh);
> +	cancel_work_sync(&security->work_complete);
> +
> +	memzero_explicit(&security->transcript, sizeof(security->transcript));
> +
> +	security->status =3D GIP_SECURITY_PENDING;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902010237.8657=
72-1-vi@endrift.com?part=3D7
