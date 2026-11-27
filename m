Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764487;
	b=dN0Ks2oPI5xboO7NoJqHiVBmt4QGDmskA4AEpUv/RM3z/VDYGNuVyu5f4QbM2OJcRsUF
	 FLfb02lmtcmkKsTe699HFW+F2V7JX0puIg3fEaQ6V2KuCuPqX0NTCXFkvt8/4TGYt/+iu
	 /hzLrAT33HL1MzuENrNWT3FW6KwAfzUv41If4p2nffqEe/f+IGOB1GygHbVcms6Cg0KV9
	 oKum3KDzhxdsYnYZeaqfG9c0MwAdAm3PilMIji4/UmdN/Ec/HJocSXyc/maPlu9BMCI8z
	 VprO2kdXLq64yrBKo73FGHdDnfflVSkZ3zCkQLe+2F3mIS6sJcTZ2sP3CO+XoRoLXyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uCHYnKWdXBzFKgXQ2sEIjTFEuNAmZ3VEH0yuYh5/fHQ=;
	b=rrtSj3F0N0kI2tNv+MvLGt6TGZ2ZExpX/2wDSWU/TakCxKy1pRIiV10CxzVRhKLMY+A9
	 TkYaCw6hT+l/ws2PqXgHga+YMgYvWdvLgKh4HCMpGGQhpV2rTuN0cy7TNWrJo2j0KIgFi
	 JKe8I1hmqqZH3zkrLbs7ON3F0F87BfXd57fNkkzOSEXJExR5LLxG0uHu+prV57D4PCLhm
	 gV3eIkQ8Bt/VLVjragYB/H6u2Jq+l88uUi1y+cwC8oxNNFhA0oYfGWbS5uEsf3Cv5aDQv
	 pOEpZd51WnddZ7JLRJFVTlpq2nkFyAhOynol6uqa5xXbmak/tqVx7UpBT2GTfXVlSNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElhfX4pQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AA606A31E;
	Fri, 27 Nov 2026 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ElhfX4pQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543991F00898;
	Fri, 27 Nov 2026 07:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795764487;
	bh=uCHYnKWdXBzFKgXQ2sEIjTFEuNAmZ3VEH0yuYh5/fHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElhfX4pQduB/uZ07AlX65RJcAzlWweGE5Akhv/8cWMibzgEPHQKKlLtmK+t7xGxD8
	 ypUlIRN4cs6nQ3IMbvyZ+VzpU7RjSoCICwukDlHOBM3CPKvFw90kUHey8o66wFJVEG
	 H8BwyTSuFbQVIKIMCFFcyM9me8bpwZkEdIIeLBBK1hqD9ErUJLeMe2mxFWrm9XONIH
	 NBqykgB2Xbs1CDXtJb/zXV5CxxvRiMzTaBzz2yuXgi3d8JK+tVZFEwybbb7O3STZGG
	 GuMkRrKonwIPvVVR1Noh8864NMX+gbmuyGNjR/TVU39Dlq5bjJR62/teSxqytLxJhB
	 7nW2mqjk+dnaQ==
Message-ID: <sashiko-outbox-236803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] ALSA: usb-audio: Add Windows volume scale quirk
 for EPOS GSX 1000 v2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aleksandrov" <aladex@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261127-gsx1000-v1-1-833554c37b82@gmail.com>
References: <20261127-gsx1000-v1-0-833554c37b82@gmail.com>
 <20261127-gsx1000-v1-1-833554c37b82@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 07:28:06 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] ALSA: usb-audio: vol->lock deadlock on autoresume in
  snd_gsx1000_vol_write()
--

commit 2cdf48294d1e8337d55eb62590e00ec94a1f72ea
Author: Andrei Aleksandrov <aladex@gmail.com>

ALSA: usb-audio: Add Windows volume scale quirk for EPOS GSX 1000 v2

This commit replaces the standard Feature Unit 12 volume control on the
EPOS GSX 1000 v2 with a mixer quirk control that writes the Windows volume
table values to channels 1 and 2.

Link: https://github.com/Aladex/epos-gsx

> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index 4c7d68311f204..6e96e80208558 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c

[ ... ]

> +/* Caller holds vol->lock */
> +static int snd_gsx1000_vol_write(struct snd_gsx1000_vol *vol)
> +{
> +	struct snd_usb_audio *chip =3D vol->list.mixer->chip;
> +	__le16 buf;
> +	int ch, err;
> +
> +	CLASS(snd_usb_lock, pm)(chip);
> +	if (pm.err < 0)
> +		return pm.err;

[ ... ]

> +static int snd_gsx1000_vol_set(struct snd_gsx1000_vol *vol, unsigned int=
 value)
> +{
> +	guard(mutex)(&vol->lock);
> +	return __snd_gsx1000_vol_set(vol, value);
> +}

[ ... ]

> +static int snd_gsx1000_vol_resume(struct usb_mixer_elem_list *list)
> +{
> +	struct snd_gsx1000_vol *vol =3D to_gsx1000_vol(list);
> +
> +	guard(mutex)(&vol->lock);
> +	return snd_gsx1000_vol_write(vol);
> +}

[Severity: High]
Can calling CLASS(snd_usb_lock, pm)(chip) under vol->lock deadlock when
the device is runtime-suspended?

snd_usb_lock_shutdown() calls snd_usb_autoresume(), which invokes
usb_autopm_get_interface() and runs the resume callback synchronously on
the calling thread:

snd_gsx1000_vol_put()
  snd_gsx1000_vol_set()
    mutex_lock(&vol->lock)
    __snd_gsx1000_vol_set()
      snd_gsx1000_vol_write()
        snd_usb_lock_shutdown()
          snd_usb_autoresume()
            usb_autopm_get_interface()
              ...
                usb_audio_resume()
                  snd_usb_mixer_resume()
                    snd_gsx1000_vol_resume()
                      mutex_lock(&vol->lock)  <-- self-deadlock

Taking CLASS(snd_usb_lock, pm)(chip) before acquiring vol->lock avoids
entering runtime resume with vol->lock held.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-gsx1000-v1=
-0-833554c37b82@gmail.com?part=3D1
