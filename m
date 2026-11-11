Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368228;
	b=3fvkNld0vnuL3UM8BlPpb4I7WkcqM7Gu+0KLWBtmcckQ4ylrqpJ0myY1Cp8q53VwYHpy
	 cwF/lX0ymWm09aum0B8oHd0JUJBEV6RCWFutj2OHl62EO0vQ7Z7nYTrfBo4aEc9ZYx63r
	 sRoG6McpdIFctukNg+ynrfTzyKrVaQgOY7Aq0LzFvxBxp/wwZi8YvqkdZqRj47pRtYN6u
	 PGS82XFp6gA+j5HIOLJEnLhLfCv3n23s08t9QriAdh56QkoRsp97D79xOhMuOpsHudwxh
	 oVYuHhJAvCgumtt2cMQSstPqfufkSG4JNFWvi4kKO0GLIwO3bYvKcxrFvyWE2u0/EQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KRL7sdtHzokVFmkZAY8mIAAGveVY4rhuvkgFHmlqv+E=;
	b=kdnqrRgrWxxb9djqjY32Q8gwXRW6Ii1nloZyrXcmklQwYEpDa2PonUEStSelnmAitOWG
	 or6am//ZJRQGi8e38LV957aBVUOUTGkAstyzn0jgXaJcx/RL+UIi8wf5jJgLLkOM1OPHx
	 4BYqxDUICOQj6/rbLROkaCmSe7DTlsUcN1V9ox5r8DSIzex8SvlQKWrSwsEUVYCE505U5
	 djNf26Vh3EWX2KuHgHBw9gJ0FI3UXe2nQHZUdh6ToWr2xAAeBNyZ/PpNqyAGrJsSdkeHr
	 Qy4lUiqzH6nzfGcjZhSTjwPCtu6fMJsoSHU+Jmtq2YAwzkJcqrZt5smiDfhRkQnXTcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=girnfAPo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA5606A31C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=girnfAPo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB6E1F0089F;
	Wed, 11 Nov 2026 03:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368227;
	bh=KRL7sdtHzokVFmkZAY8mIAAGveVY4rhuvkgFHmlqv+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=girnfAPoV5X58bABt/FbxR2Y9pO2eSLtkQJppHCAPGOrRkE2UJX44e1ZCxcs1HRZl
	 6IiaGHXueJ8PD0AYhiRtOthJxfnl1Oqw9Onhx2Wqc14h9g/B//TW89HI6jsdBTdDj2
	 qmAJDtIXQsLVx9hgZNM8gd2/ghnEQRTXx16KaieH7axQ12lzk8JkfrKvsEcQ5nLHfu
	 9L6cD74D9Gg65YN4BU7mzmI/7obtS32gOrQS9D9dWjyKBhUy6Q1xTCpLYMbm7QxATu
	 PrEil+9Lz8I6Q+0g/RwRKCvOeZ1+4H6RVQm1pp5Q4WWw0xcaautlSzaFbm2QWG2X3U
	 07CXeLebS+CyQ==
Message-ID: <sashiko-outbox-208206@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: nintendo-switch2-usb: Fix potential deadlock
 on teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261111032125.2888320-1-vi@endrift.com>
References: <20261111032125.2888320-1-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:37:06 +0000
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
- [High] HID: nintendo-switch2-usb: UAF and NULL deref in
  switch2_usb_free_in_urbs()
- [High] HID: nintendo-switch2-usb: UAF on switch2_controller during cfg
  teardown
- [Medium] HID: nintendo-switch2-usb: URB resubmission after
  switch2_usb_shutdown()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] HID: nintendo: missing usb_unanchor_urb() in
  switch2_usb_probe() [1]
--

commit e36945396b8fc382e63f59fdcd5efcaa968354a1
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo-switch2-usb: Fix potential deadlock on teardown

This commit replaces cancel_work_sync() on message_in_work with cancel_work=
()
in switch2_usb_free_in_urbs() and switch2_usb_shutdown(), and adds
cancel_work_sync() calls at the end of switch2_usb_probe() error handling a=
nd
switch2_usb_disconnect().

