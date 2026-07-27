Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA42DCF45
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130376; cv=none; b=cVOhIj09Cp2LNqGhJWLSPpiYGAv6mJjq1AgtoDUBWN7ltAhv/Eg3eBylf4UL2Z3kvOY0GMb/wN773OjnSnHxvwvy774TcpvJy/ewYnAhOuCNIt3Yx9ef8wK8Rgi9bFApr8O132YGqeTcLeDS0/2xEPDvZlZIjMGBgf1YkJT3qUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130376; c=relaxed/simple;
	bh=c4R7zzJC/g39EpGisDL6q5ylTCH8y8z/nTuK5nf6upA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r7JCeBx2Vuhnk7YI5UG6J32iM2kt5w6JiALBJFMT6egzGbO0KwT20+VQzrgAc9uX6vRHSrMTqhEOA+QnpV3yCwrwO9lHLzJjWiAzQ4HEkyn3QUkgkP47Y9UUXyw8GMKg3OCkoiQS1G7Vge+EX7Mboan7Trnsp42fCIqTJ+6/g0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuBQl0Ih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuBQl0Ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6B71F000E9;
	Mon, 27 Jul 2026 05:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785130375;
	bh=wSMwiCafobAENZSJXX4O8R3yVBvL561paOFEdxAu8UU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HuBQl0IhjHWuTCYydfz/rnUSAwaBoLySIx00+MREjO04UMduyWocI2YfzT2YzvmZb
	 x7IVPKG7mxKJM2HsVnj6Pl8I5fXQrBJs1HdZo1M60x15lVA8zD5LF4My35uuSJzT7R
	 UPEYGb+ihJbaxX4CaMa2/0Y7fYXt8gr0OC4ymPKrgc8xO8MFfIDzzoqPuOOl+7zl+d
	 P2wx6FOvzerbKLYtNnSupRxI18Rz30eu9FrLUankno4htI0wikGrW9B5sUwFQOR90Q
	 xqkOBoi+3eWfDAAd8NNe3tEf+zhx19h2tm9hA+qlBRRsxJ4YU8jUHeDAx1ANDeD3dx
	 rC+9jfITfyz2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] Input: psmouse - clean up locking around
 disable_work_sync()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260727050803.1269941-2-dmitry.torokhov@gmail.com>
References: <20260727050803.1269941-1-dmitry.torokhov@gmail.com>
 <20260727050803.1269941-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 05:32:54 +0000
Message-Id: <20260727053254.EE6B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving disable_work_sync() to the top of psmouse_disconnect() brea=
ks the early-abort synchronization in psmouse_resync(), causing delays and =
queuing stray reconnect events.
--

--- Patch [2]: [PATCH 2/4] Input: psmouse - clean up locking around disable=
_work_sync() ---
commit f2e43a3d4ae9250b89f797899728eb8d61c0ef21
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: psmouse - clean up locking around disable_work_sync()
   =20
In the past, psmouse_disconnect() used cancel_work_sync(). Because
cancel_work_sync() must be called with the psmouse_mutex dropped, and we
needed to prevent psmouse_receive_byte() from re-queueing the work
behind our back, the code transitioned the device to PSMOUSE_CMD_MODE
while holding the mutex, then dropped the mutex and cancelled the work.

When cancel_work_sync() was replaced with disable_work_sync() in this
path, the mutex juggling remained. However, disable_work_sync()
inherently prevents the work from being executed or re-queued, making
the mutex juggling unnecessary.

Clean this up by moving disable_work_sync() to the very top of
psmouse_disconnect(), before we acquire psmouse_mutex.

> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psm=
ouse-base.c
> index 916a14b9b6a7d..3fcc1d293c313 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -1458,15 +1458,12 @@ static void psmouse_disconnect(struct serio *seri=
o)
>  	struct psmouse *psmouse =3D psmouse_from_serio(serio);
>  	struct psmouse *parent =3D NULL;
> =20
> +	disable_work_sync(&psmouse->resync_work);
> +
>  	mutex_lock(&psmouse_mutex);
> =20
>  	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
> =20
> -	/* make sure we don't have a resync in progress */
> -	mutex_unlock(&psmouse_mutex);
> -	disable_work_sync(&psmouse->resync_work);
> -	mutex_lock(&psmouse_mutex);
> -

[Severity: High]
By moving disable_work_sync() before psmouse_set_state(..., PSMOUSE_CMD_MOD=
E),
does this break the early-abort synchronization in psmouse_resync()?

If a hardware resync event races with driver unbind, disable_work_sync() wi=
ll
block waiting for the already-running psmouse_resync() worker:

drivers/input/mouse/psmouse-base.c:psmouse_resync() {
	mutex_lock(&psmouse_mutex);

	if (psmouse->state !=3D PSMOUSE_RESYNCING)
		goto out;

Since psmouse_disconnect() hasn't updated the state yet, psmouse_resync() w=
ill
observe PSMOUSE_RESYNCING, proceed to poll the disconnected hardware (causi=
ng
delays), and upon failure, call serio_reconnect():

	if (failed) {
		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
		psmouse_info(psmouse,
			     "resync failed, issuing reconnect request\n");
		serio_reconnect(serio);
	}

Could this queued reconnect event cause the driver to spontaneously re-bind
after the disconnect finishes?

>  	if (serio->parent && serio->id.type =3D=3D SERIO_PS_PSTHRU) {
>  		parent =3D psmouse_from_serio(serio->parent);
>  		psmouse_deactivate(parent);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727050803.1269=
941-1-dmitry.torokhov@gmail.com?part=3D2
