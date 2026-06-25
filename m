Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C137DAB3
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375523; cv=none; b=BX8lLShOGXTRjb6kWiQP+NrEUMumtP1Xiy9jFohR7J5vsxMY8OYHoM5/v884QXrNzfe7Gkdx9YBl10vuxtVGiatdMue9uPXdFtkuKXy95YBoPiIVQmsrab9u04ieq0J1TZFXJuhndGnRtkrEQjTzrPFZEKQJE3t/aecaCc1dal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375523; c=relaxed/simple;
	bh=VFUn3ze/xdjVdMbBNsUsEgEw7XD1k/2pJmIO4XAdqmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u/89QLHp9sqPO8BQxZJ8NERdKoi44TcgZAU6kbvWK54Q7N39SA2owym4eW8hUR7l1mhTkGBaJfrIKamSQH5sFUR+L8iEj2GizCEl5778qkecVetDrtxLMKJPeTPOy9d4T+T+IFbBHhv26zRjpbBN+yHRx4gTtkUmyD0NQBFOjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y58BWl3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y58BWl3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580BE1F000E9;
	Thu, 25 Jun 2026 08:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782375521;
	bh=by2OlsS9cL8eQnM7UkyfDwyPC3JwipPFG4387w437ls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y58BWl3KY3HTfRMI1/HNMAJGILskc1whqfvf/z44kzWVIYtFE0xr02Wi1AZLwIii5
	 tvqgJLy9n7JYwYNL2SX+426w8sHL5kF7EfDpe2eDM9lhrptmgJFQYBjfOtBuTPbWu7
	 g19ZZAxnI/4c0WCn9mpc3JouhLAYVb4WZuZRzaJFY3muS8FrPmWhok2NGQs7s+OLbf
	 GmZnGK7r1zWQjlC4iiQ58MuanU0XZWre7uhesdeL/hztGS3F7AKYwaAt7KrD2WWt9r
	 8HPCyBdkw5d9w/hFu4q9sLI57Dv5D7ygFi75mczp38/pUhdaSQeFldrPZe794AGwQU
	 PerIY9Cf9fktg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
Reply-To: sashiko-reviews@lists.linux.dev
To: DevExalt <exalt.dev.team@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260625080807.74157-1-exalt.dev.team@gmail.com>
References: <20260625080807.74157-1-exalt.dev.team@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:18:40 +0000
Message-Id: <20260625081841.580BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Use-After-Destroy of `multiplatform_lock` and race with hardware t=
eardown due to deferred sysfs cleanup.
- [Medium] The `platform` sysfs attribute is exposed before IO is re-enable=
d, causing writes to time out and drop packets.
- [Low] The `platform` sysfs attribute documentation incorrectly claims it =
supports read operations.
--

commit b016243fdd25010c24333aa504f62dd4e1905e09
Author: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>

HID: logitech-hidpp: Add support for HID++ Multi-Platform feature (0x4531)

Add support in the Logitech HID++ driver for the HID++ Multi-Platform
feature (0x4531), which enables HID++ devices to adjust their behavior
based on the host operating system.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 90b0184df777f..a41fac1b4d82d 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
[ ... ]
> @@ -4423,6 +4427,379 @@ static bool hidpp_application_equals(struct hid_d=
evice *hdev,
>  	return report && report->application =3D=3D application;
>  }
> =20
> +/* ---------------------------------------------------------------------=
----- */
> +/* 0x4531: Multi-Platform Support                                       =
      */
> +/* ---------------------------------------------------------------------=
----- */
> +
> +/*
> + * Some Logitech devices expose the HID++ feature 0x4531 (Multi-Platform=
) allowing
> + * the host to specify which operating system platform to use on the dev=
ice. Changing device's
> + * platform may alter the behavior of the device to match the specified =
platform.
> + *
> + * Devices that implement this feature expose a per-device sysfs attribu=
te
> + * "platform". Writing one of (windows|winemb|linux|chrome|android|
> + * macos|ios|webos|tizen) selects the matching platform descriptor on th=
e device;
> + * reading reports the platform last applied through this attribute, or =
an empty
> + * line if none has been set.
> + */

[Severity: Low]
This isn't a bug, but the comment mentions that reading reports the platform
last applied. However, the sysfs attribute is declared as Write-Only using
DEVICE_ATTR_WO(platform) further below.

Should this block comment be updated, or was a read function intended to be
included?

[ ... ]
> +static ssize_t platform_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
> +	char platform[16];
> +	int idx;
> +	int ret;
> +
> +	strscpy(platform, buf, sizeof(platform));
> +	string_lower(platform, platform);
> +
> +	idx =3D sysfs_match_string(multiplatform_names, platform);
> +	if (idx < 0)
> +		return idx;
> +
> +	mutex_lock(&hidpp->multiplatform_lock);

[Severity: High]
Does this create a use-after-destroy regression?

Because devm_device_add_group() is used in hidpp_multiplatform_init(), the
sysfs attribute group is removed only after hidpp_remove() returns.

If hidpp_remove() destroys the multiplatform_lock via mutex_destroy(), coul=
d a
concurrent userspace write to the platform sysfs attribute attempt to lock
the destroyed mutex here?

> +	ret =3D hidpp_multiplatform_set_platform(hidpp, multiplatform_masks[idx=
]);
> +	mutex_unlock(&hidpp->multiplatform_lock);
> +	if (ret)
> +		return ret;
> +
> +	hid_dbg(hdev, "Multiplatform: Device platform set to '%s'\n",
> +		multiplatform_names[idx]);
> +
> +	return count;
> +}
[ ... ]
> @@ -4517,6 +4895,8 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
>  		connect_mask &=3D ~HID_CONNECT_HIDINPUT;
> =20
> +	hidpp_multiplatform_init(hidpp);
> +
>  	/* Now export the actual inputs and hidraw nodes to the world */
>  	hid_device_io_stop(hdev);

[Severity: Medium]
Will writes to the sysfs attribute time out here?

By initializing the sysfs attribute group in hidpp_multiplatform_init() and
immediately stopping IO with hid_device_io_stop(), the driver creates a
window where writes from userspace are possible but IO responses are blocke=
d.

If a write happens before hid_device_io_start() is called later in probe,
could hidpp_send_fap_command_sync() wait for a response that never arrives,
causing a -ETIMEDOUT error and dropping packets?

>  	ret =3D hid_connect(hdev, connect_mask);
[ ... ]
> @@ -4576,6 +4957,7 @@ static void hidpp_remove(struct hid_device *hdev)
>  	cancel_work_sync(&hidpp->work);
>  	cancel_work_sync(&hidpp->reset_hi_res_work);
>  	mutex_destroy(&hidpp->send_mutex);
> +	mutex_destroy(&hidpp->multiplatform_lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625080807.7415=
7-1-exalt.dev.team@gmail.com?part=3D1
