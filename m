Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3913438B5
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515179; cv=none; b=ZhsUK5INAOjadmPSciJr1cIAWor92vkCGtLM90H/sf4H2MzAORrEzH7TstS1nHP1WVWpkc63uPWzl2xR1mGLQ1d4mY/XKNxHEbVsfeB3xBVkPPtlEAOcP9MABSizf56EQrIjEA2cHGYmzTMHcr6kQ07Sh9PTDSOO37HaNCGV4xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515179; c=relaxed/simple;
	bh=SOzERzdL6NDc3UCsGFtVvoqLS2Ec9lRDH68PHDWpEpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KORJr9eP8h5FBHx/C7OheoYVtJfXmiYnbPnPfFCkkJEO9CEc8KJ80J9kYEO+COud9k/HAztRX8UjsZKti2vTWQB4pZf/ZY3jv8x0NC2QDTuBdA9YDuzKY9S9OMnr41xf31x7nLfcBvi6M1nWL9s/jqFN2DcvA5T2V8W7f42CQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG2QTY2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG2QTY2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590B31F000E9;
	Sat, 23 May 2026 05:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779515177;
	bh=zdXmsVtL9PkAjgiF0XN/W7eN8DMECTtRs4I3ZIKryqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DG2QTY2u5OkzsOaWVLJH9eN4qzjU2s84TNODMGSk19K2nrJA1rCzWlQ/CkkOHLpWk
	 VlBhBnNzMKRHin6VQFdl95nfK4Lg3CANfoqVqomsv8Ge9Tb00J0sL8Z0TDgQq616l0
	 TsBacRstyfSHnNj2xK2i5D2BoQ9Gz53nvmlfAL4Ru5Wwrbi3Jg1YzCTrdg9lJUonLU
	 ivr3Y6G/m29OdY697ff6spvwa0FP5QSJJ9WXIMvER6huSzccIgWaBmc5Cy9e2ub9yn
	 6YoIUwK852i4ttpQEOX+1bbC9jzXKkG7QjRl7KVBmrN4AwxAXf0irM2FrbVEGb/XYu
	 zV/iwdBRRdW4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] Input: ims-pcu - release data interface on
 disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 05:46:16 +0000
Message-Id: <20260523054617.590B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect size parameter used when freeing the IN endpoint DMA buf=
fer.
- [High] Use-After-Free race condition in sysfs handlers due to incorrect t=
eardown order of the data interface.
--

commit 53bdd94824ab81874a46c9320ecc2816e98b47a9
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ims-pcu - release data interface on disconnect
   =20
During probe the driver claims the data interface, but it never releases
it. Release it in disconnect to avoid leaving it permanently claimed.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 4c022a36dbe84..89737ef381c1c 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -2090,6 +2090,7 @@ static void ims_pcu_disconnect(struct usb_interface=
 *intf)
>  		ims_pcu_destroy_application_mode(pcu);
> =20
>  	ims_pcu_buffers_free(pcu);

[Severity: High]
This is a pre-existing issue, but are we using the correct size parameter
when freeing the IN endpoint DMA buffer?

Looking at ims_pcu_buffers_free():

drivers/input/misc/ims-pcu.c:ims_pcu_buffers_free() {
	...
	usb_free_coherent(pcu->udev, pcu->max_out_size,
			  pcu->urb_in_buf, pcu->read_dma);
	...
}

It appears to free pcu->urb_in_buf using pcu->max_out_size instead of
pcu->max_in_size.

If a malicious USB device presents endpoints with different max packet size=
s,
could passing a mismatched size to the DMA freeing function cause memory
corruption or leaks?

> +	usb_driver_release_interface(&ims_pcu_driver, pcu->data_intf);

[Severity: High]
This is a pre-existing issue, but could releasing the data interface after
freeing the buffers create a use-after-free race condition?

During probe, the driver claims the data interface, which automatically
creates sysfs attributes on it. If a concurrent sysfs operation accesses a
file on the data interface during disconnect, it might retrieve the
still-valid pcu pointer and attempt to use pcu->urb_out_buf to send a comma=
nd.

Since ims_pcu_buffers_free() has already freed the buffers, could this resu=
lt
in a use-after-free? Would it be safer to release the interface before
freeing the buffers?

>  	kfree(pcu);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D1
