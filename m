Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF0383983
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788012571; cv=none; b=sCe9jhLRKMc3gbKhw9Gm6fL21S8ZmW1jJ1CLe90x9sg0Jm+3YHGDvGr1GsjdiuOt+Ek2ViagfKukqvlpCadqRAWyXzG5fKDP+FMkn1Rw9AshzDDIogLhmgQtqQGQQYDHfa7/1h7pvSfOzEBXqT27ijXOhseo6SE0Lt7fK9xeC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788012571; c=relaxed/simple;
	bh=e/wz97JgXaIz8SdXWHvpz1T+nKzHu0yLh5Qm/U/zer4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iDH2RzorFB1eN6hNtlqcDPYUmgYVvsHXFPYzzI6OA36Fog9i7BSCeJ4BzqIgDR7pbGDSahbrxliydwFw/6B3/Nk0WnHfLO1aTD4+j/mlHBm6bid50k+qzXfvCpRKVSww9xY45Pb5W6xDXTEWc21qMa8rGMp1dLJrOmqOmiMhkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZogdb/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZogdb/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302901F000E9;
	Sat, 29 Aug 2026 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788012569;
	bh=I5AOIwPjjHznPQqPfzSZX6KX/fXIaGR810Tj01baQTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GZogdb/jHnqFkdWQ+VfHaMUc/kEX4wCaXug3s07aMcAi2DmC7N3zmavwxPZFpde+e
	 WaCw/xXeQVhXBeG37foVOzHOcmb1FMhseIgpJlmsPrdcsgPvadqieO3PF4kzTTMUJ6
	 5+4UrpgtuuTXDR6/tSUgy1A04+GuaY9L09omFea+qKUKOEPJG+/E8kexf9cS24pJUj
	 AWeqmRFO+zeaI0rYJ419yTX0A8PVQxjCEAzBms6V7z8Tu9CiCUnJhdcd/sVtiTA7id
	 FaGfRlBD0Czk8N40qPzBLRHVre6DwFrWOJ/tqfMZsgHCJvVPxsLgCZK8JiXS9SrJwf
	 Lx6pNYVj3/SgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] Input: atkbd - fix uaf in atkbd_set_repeat_rate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeffin Philip" <jeffinphilip14@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260829135959.14882-1-jeffinphilip14@gmail.com>
References: <20260829135959.14882-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 14:09:28 +0000
Message-Id: <20260829140929.302901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to resolve the Use-After-Free (UAF) race condition=
 it intends to fix because `disable_delayed_work_sync()` is incorrectly pla=
ced after `input_unregister_device()`.
--

commit 364595b57a843b20a975005b27712754f014825e
Author: Jeffin Philip <jeffinphilip14@gmail.com>

Input: atkbd - fix uaf in atkbd_set_repeat_rate
   =20
atkbd_disable() marks atkbd as disabled to prevent any work
event to be executed, however this can race with atkbd_event_work().
If a pending work passes the atkbd->enabled check and atkbd_disable()
runs after in disconnect, it could dereference dev which is freed in
disconnect following atkbd being marked disabled. Fix this by adding
disable_delayed_work_sync() which drops all work events preventing
any rescheduling after atkbd is marked disabled.
   =20
Reported-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D1e2ef9bcb29af666b2e6
Fixes: 0ef7a26af127 ("Input: atkbd - fix canceling event_work in disconnect=
")
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>

> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkb=
d.c
> index 3509b58e64920..0d75a7ba48d3c 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -966,12 +966,9 @@ static void atkbd_disconnect(struct serio *serio)
>  	input_unregister_device(atkbd->dev);
> =20
>  	/*
> -	 * Make sure we don't have a command in flight.
> -	 * Note that since atkbd->enabled is false event work will keep
> -	 * rescheduling itself until it gets canceled and will not try
> -	 * accessing freed input device or serio port.
> +	 * Prevent work from being rescheduled after atkbd is marked disabled
>  	 */
> -	cancel_delayed_work_sync(&atkbd->event_work);
> +	disable_delayed_work_sync(&atkbd->event_work);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
disable_delayed_work_sync() after input_unregister_device() leave a
Use-After-Free race window open for the background work?

If atkbd_event_work() executes concurrently with atkbd_disconnect() and
passes the atkbd->enabled check, it can access atkbd->dev after it has
been freed.

For example, if atkbd_disconnect() calls input_unregister_device(atkbd->dev)
which drops the last reference and frees the device, the background work
could then access the freed dev in atkbd_set_leds():

drivers/input/keyboard/atkbd.c:atkbd_set_leds() {
    ...
	param[0] =3D (test_bit(LED_SCROLLL, dev->led) ? 1 : 0)
    ...
}

Should disable_delayed_work_sync() be moved above input_unregister_device()
to fully close this race window and ensure the work item cannot execute
after the device is freed?

> =20
>  	serio_close(serio);
>  	serio_set_drvdata(serio, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829135959.1488=
2-1-jeffinphilip14@gmail.com?part=3D1
