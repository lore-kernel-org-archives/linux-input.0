Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500714;
	b=W2447/Wba57yAMFd8z4+2p7G2VnAdgYIdI/qNoV8Y1WsxnPTReAlGYdlnCjmZL8DdAWP
	 2ihZZoGDdEBxM6rKByRZ3JfAJAKRU+a04q8fPydb3GcrQNCPnyKXG9VhFZET45BabUjoR
	 80MbTZlAZ+JnMlAVHYzLpExS5ddhwhBx9vBxSRYsp6DPSnScvVZ+QTKwBlBdRsc520+rH
	 2V3kQflGuZL2XVtQFu0ivyGc9AXHWlxhMWyToaJJv1jFAqcP52HLl8EAaudKb9NErmMgY
	 O4yaRXT6sG1QjDLU4GppjQh8WpJwRAVRKGKa88IBmj0jJj/Nc1x5nLs3LRHxLHn+pMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500714;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qDNdpUL/8B/XXersHG/IyeaDG2C757klasspkhAuRZQ=;
	b=BAXD7reeXtUfRs++Z5vS8mEuYLiq4VISMnGjhUNWUZvokwLzUZFyT3b0Y13/HG82d/P1
	 BzD1LULHz/geavV9snokvdL8T0498pdDW1368XYHsHDbzn5yvKEPwffdpQfe3mHGovtg6
	 YlPzCc67Pe4psI9PaOJytLIffwli1szChtGrUefT/lTn7PT6SnvtQuEYRO03Oud5gde97
	 IUASjialoet9AgtxjIp5Q/Pdwf4wcC03itHQsxS4+lqF8Jf1MDEuZlGgAOOI//KARSZWc
	 RDoNmi+7A3PeykFJLxrgirrLJZ6zwcL5oui2Zp1eIu2CS/NVFQBJTssX8MhDY4Vb34Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=QBUndeGG;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F8606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 06:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C7F8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=QBUndeGG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795500711; x=1795759911;
	bh=qDNdpUL/8B/XXersHG/IyeaDG2C757klasspkhAuRZQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QBUndeGGmas5wSmiinNp9dsBwUMkQJr2zm9tP3FzKoyuhCYE6txDMO7xbJxzKMwee
	 3Ispx9EeHfM9wzs4PjvlK0111EDJzNshxk+etrdjx5pXd091X7NMjFBJ77uiC9kyDY
	 WcEMiuwrjMM6kzpC5eL9quoQyfXyQYAS8CvWsLsztvkayQX5HrowMjYRZdrhzkLGve
	 NHi7x23pi01TYH0Pfq6/vyCtCRAGaYwgvJN+mTh/lT+/h/lt5sYWTaG9q4ZsD4IgY/
	 0Ft6scPlCLHvwDwAfNV9aOOoSLicksBHU8t7bHWJL61RIM7CbRs/L0klEC1pjYyiID
	 2tcuqdz4jRSWQ==
Date: Tue, 24 Nov 2026 06:11:46 +0000
To: sashiko-reviews@lists.linux.dev
From: Erlend Jacobsen <erlendjacobsen@pm.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3] HID: rdmctmzt: add RDMCTMZT keyboard battery driver
Message-ID: <7xZrYaTeVw_39BwDhdCjoTvQZqOyrX6ndWt9U8FIXv00PkSpubYb2cSKiRCIU27c0lwc0RaRDKysqWJRedox90ahVd1yg-gp00yWAEj-mH8=@pm.me>
In-Reply-To: <sashiko-outbox-229783@kernel.org>
References: <20261123-b4-rdmctmzt-v3-1-5ce2359df0aa@pm.me> <sashiko-outbox-229783@kernel.org>
Feedback-ID: 128302180:user:proton
X-Pm-Message-ID: 3b902867fdbf0bafdf0fb36c27930c38c244b490
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

> [quote the paragraph about rdm_dongle_linked() storing the link byte
>  after rdm_command() returns]

Yes, that race was real. In v4 rdm_raw_event() stores every link byte
from the dongle under the lock, whether it was asked for or not, and
schedules a poll when it changed and was not the awaited answer.
rdm_dongle_linked() now only reads rdm->link, so a reply can no longer
overwrite a newer unsolicited status.

Erlend



On Monday, November 23rd, 2026 at 18:49, sashiko-bot@kernel.org <sashiko-bo=
t@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] HID: rdmctmzt: split-lock rdm->link update in
>   rdm_dongle_linked()
> --
>=20
> commit 6c486e725a5b70b38d74595b3572ef11e0c655ce
> Author: Erlend Jacobsen <erlendjacobsen@pm.me>
>=20
> HID: rdmctmzt: add RDMCTMZT keyboard battery driver
>=20
> This commit adds a HID driver for RDMCTMZT keyboards and their 2.4 GHz
> dongles to poll battery status over the vendor HID interface and report
> wireless link status.
>=20
> > diff --git a/drivers/hid/hid-rdmctmzt.c b/drivers/hid/hid-rdmctmzt.c
> > new file mode 100644
> > index 0000000000000..fc740c7a4e482
> > --- /dev/null
> > +++ b/drivers/hid/hid-rdmctmzt.c
> [ ... ]
> > +/* The dongle's link byte, asked for now: an 0xd0 may have been missed=
 */
