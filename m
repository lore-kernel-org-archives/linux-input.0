Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757553;
	b=pBVoJTpXbffDyHfjPsRHi45o98M4e/dKJfOKa3KnVUfxvuf+83VBd5iozn/d/zzDqhhr
	 fEIDdXCNpwlilRLGTmwSeoHi7PGfZ/8DyiNwAZP6Um5mQQVFwDIYusvZTtA9c3r9TOZ1t
	 50Rl2iuDimSMl2hlq0YzYARuMIhSSU3bH4n7G0o6SCmr325GQzcO3t3v003DwIhXSYzbr
	 BYdb0lUBRbJlR/KceBVqEWn2MTm0qi0OyAtu6aLDFZe4t1n1Z9FeD1qPLYxN29X9MYkDg
	 ZGK57UjXocif3Jh1CUdG9SvzKkbh7jE+9Eng+4HOTPFv6Ma8A+/i8mbaLdEfMHFE13Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757553;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DVhadbPpTu5BxsO/0TOSoPZXbh7auWeR3iPIzlidq9k=;
	b=wH8LTjw7Vucm6yD6Q3uWTrw/Bc8qOTUvP2VL+hhp6waNGV9m0Z3o7K7X79B82orX0QGH
	 kCX70EBbzTrtlDomTJOUpd+EeYoo6j1sB87A+yIAqRvIAfPDp9FnjLG04LRdNec3QYVH3
	 laBh36rB43sPM0kPnH93rWQmMblNnCKMrIyjzpvZ6puP+QQzfyxyyjVYQY85wGLj83Ub1
	 jcfc8UdHK8AYR35RSFxXXvSAFQUUiPp4+T/3IH4yFqB2TwBnhsevaUh3pcw9bzQMJ81UB
	 USxQbkO1Ee21s/1kYoe44JlWtUNB6iMPFSpIk0HlCk7VGH8ra/69wACnNcP6kBqJtAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcxzbRSh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DA606A31B
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcxzbRSh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EED1F000C1;
	Wed,  4 Nov 2026 01:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757553;
	bh=DVhadbPpTu5BxsO/0TOSoPZXbh7auWeR3iPIzlidq9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CcxzbRSh5opGSQZ8crWHdCOpVAks9cgSLMTKVPo20MmanhQHcm7E2nCQtt/sx4nc2
	 vDkyt+5ZCFk/AFiYrxNndcT1xgx0UiRsqhLo7D+3lzcJkylLQDlrEi07RrbB2w1Hqd
	 8vUi093G21h/6RKse23zAZe9UhLo9X+eH9Hp2zwHDB/xZ5mucjjGkl7zEo3wvEb2Bc
	 GHPa8agAbLZIuez4sgyOzs4Jo2rEMTLsgxW1vCHOpLZYEWTcG2przIhxOuIZCRwqyb
	 WkMIBZrTNY9PrDa0OV9R5yf+4Aii8Zc2VQ7S/dXKH/y1L6z6uA7aLbhblvtntWhRS8
	 MiwoHDy7y8S7A==
Message-ID: <sashiko-outbox-196420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/18] HID: asus: add gamepad configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104013935.512713-4-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
 <20261104013935.512713-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:59:12 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] HID: asus: unlocked feature report transfers in hid_asus_ally_re=
set_resume()
- [Low] HID: asus: ally_detect_capabilities() mixes guard(mutex) with goto
- [Low] HID: asus: open-coded sysfs group helpers in ally_prefs_setup()
--

commit 23ba9584ee0ff2df9f8412928af4abbe35ed412d
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add gamepad configuration

This commit adds gamepad capability detection and preference storage for
ASUS ROG Ally devices, exposes the xbox_controller sysfs attribute, and
waits for the gamepad MCU to report ready during reset_resume.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 2a3e8c399f0aa..8277d7108bb97 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -762,6 +776,281 @@ static int ally_get_endpoint_address(struct hid_dev=
ice *hdev)
>  	return ep->desc.bEndpointAddress;
>  }

[ ... ]

