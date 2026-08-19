Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE844064F
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171018; cv=none; b=FyqIIy+vvS5S5l3oLywGtINMgcDkKwG2sVchpb64jRxYQZW+AztMWoZy5pAdAtHtCVh7RbseniHR3MuKB/Bk+Ijy5U8O1qlx7YoRR6uX2upgeyQ0ELX/lntqVuHk+VEfW5pZm2jm/GS1FF+v9/gvnS0p+wmUAhAuu/oAPzYx1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171018; c=relaxed/simple;
	bh=Pm63D3Q+KnTdfs7uni/Fe4+BOcqatMD8n2/Nz/gfQQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OyHciZw4gKr40iK3y5Foiq3ojg3eNtDmpllmlJmwVHRpXpKmC4TwGtZJt0N/ySPGYNxT+orohlMd1jce5NeBW+2wF/rn1ItWPjUKpFFmZvwpWYuio4e7V2B6I8bGQgB/60sHJhIC9X+2NKa/ozWvtx+zvt6ZKYBqWBk9893ub7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgqyeLYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgqyeLYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258F21F000E9;
	Wed, 19 Aug 2026 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787171016;
	bh=v53Rp2RzGoDPFgjkMhujLrbPQh3tgtuVvT3S8RsYFIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SgqyeLYfja6cjOK0wqHSrBV2csN97O2QAymhXz7yRC7xHwzhrhAsn7BDrl+Nzp4z7
	 hYJRtLrDhSXE039VQeJAtfQmUVokGG4g0ksBI+wsFLt35ID7uhL5eVXMZnWIeuCRM4
	 7S6LrsCEOBB/ycnv0DVc4qlKMw2ev74Em2kHL/OKkU31IcsqhKqsUUKkuQjBMhWfKb
	 qGdDj6OWu6M8DCWw6aZ/m266uxXHZi2p5mz8jLHTBvoCYKDhCNUZMO2/ug/s8d6p/W
	 eR/0f1GNWj+NekWwvDdFcwC3KnUPrC1UngjLT/n58SN4JBezXFAtyPo6koLTJ7/FWp
	 xQt0YT9VKVtKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] HID: asus: add support for turbo buttons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260819195835.1649657-12-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
 <20260819195835.1649657-12-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 20:23:35 +0000
Message-Id: <20260819202336.258F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Sysfs attribute leak on probe error path leads to a Use-After-=
Free when accessed.
- [High] Calling `sysfs_remove_group()` while holding a spinlock with inter=
rupts disabled causes a scheduling-while-atomic kernel panic.
- [Medium] State desynchronization on write failure: the local cached turbo=
 configuration is permanently modified before the hardware acknowledges the=
 change.
- [Low] Missing trailing return statement after `scoped_guard` causes `-Wre=
turn-type` compiler warnings.
--

--- Patch [11]: [PATCH v2 11/12] HID: asus: add support for turbo buttons -=
--
commit 1c542d232085f0c0b17c85a45a979b053ef8c90e
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add support for turbo buttons
   =20
    ROG ally devices supports a feature called turbo buttons that allows
    the user to quickly toggle button state by keeping a button pressed,
    therefore allow userspace to configure the feature by exposing
    relevant sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 6be25cc022cba..d6ab906b7e782 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static ssize_t btn_turbo_period_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct ally_btn_sysfs_entry *entry =3D container_of(attr, struct ally_b=
tn_sysfs_entry,
> +							  attr_turbo_period);
> +	struct ally_btn_turbo_params *params =3D ally_btn_get_turbo_params(entr=
y->cfg,
> +									 entry->btn);
> +
> +	if (!params)
> +		return -ENODEV;
> +
> +	scoped_guard(mutex, &entry->cfg->config_mutex)
> +		return sysfs_emit(buf, "%hhu\n", params->turbo);
> +}

[Severity: Low]
Does this code trigger a -Wreturn-type compiler warning?

The function ends inside a scoped_guard() block without an explicit trailing
return statement. Since scoped_guard() is implemented as a macro wrapping a=
 for
loop, the compiler's flow analysis cannot definitively prove the loop execu=
tes,
which leads to a warning that control reaches the end of a non-void functio=
n.

