Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAB1F91D6;
	Tue, 30 Jun 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827002; cv=none; b=naw/gCfuQi5ZKZnO94GEbYANr0GIWI7MLV2kF/W+A8xHPeJi9LtCareYVN2y5lFmEl0WwDJlcQBcM54gWRKQelDfUkP6+4mVl1k5U+IiUpw+beifVb4qm76vBxKh7Bg++hetc2OukD+YdlPjlEHcDLGT6WUXkhJwVrR0dPV/Vr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827002; c=relaxed/simple;
	bh=4xAGmXJqZM3io21y1PJtvb9xzmA+OJsDD68FA7vbQu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jRXLm5VUPlzimxe0EQnuAEJEDaUouCQ4JBbD2YetZjW3dRYd2sDZZM3PmJarmGy4/k4c/GTL3SKdj5J5eZf4p3CaUA6JRTMqUGdUG7csE+M4c9lq5J97zcF8hKArTDuEnzyyfdZtNeVycPR56TWxp6jbw2hx86GRrdxWEHeC0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj8y4IkE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj8y4IkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1271F000E9;
	Tue, 30 Jun 2026 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827001;
	bh=hxvdIQKRJ+fZFg/VkVSimqsytVMc7FfZZeStsjMdW9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hj8y4IkEqjsE+EMF3nXeSRDdbt6PhCMSMHAYM/3gmqYSRMjs4VrrbykJ4GY1VoJoA
	 NRP6JFQ6aJm6DTau5RkEvJncSfPnwf7fLTnwI3rlQwM/NVAA2e94QlFSX/GzUaVWqZ
	 MLL/Wlt31jnvyS+MkRl3+bUsaN3H2S/rziKpaboPGUXk2gYSNqCSdHTTi+aXRbU65z
	 ERMmfoVkVhLuctNpxjXTEMDJggz+++IHege+uqyfkuQaIOhZUf1zMhbnf59U6/VPFA
	 xc9A4U5MjRRply29ivdw2I3LCla4iiPccPa6rmyAsiHaX8YAaUcfXbtHW9UVxDE5Uk
	 K2/zY3BtaknSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] HID: apple: Add support for DockChannel HID
 keyboards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves via B4 Relay" <devnull+michael.reeves077.gmail.com@kernel.org>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-7-506d936a1707@gmail.com>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-7-506d936a1707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:43:19 +0000
Message-Id: <20260630134320.9A1271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The custom `apple_match` callback fails to check for the `HID_QU=
IRK_IGNORE_SPECIAL_DRIVER` quirk, bypassing system or BPF-driven overrides =
that force the generic HID driver.
--

commit 28e52ea5c163ab3459cd9d8d4a75ee76a37b6489
Author: Michael Reeves <michael.reeves077@gmail.com>

HID: apple: Add support for DockChannel HID keyboards
   =20
This commit registers DockChannel keyboards as host-bus Apple HID devices.
It updates hid-apple to match these devices, applies the Magic Keyboard
function-key table, and fixes their oversized report-size descriptors before
parsing.

> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index bf7dd0fbf2496..47c6ec09d5fae 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c

[ ... ]

> @@ -1003,6 +1035,17 @@ static void apple_remove(struct hid_device *hdev)
>  	hid_hw_stop(hdev);
>  }
> =20
> +static bool apple_match(struct hid_device *hdev, bool ignore_special_dri=
ver)
> +{
> +	if (ignore_special_driver)
> +		return false;
> +

[Severity: Medium]
Does this custom match function bypass the HID_QUIRK_IGNORE_SPECIAL_DRIVER
quirk?

It checks the ignore_special_driver parameter, but it looks like it omits
checking if hdev->quirks has the HID_QUIRK_IGNORE_SPECIAL_DRIVER bit set.
By unconditionally returning true for standard Apple devices further down,
this might allow hid-apple to bind even when a user or BPF program explicit=
ly
requested to ignore special drivers and use hid-generic instead.

Should this also check for (hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER)
before allowing the match?

> +	if (hdev->group =3D=3D HID_GROUP_APPLE_DOCKCHANNEL)
> +		return apple_is_dockchannel_keyboard(hdev);
> +
> +	return true;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-apple-mtp-=
keyboard-final-v1-0-506d936a1707@gmail.com?part=3D7
