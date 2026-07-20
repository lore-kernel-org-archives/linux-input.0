Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1C395AC5
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543569; cv=none; b=rx7PHiqGH5np+0pglEX2lufPcIdjYxNH9jsggNy18UvTDN/MhFHKVXf8nGTg2ym+t0hZhwaue9yicLFNSNCd8HfkTPhkTV+AyV4Ro/kUJBNPySz5AJ+OXI0Thx3R8O1xJe0HU70Nrw/gMzWrWcuUp2n33aBE4nXc3NZx0lT5r10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543569; c=relaxed/simple;
	bh=54YWoozJ3mvu8h93704rFU+cxWQnCEd9BGH96UVQJR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u3UyCzJhucGp3c92A4Y0IfSSGerVpy1rRGKo8487zng26fo4TmrzWkbfrTFR8XvVbpb82DH5TxwZZfhK8BsSBHta5hbgmxdN/+iE3HdyKSxSY7Vn6qubQkU0VJnEyFZHcv/dCGoFa52U+LKS2OHLNUNZPr+eGjPwLswad/49czw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXGLnZyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXGLnZyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D209B1F00A3E;
	Mon, 20 Jul 2026 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784543566;
	bh=mVF7zUCR6C9AK9Z++iSzXoODHocspeWspPoMTkeDcOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VXGLnZyImzO+9Y9vCNroG+G42TAi1/vE2xVudVszXP2j7EzAzRQ4jMcyTykp5/qYh
	 EAfjvWnVqFh/uiOBxgvUmUaCeHWqtJBMnwT6z8p7lXrA04jqTAugJlqBhdmt2i4u8k
	 87riXu/T75M5qb7sm98N7lSLbDkFMLJrOBsAqmnHkGQqgHO7Ikaexj46P9rnrkid7I
	 V4SXYF2RISxXHSm2DTopMObCFURuWAUH+kIJ818wqOJiRLNmQrwVNOHyXCqLWTfp5F
	 T2rs0h3o7IZwheYte2Y10pMzWVnzbNp7mdOcZmTxC4fKv7+7NJwf/wTR2UTO2cbLPJ
	 I3dUfBbj1UXog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] Input: applespi - prefer asynchronous driver
 probing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720101435.13612-5-fourdollars@debian.org>
References: <20260720101435.13612-1-fourdollars@debian.org>
 <20260720101435.13612-5-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:32:45 +0000
Message-Id: <20260720103245.D209B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Failure to cancel in-flight SPI async transfers upon unbind timeou=
t results in use-after-free in completion callbacks.

Pre-existing issues:
- [High] Kernel panic in `applespi_tp_dim_open` due to an unchecked NULL `t=
ouchpad_input_dev` when touchpad initialization times out.
--

--- Patch [4]: [PATCH v2 4/5] Input: applespi - prefer asynchronous driver =
probing ---
commit df316467951827e13575294cf4f7b16d6876f89a
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - prefer asynchronous driver probing
   =20
Set probe_type to PROBE_PREFER_ASYNCHRONOUS to allow the driver core
to run applespi_probe() asynchronously. This improves system boot speeds by
avoiding blocking the main kernel thread during the 3-second touchpad
detection wait.
   =20
Additionally, clean up applespi_tp_dim_open() by simplifying product ID
retrieval and avoiding dereferencing touchpad_input_dev without a helper
variable.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1027,12 +1027,13 @@ static void applespi_debug_update_dimensions(stru=
ct applespi_data *applespi,
>  static int applespi_tp_dim_open(struct inode *inode, struct file *file)
>  {
>  	struct applespi_data *applespi =3D inode->i_private;
> +	struct input_dev *touchpad =3D applespi->touchpad_input_dev;
> =20
>  	file->private_data =3D applespi;
> =20
>  	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
>  		 "0x%.4x %dx%d+%u+%u\n",
> -		 applespi->touchpad_input_dev->id.product,
> +		 touchpad->id.product,

[Severity: High]
This isn't a bug introduced by this patch, but can this dereference a NULL
pointer if the touchpad fails to initialize?

If the 3-second wait in applespi_probe() times out:

applespi_probe() {
    ...
    sts =3D wait_event_timeout(applespi->wait_queue,
                             READ_ONCE(applespi->have_tp_info),
                             msecs_to_jiffies(3000));
    ...
}

Then applespi->touchpad_input_dev is never allocated. However, the
debugfs file is still created unconditionally later in applespi_probe():

debugfs_create_file("tp_dim", 0400, applespi->debugfs_root, applespi,
                    &applespi_tp_dim_fops);

If a user subsequently reads this file, applespi_tp_dim_open() is called
and will dereference the unconditionally NULL touchpad pointer when
retrieving the product ID.

>  		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
>  		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
>  		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);

[ ... ]

> @@ -2015,6 +2016,7 @@ static struct spi_driver applespi_driver =3D {
>  		.name			=3D "applespi",
>  		.acpi_match_table	=3D applespi_acpi_match,
>  		.pm			=3D pm_sleep_ptr(&applespi_pm_ops),
> +		.probe_type		=3D PROBE_PREFER_ASYNCHRONOUS,

[Severity: High]
Does the timeout added in this series for unbinding lead to a use-after-free
if SPI transfers are still active?

In applespi_remove(), the driver attempts to drain in-flight operations:

applespi_remove() {
    applespi_drain_writes(applespi);
    acpi_disable_gpe(NULL, applespi->gpe);
    ...
    applespi_drain_reads(applespi);
    ...
}

These drain functions wait with a 3-second timeout:

applespi_drain_writes() {
    wait_event_lock_irq_timeout(applespi->wait_queue,
                                !applespi->write_active,
                                applespi->cmd_msg_lock,
                                msecs_to_jiffies(3000));
}

If this timeout expires because the hardware is unresponsive, the function
returns and applespi_remove() completes. The devres subsystem then frees
the applespi structure and its DMA-mapped buffers.

When the asynchronous SPI transfer eventually completes, the SPI core invok=
es
applespi_async_complete() with the freed context pointer:

applespi_async_complete() {
    struct applespi_complete_info *info =3D context;
    struct applespi_data *applespi =3D info->applespi;
    ...
    spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
    ...
}

Will this dereference the freed applespi object and corrupt memory?

>  	},
>  	.probe		=3D applespi_probe,
>  	.remove		=3D applespi_remove,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720101435.1361=
2-1-fourdollars@debian.org?part=3D4
