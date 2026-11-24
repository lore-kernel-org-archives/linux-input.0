Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535414;
	b=43gB9tQeLsQ+XHdESsZAqXUgBVbJls/8oDFEYP+6MB3nPkyIVF56pYI0qgrgE49ZPNEh
	 vqNhVBazbed9OjzkJMlqKrfBostzfmKdbymUDtYcmLMViddX+X5r6GzcBs5/DV6uV9wSE
	 +9x8mbQhqUy4bZaInba93htBE2DhZjUhzW7ib5bSem2Z51wpnHoZNZ/C3KMy22UanTJUB
	 tOxmUNPDKSzW7SPpv4iWa7UhobiNhIn7MBWQxRz+4pnl7QPbDm2eNkGQrFgKUJq7prhWk
	 xs7yOeSHZ0frNjBu5jEzYkXX7oO8GT/A03+AswIUKcyclfnE8nBBM49MVOqmWAF/cFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535414;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4cxvkU6L9X6WiqXfBYJz1js10t1W7hDsdxZ2dY6jqdc=;
	b=QIR7+yF8tWADTkf/CsoMT7+VdX9uMAcucYw9UGb2G60S9PR2t/70mNCDEnd0YzOMN7lU
	 sThqg4B+V/ihs1PDXCllevetsIieT9ErHWc5t48lnDSInW/2UWBYmzcVZa/sDMK57bi6b
	 SL3VvFCNIV6a5k9JHfLJooJe1XMDaaQYPIczXlmhGJMg4lki8qgH/olYj+SeXk7ANt2Wm
	 XctlDjaQCBU1M+s0vAThRAnTYXXKSUIC0BL9B3tNbyziWX442gjxtevMVZt/l+pft3AOK
	 lG0nx/Ye5lcvsHFtZ9ZNYsUmdqJoU95XsXlA775gPYVmoXQtEpqyn+YQTqD/uZ4hsGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=dNmmwI6E;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E154606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 15:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E154606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=dNmmwI6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795535410; x=1795794610;
	bh=4cxvkU6L9X6WiqXfBYJz1js10t1W7hDsdxZ2dY6jqdc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dNmmwI6ENS0bmbPbiqL36KXRquII7zy5UBme8I1utNRAAcEGe6uZe6yoPnHVKECSZ
	 Lj6N5xFD7cLkUx2XkAC/0EJD1VQDeM2VCoC0qiP2JD1HaUofedbz49nwyfG6HnpOSG
	 UqDdJ98ZY1DUutNnzWLwP5+LlhZeP7Ma8gLtx3ncQRuixMHspjFL9jpKgcWBd35OL+
	 woyvCH3QiWzjou1/KkD1Y7Mk+Myyj8wYtp0jKkar5SM0OaQUNd6m0Zl2vJCI/ccRk7
	 V/6EuNQ7sjh0+h1ZisGJA/FOeRxKIsU0QGhIFxPahq4aNs5j5pQNAbE3+EupTeOdoh
	 OC/KSM1RH1szA==
Date: Tue, 24 Nov 2026 15:50:06 +0000
To: sashiko-reviews@lists.linux.dev
From: Erlend Jacobsen <erlendjacobsen@pm.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4] HID: rdmctmzt: add RDMCTMZT keyboard battery driver
Message-ID: <5PQ4CSmlUxHMSHUeyromIa7RlKu03awZ6ZXV3fI9tZOu4A9OzVM4eI60DsA1A0js7NnFI0pPoW-9EFfSZIlMXCkqSu1tzD4lC4E8Bs4l7JQ=@pm.me>
In-Reply-To: <sashiko-outbox-230592@kernel.org>
References: <20261124-b4-rdmctmzt-v4-1-9cb23d1ad876@pm.me> <sashiko-outbox-230592@kernel.org>
Feedback-ID: 128302180:user:proton
X-Pm-Message-ID: 062a2ca2aeabc06a6ca9c168dd531949ec61c7e5
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

