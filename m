Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177651;
	b=XCpurHPuhi6KrUaZq+qh5NOJtuNiwMwn++RJUx3qfBBBCux4NS8kZ/b9MPOYB+zsIlv8
	 BZpRCU8g6D/RJ3bKEe42On00RRmsLyYwlkmYagJ1YVaryQmSLnGSHdw1jaoTkvzaVd+H7
	 bBjaYU/wqXOu7K+9zl4B1V/mkHmt2RYpaFVPjjjWariTzTe8iQzp+wRhI4cGzOeH6pzAN
	 OzMRg2cekIJzjxQ8xsEBv+BfLNTzywTjgO+9uqzfx4cofxYex2yd41/TArBnsRTdBSrx8
	 ItqvoAv+qBjs/ZlkySeXU1xhEkvERyK7syGbMZ09VLnnBpEdScZ1vsJSDyN/B9tuYYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hNVW82+nhA+Yw0GsHJrb3CYDP6KnCnMGsWmuyGFIouU=;
	b=J/e2QZxzyIbXcADa9OhFM7woBguk39A+ixkfEZNnOVKay6AlqGCvyJ3amRnm14GoTFzI
	 eDdkh+Kh84s7Pbp2njd/rKRHCurp+ZEMU3y3YXkd95FU2QvBp7SowtL7POen+voHnWzHs
	 /yj3eP9tGr7wzrRsbkygmkt+v8ExTkegpRHSOlVJSqUwBqbwAtD8svvjGO8Vew8YjztLv
	 T/4I2A70wgF3fO1O6I2P4nCPexbhpyR80Q8TsXTUOUS+NdZawKSWx82jaespZ6TUQQNc8
	 sPCr2tneOTtLYsGL6hfhQXUOs+2BrweThJXWIsXY+X3kF0yymaWqP/Vaeq3gNmZO8hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCDlLIpf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6837606A320
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCDlLIpf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102F51F0089F;
	Sun,  8 Nov 2026 22:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794177650;
	bh=hNVW82+nhA+Yw0GsHJrb3CYDP6KnCnMGsWmuyGFIouU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GCDlLIpfCBLipKZLkbyY0fnkz2BJzaMWkN7j5DnIlSJWLikALG/ddBl0XtRxLJ0hU
	 trtXHdPQnlKdW4wvNqPtNT64JGlcFzN4ONtbOhY16iEsWHT9ktbG3oOuT+WzVBfo1E
	 DQYarMVAl+Tev9Wy0LgdQRLi8mXNT3vElaqSlfXktFnGt4EU/A84y84o2gmiBQmlzA
	 0LCnuR61RseUkC0TydzNPEP1KYKCJW0DKQcJk99lvXfNVovKu/P/IgJzKQDpfMnqM0
	 lSYIkb8pEyW02To0ZbIsgXtDqV+UXbAxRfP5Fg64RMmPi1SyYw00wPJQ3pQRTxMhWT
	 mFRGf7/xXJlzA==
Message-ID: <sashiko-outbox-204122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: nintendo-switch2-usb: check URB before use and
 reset state on free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Noah Weinberger" <NoahWeinberger2003@proton.me>
Cc: =?utf-8?b?bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3Jn?= <linux-input@vger.kernel.org>, dmitry.torokhov@gmail.com
In-Reply-To: <HP2LhXZGIipAd2XxKx7dDh8q3SopkJRAxo8IQkuyMxTlR0YfO3rS3CT9NqUkg3ispO72yfhC7Oa4MoZdXgo6lNIEjC1WvQFlrKreFzCnmFM=@proton.me>
References: <HP2LhXZGIipAd2XxKx7dDh8q3SopkJRAxo8IQkuyMxTlR0YfO3rS3CT9NqUkg3ispO72yfhC7Oa4MoZdXgo6lNIEjC1WvQFlrKreFzCnmFM=@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 22:40:49 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] HID: nintendo-switch2-usb: TOCTOU race in
  switch2_usb_message_in_work()
- [Low] HID: nintendo-switch2-usb: misleading indentation in
  switch2_usb_message_in_work()
- [Low] HID: nintendo-switch2-usb: missing Fixes and Signed-off-by
  trailers in changelog
--

commit ad9c19b8222174b67d5185145f7040b445c19cb7
Author: Noah Weinberger <NoahWeinberger2003@proton.me>

