Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ADE47CC67
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633830; cv=none; b=LuSAMkNigDwGmq4Der+Pid0JIWwqqUfQ2rQa7qz4rIDCrYNCJzTKOKsRXV0pa3elV9qYcgJISxfNX3TZprr0nHJEhBn9TOR1P50kMdVfb7VKgvrW/vMIEAsi81Ivutp7zTMX3xC1g+RKce+TdILOCNQeCwwz6lSMzOdTwzlLzTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633830; c=relaxed/simple;
	bh=by2OBWaFe3v3nPsY0ZsOLtGqjljgL1D1oUbN4ChfkI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aVQfuZQM3h2hHWBzNS5E9h7DxzjrWTAdGqQvetMELSV0pmb1oL2F+0GSjxU/FE/1dJadrUK4jXNd5XD8JC3zKyXkXWZwok4AyTAQ3KBdU2hEMuR/gRhzqbMEZPUosCmdXfP2X8imru+lUPt14pam4KbcUjgUkeDAa05zo9bde9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I466mifs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I466mifs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781DE1F000E9;
	Thu, 13 Aug 2026 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633828;
	bh=4AeRM7Gp6/8U0VAQrosQbCNpHcfX7Ys+qhJrn7cncrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I466mifsHd+uP5HHJ+bftUzJGvk+jzaVSeCqIXvkbwYUJ7m1UL95MzSqKgxu+53S1
	 e8roEUHjMNXSKs4mLk3bnDkqL4KgZNLjhd5hyNu0jKiVrv5Y+qsNJVNX99t1nafOak
	 qlcPuELHA0ms3FRKUF3RNvgskmWfJQqnLdF2L+Q3OvmH1zF4tQvOWXYTLEok1cWOua
	 3lVFSnwuAGE5mItXLa238RnZnvTcgAlAha0Alrr9SzccC5GgNnuERfd8chHM6WLlgS
	 JOHt6mojhWeuLl2fJd35zWgDYv6VpIhahRz8/9tcZxNDs74IcZlZKGPvVqrTgz7x17
	 eOj3G2FIlu8XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] HID: asus: add support for turbo buttons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260813144736.2477941-12-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-12-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:10:28 +0000
Message-Id: <20260813151028.781DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Lockless read of `cfg->turbo` in `ally_set_turbo_params` leads t=
o data races and hardware state desynchronization.
- [Low] Redundant and completely unused dynamic allocation of `struct ally_=
btn_turbo_attr`.

Pre-existing issues:
- [High] Preexisting sysfs show/store callbacks for response curves derefer=
ence `ally->config` without checking if it is NULL, leading to a kernel cra=
sh if accessed during device unbind.
--

--- Patch [11]: [PATCH 11/12] HID: asus: add support for turbo buttons ---
commit 889fd7b803cb63ae392e549855086950d7932992
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for turbo buttons

ROG ally devices supports a feature called turbo buttons that allows
the user to quickly toggle button state by keeping a button pressed,
therefore allow userspace to configure the feature by exposing
relevant sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 8930a246e7255..359832395afec 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -2195,6 +2288,321 @@ static const struct attribute_group ally_attr_gro=
ups[] =3D {
> +static int ally_set_turbo_params(struct hid_device *hdev, struct ally_co=
nfig *cfg)
> +{
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *ally =3D drvdata->rog_ally;
> +	struct ally_turbo_config *turbo =3D &cfg->turbo;
> +	const u8 payload[] =3D {
> +		turbo->btn_du.turbo,
> +		turbo->btn_du.toggle,

[Severity: Medium]
Can this lockless read result in stale or torn data being sent to the hardw=
are?

In btn_turbo_period_store(), the config_mutex is released immediately before
calling ally_set_turbo_params():

    scoped_guard(mutex, &entry->cfg->config_mutex)
        params->turbo =3D value;

    ret =3D ally_set_turbo_params(entry->hdev, entry->cfg);

Since ally_set_turbo_params() locklessly reads the entire turbo array to
construct the payload, concurrent sysfs writes to other buttons could result
in the device receiving an inconsistent or desynchronized state. Could this
be prevented by holding config_mutex while building the payload?

> +		turbo->btn_dd.turbo,
> +		turbo->btn_dd.toggle,
[ ... ]
> +struct ally_btn_turbo_attr {
> +	struct device_attribute dev_attr;
> +	int button_id;
> +};

[Severity: Low]
Does this code allocate a redundant structure?

Later in ally_btn_turbo_attr_create(), this struct is allocated via
kzalloc_obj, but its fields are never populated. The actual sysfs attributes
used seem to be embedded within struct ally_btn_sysfs_entry instead.

> +
> +#define to_ally_btn_turbo_attr(x) container_of(x, struct ally_btn_turbo_=
attr, dev_attr)
[ ... ]


[Severity: High]
This is a pre-existing issue, but can this code cause a kernel panic if the
sysfs attribute is read during device unbind?

Looking at DEFINE_JS_CURVE_PCT_FOPS in drivers/hid/hid-asus.c:

	static ssize_t side##_response_curve_pct_##region##_show(		\
		struct device *dev, struct device_attribute *attr, char *buf)	\
	{									\
		struct hid_device *hdev =3D to_hid_device(dev);			\
		struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);		\
		struct ally_handheld *ally =3D drvdata->rog_ally;			\
		return response_curve_pct_show(					\
			dev, attr, buf, &ally->config->side##_curve, region);\
	}

When the device is unplugged, hid_asus_ally_remove() synchronously sets
ally->config =3D NULL. Since devres handles the sysfs removal later, a
concurrent read of the sysfs file unconditionally dereferences ally->config
without checking if it is NULL.

Should there be a NULL check before evaluating &ally->config->side_curve
in both DEFINE_JS_CURVE_PCT_FOPS and DEFINE_JS_CURVE_MOVE_FOPS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D11
