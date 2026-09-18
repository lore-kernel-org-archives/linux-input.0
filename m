Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB447ACCE;
	Fri, 18 Sep 2026 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730287; cv=none; b=o+rnBvi1KZkhZlJrqCKv79GrJmOhaXXZ9Rgrfq86x2nBZ29JMg3ruJpcrVKRAXpEVnK5Z9ue0HAmdB1dqzU5UzBPhrWLwuBhJHjzy9QQ/n0xv44G9CGc2beNjM/WvUXPgp6/ew3S/eJEvI9LrpUlKkBcF3t87gYD7or8obDEspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730287; c=relaxed/simple;
	bh=pvu7ii/S8rNl3eZdVXy4voI+wuDoxb96k/L0MU4I/3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M8KAUS7W7n9T6wxttXWBnGT3jp5pdi3JbCEeIgpQY7eEtJAiblmGWGwUyHI8Y4r9gO5HWawEBvfxHmclBH+cRq5wsRmOUtK8TpjHtDuVxhzgafjaXQyvHP7s8Tl6Ln/CeYSzI06HVuxowsgONXcgLF3jrEZKrmshHeA7ohIYEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW7mnkip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW7mnkip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D861F000FF;
	Fri, 18 Sep 2026 11:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789730285;
	bh=ytW7Sp2ZwaSswRg7hJxe2r8E2AMia+pK/6Z7ScuoaI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MW7mnkipSOtEImfs7g7mH1tG1PF1xJdsKTotsKPCfsL7LFS+rCmn4z9GGcO/EufD7
	 B0/m5noXjY161O2t7d1TjbC7UM8BaDiognNHaWNiUvEjgU46t0NkDMzxKlcfQz+J2w
	 9r4UOyF3/KveDt0DNgnxnCaIMzjN442q6kmwV+1eY9pIVsKUyU4HWuX5fF9ZZR76FZ
	 QIPUpbbmI2OBiEQhEa1QuPRHJi8WzTKnvYAZR2WBt1Qn9sAAcYjfpNQos4sLTnd+jz
	 j3YX3rgi/Ku+dxS3A70vFg+mEs5UjmPLF2LSZEdfES9e52IkMowFeDUq/YJWNec0p5
	 vlI/GRSEXWhyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] HID: apple: Add support for DockChannel HID
 keyboards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918-apple-mtp-keyboard-final-v2-7-a5c685e50b60@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v2-0-a5c685e50b60@gmail.com>
 <20260918-apple-mtp-keyboard-final-v2-7-a5c685e50b60@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 11:18:05 +0000
Message-Id: <20260918111805.76D861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid-apple: custom match callback ignores HID_QUIRK_IGNORE_SPECIA=
L_DRIVER
--

commit f42c7195001b107355d17e77d99321b92d3f7aad
Author: Michael Reeves <michael.reeves077@gmail.com>
Subject: HID: apple: Add support for DockChannel HID keyboards

This commit adds support for DockChannel HID keyboards to the hid-apple
driver. It introduces a custom match callback to register devices based
on their host bus and specific HID group. The keyboard is then mapped
to the modern Magic Keyboard function-key table.

> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
[ ... ]
> @@ -1019,6 +1029,17 @@ static void apple_remove(struct hid_device *hdev)
>  	hid_hw_stop(hdev);
>  }
> =20
> +static bool apple_match(struct hid_device *hdev, bool ignore_special_dri=
ver)
> +{
> +	if (ignore_special_driver)
> +		return false;
> +
> +	if (hdev->group =3D=3D HID_GROUP_APPLE_DOCKCHANNEL)
> +		return apple_is_dockchannel_keyboard(hdev);
> +
> +	return true;

[Severity: Medium]
Does this code need to explicitly check for the device-specific quirk
hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER before returning true?

Returning true unconditionally for other Apple devices bypasses the HID
core's default safety enforcement. The hid-apple driver will bind to matchi=
ng
Apple devices even if a user or a HID-BPF program has set the
HID_QUIRK_IGNORE_SPECIAL_DRIVER quirk.

This breaks driver fallback to hid-generic and prevents HID-BPF from taking
over the device via the standard quirk override mechanism.

> +}
> +
[ ... ]
> @@ -1248,6 +1272,7 @@ MODULE_DEVICE_TABLE(hid, apple_devices);
>  static struct hid_driver apple_driver =3D {
>  	.name =3D "apple",
>  	.id_table =3D apple_devices,
> +	.match =3D apple_match,
>  	.report_fixup =3D apple_report_fixup,
>  	.probe =3D apple_probe,
>  	.remove =3D apple_remove,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-apple-mtp-=
keyboard-final-v2-0-a5c685e50b60@gmail.com?part=3D7
