Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122177;
	b=tZj4WwmOlpfmTdLFhqTzXLFHyGU3SBPHx69BSDnuUV4P0v+ZapwwvTa+vWSHo41NMnjS
	 YOLTY0JXFlvpdgA15BFO8SfCMxaWrNFoMZ+vDNs8CopdHPDCVEHCTmc7Z5NjNGawWvwzI
	 6bPzB3KC9CcA0mxfU0/Ceb+SrqZwmh4l3rL0ltXdC5RkzZWHnIGQB5gNgwkPeMwLiSfsr
	 Xsm1+IWrYamXHxixksP7V/DRxMmk96QIs/W2IXE5wwTrTIfdlyWO+XSsgcdzD3twvmigz
	 yZC/0EZp6KsJpg8HPo7WAbrgtGFo5Oiue4JzB61Oxn9U9+Puu8ACIqkYj7ER78fypSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122177;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=5e3qHst8t5RYS38cYNTHd20BAa716VNfA11Xr+S6tjw=;
	b=BFheNlD/fVevAQX4bjJTP3jBfgs8bvpXE1UBodf2ON1+yGMKzdT38sXRhmIrREZglgY3
	 f0nxbO9grknrLgBl2L9peMfFqouQJImGfa7rLP2Iz1V3kBN17ZmDMH54rFVUr0iWFQ6Q0
	 53jdIp8qDgOa00cLUKkrFYaMtobJKelmdOcvOc6kYP0QZDFV5dog+FQw6byBLC23xR/mU
	 pp1Zc8o4bc57lyrfnUpqWHvla8Tlq64NdjDRT73IVFKoTt6zNb15kSAEvjBITYPipIW81
	 s2tCONRXVpGpp4tFd7BXK215GBQE32sJxPtM3B/ArifM0bo5+Pjwavj8STigvuZf9Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw1mFeBM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FE606A320;
	Thu, 19 Nov 2026 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw1mFeBM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1591C1F000C0;
	Thu, 19 Nov 2026 21:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122177;
	bh=5e3qHst8t5RYS38cYNTHd20BAa716VNfA11Xr+S6tjw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Pw1mFeBMk4XMLf5MlZWFqj6ziKts0XfIQ+ucg/QVjaNZGA1rDrm606+FkxVLD5y4g
	 u3cOPQx26mnem3wqFYGlsPobz3AiSf/b99P1QPyXvZw4YmCJ5Vtay2O8sFwPBbmiVq
	 MC5zf5TqznKHNVrYdJ45V0lrOXhPvud0nEFw6TVeWN69lXHaniZyw7kUrVD5fCi56s
	 fMRkui2dlsAVuq4gP4tF7cfUa3ejX6YsbC1YuJIOqICVHQdH0SmXP+oroiqvy191Ol
	 tVKD9Kx+E1kCElA0DwxoXiryNC47ssYOAlizBwf5CV7xuT/65zid4kDupd/VYFZlD0
	 n2C1uYMCNVJdw==
Date: Thu, 19 Nov 2026 22:02:54 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jozef Riha <jose1711@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: betop: add support for SPEEDLINK TORID
In-Reply-To: <20261118143306.75858-1-jose1711@gmail.com>
Message-ID: <n5161908-rpq0-346p-1214-58746q67sp76@xreary.bet>
References: <20261118143306.75858-1-jose1711@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Nov 2026, Jozef Riha wrote:

> The SPEEDLINK TORID wireless gamepad (11c0:9105) is a Betop based
> device. Its output report has the same 4 byte layout as the other
> devices handled by hid-betopff, with the motors in bytes 2 and 3.
> 
> Without the device ID the gamepad is bound to hid-generic and has no
> force feedback. Add it to betop_devices[].
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Jozef Riha <jose1711@gmail.com>
> ---
> v2:
>  - Fix From/Signed-off-by name mismatch
>  - Cc linux-input and LKML, v1 was sent to the HID maintainers only
> 
>  drivers/hid/hid-betopff.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-betopff.c b/drivers/hid/hid-betopff.c
> index f802046a688a..28ab0acce6ad 100644
> --- a/drivers/hid/hid-betopff.c
> +++ b/drivers/hid/hid-betopff.c
> @@ -16,6 +16,9 @@
>   *
>   *  0x20bc:0x5500 "BTP2185 V2 BFM mode Joystick"
>   *   - tested with BTP2171s.
> + *
> + *  0x11c0:0x9105 "SPEEDLINK TORID"
> + *   - tested with Speedlink TORID wireless gamepad.
>   *  Copyright (c) 2014 Huang Bo <huangbobupt@163.com>
>   */
>  
> @@ -137,6 +140,7 @@ static int betop_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  static const struct hid_device_id betop_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185BFM, 0x2208) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185PC, 0x5506) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185PC, 0x9105) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185V2PC, 0x1850) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185V2BFM, 0x5500) },
>  	{ }

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

