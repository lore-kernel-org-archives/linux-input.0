Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469116;
	b=KRJCHAgy5NK2LDTjdKXRxSEwjauataPuFjkjpHZdxizeR86hUR0Rw16tOVXFfToUZoQD
	 L/GomvdKHfbgO+ao3M4BNo9NFCo1kiJAF2aBT4Rnf3+ImfMFbbgKsORnS99XMa9Aa3qeW
	 hheCvtgwVeATMxKLFiNnaqYa0KRALlR2kf5eVQaIy6kqZdGwattpXaAdIjYLIXBhr+wQG
	 pihBl9NpRMWfeZIWyEDotto5AwSOz6sIWVs1Psd6e+ybXX8npneqljAj7eXCBx9LWXciC
	 wsdC7h4wypKUXjAGInTc1QGjWrbfVYPcTWLG53B44z6WQbeJhPc2j5Q2OGIPxEFVfpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469116;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CKYYC7+S8IFKIRvbC15hJC9EndO9YVRw19MajVMePyI=;
	b=pzmmd94o0XLpRHHvt/lflFs+NV79XKZxxLAhgN/s+0/0StYmwW2SudDGfaPQgetPE5+B
	 nPKR7q63Gfv3LCL+znm9PCqmwmWYgGYxRq1AHJdgCNiFaCXTgLEc4Zd0dUiXaUp21NtLO
	 Ils0O6spbmE9A70c9YvE8bp5dg5Ui1TGL97x+T+uHH1tfH55RPG5xbnzHYqb0UOQZ6PQm
	 dSdMqFzXCAzHub71BrabDvmvsqCuyICHh92XJMwbA7nwjhED8QhnMiS4L4PrJMpoWj6Uq
	 BeDu+MF/gfjewNKnO3Sr4bR6Z1Wyy9lXGPmoIfxGfID/qQ5JFl3AXgW9KRyKrwB9zZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTKJk5ii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D12606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTKJk5ii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126ED1F000C1;
	Sat, 31 Oct 2026 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469116;
	bh=CKYYC7+S8IFKIRvbC15hJC9EndO9YVRw19MajVMePyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VTKJk5iiyjtFIfT/079aaO2bs9/Tqx4ZL4vqHuunCm9RR2D52Q0r2LMTHZPYXXTVh
	 z3aBzlP5/nWuzXwYW3oCUB3zNvSZZOMwhCl0g/x1wMpDiE1JjK5k2G/LYg3xpPHwU4
	 ZlBlqQm53NtfeyHu/YBSNpoCM30tHc1QmQpqaLY5E8yM6wNfVN8JRWtL2YgENHO08h
	 0kdulIWqaRhJ0v6etwM+GEO5TV7IkoSSVfUc0tSujk0uNn3loUw+eSO1uEESdJ/OKN
	 wNeT+/dl7/VZPalvISqVSEAWNC7Fbe1E4clfV/iTdBTyHUjXVS1TkkoktUjRjTanHm
	 7AvD5CmQ41ipQ==
Message-ID: <sashiko-outbox-192074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/17] HID: asus: add joysticks anti-deadzone
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261031174130.208240-8-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-8-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 17:51:55 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: asus: ABBA deadlock between ally_prefs.lock and kernfs_drain()
--

commit 69043ee7052574919d9b6d50e4a364916a41871f
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add joysticks anti-deadzone configuration

This commit adds sysfs attributes to configure the joystick anti-deadzone
parameter on ROG Ally devices and restores the configured values during
device initialization.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 5cf7258bc4273..9bfdde560834d 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1321,11 +1324,152 @@ static struct device_attribute dev_attr_right_jo=
ystick_outer_threshold =3D
>  static struct device_attribute dev_attr_right_joystick_outer_threshold_r=
ange =3D
>  	__ATTR(outer_threshold_range, 0444, right_joystick_outer_threshold_rang=
e_show, NULL);
> =20

[ ... ]

