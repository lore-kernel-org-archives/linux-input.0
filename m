Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE33BD64A;
	Thu,  2 Jul 2026 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032343; cv=none; b=AtWykLfIezNAK0boE/+KJOa5x3vOKIqJlkhsiAwwwrO34qxF24DmWXkup2Z3VBMOissSgp41FLTQozXnz6g0gwCPNu5vgM9WSAqOAFzbnBOkYbRY1ik5iRmmTQCFwpc2QJUHhdXcj+0qTpTjdJovth8+r0Gif2K9J8Kz6U0Uj4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032343; c=relaxed/simple;
	bh=ZDhOFrXbnL8IHVi4PbFk8oU76ut6ePD/O8wKa2ZRaPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NBO4ZYlfy1C/eoVRchzCil7r9BVk435pxf+r6y6oNDntldZv9vi8TJuZ7gHA58hiy/+VKKEIH8MLwaNSqXSLGVsgzTgb4/Q9XtrQRJYuWTjFPJphilmmSx2cvJ15u3tARm2IFSKD+R2EVdRHSYdyjm1mqANpE1V1TFCSXR3Aors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI/FKQhB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI/FKQhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0823C1F000E9;
	Thu,  2 Jul 2026 22:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783032337;
	bh=AkuUJ02p9pFNQTC2eOmk+zBCQiCsT0keFkPwXftKyRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mI/FKQhBZWidGJGTRFz/vIv0NXmTaFO8Pc02/M4pvyKlH19wG6bpGqIWrsU0LKyXV
	 /M5TdhcXkJJr3rPUhmtOvyiFSLBRrH/IOAvCs0ziCQAsDfe2bD3Npcw4joUvJhcq+W
	 Yd/alTNBmFFGSV9xO6E3dxSVweV6237ZSJyQaIdL30HGxQK10eEAe8HXNJ/4Fwaylx
	 Lh9bU+SyC5LDQUk2AyTTjv588c4L3vzmswfv077RTJWjHpaA4qQ+IvSMRHN640RSqW
	 R0Vw0xRy/3dHUgMO2VsC7WkYLL8GOwf3WTkh6UrY4PXOrKDYaDea++AbjV4ynC2ow+
	 Eh2JO4AbWNKSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] firmware_loader: expand firmware error codes
 with up-to-date error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Felsch" <m.felsch@pengutronix.de>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260703-v6-10-topic-touchscreen-axiom-v7-1-0d2a550a7ee8@pengutronix.de>
References: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v7-1-0d2a550a7ee8@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:45:36 +0000
Message-Id: <20260702224537.0823C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The selftest script for firmware uploads does not inject and tes=
t the new 'firmware-duplicate' error.
- [Low] Missing ABI documentation for the newly added sysfs error string 'f=
irmware-duplicate'.
--

commit b451d666b20500e69051bac63ead44572b79d708
Author: Marco Felsch <m.felsch@pengutronix.de>

firmware_loader: expand firmware error codes with up-to-date error

This commit adds FW_UPLOAD_ERR_DUPLICATE to allow drivers to inform the
firmware_loader that an update is not required. It also updates the
test_firmware module to support injecting this new error state.

> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/f=
irmware_loader/sysfs_upload.c
> index efc33294212fd..82c4b1fedf4cd 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -28,6 +28,7 @@ static const char * const fw_upload_err_str[] =3D {
>  	[FW_UPLOAD_ERR_RW_ERROR]     =3D "read-write-error",
>  	[FW_UPLOAD_ERR_WEAROUT]	     =3D "flash-wearout",
>  	[FW_UPLOAD_ERR_FW_INVALID]   =3D "firmware-invalid",
> +	[FW_UPLOAD_ERR_DUPLICATE]    =3D "firmware-duplicate",

[Severity: Low]
Since a new error string "firmware-duplicate" is exposed to userspace,
should this also be documented in
Documentation/ABI/testing/sysfs-class-firmware?

It looks like the new string is missing from the allowed error values
documented for the sysfs interface.

>  };
> =20
>  static const char *fw_upload_progress(struct device *dev,

[ ... ]

> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 7459bba65444d..a822d9641eb4c 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -1134,6 +1134,7 @@ static const char * const fw_upload_err_str[] =3D {
>  	[FW_UPLOAD_ERR_RW_ERROR]     =3D "read-write-error",
>  	[FW_UPLOAD_ERR_WEAROUT]	     =3D "flash-wearout",
>  	[FW_UPLOAD_ERR_FW_INVALID]   =3D "firmware-invalid",
> +	[FW_UPLOAD_ERR_DUPLICATE]    =3D "firmware-duplicate",

[Severity: Medium]
Does the test script also need to be updated to exercise this new code path?

While this properly adds injection support to the test module, the hardcoded
errors list in tools/testing/selftests/firmware/fw_upload.sh does not appear
to include "firmware-duplicate", meaning the kselftest won't actually
inject or test this new error type.

>  };
> =20
>  static void upload_err_inject_error(struct test_firmware_upload *tst,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-v6-10-topi=
c-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de?part=3D1