> > +static int rdm_dongle_linked(struct rdm_device *rdm, bool *linked)
> > +{
> > +=09u8 reply[RDM_ANSWER_LEN];
> > +=09int ret;
> > +
> > +=09ret =3D rdm_command(rdm, RDM_DONGLE_STATUS, reply);
> > +=09if (ret =3D=3D -ESHUTDOWN)
> > +=09=09return ret;
> > +
> > +=09scoped_guard(spinlock_irqsave, &rdm->lock) {
> > +=09=09if (!ret)
> > +=09=09=09rdm->link =3D reply[RDM_LINK_BYTE];
> > +=09=09*linked =3D rdm_link_may_be_up(rdm->link);
> > +=09}
> > +=09if (ret)
> > +=09=09hid_dbg(rdm->hdev, "no link status: %d\n", ret);
> > +=09return 0;
> > +}
> [ ... ]
> > +static int rdm_raw_event(struct hid_device *hdev, struct hid_report *r=
eport,
> > +=09=09=09 u8 *data, int size)
> > +{
> > +=09struct rdm_device *rdm =3D hid_get_drvdata(hdev);
> > +
> > +=09if (!rdm || size < RDM_ANSWER_LEN || data[RDM_PREFIX_BYTE] !=3D RDM=
_PREFIX)
> > +=09=09return 0;
> > +
> > +=09guard(spinlock_irqsave)(&rdm->lock);
> > +=09if (rdm->expect && data[RDM_CMD_BYTE] =3D=3D rdm->expect) {
> > +=09=09memcpy(rdm->answer, data, RDM_ANSWER_LEN);
> > +=09=09rdm->expect =3D 0;
> > +=09=09complete(&rdm->done);
> > +=09} else if (data[RDM_CMD_BYTE] =3D=3D RDM_DONGLE_STATUS && rdm->dong=
le &&
> > +=09=09   data[RDM_LINK_BYTE] !=3D rdm->link) {
> > +=09=09/* The link to the keyboard came or went: ask now */
> > +=09=09rdm->link =3D data[RDM_LINK_BYTE];
> > +=09=09if (rdm->expect && !rdm_link_may_be_up(rdm->link)) {
> > +=09=09=09rdm->expect =3D 0;
> > +=09=09=09complete(&rdm->done);
> > +=09=09}
> > +=09=09if (!rdm->stopping)
> > +=09=09=09mod_delayed_work(system_dfl_wq, &rdm->work, 0);
> > +=09}
> > +=09return 0;
> > +}
>=20
> [Severity: Medium]
> Can rdm_dongle_linked() overwrite a newer rdm->link update or cause
> rdm_raw_event() to drop an unsolicited link-change event?
>=20
> When rdm_dongle_linked() requests RDM_DONGLE_STATUS, rdm_raw_event() take=
s
> the rdm->expect branch and completes rdm->done without updating rdm->link=
.
> If the dongle sends an unsolicited RDM_DONGLE_STATUS report before the
> worker updates rdm->link in rdm_dongle_linked(), the two updates race:
>=20
> kworker                           <hardirq>
> rdm_dongle_linked()
>   rdm_command(RDM_DONGLE_STATUS)
>     rdm->expect =3D 0xd0
>                                   rdm_raw_event() [reply: link =3D 0x02]
>                                     memcpy(rdm->answer, data, ...)
>                                     rdm->expect =3D 0
>                                     complete(&rdm->done)
>                                   rdm_raw_event() [event: link =3D 0x00]
>                                     data[13] !=3D rdm->link (0x00 =3D=3D =
0x00)
>                                     /* reconnect event ignored */
>   rdm->link =3D reply[13] (0x02)
>   *linked =3D false                 <-- stale link state kept
>=20
> Because rdm->link still held 0x00 when the unsolicited reconnect report
> arrived, rdm_raw_event() did not reschedule rdm->work, and
> rdm_dongle_linked() then stores the older RDM_LINK_NONE (0x02) reply,
> leaving the reconnected keyboard unpolled for RDM_POLL_MS (60 s).  In the
> opposite transition (reply 0x00 followed by unsolicited 0x02),
> rdm_dongle_linked() overwrites the newer 0x02 in rdm->link with the stale
> 0x00 from reply[].
>=20
> Updating rdm->link inside rdm_raw_event() whenever a valid
> RDM_DONGLE_STATUS report arrives (and having rdm_dongle_linked() only rea=
d
> rdm->link under rdm->lock) would avoid this race.
>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-rdmct=
mzt-v3-1-5ce2359df0aa@pm.me?part=3D1
> 
