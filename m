Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5CD1B87C9
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779514626; cv=none; b=vBrDGBskCzUYHlIyfG2LEwl8oJMIgDD5FH8Nk6wIEIAiklkk42oHQvLstYivFA/2E3COjL3V8uhIZVPMes/SqKlnFiVMI8YOg4bSfUbLgf0t72W/P/Q2o0hdsmBH8zbeuVlvMkULQWtuWH5OahXF6+kLplbTwQ8ixrlPKAFJZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779514626; c=relaxed/simple;
	bh=yZYhqgTACCwPqPpy/8FbEdH8NLvLCCJ1zIikMkFqVxQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uyxMqgDXpxS+clwnMiQ/XKhN+mm8mb3NPz5vDhTa1der2zZ17o9hce2E5LCsTMvDWOuXteb5/+SjNYyupUF9MzbhsinmitvbXYEJu8w9aovTH+gj5WBqalSsshY3+HeAAPL6dflolUGrJHLghWiS/yg2Z9DoxuD1HREe5jd+z3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ieur6rqE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ieur6rqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD63A1F000E9;
	Sat, 23 May 2026 05:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779514624;
	bh=ReEj4X/QtW/CyrcpeScHGf6wIbw/8adXSoEqmfknjbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ieur6rqEpBM6tlfgVRWaF7k6zhwWLhSn1FXYBl5Jz2nrrikPt9j1ZMXCxP277sdRa
	 tit3sI8/3v32+s3sVNb00d01e/5jFWKulN794nObDhxP+ixVhn/9tml5MjsCz2m1ND
	 Xc0JXVTZhWYYFmLbzGPCMmLEoAvTnndCXzfhQJExwjhClrInoFjjj4aUub9+2kD3n/
	 x2hATQvxqdpzgIa7N8cJHvXV8hT+L4kTS9aNq2I641N4y9FCjYdRJ6yW9UpigkPRaf
	 iDiOV2xsVFiNGJXyLyv0RL5Bq/XKkCeIhaFGZWlB26JNr8WQobGP8PbQxwV13P+VB9
	 mY0umn+GVi6TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] Input: ims-pcu - fix DMA mapping violation in
 line setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523050634.501509-9-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-9-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 05:37:04 +0000
Message-Id: <20260523053704.BD63A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Using GFP_KERNEL in a function called from a USB resume callback r=
isks system deadlocks during suspend/resume.

Pre-existing issues:
- [High] Mismatch between allocation and free sizes for coherent DMA memory.
--

commit ecb1961e66f5ce58ee717e51a89fafeaebd53f86
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ims-pcu - fix DMA mapping violation in line setup

This commit fixes a DMA mapping alignment violation by replacing the
embedded pcu->cmd_buf with a dynamically allocated buffer for line coding
data.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index d7a3f4c7214a0..7746a8242f2a0 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1790,11 +1790,16 @@ static void ims_pcu_stop_io(struct ims_pcu *pcu)
>  static int ims_pcu_line_setup(struct ims_pcu *pcu)
>  {
>  	struct usb_host_interface *interface =3D pcu->ctrl_intf->cur_altsetting;
> -	struct usb_cdc_line_coding *line =3D (void *)pcu->cmd_buf;
> +	struct usb_cdc_line_coding *line __free(kfree) =3D
> +				kmalloc(sizeof(*line), GFP_KERNEL);

[Severity: High]
Does allocating memory with GFP_KERNEL here risk a system deadlock during
suspend/resume?

Since ims_pcu_line_setup() is called by the USB power management callback
ims_pcu_resume():

ims_pcu_resume() {
    if (alt->desc.bInterfaceClass =3D=3D USB_CLASS_COMM) {
        retval =3D ims_pcu_start_io(pcu);
        if (retval =3D=3D 0)
            retval =3D ims_pcu_line_setup(pcu);
    }
}

During the system resume phase, device locks are held by the PM core. Using
GFP_KERNEL allows direct reclaim, which can initiate filesystem and block I=
/O.

If these operations attempt to access a suspended device or wait on a shared
lock, it could block indefinitely. Should this use GFP_NOIO instead?

>  	int error;
> =20
> -	memset(line, 0, sizeof(*line));
> +	if (!line)
> +		return -ENOMEM;
> +
>  	line->dwDTERate =3D cpu_to_le32(57600);
> +	line->bCharFormat =3D USB_CDC_1_STOP_BITS;
> +	line->bParityType =3D USB_CDC_NO_PARITY;
>  	line->bDataBits =3D 8;
> =20
[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is there a mismatch between =
the
allocation and free sizes for the coherent DMA memory?

Looking at ims_pcu_buffers_alloc(), pcu->urb_in_buf is dynamically allocated
with a size of pcu->max_in_size:

ims_pcu_buffers_alloc() {
    ...
    pcu->urb_in_buf =3D usb_alloc_coherent(pcu->udev, pcu->max_in_size,
                                         GFP_KERNEL, &pcu->read_dma);
    ...
}

However, in ims_pcu_buffers_free(), the same buffer is freed using
pcu->max_out_size instead:

ims_pcu_buffers_free() {
    ...
    usb_free_coherent(pcu->udev, pcu->max_out_size,
                      pcu->urb_in_buf, pcu->read_dma);
    ...
}

Since max_in_size and max_out_size are initialized independently from their
respective endpoint descriptors, they can differ. Can passing the incorrect
size to usb_free_coherent() result in memory corruption or page leaks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D9
