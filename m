Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8E47CA9E
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836795; cv=none; b=rhTW24XDfyviTrZBoW2G5ujZgwCcuLXsn61c7Y/Dai1+uFzBVKhrnfiYd5665z9Tu53/NOmLPoXceKBuOmrD7SlOWD9CqbX+nKgxKEz2sN+Hm2yZgOnZXiWV8eLOHEHx7JD8Cp+kEUB0A1GJRw1CsQjGy4mDEHvFQ1HIcNRPKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836795; c=relaxed/simple;
	bh=h+6Q6qvza3Nq5Buo+wPGPBkDRcB3fU6kIFJl0ELV95U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mp95onAmAchWPGr+qZqrJPn+SiF/2vra+FDmQ3iQq3FOpdXDAQ70wF3/u2+bBWBbxEQH4leVqdmEQIBwC0zc4rQqKbofsRn9TED0+qrHklE9ctnzJq6HCJ22UdtgoBqEv/4iUsDFUEpJK+XyTNyREUiRibcfmblteptAzBaojao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCLBjYLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCLBjYLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC581F000FF;
	Thu,  1 Oct 2026 06:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790836793;
	bh=PrJOh8Aor8W4v3IeS3Y2P5VUqboRyi/YgzvO49zQ2Mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCLBjYLpze4INSRjF3GPQwhOtKv3uKpsyC26NvwzBHBiT5MO2kF2mVFPimjZXNaLe
	 5cIyq9ZxTSZSMiqNFY1ud7iMs4G32HBWt8he7s4TH/K9sW36745QwRHKvcZ1OPJVcY
	 pYWY2RqJWu5uk5NDPArTFr5z/Z82YojzZvOcz+9Y4dJhO7yChRRnptC2j9JtDbdvG7
	 BnBABt48QDPJpAupDVuiobEepkm0bpqRgCq8aPSFkN3IQVskcqBFT1JtwW/o6v5idR
	 w8xnxXqzgvA1eL2EOJqsabIHDYoSXy9eaK5UiQMYibPIFHlQ/MMaCAMhftT2jbUuDG
	 LIwY+UvagqSyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix input device name lifetime
 with hid-rmi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <ar38b7ToAe8iGU5v@google.com>
References: <ar38b7ToAe8iGU5v@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 06:39:52 +0000
Message-Id: <20261001063953.4FC581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: devm memory leak of input device name on rmi_driver probe fa=
ilure or unbind
--

commit cb8d75744bf1ae82958b47feab42ec5de7126321
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Input: synaptics-rmi4 - fix input device name lifetime with hid-rmi

This commit changes the input device name allocation to use the parent devi=
ce
instead of the child device. This addresses a use-after-free issue when the
input device is supplied by a transport driver such as hid-rmi.

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..5b104b2b8e19a 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -361,7 +361,14 @@ static void rmi_driver_set_input_name(struct rmi_dev=
ice *rmi_dev,
>  	const char *device_name =3D rmi_f01_get_product_ID(data->f01_container);
>  	char *name;
> =20
> -	name =3D devm_kasprintf(&rmi_dev->dev, GFP_KERNEL,
> +	/*
> +	 * Allocate the name string on the input device's parent rather than
> +	 * rmi_dev->dev so that when the input device is supplied by a
> +	 * transport driver (such as hid-rmi), the name string is not freed
> +	 * when rmi_dev is torn down before the transport unregisters its
> +	 * input device.
> +	 */
> +	name =3D devm_kasprintf(input->dev.parent, GFP_KERNEL,

[Severity: Medium]
Does tying this devm allocation to the parent transport device (e.g., hdev-=
>dev
when using hid-rmi) cause a memory leak when the child device fails to probe
or is unbound/rebound?

If the RMI driver probe fails subsequently, or if the RMI driver is manually
unbound via sysfs and rebound, the devres group for the parent HID device is
not cleaned up. Each probe attempt allocates a new string on the parent's
devres list, leaking the previous allocations until the parent HID device
is eventually unbound.

>  			      "Synaptics %s", device_name);
>  	if (!name)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ar38b7ToAe8iGU5v@go=
ogle.com?part=3D1
