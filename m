Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB81A9F97
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780800; cv=none; b=lVWoBYEbE0ZWvfi/I5faf5/ykloHryW8XZVp5niXVQA5lhj8z9MjtnkgOMm81KjvftKRpG9/wPp0+0jsh3Pfop14prsHitp3yrrcMZMWhx1OO7pDhy0MJnwncS7qivTMGFVmRYKmsDoRgGje6a0FvhoV+4HAMCl1SuqN6lfZoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780800; c=relaxed/simple;
	bh=9JAXI7u1lrwo8klc1DjKfWygEGMnh+wjZpscFtURSwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YPImfHjP4h+uwc6voiOa77hzn7jl+VpejOUv4+VqXog3lJmZk1aFKr4ESBtLeF8tSRH0wRI3siSPevP2ILxqE3g42AMuCZYUpIhRqBznbugW8R8P/t9B4WjHyFQ+NQVUq5Zz2E/knwb++M6AER2LhSAWMn32OXJ99Y1EuC7UCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np8NoNju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np8NoNju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5B81F000E9;
	Tue, 30 Jun 2026 00:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782780799;
	bh=8+4YvhlvXmI+NG0DTcDUbePVBYZXrTEDNqK08xVTt/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=np8NoNjuR0qIVAbsRM9XBOKqHNVCuVKji1qhsDVpq3rT1AILv6dIYYQHmAd+ydCJp
	 IQG8/DXNn/Yr4fO0iBIsQkht/WQ682p74XVaHLPZwCJzYsyaP42J+SbFEnHhoCFmal
	 jurTRXLc1K2sSJmXhZ0nNNPfRGGIBi0s8mlGBIQXrRtvUNAl0HcW1mk1MQkFLEnzZN
	 CtBMRbFRbgmhOD1kmIjCz47hQc898h52OYa6wm+k2+iEL3OEVz6xrdty9k8R+CfWxJ
	 9SCCjE78U/Y2FYeQK9fSl91sscTqaQU0I9et5QZ34ZRLtvDV0PB4Eo3MRfJQm/bV4i
	 /ECpo5BoiEDCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: corsair-void: Check size of status and firmware
 events before reading them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stuart Hayhurst" <stuart.a.hayhurst@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260630004003.579171-2-stuart.a.hayhurst@gmail.com>
References: <20260630004003.579171-2-stuart.a.hayhurst@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 00:53:18 +0000
Message-Id: <20260630005319.3D5B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Un-ratelimited kernel warning in a high-frequency packet processin=
g path.
- [Medium] Overly strict bounds checking on report sizes incorrectly reject=
s valid, padded reports.
--

commit 867047370d14d44d5c13655e52c433ab8be9dd4a
Author: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

HID: corsair-void: Check size of status and firmware events before reading =
them

This commit adds bounds checking for status and firmware events in the
corsair-void HID driver to prevent out-of-bounds reads. If the size of the
event does not match the expected size, it logs a warning and returns early.

Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-voi=
d.c
> index 5e9a5b8f7f167..fdcc4b8cd2720 100644
> --- a/drivers/hid/hid-corsair-void.c
> +++ b/drivers/hid/hid-corsair-void.c

[ ... ]

> @@ -742,6 +745,11 @@ static int corsair_void_raw_event(struct hid_device =
*hid_dev,
> =20
>  	/* Description of packets are documented at the top of this file */
>  	if (hid_report->id =3D=3D CORSAIR_VOID_STATUS_REPORT_ID) {
> +		if (size !=3D CORSAIR_VOID_STATUS_REPORT_SIZE) {
[Severity: Medium]
Does this overly strict bounds check reject valid, padded reports?

It is common for USB host controllers to pad reports for 32-bit alignment,
or for newer headset firmwares to append data. Checking for an exact match
instead of a minimum length could cause the driver to silently drop these
packets and break headset functionality like battery status.

Would it be safer to check for a minimum length instead?

> +			hid_warn(hid_dev, "unexpected status report of size %d", size);
[Severity: High]
Can a malfunctioning or malicious USB device flood the kernel log here?

Since this warning is un-ratelimited and occurs in the high-frequency packet
processing path of corsair_void_raw_event(), a device continuously sending
incorrectly sized reports could spam dmesg and potentially stall the CPU on
a slow serial console.

Should this use a ratelimited print, such as hid_warn_ratelimited() or
dev_warn_ratelimited()?

> +			return 1;
> +		}
> +
>  		drvdata->mic_up =3D FIELD_GET(CORSAIR_VOID_MIC_MASK, data[2]);
>  		drvdata->connected =3D (data[3] =3D=3D CORSAIR_VOID_WIRELESS_CONNECTED=
) ||
>  				     drvdata->is_wired;
> @@ -750,6 +758,11 @@ static int corsair_void_raw_event(struct hid_device =
*hid_dev,
>  					      FIELD_GET(CORSAIR_VOID_CAPACITY_MASK, data[2]),
>  					      data[3], data[4]);
>  	} else if (hid_report->id =3D=3D CORSAIR_VOID_FIRMWARE_REPORT_ID) {
> +		if (size !=3D CORSAIR_VOID_FIRMWARE_REPORT_SIZE) {
[Severity: Medium]
This has the same strict bounds checking issue as the status report check
above. Does this also need to be converted to a minimum length check?

> +			hid_warn(hid_dev, "unexpected firmware report of size %d", size);
[Severity: High]
This warning is also un-ratelimited. Can this be changed to use a
ratelimited print to prevent log flooding from malformed firmware reports?

> +			return 1;
> +		}
> +
>  		drvdata->fw_receiver_major =3D data[1];
>  		drvdata->fw_receiver_minor =3D data[2];
>  		drvdata->fw_headset_major =3D data[3];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630004003.5791=
71-2-stuart.a.hayhurst@gmail.com?part=3D1
