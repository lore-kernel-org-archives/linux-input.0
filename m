Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452216;
	b=JiRtPVOh1rlU59kHM2fZHYX1gBXpkME665pr/tFhQ0G0b3VI7o5KU15e4aWw1zfD9kJ/
	 +/zeD03isznWLHHKWC1cxUDv6HLzAJbyuB1MmtkunXB3OJlL5SpXS78O+qCh1/rxmMElw
	 LtLQ3cpC6BFsJa0c3YWbpAdQptZU2wVT5CWwHwx2m9hQWu9jjGwwQtngY9ZBgmX3X+7qv
	 uH6fJnfd/LtXtrte6yBQu8bQbWZkJ+Zg5fLrBJtJF4RPQl/Sjt0G4M2SGUUnqa7s1Ou1s
	 yUUB7KyH8wXSD92H2olKIG+UL6+/FfbVTWu0Fnj1H+x5DR4G6d1xT6kzC2xsjlqoU9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452216;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=U3bXzxE9PE+5EeuflkK/MmHPqdxGmTfaMaP+/oBWzZc=;
	b=xwkbw6T96A2NUhSq3Cz16b9wi/BC3nNePXzYzMw63UaA1IOBI80s5vWJZnT1aZtmzdtr
	 me4AOMwYjdGMbaTycZMh4h2EjzIqIg2FjDxBMDSE9zg9QxL+AbnkOT8few7vn/I41j4HX
	 7kKRn3Wv/rfubz3VMkkgU+DLhGpGHKD8RvA3DIhezrOKa9sjuewwWkKRHHAXS//1ZOz6Z
	 QG+xi45RiOUau8akCTTO+MgOJhfVooqlARH31C9oMalEGP+4JniW24XI+i+w4IT3pU2Dd
	 bkjVxLpakhJly1iRm9obBMMlyM6jltEnVjW1VM7cJlq85aqH9/wwV3DW2HGrVcj5SDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=LgqU0EGt;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAEF606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 16:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DAEF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=LgqU0EGt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795452213; x=1795711413;
	bh=U3bXzxE9PE+5EeuflkK/MmHPqdxGmTfaMaP+/oBWzZc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LgqU0EGtTxPVm84NmjBCuOxtU0pT3Ya1J6e4Jq/WCcRy22KYyRJE4kXUDvNAzpmc/
	 7vBuHSQ+HxlHDGMCo61X/zzd4augXImPxYmtkfFG+FAOot7UHIqcJBjrwNunLGqzWx
	 XzDH0y2wtJRvDOpFPfmYhT55y4xylXhDLNXGaJarbrWXO1eVrRPQ4kDcdDGxsvg4AV
	 LEkElHuamueRsJ/HJBfOIQeuvMYu1dAdBTvbRzilOcvO5xyit5P4LA9JQ9Ho4jFkEA
	 TPRu3Q7+a6kY0qzVmFux5QZIbrdBruMUuBj1ZjZ7IuyVz3bdw0C/Rp64Ca5LgjR3kx
	 vhPBw+Fu4JgwQ==
Date: Mon, 23 Nov 2026 16:43:30 +0000
To: sashiko-reviews@lists.linux.dev
From: Erlend Jacobsen <erlendjacobsen@pm.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2] HID: rdmctmzt: add RDMCTMZT keyboard battery driver
Message-ID: <32ixcLJs8A9rbhRwB5jUgryVZNwXWjwE5lF7zmNwREwiHEgmJRO75Oeu0jTf5ULhfvqn7L18SXFxPrvauHHdbnpD-7vGQQSl96jC5vt2E1g=@pm.me>
In-Reply-To: <sashiko-outbox-229637@kernel.org>
References: <20261123-b4-rdmctmzt-v2-1-8c18d7dac4bc@pm.me> <sashiko-outbox-229637@kernel.org>
Feedback-ID: 128302180:user:proton
X-Pm-Message-ID: 88fa773171a6e136de1fb1cb0c973705660714f3
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you for the review.

