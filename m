Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5AD472F67
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522051; cv=none; b=sEs4qQf33sLexAI1CqWrZqQU34t38mawEW0FY6bhctuHlzHTd5VdS9kRjglsfSsP8tVcp9GqoiJgq5yrUwypgu7/2cyOTH3dkxinUz3IpvCjzK0+uUby/BVvanQLKNM6yzcBCn03+GDB17k2hartc+CMUuKB3ij69GjLPkmpUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522051; c=relaxed/simple;
	bh=AfSgiCbkESwqCwk1yTXiaanjxPN1p3S3QE8yeRJtFc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kiWBrRVPAwdhhInOlHOuq/rubyhdUQvHPm5pa7n9N9vte7xWHB4RwFnEN3hHlcIL3V2Ve6a3uRIB0P/deCRq3qiMiXCMh0wJR1BZCuF11fVWCBG4zEi0WHnTXZtdSfT9+6TmUPeOG5LVhW8H997gEc7f4/AGwDuEMWZ1vBP4Htk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5LVOQ67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5LVOQ67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB211F00A3D;
	Fri,  4 Sep 2026 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522048;
	bh=C9JaJ4ybXy7IrkHAIvW5xQqcDsCVTYEKyeS3tyiytQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5LVOQ67AIALeJS/vxgUrSVg2hK6F8znEuY8KyLeLobO/PlM6BIAggwImz/H6fcr3
	 HhrUvRveisssqlw22pSh0jxhLp4rDp/XdzCwPn7Lixg5Vwindo2PyRBMKHXlwS7PcQ
	 UCzB3K6Nqn5BYd4JuP71mwv2N0Rb7avfI29mFwVN+IEZYwKv+yfXgqYZi/E25cwmGW
	 0/s8XtMhm8JIrAhNuxcHDLoQU917OgMjAzmimSMXHtRyAsrGENOwjgOtIkzjlnoYLC
	 BZolRy5y8GFJfqnymDgeSVjYR1AOsZCjIMlqYZJWjk3+E1GjxmK/Ci8pDzCPnqfe8f
	 jWi5uFlEjPGXQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] ALSA: usb-audio: bind the Topping M62's vendor
 controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904112610.3286659-3-mikhail.v.gavrilov@gmail.com>
References: <20260904070530.195389-1-mikhail.v.gavrilov@gmail.com>
 <20260904112610.3286659-1-mikhail.v.gavrilov@gmail.com>
 <20260904112610.3286659-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:40:48 +0000
Message-Id: <20260904114048.8AB211F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing check for IS_ERR(match) after component_match_add() could =
lead to an invalid pointer dereference under OOM.
--

commit ba009c1371d8827cf3c93bcfa9e391f4cb1fd549
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: ALSA: usb-audio: bind the Topping M62's vendor controls

The M62's vendor controls are driven by hid-topping-m62, added in the
previous patch, which speaks a vendor protocol on the card's HID
interface. Those controls belong on the sound card that plays the
audio, not on a card of the HID driver's own.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..922b0f61cbd41
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c

[ ... ]

> +int snd_topping_init(struct usb_mixer_interface *mixer)
> +{
> +	struct snd_usb_audio *chip =3D mixer->chip;
> +	struct component_match *match =3D NULL;
> +	struct usb_interface *intf;
> +	struct topping_master *tm;
> +	struct device *dev;
> +	int err;

[ ... ]

> +	component_match_add(dev, &match, topping_match_component,
> +			    &chip->dev->dev);
> +
> +	/*
> +	 * This returns 0 with the aggregate merely pending when
> +	 * hid-topping-m62 has not registered its component yet:
> +	 * try_to_bring_up_aggregate_device() reports an incomplete set as
> +	 * "not ready", not as an error.  So the card comes up either way and
> +	 * grows the vendor controls if and when the other half appears.
> +	 */
> +	err =3D component_master_add_with_match(dev, &topping_master_ops, match=
);

[Severity: High]
Should we check if match is an error pointer before passing it to
component_master_add_with_match()?

If memory allocation fails inside component_match_add(), it assigns an
ERR_PTR(-ENOMEM) to the match pointer.

Because this unchecked pointer is then passed directly to
component_master_add_with_match(), it gets dereferenced (match->num)
inside the component core. This would trigger a page fault and kernel
panic under memory pressure.

Could we add an IS_ERR(match) check here before proceeding?

> +	if (err < 0) {
> +		mixer->private_data =3D NULL;
> +		mixer->private_free =3D NULL;
> +		devres_destroy(dev, topping_master_release, NULL, NULL);
> +		usb_audio_err(chip, "Topping: no component master: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904112610.3286=
659-1-mikhail.v.gavrilov@gmail.com?part=3D2
