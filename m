Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C03FE362
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427288; cv=none; b=JRR8sZxPXYihquZNUJj5cYDjM9DH3+cNk34ic3nvGMQbLFTNi+NOpK7aPtRqHcxq2gOBAg8XFWm0UuEAtNk1f6ORhOvbZZ5PoBUniH/S7I1G+X7KSO8TOR7elrVqdhw1MYs4ZF9PsRxU/jSi+OvPcWJiOC65+tJxnmur3Ic3jcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427288; c=relaxed/simple;
	bh=fywrpQXlnYOOhLu0x+/WD5dcuhGuG428ILhzPkigOlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c9JG/h8vEcF6v7xNFJZTkKZX4bS7Z74j4EYsS5iJ8AB0DCx8fmsE98lx4LhsIlv5EKsadER8+AtShCRuhZ19hs1bg1MhMZjo0SgTUAhDAfmYfm/muPv9ot6ASinPKC8gDyxJ69djNvzZIm6wl6MFD1CgS9WAQ63YzDFmDKzFaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwKn8OGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwKn8OGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFE11F000E9;
	Tue,  7 Jul 2026 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783427286;
	bh=PeSc+1w+J7ueeXCzhukn8wjwqi7M7qOJkP09DpHg/f0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VwKn8OGneJa0WdkOUkBYApf/M3KnlB75gR+tGeDx7Ym54u2FjWhEQvdXJl+sGjU4u
	 3eEfd6o41nJAGPzmaDPE5uQc9kmu7XxVnvz5VYDBRUzgx/XprWXGbX2O2QRcB0E+Oj
	 3dWkRQJHWC2PHN5F3CZpi1U2Gr7x1wcCwstuABnx8VYoUT46NkljUNR+anHYgKFOJa
	 Bp0spuxfkNMa4VOPlDfz2MgnDrNQeyI2BZkQdLKEpNitIw8V4Dt3T+hfA1paQkOdhZ
	 0OAvV9OTBKdMVqgV5OvmkDkf6M2xm70lyLcGoKngYg0v4QYIfmjrhmHtI+XW4q939I
	 5um7QItLd2Ofw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260707121051.1683937-1-lee@kernel.org>
References: <20260707121051.1683937-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 12:28:06 +0000
Message-Id: <20260707122806.AAFE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving the `SW_MUTE_DEVICE` capability assignment into `wacom_setu=
p_touch_input_capabilities()` silently breaks the mute switch feature for g=
eneric Wacom devices due to interface probe ordering.
--

--- Patch [1]: [PATCH 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability =
prior to registration ---
commit 36a40be02315e2e469201d6490c033d8bc04fa73
Author: Lee Jones <lee@kernel.org>

HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration

This commit moves the SW_MUTE_DEVICE capability advertisement into
wacom_setup_touch_input_capabilities() to ensure it is set prior to input
device registration, conforming to input subsystem guidelines. It also
removes the post-registration assignment in wacom_set_shared_values() and
simplifies some product ID checks.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f75..6c2a3ddfe366a 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2359,12 +2359,6 @@ static void wacom_set_shared_values(struct wacom_w=
ac *wacom_wac)
>  			wacom_wac->shared->is_touch_on =3D true;
>  	}
> =20
> -	if (wacom_wac->shared->has_mute_touch_switch &&
> -	    wacom_wac->shared->touch_input) {
> -		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> -		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
> -				     SW_MUTE_DEVICE);
> -	}
>  }

[ ... ]

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..a31325be50f8c 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3951,6 +3951,8 @@ int wacom_setup_pen_input_capabilities(struct input=
_dev *input_dev,
>  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>  					 struct wacom_wac *wacom_wac)
>  {
[ ... ]
> -	if (features->type =3D=3D HID_GENERIC)
> +	if (features->type =3D=3D HID_GENERIC) {
> +		if (wacom_wac->shared && wacom_wac->shared->has_mute_touch_switch) {
> +			input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> +			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> +		}
>  		/* setup has already been done */
>  		return 0;
> +	}

[Severity: High]
Does moving this assignment inadvertently break the mute switch on composite
USB devices?

For multi-interface generic Wacom devices, the touch interface typically
probes before the pad interface. During the touch interface's initializatio=
n,
this checks wacom_wac->shared->has_mute_touch_switch.

Since the pad interface (which contains the mute switch usage) hasn't been
parsed yet, has_mute_touch_switch will still be false.

Because the fallback assignment in wacom_set_shared_values() was removed
above, will this result in the SW_MUTE_DEVICE capability never being
advertised to the touch device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707121051.1683=
937-1-lee@kernel.org?part=3D1
