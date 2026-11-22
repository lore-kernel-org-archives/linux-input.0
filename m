Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376848;
	b=FqZ0ZXhcDqyqRaR1smkViNVzf/nU8wLAwv3BmHKlEBagqmHk0lfOTQ3ZBeykqoKCYf/x
	 zjAfVc2hWan8RgJH5VVRGDqiqniUI8xyaaJMacD5nHw2GNRDiCfzhM0n622sJbYq7M+ZV
	 M0ANE+2rOZpg1FaXU4Nai/AgltAcHoG86AT1aUxOKuhHUzz5uf1LcZyfzUTBAW9ll7Uqa
	 PpHtf4iWSuMKJqtucjHNq8c/AQ0WMV/UHci7O85V97Xu7sRmvbTfZKFGSVVbVP5kRthiA
	 MRwt9EpNj4Md2rfUCRYnb8180JnmhQ+QhrXSdhOMgqT7ReWcXspgJCM9bXBGX+qbodA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j+mnsELK7VXL2g2cb9zfpiYJx7Lm1c8s2ym5muvm05g=;
	b=SZCjwW9vNlwyXBKcgfciqGHnt5De7MERuLRHy9fEpLIJBtj9yJBoUNVAN+ar+7AWNp2b
	 qYxCDoEB3SbWtRMhUPESbzYZ2l0EbdKQ+FZe33/vEsnuQLZPS6f39E+FEQBR64JCja95H
	 L0qd2vKRQkZ09uttk1DAf9wXzXWCaHBLOhlPmcp4bV8CL9MT75noF+T40XC/tT01QglZs
	 yglgfnqmiKh+XhovGNOws+OqtNyZgbZ+X3C9meXhuw/O+5XfdxvyrtKylUl+Ik8nbjKXw
	 Glg3iyVzQvYB6+iVVOx++IxnjnE6i1I7y9s/9McnaCctpBhgKE27bfnOBqAj2ISb6HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K41iAq7t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D33606A31A
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K41iAq7t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350921F000C6;
	Sun, 22 Nov 2026 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795376847;
	bh=j+mnsELK7VXL2g2cb9zfpiYJx7Lm1c8s2ym5muvm05g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K41iAq7tl5Jgp7uhPki3vaB/pofCuV75sfmvWLQE++ZD9QtfLbn8VsGMnVOrHQfUc
	 n/ebse9ZCKDHlPiYAkrDSconyuJegtOEXf3TTVPBdoUVufB1VySCvKdqXDHJrybnkK
	 QFdbSiakGrkZB4J7+sLrRR3S+8EsWm2CrTjTswtF7iZcgBbng2ZfVWlyPK8CQaJb3C
	 UjEMWx54XO7fyda6PlUgTf/G0tTqQVDpmBOxvbZqLsQl8ybDYG6BiGi4JnhwK6JL2T
	 kvIlD2SYcK3yzqInmE7z2dJsKYLoADOhMsDIzRKxUYGazflIMwbLjKGz6ZGmBkRmAm
	 Z1iYvkF6n276g==
Message-ID: <sashiko-outbox-228283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: rdmctmzt: add RDMCTMZT keyboard battery driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Erlend Jacobsen" <erlendjacobsen@pm.me>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261122-b4-rdmctmzt-v1-1-d45883e1fe33@pm.me>
References: <20261122-b4-rdmctmzt-v1-1-d45883e1fe33@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 19:47:26 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] HID: rdmctmzt: stale fails count delays reconnect retry in
  rdm_battery_work()
- [Medium] HID: rdmctmzt: battery polling stops permanently on -ENODEV
  during USB reset
--

commit df75940f34ec97cd0e02102aba217a05fb6752a4
Author: Erlend Jacobsen <erlendjacobsen@pm.me>

HID: rdmctmzt: add RDMCTMZT keyboard battery driver

This commit adds a HID driver for RDMCTMZT keyboards and their 2.4 GHz
dongles to poll battery status over the vendor raw-HID interface and report
wireless link status.

> diff --git a/drivers/hid/hid-rdmctmzt.c b/drivers/hid/hid-rdmctmzt.c
> new file mode 100644
> index 0000000000000..9966025b40587
> --- /dev/null
> +++ b/drivers/hid/hid-rdmctmzt.c
> @@ -0,0 +1,654 @@

[ ... ]

> +/* Send one command; its answer arrives in rdm_raw_event() */
> +static int rdm_send(struct rdm_device *rdm, u8 cmd)
> +{
> +	size_t raw_len =3D rdm->len + 1;
> +	int ret;
> +
> +	memset(rdm->buf, 0, raw_len);
> +	rdm->buf[0] =3D 0x00; /* unnumbered report ID */
> +	rdm->buf[1 + RDM_PREFIX_BYTE] =3D RDM_PREFIX;
> +	rdm->buf[1 + RDM_CMD_BYTE] =3D cmd;
> +	rdm->buf[1 + RDM_SIZE_BYTE] =3D rdm->len;
> +
> +	ret =3D hid_hw_output_report(rdm->hdev, rdm->buf, raw_len);
> +	/*
> +	 * -ESHUTDOWN from the transport (an endpoint flushed by a USB reset)
> +	 * is a lost poll; it must not end the polling like rdm->stopping does.
> +	 */
> +	if (ret =3D=3D -ESHUTDOWN)
> +		return -EIO;
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D raw_len)
> +		return -EIO;
> +
> +	return 0;
> +}

