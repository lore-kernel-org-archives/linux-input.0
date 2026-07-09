Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120134A794;
	Thu,  9 Jul 2026 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573409; cv=none; b=MktfskkAL84DTL8Kr1pFQc4991imZQxxXSuu7GBkLEURSe8T3LzTG0vSgz904Sq/miT3GR0k4BRNDkMqEs8hmmqL1QIfBC6YVIkUcCS29pxnCvUY6zQt/+a2upTY/IcFeTl3hmaqCQJQ4bfWIiXp+DrJmikiDWSF/yi+AEORvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573409; c=relaxed/simple;
	bh=7UgJytsVFpfjT78THrPpJAEwz4iG2ggfe2SRfLUxiNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DEMR7lP0n9WPiTbzecBGYBt+qXlZay37BpF3oR5lYxeoyjuyMK8Z6XbkHOKPZvSQA2+xWQoGFd8kTvnQbVygvoVsQvjkAX9Zy2FfVrIDyB7+uYZ8DhpQu+9inNwCJiaqbZ405oSFkKJKzVUXlkaab5WfD7IJ0m5CC+EWDYQCzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKeotgnY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKeotgnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFAD1F000E9;
	Thu,  9 Jul 2026 05:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783573407;
	bh=VENrEYIVZK85ie9wjF8O/8sm+qJHGHfHIeLMze3piDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKeotgnYZ/oLjqMoZxB/avhYrefBXHxbFpSznEMPmHvGUeHOsNbRGxprtnMxCed6L
	 GD4UxPIlMEWklnyZozbbr3w/5ql2VIigunZDDgNa56Trhb6FEFONi58iH1VCR6bPll
	 kxiGOZEEGuWpw+3fSbC+RRKtPDMOZ4IW+qUVmph4ImR1plEbo0xg0lu95pWX1U3ZvD
	 55oUSiuuoR5/hgnMVuzpW3n5t2sbIVrT7L7ZCBpA5VCamn+sj5bHIuBlukkMzBpw0O
	 WT2MHRsMG9prpNktFH9WhU8yQ4iZRA/2DDKMJVF8fcsR67wELeVF4ayhyDZ2AsSMcI
	 JvoIePROE2gtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] regulator: wm831x: support software node in
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260708-samsung-kp-v2-7-3c6ed4c9b3b6@gmail.com>
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
 <20260708-samsung-kp-v2-7-3c6ed4c9b3b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 05:03:27 +0000
Message-Id: <20260709050327.7EFAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using `device_set_node()` on an already-registered platform device=
 destructively overwrites its primary firmware node and introduces dangling=
 pointer/use-after-free risks.
--

--- Patch [7]: [PATCH v2 07/11] regulator: wm831x: support software node in=
 platform data ---
commit 41eed35e80fd0a1bdad7b80c52433a74629a0ec0
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

regulator: wm831x: support software node in platform data

This commit allows passing a software node via platform data to the
wm831x buckv regulators. It attempts to read DVS configuration from the
software node if it is present, falling back to legacy platform data.

> diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-d=
cdc.c
> --- a/drivers/regulator/wm831x-dcdc.c
> +++ b/drivers/regulator/wm831x-dcdc.c

[ ... ]

> @@ -332,14 +333,26 @@ static void wm831x_buckv_dvs_init(struct platform_d=
evice *pdev,
>  	struct wm831x *wm831x =3D dcdc->wm831x;
>  	int ret;
>  	u16 ctrl;
> +	int dvs_control_src;
> +	u32 val;
> =20
>  	if (!pdata)
>  		return;
> =20
> +	if (pdata->swnode) {
> +		struct fwnode_handle *fwnode =3D software_node_fwnode(pdata->swnode);
> +
> +		if (fwnode)
> +			device_set_node(&pdev->dev, fwnode);

[Severity: High]
Does overwriting the primary firmware node here with device_set_node()
safely manage the device lifecycle?

Calling device_set_node() on an already-registered platform device destruct=
ively
overwrites its primary fwnode, clearing any Device Tree or ACPI bindings
established by the MFD core. It also bypasses the correct API for secondary
nodes (device_add_software_node()).

If a later step in wm831x_buckv_probe() fails and the driver unwinds, the
modified pdev->dev.fwnode is never restored. This leaves a dangling pointer
to the unrefcounted software node.

Should this code use device_add_software_node() instead?

> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-samsung-kp=
-v2-0-3c6ed4c9b3b6@gmail.com?part=3D7
