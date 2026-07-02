Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B83D1A98;
	Thu,  2 Jul 2026 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031988; cv=none; b=ZtN1F2rb7qtsjwsOiJ22Ol6KjAW3PQiSUHfvZVMpwaqR9EEcnkbz/ArroKA5a9IH+wQHPS2eIG8ET7lNiT5A+NuQzrkEEBw7nZ4UGslwiHoZkhZyY6M7FQbVEhjdBcz6JFXhZk0LvkAEXtFYgRdsJGWCO+MfaXsKI7LU7o3lPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031988; c=relaxed/simple;
	bh=NdZaO696DkukDhX4+tjxMVKmN9Oqn57Y3wITxefbmcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TauEUQ9pucBXsTqzZuzwIPM6YAIG336GsdYldCUsJhVf6gbGeLQOPrpLQ4NQs1aj03JSIcRA/tthSeLs6txqDg15zJB2opSENTtOX+3MjmeioqYpEQC4CsYOFogshZpNVTcm/F54nzXLWG9o6lY2sD/pTY7Zl9w2t+SFlqMSbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGsCOYBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGsCOYBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7D01F000E9;
	Thu,  2 Jul 2026 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783031983;
	bh=Ap9DrUTnqXlN5zm9ulmcbFUjVW/LtzCwBm0PFq/FCdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oGsCOYBzAYaZDtZMwF8/n0lB8Tsn7BfRLAm1WpRuXsjMI8SH5pAH5jrqjx+cLURgd
	 GGf7Xa3fCjybsKManjUYT7RVUYKyRlMQv1PDfkewAKcqNlUiEaL6eNrTvqtXQNF5fC
	 WFM/iydpwKOR8N40JqTdfS8QKg3TwECnYKV4bVaVOvDAPTOrdaMEfjEnY97ccne3Oa
	 9Hn1K/0DRlVTj+R50B8IuUZk7+E0ctWu9FNHn7XXffBQf39pD/ZEpMA6+Y+URgs3S9
	 aJ0N2XIn5w52e8L8U92f03OGoHGaHhIceAdc66oEnPuXhS0H/CUCBn3BUNrh2Hejas
	 UW52zSslnwvlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] firmware_loader: expand firmware error codes
 with up-to-date error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Felsch" <m.felsch@pengutronix.de>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260703-v6-10-topic-touchscreen-axiom-v6-1-1aa50ba3bc5a@pengutronix.de>
References: <20260703-v6-10-topic-touchscreen-axiom-v6-0-1aa50ba3bc5a@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v6-1-1aa50ba3bc5a@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:39:42 +0000
Message-Id: <20260702223943.6B7D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added "firmware-duplicate" sysfs error string is omitted =
from the sysfs ABI documentation and the corresponding selftest script.
--

commit 59f39aaf73939b5dbe553a0c6fe3c5d3c9ce3d78
Author: Marco Felsch <m.felsch@pengutronix.de>

firmware_loader: expand firmware error codes with up-to-date error

This commit adds FW_UPLOAD_ERR_DUPLICATE to allow drivers to signal
that a firmware update is not required. It also updates the error
strings in the core sysfs interface and the test firmware module.

> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/f=
irmware_loader/sysfs_upload.c
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -28,6 +28,7 @@ static const char * const fw_upload_err_str[] =3D {
>  	[FW_UPLOAD_ERR_RW_ERROR]     =3D "read-write-error",
>  	[FW_UPLOAD_ERR_WEAROUT]	     =3D "flash-wearout",
>  	[FW_UPLOAD_ERR_FW_INVALID]   =3D "firmware-invalid",
> +	[FW_UPLOAD_ERR_DUPLICATE]    =3D "firmware-duplicate",

[Severity: Low]
Since firmware-duplicate is now exposed to userspace, should it also
be documented in Documentation/ABI/testing/sysfs-class-firmware? The
existing documentation lists the other expected error strings but is
missing this one.

Additionally, does this require an update to the selftests? Looking at
tools/testing/selftests/firmware/fw_upload.sh, the errors list is
hardcoded:

errors=3D"hw-error
	timeout
	device-busy
	invalid-file-size
	read-write-error
	flash-wearout"

Without adding firmware-duplicate to this list, the new error injection
capability added to lib/test_firmware.c might not be exercised by the
test suite.

>  };
> =20
>  static const char *fw_upload_progress(struct device *dev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-v6-10-topi=
c-touchscreen-axiom-v6-0-1aa50ba3bc5a@pengutronix.de?part=3D1
