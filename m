Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27484CA770
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805025; cv=none; b=tlwt73SPMw2LawNwo/V9Vm8CIGoMFCJ79werIHqtqKcdWduOF5RixoxJCp2wXvLlax4zCKPfS5luFOYTIpTBsaW6WYLcznU36PFWdWpgcVt3YYUEgK4HtDc64Lf5LWXsYywX6zAXdsRYwI69LeywnzxTEuaP6Y4G+XdZ2YFMFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805025; c=relaxed/simple;
	bh=+ONQELpP+tcawXjGi+Yo6CgI9tgyASer0ZfjiG2JDSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lW8RVP1KCrgnKqlxmTxFvM43lgpIac1NMbnHDxLkSF599I341Yb3e+tv3blujbF8vUeQa3gARsQ1pJ3EMzxwVEOIULgjm5mXrBUsrCmsHW4ADsVcpaSdwZS/8o+s21HTb0AC7wlmOnQ2sxAWK1R/wvoBSvgVQrxJn0622FLhWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APfFd5Lf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APfFd5Lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C5A1F00898;
	Wed, 30 Sep 2026 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805023;
	bh=9FUTnoGnYVvyiNNjXtc7HjUivjfDOnR7r2WtDhE1hu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APfFd5Lf/Q6uREoxA9Hujlw2fud7CDMemEPve1HBnGgkGEhP42JJ0DMpcxgHzbvT9
	 4LZkmJ6ubMANGMS+b126vxM8LRQKGsvtWWV1lj/28iDgRF8SNKvx3Uwm+JKWVWh7UZ
	 gi2h6uJeev7/hKPa/EHBIyO2SvNfRmdzVIQC2hBN/Azl/JxK/YEX5aloqRjPiy/A1X
	 AdN4o31srcwHOqwxkOIPsga63V6l/kqEpGYqPgHWH10W4KK/HV1xJ06HSF44ANSq3t
	 y6yk4k1NMQkpDlT94LhqJ0eQwY6D1HjG9DHP57VubN2ssNgDOiSzhxoCZEizMggNDg
	 tRutvVHahnllw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] ALSA: usb-audio: bind the Topping M62's vendor
 controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260930213322.32454-3-mikhail.v.gavrilov@gmail.com>
References: <20260930213322.32454-1-mikhail.v.gavrilov@gmail.com>
 <20260930213322.32454-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:50:22 +0000
Message-Id: <20260930215023.39C5A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] sound/usb: Use-After-Free in topping_private_free() via TOCTOU=
 race
--

commit a868f2097e7f0e27683675ee55b1cecdef99afcf
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: ALSA: usb-audio: bind the Topping M62's vendor controls

This patch introduces a component master for the Topping M62's vendor
controls, binding them to the hid driver that speaks the vendor protocol.
It utilizes the component framework and devres to manage the lifetime
of the controls when either the audio or hid interfaces bind and unbind.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..5557bc41f05f0
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
> +	}
> +}

[Severity: Critical]
Can this clearing of mixer->private_data happen concurrently with
snd_usb_mixer_disconnect() without synchronization?

If a secondary interface fails to probe after creating a mixer,
usb_audio_probe() returns an error but leaves the mixer on the card's
mixer_list because chip->num_interfaces > 0.

The driver core then unwinds devres for the secondary interface without
holding ALSA's register_mutex.

Concurrently, if the device is unplugged, snd_usb_mixer_disconnect()
iterates the mixers and invokes:

    if (mixer->private_free)
        mixer->private_free(mixer);

Does this lockless teardown open a time-of-check to time-of-use race window
before the tm context is freed by devres?

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

[Severity: Critical]
Could this dereference of tm->dev result in a use-after-free regression?

If snd_usb_mixer_disconnect() reads mixer->private_data into tm, but is
then preempted by the concurrent devres unwind, tm could be freed before
devm_release_action() is called.

For example, could this sequence occur:

cpu2 (snd_usb_mixer_disconnect)
topping_private_free()
   tm =3D mixer->private_data;

cpu1 (devres unwind)
topping_master_teardown()
   tm->mixer->private_data =3D NULL;
   devres frees tm

cpu2 (snd_usb_mixer_disconnect)
   devm_release_action(tm->dev, ...)

Is there any synchronization missing here to protect against this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930213322.3245=
4-1-mikhail.v.gavrilov@gmail.com?part=3D2
