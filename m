Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40083CF05E
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531901; cv=none; b=cg42frlwTurUtCiFZirRWbTNNYs08O4CKm3lm8fGd48LXSA46fwchc3yl2LaBVHv+JJclvRCK59qx4HWymXrhi8GyixifN94r7VKIW604hw5ia7i/mI6URTEKVsWCTkGqcFNNA2PFVOGZsB90h6EFdsGbC4Wwi25ghctBXyqew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531901; c=relaxed/simple;
	bh=5DxMlZc8KStMjL8aLlJ+EUkgLtxvi7hwPWuLe5U00bw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2IqSBwQV6py6cEOXYmfZifPCetB7D6tYv/ur1XTqVnWEKnWK4YsE4irSm92joLMlHSHV18vO69+v0VVonPt3KgHzHKl/pcjAzuj1QUOSAMiWXaEuhis9WjBDmclcnYZZcSN5uYjoDxWQw6GH5kHtxZuCB50JwENDsxCq+ixf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXjTWYuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXjTWYuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AE41F00A3D;
	Fri,  4 Sep 2026 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531899;
	bh=Nbv9l1jKlzlgDwWM5YvoUeU3jy0Z0Ab7LkKbkhcvld0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jXjTWYuydkN8uW/eEuJZjqK6xj3GM0yV2M/iTKhnQ/ipNUHr4j/ikHdZndYbVZtyU
	 pfRXWlakDg1QUC6T27G82JME3zGQmReEb4EsOMFQfP2zMFbGozb/kfvgzCPO8laybn
	 oSRcpfZkQHwGQOVoVqZx+5cvFnQTT4QhGb4OnIGRg7SnbVxH2yoXHFZjFoXmSh1CbW
	 NbWFo7J/ouH7LBFt3U9uqJVAtFw4y7RiIpJ3HJrmlRhFqoRZkeKPFXXyshU0vKAU3H
	 FHy+K0T4p3ObLF5TJiCcyVMY6bEOAlblTnQ+imtgKD2n1mUzu89/N3I9gNM7DAmGfH
	 lzfjL4VNDEXBw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/2] ALSA: usb-audio: bind the Topping M62's
 vendor controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904141158.33398-3-mikhail.v.gavrilov@gmail.com>
References: <20260904112610.3286659-1-mikhail.v.gavrilov@gmail.com>
 <20260904141158.33398-1-mikhail.v.gavrilov@gmail.com>
 <20260904141158.33398-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:24:58 +0000
Message-Id: <20260904142459.15AE41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Kernel panic due to ERR_PTR dereference if component_match_add() f=
ails on OOM.
--

commit 2f96a32362993ba059fe1ac1ed3ecb8fe309cd34
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: bind the Topping M62's vendor controls

This commit adds a component master for the Topping M62 sound card's vendor
controls to bind the audio and HID sides together. It registers a component
master that passes its snd_card to the HID driver at bind time and cleans
it up at unbind.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..922b0f61cbd41
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +int snd_topping_init(struct usb_mixer_interface *mixer)
> +{
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
Does this code risk a kernel panic if component_match_add() fails during OO=
M?

If component_match_add() fails to allocate memory, it sets the match pointer
to ERR_PTR(-ENOMEM).

The match pointer is then passed directly to component_master_add_with_matc=
h(),
which unconditionally dereferences it when accessing match->num, leading to
an invalid pointer dereference.

Should there be an IS_ERR() check for the match pointer before passing it to
component_master_add_with_match()?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904141158.3339=
8-1-mikhail.v.gavrilov@gmail.com?part=3D2
