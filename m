Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E3326939
	for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 03:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752471; cv=none; b=DguId7Pp64sdTmSXRYJoCjMs3T+VwmHo7V5P9h5+Ylfcp7NlF8pf968aMOy3jFXzTl341lAcYG4yBLwIa611Wky+2ZlHVXDduFNFA3Ns5Vw9kmXGwx7BwHuAzkTXEXQsEjWKv9bFzGECtcpywijT278tyhDPCEshBa/yZQsPLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752471; c=relaxed/simple;
	bh=CmPvEmlyE9Oc6q7tca8n1sbaLYEDpzCaUe/HNnTKxKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DTcyGC2qG+1SDRxyx+HFR9vyPCyPskkHESHdTLNWKusAvrajK81r2XzGUmcKSZ02gO0E4NfgCFvPGKAJDiFWeVhL5hzSHGPAvQrjP6AJ6UguajuV1+1Kd9xcy4OHNArMz/3vgmyMOUVPVgogsma350ZDtqNrvCdQkA5jQLSwsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr/Xnh3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr/Xnh3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79481F000E9;
	Thu, 18 Jun 2026 03:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781752470;
	bh=D3FZfUzLdivkmkJWT4BctiFuarZu0TP1eCus10zY64s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jr/Xnh3bVnHw/lfwFYW9nBPeb2l7ZSbWbxlnqKEonNrl+4psbB+gKF948QcX5J8++
	 n1bioHNQfc2LGZzGAZyHeiQpphQpje86q/O51I1ZOFlKnJPQVnJ3OTebxBRmEFeNiq
	 ZCNAbgMQpI5DHIX/RZUpovRzFRSSkWgqgrbPT4ylERKImCP+iBnkiR8HhOzWNusHUo
	 9w/IDptVojgQCchlHuPwoFkwVA856SXlS536/89EcErCS0W3S3CTYKi84HT+OpL7YW
	 B9iww/1gpEIaM1j2RVXGRX8CT+mrHv5AX5sLC/CVNcYQWBJ21l/2oXV38W09CffniR
	 xfog5ULaU3wjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: roccat: add KUnit test for kone profile-index
 bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260618030036.1880139-3-michael.bommarito@gmail.com>
References: <20260618030036.1880139-1-michael.bommarito@gmail.com>
 <20260618030036.1880139-3-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 03:14:29 +0000
Message-Id: <20260618031429.C79481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A Use-After-Free vulnerability occurs because the `kone_device` st=
ructure is freed while hardware interrupts are still active, leaving a dang=
ling pointer in `hid_drvdata`.
- [High] Uninitialized kernel memory is copied to the persistent `kone->set=
tings` structure on a failed USB control message, leading to a heap informa=
tion leak via sysfs.
--

commit e8aee21a8be54aaf776b4d76c32eeaefd255b5aa
Author: Michael Bommarito <michael.bommarito@gmail.com>

HID: roccat: add KUnit test for kone profile-index bounds

This commit adds a KUnit test for the Roccat Kone driver to verify bounds
checking on profile indices. It simulates a crafted switch-profile event to
ensure the driver does not read out-of-bounds.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index ff2f580b660ba..3c6bc918aeb54 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1057,6 +1057,15 @@ config HID_ROCCAT
>  	Say Y here if you have a Roccat mouse or keyboard and want
>  	support for its special functionalities.
> =20
> +config HID_ROCCAT_KONE_KUNIT_TEST
> +	bool "KUnit tests for the Roccat Kone driver" if !KUNIT_ALL_TESTS
> +	depends on HID_ROCCAT=3Dy && KUNIT=3Dy
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable the KUnit regression tests for the Roccat Kone driver,
> +	  covering bounds checking of device-supplied profile indices.
> +	  If unsure, say N.
> +
>  config HID_SAITEK
>  	tristate "Saitek (Mad Catz) non-fully HID-compliant devices"
>  	help
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> index 17495fcc8b7da..3dae9eaa0b6f4 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c

[ ... ]