> +
> +static ssize_t btn_turbo_period_store(struct device *dev, struct device_=
attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct ally_btn_sysfs_entry *entry =3D container_of(attr, struct ally_b=
tn_sysfs_entry,
> +							  attr_turbo_period);
> +	struct ally_btn_turbo_params *params;
> +	u8 value;
> +	int ret;
> +
> +	if (!entry->cfg->turbo_support)
> +		return -EOPNOTSUPP;
> +
> +	params =3D ally_btn_get_turbo_params(entry->cfg, entry->btn);
> +	if (!params)
> +		return -ENODEV;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value < ALLY_TURBO_PERIOD_MIN || value > ALLY_TURBO_PERIOD_MAX)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &entry->cfg->config_mutex) {
> +		params->turbo =3D value;
> +		ret =3D ally_set_turbo_params(entry->ally, entry->hdev, entry->cfg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return count;
> +}

[Severity: Medium]
Are we permanently desynchronizing local state if the hardware transmission=
 fails?

By updating params->turbo before confirming the hardware acknowledged the c=
hange
via ally_set_turbo_params(), the local cache becomes modified. If the USB/H=
ID
transmission fails, the function returns an error without rolling back
params->turbo.=20

A subsequent successful sysfs write to another button will then silently fl=
ush
this invalid cached state to the hardware.

> +
> +static ssize_t btn_toggle_period_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ally_btn_sysfs_entry *entry =3D container_of(attr, struct ally_b=
tn_sysfs_entry,
> +							  attr_toggle_period);
> +	struct ally_btn_turbo_params *params =3D ally_btn_get_turbo_params(entr=
y->cfg, entry->btn);
> +
> +	if (!params)
> +		return -ENODEV;
> +
> +	scoped_guard(mutex, &entry->cfg->config_mutex)
> +		return sysfs_emit(buf, "%hhu\n", params->toggle);
> +}

[Severity: Low]
Does this code trigger a -Wreturn-type compiler warning?

The function ends inside a scoped_guard() block without an explicit trailing
return statement. Since scoped_guard() is implemented as a macro wrapping a=
 for
loop, the compiler's flow analysis cannot definitively prove the loop execu=
tes,
which leads to a warning that control reaches the end of a non-void functio=
n.

> +
> +static ssize_t btn_toggle_period_store(struct device *dev, struct device=
_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct ally_btn_sysfs_entry *entry =3D container_of(attr, struct ally_b=
tn_sysfs_entry,
> +							  attr_toggle_period);
> +	struct ally_btn_turbo_params *params;
> +	u8 value;
> +	int ret;
> +
> +	if (!entry->cfg->turbo_support)
> +		return -EOPNOTSUPP;
> +
> +	params =3D ally_btn_get_turbo_params(entry->cfg, entry->btn);
> +	if (!params)
> +		return -ENODEV;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value < ALLY_TOGGLE_PERIOD_MIN || value > ALLY_TOGGLE_PERIOD_MAX)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &entry->cfg->config_mutex) {
> +		params->toggle =3D value;
> +		ret =3D ally_set_turbo_params(entry->ally, entry->hdev, entry->cfg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return count;
> +}

[Severity: Medium]
Are we permanently desynchronizing local state if the hardware transmission=
 fails?

By updating params->toggle before confirming the hardware acknowledged the =
change
via ally_set_turbo_params(), the local cache becomes modified. If the USB/H=
ID
transmission fails, the function returns an error without rolling back
params->toggle.=20

A subsequent successful sysfs write to another button will then silently fl=
ush
this invalid cached state to the hardware.

[ ... ]

> @@ -2556,6 +2967,9 @@ static void ally_config_remove(struct hid_device *h=
dev, struct ally_handheld *al
> =20
>  	if (!cfg || !cfg->initialized)
>  		return;
> +
> +	if (cfg->turbo_support && cfg->button_entries)
> +		ally_remove_button_attributes(hdev, cfg);
>  }

[Severity: High]
Does this cause a scheduling-while-atomic kernel panic during device unbind?

Looking at hid_asus_ally_remove(), it acquires ally_data_lock via
spin_lock_irqsave() and disables interrupts before calling ally_config_remo=
ve():

drivers/hid/hid-asus.c:hid_asus_ally_remove() {
	...
	spin_lock_irqsave(&ally_data_lock, flags);
	...
	if (ally->cfg_hdev =3D=3D hdev) {
		ally_config_remove(hdev, ally);
	...
}

This patch modifies ally_config_remove() to call ally_remove_button_attribu=
tes()
which calls sysfs_remove_group(). Because sysfs_remove_group() blocks on
kernfs_rwsem, sleeping inside this atomic context will predictably trigger a
panic when the device is unbound or the module is removed.

[Severity: Critical]
Does this result in a Use-After-Free and sysfs attribute leak if probe fail=
s?

When hid_asus_ally_setup() calls hid_asus_ally_init(), an error causes
ally_config_remove() to be called:

drivers/hid/hid-asus.c:hid_asus_ally_setup() {
	...
		ret =3D hid_asus_ally_init(hdev, &ally_drvdata);
		if (ret < 0) {
			ally_config_remove(hdev, &ally_drvdata);
			return ERR_PTR(ret);
		}

		spin_lock_irqsave(&ally_data_lock, flags);
		ally_drvdata.config =3D ally_cfg;
	...
}

However, ally_drvdata.config is not assigned until after this check. When
ally_config_remove() runs, ally_drvdata.config is NULL, causing it to return
early without calling ally_remove_button_attributes().=20

The sysfs groups created by ally_create_button_attributes() are leaked and=
=20
remain accessible. When devres subsequently frees the backing memory
(ally_cfg and entries), any unprivileged user reading the leaked sysfs files
like btn_turbo_period_show() will dereference freed memory, triggering a UA=
F.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819195835.1649=
657-1-denis.benato@linux.dev?part=3D11
