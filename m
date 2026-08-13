Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA99483BE9
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633372; cv=none; b=MkXq3nj6uFeCwOIWhSfyYM8L9rXI25KqnjfYY0AB7R1/fRLqR+oA2joHIbd3ZoLUfRtxImI9XGLed7vw2NWGO3i9ZWn0EqiGjnSAcVwg6/jE23h+xoQLumM8QY9Bb/RnYYoILIfwDzh5+tr25VdPqoDzrO30MH+WEDgtx0RomEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633372; c=relaxed/simple;
	bh=g6NIc2nQuryMYquc6o1ipoA+pDJa2MJXBVsZ8Nlsxuw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cRaMVF6O1DavnKv2bR1ddSawHUH4C8N7MIPjpBkZPD8FJ7OA0QzQsWetPW7Pf9V0VB6F8BShzMnrBFi0RB6THSEZW2CjOYT3lcf0dPMBWy6NC4zXzXr5onsGdBHX7gtGdbqa8npz+LBgaJ0EiG8+9RfIHK5Ia1CAbcTueBDj6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuCEMI2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuCEMI2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469BA1F000E9;
	Thu, 13 Aug 2026 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633370;
	bh=srrtATS/2jjLnNLtqpyBqRlBimlhoD0cUIQBw794pcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuCEMI2/vcZZXwd4mRRuCBC5RyT0A/2BJkzKVUzh/BEo7LRmNdAg/cjIDH30WJKTn
	 xmH8OfjDc6hzX7zlOPCu+Q3VvNCtG13o6RXbY7ug7REB1ce69ftvL8vdU46C2aL4zi
	 YhJpqzZAIzaEEFKZtq//JkfA7m06xfKPKpizcgS10flh7LD0LLnue7tU7oFkA6Jtow
	 KaBxKVng5/KgR5F/p5WSwWO+QcxVi9JRTtFHZfgSzm1/cZls9XNU23rGsUd+8FN89Y
	 HJl3dqtz1USUGxEQ0FfGtXQE9Bg6xUdoItx1cgRMZJlEtJEFLaLTXD0Y15peYKMdmZ
	 oTdE8SlAw+O7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] HID: asus: add joysticks inner and outer range
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260813144736.2477941-6-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-6-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:02:49 +0000
Message-Id: <20260813150250.469BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Uninitialized Mutex `config_mutex` in `ally_config`
- [High] NULL Pointer Dereference due to TOCTOU on `ally->config`
- [Medium] Data Race and State Desynchronization in Sysfs Handlers
- [Low] Dead Code: Unused Macros
--

--- Patch [5]: [PATCH 05/12] HID: asus: add joysticks inner and outer range=
 configuration ---
commit bd4086a93a46d9dd4b9c0379eb086b2a077f1489
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add joysticks inner and outer range configuration

ROG Ally devices supports configuring joysticks inner and outer range:
add sysfs attributes to allow userspace modifying the sensitivity
of those controllers.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 48cc867aeea86..010b33533068a 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -133,6 +133,19 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
> =20
>  #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
> =20
> +#define ALLY_DEVICE_ATTR_RO(_name, _sysfs_name)    \
> +	struct device_attribute dev_attr_##_name =3D \
> +		__ATTR(_sysfs_name, 0444, _name##_show, NULL)
> +
> +#define ALLY_DEVICE_CONST_ATTR_RO(fname, sysfs_name, value)			\
> +	static ssize_t fname##_show(struct device *dev,				\
> +				   struct device_attribute *attr, char *buf)	\
> +	{									\
> +		return sysfs_emit(buf, value);					\
> +	}									\
> +	struct device_attribute dev_attr_##fname =3D				\
> +		__ATTR(sysfs_name, 0444, fname##_show, NULL)

[Severity: Low]
Are these macros used anywhere in this patch or the rest of the codebase?

[ ... ]

> +static ssize_t left_joystick_inner_threshold_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally =3D drvdata->rog_ally;
> +	u8 value;
> +	int ret;
> +
> +	if (!ally || !ally->config)
> +		return -ENODEV;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret || value > 50)
> +		return -EINVAL;
> +
> +	ret =3D ally_set_joystick_thresholds(hdev, ally->config,
> +					   value,
> +					   ally->config->left_outer_threshold,
> +					   ally->config->right_deadzone,
> +					   ally->config->right_outer_threshold);

[Severity: High]
Could ally->config become NULL after the initial check if a concurrent devi=
ce
removal (like USB unplug) occurs while this sysfs write is executing?

If hid_asus_ally_remove() runs concurrently and sets ally->config to NULL:

hid_asus_ally_remove() {
    if (ally->cfg_hdev =3D=3D hdev) {
        ally_config_remove(hdev, ally);
        ally->cfg_hdev =3D NULL;
        ally->config =3D NULL;
    }
}

Then this function could dereference a NULL pointer when reading
ally->config->left_outer_threshold. Would it be safer to cache the config
pointer locally?

[Severity: Medium]
Does reading ally->config->left_outer_threshold and other variables
locklessly create a race condition with other concurrent sysfs writes?

If two writes interleave, they could both read the same threshold values
before either updates the hardware, causing the hardware state to become
desynchronized with the sysfs cache. Should the mutex be acquired before
reading the current configuration and sending the hardware command?

> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &ally->config->config_mutex)

[Severity: High]
Is config_mutex initialized before being used here?

Looking at ally_config_create(), the configuration structure is allocated
with devm_kzalloc(), but mutex_init() is never called on config_mutex. Will
acquiring this all-zeros mutex trigger a crash or lockdep failure?

> +		ally->config->left_deadzone =3D value;
> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D5
