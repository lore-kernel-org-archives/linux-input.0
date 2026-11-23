Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456188;
	b=bJrbsUESG9WUCtBJazR1FqJJL4y0x68kL/ovPONFGP1RvYWdK3zglR6tlY8XatiFsDHr
	 wJqXJiP+Bwgh6aJGlpE1YotdgFN8FX6dC4QrSYm0aa5VNS3VE5SZYepQEL0rMckAg84iD
	 i0ueYeVHYS/objNdWdcqvmC0uR3vLlCPFGA4QkWL2A8ZH3u2Q55+HbVyXUBW7z0m4pSyb
	 h38sqyuwOX1Vy2jWqTi9w8cq/Toj6a87Cr1ai3sERaqeHbcptOq/dpmw9BKxlf0K7byoD
	 h1s1mXxZdr/nfz5U1eQrU8En0hZ4eF5WQqwNGJv9OjOwVEfKPoq50r91PBvZRBM2g/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456188;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DWCgD4jFh5MUzaGBbL+xu9bwZ84EW2hVajAfFpV5Au4=;
	b=pQ7pKeRTYwDDY2Cb4D0v0kiiIqs4NdxiqpBVcFI3fO1yg69L2WbMf4jzBZL82t3ft2/r
	 wOd58JA7SA8aMRjLtAGe8iDo4GCQE+9tsWkPxzTmtRJ0KvsO/lVkfwXK5QoEaN90GlyHW
	 ZKE0tI9JLSiF1IVWzWBfH6XqJnlFP6xeI/efVhSPdrwAHslzVE9ADWepWqOPk7WdHcBVS
	 TWS9r4zen8MBCY2aY30UK0g4oTMXi/qMvz5GSFvfMdHQtaEw2NB7z93PVzdHqpZretxNl
	 gA2Gm0IGRehYtuK2LmY3kk1cyzeTx44SrMclpnoInkQWauoR2PoITgpFAJbw4VSGrLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtGSCILc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E4606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtGSCILc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0EF1F000CA;
	Mon, 23 Nov 2026 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795456187;
	bh=DWCgD4jFh5MUzaGBbL+xu9bwZ84EW2hVajAfFpV5Au4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CtGSCILc5/QjoROrtoEmI08lnblzrvwSvuRHd9F5/lbzJNjNpoW2VpauHhlxRBOa2
	 ZrTwTWD8tuR8Ngd22DRnbN0f7JvFo1yn4e2AAPegDd6R6HlKqwuFTC2SqPiANEksxf
	 vOnM0fva103XjhMIFZdQCtZ5WTGAdRfk7begbG5VvUM3dyBbD/8Bizm4qC5b+84Xiz
	 qaPjf8Dc8tGod9xedJHWVgWfj+VQhqG1aBEm/ZEsfZSmJFDcImAV1KOlT10iUrYrXI
	 FXIygUR73KA3GYNjntMdHN+spK8lnR7ZZj86JTH59hxZqaW5H5jWa4Mg7a6o3VwPP6
	 Vs/zaLMansrKg==
Message-ID: <sashiko-outbox-229783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: rdmctmzt: add RDMCTMZT keyboard battery driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Erlend Jacobsen" <erlendjacobsen@pm.me>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261123-b4-rdmctmzt-v3-1-5ce2359df0aa@pm.me>
References: <20261123-b4-rdmctmzt-v3-1-5ce2359df0aa@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:49:46 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: rdmctmzt: split-lock rdm->link update in
  rdm_dongle_linked()
--

commit 6c486e725a5b70b38d74595b3572ef11e0c655ce
Author: Erlend Jacobsen <erlendjacobsen@pm.me>

HID: rdmctmzt: add RDMCTMZT keyboard battery driver

This commit adds a HID driver for RDMCTMZT keyboards and their 2.4 GHz
dongles to poll battery status over the vendor HID interface and report
wireless link status.

