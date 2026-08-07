Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5873B2AA
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147163; cv=none; b=ZVxaZ47gOlRIxHec5rJg1Kn1yvYMyxGwyCsEBc501Dz7oc3wxX+qePv4YOnV9PQGtYkCsFhxlohMjZM9lyU05Is09dSZjzUd4JtFMvqbH8JuxdXlTnuBy96ChvrIzRAlOqLm0rR0x2qF08P5zsHa2/rIxcwGRzffbCl2a4kixMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147163; c=relaxed/simple;
	bh=kGkSnkKUU/4SoEUMOQum5WR9eAbYuK1eVMmX8x/2JGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VnVszGYp9IEJab0qahmZo4CMskIOElA+ZDAAgO4kHT9ElRCaPyBq5Sa6FPLs/iiaJ5pFlIc8a/jlgfmhKsOZhKBtNOEAwAkBCs+1UBcpqdlDe8BMd5pZW9SjA14q8YFh/YeuWs/JGMN46rdDkAYR7xwXfkVi/Q6zDQ90f20VPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY8pOyJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY8pOyJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185D71F000E9;
	Fri,  7 Aug 2026 23:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786147162;
	bh=wxGUD2X/Ev1ILBJ6k98hfL5F+mgmFtX5veJvgwUTle0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hY8pOyJarYXND9RoYpQZptsqbBQ1E1PTiO40eA15Dh5Uf+BSsE+xbGGoAty/AkLOp
	 iN5h3DkBeuNyfV2N9tTdkSX1F/j5lp8pvjlX8BQMWqGjI3X2y5R54s0l0BJ24tZKR7
	 XkJuRfynll+m2Nc5ZG7AjIqZoSTlVEOHQK18gSSnNX46c1iFMNS3HZILejkQYg/4tC
	 hmOhJWJgr3yDOMdFRaSkDERq38twNZOX4uX91jWfTXQMH0SRwBmFRgYAKldVLM2vuJ
	 nlnMtu07SxSP1cDS+u8K5szSjEZSIKiraejDZKhIxBecKaqhAiPNoT+t/SMkEVVauS
	 vLn88l252RVKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] HID: steam: Initial 2026 Steam Controller
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260807232339.2799205-3-vi@endrift.com>
References: <20260807232339.2799205-1-vi@endrift.com>
 <20260807232339.2799205-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 23:59:21 +0000
Message-Id: <20260807235922.185D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free (UAF) of the `steam` struct due to uncancelled dela=
yed works when asynchronous registration fails.
--

--- Patch [2]: [PATCH v4 2/6] HID: steam: Initial 2026 Steam Controller sup=
port ---
commit 1d87ff75b79e456dee7ec00f38dd2bafa9555a17
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Initial 2026 Steam Controller support

This brings support for the 2026 Steam Controller, comparably featureful to
the existing support for the Steam Deck.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 5deeff2db266e..ec7ccbe5aba09 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -1210,7 +1440,6 @@ static void steam_unregister(struct steam_device *s=
team)
>  	mutex_lock(&steam_devices_lock);
>  	list_del_init(&steam->list);
>  	mutex_unlock(&steam_devices_lock);
> -	steam->serial_no[0] =3D 0;
>  }

[Severity: High]
Can this result in a use-after-free of the steam struct?

If a controller connects asynchronously and steam_register() is called,
it registers the input device. If a subsequent step like
steam_sensors_register() fails, the error path is taken:

drivers/hid/hid-steam.c:steam_register() {
...
	ret =3D steam_sensors_register(steam);
	if (ret !=3D 0)
		goto steam_register_sensors_fail;

	steam->registered =3D true;
...
steam_register_sensors_fail:
	steam_input_unregister(steam);
...
}

Because steam->registered is never set to true, any delayed works scheduled
during the brief window the input device was active (such as mode_switch
or rumble_work) might still be pending.

Later, when the device is removed, steam_unregister() is called but
returns early without canceling those works:

drivers/hid/hid-steam.c:steam_unregister() {
	if (!steam->registered)
		return;
...
}

When devres frees the steam struct at the end of steam_remove(), wouldn't
the still-pending works execute and access freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807232339.2799=
205-1-vi@endrift.com?part=3D2