> When a dongle keeps linked =3D=3D true while the keyboard is silent (such=
 as
> bcdDevice 0x0102 reporting link byte 0x00), three unanswered polls leave
> both rdm->silent and rdm->fails at RDM_MAX_FAILS.  If the keyboard then
> connects and answers RDM_CMD_START without returning a battery status yet
> (for example, refusing with 0x0f before measuring the battery),
> rdm->silent resets to 0 while rdm->fails stays at RDM_MAX_FAILS.
>
> Does delay then fall through to RDM_POLL_MS (60 s) instead of
> RDM_RETRY_MS (5 s) on that first answer?

Yes. v3 resets rdm->fails when the keyboard answers after
RDM_MAX_FAILS silent polls, as v2 already does while the dongle reports
no link, so that first answer is retried after RDM_RETRY_MS.

Erlend



On Monday, November 23rd, 2026 at 17:03, sashiko-bot@kernel.org <sashiko-bo=
t@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] HID: rdmctmzt: 60s retry delay in rdm_battery_work() on first
>   answer
> --
>=20
> commit db1494c514873abbd1e68abaf2e2c2ff69742269
> Author: Erlend Jacobsen <erlendjacobsen@pm.me>
>=20
> HID: rdmctmzt: add RDMCTMZT keyboard battery driver
>=20
> This commit adds a HID driver for RDMCTMZT keyboards and their 2.4 GHz
> dongles to poll battery status over the vendor raw-HID interface and
> report the dongle's wireless link status.
>=20
> > diff --git a/drivers/hid/hid-rdmctmzt.c b/drivers/hid/hid-rdmctmzt.c
> > new file mode 100644
> > index 0000000000000..cad89c22577d4
> > --- /dev/null
> > +++ b/drivers/hid/hid-rdmctmzt.c
> [ ... ]
> > +static void rdm_battery_work(struct work_struct *work)
> > +{
> [ ... ]
> > +=09if (!linked) {
> > +=09=09/* A keyboard that comes back starts with fresh counts */
> > +=09=09rdm->silent =3D 0;
> > +=09=09rdm->fails =3D 0;
> > +=09=09wireless =3D USB_WIRELESS_STATUS_DISCONNECTED;
> > +=09} else {
> > +=09=09rdm->silent =3D answered ? 0 : min(rdm->silent + 1, RDM_MAX_FAIL=
S);
> > +=09=09rdm->fails =3D got ? 0 : min(rdm->fails + 1, RDM_MAX_FAILS);
> > +=09=09if (answered)
> > +=09=09=09wireless =3D USB_WIRELESS_STATUS_CONNECTED;
> > +=09=09else if (rdm->silent >=3D RDM_MAX_FAILS ||
> > +=09=09=09 rdm->wireless =3D=3D USB_WIRELESS_STATUS_NA)
> > +=09=09=09wireless =3D USB_WIRELESS_STATUS_DISCONNECTED;
> > +=09}
> > +
> > +=09/* Without a link the dongle reports when it comes back */
> > +=09if (got || !linked)
> > +=09=09delay =3D RDM_POLL_MS;
> > +=09else if (rdm->fails < RDM_MAX_FAILS)
> > +=09=09delay =3D RDM_RETRY_MS;
> > +=09else if (rdm->dongle && rdm->silent >=3D RDM_MAX_FAILS)
> > +=09=09delay =3D RDM_SEARCH_MS;
> > +=09else
> > +=09=09delay =3D RDM_POLL_MS;
>=20
> [Severity: Low]
> When a dongle keeps linked =3D=3D true while the keyboard is silent (such=
 as
> bcdDevice 0x0102 reporting link byte 0x00), three unanswered polls leave
> both rdm->silent and rdm->fails at RDM_MAX_FAILS.  If the keyboard then
> connects and answers RDM_CMD_START without returning a battery status yet
> (for example, refusing with 0x0f before measuring the battery),
> rdm->silent resets to 0 while rdm->fails stays at RDM_MAX_FAILS.
>=20
> Does delay then fall through to RDM_POLL_MS (60 s) instead of
> RDM_RETRY_MS (5 s) on that first answer?
>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-rdmct=
mzt-v2-1-8c18d7dac4bc@pm.me?part=3D1
> 
