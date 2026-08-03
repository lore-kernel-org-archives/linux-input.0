Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7850432BE1;
	Mon,  3 Aug 2026 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782324; cv=none; b=APFiQqJTFtpVOe1S5Yb1pfDeVumPxWwlqPSXb5RlXwcS9VPYQPzJnTBauPmImYfClaKz0a7bRliEbN5b290ZPkOZ+Rtlt80lLcSi+bz5OMW0r3c132dEuLX6CRzPHO2l0wT0qcChKeWVSJCQV7SuzdPFzw4+OtiZQzV/kBkYaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782324; c=relaxed/simple;
	bh=Op+tFnTe5MA12xM4yjuqyrNzUvOKLHSnN6JMN954TRY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mSDNq8KdwFjhhCFBb/1ia6xnoNorJDKeuRiaUDoZv9nhBw89F7a+TgqFandIGaVF9Wr5cQyY1/EmwKZA+nH28SilWjh1lOY7NrshJbHwxzLzGH+uKgJH6OSLpcrsL68DElReijyk4UzT20cSjE88dLA9JClH2b5BaNgzq9CFciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCsZo1So; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCsZo1So"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE72C1F000E9;
	Mon,  3 Aug 2026 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782322;
	bh=JuUhPElFsjrAqQ4MqhZeGhZ+C8IxlE4E0T9su6gUoog=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OCsZo1SoOgZmCxNhDwjVkJg41Oijuni68W0NHGp2qehNOIHjfu8ntejM1ArtQDjpz
	 ljATgZ3nbsBoTdCBESluJeq3xiKMvUv0LpHS1z4O+rOgkoY9LyfymWS8uJRvWapiqy
	 t0KwKjBEJwA1sQVP+ZKwzp6ZmQecnZfPWqZGRm3e0GBeJiBv8JtZqvF205ORKDmwnR
	 mNcb6xMO+aKMwr6wu+xHde2CvO9GmkBrI+pN2AZIVqT4uVYKZhQKmHgPJn+wCWkmPx
	 y3rb5BBIGvGiFtIsBIvIGgbnonylcfCLa8SRaNp2mP4yqbJR1G2NM0IUtWffawrP+e
	 7sKpb8QHXGwZg==
Date: Mon, 3 Aug 2026 20:38:39 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Jose_Villase=F1or_Montfort?= <pepemontfort@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Andrei Fed <andfed.net@gmail.com>, Alec Hall <signshop.alec@gmail.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: input: read battery capacity from its actual
 report offset
In-Reply-To: <20260728201309.776026-1-pepemontfort@gmail.com>
Message-ID: <op9op49q-40rp-2rns-5843-5oq03r0998n5@xreary.bet>
References: <20260728201309.776026-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 Jul 2026, Jose Villase=F1or Montfort wrote:

> hidinput_query_battery_capacity() assumes the state-of-charge value is
> the first byte following the report ID (buf[1]) and ignores where the
> battery field actually sits within the report.
>=20
> An Apple Magic Trackpad 2 precedes the AbsoluteStateOfCharge byte with a
> byte of status flags in its battery reports, so this query returns the
> flags byte instead of the charge level.
>=20
> The device happens to make that easy to observe, because it exposes the
> same cell twice: its report descriptor declares AbsoluteStateOfCharge in
> two reports (0x90 and 0x9b), so hidinput_setup_battery() registers two
> power supplies. Only the first one is refreshed by hid-magicmouse -- it
> uses hid_get_battery(), which returns the first battery of the list --
> and that refresh goes through the report event path, which parses the
> field correctly. Nothing ever reports the second one, so every read of
> its capacity takes the query path above. On a USB-C Magic Trackpad over
> USB, on an unpatched 7.1.5:
>=20
>   hid-<serial>-battery-144 =3D 100%  (Charging)      <- report event path
>   hid-<serial>-battery-155 =3D   3%  (Discharging)   <- query path
>=20
> Both are the same physical battery. A raw HIDIOCGINPUT of the two
> reports at that same moment:
>=20
>   report 0x90 -> [90 03 64]
>   report 0x9b -> [9b 03 64 64 00 00 10 00 00 00 00 00 00 00]
>                      ^flags ^SoC =3D 0x64 =3D 100%
>=20
> The device answers correctly in both cases; only the offset the kernel
> reads the capacity from is wrong. 0x03 is the flags byte (present,
> charging), reported as "3%".
>=20
> Bluetooth takes the same query path for its capacity, where the trackpad
> reported a bogus near-constant ~4% -- 0b100, the FullyCharged flag --
> regardless of the real charge.
>=20
> Store the battery field's offset within the report at setup time and use
> it when querying, so the capacity is read from its real position. The
> report event path already parses the field correctly through the HID
> core; only the explicit GET_REPORT query was wrong.
>=20
> Devices whose capacity field is the first field in the report have a
> report_offset of 0 and are unaffected (buf[1 + 0] =3D=3D buf[1]).
>=20
> Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Villase=F1or Montfort <pepemontfort@gmail.com>
> ---
> No code changes since v1, only the commit message and tags.
>=20
> Changes in v2:
> - Added Fixes: 581c4484769e, which introduced
>   hidinput_query_battery_capacity() with the hardcoded buf[1], and a
>   stable tag.
> - Dropped the claim in v1 that USB is unaffected. It is not: the
>   trackpad's descriptor declares AbsoluteStateOfCharge in two reports,
>   hidinput_setup_battery() registers a power supply for each, and
>   hid-magicmouse only ever refreshes the first one (hid_get_battery()
>   returns the head of the list). The second power supply therefore
>   serves every read from the broken query path, and shows 3% -- the
>   flags byte -- permanently, on USB, next to the first one showing the
>   correct 100%. That replaces the v1 example, since it puts the working
>   and the broken path on the same cell at the same instant.
> - v1: https://lore.kernel.org/linux-input/20260702192139.114809-1-pepemon=
tfort@gmail.com/

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

