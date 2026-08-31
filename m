Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C42AEEB
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135280; cv=none; b=dqDoVv4U7zaETAGHK0CBNDpAAHRxIo69DUoN5bSidlXvTxiTZ2ntvntr3XkMVFv+juAGLIHyO2jLhBJpPcLPYJBLTSh1IiG/3Lzufk/71En7p/77QEs2SJsvzy/U4DK3Fkd3z6qbx2cVf+VK9WGvFzu3GsdGxCQ0j3Hp9UDnquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135280; c=relaxed/simple;
	bh=gl/T99+EIgRusw8p4a7prrMRVjxAdeOl9aF6C58txsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yq4bO5tZx2RUXY7E0wg9HraLPcWJmXMRQDB0w6FkT+eLTl3YS23nJBFDc5AwMvoP0AVTm4z7Sv+RmBQpojyHvrQext6o259QiLvxmXgCzSs8xJW5N6swcTfD1nXpA0mxiCDcM4griotSNMdTHF2HZo+xipqQQdPpdJgDCNFcOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoIRPbGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoIRPbGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE05B1F000E9;
	Mon, 31 Aug 2026 00:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788135278;
	bh=SJdrJtsgfgWt4fxDbiHX4zNy8dJit+6VIm21Q5Im/zE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SoIRPbGG+r6yzV8mhilgjkadXjcEjp5ID4gLVHMyuiHh1q8VsOuwjEnAOiFJnFqJ/
	 Nc3Sc3thwr3r5AZpDvLmGEKhx9CLP689og1m1VPxkH7L2PWPNDCN5DJJrw9fJpL1qx
	 ao0CKb8HZhs5Ru2PGdVNyuTQDnscdH0dL1dleSkBzPKerioLPcsJx0kseVQ4AOXh+x
	 Y9i3O6PP8AutD3LgOgm11MV4ut9sY/shI3135yUFwD0S0HQ5hb5p7E7YflZV/ywKF3
	 8YkejBTCiRzvkVKnedkzewoq7EeUq0q5ImXfINQbz8oNpIHViEQd+LljYga+WgfrdN
	 hfWdd+VBmFGmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/13] HID: asus: add support for turbo buttons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830234320.114356-13-denis.benato@linux.dev>
References: <20260830234320.114356-1-denis.benato@linux.dev>
 <20260830234320.114356-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 00:14:37 +0000
Message-Id: <20260831001437.EE05B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free of turbo button sysfs entries during driver unbind.
- [Low] Memory leak of devm-allocated `entries` array on sysfs creation err=
or path.

Pre-existing issues:
- [High] Missing assignment of newly created configuration to the global sh=
ared state.
--

commit c80fc8c450c40cb3fda087280dc3fa093ed01eeb
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for turbo buttons

ROG ally devices supports a feature called turbo buttons that allows
the user to quickly toggle button state by keeping a button pressed,
therefore allow userspace to configure the feature by exposing
relevant sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 9ed6c605df888..7fc04d29de8de 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2684,6 +3118,8 @@ static struct ally_config *ally_config_create(struc=
t hid_device *hdev, struct al
> =20
>  	return cfg;
>  ally_config_create_sysfs_err:
> +	if (cfg->button_entries)
> +		ally_remove_button_attributes(hdev, cfg);
>  ally_config_create_err:
>  	devm_kfree(&hdev->dev, cfg);
>  	return ERR_PTR(ret);

[Severity: Low]
Does this code leak the entries array if sysfs creation fails?

In ally_create_button_attributes(), the entries array is allocated using
devm_kcalloc(). If sysfs_create_group() fails, the error path sets
cfg->button_entries =3D NULL.

When returning here, cfg->button_entries is NULL, so
ally_remove_button_attributes() is skipped. The cfg structure is freed
manually to save memory, but the devm-allocated entries array is abandoned.

Since asus_probe() might ignore probe failures from the Ally extension,
the devres group remains alive, causing this memory to stay allocated until
the device is unbound. Could the entries array be freed directly on this
error path?

[ ... ]

> @@ -2701,6 +3137,9 @@ static void ally_config_remove(struct hid_device *h=
dev, struct ally_config *cfg)
>  	if (!cfg || !cfg->initialized)
>  		return;
> =20
> +	if (cfg->button_entries)
> +		ally_remove_button_attributes(hdev, cfg);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
>  		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
>  }

[Severity: High]
This is a pre-existing issue, but it appears the newly created configuration
in hid_asus_ally_probe() is never assigned to the global shared state.

In hid_asus_ally_probe():

    ally_cfg =3D ally_config_create(hdev, &ally_drvdata);
    if (IS_ERR(ally_cfg)) {
    ...
    spin_lock_irqsave(&ally_data_lock, flags);
    ally_drvdata.cfg_hdev =3D hdev;
    // ally_drvdata.config is not set to ally_cfg
    spin_unlock_irqrestore(&ally_data_lock, flags);

Because ally->config is never set, subsequent config lookups fail, and
the cfg parameter passed to ally_config_remove() is always NULL.

[Severity: High]
Can the unbind path cause a use-after-free regression here?

Because cfg is always NULL (due to the pre-existing issue mentioned above),
the early return in ally_config_remove() is taken, and
ally_remove_button_attributes() is skipped during unbind.

Since sysfs_create_group() is used to manually create the sysfs attributes,
they are not tied to devres. However, their backing memory (the entries
array) is allocated with devm_kcalloc() and will be freed by devres.

This leaves the sysfs files active after the memory is freed. If a user
reads one of these leftover sysfs files after device unplug (e.g., in
btn_turbo_period_show()), it dereferences the freed memory, causing a
use-after-free.

Could the missing configuration assignment be fixed so cleanup occurs
correctly, or could the sysfs group lifecycles be tied to devres as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830234320.1143=
56-1-denis.benato@linux.dev?part=3D12