> +static int ally_detect_capabilities(struct hid_device *hdev)
> +{
> +	int ret;
> +
> +	guard(mutex)(&ally_prefs.lock);
> +
> +	ally_prefs.is_ally_x =3D (hdev->product =3D=3D USB_DEVICE_ID_ASUSTEK_RO=
G_NKEY_ALLY_X);
> +
> +	ret =3D ally_check_capability(hdev, CMD_CHECK_XBOX_SUPPORT);
> +	if (ret < 0)
> +		goto ally_detect_capabilities_err;
> +	ally_prefs.xbox_controller_support =3D ret;
> +
> +
> +	ret =3D ally_check_capability(hdev, CMD_CHECK_USER_CAL_SUPPORT);
> +	if (ret < 0)
> +		goto ally_detect_capabilities_err;
> +	ally_prefs.user_cal_support =3D ret;
> +
> +	ret =3D ally_check_capability(hdev, CMD_CHECK_TURBO_SUPPORT);
> +	if (ret < 0)
> +		goto ally_detect_capabilities_err;
> +	ally_prefs.turbo_support =3D ret;
> +
> +	ret =3D ally_check_capability(hdev, CMD_CHECK_RESP_CURVE_SUPPORT);
> +	if (ret < 0)
> +		goto ally_detect_capabilities_err;
> +	ally_prefs.resp_curve_support =3D ret;
> +
> +	ret =3D ally_check_capability(hdev, CMD_CHECK_DIR_TO_BTN_SUPPORT);
> +	if (ret < 0)
> +		goto ally_detect_capabilities_err;
> +	ally_prefs.dir_to_btn_support =3D ret;
> +
> +	ret =3D ally_check_capability(hdev, CMD_CHECK_GYRO_TO_JOYSTICK);
> +	if (ret < 0)
> +		goto ally_detect_capabilities_err;
> +	ally_prefs.gyro_support =3D ret;
> +
> +	ret =3D ally_check_capability(hdev, CMD_CHECK_ANTI_DEADZONE);
> +	if (ret < 0)
> +		goto ally_detect_capabilities_err;
> +	ally_prefs.anti_deadzone_support =3D ret;
> +
> +	return 0;
> +ally_detect_capabilities_err:
> +	hid_err(hdev, "Failed to detect capabilities: %d\n", ret);
> +	return ret;
> +}

[Severity: Low]
This isn't a bug, but ally_detect_capabilities() in drivers/hid/hid-asus.c
mixes guard(mutex)(&ally_prefs.lock) with goto ally_detect_capabilities_err,
contrary to the cleanup.h convention of not mixing scope-based cleanup
helpers with goto error paths in the same function.

Since ally_check_capability() and the caller hid_asus_ally_probe() already
log hid_err() on failure, and ally_detect_capabilities_err performs no
resource cleanup, could each failed check in ally_detect_capabilities()
simply return ret directly?

[ ... ]

