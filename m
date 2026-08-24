Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43A386C3E
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603161; cv=none; b=EddOHcJGi7YWqDPHNmsTHahGG3QlcqF9OMwpz0XaZhlNQkQ3Emp2zl7QMr5vvCxME+VFXc9bVskz8edUis8bRRRIzenelcatQgifGvIn9KnfXzbERgJtCsztNAbyHVoMSi/+c95vTGeR0WJW3SFbRM4vu7y4x5TwR2Gcg4dlv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603161; c=relaxed/simple;
	bh=wUWJ0XlERMOYBrynQnbWMg5aGrT6YRRKZ3WTkmRXie4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nhU8xiaK0bNWY3Vd2c9hXl3NHobFgHCaktZ95R0Z80CqKPG2bKNEs9Aq1OEAlZRTv2p2BzVoMNZQ7qlnnCGGSRUsFnw5Tv4MeRljFcaKqlulBcvZcTXkZSbo9XQMVDu212O9uqaShr0DidLH9bS/hEvQHxKRHSeNyrAPPvwWI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faBEHPco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faBEHPco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A451F000E9;
	Mon, 24 Aug 2026 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787603160;
	bh=p1Zpt4S/SuOUWHYXeUwl7yzgsxVvFeHdW8GcIQnv+mo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=faBEHPconbNyWCRjH9V/RsGxOjifxdnc/F80PM+OSUWDzK/7TPHRT5NutfDNYHleP
	 wSOvFRjz96mKeN07g3E91WW3tARDrDSvfwREvoVI1OdGaIpIQzHHMIvKbJt5tzNbp4
	 HNZ4XhLyFCh6pJ2rpZhTJj/OAckSx6G/IycQWR6VXUmFTvhFCmtOygz5ZkUB+G3Oa7
	 77jkdrQhvvVboydEGWxxlPLciNN/JSeLBmhNkh0+m6Ucu22TDI27bbjZ9bBNHFDos8
	 LQQ2FHHxWytDXWyfCEp7o4ua964V31MraIVz5HsPnRLXy4f3CXraHIPa6ko2/IiW7d
	 Vhnmq8RPJzbFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] ALSA: usb-audio: let the M62's outputs say what
 they listen to
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260824201331.304705-3-mikhail.v.gavrilov@gmail.com>
References: <20260823222946.171345-1-mikhail.v.gavrilov@gmail.com>
 <20260824201331.304705-1-mikhail.v.gavrilov@gmail.com>
 <20260824201331.304705-3-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 20:25:59 +0000
Message-Id: <20260824202600.51A451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Self-deadlock (AB-BA) on tm->write_lock during USB runtime resume.
--

--- Patch [2]: [PATCH v5 2/2] ALSA: usb-audio: let the M62's outputs say wh=
at they listen to ---
commit 3dbac150fa1280d6dbcdfa425bfa48831578b8a0
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
ALSA: usb-audio: let the M62's outputs say what they listen to

This patch adds ALSA controls for output sources on the M62 USB audio
interface, allowing the selection of internal mixes, inputs, or playback bu=
ses.
It exposes these options to the user and ensures the device state is update=
d,
including restoring choices upon resume.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> index 2f42b26336266..1743b8ee7facb 100644
> --- a/sound/usb/mixer_topping.c
> +++ b/sound/usb/mixer_topping.c

[ ... ]

> @@ -342,6 +382,66 @@ static int topping_ctl_put(struct snd_kcontrol *kctl,
[ ... ]
> +static int topping_sel_put(struct snd_kcontrol *kctl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
[ ... ]
> +	guard(mutex)(&tm->write_lock);
> +
> +	/*
> +	 * "Unknown" is what this control reports until a hand has chosen,
> +	 * and alsactl stores and restores it like any other value.  It is
> +	 * not a choice, so writing it changes nothing -- quietly, rather
> +	 * than failing a restore of the driver's own report.
> +	 */
> +	if (!item || tm->sel[elem->control] =3D=3D item)
> +		return 0;
> +
> +	d =3D &topping_m62_enums[elem->control];
> +	err =3D topping_send(tm, d->target, d->prop,
> +			   topping_source_value[item]);

[ ... ]

> +static void topping_restore_sel(struct topping_mixer *tm)
> +{
> +	const struct topping_enum_desc *d;
> +	int i;
> +
> +	guard(mutex)(&tm->write_lock);

[Severity: High]
Could this cause a self-deadlock if the control is changed while the device
is in runtime suspend?

If a user modifies the ALSA control while the device is suspended,
topping_sel_put() acquires tm->write_lock and calls topping_send().=20

Inside topping_send(), the USB shutdown lock is acquired which triggers a
synchronous runtime resume. This will invoke the resume callback on the same
thread:

topping_sel_put()=20
  -> topping_send()
    -> pm_runtime_get_sync()
      -> usb_audio_resume()=20
        -> topping_resume()=20
          -> topping_restore_sel()

Will topping_restore_sel() then block indefinitely trying to acquire
tm->write_lock since Linux mutexes are not recursive?

> +	for (i =3D 0; i < TOPPING_NUM_ENUMS; i++) {
> +		if (!tm->sel[i])
> +			continue;	/* nothing was ever chosen */
> +		d =3D &topping_m62_enums[i];
> +		topping_send(tm, d->target, d->prop,
> +			     topping_source_value[tm->sel[i]]);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824201331.3047=
05-1-mikhail.v.gavrilov@gmail.com?part=3D2
