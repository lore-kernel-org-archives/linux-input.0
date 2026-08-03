Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7131E857
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770827; cv=none; b=B8y0QZZurILljplCs6DlZ3HxwHV/vockeDHpBmmeEAL0+hpIll2lV3SHSxb4JSAAAvFpq1bjB1jaA8ozajyH9XfyheE3yJwWlH7jNnmr2ZGKJA/UGi5BF4SQefcGXlqNJeuyHFPNF/Bcqo2OwIzRCmH9T56tA/KypBDgHKJosUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770827; c=relaxed/simple;
	bh=VZEjzMpxcTvM6YsCU/0St4AXN2NnztvNTMmBiP9hmNQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t4MjQHD9nPCUavyPbEwVyb35l3L4JfcHafzrujDldumbv0pwEHAFTjrwS0lyd8HA06gu8Fm6yFpnjBk3016m1CKT4finnul9vFvA+buxIUvtaANJ9NCxZEYBiVWpnfLdysK65LRwwFOiO3XqABpBPXShk/fzDxtHtCZ9x0VQ0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8Ic5NaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8Ic5NaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B0C1F000E9;
	Mon,  3 Aug 2026 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770825;
	bh=bS66Ext+hO6Kc+CnsK32nQaWGGuKWhYF0btNJcyzpdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J8Ic5NaK26ImkoQ+1yo/r2zyKErgVzaE2seF1rCBekR3ZVTEbV4yX1n4yt4CSFpSH
	 n2luUBXjYvopq+9UoJDtNhqVliDwUjMMAnJRLNBtPls5PSyqdBZPy7JDSGe6K3UhGY
	 YrGP0QJApZKdEQ9f0QtvLoJMjQiH2OV6daKi2xgnEuY1Oy0uEvYABgHeR33P+NsnNz
	 KrwB4eJGuawgD3VCLJgz9wUPadeQ+fzyoAcenJqiEgip4GN3wFSr24pvzLgODqqxcU
	 +nHh41atJwVNecdAOm0XilxcQzxtMMhWxIF26VVMLv1E6qcAS3hNcFIkf36AprtlcC
	 Snho/L1p0OxYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] Input: xpad - add safer data access framework
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin@kroah.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260803-xpadone_packet_fix-v1-1-280da203f15c@kroah.com>
References: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
 <20260803-xpadone_packet_fix-v1-1-280da203f15c@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:27:04 +0000
Message-Id: <20260803152705.63B0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Processing GIP_CMD_ANNOUNCE can trigger sleeping functions from an=
 URB completion handler.
--

--- Patch [1]: [PATCH 1/3] Input: xpad - add safer data access framework ---
commit 852b38f29eb8d0217357629e77fd629842b2aed4
Author: Griffin Kroah-Hartman <griffin@kroah.com>

Input: xpad - add safer data access framework

This commit introduces a safe_data struct and a safe data check function to
prevent reads and writes outside of the data buffer bounds.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..c516860711a82 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -1078,44 +1100,49 @@ static void xpadone_process_packet(struct usb_xpa=
d *xpad, u16 cmd, unsigned char
[ ... ]
> -	} else if (data[0] =3D=3D GIP_CMD_ANNOUNCE) {
> +	} else if (sdata_check(&sdata, 0) =3D=3D GIP_CMD_ANNOUNCE) {
>  		int error;
> =20
>  		if (xpad->delay_init && !xpad->delayed_init_done) {
>  			xpad->delayed_init_done =3D true;
>  			error =3D xpad_start_input(xpad);

[Severity: High]
This is a pre-existing issue, but does this code path trigger sleeping
functions from an atomic context?

When an Xbox One controller sends a GIP_CMD_ANNOUNCE packet on the irq_in
endpoint, the URB completion handler (which runs in atomic softirq context)
processes it via xpadone_process_packet().

If xpad->delay_init is true and initialization hasn't completed, it calls
xpad_start_input(), which subsequently uses GFP_KERNEL:

xpad_start_input() {
    ...
    if (usb_submit_urb(xpad->irq_in, GFP_KERNEL))
        return -EIO;
    ...
}

Additionally, xpad_start_input() calls xpad_start_xbox_one(), which makes a
synchronous blocking call that sleeps:

xpad_start_xbox_one() {
    ...
    error =3D usb_set_interface(xpad->udev, GIP_WIRED_INTF_AUDIO, 0);
    ...
}

Could this lead to a scheduling while atomic kernel panic when a device sen=
ds
this command during URB completion?

>  			if (error)
>  				dev_warn(&xpad->dev->dev,
>  					 "unable to start delayed input: %d\n",
>  					 error);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-xpadone_pa=
cket_fix-v1-0-280da203f15c@kroah.com?part=3D1
