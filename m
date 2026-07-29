Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1D469842
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345281; cv=none; b=c4pnVhImiYL+3wYXBTjXNk8DPm8tXgWBclroiNtVo4pygW5EGhhvYdlw1AH1yF+X5xvS1bm5Gm6ur0Zlq1IVUzN8gFNubdWcsZhQOkvNi6OUbV4/4J/yPK4TFcSqa2KZRDLBdYGR8WloVV6tKjOEB2gnGDJkvTzj0kQdisqz0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345281; c=relaxed/simple;
	bh=OnItz8rqWyY5PQYXTMaQEg0RNkhzhdTecftXAEh9v+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hsd6jQh1OuPTiqdriqZP2YEq6tZPuW9Y7w58Sjw70jStUeQb8RVB15ZX/d6xpX1MF4neenNLr1FcH8QjtmGouOSVFDzrs3Z1Q0rXuKzkZKK2WDthasUEQT1FkUcYcTBlxXhg0rZvAyG/IsMe18guMBkihxE1H68RAMYVK1cglh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFYwafuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFYwafuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3571F000E9;
	Wed, 29 Jul 2026 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345276;
	bh=QoqeWjMC+Sb+oPKp6qx4lxDXkNMFGfFxcuzULYZr1IA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFYwafuIhxu4boG/9y0nALxF7PYBlLRT4NSgEFJKqe/B66DotmuQQq5n9yTx4b2Ty
	 RuxucYlxl1GpEjwh5i5thGmA0gWHYpdklgbeP1lWf5whq/hg9s9ZKEdJOXQpJxxOvP
	 5pIliUuCwqKasF1F8P3Lw8adzrhEHsnpA0YK6gGyaZiwOyB5UDRwubFnpjXqngi80t
	 cv8YUews42xzHcwPYS8vXybqfFpyYF7jI0Lkhsjav9rleycuimaMkxryFoWRVcNyzb
	 1/F7ye6Zltgh62AOYVu/x3CyLT4S8Cp1QdmWWNezGImueg3WwekSWwx93zCLTLyRk+
	 JUev5K4cJns8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] HID: wiimote: fix uaf when hid events are
 handled during destroy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260729164928.1138468-5-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-5-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:14:36 +0000
Message-Id: <20260729171436.7E3571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch prevents essential hardware cleanup commands (such as tu=
rning off the rumble motor) from being sent to the controller during driver=
 unbind.
- [Medium] Skipping `wiimote_cmd_abort()` when the controller is exiting ca=
uses concurrent synchronous callers to block for a 1-second timeout, needle=
ssly delaying device teardown.
--

--- Patch [4]: [PATCH v3 4/4] HID: wiimote: fix uaf when hid events are han=
dled during destroy ---
commit f6099e564144794e28eb9ef912f3b349802b5cd8
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: fix uaf when hid events are handled during destroy

This patch aims to prevent use-after-free races during device teardown by
dropping new outgoing events in wiimote_queue() if the controller is in the
exiting state.

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index 31ee86affc553..067db8b8a56d1 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -92,6 +92,9 @@ static void wiimote_queue(struct wiimote_data *wdata, c=
onst __u8 *buffer,
>  	 */
> =20
>  	spin_lock_irqsave(&wdata->queue.lock, flags);
> +	/* Do not schedule work if controller is exiting */
> +	if ((wdata->state.flags & WIIPROTO_FLAG_EXITING))
> +		goto out_unlock;

[Severity: High]
Will this unconditionally drop all hardware cleanup commands during driver
unbind?

When wiimote_destroy() runs, it sets WIIPROTO_FLAG_EXITING before calling
wiimote_modules_unload(). The module remove handlers, such as
wiimod_rumble_remove(), attempt to gracefully shut down hardware features
like turning off the rumble motor via wiiproto_req_rumble().

Because this check now drops all packets when EXITING is set, doesn't this
prevent those cleanup commands from reaching the hardware, potentially leav=
ing
the rumble motor running indefinitely?

[Severity: Medium]
Does skipping the out_error label here introduce a teardown delay?

If a concurrent synchronous caller like wdata->init_worker is running when
wiimote_destroy() sets the EXITING flag, its packets will be dropped here.
By jumping directly to out_unlock, this bypasses wiimote_cmd_abort() at
the out_error label.

Without the abort to wake up waiters, won't wiimote_cmd_wait_noint() block
for its full 1-second timeout (HZ) while wiimote_destroy() waits in
cancel_work_sync(&wdata->init_worker)?

> =20
>  	memcpy(wdata->queue.outq[wdata->queue.head].data, buffer, count);
>  	wdata->queue.outq[wdata->queue.head].size =3D count;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729164928.1138=
468-1-rafael@rcpassos.me?part=3D4