> [quote the paragraph starting "If rdm_command() fails or times out while
>  rdm->link is still RDM_LINK_UNKNOWN"]

Yes, that is a real bug. RDM_LINK_UNKNOWN only remains after a poll when
the 0xd0 query got no answer, and rdm_link_may_be_up() treated it like
the dongle's 0x02 (no link). In v5 only 0x02 rules out a link, so a lost
link status counts as a lost poll: the keyboard is still asked, the next
try comes after 5 s, and a present battery is only marked not present
after three failed polls in a row. RDM_LINK_UNKNOWN remains the value
before the first link byte, so that byte is always seen as a change in
rdm_raw_event().

Erlend



On Tuesday, November 24th, 2026 at 07:25, sashiko-bot@kernel.org <sashiko-b=
ot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] HID: rdmctmzt: failed 0xd0 poll with RDM_LINK_UNKNOWN treated
>   as link down
> --
>=20
> commit 10ff773cbdbe0a54663e148f524ced35f821f2d3
> Author: Erlend Jacobsen <erlendjacobsen@pm.me>
>=20
> HID: rdmctmzt: add RDMCTMZT keyboard battery driver
>=20
> This commit adds a HID driver for RDMCTMZT keyboards and their 2.4 GHz
> dongles to poll battery status over their vendor raw-HID interface and
> report the dongle's wireless link status.
>=20
> > diff --git a/drivers/hid/hid-rdmctmzt.c b/drivers/hid/hid-rdmctmzt.c
> > new file mode 100644
> > index 0000000000000..391d7c934f5b4
> > --- /dev/null
> > +++ b/drivers/hid/hid-rdmctmzt.c
> > @@ -0,0 +1,664 @@
>=20
> [ ... ]
>=20
> > +/* Only 0x02 rules out a link; the keyboard's answers decide the rest =
*/
> > +static bool rdm_link_may_be_up(u8 link)
> > +{
> > +=09return link !=3D RDM_LINK_NONE && link !=3D RDM_LINK_UNKNOWN;
> > +}
>=20
> [ ... ]
>=20
> > +/* The dongle's link byte, asked for now: an 0xd0 may have been missed=
 */
> > +static int rdm_dongle_linked(struct rdm_device *rdm, bool *linked)
> > +{
> > +=09u8 reply[RDM_ANSWER_LEN];
> > +=09int ret;
> > +
> > +=09/* rdm_raw_event() stores the link byte of the reply too */
> > +=09ret =3D rdm_command(rdm, RDM_DONGLE_STATUS, reply);
> > +=09if (ret =3D=3D -ESHUTDOWN)
> > +=09=09return ret;
> > +=09if (ret)
> > +=09=09hid_dbg(rdm->hdev, "no link status: %d\n", ret);
> > +
> > +=09scoped_guard(spinlock_irqsave, &rdm->lock) {
> > +=09=09*linked =3D rdm_link_may_be_up(rdm->link);
> > +=09}
> > +=09return 0;
> > +}
>=20
> [Severity: Medium]
> If rdm_command() fails or times out while rdm->link is still
> RDM_LINK_UNKNOWN (at initial probe or after rdm_reset_resume()), does
> rdm_dongle_linked() treat the lost poll as an active RDM_LINK_NONE report
> from the dongle?
>=20
> Because rdm_link_may_be_up() returns false for RDM_LINK_UNKNOWN,
> rdm_battery_work() takes the !linked path: after a reset_resume, a single
> lost RDM_DONGLE_STATUS query immediately marks a present battery as not
> present and sets wireless_status to disconnected, and at both probe and
> reset_resume it delays the next poll for RDM_POLL_MS (60 s) instead of
> retrying after RDM_RETRY_MS (5 s).
>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-b4-rdmct=
mzt-v4-1-9cb23d1ad876@pm.me?part=3D1
> 
