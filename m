Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4EF40D57B
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912130; cv=none; b=C5pINGBgQOl3qISS01bBwWez8vKMMct3LE4vhWs/qPaWhzVDVS6DIAPzoLmloNxvfpXq7Maw5HnE/xPI93ETYs3GY7rpgR/E2GtjKiUPEyqwnoOa5TPu81ohPKNUqh6eyz48usRLywFw9vhbA/IR7TQGew1AIi092bCCbfwhOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912130; c=relaxed/simple;
	bh=FXvP+nt4Q5KlgfDrT0NfPJ4+htAdqL1rjkzFlqSJzmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o4m8Kv4C4Ns8Nu1TlchbFFTkMGe7vXssJVJolfxT2VhktA0jC3uADEAXCaroZ1MEw6a8BsuJyTHg2/nOMQB8qeJTs1T6gXpc0tKERTliXnHMA4s0KlY0QnlqXgeq6qnLUdku3GyRvpbRd0VLPmvF/jAUrfJaWTjY4REItqS523o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Do7aQaQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Do7aQaQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8001F000E9;
	Fri, 28 Aug 2026 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787912128;
	bh=Kmt0fiz++8Ylp6oPCQNSGmHQPVpa/YVMFJpuVSrW1nI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Do7aQaQBssp4ct8oe23fHwtCNWPj6vTGl4VCJEsHxTXaZ0O3F9JhdZCqZ4u+DZxyr
	 0XTu7NRai04DQg+SEaqQXouGKLttoLCnjOLwgjeD1AeaBptz1U8pdkKDUXlvOE3XuW
	 8JPK/zWJ5q3VOYCo43pPVWq4/pQNUyOQlTVid+pDKIxak69zy9zyFsWDhLoY8pAs4c
	 4HF+ToazvKwf1Qu6ONqhKsjcPDldj1anPRgS49tph0J0P2EJ1rWQ/1Ljb5BMyj2meT
	 k3Rq/HjPAS6OzlnQC91ss1Wwc5H0O5DRvFeFDULm76iOXP8M/mqh74Dwn7pvr4tPmA
	 jFpniLOodvw1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: atkbd - fix UAF in atkbd_set_repeat_rate() on
 disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeffin Philip" <jeffinphilip14@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260828100547.120553-1-jeffinphilip14@gmail.com>
References: <20260828100547.120553-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 10:15:27 +0000
Message-Id: <20260828101528.6C8001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in `atkbd_e=
vent()` allows delayed work to be queued after `cancel_delayed_work_sync()`=
, leading to a Use-After-Free of the `atkbd` structure.
--

commit 0f8148a1f313524a8dd641967f56cd788e4c8ac4
Author: Jeffin Philip <jeffinphilip14@gmail.com>

Input: atkbd - fix UAF in atkbd_set_repeat_rate() on disconnect

This commit attempts to fix a use-after-free issue by closing the serio
port before canceling delayed work and adding an enabled check to
atkbd_event(). It aims to prevent work from being scheduled after
disconnection.

Link: https://lore.kernel.org/all/20260828080839.116065-1-jeffinphilip14@gm=
ail.com/T/#u

> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkb=
d.c
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -672,6 +672,9 @@ static int atkbd_event(struct input_dev *dev,
>  	if (!atkbd->write)
>  		return -1;
> =20
> +	if (!atkbd->enabled)
> +		return -1;
> +

[Severity: High]
Can this lockless check introduce a Time-of-Check to Time-of-Use (TOCTOU) r=
ace
condition?

If userspace calls evdev_write(), which invokes atkbd_event(), a thread cou=
ld
read atkbd->enabled as true here, but then stall or be preempted before
actually scheduling the work.

[ ... ]

> @@ -963,17 +966,18 @@ static void atkbd_disconnect(struct serio *serio)
> =20
>  	atkbd_disable(atkbd);
> =20
> -	input_unregister_device(atkbd->dev);
> -
>  	/*
> -	 * Make sure we don't have a command in flight.
> -	 * Note that since atkbd->enabled is false event work will keep
> -	 * rescheduling itself until it gets canceled and will not try
> -	 * accessing freed input device or serio port.
> +	 * close serio first so device will not get any data, which prevents
> +	 * atkbd_event_work from being rescheduled after cancel_delayed_work_sy=
nc
> +	 * returns. This ensures no work can dereference atkbd->dev after it has
> +	 * been freed.
>  	 */
> -	cancel_delayed_work_sync(&atkbd->event_work);
> =20
>  	serio_close(serio);
> +	cancel_delayed_work_sync(&atkbd->event_work);
> +
> +	input_unregister_device(atkbd->dev);
> +

[Severity: High]
If the thread running atkbd_event() is delayed after checking atkbd->enable=
d,
could it resume here and queue work after cancel_delayed_work_sync() has
already returned?

Since serio_close() only stops hardware interrupts and does not block users=
pace
from invoking atkbd_event(), atkbd_disconnect() could proceed to unregister
the device and free the atkbd structure.

When the delayed thread finally resumes and queues the work, won't that que=
ued
work execute later and dereference the freed atkbd structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828100547.1205=
53-1-jeffinphilip14@gmail.com?part=3D1
