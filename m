Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579B34752D
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838521; cv=none; b=kyG2oIMUko7YjSTHS8UKo6ga9nJ6ZOL0pa2dVVjq4WNr0enNfGr46G8GL9Amuwf5Rnri16C4ibZsTmr5e2dZyf6V6S202cExyJRdc4maAJEyl8vLwtIrmTtvOU5J/nDvDPCdY+duq2S2qkL0rve8iMugjOjS6AHnIbVc5bYjVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838521; c=relaxed/simple;
	bh=6S/JWagxo3CnNMfpHjEU9jm9LUgx0j2vVIhGk4gcrkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uSIIGh5h4dv9Nx2TW1qqWEUaXXOpjB7+D5XwJ6LEnuP+ByddXPAk1DFi0DSpeW22e61vjpzhAgxXonE6ER0xx7GEIBieQiajWFFLHMsZAuQViz3c7IO4rQQ8xfeeaJ8Hg0A0RllKb1P2Z0H6SniVCz2jxDsAAzRdY+PcQLoW8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeXMb5+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeXMb5+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8231F00A3D;
	Tue,  8 Sep 2026 03:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788838513;
	bh=k2SRaymVTr+g2Hx9yQSY3KDCagMNppfIRipCEv6C7U8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GeXMb5+i+Vp14HSsruutQfRZRScncxlrOJMD001cl1xoOVKRHeKvQw9Odt+yzfc4I
	 2SOInhx0sX1bAyMeutq1zyetrMyASb5N6BGKcJYb9ppAOEqHkPtE9xGnQ6w7XOYZNq
	 73xdx5jGxZqwYwIN+32QOcW+Inb9AEmsbEMzOIb/IoFLRbaqiNs9qx+vVZbQNrKZqD
	 nylCZyyeRiZv/yPC2Xo60G9Vt7Lb3vU1q7RGzvvt1hF+Gl/cbiPXq3e7wkOgTCcYle
	 8qcCECcsFyvNmhYvXxmH473MXDbgTsU0uNglrORzzBGDsyiKYMvLzweZC+UMzvPRyN
	 PkOig9P6kpDXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/12] Input: xbox_gip - Add arcade stick support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260908032145.2118234-9-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-9-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:35:13 +0000
Message-Id: <20260908033513.6A8231F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `gip_handle_arcade_stick_report` function returns `-EINVAL` =
on short packets after successfully reporting key events, bypassing `input_=
sync()`.
--

commit 52729645cd0e478b1045c3e2e7b193ab5b91d1c7
Author: Vicki Pfau <vi@endrift.com>

    Input: xbox_gip - Add arcade stick support
   =20
    This adds support for the arcade stick device type. Currently I'm only
    aware of one Xbox controller that uses this device type, the Razer Atro=
x,
    so testing coverage is limited.

> diff --git a/drivers/input/joystick/gip/gip-arcade-stick.c b/drivers/inpu=
t/joystick/gip/gip-arcade-stick.c
> new file mode 100644
> index 0000000000000..11ededfab8555
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-arcade-stick.c

[ ... ]

> +static int gip_handle_arcade_stick_report(struct gip_attachment *attachm=
ent,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	struct gip_arcade_stick_info *info =3D attachment->driver_data;
> +	int rc;
> +
> +	if (!info)
> +		return -ENODEV;
> +
> +	rc =3D gip_driver_navigation.handle_input_report(attachment, input, byt=
es, num_bytes);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (num_bytes < 6) {
> +		gip_dbg(attachment, "Discarding too-short input report\n");
> +		return -EINVAL;
> +	}

[Severity: Medium]
If the input report packet is between 2 and 5 bytes long, does this sequence
skip the required input_sync() call?

gip_driver_navigation.handle_input_report() will successfully process the
first few bytes and queue key events. Returning -EINVAL here propagates the
error to the caller, which then aborts and skips the input_sync() call for
the already queued events.

Should the size check for num_bytes < 6 be performed before delegating to
the navigation driver to prevent leaving unsynchronized events in the input
core?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D8
