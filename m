Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25941F5EE
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169145; cv=none; b=fc/xz8jL2vR3yXrfHcnqKP4YUsuNRWpxEafWDPPNiYzbSNhR4DQv8o78b4KScc1+oxYbaOUFtHo1ncIj6fMDhfoXGPwhkg65wxabkMSOy7N7aMKaTW7K40kM/hpzxzYRsC+U3XQiYMtb1pwIWB2D9tu3wRLYR3K2vLpInYc3mpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169145; c=relaxed/simple;
	bh=y9APjsCRhi1maplM4z4b8sgwqliHwFLfJaCljJk1EeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b2I3pJB30+N9NTeabkX7VFsTOw8yI7fb3XEPKL5t8ODNyUfiZ5Q4BdZoxuf19tNKQCotefmZR3kKKXIyD3bpI29aKNydinki+TLRe+wsPCoXT9iyn0RR9D3bWb5lFEvUkO+oKsrXNeJe4NzkV8Q3JxJRZOycGIPFVkZYX3wqGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkM0q10G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkM0q10G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C6B1F000E9;
	Mon, 27 Jul 2026 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169143;
	bh=JXmO29m3KMn7HJWqU4xlMYHLnJew+J97TdjYTCcqXx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HkM0q10GlyWZ2h4lD7JCz1MLdu0rvO+fTT0EJkQbySyJsO5sFIrinOs9hbkZ/3upy
	 HxAgYwdPvwYXy+7op8cUNXNOiyYdGdh87HVdPMvyN9v8ZjP0cUAX0MdnKq67l1WatZ
	 zzGaYjqoyMy92suMGoTl3g4Wyy/hZKMeh5c9O7Mnf9UwRIB3jT8NOmJ0NSPX+kxvbw
	 mBQ3J2E+JdULXQF707PpPsrzLkwl6lpOPPTNLnU8W4Tz/MiKbzG+mFwIo54XqZFQNZ
	 YpMxhXDOOyaposqW9xTaIcSymonE1Ig02/+fnYWaYxa+FLlQVHceGMOiwFb4RXcBp3
	 Jmi287bvxPotA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - add out-of-bounds checks for xpadone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin@kroah.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260727-xpadone_length_checks-v1-1-19aa9331e82d@kroah.com>
References: <20260727-xpadone_length_checks-v1-1-19aa9331e82d@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:19:02 +0000
Message-Id: <20260727161902.B4C6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Early returns during packet processing bypass `input_sync()`, leav=
ing previously reported events unsynchronized.
--

--- Patch [1]: [PATCH] Input: xpad - add out-of-bounds checks for xpadone -=
--
commit 8c34b8de402ad35f3c36f154396b4b591175f380
Author: Griffin Kroah-Hartman <griffin@kroah.com>

Input: xpad - add out-of-bounds checks for xpadone
   =20
Add size checks for the len variable in xpadone_process_packet() to
prevent out-of-bounds accesses to the data buffer.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1079,6 +1087,8 @@ static void xpadone_process_packet(struct usb_xpad =
*xpad, u16 cmd, unsigned char
>  					 error);
>  		}
>  	} else if (data[0] =3D=3D GIP_CMD_INPUT) { /* The main valid packet typ=
e for inputs */
> +		if (len < 18)
> +			return;
>  		/* menu/view buttons */
>  		input_report_key(dev, BTN_START,  data[4] & BIT(2));
>  		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));

[ ... ]

> @@ -1145,13 +1155,18 @@ static void xpadone_process_packet(struct usb_xpa=
d *xpad, u16 cmd, unsigned char
>  		}
> =20
>  		/* Profile button has a value of 0-3, so it is reported as an axis */
> -		if (xpad->mapping & MAP_PROFILE_BUTTON)
> +		if (xpad->mapping & MAP_PROFILE_BUTTON) {
> +			if (len < 35)
> +				return;

[Severity: High]
By returning early here, do we bypass the synchronization of the standard=20
buttons and axes that were already reported earlier in this function?

If the controller sends a valid base GIP_CMD_INPUT packet (>=3D 18 bytes) b=
ut=20
shorter than 35 bytes, this early return skips the do_sync =3D true assignm=
ent=20
and the final input_sync() call at the end of xpadone_process_packet().=20

Would this result in standard inputs becoming unresponsive since the events=
 are=20
buffered by the input core but never delivered to userspace?

>  			input_report_abs(dev, ABS_PROFILE, data[34]);
> +		}
> =20
>  		/* paddle handling */
>  		/* based on SDL's SDL_hidapi_xboxone.c */
>  		if (xpad->mapping & MAP_PADDLES) {
>  			if (xpad->packet_type =3D=3D PKT_XBE1) {
> +				if (len < 33)
> +					return;

[Severity: High]
This early return, as well as the ones below for PKT_XBE2_FW_OLD and
PKT_XBE2_FW_5_EARLY, appear to have the same issue. Do they also skip=20
input_sync() for the standard inputs?

>  				/* Mute paddles if controller has a custom mapping applied.
>  				 * Checked by comparing the current mapping
>  				 * config against the factory mapping config

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-xpadone_le=
ngth_checks-v1-1-19aa9331e82d@kroah.com?part=3D1