> +static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *i=
ntf)
> +{
> +	int ret, i;
> +
> +	ret =3D ally_detect_capabilities(hdev);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		if (!ally_prefs.initialized) {
> +			ally_prefs.gamepad_mode =3D 0x01;
> +			ally_prefs.xbox_controller_enabled =3D true;
> +			ally_prefs.initialized =3D true;
> +		}
> +
> +		if (intf->sysfs_live)
> +			return 0;
> +	}
> +
> +	/*
> +	 * Create and remove sysfs groups without ally_prefs.lock. Attribute
> +	 * methods take that lock while holding a kernfs active reference;
> +	 * removing a group drains those references, so locking here would
> +	 * invert the order and deadlock.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++) {
> +		ret =3D sysfs_create_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +		if (ret) {
> +			hid_err(hdev, "Failed to create Ally sysfs group '%s': %d\n",
> +				ally_attr_groups[i].name ?: "", ret);
> +			while (i--)
> +				sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +			return ret;
> +		}
> +	}
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		intf->sysfs_live =3D true;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ally_sysfs_remove(struct hid_device *hdev, struct ally_intf =
*intf)
> +{
> +	int i;
> +
> +	if (!intf)
> +		return;
> +
> +	if (ally_get_endpoint_address(hdev) !=3D HID_ALLY_INTF_CFG_IN)
> +		return;
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		if (!intf->sysfs_live)
> +			return;
> +
> +		intf->sysfs_live =3D false;
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
> +		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +}

[Severity: Low]
This isn't a bug, but ally_prefs_setup() and ally_sysfs_remove() in
drivers/hid/hid-asus.c open-code the iteration and error rollback over
ally_attr_groups using sysfs_create_group() and sysfs_remove_group().

Could ally_attr_groups be defined with ATTRIBUTE_GROUPS() (or a
NULL-terminated struct attribute_group pointer array) so ally_prefs_setup()
and ally_sysfs_remove() can use sysfs_create_groups() and
sysfs_remove_groups() instead?

[ ... ]

> @@ -944,6 +1233,14 @@ static int hid_asus_ally_init(struct hid_device *hd=
ev)
>  	if (ret < 0)
>  		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> =20
> +	guard(mutex)(&ally_prefs.lock);
> +
> +	if (ally_prefs.initialized && ally_prefs.xbox_controller_support) {
> +		ret =3D ally_set_xbox_controller(hdev, ally_prefs.xbox_controller_enab=
led);
> +		if (ret < 0)
> +			hid_warn(hdev, "Failed to apply Xbox controller mode: %d\n", ret);
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -1038,6 +1335,12 @@ static struct ally_intf *hid_asus_ally_probe(struc=
t hid_device *hdev)
>  			return ERR_PTR(ret);
>  		}
> =20
> +		ret =3D ally_prefs_setup(hdev, intf);
> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to create Ally cfg: %d\n", ret);
> +			return ERR_PTR(ret);
> +		}
> +
>  		hid_asus_ally_init(hdev);
>  		break;
>  	case HID_ALLY_X_INTF_IN:
> @@ -1058,7 +1361,7 @@ static struct ally_intf *hid_asus_ally_probe(struct=
 hid_device *hdev)
> =20
>  static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct al=
ly_intf *intf)
>  {
> -	int ep;
> +	int ep, ret;
> =20
>  	/*
>  	 * The extensions failed to probe and the device is operating as a
> @@ -1071,6 +1374,12 @@ static int hid_asus_ally_reset_resume(struct hid_d=
evice *hdev, struct ally_intf
>  	if (ep !=3D HID_ALLY_INTF_CFG_IN)
>  		return 0;
> =20
> +	ret =3D ally_gamepad_check_ready(hdev);
> +	if (ret < 0) {
> +		hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
> +		return ret;
> +	}
> +
>  	return hid_asus_ally_init(hdev);
>  }

[Severity: Medium]
Can a concurrent write to xbox_controller_store() race with the unlocked
feature report transfers in hid_asus_ally_reset_resume() and
hid_asus_ally_init()?

Once ally_prefs_setup() exposes the sysfs group on hdev->dev.kobj,
xbox_controller_store() remains live across suspend and reset_resume (as
well as during the rest of hid_asus_ally_probe()):

    xbox_controller_store()
      guard(mutex)(&ally_prefs.lock)
      ally_set_xbox_controller()
        ally_gamepad_send_packet()
          ally_dev_set_report() /* feature report 0x5A */

However, hid_asus_ally_reset_resume() runs ally_gamepad_check_ready()
without holding ally_prefs.lock, where each attempt performs a two-step
command and response sequence over USB control transfers:

    hid_asus_ally_reset_resume()
      ally_gamepad_check_ready()
        ally_gamepad_send_receive_packet()
          ally_dev_set_report() /* feature report 0x5A */
          ally_dev_get_report() /* feature report 0x0D */

Similarly, hid_asus_ally_init() sends ally_force_feedback_off via
ally_gamepad_send_packet() before acquiring ally_prefs.lock.

If userspace writes to xbox_controller during hid_asus_ally_reset_resume()
or hid_asus_ally_init(), can CMD_SET_XBOX_CONTROLLER be sent before the MCU
is ready or interleave between ally_dev_set_report() and
ally_dev_get_report() in ally_gamepad_check_ready(), causing the readiness
check or configuration command to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104013935.5127=
13-1-denis.benato@linux.dev?part=3D3
