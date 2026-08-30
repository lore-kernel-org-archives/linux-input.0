Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816E28C5B1
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134313; cv=none; b=aMuqitOt0WGr/4E7XRO3n1O8CIuT2vqu6cxEzixC2Le2vokjDeJ+DV7Rl6V/WuoVu130mlg6JypFxOrxyfXyXzNtrn/Vs2ap0kOsF62CGQLjkcuU931xAPj4fAQ4Em//ulppq8vkF2ClpQNpTp33dHPFHdi9w2Xd7u7gDB/ZZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134313; c=relaxed/simple;
	bh=ykhzphmIVATgabJk0zy0P7Ek34d0B32IVyoF02NAdiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HhDZ59OivCQvsTQy087xid0fncv4QOEpPn/Hgmz7Qcz7HZTdj/oRzQ0MD2S8FQNVXCrVemS557/S/TTfv1Vx6vUoWQYhO5YfBZyZCFlmil+32Q0Pl4rI70AeuAx8ibCrnJ1PA0aal+IzRNc1YAQflmcfqgYlA/wZqquDRDK9yvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHRJo/+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHRJo/+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585A41F000E9;
	Sun, 30 Aug 2026 23:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134311;
	bh=tl8V796Vn0Amhy1JlYSoFzOD/oI94MvMIwIRJ+T9i08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MHRJo/+pLLaK3adj4rKYUooPqC9C4gLbs7Z9uMNuNI+dgmIOcr10jN5yQiZo7Py7L
	 1GuE8fL4sm4xL3nt22+L8r766LyoIQAzfXMUj88X7+qA1xg+PidrTGklhY5iQWThV7
	 +zB3KYrD3OM2owSnd/VzU8Pyp3/RA0WxByDapmPLmTg8MmooRVlVcMONLXxfSgsvp5
	 7ZrrJbkMAsRkYoUXQC9ksYjVXSxqu8GzEEBJNI5nhSbkcTOjrprUeabPALO77Ls4ad
	 85zEbgSRpCAtzNOnGVOy4nriL8rE8tceowWuPwbJnSFzSz+QgKL/EpPWcwzoA8OxYx
	 Y+mfeKY7NgLlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/13] HID: asus: add triggers inner and outer range
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830234320.114356-8-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-8-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 23:58:30 +0000
Message-Id: <20260830235831.585A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The configuration pointer ally_drvdata.config is never initialized=
, causing all sysfs configurations to silently fail.
- [Medium] Sysfs attributes are registered before their backing driver stat=
e is initialized.
--

commit 80d5926aadeb16828c5f704e5f821fff45eb12b6
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add triggers inner and outer range configuration

This patch allows userspace to configure the inner and outer ranges for
the trigger buttons on ROG Ally devices by exposing new sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 7702427bde451..6688615f644a1 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1318,6 +1318,350 @@ static struct device_attribute dev_attr_right_joy=
stick_outer_threshold =3D
[ ... ]
> +static ssize_t left_trigger_range_lower_limit_show(struct device *dev,
> +						   struct device_attribute *attr, char *buf)
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
This is a pre-existing issue, but does ally_drvdata.config ever get
initialized?

In hid_asus_ally_probe(), the pointer returned by ally_config_create() is
stored in a local variable ally_cfg, but it is never assigned to the global
state struct:

drivers/hid/hid-asus.c:hid_asus_ally_probe() {
    ...
        spin_lock_irqsave(&ally_data_lock, flags);
        ally_drvdata.cfg_hdev =3D hdev;
        spin_unlock_irqrestore(&ally_data_lock, flags);
        break;
    ...
}

As a result, ally_get_config() permanently returns NULL, causing every sysfs
callback, including this new one, to immediately abort with -ENODEV.

[ ... ]
> @@ -1429,6 +1801,10 @@ static struct ally_config *ally_config_create(stru=
ct hid_device *hdev, struct al
>  	cfg->left_outer_threshold =3D 90;
>  	cfg->right_deadzone =3D 10;
>  	cfg->right_outer_threshold =3D 90;
> +	cfg->left_trigger_min =3D 0;
> +	cfg->left_trigger_max =3D 100;
> +	cfg->right_trigger_min =3D 0;
> +	cfg->right_trigger_max =3D 100;

[Severity: Medium]
This is a pre-existing issue, but do these driver states get initialized too
late?

The sysfs nodes for the trigger ranges become active and accessible to
userspace earlier in ally_config_create() when devm_device_add_group() is
called:

drivers/hid/hid-asus.c:ally_config_create() {
    ...
    ret =3D devm_device_add_group(&hdev->dev,
                                ally_cal_attr_groups[sysfs_i]);
    ...
}

This creates a window where udev or another userspace process can access the
newly created sysfs nodes immediately upon registration and read uninitiali=
zed
defaults before the configuration is initialized here.

>  	cfg->vibration_intensity_left =3D 100;
>  	cfg->vibration_intensity_right =3D 100;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D7
