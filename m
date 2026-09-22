Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB7334C1C
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118986; cv=none; b=bRqt0Zr3e1pkhk+wdEtzoRgNSbLmNpK4/+6gwmPqZxRfU75oTWsGsi5kRUQGbLeStnCND+NhnqpK/SB6WLkm3WKedO1lbelZCZqGggq23vfTGoRhZTlzjbtuz8leeyoxR1bbzKedjwDFGGbRLsmdgwJWEbc5LHsCSxwTWgB1FGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118986; c=relaxed/simple;
	bh=rTxLLsiQab5uXuebhNicjV2ddpVNOHKHfE8Ho7QvoeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q0bWGbJmZcNpRh/OwmxaxLUil4wUzKmEnpzXU7pyKuyxKy5fcSWKbVO9GDUIWrG9E+2095/hiZ51zRtfSTV+KNTou3hgNFLrkUi3tKwfdv9AlyAcMZ3qXWmwHdadBsmV9KC9XtDGKo6AQQqs82axKG2yZKSwiysw6k8T1iEBArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOJSbnKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOJSbnKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600451F000FF;
	Tue, 22 Sep 2026 23:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790118984;
	bh=C12cF7aPMVNvfWntk5NmF2LwwwqAg2p3hZMBz/aDoik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KOJSbnKYZg08W+hU0z7Ix/kI1A3NUkkVBfGbDtNuXpejsSQ7xb1tNMHX1NY6M4djx
	 ovVG2z7nSPiOumVdhx783+MxNDvYz2R/VGNkdcf8RSu9R01/1wR4R+37LIN0/rUBdk
	 Pu69NM1V3rR9zRvCecw/SWBCJbaB1EhxgMHNnir7FHLUk0ytYL7SWC6wBwAncZ9uMa
	 xKcdUJswTBzsOwUQhsG3myeE3ja6u5Iq+eoafgNwrsdIev855OIpk0vpi50iWOBnZu
	 qp8xxaM2NrtN81Gspig7TGS5K/UxOox3PiFsybIEaM1ocU88v+ysLdb9/TCHyR/Kh7
	 qRJDICp3hV2Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/12] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260922230205.6847-13-denis.benato@linux.dev>
References: <20260922230205.6847-1-denis.benato@linux.dev>
 <20260922230205.6847-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 23:16:24 +0000
Message-Id: <20260922231624.600451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: asus: use-after-free of button_entries during teardown and er=
ror paths
--

commit d969019ebea0db9a650c70e2413a3a0ba90ade15
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for btn remapping

This commit adds support for button remapping on ROG Ally devices. It
introduces sysfs attributes to configure valid remap targets and automatica=
lly
refreshes the software cache when the gamepad mode changes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -1131,6 +1470,33 @@ static ssize_t gamepad_mode_store(struct device *d=
ev, struct device_attribute *a
[ ... ]
> +	if (cfg->button_entries) {
> +		for (i =3D 0; i < ALLY_BTN_MAX; i++) {
> +			sysfs_notify(&dev->kobj, cfg->button_entries[i].group.name,
> +				     "remap");
> +			sysfs_notify(&dev->kobj, cfg->button_entries[i].group.name,
> +				     "macro");
> +		}
> +	}
[ ... ]
> @@ -2883,12 +3860,22 @@ static void ally_remove_button_attributes(struct =
hid_device *hdev, struct ally_c
[ ... ]
>  	kfree(entries);
> =20
> -	cfg->button_entries =3D NULL;
> +	/*
> +	 * Unpublish the pointers under the lock, so that a sysfs callback
> +	 * which is still holding config_mutex observes the teardown
> +	 * instead of freed memory.
> +	 */
> +	scoped_guard(mutex, &cfg->config_mutex) {
> +		cfg->button_entries =3D NULL;
> +	}
>  }

[Severity: High]
Can this result in a use-after-free when sysfs callbacks run concurrently?

Here entries (which corresponds to cfg->button_entries) is freed via
kfree(entries) before the pointer is actually set to NULL under
config_mutex. If a concurrent sysfs write to gamepad_mode_store() acquires
config_mutex right after this kfree() but before the scoped_guard executes,=
=20
it will see a non-NULL cfg->button_entries and dereference freed memory whe=
n=20
accessing cfg->button_entries[i].group.name.

Should cfg->button_entries be set to NULL inside the lock before entries is
freed?

[ ... ]
> @@ -2861,6 +3833,11 @@ static int ally_create_button_attributes(struct hi=
d_device *hdev,
[ ... ]
>  err_cleanup:
>  	while (--i >=3D 0)
>  		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
> =20
> +	for (i =3D 0; i < ALLY_BTN_MAX; i++) {
> +		kfree(entries[i].remap_attr);
> +		kfree(entries[i].macro_attr);
> +	}
> +
>  	kfree(entries);
> =20
>  	cfg->button_entries =3D NULL;

[Severity: High]
Is there a similar race condition on this error path?

If ally_create_button_attributes() fails and takes this error path,
cfg->button_entries is set to NULL without holding config_mutex, and after
entries has already been freed. This seems to expose the same use-after-free
window to any concurrent sysfs accesses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922230205.6847=
-1-denis.benato@linux.dev?part=3D12
