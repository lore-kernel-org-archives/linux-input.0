Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB1C4FB9C3
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536362; cv=none; b=bw1KjpK7Rt3/N9JCOVhhUh0Q/X9N7RBnogMmALj0hAgRvb+cwfEJiQSNUDuVd7trhcVxLfZD8Q91JNxu1llaC7mJtAApKpus3Cp1ATwNquRiHAlxaqudrq8eDTyPs+BSpkDQ+04YLJgijLswJERLZ8Lokil9VQERRhRNW64YvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536362; c=relaxed/simple;
	bh=ZccEufXCppiAf806YF0M/rjgw2Ol/lqMKxv3jZoF0YE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vz3QsoHsRop7F5lSvjKbLvFhs9b+J5YAb97QB0f1UaZSm9YiWWy8VVaaK+Zz/wI3vvMw1Sly2ysnro0RifaloJ+FF8X7YvFgi0AVH3CxnHascM+JhuwG/SMuTTC5mgWwqPEAeXhiwk/5Vg6knLWPfyG0KQn9LXnZRQY1lf1Ygtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVA/4TjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVA/4TjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1CC1F00A3D;
	Fri,  4 Sep 2026 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536360;
	bh=NIYrexCANV27an/eVXBFcXPiB/CAjBE8j0NAxM11bxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kVA/4TjSeecNSvS4126/1bpKpo4DwNsBjyafEamMKrVNKx5bmnr2lo5syZJzSOLnO
	 3cal2IsFT0C/CA+TkK1rlfLDfJ1nzKVvznqbX6G7VN9vNHe0O7G0KWUwULKwHNE9y3
	 wffIV14q3c6sKnhUhTQOdEXPyiAcQNLc/LfIdH0s8r6EgMqLPQI/VzJhGZk2Xspipf
	 soxGYREJKgLRMNRZlhXOlsiXRplD1N2byeLpF/bU1omEdphqJqHyaTIonAET5YUIXP
	 0sHaQFsFlJmBf6FrRQ3dKwA7swgzZ6wyy8+sjXJNbQG7Y0ANBH4VnjhKEk4bV3AOgh
	 LnMWdoHxpoejA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/13] HID: asus: add vibration strength
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904145845.184887-6-denis.benato@linux.dev>
References: <20260904145845.184887-1-denis.benato@linux.dev>
 <20260904145845.184887-6-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:39:19 +0000
Message-Id: <20260904153920.1D1CC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Vibration intensity restoration logic added to `hid_asus_ally_in=
it` is bypassed during device probe because the function exits early when `=
ally_drvdata.config` is NULL.
--

commit 9d78d1047388b95822776aa7476f2875ba47b078
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add vibration strength configuration

ASUS ROG Ally handhelds support the vibration strength to be configured:
add sysfs attributes to allow userspace configure motors vibration
intensity.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 4714ebb4a5435..659956ebaefca 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1215,6 +1399,17 @@ static int hid_asus_ally_init(struct hid_device *h=
dev, struct ally_handheld *all
>  				 ret);
>  	}
> =20
> +	/*
> +	 * The MCU does not keep the vibration intensity across a reset:
> +	 * send the recorded values again, whichever interface probed.
> +	 */
> +	ret =3D ally_set_vibration_intensity(ally, hdev,
> +					   cfg->vibration_intensity_left,
> +					   cfg->vibration_intensity_right);
> +	if (ret < 0)
> +		hid_warn(hdev, "Failed to restore vibration intensity: %d\n",
> +			 ret);
> +
>  	return 0;
>  }
> =20

[Severity: Medium]
Will this initialization ever run during the device probe?

Looking at hid_asus_ally_probe(), hid_asus_ally_init() is called before the
configuration is actually assigned to the handheld structure:

drivers/hid/hid-asus.c:hid_asus_ally_probe() {
    ...
    ally_cfg =3D ally_config_create(hdev, &ally_drvdata);
    if (IS_ERR(ally_cfg)) {
        ...
    }

    ret =3D hid_asus_ally_init(hdev, &ally_drvdata);
    if (ret < 0) {
        ...
    }

    spin_lock_irqsave(&ally_data_lock, flags);
    ally_drvdata.config =3D ally_cfg;
    ...
}

Because ally_drvdata.config is not yet assigned, the early check inside
hid_asus_ally_init() will always trigger and return early:

drivers/hid/hid-asus.c:hid_asus_ally_init() {
    ...
    cfg =3D ally_get_config(ally);
    if (!cfg)
        return 0;
    ...
}

Does the vibration intensity restoration logic get unintentionally bypassed
during probe, causing the device to lose user-configured vibration settings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904145845.1848=
87-1-denis.benato@linux.dev?part=3D5
