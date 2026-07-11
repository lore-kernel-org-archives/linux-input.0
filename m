Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7B391836
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776415; cv=none; b=gvsOeodKlW+kgTz41JcvFjOovASFlmK0wLv49o72H0UyJwcj0/oeFu9K3BDj0cf4jG/tecN3t3N5RXNBH/7ZNLcKgQHiH0naigxsgRSCG6hlsDkrI/S8jNz2mN1KqSxtV15YKJjIOmf+EAZn2WMg5FMGFFvt506loxkVQtA6CXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776415; c=relaxed/simple;
	bh=U9sNMOoDbCwKYyLrvu4UVtFmwJlobNpfau4cmNJOODE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hgJCX22vTN0w/SiWU6INtk05+bMnl6wmd3ReLyseC+0SCxd2AoITBXTMbKhFH4et9sRAtM/ZaOqnvtRFrolM87smS+pON4dweTuo1CDDi8NX7l5F8DPPT8yyMcFUVAXI7rwnJGdlmOW8RY2zuAldWHGX/jxRZIrPAjgOmo25Ej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY6xosDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY6xosDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEFE1F000E9;
	Sat, 11 Jul 2026 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783776414;
	bh=+Zj26UOQtmioRcFFK5Ln8c1d9zjxuGwZYisO6NeuYTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AY6xosDkVRIBjXoo/8RkE+6HOcKkwPjt8EUTZc4O2BpwZzgkvYhjzlm1QAAWLVXnA
	 80X3QuLXadizjgsNnLz8l3e78pCUIFIqLcEsME2OatqzsyPA+tFCbfleHr6GCcGteW
	 oSaFKmSxrmYY7JrKYwnVf3AfKi/p/P6iYLY8qE86Pq/23vOFDhxE2ta3iWUS622Qov
	 46x49VR3e3hHoHEP2pKL7O7aG1M/hm5gQNXWJunPl86r0aayGSG1/ftPNZrE+XuRxM
	 6WQJyzR7q31RUR6yfkUB41Dp+H8o8LaqQtpiTHXwtfjq35IQIDUBVYePx9fZe0z/kC
	 0FEeBVKH1dARA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] Input: applespi - fix NULL pointer dereference
 in tp_dim open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260711131140.18777-3-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
 <20260711131140.18777-3-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 13:26:53 +0000
Message-Id: <20260711132653.DAEFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsolicited or repeated PACKET_DEV_INFO messages cause multiple to=
uchpad input devices to be allocated and registered, leaking previously reg=
istered ones.
--

--- Patch [2]: [PATCH v5 2/3] Input: applespi - fix NULL pointer dereferenc=
e in tp_dim open ---
commit 083469b928bf6d69e48361fe4f8c93f87f2a7820
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - fix NULL pointer dereference in tp_dim open

The tp_dim debugfs file is registered synchronously during driver probe
in applespi_probe(). However, the applespi->touchpad_input_dev is
initialized and registered asynchronously in the driver's worker thread.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index 3bdb9e7cfb8b2..4d339445e9c71 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -963,12 +963,18 @@ static void applespi_debug_update_dimensions(struct=
 applespi_data *applespi,
>  static int applespi_tp_dim_open(struct inode *inode, struct file *file)
>  {
>  	struct applespi_data *applespi =3D inode->i_private;
> +	struct input_dev *touchpad;
> =20
>  	file->private_data =3D applespi;
> =20
> +	/* Pairs with smp_store_release in applespi_register_touchpad_device() =
*/
> +	touchpad =3D smp_load_acquire(&applespi->touchpad_input_dev);

[Severity: High]
This isn't a bug introduced by this patch, but looking at the worker
thread that sets applespi->touchpad_input_dev, is there a resource leak
if the hardware sends repeated PACKET_DEV_INFO messages?

In applespi_handle_cmd_response(), work is unconditionally scheduled
whenever a PACKET_DEV_INFO packet is received:

drivers/input/keyboard/applespi.c:applespi_handle_cmd_response() {
    ...
    if (packet->device =3D=3D PACKET_DEV_INFO &&
        le16_to_cpu(message->type) =3D=3D 0x1020) {
        /*
         * We're not allowed to sleep here, but registering an input
         * device can sleep.
         */
        applespi->rcvd_tp_info =3D message->tp_info;
        schedule_work(&applespi->work);
        return;
    }
    ...
}

When the worker runs applespi_register_touchpad_device(), it unconditionally
allocates and registers a new input device via devm_input_allocate_device()
and input_register_device(), overwriting the applespi->touchpad_input_dev
pointer.

Because the allocated device is devm managed, the old device and its associ=
ated
character device minor numbers are never unregistered or freed until the SPI
driver unbinds. Does this code need to check if the touchpad device is alre=
ady
initialized before allocating and registering a new one to prevent exhausti=
ng
system memory?

> +	if (!touchpad)
> +		return -ENODEV;
> +
>  	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
>  		 "0x%.4x %dx%d+%u+%u\n",
> -		 applespi->touchpad_input_dev->id.product,
> +		 touchpad->id.product,
>  		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
>  		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
>  		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711131140.1877=
7-1-fourdollars@debian.org?part=3D2
