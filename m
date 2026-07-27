Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EED727732
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130690; cv=none; b=EMCYkoBwfXGTphZ18JV2mTy1q4kMWdzLWXzwupb3aBw+4kjaSLp60PMKzGuyR0py56m8BisRzetOLToKthMnx/fROVkqbaEBXD+gIdozq52/6sVfTOGYw7dmTKvRZFzNR/llZTV0LIri/L2n3LnQGp3fC9mSAVLlXu82lH9P5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130690; c=relaxed/simple;
	bh=PA9r2o7cqlGLA8r1lF2ewEBKdVdq5i05b8tk/6bNK/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ef/XYlIGGuk3eaKIrA1lPFU8PhBEbOAdugLpPA+sZpku2QHXUUCLuIGmJrfOARHhv2t07bTec+T6v1IaiiuvdpUIxGAe3RVDUTGpmKrpLe9gY676xzl3mB9iApqKDbwA12cNO4/gPXp8xPae7v9EmQoGz2/pO1/KssakgiHBA8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSeil4lW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSeil4lW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030801F000E9;
	Mon, 27 Jul 2026 05:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785130689;
	bh=n/SQbr7nzqaZsljQ2WLknyoRi5ywzMdVJWnKln1br5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RSeil4lW3b8uHqmIJJSUvRYuojkWfAELdcMcQCbMvNnkQTOTO/OQO63oaXaP/rcIi
	 6fT2cS+iocVpmtEZ0/D/YoLP8LQhUPe7Ircibnpz7GTG67z85DRxvww8aX2ia1ZwQS
	 9AIB/jrsjl3dfr4+E0A0BhOnp/DlheNfNXEkvx/FDtzU/BU28m5Naqy9oO25OTSUMj
	 N8aLaKHU2iKzYvhzIZ8ZcYzEKU7/uabqFJsfxnGbA4JLGtLPtTshFO1dU9BsxNG+dV
	 aDP3TF6gvLaY1dp8vnaIp63RdEXJy5YuiwdZ1nNK+WNnPvxiatu7muBaZfDu7Z8vXg
	 LDvXoifDJ9OJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] Input: psmouse - fix use-after-free during protocol
 disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260727050803.1269941-1-dmitry.torokhov@gmail.com>
References: <20260727050803.1269941-1-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 05:38:08 +0000
Message-Id: <20260727053809.030801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces an unbounded increment of `psmouse->pktcnt` l=
eading to a heap buffer overflow in the `psmouse->packet` array when stray =
bytes are received during protocol disconnect.
--

--- Patch [1]: [PATCH 1/4] Input: psmouse - fix use-after-free during proto=
col disconnect ---
commit 6906d0fc401466f9489746b3c6e47ede12a56c49
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: psmouse - fix use-after-free during protocol disconnect

This commit attempts to fix a use-after-free by explicitly setting
psmouse->protocol_handler to NULL inside a serio_pause_rx scoped_guard.
It also updates psmouse_handle_byte() to drop incoming bytes when the
handler is NULL.

> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psm=
ouse-base.c
> index 6ab5f1d96eaea..916a14b9b6a7d 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -267,7 +267,13 @@ void psmouse_set_state(struct psmouse *psmouse, enum=
 psmouse_state new_state)
>   */
>  static int psmouse_handle_byte(struct psmouse *psmouse)
>  {
> -	psmouse_ret_t rc =3D psmouse->protocol_handler(psmouse);
> +	psmouse_ret_t rc;
> +
> +	/* protocol_handler is NULL when device is being disconnected */
> +	if (unlikely(!psmouse->protocol_handler))
> +		return 0;
> +

[Severity: High]
Does this early return cause an out-of-bounds write in psmouse_receive_byte=
()?

By returning 0 here, we completely bypass the switch block below which is
responsible for resetting psmouse->pktcnt.

When stray bytes arrive during the disconnect window, psmouse_receive_byte()
will append them to the packet buffer and increment the counter:

psmouse_receive_byte() {
    ...
    psmouse->packet[psmouse->pktcnt++] =3D data;
    ...
    psmouse_handle_byte(psmouse);
}

If psmouse_handle_byte() keeps returning 0 without resetting pktcnt, won't
pktcnt grow monotonically and eventually overflow the 8-byte packet array?

> +	rc =3D psmouse->protocol_handler(psmouse);
> =20
>  	switch (rc) {
>  	case PSMOUSE_BAD_DATA:

[ ... ]

> @@ -1466,6 +1472,9 @@ static void psmouse_disconnect(struct serio *serio)
>  		psmouse_deactivate(parent);
>  	}
> =20
> +	scoped_guard(serio_pause_rx, serio)
> +		psmouse->protocol_handler =3D NULL;
> +
>  	if (psmouse->disconnect)
>  		psmouse->disconnect(psmouse);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727050803.1269=
941-1-dmitry.torokhov@gmail.com?part=3D1
