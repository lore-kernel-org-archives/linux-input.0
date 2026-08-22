Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F72E03EA
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366309; cv=none; b=KmmPYis7T4sFb1gvnLXnlzrha78xCgxtTBQczznknCUyUMvm8KE/wLRSm1ROrnZhX1EGV68V4tq3KJF4HE3BU+5JFisdkX1SlTHLPjkS8/pSnG9TwrSPavatYlmJBMDaNRftSI3BgULCO02Kb4tAeAAB7wOpSCZ9NQHBBOznHxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366309; c=relaxed/simple;
	bh=t6yf/RG/0QYXFNZ2TH3ECvHrff4MwNpWb6wkaE+17Do=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XUCatuoBF/eXH2+imfF0J7MNDnG8ywOFx6e1dKy2KQs9hz4nmhSSUF/rxBFsuPzXUTaanHIkvHGXoIP8jnAJN5ng8bwJry6tAF9OAgL2a5Olen6Mkebfa/uPxUYztTDDjQWj8A90/sYHIiyfpCRGfai/dbnpKySDszBao7X2gzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EokJ5CMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EokJ5CMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DABF1F000E9;
	Sat, 22 Aug 2026 02:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787366308;
	bh=RRWDrpi6HKgihyzD8+7U9skhbmcqrp+0brt1kfw7AOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EokJ5CMpoLbUD/CYCaH0gdpV+OVRQeiEE+FH/IpFdLlcTQoGXSh5tktoFBwkmWI6v
	 oeB697LHVDQN3WVnXpe3lf0ztnaF6iqLB0uSrzrd84CCN6E80AuJWoZuZCW07ixFlc
	 Z36AvB3pjxPsCnG5oaElQq8+fTOimvA6MzzNa2d4AttKLe390dD5/FbYnN0mwkXxQ0
	 +j+lek2XgFbLILs01K5htecbNRy9qYPDo/YqzVFkg+HSDmjqutJzdS73R1ysJfbG4e
	 L6tDK+ceotoVzj65yMxGI2Wdhxa9PycQmqRoWPOO5fUCWbgCJIoY1JVlD1tJtLRFg6
	 v6Ef0CgbxA2PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/12] Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822021140.1149546-11-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-11-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:38:27 +0000
Message-Id: <20260822023828.3DABF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `hid-universal-pidff.c` driver contains a hardcoded loop bou=
nd (`ABS_BRAKE`) for racing axis initialization, leaving the newly added ra=
cing axes without correct fuzz and deadzone configuration.
--

--- Patch [10]: [PATCH v4 10/12] Input: Add ABS_CLUTCH, HANDBRAKE, and SHIF=
TER ---
commit 518c533c53885e9a0bf15581d9e84560c1f27740
Author: Vicki Pfau <vi@endrift.com>

Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER

This commit introduces new absolute axes (ABS_CLUTCH, ABS_HANDBRAKE, and
ABS_SHIFTER) for racing game controllers. It updates the relevant definitio=
ns
in input-event-codes.h and the debug string representations in the HID
subsystem.

[ ... ]

> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/=
input-event-codes.h
> index 3528168f7c6d7..5c881ed441771 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -879,6 +879,9 @@
>  #define ABS_WHEEL		0x08
>  #define ABS_GAS			0x09
>  #define ABS_BRAKE		0x0a
> +#define ABS_CLUTCH		0x0b
> +#define ABS_HANDBRAKE		0x0c
> +#define ABS_SHIFTER		0x0d

[Severity: Medium]
Will these newly added axes be missing fuzz and deadzone configuration in
some drivers?

Looking at universal_pidff_input_configured() in
drivers/hid/hid-universal-pidff.c, there is a hardcoded loop bound that
explicitly terminates at ABS_BRAKE:

	/* Decrease fuzz and deadzone on available axes */
	for (axis =3D ABS_X; axis <=3D ABS_BRAKE; axis++) {

Does this loop need to be updated to include ABS_CLUTCH, ABS_HANDBRAKE,
and ABS_SHIFTER, since they logically belong in this racing axes group
and might otherwise incorrectly retain default settings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D10
