Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23358477E4F
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464606; cv=none; b=Lmob8iDtyOgPSJzBQ6iygd/6mtS2aiZexR9/qV/CGDgnTxG+SDFOHZ311qswJ4NicsBdOjjQnLuKeq/tJRCYB/uxuGL8zHbLM+G3JgdjTn7hXyuM6Fo1V8rb/VR3JBuo0xWG/Q3qnkrcL/r/Zf5w3dlFEmm7q8DkrifqHYJIUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464606; c=relaxed/simple;
	bh=6ipoTFr2XdyI2Bz6wmD0gxUjefChv8tCrhEtLHqoPJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nEvZ6jrHCrVzGZIdUndiFI5qatVRVo8wfAjhzSb2IM7VUu65MEZgI0DnQvhmTLjNqE+KjbUFuS4Ue2NkwJNovET49TqLJtkiy3JhiPSFLSRa8kv3RYtoskpl4i7drJzM3DKn6hf0wPeIKzRBiaymVmWVL8JDUMDSKuudsOA06Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ9yZPiP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ9yZPiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E501F000E9;
	Fri, 22 May 2026 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464604;
	bh=698GcWvqjezdmkaMUHSzyAdCdkJoobcYHSKR/WFLE8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XJ9yZPiPkLA5Q4UY77SX985z8+2csSmi+JB+ECWtiIV4NKQXTxfSVMbtSOunKaLDP
	 SddJ5TSwqG9bCDlM8Kc0ixpRwNHJo4hP3m8jTQzqMjaQdkOiU5s8Yk40K1Wfxggajn
	 YpraYuAcS49XdGvgDRfHIapjv6+/zr+VVTYX2ptdvL/DDAHAyMUWe72r6qlflQwXvH
	 pUHtQdbPyLBa89zrXl/7Jy8FQ0BBb5eYRg3uWa91dPWGMpCuxvncmxbegAQQz+50SL
	 KIXP6d+q26p5DeASp8FHx02ivsL2EGSpAyIx47aexo5zqzUA0DJSEV2tdFz9EDT5J/
	 La0YbGP2+14Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics - add quirk for Daffodil DC253D
 touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashwin Gundarapu" <linuxuser509@zohomail.in>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <19e5047ead1.ce62bdb39017.6022546617731203250@zohomail.in>
References: <19e5047ead1.ce62bdb39017.6022546617731203250@zohomail.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 15:43:24 +0000
Message-Id: <20260522154324.B4E501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The newly added DMI quirk is bypassed if the touchpad initializes =
in SMBus (InterTouch) mode.
- [Medium] Using exact string matching with dmi_match() instead of a dmi_sy=
stem_id table.
- [Low] Spaces are used instead of tabs for indentation.
--

commit 49d6473335088b14bbb30544a1f0fe866d10ddb5
Author: Ashwin Gundarapu <linuxuser509@zohomail.in>
Input: synaptics - add quirk for Daffodil DC253D touchpad

This commit adds a DMI quirk to clear the CLICKPAD capability bit for the
Daffodil DC253D touchpad. It aims to fix an issue where the device is
incorrectly detected as a clickpad, causing the physical right button to be
missing.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2153983

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index 26071128f43a7..4ca85fb4ab70d 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -534,9 +534,16 @@ static int synaptics_invert_y(int y)
>   * Apply quirk(s) if the hardware matches
>   */
>  static void synaptics_apply_quirks(struct psmouse *psmouse,

[Severity: High]
Does this logic get bypassed if the touchpad initializes in SMBus
(InterTouch) mode?

It looks like synaptics_apply_quirks() is only called from the PS/2 fallback
initialization path (synaptics_init_ps2()). During device initialization in
synaptics_init(), if InterTouch (SMBus) is supported, the setup is routed to
synaptics_setup_intertouch().

This SMBus path directly evaluates SYN_CAP_CLICKPAD(info->ext_cap_0c) to
configure the .buttonpad property for the RMI4 driver without ever running
synaptics_apply_quirks(). This would cause the intended fix to fail on mode=
rn
systems using InterTouch.

> -				   struct synaptics_device_info *info)
> +                                   struct synaptics_device_info *info)
>  {
> -	int i;
> +        int i;

[Severity: Low]
This isn't a bug, but it looks like spaces were used for indentation here a=
nd
in the modified function arguments instead of tabs. The Linux kernel coding
style mandates the use of 8-character tabs for indentation.

> +
> +        /* Daffodil DC253D has a physical right button */
> +        if (dmi_match(DMI_SYS_VENDOR, "Daffodil Computers Ltd.") &&
> +            dmi_match(DMI_PRODUCT_NAME, "DC253D")) {

[Severity: Medium]
Will this exact string matching fail if the DMI strings contain trailing
whitespace or padding?

The dmi_match() function uses exact string matching. DMI strings from OEM B=
IOS
vendors frequently include trailing whitespace or padding, which would cause
this match to fail and the quirk to be silently ignored.

The standard and more robust approach used throughout the kernel and within
synaptics.c is to use dmi_check_system() with a struct dmi_system_id table.
This utilizes DMI_MATCH() to perform substring matching, safely ignoring any
trailing spaces.

> +                info->ext_cap_0c &=3D ~BIT(20);  /* Clear CLICKPAD bit */
> +                psmouse_info(psmouse, "Force right button on Daffodil DC=
253D\n");
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/19e5047ead1.ce62bdb=
39017.6022546617731203250@zohomail.in?part=3D1
