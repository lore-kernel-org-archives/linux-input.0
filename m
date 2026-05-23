Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF01A267
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515527; cv=none; b=CloeA4x5jknF+DR3FM8gOTqY5tTY/4jOkNLCy5YHOp+dgx6drINGGN1jkeaE42EYGbcVldO3mfJaNxpuSTS/cqT/OrXAEC9FQVjHzFUo+h0T1p+S+jCIQ7m12yWR+kbu0/yllcWLylak3rOsX4Ypqz11m1Bl0oNb/zjsBTL9Cpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515527; c=relaxed/simple;
	bh=6scU869qawrt1rw25gYNpEN2fpqxhHTAXbUN25b8zI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YKz6eZBEqtHXUmS47E7BsyXT/YvXJjP9yN9J0cSAK5/7JRg0K9ala/ku33Pm9c80+tkBofxyEQ84s/3hmxJsmhWbxj92gf0hVmzOUqILlzDVzpmrmKk0hh69z9WENree3P2ODaJCUnEOuv9X10cLTO0aBtlIz1nEmrmzyRl6H1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMM0a9TD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMM0a9TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3421F000E9;
	Sat, 23 May 2026 05:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779515525;
	bh=tc3XrvyCWrB4uQpyVd8/295LwtZyhflhOS1mibFDtUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMM0a9TDCIts3BqzcKLp6zZZv/i8MIbpKu7Z0j14sjlJMHIBG9atlW1qgYxPKuAFS
	 YERw3kCPPUidsy5ILvzCxoJTHeaVW8SqDePGbGQlkPe5PGvuQVQMcPK1qGWiAnhe4b
	 nAYu0Q4M9p7i4Pujy8A72DfhPVkQq9oxFfcpyXlZ4ez5IvubriWkcmAMsjLqPh7HV7
	 InCmKOqNu2///Trp5gK0M64Bluh1ROLX+P9oUhyW3pILLUGLUWPI1rMqzMbl1VRV2H
	 iM9S9dd1ZNphXf1dXgH9YcFeiqpX5itmtKZvpE4LIBDkBXPWQAyrojKhHmrznX2BMB
	 ym31JvGQ3To6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] Input: ims-pcu - fix type confusion in CDC union
 descriptor parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523050634.501509-3-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 05:52:04 +0000
Message-Id: <20260523055205.8B3421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The size parameter passed to `usb_free_coherent()` when freeing `u=
rb_in_buf` is incorrect.
- [High] The driver does not properly clean up or stop I/O when the seconda=
ry (data) interface is unbound.
--

commit af29ec151c71a12e07665974e6faf5b8ab15fa16
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ims-pcu - fix type confusion in CDC union descriptor parsing

The driver currently trusts the bMasterInterface0 from the CDC union
descriptor without verifying that it matches the interface being probed.
Validate that the control interface found in the descriptor is indeed the
one we are probing to avoid overwriting private data.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 2ad72fe4a51d9..5d1df07ac2a2a 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1693,7 +1693,7 @@ static int ims_pcu_parse_cdc_data(struct usb_interf=
ace *intf, struct ims_pcu *pc
> =20
>  	pcu->ctrl_intf =3D usb_ifnum_to_if(pcu->udev,
>  					 union_desc->bMasterInterface0);
> -	if (!pcu->ctrl_intf)
> +	if (pcu->ctrl_intf !=3D intf)
>  		return -EINVAL;
> =20
>  	alt =3D pcu->ctrl_intf->cur_altsetting;

[Severity: High]
This isn't a bug introduced by this patch, but pre-exists in the driver:
the size parameter passed to usb_free_coherent() when freeing urb_in_buf
appears incorrect.

Does this mismatch result in partial memory unmapping or page leaks if the
max packet sizes for IN and OUT endpoints differ?

In ims_pcu_buffers_alloc(), pcu->urb_in_buf is allocated using
pcu->max_in_size:

drivers/input/misc/ims-pcu.c:ims_pcu_buffers_alloc() {
	...
	pcu->urb_in_buf =3D usb_alloc_coherent(pcu->udev, pcu->max_in_size,
					     GFP_KERNEL, &pcu->read_dma);
	...
}

However, in ims_pcu_buffers_free(), it is freed using pcu->max_out_size:

drivers/input/misc/ims-pcu.c:ims_pcu_buffers_free() {
	...
	usb_free_coherent(pcu->udev, pcu->max_out_size,
			  pcu->urb_in_buf, pcu->read_dma);
	...
}

Because USB devices can have different max packet sizes for IN and OUT
endpoints, max_in_size and max_out_size are not guaranteed to be equal.
The DMA API requires that the exact size passed to the allocator is
provided to the free function.

[Severity: High]
This is a pre-existing issue, but the driver does not appear to properly
clean up or stop I/O when the secondary (data) interface is unbound.

If a user manually unbinds the data interface via sysfs, will the driver
continue submitting URBs to the unbound interface's endpoints?

Looking at ims_pcu_disconnect(), if the unbound interface is not the
control interface, it returns early without stopping URBs:

drivers/input/misc/ims-pcu.c:ims_pcu_disconnect() {
	...
	/*
	 * See if we are dealing with control or data interface. The cleanup
	 * happens when we unbind primary (control) interface.
	 */
	if (intf !=3D pcu->ctrl_intf)
		return;

	ims_pcu_stop_io(pcu);
	...
}

This means the control interface remains bound and the driver will continue
to submit URBs (such as urb_out in ims_pcu_send_cmd_chunk()) to the data
interface's endpoints.

This unstopped I/O can lead to state corruption if the data interface is
subsequently claimed.

Note that a later patch 'Input: ims-pcu - fix use-after-free and double-free
in disconnect' alters the early return condition to compare pointers instead
of class types, but it maintains the fundamentally flawed behavior of
skipping cleanup when the data interface is unbound.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D3