Link: https://sashiko.dev/#/message/20261006063000.A0B821F000FF%40smtp.kern=
el.org

> diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nin=
tendo-switch2-usb.c
> index 623473f3d2161..8eafc4fc513d4 100644
> --- a/drivers/hid/hid-nintendo-switch2-usb.c
> +++ b/drivers/hid/hid-nintendo-switch2-usb.c
> @@ -217,7 +217,7 @@ static void switch2_usb_free_in_urbs(struct switch2_u=
sb *ns2_usb)
>  	ns2_usb->shutdown =3D true;
>  	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> =20
> -	cancel_work_sync(&ns2_usb->message_in_work);
> +	cancel_work(&ns2_usb->message_in_work);
> =20
>  	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
>  	for (i =3D 0; i < NS2_IN_URBS; i++) {

[Severity: High]
Can deferring cancel_work_sync(&ns2_usb->message_in_work) until after
switch2_usb_free_in_urbs() cause a NULL pointer dereference or use-after-fr=
ee
on bulk_in[i].urb and its transfer_buffer?

cancel_work() returns immediately if switch2_usb_message_in_work() is alrea=
dy
running on a worker CPU.  Once switch2_usb_message_in_work() drops
bulk_in_lock, switch2_usb_free_in_urbs() can clear bulk_in[i].urb and free =
the
coherent DMA buffer and URB while the worker is still using them:

CPU0                                  kworker
switch2_usb_disconnect()              switch2_usb_message_in_work()
  switch2_usb_free_in_urbs()            spin_lock_irqsave(&bulk_in_lock)
    cancel_work(&message_in_work)       urb =3D &ns2_usb->bulk_in[i]
                                        spin_unlock_irqrestore(&bulk_in_loc=
k)
    spin_lock_irqsave(&bulk_in_lock)
    ns2_usb->bulk_in[i].urb =3D NULL
    ns2_usb->bulk_in[i].data =3D NULL
    spin_unlock_irqrestore(&bulk_in_lock)
    usb_kill_urb(urb)
    usb_free_coherent(..., data, ...)
    usb_free_urb(urb)
                                        switch2_receive_command(...,
                                          urb->urb->transfer_buffer, ...)
                                          <-- NULL deref or use-after-free

In addition, switch2_usb_free_out_urbs() also runs before cancel_work_sync()
and clears bulk_out[i].urb and bulk_out[i].data while leaving
bulk_out[i].state as NS2_URB_FREE, so if switch2_receive_command() sends a
command via switch2_usb_send_cmd(), it can pick a freed slot and dereferenc=
e a
NULL urb->data or urb->urb.

> @@ -276,7 +276,7 @@ static void switch2_usb_shutdown(struct switch2_cfg_i=
ntf *intf)
>  	ns2_usb->shutdown =3D true;
>  	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> =20
> -	cancel_work_sync(&ns2_usb->message_in_work);
> +	cancel_work(&ns2_usb->message_in_work);
> =20
>  	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
>  	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);

[Severity: Medium]
Can an in-flight switch2_usb_message_in_work() resubmit a bulk IN URB after
switch2_usb_shutdown() finishes?

drivers/hid/hid-nintendo-switch2-usb.c:switch2_usb_message_in_work() {
    ...
		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
		if (!urb->urb)
			/* We're shutting down and this URB was freed */
			break;

		urb->state =3D NS2_URB_FREE;
		/*
		 * We want exactly one bulk in URB scheduled at a time, so only
		 * reschedule this immediately if nothing else is scheduled
		 * currently.
		 */
		if (!usb_anchor_empty(&ns2_usb->bulk_in_anchor))
			continue;

		usb_anchor_urb(urb->urb, &ns2_usb->bulk_in_anchor);
		err =3D usb_submit_urb(urb->urb, GFP_ATOMIC);
    ...
}

