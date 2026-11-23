Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448872;
	b=ODzoiKSWDAIRj+CAE7cVWbzFZXpS8VK1F97P2aFS+aOYvyM/O2DPA4cYwzMsStkdXNTX
	 Rnc5spuNfp21WWmZlkd36Q38NAKbWsVCVFHdnoM9/QGPNYAPZ4ikskW9SBKc4WB4wDOkE
	 c1p7a4wTZOpKPoAHf9XdB4LQIuQFgkbptbQeaPDwAa7NrCO2Ij+47JreAoSQfm4nOiS1Y
	 30OShdzzsyi4QCjl5kiJSaq8EVJP2Q03IZGQbaaOV7p4eDzW8NXpdSQn4BqZ4UQC6vQ4a
	 1O7QAsQl4Wxw/mU1t5XP6AAf5mWbBLJGgO01RORx7C/HeTtIMHr1JOpJXtoVWeYap2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448872;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Sxme6riOmitdd/D4oIIp+QdlkQ7Ium7Vb6++P08XVEc=;
	b=V6ll+OIbY0+uAbg5Wrwtmd399vkfxsBw9ZuH+8YCiVQ4YvkJW5k+OYscPTsvRBkQMC8P
	 w9FAjT0tFog4o0dN/TUjnPzncQfrVkH2yRcXWomp5vMuzZYGwXY8o44MppyaXFYLK6JQd
	 uJz0IGjepEUM6HaN8EQ4KadlvM5KT6ljiT3ohvtBRdZ1jAHcNbxtJnGL4kv3SXMD2pUAP
	 1ZFF1x/5lSo8dzLp38qhPeEvOqttASc0fSOApU43QFtSu5YSPtYScVBQM4ACxQhenSwiO
	 Zpvfr62uSRXn9ABlDza5QXNCtmj/rohUc7ZBhrWTypLVdXDG2+bHI9kbyAxJFgNLhJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b="jPVS/347";
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35197606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 15:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35197606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=jPVS/347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795448869; x=1795708069;
	bh=Sxme6riOmitdd/D4oIIp+QdlkQ7Ium7Vb6++P08XVEc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jPVS/347IrIWLHKWBdXz7gUhrjzvQbtCFy95+UuGoV80C7jlrUST1sRUH+4fU8DR5
	 uAzZpHE2ZB0YC0LxOzMbsZEoeUWof2EyZRUZxdRDgf1keoenVm5AuTmrC3qhpnH97T
	 wtvw0/YSAwbMfdbsNBMCJKzVCa0Gm1aspboF1dmpbdpn6D268yUYEm78L84lwg+vo7
	 FZKLgPHG2+14djl9FBjfgDH68nwPtmQtxEKL/Sad5FzpjLHUYyOGOeMd4cLSKuJrNQ
	 v9Nwbb5Vo7cfr+T+szfZB3Wt074PZyEl5gSMeQ50QmtRhERiIeKF1QxFDmb0sG34GH
	 7gfipNs6QEJ4w==
Date: Mon, 23 Nov 2026 15:47:45 +0000
To: sashiko-reviews@lists.linux.dev
From: Erlend Jacobsen <erlendjacobsen@pm.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH] HID: rdmctmzt: add RDMCTMZT keyboard battery driver
Message-ID: <n7p9VNimdc3xx8VRUl1TSM5nXeabeiKke7akTR6m6222F0B7bbhPzUa1YI2QwFIxHoiHP7n2csrJECs1M-mT6JcQtaoh-fyevF7qgqjgpu4=@pm.me>
In-Reply-To: <sashiko-outbox-228283@kernel.org>
References: <20261122-b4-rdmctmzt-v1-1-d45883e1fe33@pm.me> <sashiko-outbox-228283@kernel.org>
Feedback-ID: 128302180:user:proton
X-Pm-Message-ID: 4a443b90599a4db757be5d5508b1a347ce8e9400
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

Thank you for the review. Both points are addressed in v2.

> [Severity: Medium]
> Can a runtime USB reset stop rdm->work permanently when usb_submit_urb()
> returns -ENODEV?

