Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3872DB78C
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888226; cv=none; b=SZ1J4JRgTJyp+g5Bhkl5ePCYjOgjR/udQW+KBjr5qzVvWY3XKJ5+NIfrVeB480wyKlh4xbg2tzXst2gSrxfkR81uPJJi4hzOJHUQN1sG03yTIa+6Bvl1f1SZPwvZR3KrTOjGEnu7WZw/+7TXPtwS4lxibCVv/PIHjxlsckpv+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888226; c=relaxed/simple;
	bh=F2itCEhYpmLFQb7edGPeVqfafbVhUVvTViR3SrbMvdo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gxhkz69xxQUX2fI+fR5X4Z5a8EmksfgwtzljvK3Y7gXLr4S4eiBppBdvK2wX4EG6XmKH4Kqtz2tPdQQJ39YgsWbdg6HzbHO6WvhQ/VFsOwOfrcmQTx7pVZWj6vR0Li11VTMMdAh2MfzZ48pSQHjH4uM4NnN51AP2osjhpIfkJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmEzLkZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmEzLkZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920EE1F000E9;
	Wed,  1 Jul 2026 06:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782888224;
	bh=6LmAQbUDhqgKcTNQ30JsL7fhNFlaM7ebg5aZHFScJ3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cmEzLkZ4/K2wVgJZwTIxIrPM6rtDTJE8afauGzRURA4oNKFPMuZYsxe+pFzboiQC0
	 gUUM5Ed6Zn6baK02zfZHAGCFVvv2GTUQT0YZPM4ix0OsO2PUGnT+6Y4vbvUO96JA/J
	 L4i1jW2R/c+OCWUfPvhKWkE66HpZjwyuySGaBymsPDMWtIwvZPYPsuN2zgWLzSq8Dj
	 P4JiAJXVwps16JiC0AglNA0P8/S/UFdFc2uKxtpp2Kqt/Lm8T18uEBg0+l9fZ9PStE
	 Zvm0URIKmYGxsT6Tmxd3hVDIpxj54T21c5LJeVsHD+ehjhAkVFEjXxFk6za2SPdMuO
	 5ECwjdOGEZEyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
Reply-To: sashiko-reviews@lists.linux.dev
To: DevExalt <exalt.dev.team@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260701063022.29547-1-exalt.dev.team@gmail.com>
References: <20260625080807.74157-1-exalt.dev.team@gmail.com>
 <20260701063022.29547-1-exalt.dev.team@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:43:43 +0000
Message-Id: <20260701064344.920EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] FAP command macros incorrectly embed a hardcoded Client ID, viol=
ating the subsystem's software ID convention.
--

commit 18d7a2d2e6622c1a347a9e072d766882d23cb46c
Author: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>

HID: logitech-hidpp: Add support for HID++ Multi-Platform feature (0x4531)

Adds support in the Logitech HID++ driver for the HID++ Multi-Platform
feature (0x4531), introducing a per-device sysfs attribute "platform" to
allow selecting a target operating system platform.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 90b0184df777f..b3b846c8bdaf8 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
[ ... ]
> @@ -4423,6 +4426,398 @@ static bool hidpp_application_equals(struct hid_d=
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
[ ... ]
> +#define HIDPP_MULTIPLATFORM_FEAT_ID			0x4531
> +#define HIDPP_MULTIPLATFORM_GET_FEATURE_INFO		0x0F
> +#define HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR	0x1F
> +#define HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM	0x3F

[Severity: Medium]
Do these FAP command constants incorrectly have the Client ID 0xF baked into
the lower nibble? By subsystem design, they should specify only the function
index (e.g., 0x00, 0x10, 0x30).

Because these constants hardcode 0xF, when hidpp_send_fap_command_sync() is
called to format the message:

drivers/hid/hid-logitech-hidpp.c:hidpp_send_fap_command_sync() {
    ...
    message->fap.funcindex_clientid =3D funcindex_clientid | LINUX_KERNEL_S=
W_ID;
    ...
}

The bitwise OR with LINUX_KERNEL_SW_ID (which is 1) will result in 0xF,
bypassing the driver's intentional Linux Kernel Software ID allocation.

Could this incorrect Client ID cause the device to misattribute state chang=
es
or fail to route events back to the kernel properly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701063022.2954=
7-1-exalt.dev.team@gmail.com?part=3D1
