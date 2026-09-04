Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D54F0554
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534720; cv=none; b=WTEDGodUJgmAhp2dVevSiwWrwqDg0al8lqMVbBWczmjmq1EM7ttimbZV33XWEKOGU1XijevBI3MV5w6J1oZ4p+DWojJEvD8RB1tyFoPDdVY+i9KPxhnbNDjqLa+tDiKsbQ6q7odC/cvMOKJPDHMMPQJTA45lKJMNUxYTQhT0W8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534720; c=relaxed/simple;
	bh=dSDAGSGdeMYfU5TFBDGyvhEuA4jGnTzqs/AquFxd5NQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NXgUm5eEr5vcE5P7ZfnPQ42dGAs/lne6f9M3tq97fniwFZa8Z8tj/U8W01NFTvFF/eoWLJeN/mrrzYX/Ij/rnbSzc7Cy40E15WGcCaD6kScFBGed19RI1t9VvnPt8oWZaACrV4SGSwDby5ns97HOQmXmYb3pfomDYOiSoK13bO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDNVjiyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDNVjiyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85601F00A3D;
	Fri,  4 Sep 2026 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534718;
	bh=Wu7YYfGQTcn8eWF9uXPVhM89DbgWcWWtI3Ufhi2xQus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lDNVjiyArIH53M25FCWtW7DNF8p8G2DrAfiApYHD9rU+ta/cvcIZf3t52lrhfxeP5
	 E0BHEqzgjcFtqyhad2wCrIf/m0dPoPY3+1O1L3xR0Cea2f4aYRyU+1lvshwUWgqqUZ
	 ylKqluzU7BIAewFgMRPu9XyWXmbfFrk3qdwlkI/Pr6+CiEiyElijrC3aPCP6L3Qy1n
	 DcglJGsxUvBTsmL0RxeTkrKsxMJdBZkKTh9VIoIvIccV3xVAhGzXYHvQvM6LRpJZIQ
	 Jmu5nfjPVgZV3cH/N87lw1LiHJ7WrGDe6Ubbad4TvxJFF8FIWb2G52JhoxB/YqraG0
	 7jrRHDslPKjWw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/2] ALSA: usb-audio: bind the Topping M62's
 vendor controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904144300.529289-3-mikhail.v.gavrilov@gmail.com>
References: <20260904141158.33398-1-mikhail.v.gavrilov@gmail.com>
 <20260904144300.529289-1-mikhail.v.gavrilov@gmail.com>
 <20260904144300.529289-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:11:57 +0000
Message-Id: <20260904151157.D85601F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-after-free of `tm` devres allocation in `topping_private_free(=
)` when probe fails on a secondary interface.
--

commit 609b467189291cd5e9a1099df6471716a2475cca
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: bind the Topping M62's vendor controls

This commit adds a component master for the Topping M62 vendor controls
to bind the ALSA sound card to the corresponding HID driver. It uses the
component framework to manage the lifetime between the ALSA card and the
HID vendor controls, allocating its context using devres on the audio
control interface.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..d97d895a4493d
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +static void topping_private_free(struct usb_mixer_interface *mixer)
> +{
> +	struct topping_master *tm =3D mixer->private_data;
> +
> +	if (!tm)
> +		return;
> +
> +	/*
> +	 * Reached from snd_usb_mixer_disconnect(), on an unplug and on an
> +	 * unbind of the audio interface alike.  component_master_del() runs
> +	 * topping_master_unbind() on the way, so the HID side has taken its
> +	 * kcontrols off this card before the card is taken apart.
> +	 */
> +	component_master_del(tm->dev, &topping_master_ops);

[Severity: High]
Can this result in a use-after-free of the `tm` structure if probe fails on=
 a
secondary interface?

If a USB device matching the Topping M62 quirk has multiple interfaces, and
the primary interface probes successfully but the secondary interface's pro=
be
fails (e.g., due to ALSA card slots being exhausted or memory allocation
failure), the USB core will clean up the secondary interface's devres, free=
ing
`tm`.

However, looking at `usb_audio_probe()` in `sound/usb/card.c`:

    if (!chip->num_interfaces)
        snd_card_free(chip->card);

For a secondary interface (`chip->num_interfaces > 0`), the ALSA card and
`chip->mixer_list` are intentionally not freed when probe fails. The mixer
appended during the failed probe remains in the list.

Later, when the primary interface unbinds, `snd_usb_mixer_disconnect()` is
called and invokes this `topping_private_free()` function, which will access
the already freed `tm->dev`.

> +	devres_destroy(tm->dev, topping_master_release, NULL, NULL);
> +	mixer->private_data =3D NULL;
> +}
> +
> +int snd_topping_init(struct usb_mixer_interface *mixer)
> +{
> +	struct snd_usb_audio *chip =3D mixer->chip;
> +	struct component_match *match =3D NULL;
> +	struct usb_interface *intf;
> +	struct topping_master *tm;
> +	struct device *dev;
> +	int err;
[ ... ]
> +	tm =3D devres_alloc(topping_master_release, sizeof(*tm), GFP_KERNEL);
> +	if (!tm)
> +		return -ENOMEM;
> +	tm->dev =3D dev;
> +	tm->card =3D chip->card;
> +	devres_add(dev, tm);
> +
> +	mixer->private_data =3D tm;
> +	mixer->private_free =3D topping_private_free;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904144300.5292=
89-1-mikhail.v.gavrilov@gmail.com?part=3D2