> +static ssize_t ally_anti_deadzone_show(struct device *dev, char *buf,
> +				       enum ally_joystick which)
> +{
> +	guard(mutex)(&ally_prefs.lock);
> +
> +	if (!ally_prefs.anti_deadzone_support) {
> +		hid_dbg(to_hid_device(dev), "Anti-deadzone not supported on this devic=
e\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", *ally_anti_deadzones[which]);
> +}
> +
> +static ssize_t ally_anti_deadzone_store(struct device *dev, const char *=
buf,
> +					size_t count, enum ally_joystick which,
> +					const char *group)
> +{
> +	u8 value, dz[ARRAY_SIZE(ally_anti_deadzones)];
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	unsigned int i;
> +	int ret;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value > 100)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		if (!ally_prefs.anti_deadzone_support) {
> +			hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		for (i =3D 0; i < ARRAY_SIZE(dz); i++)
> +			dz[i] =3D *ally_anti_deadzones[i];
> +		dz[which] =3D value;
> +
> +		ret =3D ally_set_anti_deadzone(hdev, dz[ALLY_LEFT_JOYSTICK],
> +					dz[ALLY_RIGHT_JOYSTICK]);
> +		if (ret)
> +			return ret;
> +
> +		*ally_anti_deadzones[which] =3D value;
> +	}
> +
> +	sysfs_notify(&dev->kobj, group, "anti_deadzone");
> +
> +	return count;
> +}

[ ... ]

> @@ -1602,7 +1748,7 @@ static int ally_prefs_setup(struct hid_device *hdev)
>  	}
> =20
>  	/* Skip the calibration groups when the capability is missing. */
> -	if (ally_prefs.user_cal_support) {
> +	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support) {
>  		int cal_i;
> =20
>  		for (cal_i =3D 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups); cal_i++) {
> @@ -1643,8 +1789,7 @@ static void ally_sysfs_remove(struct hid_device *hd=
ev)
>  	for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
>  		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> =20
> -	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support ||
> -	    ally_prefs.resp_curve_support) {
> +	if (ally_prefs.user_cal_support || ally_prefs.anti_deadzone_support) {
>  		for (i =3D 0; i < ARRAY_SIZE(ally_cal_attr_groups); i++)
>  			sysfs_remove_group(&hdev->dev.kobj, ally_cal_attr_groups[i]);
>  	}

[Severity: High]
Can this cause an ABBA deadlock between ally_prefs.lock and the kernfs acti=
ve
reference when userspace accesses the anti_deadzone sysfs attribute
concurrently with device disconnect, unbind, or setup rollback?

In drivers/hid/hid-asus.c, when userspace reads or writes the anti_deadzone
sysfs attribute, kernfs_fop_read_iter() or kernfs_fop_write_iter() acquires
the kernfs active reference via kernfs_get_active() before invoking
ally_anti_deadzone_show() or ally_anti_deadzone_store(), both of which then
take ally_prefs.lock:

  kernfs_fop_read_iter() / kernfs_fop_write_iter()
    kernfs_get_active()               [acquires kn->active]
    ally_anti_deadzone_show() / ally_anti_deadzone_store()
      mutex_lock(&ally_prefs.lock)    [waits for ally_prefs.lock]

Concurrently, ally_sysfs_remove() (and the error rollback path in
ally_prefs_setup()) holds ally_prefs.lock via guard(mutex)(&ally_prefs.lock)
while calling sysfs_remove_group() on ally_cal_attr_groups:

  ally_sysfs_remove() / ally_prefs_setup()
    guard(mutex)(&ally_prefs.lock)    [holds ally_prefs.lock]
    sysfs_remove_group()
      __kernfs_remove()
        kernfs_drain()                [waits for kn->active to drain]

Wouldn't this lock inversion deadlock if a thread enters
ally_anti_deadzone_show() or ally_anti_deadzone_store() just as
ally_sysfs_remove() or ally_prefs_setup() removes the attribute groups under
ally_prefs.lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031174130.2082=
40-1-denis.benato@linux.dev?part=3D7
