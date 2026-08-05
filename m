Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA8279DC3
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924539; cv=none; b=g0QNCawAYWYE5UmBIeknCSIfyT8TMfPPDARk8eWsRqg0BxROrvWFDFfn477o6MDSiuS7qYU01phR+msN+HMDj8IQVTa77KvpNTURhVWfAalSjn6oUrRaQebf89nK3iBhNTvcN0JDpef3E6brA1HSIzfRRNqaCCO4UoP7nMOCnIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924539; c=relaxed/simple;
	bh=FAIkEjHIJsT/b81rIJxD7sg4wGtysWgPSAsSfBKSE6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h+H50LWjN6g5TcqaGfb2jR9616U/zIdjuA915icRgsV272ND/tQzYL1egcmo029rl7yHpvHNM2WNN82DoXxHfF0U6+iW/2JhP460qnjjNA4ONfUmrJQRXgFSC95o9vPGmn5WADUxWEbABovkW3phLhwuUmx7vkFkrrXSCXxwfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG7xC4FK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG7xC4FK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AD01F00A3A;
	Wed,  5 Aug 2026 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785924538;
	bh=c2C8fEvynORUPkkIX2bladZ6jXNeDGdO8R0eZqc6Pqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WG7xC4FKRopMGVEYbXKJg/XfzTQpZEgW56FMbGrgxIckD72h1l+LkSj+U1dxQoE0B
	 B7cM5sO/Zep4KartfyktI4C+gxf58tat0r9l99cdSee3LJXJBzFlAf1E/+xS8W8H0k
	 hpgENgkR0iXbQiadD1mkAYBrYKkTqa5mlcewKHKgmZNFGe+y535osZWDPakNFkIjMb
	 ADtSybRF5lOKTOJ4ppl2aHBkvtH34Ce7vbG6vlbgvRZHqPi9K9eVmI1GYuIoPbDtcD
	 WrltjpP0rEzJuPtfH8CJjYMJcTAcm06/KFo+gsWBE+kqa1tQd+Px+vedl6lh1G8xcJ
	 sEivI/G3Pdn6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] Input: xpad - add size checks to xpad360 packet
 processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin@kroah.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260805-xpadone_length_checks-v2-3-f3e925e0280b@kroah.com>
References: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
 <20260805-xpadone_length_checks-v2-3-f3e925e0280b@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 10:08:57 +0000
Message-Id: <20260805100857.D8AD01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Logical out-of-bounds read due to incorrect order of length chec=
k.

Pre-existing issues:
- [High] Use-After-Free or NULL Pointer Dereference in error logging path.
--

--- Patch [3]: [PATCH v2 3/3] Input: xpad - add size checks to xpad360 pack=
et processing ---
commit 2a90e36a133f256901ec08114f8164654060dd73
Author: Griffin Kroah-Hartman <griffin@kroah.com>

Input: xpad - add size checks to xpad360 packet processing

This commit adds size checks to xbox360_process_packet() and
xbox360w_process_packet() to prevent out-of-bounds reads with the data arra=
y.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 83bc361b15f76..6f15eafc64775 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -870,10 +870,10 @@ static void xpad_process_packet(struct usb_xpad *xp=
ad, u16 cmd, unsigned char *d
>   */
> =20
>  static void xpad360_process_packet(struct usb_xpad *xpad, struct input_d=
ev *dev,
> -				   u16 cmd, unsigned char *data)
> +				   u16 cmd, unsigned char *data, u32 len)
>  {
>  	/* valid pad data */
> -	if (data[0] !=3D 0x00)
> +	if (data[0] !=3D 0x00 || len < 14)

[Severity: Medium]
Will this evaluate data[0] before checking len? C logical OR short-circuits
from left to right, meaning data[0] could be read from the DMA buffer
before we verify len is large enough to contain it.

If we receive a zero-length packet (ZLP) where urb->actual_length is 0,
could this result in an out-of-bounds read of the data array?

[ ... ]

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but I noticed a potential use-after-free or NULL pointer dereference in the
error logging path when xpad_init_input() fails.

If input_allocate_device() fails, xpad->dev remains NULL:

drivers/input/joystick/xpad.c:xpad_init_input() {
    ...
	input_dev =3D input_allocate_device();
	if (!input_dev)
		return -ENOMEM;

	xpad->dev =3D input_dev;
    ...
}

Or if a later initialization step fails, xpad_init_input() frees input_dev
but leaves xpad->dev pointing to the freed memory:

drivers/input/joystick/xpad.c:xpad_init_input() {
    ...
 err_free_input:
	input_free_device(input_dev);
	return error;
}

If xpad_init_input() returns an error, xpad_presence_work() logs it:

drivers/input/joystick/xpad.c:xpad_presence_work() {
    ...
			dev_err(&xpad->dev->dev,
				"unable to init device: %d\n", error);
    ...
}

Could this dev_err() call dereference the NULL or dangling xpad->dev pointe=
r?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-xpadone_le=
ngth_checks-v2-0-f3e925e0280b@kroah.com?part=3D3
