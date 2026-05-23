Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CD27732
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779551151; cv=none; b=S05lkBJE+anPCVFUWyHDi/jBVKS0kmNG9wzOm9wVJMvzynYnbVrtXmHlpLBc4JuNwL/Vg8LRRUFxHPrv/bMcrncKD1Cl76bR6PYSB1+mKZ8V5zSX+Tzx0B4rrCNXAOVKr/LKYginJYof2FJ/16+XcPWKeKLYL4tRsXhkPBiLix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779551151; c=relaxed/simple;
	bh=iwvfnJDoHHMYF+dysK5S6WxA6H9aouGS7bQ6eBOidMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=acE8Q9KVQ+i5oqzj08IrLpOHz0+pUj/FS/GyDQYX03FjKaBJCqq10Q5vRXGXtJuzhaqSn5ejTLtf9E+xhC5EKyk8ROXTj2xid9ASoxbuC95B6SbycFF7BELG08YH4IIf2yFfd4DNglmKXyeuNCPALZuka2hUCrUN17F93eug0xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtDhOwWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtDhOwWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75DF1F000E9;
	Sat, 23 May 2026 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779551150;
	bh=UK/HQ1C+Dbtf9yc+8ioR+WwPimmvn2t41TIicdZeto0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtDhOwWWehot3/gks4Eh0BaC43YtQcSIGR5jNTFVddzkmJgJLXpYHlSaeZM43Klxj
	 3sj1XvokTxN6hRvOvD0Z4B2WsriIkUzLRHHtBykW2EkaVjwDD/bb+eo/dzxCqdY5jj
	 63ap2Jimh+LN1XYkDLzJLEOagjW/lyEgx6BD4KTV6lAkF4hKRheTQci1LCi7NiDPHL
	 8ICSmYs8F4PWsPx51OQzPaYwXY5MjQ57aodLR+zYNEkdP8ySdRTNnjZDxP396lZ+AA
	 ghhmcuGncNW92jAhIzLqNNuyPEqXY9qo+2Fb5R9MxPT9Jf6aPZOh0xz94p6tw8UXz/
	 JjpGPPqswtl0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: fix NULL pointer dereference in
 wacom_intuos_pad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260523150101.611473-1-jinmo44.yang@gmail.com>
References: <20260523150101.611473-1-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 15:45:49 +0000
Message-Id: <20260523154549.E75DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The added early return `if (!input) return 0;` in `wacom_intuos_pa=
d()` fails to consume unhandled pad packets, causing them to fall through a=
nd be misinterpreted as pen events.

Pre-existing issues:
- [High] Identical NULL pointer dereference vulnerabilities exist for `pen_=
input` and `touch_input` in other event handlers.
--

commit f0fe30c63ed06d22404bffeeaa7efc7e1da7f7c0
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: fix NULL pointer dereference in wacom_intuos_pad()

This commit adds a NULL check for pad_input at the top of wacom_intuos_pad()
to bail out early when the pad input device was not set up. This prevents
a general protection fault in input_get_drvdata() when a Wacom tablet is
created via UHID with missing interfaces.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..251ddda3ecb3d 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -523,6 +522,10 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>  	bool prox =3D false;
>  	bool wrench =3D false, keyboard =3D false, mute_touch =3D false, menu =
=3D false,
>  	     info =3D false;
> +	int i;
> +
> +	if (!input)
> +		return 0;

[Severity: High]
Does returning 0 here instead of 1 when input is NULL cause the pad packet
to be treated as unhandled?

If wacom_intuos_irq() receives a 0, it falls through to wacom_intuos_inout(=
).
Since wacom_intuos_inout() does not validate the report ID in data[0],
could a pad packet coincidentally matching proximity masks be incorrectly
processed as a pen event, causing spurious events and state corruption?

Should the !input check be moved after the data[0] check, and return 1
to consume and discard the unhandled packet?

[Severity: High]
This is a pre-existing issue, but are there identical NULL pointer derefere=
nce
vulnerabilities for wacom->pen_input and wacom->touch_input?

If an attacker uses /dev/uhid to create a virtual device without PEN or TOU=
CH
collections, pen_input and touch_input remain NULL.

If packets for these missing interfaces are sent, will handlers like
wacom_bpt_touch(), wacom_bpt_pen(), or wacom_intuos_inout() unconditionally
dereference these NULL pointers during input_event() calls or when reporting
out-of-proximity events?

> =20
>  	/* pad packets. Works as a second tool and is always in prox */
>  	if (!(data[0] =3D=3D WACOM_REPORT_INTUOSPAD || data[0] =3D=3D WACOM_REP=
ORT_INTUOS5PAD ||
>  	      data[0] =3D=3D WACOM_REPORT_CINTIQPAD))
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523150101.6114=
73-1-jinmo44.yang@gmail.com?part=3D1
