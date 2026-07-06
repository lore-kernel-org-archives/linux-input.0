Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90537F010
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330462; cv=none; b=syUwHDh55sEREPi12PUHjbkYArpLddbMTfViJh0TGS9fHgksVhZsVgqcEALavz3HethHtbFEr82SF4LuLhCaD27waRGLpUwbQAL87+/C5C4HQGH3jfrzKcNPYB3NSGtyyafM9+n0gRkfl3vAO/0VhtYl72MqMSm/Z2v2y3Bl8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330462; c=relaxed/simple;
	bh=6lVbsmsqcR4eRLonNA+oPzmnlO4GO+VAS0II3dH82vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eETa4J6lmE6qK6Cgx0PJmHrrc9DWpwl6k2jGFE3VIgV46VEh2Cv9lPSWLCvcDiemoZqF+JBPMTj8jGtWifxGQ71USA+sAjipZGk+naGdE14aycnDSKe5y8SpYvJalDez2w65EPFYS2dEr2bbTmP5mZBVqc7XmId53cWlIXzJijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewQlOVET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewQlOVET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E071F000E9;
	Mon,  6 Jul 2026 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330456;
	bh=BdXBV5BNgLh7AOA4wa/MVGF62KqnX1vBNlE9P6D9Mf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewQlOVETvrm32tnT8eEpFurSBrl70ujNI7fdfU3mtBjDeKrg+fXvcxMRjTR/d2TnQ
	 H8utfpn9YDp5TrW2XoX9GWyWbFoC1iRTmLPHpDCUxZ0H5sssIgliYBum42XaxS3vha
	 SQhhB369FS4MPh5+VeYILGlKToFvFzNGw/e9B/AM0N0463emuZmDHbeTRGT0A8qGAI
	 v3XVOEFVKf0VISW2AcEmZwQoin8v3e89W7Pgi+pqsKj9UpZPcXJByonN4+SnmN/JZe
	 cijxFKtWD20WUvaAuUaNb64RZ24g7bvzgLnzh9yXYcL734HGoGO6zDIjKE9Zs8DZBs
	 44kmklcDhJhVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: iforce - validate packet lengths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260706092016.78176-1-pengpeng@iscas.ac.cn>
References: <20260706092016.78176-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:34:15 +0000
Message-Id: <20260706093416.47E071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Zero-length USB packets cause an integer underflow that bypass=
es length checks, triggering a massive out-of-bounds kernel memory read and=
 panic.
- [High] Incomplete bounds checks for joystick and wheel packets allow logi=
cal out-of-bounds reads.
- [High] Out-of-bounds read in status report packet processing loop.
--

commit ebc2b4788d350db685692da195ae9d9cd27098a0
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

Input: iforce - validate packet lengths

iforce_process_packet() decodes several packet formats from a
variable-length input buffer. Add minimum length checks for joystick,
wheel and status packets before reading their fixed fields.

> diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/inp=
ut/joystick/iforce/iforce-packets.c
> index effa76bfd8f9a..54697b252b84d 100644
> --- a/drivers/input/joystick/iforce/iforce-packets.c
> +++ b/drivers/input/joystick/iforce/iforce-packets.c
> @@ -155,6 +155,9 @@ void iforce_process_packet(struct iforce *iforce,
>  	switch (packet_id) {
> =20
>  	case 0x01:	/* joystick position data */
> +		if (len < 5)
> +			break;
> +

[Severity: Critical]
This isn't a bug introduced by this patch, but does len underflow when a
zero-length USB packet is received?

Looking at iforce_usb_irq() in drivers/input/joystick/iforce/iforce-usb.c, =
it
calls iforce_process_packet() with urb->actual_length - 1:

    iforce_process_packet(iforce, iforce_usb->data_in[0],
                          iforce_usb->data_in + 1, urb->actual_length - 1);

If urb->actual_length is 0, this underflows to SIZE_MAX. The new bounds che=
ck
here will be bypassed, and subsequent loops can read linearly out of bounds
into unmapped memory, potentially causing a panic.

[Severity: High]
This is a pre-existing issue, but is the len < 5 check sufficient to prevent
out-of-bounds reads when processing hats and buttons?

When iforce_process_packet() calls iforce_report_hats_buttons(), it
unconditionally accesses data[6]:

    input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);

If a short packet arrives (e.g., actual length 6, leading to len =3D 5), the
check passes, but we still read stale memory when accessing data[6],
potentially reporting phantom hat movements or button presses.

[ ... ]

>  	case 0x03:	/* wheel position data */
> +		if (len < 4)
> +			break;
> +

[Severity: High]
This is also a pre-existing issue, but this check is similarly insufficient
because iforce_report_hats_buttons() requires at least 7 bytes of data to
safely access data[6].

[ ... ]

>  	case 0x02:	/* status report */
> +		if (len < 2)
> +			break;
> +

[Severity: High]
This isn't a bug introduced by this patch, but could the status report
processing loop read out of bounds?

Downstream in this case block, there is a loop:

    for (j =3D 3; j < len; j +=3D 2)
        mark_core_as_ready(iforce, get_unaligned_le16(data + j));

If a packet arrives with an even length (e.g., len =3D 4), the loop conditi=
on
j < len allows get_unaligned_le16() to read two bytes starting at offset 3.
This extends beyond the valid payload length of 4, inadvertently reading st=
ale
data that could match and corrupt force-feedback state tracking for unrelat=
ed
effects.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706092016.7817=
6-1-pengpeng@iscas.ac.cn?part=3D1
