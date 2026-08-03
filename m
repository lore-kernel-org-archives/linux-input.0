Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD17126C17
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785733687; cv=none; b=gzWgsQ/oRqoiXq9swlqTpyR4SN41y6wh9unve287U6gJ5io/pGhlaSUeN36ai3xg56MQybSyCj1K21fjTzLH5R8rBmRgZfJa2lnp1xZH4H6/YldHmL/WV/Jonha1hKUvAxYK+9RJqOtgwfK7FRt61jymvBL9XAO5knB7n+WvvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785733687; c=relaxed/simple;
	bh=Ksmh0X3AXOsoMFGyLhajShCbqFJKKhljM/sRMm+xAvg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C1ZpFpoSkSR94i6BeCQiD5EEnd6GclyQiJZRqHWhEWXGDo3KI2JLY9lAxlVSUoBlvBCqbj+nEX6+KTzCBCGNqdss2W3GspxXIPCno/9AXfu2NyYF5OsWo82+sC7YYuuBIZFs1v73zqT7DzOukQwlPhwKtUWGcs7n3muqnOrw+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kt73gMXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kt73gMXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6702E1F00A3A;
	Mon,  3 Aug 2026 05:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785733685;
	bh=XM9XcDHHvGsqvFtKY/IbtzJBVCFJWzVfbvTcn5OugnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kt73gMXzG7uH/8ePNqNMZ+/4R47+vZGVbGYu3jMgOeFjpUDCPiBRU00VCv2tzQsu7
	 UVqCBZYewf4jeKPW3MlA59WDhmvh5W+r418NRUEIMSg2IheXOqZvbm1OC1Z5aNRt6L
	 Tko+g344sVXxQV8TwBUzzBkaCN76jv95yIXNRStHoOEYYhBV2l0hjDJcB4/CDE0s65
	 RMO7pkJNCnVzBKyDNI8E3JweB1ezyW2E8/GF0Y9kpIZTFNmvbkPxSbygMebGhrqkVN
	 Z5Sa3aoHstiy+VrPXmMkzVW2CFd48lzmY6DwcfdBJJsK/q20/UBPOvu+K3n6cr71B1
	 aqb1ITiiqNTqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: gscps2 - supply PA-RISC keyboard keymap via
 device property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <am_9BvmZu9g4RlUM@google.com>
References: <am_9BvmZu9g4RlUM@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 05:08:04 +0000
Message-Id: <20260803050805.6702E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free in shared interrupt handler during device removal.
- [High] Data race and hardware state corruption due to missing lock in `gs=
cps2_flush()`.
--

--- Patch [1]: [PATCH] Input: gscps2 - supply PA-RISC keyboard keymap via d=
evice property ---
commit a01a8cad369fa3c00ef5c659a70dd84ac7f1e275
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: gscps2 - supply PA-RISC keyboard keymap via device property

This commit modifies the gscps2 PS/2 port driver to attach a software node
with a linux,keymap property to the serio device. This replaces compile-time
architecture-specific keyboard hacks in the generic atkbd driver. It also
moves the keymap definitions to the serio driver and resolves conflicting
keys via a compile-time config.

> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index bf9b993f57330..cd1bca57fda33 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
[ ... ]
> @@ -434,6 +449,9 @@ static void __exit gscps2_remove(struct parisc_device=
 *dev)
>  {
>  	struct gscps2port *ps2port =3D dev_get_drvdata(&dev->dev);
> =20
> +	if (ps2port->id =3D=3D GSC_ID_KEYBOARD)
> +		device_remove_software_node(&ps2port->port->dev);
> +
>  	serio_unregister_port(ps2port->port);
>  	free_irq(dev->irq, ps2port);

[Severity: High]
This is a pre-existing issue, but could this sequence in gscps2_remove() le=
ad
to a use-after-free if a shared interrupt fires?

serio_unregister_port() synchronously disconnects the driver and drops the
reference to the port, freeing the serio structure. However, the device
remains in ps2port_list and the shared IRQ is still active since free_irq()
hasn't been called yet.

If another device on the same shared IRQ line triggers an interrupt during
this window, gscps2_interrupt() will iterate over ps2port_list, find this
port, and call serio_interrupt(ps2port->port, ...).

Since ps2port->port was just freed by serio_unregister_port(), will this
dereference freed memory?

Should the device be removed from ps2port_list and its IRQ disabled via
free_irq() before unregistering the serio port?

>  	gscps2_flush(ps2port);

[Severity: High]
This is also a pre-existing issue, but is there a missing lock in
gscps2_flush() that causes a data race?

Looking at gscps2_flush():

static void gscps2_flush(struct gscps2port *ps2port)
{
        while (gscps2_readb_status(ps2port->addr) & GSC_STAT_RBNE)
                gscps2_readb_input(ps2port->addr);
        ps2port->act =3D ps2port->append =3D 0;
}

This modifies the shared act and append indices and reads hardware registers
without acquiring ps2port->lock.

When gscps2_open() executes, it calls gscps2_reset() which in turn calls
gscps2_flush(). Since the shared IRQ is requested prior to registration, a
concurrent interrupt triggered by another shared device could cause
gscps2_interrupt() to run.

Because gscps2_interrupt() acquires the lock, reads the same registers, and
modifies append via gscps2_read_data(), will this cause non-serialized
hardware access and buffer state corruption?

>  	list_del(&ps2port->node);
>  	iounmap(ps2port->addr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/am_9BvmZu9g4RlUM@go=
ogle.com?part=3D1
