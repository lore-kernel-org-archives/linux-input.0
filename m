Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379F331ED2
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575781; cv=none; b=hVAdnrpRgQrUvln+sCBdnXG+At0poHGBWpKJu95AfM+KFR0P+KalFjEscBu/ofsG9EvFfpurdrJFxc524Qc7hU+vwgMNonn1nxDu4qw+esl4unVfwFq1V4YKaDpv/ajiyANELdkDH6q3ug0SEr/fscTJ6qAg+bAaU+J9kHAs5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575781; c=relaxed/simple;
	bh=g3xoZBf3v20/eNT2CZqcAwAa4KyPBbt3duH1gedFFTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S1+tM8KrILq+4U73L4Odm0sWzFML39LTVfbUhresHBanVjfesRK+LckA0rAP/IzlWf3xxz5u9qTbF2AcqqBijvyyG1AYRN4khYElaisvLsNka/igqL9JF3ltW7AI/h4XZixyF+Ka3rrn4ojzn6OOGadBk1A1EtByybfp6wU8pNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSvx8Weq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSvx8Weq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AC91F00AC4;
	Sat,  1 Aug 2026 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785575780;
	bh=Le5N5ZmXILHlFvdaJLueUQm8OKBy7yVzsQ77FHweqd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BSvx8WeqvYk4zqLvp53z6Af0nAHYS6d+9RHZ9EyGNbOrQfMC4MaufWXqtE44+vFCX
	 5ke3PvHHCIfa+w436thcW7QfHuv4teOJ9+cVuQgTtoS7Cecr4rSLcVLCl3O23OGdrl
	 tnSDGKIRArYp0rjsqYYEnmEGOLd4zAsO9m1p7ycJT65NIjgSLLYqbgPtv8S0vJ/O/d
	 6YTLH1qC8J3V9waZZN/dMBrk2aDVis9fRM5eWuYeRBmVCYNHm8zEyubtfztaltEKd2
	 C7o8CXonuCSffbK7a1N08u3R63NDl25LTRTx0unQGNmKvfC2XuBs69l8PgAqAVpnud
	 NZ3hPz6d7mOsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: nintendo: fix rumble starved by the input report
 cadence gate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandre Derumier" <aderumier@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260801090059.1349535-1-aderumier@gmail.com>
References: <20260801090059.1349535-1-aderumier@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 09:16:19 +0000
Message-Id: <20260801091619.92AC91F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature registration of input device before capabilities are ful=
ly configured.
--

--- Patch [1]: [PATCH] HID: nintendo: fix rumble starved by the input repor=
t cadence gate ---
commit b0ec0e9322fbf2a41d6005445efd2343b058fb43
Author: Alexandre Derumier <aderumier@gmail.com>

    HID: nintendo: fix rumble starved by the input report cadence gate

    Rumble on third-party controllers speaking the Switch protocol is weak
    and intermittent over bluetooth, and absent on some units. This commit
    adds a fallback to the legacy subcommand throttle when the controller
    fails to meet the strict cadence requirements.

> [ ... ]

This is a pre-existing issue, but looking at joycon_input_create() in
drivers/hid/hid-nintendo.c:

drivers/hid/hid-nintendo.c:joycon_input_create() {
...
	ret =3D input_register_device(ctlr->input);
	if (ret)
		return ret;

	if (joycon_type_is_right_joycon(ctlr)) {
		joycon_config_right_stick(ctlr->input);
		joycon_config_buttons(ctlr->input, right_joycon_button_mappings);
...
}

[Severity: High]
Does this code register the input device before its capabilities (such as
buttons, axes, and force-feedback) are fully configured?

Registering before configuration completes can lead to undersized event
buffers and incorrect udev or Wayland classification since the capabilities
are checked at registration time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801090059.1349=
535-1-aderumier@gmail.com?part=3D1
