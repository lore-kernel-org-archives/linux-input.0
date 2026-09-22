Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118C384242
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120274; cv=none; b=Eypb0C3CtnvEG3dTInjXjvz6ZiOc7Z5NnMUY6tD1VacDCPT34yN+40Y43iwrvwbY1O2cufqN7r8g4ZuKQ50txP7DPOhoXvYRfnYC7f5IZXrw3esgy4dfmZIQ7BEWxXPc5eWP2DxSmRR+OYyXfRqR8BVjhtjJ7PaFd8/MyAO4/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120274; c=relaxed/simple;
	bh=ov8YJxH9NIseO38rpXAO6P6oyCaXiuvq7KT9PuVg7KI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bThOJK+uj8QNbDRJ5pz+ijvOWAZOzvCacgi69IMyGy83Uwq4P0cgRM/iGuagzhPka+uQ986GoVHwpYmmiOH2XErHGqtXpl764CzkZV2vyOEwNlgOMKOijdSTU1AB2QLQBB2iZWxRQ8CJiZ8F69nbLpaVLemwFsA2KhVw8ZkQnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsbFxLNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsbFxLNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136E61F000FF;
	Tue, 22 Sep 2026 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790120266;
	bh=7o2tAgXLvifuH2K7pWfvcGt534TC4SSlKycbvizETE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FsbFxLNwFgS7FbRYELFx1g9Q11J9e+/v5XZJrL3OX/RBdQ0YoV5BHfM+oGNO7mJ74
	 vXiPJ/RpqBfPryUrmc7DXxmBSp9fWxD8MwOYMHZ8NjuKGZ6m9/dCLIqYx0KWNQRyLs
	 SA9WGKpV09VXdUQpHCz1AjUO6IUC0J4ZGRSLcv53mIQVgJB+eT2wVJdemjyZDzWm2e
	 /QUKw1ti0nu6i1xXHMKzHIQTDBwyrOGVRCZoo1dQ/sEMq5n07R1YCNr437bbZ/6yBt
	 S5W8brxiZIW++VA1ukcvrmA58NaWMff/fo0xcLBnIcEpWjAaTtRgZ0uOHv/n/HdCDd
	 EIlT4KqYri9vQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] Input: elan_i2c_smbus - resend ENABLE_TP on wake
 from sleep (NOT TESTED, NEEDS TESTER!)
Reply-To: sashiko-reviews@lists.linux.dev
To: "R. Larocque" <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260922232707.8949-1-rlarocque@disroot.org>
References: <20260922232707.8949-1-rlarocque@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 23:37:45 +0000
Message-Id: <20260922233746.136E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] input: redundant ETP_SMBUS_ENABLE_TP command during initializati=
on
- [Low] input: explicit failure path violation in elan_smbus_sleep_control()
--

commit a7e8e038348366c26f0b3d1a3a7f9e778cbce51a
Author: R. Larocque <rlarocque@disroot.org>

Input: elan_i2c_smbus - resend ENABLE_TP on wake from sleep (NOT TESTED, NE=
EDS TESTER!)

This commit updates the Elan SMBus sleep control to resend the enable comma=
nd
when waking up the touchpad. This mirrors the initialization path to ensure
touch reporting resumes.

> diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/e=
lan_i2c_smbus.c
> index 0287441cda46d..dd86bd1739c55 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -93,10 +93,25 @@ static int elan_smbus_set_mode(struct i2c_client *cli=
ent, u8 mode)
> =20
>  static int elan_smbus_sleep_control(struct i2c_client *client, bool slee=
p)
>  {
> +	int error;
> +
>  	if (sleep)
>  		return i2c_smbus_write_byte(client, ETP_SMBUS_SLEEP_CMD);

[Severity: Low]
Does this direct return bypass the preferred explicit failure path style?

The input subsystem maintainer style guidelines suggest expanding direct
returns into explicit error checks when a function has multiple failure
points. Should this be updated to assign the return value to error and retu=
rn
explicitly?

> -	else
> -		return 0; /* XXX should we send ETP_SMBUS_ENABLE_TP here? */
> +
> +	/*
> +	 * The controller stops touch reporting while asleep; resend
> +	 * ETP_SMBUS_ENABLE_TP on wake, mirroring what is done during
> +	 * elan_smbus_initialize(), so that reporting actually resumes.
> +	 */
> +	error =3D i2c_smbus_write_byte(client, ETP_SMBUS_ENABLE_TP);

[Severity: Medium]
Will this cause a redundant enable command during initialization that
might confuse the hardware?

During device probe, the sequence calls the initialization routine and then
the sleep control routine to wake it up:

__elan_initialize()
   data->ops->initialize(client)
      -> elan_smbus_initialize() sends ETP_SMBUS_ENABLE_TP
   data->ops->sleep_control(client, false)
      -> elan_smbus_sleep_control() now sends ETP_SMBUS_ENABLE_TP again

Since this patch is explicitly untested on real hardware, is there a risk
that this double-command could cause unexpected states or fail the probe
sequence?

> +	if (error) {
> +		dev_err(&client->dev,
> +			"failed to re-enable touchpad after wake: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922232707.8949=
-1-rlarocque@disroot.org?part=3D1