I don't think a reset can produce -ENODEV here: usb_submit_urb() returns
it only while dev->state < USB_STATE_UNAUTHENTICATED, and a reset moves
the device through USB_STATE_DEFAULT and USB_STATE_ADDRESS, both above
that. The only way to get there is USB_STATE_NOTATTACHED after a failed
reset, which usb_set_device_state() never leaves, and the disconnect
then calls rdm_remove().

Still, v2 makes the rule simpler: the work now ends only on -ESHUTDOWN,
which rdm_command() returns only when rdm->stopping is set. Any error
from the transport, -ENODEV included, counts as a lost poll.

> [Severity: Medium]
> Does a stale rdm->fails count after the keyboard reconnects delay the nex=
t
> retry for RDM_POLL_MS (60 s) instead of RDM_RETRY_MS (5 s)?

Yes, that is a bug. In v2, fails and silent are reset to 0 while the
dongle reports no link; the battery is already marked not present then,
because of the linked check. A keyboard that comes back is retried after
RDM_RETRY_MS. Tested by switching the keyboard off and on through the
dongle: the battery was back at the first poll after the reconnect.

Erlend



On Sunday, November 22nd, 2026 at 20:47, sashiko-bot@kernel.org <sashiko-bo=
t@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] HID: rdmctmzt: stale fails count delays reconnect retry in
>   rdm_battery_work()
> - [Medium] HID: rdmctmzt: battery polling stops permanently on -ENODEV
>   during USB reset
> --
>=20
> commit df75940f34ec97cd0e02102aba217a05fb6752a4
> Author: Erlend Jacobsen <erlendjacobsen@pm.me>
>=20
> HID: rdmctmzt: add RDMCTMZT keyboard battery driver
>=20
> This commit adds a HID driver for RDMCTMZT keyboards and their 2.4 GHz
> dongles to poll battery status over the vendor raw-HID interface and repo=
rt
> wireless link status.
>=20
> > diff --git a/drivers/hid/hid-rdmctmzt.c b/drivers/hid/hid-rdmctmzt.c
> > new file mode 100644
> > index 0000000000000..9966025b40587
> > --- /dev/null
> > +++ b/drivers/hid/hid-rdmctmzt.c
> > @@ -0,0 +1,654 @@
>=20
> [ ... ]
>=20
> > +/* Send one command; its answer arrives in rdm_raw_event() */
> > +static int rdm_send(struct rdm_device *rdm, u8 cmd)
> > +{
> > +=09size_t raw_len =3D rdm->len + 1;
> > +=09int ret;
> > +
> > +=09memset(rdm->buf, 0, raw_len);
> > +=09rdm->buf[0] =3D 0x00; /* unnumbered report ID */
> > +=09rdm->buf[1 + RDM_PREFIX_BYTE] =3D RDM_PREFIX;
> > +=09rdm->buf[1 + RDM_CMD_BYTE] =3D cmd;
> > +=09rdm->buf[1 + RDM_SIZE_BYTE] =3D rdm->len;
> > +
> > +=09ret =3D hid_hw_output_report(rdm->hdev, rdm->buf, raw_len);
> > +=09/*
> > +=09 * -ESHUTDOWN from the transport (an endpoint flushed by a USB rese=
t)
> > +=09 * is a lost poll; it must not end the polling like rdm->stopping d=
oes.
> > +=09 */
> > +=09if (ret =3D=3D -ESHUTDOWN)
> > +=09=09return -EIO;
> > +=09if (ret < 0)
> > +=09=09return ret;
> > +=09if (ret !=3D raw_len)
> > +=09=09return -EIO;
> > +
> > +=09return 0;
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
> > +=09ret =3D rdm_command(rdm, RDM_DONGLE_STATUS, reply);
> > +=09if (ret =3D=3D -ENODEV || ret =3D=3D -ESHUTDOWN)
> > +=09=09return ret;
>=20
> [ ... ]
>=20
> > +static void rdm_battery_work(struct work_struct *work)
> > +{
> > +=09struct rdm_device *rdm =3D container_of(to_delayed_work(work),
> > +=09=09=09=09=09      struct rdm_device, work);
> > +=09enum usb_wireless_status wireless =3D rdm->wireless;
> > +=09bool linked =3D true, answered =3D false, got =3D false;
> > +=09bool changed, present;
> > +=09unsigned int delay;
> > +=09u8 capacity =3D 0;
> > +=09int status =3D 0;
> > +
> > +=09if (rdm->dongle && rdm_dongle_linked(rdm, &linked))
> > +=09=09return;
> > +
> > +=09if (linked && rdm_poll_keyboard(rdm, &linked, &answered, &got,
> > +=09=09=09=09=09&capacity, &status))
> > +=09=09return;
>=20
> [Severity: Medium]
> Can a runtime USB reset stop rdm->work permanently when usb_submit_urb()
> returns -ENODEV?
>=20
> During usb_reset_and_verify_device(), usbhid runs hid_pre_reset() and
> hid_post_reset() without calling the driver's suspend or reset_resume
> callbacks, and hub_port_init() temporarily places udev->state in
> USB_STATE_DEFAULT and USB_STATE_ADDRESS.  If hid_hw_output_report() runs
> during that window, usb_submit_urb() fails with -ENODEV (while
> dev->state < USB_STATE_CONFIGURED), causing rdm_dongle_linked() or
> rdm_poll_keyboard() to abort rdm_battery_work() before
> queue_delayed_work().
>=20
> Since rdm_stop_polling() sets rdm->stopping and cancels the work on unplu=
g
> and suspend, should rdm_dongle_linked() and rdm_poll_keyboard() only bail
> out on -ESHUTDOWN (or should rdm_send() also map -ENODEV to -EIO)?
>=20
> > +
> > +=09if (!got)
> > +=09=09hid_dbg(rdm->hdev, "no battery status (linked %d, answered %d)\n=
",
> > +=09=09=09linked, answered);
> > +
> > +=09rdm->silent =3D answered ? 0 : min(rdm->silent + 1, RDM_MAX_FAILS);
> > +=09rdm->fails =3D got ? 0 : min(rdm->fails + 1, RDM_MAX_FAILS);
> > +=09if (!linked) {
> > +=09=09rdm->fails =3D RDM_MAX_FAILS;
> > +=09=09wireless =3D USB_WIRELESS_STATUS_DISCONNECTED;
> > +=09} else if (answered) {
> > +=09=09wireless =3D USB_WIRELESS_STATUS_CONNECTED;
> > +=09} else if (rdm->silent >=3D RDM_MAX_FAILS ||
> > +=09=09   rdm->wireless =3D=3D USB_WIRELESS_STATUS_NA) {
> > +=09=09wireless =3D USB_WIRELESS_STATUS_DISCONNECTED;
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
> [Severity: Medium]
> Does a stale rdm->fails count after the keyboard reconnects delay the nex=
t
> retry for RDM_POLL_MS (60 s) instead of RDM_RETRY_MS (5 s)?
>=20
> While the keyboard is off or unlinked, rdm->fails reaches RDM_MAX_FAILS.
> When the keyboard powers on, the dongle's 0xd0 report in rdm_raw_event()
> queues rdm->work with delay 0 without resetting rdm->fails.  If that
> immediate poll runs before the newly booted keyboard has measured its
> battery, the keyboard answers RDM_CMD_START (answered =3D true) and refus=
es
> RDM_CMD_BATTERY with 0x0f (got =3D false): rdm->silent is reset to 0 whil=
e
> rdm->fails stays at RDM_MAX_FAILS, so the delay check skips both
> RDM_RETRY_MS and RDM_SEARCH_MS and falls through to RDM_POLL_MS, leaving
> the battery unregistered or marked not present for a full minute.  The sa=
me
> 60 s stall happens if one !linked poll sets rdm->fails =3D RDM_MAX_FAILS
> while rdm->silent is 1, and the immediate poll on reconnect times out
> (leaving rdm->silent at 2).
>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-rdmct=
mzt-v1-1-d45883e1fe33@pm.me?part=3D1
> 
