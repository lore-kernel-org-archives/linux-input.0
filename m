Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501545;
	b=ha2plkjjPVx7QgG8Y/TY/DycN2DbtC/0tsZ2X9QpTH3OjZqZv0AsZAxyJzJ83pQwYBVC
	 DAhSPr0H9mUOnic88/d7G7EcAcDx7vSAmNlcmai6vv8Vi8o9jk2zFLXmL4hP0GQVyoA+M
	 5jGCtrf1a2PlZU6pDztEy13JnHGz45ukqVsek44Us+JUXZqW6W/pGr/5e3RkJyJEqSHAO
	 X2ZK68zU7MFqLQCV+SoNZn+iZU0jKBjFH099r2WrYfW6IPEJzNCDZNBOBctEsJ1fEqNLR
	 TO1XHx8iY2mRG4Y/p77prNR4Uxgoxz8zq0zL9CT7lu9SkhKdpRKp1EoAOX+BJUVWmAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501545;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VP5JjXljWzKd6QfGSev6wfp3wrrT1nsssvIBG4k5xXE=;
	b=eZTfficUa2t0EybBQ6RzefI5PHA266xox8S8xUOxXnYipyOUQwLCko7pVx3U22hbwtRn
	 1qLJgoSB6bvihMWQGrHwq7UtfPOFhfnnwh4Dwzb8F2KmLg3L1lvcQvTp09sIma+c5AjRB
	 2aQBGm/aBdHQ1PfD3MzEqV1LZ69NmEHf6rwd9mDNoE779aLARnNUIWpCo+/mzXDjNcV1U
	 X76zPYgodWy3Ah/6m8we4bPiSfKRi6qfR6nRe1Qf214SYOjBr/WWERuHbhbgBst8EttMx
	 o1fXpVpCjRYOaQixFxL/KRKNW8NeJu1cMBfjeVMlnpmP3LYcdDz4n6cdShOEHjfapnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgH2uwDT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC6606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgH2uwDT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0074F1F000D0;
	Tue, 24 Nov 2026 06:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795501545;
	bh=VP5JjXljWzKd6QfGSev6wfp3wrrT1nsssvIBG4k5xXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jgH2uwDT7LvZHYIBHgQPRU8b60nKt50pzXVZ1dAQ/JaYkHE6CUceVyaOyyI5t0hle
	 B42nvlcz1/POwkn3SeMRLovjqtDpjheMXGzChmjEzORuZkFNS8JlFVND1ZwySbSn3d
	 xVlFKlm05jX+aMl2lhDuOmFpVV13UgzshPo1no2/YHmmCzU29va8zHb2bn0WPAnXuS
	 7dXBSN2aj6HciJrkbVZRFXk3qycZKToOyPwgNooe98D16l1RcIaaahsCcHWHFjmT8O
	 i8RDnOvqCbV2vD1GeJMxYgFQm7Fbd43N8mYJKn4kk/sp09caxdukau9prNpfLACpno
	 4clKdRSNpzYow==
Message-ID: <sashiko-outbox-230592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: rdmctmzt: add RDMCTMZT keyboard battery driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Erlend Jacobsen" <erlendjacobsen@pm.me>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261124-b4-rdmctmzt-v4-1-9cb23d1ad876@pm.me>
References: <20261124-b4-rdmctmzt-v4-1-9cb23d1ad876@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:25:44 +0000
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
- [Medium] HID: rdmctmzt: failed 0xd0 poll with RDM_LINK_UNKNOWN treated
  as link down
--

commit 10ff773cbdbe0a54663e148f524ced35f821f2d3
Author: Erlend Jacobsen <erlendjacobsen@pm.me>

HID: rdmctmzt: add RDMCTMZT keyboard battery driver

This commit adds a HID driver for RDMCTMZT keyboards and their 2.4 GHz
dongles to poll battery status over their vendor raw-HID interface and
report the dongle's wireless link status.

> diff --git a/drivers/hid/hid-rdmctmzt.c b/drivers/hid/hid-rdmctmzt.c
> new file mode 100644
> index 0000000000000..391d7c934f5b4
> --- /dev/null
> +++ b/drivers/hid/hid-rdmctmzt.c
> @@ -0,0 +1,664 @@

[ ... ]

> +/* Only 0x02 rules out a link; the keyboard's answers decide the rest */
> +static bool rdm_link_may_be_up(u8 link)
> +{
> +	return link !=3D RDM_LINK_NONE && link !=3D RDM_LINK_UNKNOWN;
> +}

[ ... ]

> +/* The dongle's link byte, asked for now: an 0xd0 may have been missed */
> +static int rdm_dongle_linked(struct rdm_device *rdm, bool *linked)
> +{
> +	u8 reply[RDM_ANSWER_LEN];
> +	int ret;
> +
> +	/* rdm_raw_event() stores the link byte of the reply too */
> +	ret =3D rdm_command(rdm, RDM_DONGLE_STATUS, reply);
> +	if (ret =3D=3D -ESHUTDOWN)
> +		return ret;
> +	if (ret)
> +		hid_dbg(rdm->hdev, "no link status: %d\n", ret);
> +
> +	scoped_guard(spinlock_irqsave, &rdm->lock) {
> +		*linked =3D rdm_link_may_be_up(rdm->link);
> +	}
> +	return 0;
> +}

[Severity: Medium]
If rdm_command() fails or times out while rdm->link is still
RDM_LINK_UNKNOWN (at initial probe or after rdm_reset_resume()), does
rdm_dongle_linked() treat the lost poll as an active RDM_LINK_NONE report
from the dongle?

Because rdm_link_may_be_up() returns false for RDM_LINK_UNKNOWN,
rdm_battery_work() takes the !linked path: after a reset_resume, a single
lost RDM_DONGLE_STATUS query immediately marks a present battery as not
present and sets wireless_status to disconnected, and at both probe and
reset_resume it delays the next poll for RDM_POLL_MS (60 s) instead of
retrying after RDM_RETRY_MS (5 s).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-b4-rdmctmz=
t-v4-1-9cb23d1ad876@pm.me?part=3D1
