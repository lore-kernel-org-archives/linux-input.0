Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3754B1AD
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060693; cv=none; b=Hyb8L0kCjVtYBfU+Y6qILE6LBy8eLiooRbkH27WOxZo5BWrHNI3oPql/gNavlrtr7WcS263zbf03PtcClOu8obSZLfzBDszzR74nMMRWq/dPugulklDzsTgLgQvH5ikiQC57xtoedzgy/JbNN2xtDx+/Lue7+chxYXQNj8JX0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060693; c=relaxed/simple;
	bh=/x5eumeJdkz833HEovsX6YVP4I22l9IUDd2p+o+euHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I+N/g4tgKo7jETS7xPes6vHj+5KQehc9/+uAVeLcIJcnoqZ3mjuUbv5mL42mnUeMSRMOEb6EfOcnV3Gu8FkGwM/XWEbgrFKsst1q93+Cdzj+lK01beCp/R+HXJQv4q9bnZbM6FjGulec2aTx0nJwfrxwzi2K26NGaKfQNpy5ebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHvtH9RV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHvtH9RV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EEF1F00893;
	Thu, 10 Sep 2026 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060676;
	bh=5Ex9Y/fSofUWbHLlQlh63dWQWlxwz7mWacvayhJkIk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XHvtH9RVtk9Vruvldn2twR7zGDEKnS4IQxwikB79H6cHS7rWTDWuCZ7DZBQnBJRXL
	 DLlZKq5nlHapDAAgvFETQltQhh1NutK5JdA/qIed8J1iIi16dV4/kE+fvekBo8Ja+D
	 c0uyft6BZ0PhB8XrMGekJLUgAMnCEyTB1jCEMHe4+wFyGm0psuMoATtamImtgnEiwt
	 qI/Y2ViXphu04teyL0uvgKU1ZWrtW3rfJv70LVuZpk+yfRSN3BdtImDuYj131Unsmg
	 lEVL9AH4M2e5EL2llEnwzUDpNxcIKxeCXi8bJUdDEhoLRrK/9YaM4qn26khifGqQ2z
	 orbeC+D8C8QXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260910170254.833871-3-mario.limonciello@amd.com>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:17:55 +0000
Message-Id: <20260910171756.57EEF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect buffer formatting and report ID targeting in `hid_hw_r=
aw_request` fallback for an unnumbered HID report.
--

commit 4526fbce2701e5a40089fba6ae186ded76bc0864
Author: Mario Limonciello <mario.limonciello@amd.com>
Subject: HID: valve-index: Reboot headset on system power transitions

This commit introduces a new HID driver for the Valve Index headset to
reboot it on system power transitions. It sends a specific 64-byte report
to recover the EDID service after a DisplayPort link shutdown.

Link: https://github.com/ValveSoftware/SteamVR-for-Linux/issues/939

> diff --git a/drivers/hid/hid-valve-index.c b/drivers/hid/hid-valve-index.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/hid-valve-index.c
[ ... ]
> +static void valve_index_reboot(struct hid_device *hdev, bool wake)
> +{
> +	u8 *report;
> +	int ret;
> +
> +	if (!valve_index_has_reboot_report(hdev))
> +		return;
> +
> +	/* USB transfer buffers must be DMA-able, so not on the stack. */
> +	report =3D kzalloc(VALVE_INDEX_REPORT_SIZE, GFP_KERNEL);
> +	if (!report)
> +		return;
> +	report[0] =3D VALVE_INDEX_REBOOT_REPORT_ID;

[Severity: Medium]
Is the report buffer sized correctly for an unnumbered report fallback?

The HID core and usbhid transport expect unnumbered report buffers to be
prefixed with a dummy 0x00 byte (so payload size + 1) for control transfers.
Allocating exactly 64 bytes and placing the payload command at index 0 might
break control transfer formatting in usbhid_set_raw_report if the fallback
path below is taken.

[ ... ]
> +	/* Use the same interrupt-out then SET_REPORT fallback as hidraw. */
> +	ret =3D hid_hw_output_report(hdev, report, VALVE_INDEX_REPORT_SIZE);
> +	if (ret =3D=3D -ENOSYS)
> +		ret =3D hid_hw_raw_request(hdev, report[0], report,
> +					 VALVE_INDEX_REPORT_SIZE,
> +					 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);

[Severity: Medium]
Does this properly target the unnumbered report during the fallback?

By passing report[0] (which contains 0x16) as the reportnum argument, the
fallback control transfer will target Output Report ID 0x16 instead of the
required unnumbered report (ID 0). If hid_hw_output_report returns -ENOSYS
and this fallback is taken, the headset might reject the transfer, causing
the reboot command to fail.

> +	if (ret < 0)
> +		hid_warn(hdev, "failed to reboot headset: %d\n", ret);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910170254.8338=
71-1-mario.limonciello@amd.com?part=3D2