> HID: nintendo-switch2-usb: check URB before use and reset state on free
>
> Hello,
>
> Proposed-fix limitation: the checks below do not establish URB or
> interface lifetime across the pointer check, lock release, and subsequent
> use. These proposed changes may therefore not resolve the teardown race
> or the late-work use-after-free described below. Please review the
> locking and work/interface lifetime before treating this as a complete
> fix; this is an incomplete proposal for maintainer review, not a
> validated resolution.
>
> switch2_bulk_in() calls schedule_work() after dropping bulk_in_lock, so
> the work can be queued after switch2_usb_free_in_urbs() has returned
> from cancel_work_sync(). free_in_urbs() NULLs bulk_in[i].urb but never
> resets bulk_in[i].state, so the late work still sees NS2_URB_IN and
> dereferences urb->urb->transfer_buffer / urb->urb->actual_length on a
> NULL pointer - the existing !urb->urb check sits after those
> dereferences:
>
>     if (urb->state !=3D NS2_URB_IN)
>             continue;
>     spin_unlock_irqrestore(...);
>     if (ns2_usb->cfg.parent) {
>             err =3D switch2_receive_command(..., urb->urb->transfer_buffe=
r,
>                                     urb->urb->actual_length);   <-- NULL =
deref
>     ...
>     if (!urb->urb)   <-- too late
>
> A malicious or misbehaving controller (or an unplug racing active
> traffic) wins a narrow window to trigger this; the outcome is an oops
> in workqueue context, and a use-after-free if the work runs after the
> interface data is released. The patch re-checks urb->urb under the lock
> before using it and resets the URB state when freeing, mirroring what
> switch2_usb_shutdown() already does.
>
> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670b=
d (v7.4-rc1, 2026-11-07), drivers/hid/hid-nintendo-switch2-usb.c:51-121 (co=
mpletion), 209-240 (free path), 288-316 (work).
> New driver merged in this window (zero prior field exposure).
>
> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07);=
 every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
> conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.
>
> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>

[Severity: Low]
The commit message is missing a Signed-off-by: trailer, includes conversati=
onal
report boilerplate in the changelog body, and should include:

  Fixes: 9417132df63e ("HID: nintendo: Add preliminary Switch 2 controller =
driver")

> diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nin=
tendo-switch2-usb.c
> index 8b3b6841035d0..c103cedc181ff 100644
> --- a/drivers/hid/hid-nintendo-switch2-usb.c
> +++ b/drivers/hid/hid-nintendo-switch2-usb.c

[ ... ]

> @@ -298,6 +299,11 @@ static void switch2_usb_message_in_work(struct work_=
struct *work)
>  		urb =3D &ns2_usb->bulk_in[i];
>  		if (urb->state !=3D NS2_URB_IN)
>  			continue;
> +			/* urb->urb is NULLed by switch2_usb_free_in_urbs() while we
> +			 * may still run; re-check under the lock before using it.
> +			 */
> +			if (!urb->urb)
> +				continue;

[Severity: Low]
Does this over-indent the comment and if (!urb->urb) check by one tab level
after the unbraced continue?  This triggers a -Wmisleading-indentation
compiler warning (and a build failure with CONFIG_WERROR=3Dy).

>  		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> =20
>  		if (ns2_usb->cfg.parent) {

[Severity: High]
Can switch2_usb_free_in_urbs() still clear and free urb->urb right after
switch2_usb_message_in_work() drops bulk_in_lock here?

switch2_bulk_in() calls schedule_work(&ns2_usb->message_in_work) after
releasing bulk_in_lock, and switch2_usb_free_in_urbs() calls
cancel_work_sync() before killing the URBs, so message_in_work can still be
scheduled and run concurrently with teardown:

CPU0                                  CPU1 (kworker)
switch2_bulk_in()
  lock(&ns2_usb->bulk_in_lock)
  urb->state =3D NS2_URB_IN
  unlock(&ns2_usb->bulk_in_lock)

switch2_usb_free_in_urbs()
  ns2_usb->shutdown =3D true
  cancel_work_sync()
  usb_kill_anchored_urbs()

switch2_bulk_in() (resumes)
  schedule_work(&message_in_work)
                                      switch2_usb_message_in_work()
                                        lock(&ns2_usb->bulk_in_lock)
                                        if (!urb->urb)
                                        unlock(&ns2_usb->bulk_in_lock)
  lock(&ns2_usb->bulk_in_lock)
  ns2_usb->bulk_in[i].urb =3D NULL
  unlock(&ns2_usb->bulk_in_lock)
  usb_free_coherent(...)
  usb_free_urb(urb)
                                        switch2_receive_command(...,
                                          urb->urb->transfer_buffer, ...)
                                          <-- NULL dereference / UAF

If message_in_work runs after switch2_usb_disconnect() or the
switch2_usb_probe() error path frees ns2_usb, it also dereferences freed
ns2_usb memory, and when re-acquiring bulk_in_lock at the end of the loop it
does not check ns2_usb->shutdown before resubmitting the URB.  Killing the
URBs before cancel_work_sync() (or moving schedule_work() inside bulk_in_lo=
ck
while checking ns2_usb->shutdown) would prevent new work from being queued
after cancel_work_sync() completes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/HP2LhXZGIipAd2XxKx7=
dDh8q3SopkJRAxo8IQkuyMxTlR0YfO3rS3CT9NqUkg3ispO72yfhC7Oa4MoZdXgo6lNIEjC1WvQ=
FlrKreFzCnmFM=3D@proton.me?part=3D1
