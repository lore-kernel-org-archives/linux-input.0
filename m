Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DBC3B27C3
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532668; cv=none; b=TqJYZ6dgO1yosQ5l5alhSTYwPSclZ4+M/GDiOCUeJbJLpje9l7jB/RBpglNuTBkM5F1Da+SVr+Nl3k/dHsz48CUsgrevonFSUYjoSrETi1V3RAn8SqF+gSscRfaHJz+Bnk7agOgBOL40LKd3fzIn1QHNm4oB9b3nlKNtz6FYlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532668; c=relaxed/simple;
	bh=arUP1fJPGfwt5TO8jvEcNY7jV2fxP6JUu8bX9760ziQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SxxuHyplq/Z1QZaasw79BT+nkx33mCVKu8794kqDU6v3PiEhFzMT/bCxPenrEYshCprT4imkAd6Dentv+8yWiWdU6TX3P72AUPwrAb9ahPRdU6xqjhYkN9Ewx7N77Zvw+mQbdGAw7SFO2RW8TPzs9rl7JdYhtenO4xU0DZkoM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvOvhn1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvOvhn1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2030C2BCB0;
	Mon, 11 May 2026 20:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778532668;
	bh=arUP1fJPGfwt5TO8jvEcNY7jV2fxP6JUu8bX9760ziQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QvOvhn1lgjUTZkKiqHuehZofUJ7YfU8GgheVvobpL5aKEA12aWs9nfgpVWHiKCUr4
	 SiWd0mjeHwhgp1/HZANFJ5sefluIUIYPStnpbRAbvoIVM6PfUvQauWwl+fMVR4zo+g
	 RzxuknUl4yKse8/OsN3r+2U2AoMUhdtDEmP6S87lLu9BvTE+rTOK9Ui2Khzw4WiuCk
	 CiR9oJHDXb5ud2N6/zPajLB9sC6VZQJgVSgNt9Xf/+8FOvhGwbe8Catl8htPQN0sfY
	 8pADqJNoD0nWwttafb47DJuHW6E6f36FI4jMI0UkNfFBPPjRMjCdQKZVlU5ck0soeK
	 Ex9A3rXbQZB2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] HID: hid-msi-claw: Add M-key mapping attributes
Reply-To: sashiko@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260510043510.442807-3-derekjohn.clark@gmail.com>
References: <20260510043510.442807-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 20:51:07 +0000
Message-Id: <20260511205107.C2030C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race on `drvdata->profile_pending` and lack of transaction at=
omicity during concurrent sysfs accesses.
--

commit b9bc6d29326e3dd3ed065aca7059668a1b674bc8
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi-claw: Add M-key mapping attributes

Adds sysfs attributes to remap the M1 and M2 rear buttons to up to 5 events
(gamepad, keyboard, or mouse) when in macro mode.

> diff --git a/drivers/hid/hid-msi-claw.c b/drivers/hid/hid-msi-claw.c
> index 7a3cd940ec49e..60694d075d56f 100644
> --- a/drivers/hid/hid-msi-claw.c
> +++ b/drivers/hid/hid-msi-claw.c
[ ... ]
> +static int claw_buttons_store(struct device *dev, const char *buf, u8 mk=
ey_idx)
> +{
[ ... ]
> +set_buttons:
> +	ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA, da=
ta, len, 8);
> +	if (ret < 0)
> +		goto err_free;
> +
> +	ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NULL, 0, =
0);

Is it possible for concurrent writers to interleave these commands?

Looking at mcu_property_out(), it takes the cfg_mutex internally, but there
is no lock held across both calls here. If a second writer executes its
WRITE_PROFILE_DATA before the first writer executes SYNC_TO_ROM, could the =
MCU
be left in an inconsistent state?

[ ... ]
> +static int claw_buttons_show(struct device *dev, char *buf, enum claw_ke=
y_index m_key)
> +{
[ ... ]
> +	codes =3D (m_key =3D=3D CLAW_KEY_M1) ? drvdata->m1_codes : drvdata->m2_=
codes;
> +	drvdata->profile_pending =3D (m_key =3D=3D CLAW_KEY_M1) ? CLAW_M1_PENDI=
NG : CLAW_M2_PENDING;
> +
> +	ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data, le=
n, 8);

Can concurrent reads of button_m1 and button_m2 race and corrupt the
profile_pending state?

If Thread A and Thread B access the sysfs attributes simultaneously,
profile_pending is updated locklessly here before mcu_property_out() takes
the cfg_mutex.

Could Thread B overwrite profile_pending to CLAW_M2_PENDING before Thread A=
's
command executes? If so, when the hardware replies to Thread A's M1 command,
claw_profile_event() might route Thread A's data into Thread B's m2_codes
buffer and clear the state to CLAW_NO_PENDING.

This would cause Thread B's subsequent reply to be dropped and trigger the
"Got profile event without changes pending" warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510043510.4428=
07-1-derekjohn.clark@gmail.com?part=3D2
