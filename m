Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F94FDE76
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542208; cv=none; b=JAvgqef0npy3PRh9VhoBHJST+KTAuWc3MyIWPMV+s45K9VvbyLjx88O7kr4IqPXcO3xuxGB8M9D9FItQ9ixK8GGsAV6RKoUhh13zc4JEyY6906Z5ODrESBjCxDS33cl/p7VuKwy7hnorKnsvz4MHq46icz6eS/pQrDqZvtalYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542208; c=relaxed/simple;
	bh=oG9i3YH4mjn7DiGoGWrca8vvSqh6kNw4/n81jv6vzhw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OthCIZohgLVVWvnoBf6nCCWSPtmqFXFgJiCmPBZdroyosyFV8HD5g59xUACBm4gll8tnFyJstRUiakajC+C0A9Rg0/jY2nfhwEeWTW1u6+OxqYkPeIfNxc9UAWl/55FdFD2mlT8gi68J138+lEl/Ob/kZ25hDl5L6LJrgKEy5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1hnDTVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1hnDTVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5301B1F00A3D;
	Fri,  4 Sep 2026 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788542206;
	bh=L4c5UyrEzdXzBzMEpdWFdJUBWMY2YxbLGUdxN2NOKpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o1hnDTVr75ZBIGCQ4MU50w15j+OAdGHb9P3BMyv4nr23s1bOaT3a3itNBkWRNKzer
	 PQjprBVZqnDg5waC8Ca126x/2k7d/ev+YBSD4dx99w6uyRW5y/luk/WEiyycl4r8Md
	 +Oyoc2it1E4WLgomOMzlkyX2fHHe22X0n3+mBlrUilHhHbJuIotVFKdU972u9VFMR0
	 ABI5UmWgizg/01No/bd6lX0I4MROHz6MqIrSMf6lPiKwOhW3pJEi3dPTAQBayln5Xe
	 oBGVjoO5Pfo6mbvDENgnBs0VGualbvHvHqXSGhuImc4S1oL2/JHNOqIcZ5ToirWTMD
	 l/LJk7+V2GS7g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 2/2] ALSA: usb-audio: bind the Topping M62's
 vendor controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904165848.3940603-3-mikhail.v.gavrilov@gmail.com>
References: <20260904162236.3212370-1-mikhail.v.gavrilov@gmail.com>
 <20260904165848.3940603-1-mikhail.v.gavrilov@gmail.com>
 <20260904165848.3940603-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:16:45 +0000
Message-Id: <20260904171646.5301B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition between devres unwinding on a failing secondary int=
erface and snd_usb_mixer_disconnect leads to Use-After-Free of `struct topp=
ing_master`.
--

commit 5c451ddb148b4a001ba73165f1af998978db8641
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: bind the Topping M62's vendor controls

This adds a component master for the Topping M62's vendor controls to conne=
ct
the USB audio interface with the HID interface. The lifecycle context is
stored in devres on the audio control interface.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +static void topping_master_teardown(void *data)
> +{
> +	struct topping_master *tm =3D data;
> +
> +	component_master_del(tm->dev, &topping_master_ops);
> +
> +	if (tm->mixer) {
> +		tm->mixer->private_data =3D NULL;
> +		tm->mixer->private_free =3D NULL;

[Severity: High]
Is there a missing lock here when clearing the mixer's private fields?

If usb_audio_probe() fails on a secondary interface, devres is synchronously
unwound and topping_master_teardown() runs while the orphaned mixer is still
in chip->mixer_list. If an unbind happens concurrently on the first
interface, snd_usb_mixer_disconnect() can race with this teardown.

Since snd_usb_mixer_disconnect() reads mixer->private_free without holding
register_mutex, modifying these pointers without synchronization introduces=
 a
Time-of-Check to Time-of-Use (TOCTOU) race.

> +	}
> +}
> +
> +static void topping_private_free(struct usb_mixer_interface *mixer)
> +{
> +	struct topping_master *tm =3D mixer->private_data;
> +
> +	if (!tm)
> +		return;
> +
> +	/*
> +	 * Reached from snd_usb_mixer_disconnect(), on an unplug and on an
> +	 * unbind of the audio interface alike.  The action clears
> +	 * mixer->private_data on its way through, so nothing is left
> +	 * pointing at the storage dropped below.
> +	 */
> +	devm_release_action(tm->dev, topping_master_teardown, tm);

[Severity: High]
Could this dereference tm->dev after tm has already been freed?

Due to the race condition described above, snd_usb_mixer_disconnect() might
read mixer->private_free just before it is cleared by
topping_master_teardown().

If the teardown finishes and devres frees the struct topping_master memory,
topping_private_free() will then be executed with a freed tm pointer,
leading to a Use-After-Free when accessing tm->dev.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904165848.3940=
603-1-mikhail.v.gavrilov@gmail.com?part=3D2
