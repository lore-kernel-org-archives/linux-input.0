Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322CB353A66
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 23:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134249; cv=none; b=HJKSdR+4NVey5svRarMdNZKqz0sqIKwaxAR9XSEv1YQwScytNS1qM/FCC9CwYkanFjNv5q5R2qOUJSo3oeWsjk812rx35yoIqm+2gYcGg4rDbOa/c8qRbQR5BA3Ea8D5/SDUPpRzRnbSFXrzJouDjGWY5/73BoXAGiExuwZiBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134249; c=relaxed/simple;
	bh=90VJ9NHVlIcdrTeIdxoFsQLMBF91HxoabAV9/whJsWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nKfIfcuT/hrP+afxnDUjhFqma6eGVH4Pq5qrwrQ3kAvPZ0bHq5zBP7pAjAtGibHhMU9gYaQivDOukoZB80wjqhRma90PnSDgAMBPk3SLOR/XuGmZSrD9G7+HnyEG7oxBfu5VtkjIuXc1MtNGfZ8Zm8IbJz06+cLO3zaD31xhqzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxr4kSHK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxr4kSHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D56F1F000E9;
	Sun, 30 Aug 2026 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134245;
	bh=f9ylClfb3kvQ2b/32gP2MwkuCexUUqD9KlUVJn5Tf1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxr4kSHKsgbpH+IethxMvWs0X9htZi4mGFUCBnDy9aIp4aKkzxWIubEiO2LPAYpr3
	 mHYeY9Jfw+cmBPpfLYemM6t833ndRWK3MzvQP0e7Mym0pfKoj3lgaURIeEFWgePfG/
	 o5jzfo8hIDt/zrDNMdEsORHMlwifeWFMb7GfOpHcPpvKetme60onNPlrJ+EYidx4OP
	 rmeuVLLHKLrw5HUDEd9R48YkVhUBSLhqd6umsuM7W+6sNPLUK7ATDKyh08/qirWcXN
	 p1adWJm0PL6GsAZ6O1YHns0Sp2/EpGDwKLF2+66fk5iiAU3uvqJ+TUj0ZH0SSUnlPL
	 ZJ7u05K9tWTSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/13] HID: asus: add joysticks anti-deadzone
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260830234320.114356-9-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-9-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 23:57:25 +0000
Message-Id: <20260830235725.8D56F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `ally_drvdata.config` is never initialized with the allocated `all=
y_cfg` pointer, making all configuration sysfs attributes return `-ENODEV`.
--

commit a0409ef85990017ccc5539d469ac0af6eff50ada
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add joysticks anti-deadzone configuration

This commit adds sysfs attributes to configure the anti-deadzone parameters
for the resistive joysticks on ROG Ally devices, allowing userspace to
compensate for drift over time.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 6688615f644a1..c365b96d4486f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1318,6 +1318,193 @@ static struct device_attribute dev_attr_right_joy=
stick_outer_threshold =3D

[ ... ]

> +static ssize_t left_joystick_anti_deadzone_show(struct device *dev, stru=
ct device_attribute *attr,
> +						char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally =3D drvdata->rog_ally;
> +	struct ally_config *cfg;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg =3D ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;

[Severity: High]
This is a pre-existing issue, but won't this newly added sysfs attribute (a=
nd
all other configuration attributes) unconditionally return -ENODEV here?

Looking at hid_asus_ally_probe(), the successfully allocated configuration
object is never assigned to the controller's configuration pointer:

hid_asus_ally_probe()
{
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
        ally_drvdata.cfg_hdev =3D hdev;
        /* missing: ally_drvdata.config =3D ally_cfg; */
        spin_unlock_irqrestore(&ally_data_lock, flags);
        ...
}

Because of this, won't ally_get_config() consistently read a NULL pointer,
rendering the configuration features completely unusable and causing
hid_asus_ally_init() to silently skip hardware configuration on probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D8
