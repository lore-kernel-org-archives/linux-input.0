Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218CDF72
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134534; cv=none; b=AIfJQCpSZGZU/WeYIScjUUtIrHp6svRfzZt+GlG9zH6ruhO4WY7jjJ5rhlBLE/iQCbs4/VNifCw09y4+GO7wcbZiW2CNNnYOlV4vJMEnbTf5hhnvWeuWmVxXcUQARUeHT4eYOS22nTlDa3lShGmXCJoim/TOWiLz2pRq/PzPMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134534; c=relaxed/simple;
	bh=ilZZ3whotYbXUtMwFlPo3L+tvk+92ZZCEIpwLcZdJHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BbN0dxaqa3oXdFqE3y9hREPdeSUMZdAy61WzAmxio+4LY0W0P6YawRxd6YCae8P8QgSMFgQ+nzciNh/VYQ988H1YzXKncfVGtrHeUWvzH+6ymHL92YGuHOieu5xvCKhPpJMG9aFqMyasnf5bRWCLkHtfLoa/XFxzTxoDiTuT1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dySxJQoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dySxJQoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6425B1F00ACA;
	Mon, 31 Aug 2026 00:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134532;
	bh=Bt7Eh2KFpLiS5OZP9DRmYYOVQQXtSANfPKspuEotqN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dySxJQoJ3DhQJwuqCKNq8j/i9kP6ANKyczM0T5gHUd9uXMPlbWunAUavVszE6nAiX
	 VXOYklbrS+VxAlPX+y/bnWICIm/5TzfXmAriRpFqwpeSLw5POrwpfF80v5yRGoXdsT
	 cgO9zFLif8dlXPt/YSLt+1ehcDcj7VSvrKE5cKhVHVLETfnIKygd1sZtqg8IRc1ctw
	 yn3Vo44pQMHalecCsphwzFa3E0rKSDywIN4xbS1jvgdbAbjVQLfwYAa3+qnJyjmt5J
	 EvES4Ze5UCd+F/yBNwj2HEIOOtSwgUMPoTV/4Yiq06PHq9WYydP7V/RrPe4iy5DI6g
	 6QtBVi6yF6rRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] HID: asus: add support to force feedback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830234320.114356-11-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-11-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 00:02:12 +0000
Message-Id: <20260831000212.6425B1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent execution of the config interface probe/resume and game=
pad interface unbind causes a use-after-free on HID hardware resources.
--

commit b62ad34c16f335dc9dd774f0d7548d234839ba8d
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add support to force feedback
   =20
    Unlike ROG ally the X version and following ones uses DInput protocol
    and the force feedback needs to be implemented as its protocol is
    vendor-specific, therefore add support for FF_RUMBLE with magnitude
    scaling on a work-queue based approach to avoid using possibly
    sleeping calls in atomic context.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index bd488acdb5d49..61330ae082b16 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2756,19 +2912,43 @@ static int ally_x_setup_input(struct hid_device *=
hdev, struct ally_handheld *all
> =20
>  	return 0;
>  ally_x_setup_input_err:
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	if (ally->ally_x_hdev =3D=3D hdev)
> +		ally->ally_x_hdev =3D NULL;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
>  	return ret;
>  }
> =20
>  static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handh=
eld *ally)
>  {
> +	struct hid_device *x_hdev;
>  	struct ally_config *cfg;
> +	unsigned long flags;
>  	int ret;
> =20
> -	/* Failure at this point is non-critical */
> -	ret =3D ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
> -				       sizeof(ALLY_FORCE_FEEDBACK_OFF));
> -	if (ret < 0)
> -		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> +	/*
> +	 * The force-feedback "off" packet belongs to the gamepad interface,
> +	 * which consumes it as an output report: the config interface probed
> +	 * here would reject it. The gamepad probe path sends the packet itself,
> +	 * so this only matters when the gamepad interface is already bound,
> +	 * e.g. after a reset resume that re-initialized the MCU.
> +	 */
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	x_hdev =3D ally->ally_x_hdev;
> +	if (x_hdev)
> +		get_device(&x_hdev->dev);
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	if (x_hdev) {
> +		/* Failure at this point is non-critical */
> +		ret =3D ally_x_send_ff_off(ally, x_hdev);

[Severity: High]
Can this cross-device call cause a use-after-free on transport data structu=
res?

While taking a reference to x_hdev->dev with get_device() prevents the
struct hid_device memory from being freed, does it stop the peer's
transport resources from being torn down?

If the configuration interface probes or resumes concurrently with the
gamepad interface being unbound (e.g., via sysfs or a reset/disconnect cycl=
e),
it appears the transport driver could destroy the transport driver data once
hid_destroy_device() returns, while we are still holding the device referen=
ce.
Would the subsequent call to hid_hw_output_report() via ally_x_send_ff_off()
then dereference that freed memory?

> +
> +		if (ret < 0)
> +			hid_err(hdev, "Ally failed to init force-feedback off: %d\n",
> +				ret);
> +
> +		put_device(&x_hdev->dev);
> +	}
> =20
>  	cfg =3D ally_get_config(ally);
>  	if (!cfg)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D10