When switch2_usb_shutdown() runs while switch2_usb_message_in_work() is
blocked in switch2_receive_command(), cancel_work() does not wait for the w=
ork
item, and switch2_usb_shutdown() kills all anchored URBs while leaving
urb->urb non-NULL.  When switch2_usb_message_in_work() reacquires
bulk_in_lock, it only checks !urb->urb and usb_anchor_empty(), not
ns2_usb->shutdown, so it re-anchors and resubmits urb->urb after shutdown.
Note that follow-up commit "HID: nintendo-switch2-usb: Improve shutdown log=
ic
with inbound message work" checks ns2_usb->shutdown at the start of
switch2_usb_message_in_work(), but still does not check it after reacquiring
bulk_in_lock here.

> @@ -447,6 +447,7 @@ static int switch2_usb_probe(struct usb_interface *in=
tf, const struct usb_device
>  	switch2_usb_free_out_urbs(ns2_usb);
>  err_free_in:
>  	switch2_usb_free_in_urbs(ns2_usb);
> +	cancel_work_sync(&ns2_usb->message_in_work);
>  	devm_kfree(&intf->dev, ns2_usb);
> =20
>  	return ret;

[Severity: Medium]
This problem wasn't introduced by this patch, but if usb_submit_urb() fails=
 in
switch2_usb_probe() [1], does switch2_usb_free_in_urbs() hang forever in
usb_kill_anchored_urbs()?

drivers/hid/hid-nintendo-switch2-usb.c:switch2_usb_probe() {
    ...
	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
	ns2_usb->bulk_in[0].state =3D NS2_URB_OUT;
	usb_anchor_urb(ns2_usb->bulk_in[0].urb, &ns2_usb->bulk_in_anchor);
	ret =3D usb_submit_urb(ns2_usb->bulk_in[0].urb, GFP_ATOMIC);
	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);

	if (ret < 0)
		goto err_free_out;
    ...
}

Because bulk_in[0].urb is anchored before usb_submit_urb() and is not
unanchored on submission failure, usb_kill_urb() inside
usb_kill_anchored_urbs() returns immediately without unanchoring the
unsubmitted URB, leaving usb_kill_anchored_urbs() spinning in an infinite l=
oop
waiting for bulk_in_anchor to become empty.

> @@ -466,6 +467,8 @@ static void switch2_usb_disconnect(struct usb_interfa=
ce *intf)
>  		switch2_controller_detach_cfg(ns2_usb->cfg.parent);
> =20
>  	switch2_usb_free_out_urbs(ns2_usb);
> +
> +	cancel_work_sync(&ns2_usb->message_in_work);
>  }
> =20
>  #define SWITCH2_CONTROLLER(vend, prod) \

[Severity: High]
Can running switch2_controller_detach_cfg() (or the error path of
switch2_controller_attach_cfg()) before cancel_work_sync() cause a NULL
pointer dereference or use-after-free on struct switch2_controller?

Because switch2_usb_shutdown() no longer waits for switch2_usb_message_in_w=
ork()
to finish, switch2_controller_detach_cfg() can clear ns2->cfg->parent and d=
rop
the last reference to ns2 while switch2_usb_message_in_work() is still runn=
ing
or blocked on mutex_lock(&ns2->lock) inside switch2_receive_command():

CPU0                                  kworker
switch2_usb_disconnect()              switch2_usb_message_in_work()
  ...                                   if (ns2_usb->cfg.parent)
  switch2_controller_detach_cfg(ns2)      switch2_receive_command(ns2, ...)
    mutex_lock(&ns2->lock)
    ns2->cfg->shutdown(ns2->cfg)
      cancel_work(&message_in_work)
    ns2->cfg->parent =3D NULL
    mutex_unlock(&ns2->lock)
    ...
    kref_put(&ns2->refcount,
             switch2_kref_put)
      kfree(ns2)
                                            mutex_lock(&ns2->lock)
                                            <-- use-after-free
  cancel_work_sync(&message_in_work)

Similarly, if ns2->cfg->parent is cleared between the if (ns2_usb->cfg.pare=
nt)
check and the call to switch2_receive_command(ns2_usb->cfg.parent, ...),
switch2_receive_command() will dereference NULL at mutex_lock(&ns2->lock).

[1] https://sashiko.dev/#/bug/linux-278e82ab-e1db-4cb6-bba0-623a80fa475c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111032125.2888=
320-1-vi@endrift.com?part=3D1
