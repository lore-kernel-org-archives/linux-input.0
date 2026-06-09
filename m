Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BAB377EBA
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022065; cv=none; b=qDDx467SVBFzBb0tYzQY+WlMQXs1rRdCOsP9o7dumbWpN2dld7N/Hg+U90uDP8Wi9Jq+x/OrSBx6qf/Fh2sQPowbVr9xqjF9hWV7njKz7xFtwJ4UAJV5qqFhr8E10Vl57UXY5Tez59ikNx5/cA+nImZy7QVIoH+RYXW/G4tQ3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022065; c=relaxed/simple;
	bh=91zLGe/9YuimnQRlhwTB8RCcjIfKnOoZZHUI9wB3BRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJyqgAhtzal+viHG6oYOpG1jeWxGr9lpq+st+/EtTY58vg+szxJZwLFzHIQrE3I4eGWwIrY+Yk62iyc/cASAUlQ1UsQMlJHwTLSYkf0JnLqn6M342Y0V7rFfK/3hkDHCGumxE/LhHhJZTtAV2Zlsl9XN3njuIH1h1NPhOkFmNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYP1E3TR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYP1E3TR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882221F00893;
	Tue,  9 Jun 2026 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781022063;
	bh=jwXsRLHs/y8m3SE9ht+p0nk6LOsPRBYmoo7v7aUmjMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IYP1E3TRom/EvVyeAautu5/AO7mpA98KF7SXQqs5ShKWBvcM8fOhrJwiRjicZdmYq
	 dKIl8zwuLsKz+v1xgxXa0BO1PsK9rBCArEnZ6JUCh0lc3gv6VVSn5TRHUxzhfCvxVU
	 hg55wvvJbe4SekKoA/xwL1H7sKL3SDVrIJUx80YMIHBgSGhXwZ3x0vUwyFVR//vgJi
	 sBlIlEYyw51rH5aHtG0T40w0UwZuSiFtimRlZBmPG9Ezz5MKzvLVk+x1FZ5JZFkcTf
	 j63xAgb3eJYt7soyBkCojDpH/KBXJHgibEennV0tqnbFx8E1kTUOD078Cd2YcvVnbO
	 QlZlDz/WEGzMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: pidff: Use correct effect type in effect update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleg Makarenko" <oleg@makarenk.ooo>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260609160031.493353-1-oleg@makarenk.ooo>
References: <20260609160031.493353-1-oleg@makarenk.ooo>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:21:03 +0000
Message-Id: <20260609162103.882221F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing out-of-bounds read in `pidff_find_effects` leading to=
 potential kernel panic (local DoS via crafted USB device).
--

commit 07c3b678f1bae4a1c16dfff6971345dc4b180f89
Author: Oleg Makarenko <oleg@makarenk.ooo>

HID: pidff: Use correct effect type in effect update

This commit fixes an issue where the effect type from the last created effe=
ct
was incorrectly used when updating existing effects. It ensures the correct
effect type ID is sent to the device, fixing force feedback in games that
manage multiple simultaneous effects.

> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index c45f182d04480..5f4395f7c6458 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but looking at pidff_find_effect=
s()
in this same file:

drivers/hid/usbhid/hid-pidff.c:pidff_find_effects() {
...
	for (i =3D 0; i < ARRAY_SIZE(pidff_effect_types); i++) {
		int pidff_type =3D pidff->type_id[i];

		if (pidff->set_effect_type->usage[pidff_type].hid !=3D
		    pidff->create_new_effect_type->usage[pidff_type].hid) {
			hid_err(pidff->hid,
				"effect type number %d is invalid\n", i);
			return -1;
		}
	}
...
}

Could this code cause an out-of-bounds read if a malicious USB device is
plugged in?

The type_id array is populated with 1-based logical indices, but pidff_type=
 is
used directly as a 0-based index to access the usage arrays.

If the device descriptor defines many usages in create_new_effect_type but
very few in set_effect_type, would pidff_type exceed
set_effect_type->maxusage and read past the end of the array?

Does this risk a kernel panic if the read crosses page boundaries during
device probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609160031.4933=
53-1-oleg@makarenk.ooo?part=3D1