> @@ -919,3 +919,60 @@ module_exit(kone_exit);
>  MODULE_AUTHOR("Stefan Achatz");
>  MODULE_DESCRIPTION("USB Roccat Kone driver");
>  MODULE_LICENSE("GPL v2");
> +
> +#if IS_ENABLED(CONFIG_HID_ROCCAT_KONE_KUNIT_TEST)
> +#include <kunit/test.h>
> +
> +/*
> + * Regression test for the out-of-bounds read in
> + * kone_keep_values_up_to_date(): a malicious USB device sends a
> + * "switch profile" HID event (event =3D=3D kone_mouse_event_switch_prof=
ile)
> + * with an attacker-chosen value in 0..255, which is used unbounded as
> + * profiles[value - 1].  On an unpatched kernel the attack case triggers=
 a
> + * KASAN slab-out-of-bounds read; the fix must leave actual_dpi unchange=
d.
> + */
> +static void kone_profile_index_oob_test(struct kunit *test)
> +{
> +	struct kone_device *kone;
> +	struct kone_mouse_event ev =3D {};

[ ... ]

> +	/* attack: value =3D=3D ARRAY_SIZE(profiles) + 1 reads profiles[5], one
> +	 * element past the array end -> KASAN slab-out-of-bounds read on an
> +	 * unpatched kernel. The fix must reject it (actual_dpi unchanged).
> +	 */
> +	ev.value =3D ARRAY_SIZE(kone->profiles) + 1;
> +	kone_keep_values_up_to_date(kone, &ev);
> +	KUNIT_EXPECT_EQ(test, kone->actual_dpi, 0x42);
> +}
> +
> +static struct kunit_case kone_test_cases[] =3D {
> +	KUNIT_CASE(kone_profile_index_oob_test),
> +	{}
> +};
> +
> +static struct kunit_suite kone_test_suite =3D {
> +	.name =3D "hid-roccat-kone",
> +	.test_cases =3D kone_test_cases,
> +};
> +kunit_test_suite(kone_test_suite);
> +#endif /* CONFIG_HID_ROCCAT_KONE_KUNIT_TEST */

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing I noticed a
potential use-after-free vulnerability in the driver initialization and
teardown paths.

In kone_probe(), hid_hw_start() is called before kone_init_specials(),
starting the hardware and enabling USB interrupts. If initialization fails,
the error path frees the driver data but does not clear the pointer:

drivers/hid/hid-roccat-kone.c:kone_init_specials() {
...
exit_free:
	kfree(kone);
	return retval;
}

Between kfree() and hid_hw_stop(), an incoming USB interrupt will trigger
kone_raw_event(), which dereferences the dangling pointer:

drivers/hid/hid-roccat-kone.c:kone_raw_event() {
...
	struct kone_device *kone =3D hid_get_drvdata(hdev);
...
}

The same window exists in the teardown path, where the driver state is freed
before stopping the hardware:

drivers/hid/hid-roccat-kone.c:kone_remove() {
...
	kone_remove_specials(hdev);
	hid_hw_stop(hdev);
}

Is it possible for an attacker to trigger this use-after-free by
disconnecting the device or simulating a device error while hardware
interrupts are active?

[Severity: High]
This is a pre-existing issue, but there appears to be a potential heap
information leak when copying uninitialized memory after a failed USB
transfer.

In kone_receive(), a bounce buffer is allocated with kmalloc() and
unconditionally copied to the target even if the USB transfer fails:

drivers/hid/hid-roccat-kone.c:kone_receive() {
	buf =3D kmalloc(size, GFP_KERNEL);
...
	retval =3D usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0), ...
...
	memcpy(data, buf, size);
	kfree(buf);
	return retval;
}

When called via kone_get_settings(), the uninitialized kernel heap memory
is copied to the persistent settings structure. If this occurs during a
sysfs operation where the error is handled, the corrupted structure remains
intact:

drivers/hid/hid-roccat-kone.c:kone_sysfs_set_tcu() {
...
	retval =3D kone_get_settings(usb_dev, &kone->settings);
	if (retval)
		goto exit_no_settings;
...
}

A subsequent read of the settings sysfs attribute exposes this memory
directly to userspace:

drivers/hid/hid-roccat-kone.c:kone_sysfs_read_settings() {
...
	memcpy(buf, ((char const *)&kone->settings) + off, count);
...
}

Could a malicious USB device intentionally fail the transfer to exploit
this leak? Should we check the return value of usb_control_msg() before
calling memcpy() in kone_receive()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618030036.1880=
139-1-michael.bommarito@gmail.com?part=3D2