> diff --git a/drivers/hid/hid-rdmctmzt.c b/drivers/hid/hid-rdmctmzt.c
> new file mode 100644
> index 0000000000000..fc740c7a4e482
> --- /dev/null
> +++ b/drivers/hid/hid-rdmctmzt.c
[ ... ]
> +/* The dongle's link byte, asked for now: an 0xd0 may have been missed */
> +static int rdm_dongle_linked(struct rdm_device *rdm, bool *linked)
> +{
> +	u8 reply[RDM_ANSWER_LEN];
> +	int ret;
> +
> +	ret =3D rdm_command(rdm, RDM_DONGLE_STATUS, reply);
> +	if (ret =3D=3D -ESHUTDOWN)
> +		return ret;
> +
> +	scoped_guard(spinlock_irqsave, &rdm->lock) {
> +		if (!ret)
> +			rdm->link =3D reply[RDM_LINK_BYTE];
> +		*linked =3D rdm_link_may_be_up(rdm->link);
> +	}
> +	if (ret)
> +		hid_dbg(rdm->hdev, "no link status: %d\n", ret);
> +	return 0;
> +}
[ ... ]
> +static int rdm_raw_event(struct hid_device *hdev, struct hid_report *rep=
ort,
> +			 u8 *data, int size)
> +{
> +	struct rdm_device *rdm =3D hid_get_drvdata(hdev);
> +
> +	if (!rdm || size < RDM_ANSWER_LEN || data[RDM_PREFIX_BYTE] !=3D RDM_PRE=
FIX)
> +		return 0;
> +
> +	guard(spinlock_irqsave)(&rdm->lock);
> +	if (rdm->expect && data[RDM_CMD_BYTE] =3D=3D rdm->expect) {
> +		memcpy(rdm->answer, data, RDM_ANSWER_LEN);
> +		rdm->expect =3D 0;
> +		complete(&rdm->done);
> +	} else if (data[RDM_CMD_BYTE] =3D=3D RDM_DONGLE_STATUS && rdm->dongle &&
> +		   data[RDM_LINK_BYTE] !=3D rdm->link) {
> +		/* The link to the keyboard came or went: ask now */
> +		rdm->link =3D data[RDM_LINK_BYTE];
> +		if (rdm->expect && !rdm_link_may_be_up(rdm->link)) {
> +			rdm->expect =3D 0;
> +			complete(&rdm->done);
> +		}
> +		if (!rdm->stopping)
> +			mod_delayed_work(system_dfl_wq, &rdm->work, 0);
> +	}
> +	return 0;
> +}

[Severity: Medium]
Can rdm_dongle_linked() overwrite a newer rdm->link update or cause
rdm_raw_event() to drop an unsolicited link-change event?

When rdm_dongle_linked() requests RDM_DONGLE_STATUS, rdm_raw_event() takes
the rdm->expect branch and completes rdm->done without updating rdm->link.
If the dongle sends an unsolicited RDM_DONGLE_STATUS report before the
worker updates rdm->link in rdm_dongle_linked(), the two updates race:

kworker                           <hardirq>
rdm_dongle_linked()
  rdm_command(RDM_DONGLE_STATUS)
    rdm->expect =3D 0xd0
                                  rdm_raw_event() [reply: link =3D 0x02]
                                    memcpy(rdm->answer, data, ...)
                                    rdm->expect =3D 0
                                    complete(&rdm->done)
                                  rdm_raw_event() [event: link =3D 0x00]
                                    data[13] !=3D rdm->link (0x00 =3D=3D 0x=
00)
                                    /* reconnect event ignored */
  rdm->link =3D reply[13] (0x02)
  *linked =3D false                 <-- stale link state kept

Because rdm->link still held 0x00 when the unsolicited reconnect report
arrived, rdm_raw_event() did not reschedule rdm->work, and
rdm_dongle_linked() then stores the older RDM_LINK_NONE (0x02) reply,
leaving the reconnected keyboard unpolled for RDM_POLL_MS (60 s).  In the
opposite transition (reply 0x00 followed by unsolicited 0x02),
rdm_dongle_linked() overwrites the newer 0x02 in rdm->link with the stale
0x00 from reply[].

Updating rdm->link inside rdm_raw_event() whenever a valid
RDM_DONGLE_STATUS report arrives (and having rdm_dongle_linked() only read
rdm->link under rdm->lock) would avoid this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-rdmctmz=
t-v3-1-5ce2359df0aa@pm.me?part=3D1
