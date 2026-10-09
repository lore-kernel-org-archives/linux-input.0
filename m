Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443E4E36C4
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554743; cv=none; b=PSvTW4YkLPq3xynYKsv0dVHpby3j7kBABrqujN8rEUh0j8v2VzvsccRXWq2XWgwopvcDJU+8wLf3LO0IxuOdDXcyKvsN8HOQE2CLqhnqzBH+iFDDwqq5TG176ypXNgccP6QcAyr4C+CW8FhaXTpz9ohy1+kPvrBGELXQgDlY1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554743; c=relaxed/simple;
	bh=eQYU9d1Edtdf1ZLn6eQlpR2PhFw6xPUmoP5cm1HHQk0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BDP5AXTbQfKX98timUMSFQyVPz8Wo9OG/ij7s50YkJBUiXThtaJ4c1SRFdY8kDdiL27DRwYHfPrF9CPf9gN0/i20wELw4+K5Ww7mXNTEm4Of7i00yY6p9lhl3yh5mXPUf0L/lSKxuPbKOyI4zAUcXP6eid7QVmguReqA0CzFUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg/yyEey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg/yyEey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E1E1F00893;
	Fri,  9 Oct 2026 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554740;
	bh=QT1fYP++Fpndz0WKcTwrDMMSDQcDvIfT97GBKI15nRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eg/yyEeyoqFX2KBK2kHkL5E+7+Nn32aErUUlmFJSa6exSuDLHbi0dK/8VtNSJoRkC
	 q+WiIFEEEl9pen2uK/r2jcxAL+lyttaPdbxIurahM/cmR84Knz9fVxtOaHTZXmBVFF
	 jeUKJ0voMW6FyiwwLQRZBookPSmB9M9KSSOq5bko60nU7/F9O9cNUeq1/wA7Nt6Te2
	 6PWtIxVFCh35BgM37oJAzZp5jt73VU5TlC3sEJjZRttsGXEDUeulBPwnupDMX6cUJg
	 YtjKrZlkmJP3I2sZARaa4j+POoVlViuxLM3aFEdXISOafQRVK3/FGiYpjcVgpg0e0+
	 2LHVSsp6w0W9Q==
Message-ID: <sashiko-outbox-165689@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/12] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261009122820.7603-13-denis.benato@linux.dev>
References: <20261009122820.7603-1-denis.benato@linux.dev>
 <20261009122820.7603-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:05:39 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] hid-asus: Data race and potential crash due to lockless, early pub=
lication of cfg->button_entries
- [Medium] hid-asus: Spurious -ENODEV in btn_remap_index_show during probe =
window
- [Low] hid-asus: Mixing of goto-based error handling and scope-based clean=
up macros
--

commit a48a3e57ee28de7514fe1b866341ce1f961419d7
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add support for btn remapping
   =20
    Add support for buttons remapping: the ability to assign different
    button events to each one of the physical button on the device.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e9380002e9ffb..c439f0eeedc1d 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1131,6 +1470,33 @@ static ssize_t gamepad_mode_store(struct device *d=
ev, struct device_attribute *a
> =20
>  	cfg->gamepad_mode =3D mode_byte;
> =20

[ ... ]

> +	if (cfg->button_entries) {
> +		for (i =3D 0; i < ALLY_BTN_MAX; i++) {
> +			sysfs_notify(&dev->kobj, cfg->button_entries[i].group.name,
> +				     "remap");

[Severity: High]
Does this code introduce a data race with ally_create_button_attributes()?

Since ally_config_create() registers the main sysfs attributes (including
gamepad_mode) before calling ally_create_button_attributes(), userspace can
write to gamepad_mode while the button entries are being initialized.

ally_create_button_attributes() assigns the allocated array to
cfg->button_entries without any locks or memory barriers:

ally_create_button_attributes()
	entries =3D kcalloc(ALLY_BTN_MAX, sizeof(*entries), GFP_KERNEL);
	if (!entries)
		return -ENOMEM;
	cfg->button_entries =3D entries;

If gamepad_mode_store() runs concurrently, it acquires cfg->config_mutex,
observes the non-NULL cfg->button_entries pointer, and attempts to pass
cfg->button_entries[i].group.name to sysfs_notify().

As the array elements may not yet be initialized, this could pass a NULL or
garbage pointer to sysfs_notify(), potentially leading to a crash in
kernfs_find_and_get().

> +			sysfs_notify(&dev->kobj, cfg->button_entries[i].group.name,
> +				     "macro");
> +		}
> +	}
> +
>  	hid_dbg(hdev, "Set gamepad mode to %s\n", ally_gamepad_mode_text[mode]);
> =20

[ ... ]

> +static ssize_t btn_remap_index_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *ally =3D drvdata->rog_ally;
> +	struct ally_btn_sysfs_entry *entry =3D container_of(attr,
> +		struct ally_btn_sysfs_entry, attr_remap_index);
> +	struct ally_config *cfg;
> +	enum ally_button_id btn =3D entry->btn;
> +	u8 mode;
> +	ssize_t len =3D 0;
> +	int i;
> +
> +	if (!ally)
> +		return -ENODEV;

[Severity: Medium]
Will this return a spurious -ENODEV if userspace accesses the sysfs
attribute immediately after creation?

The globally published drvdata->rog_ally pointer is not set until
asus_probe() completes. However, the sysfs files are created and exposed
during hid_asus_ally_probe().

If userspace accesses this file before asus_probe() finishes,
drvdata->rog_ally will be NULL, causing this function to fail with -ENODEV.

Should this code use the safely cached entry->ally pointer instead of
attempting to retrieve the global pointer from drvdata?

> +
> +	cfg =3D ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;

[ ... ]

> @@ -2858,12 +3830,27 @@ static int ally_create_button_attributes(struct h=
id_device *hdev,
>  	return 0;
> =20
>  err_cleanup:
> +	/*
> +	 * Unpublish first: the readers of button_entries (like the
> +	 * gamepad_mode_store() cross-notification) hold config_mutex and
> +	 * must observe either the live array or NULL, never a freed one.
> +	 * The lock is released again before the removals, so a straggler
> +	 * callback waiting on it can drain against the not yet freed
> +	 * entries.
> +	 */
> +	scoped_guard(mutex, &cfg->config_mutex) {
> +		cfg->button_entries =3D NULL;
> +	}

[Severity: Low]
Does this code violate the kernel cleanup guidelines by mixing goto-based
error handling with scope-based cleanups?

The cleanup subsystem documentation in include/linux/cleanup.h mandates
that functions must not mix goto-based cleanup labels with scope-based
cleanups (guard() or scoped_guard()). The rule states to either convert all
resources to scope-based cleanup, or convert none of them.

Since ally_create_button_attributes() relies entirely on goto-based error
handling for unwinding memory and sysfs allocations, could you use standard
mutex_lock() and mutex_unlock() calls here instead?

> +
>  	while (--i >=3D 0)
>  		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009122820.7603=
-1-denis.benato@linux.dev?part=3D12
