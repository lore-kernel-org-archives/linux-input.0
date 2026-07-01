Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609C3B47C6
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889953; cv=none; b=DWLG3IY/8m6zNqRHC+2k2sZLhHb7QQR52ZAuBBw3A3JK1upl9EuTuXgQvVlH52iBgEBiLn67zlHWO9rMVzhdOux84MBy8xssLqPxpAa3F2KAZX5LSwABV0VHO3PgOaFwPOvGdiunfXIl48VZfaZo7DRp5uCk02SC7mLJjQAB2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889953; c=relaxed/simple;
	bh=Or0Qn0IEXtDSEBUe+v/ugP894jhlGoh6LC5RKh/3vrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LwXrbitSh4xDdAsJ4vq8yuta7zSSrzmL2SXYo/aw9J0/BSDAzV0W3ckW8xRteuNF+8iF6FlCzOMYCtGT6dVJnHEHTnUcSW5Ukvo2/L+3O9AScFhPHzzhcmZPgpJBY/MzjTheMMTXeszI4osUK0tBFHMLfzzrkF0Xm5EAamvx9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcLFYk7o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcLFYk7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7641F000E9;
	Wed,  1 Jul 2026 07:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782889950;
	bh=xEcX0S6VShpBL+rS16+LU99VoeqHqxciSTQfPOpl69M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jcLFYk7oQgDaUBHLgQ7Y5DGOMVKUxSHUX1WotmE+yL5JMJ43JpuPRFirzHK7hZXQO
	 oeeVOcxBwGMWMWG1KABKKIB7F5bbN719h2/QVEigzjVpSklUrig8+ZMsiTWRrwAQAp
	 ZvCXC4v5HRjCQ42Uiu4wHwqWDNYS3u0ukgVOwCnSjFQ+1h3iWU378+BHvAaJSnt51j
	 AnhJnZMb8emMSyMjyseDdn65R78lLtZtGgzLvj1gyLbaKzO7K8vNFxReHVcjYHRbSo
	 8xJAQdr7VnU2pKPUQB/hVBMZUPQt/QRp3SXBd2uiwDpFYgh1OKruuzbrsH9oYNc/cK
	 tqKCpixgZzEWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] HID: nintendo: Add unified report format support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260701065606.4169999-4-vi@endrift.com>
References: <20260701065606.4169999-1-vi@endrift.com>
 <20260701065606.4169999-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 07:12:30 +0000
Message-Id: <20260701071230.6B7641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] LED class devices registered with devm_led_classdev_register()=
 outlive their containing switch2_controller structure, leading to a UAF if=
 accessed via sysfs after the device is unplugged.
--

commit 84beb320490de870df51e881a9a77c861e3838ca
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add unified report format support

This adds support for the "unified" report format that all controllers also
support, which has overlapping fields for like buttons and axes between
them.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 96463e1586bbd..b406e6cfd221f 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but can this lead to a use-after-free when the
device is unplugged?

Looking at switch2_init_input(), LEDs are registered with a devm action tie=
d to
input->dev:

drivers/hid/hid-nintendo.c:switch2_init_input() {
    ...
    ret =3D devm_led_classdev_register(&input->dev, led);
    ...
}

This means their teardown action is delayed until the input device's kobjec=
t is
released.

However, the ns2 structure containing the leds array is freed manually in
switch2_kref_put() upon device removal:

drivers/hid/hid-nintendo.c:switch2_kref_put() {
    ...
    kfree(ns2);
    ...
}

Because the LED sysfs device is a child of input->dev, it prevents input->d=
ev
from being released until it is unregistered. This creates a circular depen=
dency
where the devm cleanup is never triggered.

If a process keeps the LED sysfs file open, input->dev remains alive, but n=
s2
is freed. Does this leave the LED sysfs endpoints pointing to freed memory,
potentially executing function pointers from the freed ns2 structure when
writing to the LED sysfs brightness file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701065606.4169=
999-1-vi@endrift.com?part=3D3