[ ... ]

> +/* The dongle's link byte, asked for now: an 0xd0 may have been missed */
> +static int rdm_dongle_linked(struct rdm_device *rdm, bool *linked)
> +{
> +	u8 reply[RDM_ANSWER_LEN];
> +	int ret;
> +
> +	ret =3D rdm_command(rdm, RDM_DONGLE_STATUS, reply);
> +	if (ret =3D=3D -ENODEV || ret =3D=3D -ESHUTDOWN)
> +		return ret;

[ ... ]

> +static void rdm_battery_work(struct work_struct *work)
> +{
> +	struct rdm_device *rdm =3D container_of(to_delayed_work(work),
> +					      struct rdm_device, work);
> +	enum usb_wireless_status wireless =3D rdm->wireless;
> +	bool linked =3D true, answered =3D false, got =3D false;
> +	bool changed, present;
> +	unsigned int delay;
> +	u8 capacity =3D 0;
> +	int status =3D 0;
> +
> +	if (rdm->dongle && rdm_dongle_linked(rdm, &linked))
> +		return;
> +
> +	if (linked && rdm_poll_keyboard(rdm, &linked, &answered, &got,
> +					&capacity, &status))
> +		return;

[Severity: Medium]
Can a runtime USB reset stop rdm->work permanently when usb_submit_urb()
returns -ENODEV?

During usb_reset_and_verify_device(), usbhid runs hid_pre_reset() and
hid_post_reset() without calling the driver's suspend or reset_resume
callbacks, and hub_port_init() temporarily places udev->state in
USB_STATE_DEFAULT and USB_STATE_ADDRESS.  If hid_hw_output_report() runs
during that window, usb_submit_urb() fails with -ENODEV (while
dev->state < USB_STATE_CONFIGURED), causing rdm_dongle_linked() or
rdm_poll_keyboard() to abort rdm_battery_work() before
queue_delayed_work().

Since rdm_stop_polling() sets rdm->stopping and cancels the work on unplug
and suspend, should rdm_dongle_linked() and rdm_poll_keyboard() only bail
out on -ESHUTDOWN (or should rdm_send() also map -ENODEV to -EIO)?

> +
> +	if (!got)
> +		hid_dbg(rdm->hdev, "no battery status (linked %d, answered %d)\n",
> +			linked, answered);
> +
> +	rdm->silent =3D answered ? 0 : min(rdm->silent + 1, RDM_MAX_FAILS);
> +	rdm->fails =3D got ? 0 : min(rdm->fails + 1, RDM_MAX_FAILS);
> +	if (!linked) {
> +		rdm->fails =3D RDM_MAX_FAILS;
> +		wireless =3D USB_WIRELESS_STATUS_DISCONNECTED;
> +	} else if (answered) {
> +		wireless =3D USB_WIRELESS_STATUS_CONNECTED;
> +	} else if (rdm->silent >=3D RDM_MAX_FAILS ||
> +		   rdm->wireless =3D=3D USB_WIRELESS_STATUS_NA) {
> +		wireless =3D USB_WIRELESS_STATUS_DISCONNECTED;
> +	}
> +
> +	/* Without a link the dongle reports when it comes back */
> +	if (got || !linked)
> +		delay =3D RDM_POLL_MS;
> +	else if (rdm->fails < RDM_MAX_FAILS)
> +		delay =3D RDM_RETRY_MS;
> +	else if (rdm->dongle && rdm->silent >=3D RDM_MAX_FAILS)
> +		delay =3D RDM_SEARCH_MS;
> +	else
> +		delay =3D RDM_POLL_MS;

[Severity: Medium]
Does a stale rdm->fails count after the keyboard reconnects delay the next
retry for RDM_POLL_MS (60 s) instead of RDM_RETRY_MS (5 s)?

While the keyboard is off or unlinked, rdm->fails reaches RDM_MAX_FAILS.
When the keyboard powers on, the dongle's 0xd0 report in rdm_raw_event()
queues rdm->work with delay 0 without resetting rdm->fails.  If that
immediate poll runs before the newly booted keyboard has measured its
battery, the keyboard answers RDM_CMD_START (answered =3D true) and refuses
RDM_CMD_BATTERY with 0x0f (got =3D false): rdm->silent is reset to 0 while
rdm->fails stays at RDM_MAX_FAILS, so the delay check skips both
RDM_RETRY_MS and RDM_SEARCH_MS and falls through to RDM_POLL_MS, leaving
the battery unregistered or marked not present for a full minute.  The same
60 s stall happens if one !linked poll sets rdm->fails =3D RDM_MAX_FAILS
while rdm->silent is 1, and the immediate poll on reconnect times out
(leaving rdm->silent at 2).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-rdmctmz=
t-v1-1-d45883e1fe33@pm.me?part=3D1
