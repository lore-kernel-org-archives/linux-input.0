Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4A3AA51E
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536727; cv=none; b=K31mTVhp0hjJbXF6+AGu0I++40E4TkYjDEfQmxCoCT4Ojn4r9TfmRxOvazpuxY1kr93uPA+6KVFpkm/ujBWsw8elQmjYfG28oRfFUaYr4jrLYWuuwF/XSrpU+mk6GbgMCd4JylR5ItS2u2qpd4eJqxRsV7dE0T5f/GLXVkkOZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536727; c=relaxed/simple;
	bh=OalAdleMTGOGCGX0znzL35bBFGsF6Yf9AEYEmRLBFD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jhF58n/HvTBdjPVNb2xvAJylvcUZZxylkbbfOudJOOnINufMqhHGYcTi94+OgkLuR8L7Yoybvj3q8Ro9ildczHNXHxwoXry8fjjoPOgI4xCtsaN+ImwIJpQeBLccwDVGGpDSGMhI4LtRXxD4tRdTi94q3FET+pRFuC/UkvJgLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLVype+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLVype+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1D01F00A3D;
	Fri,  4 Sep 2026 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536725;
	bh=KV25n2nciAfBlHF9LPc6O3R2307OKxWCixTkJZPQJkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLVype+Ljotm/PPvUrEE9RbW+tLQXKlU64V4YhUr/u9hVF6MffitDrU2oAhQmbQ2W
	 8WDVu6aIAQCA9VBDL/OVzeyVkxtGYvGICj+qdD31JKbIFWoFsWyakoUYUoKrDkwYup
	 AZmYd3OuPa+WbWx2UjuqIOaqP0WuuYWr6/A82kT4Us+VbyCiyGANJOA5wtM3qmmGg6
	 NP0++40I6rjHYc35cBTZ0mL+unN9KF3GW7kty/c+x4BMaEYKwNzqY+essKHalZK0YA
	 f9k6QI5P1+6yvva7q4sX5lBtFyFlqEppuywOVm5wO+vcCYSDkwl4SE0x+el0yropZR
	 F5dTI0F8jaOyw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/2] ALSA: usb-audio: bind the Topping M62's
 vendor controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904153051.1785280-3-mikhail.v.gavrilov@gmail.com>
References: <20260904144300.529289-1-mikhail.v.gavrilov@gmail.com>
 <20260904153051.1785280-1-mikhail.v.gavrilov@gmail.com>
 <20260904153051.1785280-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:45:25 +0000
Message-Id: <20260904154525.AF1D01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Devres LIFO release order in the probe error path triggers a WARN_=
ON and skips component unbinding.
--

commit cf20bcaed73c317ecf96294d265e775046594f6a
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: bind the Topping M62's vendor controls

This commit registers a component master from the Topping M62's mixer quirk
to hand its struct snd_card to the HID driver at bind time. The master's
context is managed using devres on the audio control interface.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..15217286842ad
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +static void topping_master_unbind(struct device *dev)
> +{
> +	struct topping_master *tm =3D topping_get_master(dev);
> +
> +	if (WARN_ON(!tm))
> +		return;

[Severity: High]
If snd_topping_init() succeeds but a later initialization step fails,
the USB core releases the devres group for the interface.

In snd_topping_init(), the match array is added to devres after the master:

snd_topping_init()
    ...
    devres_add(dev, tm);
    ...
    component_match_add(dev, &match, topping_match_component, ...);

Due to devres LIFO order, the match array is freed first.

Then, topping_master_release() runs and calls component_master_del(),
which invokes topping_master_unbind().

During devres cleanup, the node is unlinked before the callback runs,
so topping_get_master() (which uses devres_find()) will return NULL here.

Will this return NULL trigger the WARN_ON and skip component unbinding?

If the unbind is skipped, does it leave the component bound to a
destroyed master and prevent a use-after-free on the already-freed
match array that would have occurred during component_unbind_all()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904153051.1785=
280-1-mikhail.v.gavrilov@gmail.com?part=3D2
