Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C765471CFA
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059758; cv=none; b=T66ZshEpm+dTyVaA1mAku9/UTFTiWpl4L1GbKJ/ywjA+Zfyn1/dNdUQ3VtGZdWLL/qnwoOpwdwIpABqtM4WGUp0J0OzV26qsfYLAoBysfWCNpiT9EQh+QE3x6Z7OV7g2rhjhEkFFilUewl/cn23Aa3Y9M3+E6zUjUJIfTV65EoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059758; c=relaxed/simple;
	bh=eJWR+6rmNqn6FOBOVCe2MdyZbex454SlW5N30jLsgdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bHlyX4XnKDkY6wxmwuUCp0d6QkkyZbmchY/e4WoxIIzLcZUZaOJO3A6YeMxq4SMQgb6cXVJHU1TozIjGzzK4vIZSdpro5qWdghCKZfroXjc2ikkdIJvQFY0v2q6UzLl4777rmovzAFte+L3/bhNPxTqoCBAYueQ/LvSFm8BIVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb2f8YPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb2f8YPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35EE1F000E9;
	Tue, 18 Aug 2026 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787059756;
	bh=6DZID3jNLzisVbvnla5EMZeRvZyiM9NuEFC0VKt9zh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nb2f8YPCeTlYQkZlUlmBd6r5+TcyOmIlthR2OFSRF5vY+KQR7EZpC1/hIvBXLH4+W
	 eYLus18pdlQoRduPHARhJsr89uR15ShNZVI9w3vvoLhxKgKn4afFcJVDXSUq13+zp2
	 d3EVFmleTA4MqllXgArBDGknlgi1pWt0rSUrWXrhfcMJJLIyCS852yMdGEtBXPPmEg
	 xe1kA6dwzpF2xXFNC+diHutVZBZ5JxL1QpAAEnca3NmAFTa8NhMNaeuPSGKaxWgDdN
	 vrWSSDFKSmSc7gQFmqWYO0jK3GBgCOC+eptiyga9bGimRqjL10+IvdEiAlinsuHsRM
	 ESRnUsPs2Qrjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] HID: corsair-void: Fix firmware event packet
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stuart Hayhurst" <stuart.a.hayhurst@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260818130053.45064-2-stuart.a.hayhurst@gmail.com>
References: <20260818130053.45064-2-stuart.a.hayhurst@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:29:16 +0000
Message-Id: <20260818132916.B35EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing report size validation in `corsair_void_raw_event` allow=
s out-of-bounds read of the `data` array, leading to processing of uninitia=
lized or stale data.
--

--- Patch [1]: [PATCH RESEND] HID: corsair-void: Fix firmware event packet =
description ---
commit 80e19492934a593a71b8da5c14d031065a2f1255
Author: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

HID: corsair-void: Fix firmware event packet description

This commit updates the firmware event packet description in the corsair-vo=
id
driver. It corrects the size to 5 bytes to account for the report ID and
updates the byte indices for the firmware version fields.

> diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-voi=
d.c
> index 5e9a5b8f7f167..ce92e3a9c0580 100644
> --- a/drivers/hid/hid-corsair-void.c
> +++ b/drivers/hid/hid-corsair-void.c

[ ... ]

> - * 3: Headset firmware minor version
> + * 4: Headset firmware minor version
>   *  Minor version of the headset's firmware
>   */
>  /* ---------------------------------------------------------------------=
----- */

[Severity: Medium]
This is a pre-existing issue, but since the documentation correctly notes t=
he
receiver responds with 5 bytes, does the driver need to validate this size
before parsing the packet?

In drivers/hid/hid-corsair-void.c:corsair_void_raw_event(), the data array =
is
accessed up to index 4 without first validating the report size:

	} else if (hid_report->id =3D=3D CORSAIR_VOID_FIRMWARE_REPORT_ID) {
		drvdata->fw_receiver_major =3D data[1];
		drvdata->fw_receiver_minor =3D data[2];
		drvdata->fw_headset_major =3D data[3];
		drvdata->fw_headset_minor =3D data[4];
	}

If an untrusted or misbehaving USB device sends a short report where the si=
ze
is less than 5, could this lead to an out-of-bounds read and cause the driv=
er
to process uninitialized or stale data from the HID core's input buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818130053.4506=
4-2-stuart.a.hayhurst@gmail.com?part=3D1
