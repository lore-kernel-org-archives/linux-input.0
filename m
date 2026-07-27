Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583E927732
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130523; cv=none; b=XaIYgA6yqmrPLwxtC0DNqYq3dG/RTb/0kwxyOFs60pjlpA+dloqOk1sOocB5F1CdF9uIEfEJzfzUdS6QLtz/lBw6qcypPhM9FSjC7w+Nn71Pr2gXlB+7eCq3N0pYupgvh35Evmiy+9RPSWvZzN5yPC70dL+9CcfcWJ75n2gWUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130523; c=relaxed/simple;
	bh=WCdJDZz3sfFjhBINU/aHEJdz+CNHwjMrVtXgkibacFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pwVAN57GbxMKKCBsoox07e02aq4+V2ro2yhLKvIxtwXOViFUyhABHzFo+Z9U2Ayuxm66wJI2HxMbaRI+NvG7fqMa1289v+iPlhtpSaBGbA4c6m8BijGdqOgWJAjCZe+WcpCCxRZnZeDLixO9ENdb0y1Ial9WDl3s0iBsL0rHHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1JHMDe5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1JHMDe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CA01F000E9;
	Mon, 27 Jul 2026 05:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785130521;
	bh=FXYGw4r7oo/Qo+q3l78S0n8KuNcFTY3/E6DNFBZYUL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1JHMDe5ZE79Pz0Ixw4qgSgQTrKZ+k/0IR47QxXexnkmGM9/DD2eSOMCWAmzBrluV
	 axVZWtriJm1dZ7CaH9aG458sQ3ng64N+M8yzgbgLSWI8ERogbHzNQ0MvbLIY2hJ1RA
	 Pt07nsC2EarvRSIZTJMYNVvTtu4OlBgMouQmeU99TtNTBK2SCNo7tAMZyr5+2RKKRd
	 S7tvNPR2GX7w6o2LztBq+4jJmsGalqqahZVC3WnDkOeK3CvkH3y8PiNDlkggZANQCn
	 wI58drsCVUwnKn5Vh8UfTRrV7Dobk1QoiCh99Ddx5mxM2HOj8Nl9QbTIH5hBQwXbbZ
	 0fOhhMc8DlSnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] Input: psmouse - use guard() for resource
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260727050803.1269941-4-dmitry.torokhov@gmail.com>
References: <20260727050803.1269941-1-dmitry.torokhov@gmail.com>
 <20260727050803.1269941-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 05:35:21 +0000
Message-Id: <20260727053521.A5CA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unbounded array write (buffer overflow) in `psmouse_receive_by=
te` due to unhandled `protocol_handler =3D NULL`.
--

--- Patch [4]: [PATCH 4/4] Input: psmouse - use guard() for resource manage=
ment ---
commit 7e27c0c560cf8dcd06bedf52a084dc88e9bf3ed9
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: psmouse - use guard() for resource management

Replace manual serialization with guard(mutex) and guard(serio_pause_rx)
where appropriate. This eliminates the need for explicit goto-based error
paths.

> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psm=
ouse-base.c
> index a9a110f2c860a..58b9b5dd7f085 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c

[ ... ]

> @@ -1461,7 +1456,7 @@ static void psmouse_disconnect(struct serio *serio)
> =20
>  	disable_work_sync(&psmouse->resync_work);
> =20
> -	mutex_lock(&psmouse_mutex);
> +	guard(mutex)(&psmouse_mutex);
> =20
>  	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
> =20

[Severity: Critical]
With the changes in the first patch of this series, psmouse_disconnect() se=
ts
psmouse->state =3D PSMOUSE_CMD_MODE and sets psmouse->protocol_handler =3D =
NULL
before calling the vendor disconnect handler.

If a noisy or malicious PS/2 device (e.g., emulated by a BMC or USB adapter)
spams bytes during this driver unbind window, psmouse_receive_byte() will
place them into psmouse->packet[psmouse->pktcnt++] and call
psmouse_handle_byte().

Because protocol_handler is NULL, psmouse_handle_byte() immediately returns=
 0:

drivers/input/mouse/psmouse-base.c:psmouse_handle_byte() {
    ...
	/* protocol_handler is NULL when device is being disconnected */
	if (unlikely(!psmouse->protocol_handler))
		return 0;
    ...
}

Since pktcnt is never reset here, could this regression allow pktcnt to
continuously increment and overflow the 8-byte psmouse->packet[] array on
subsequent bytes, corrupting struct psmouse fields and adjacent memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727050803.1269=
941-1-dmitry.torokhov@gmail.com?part=3D4
