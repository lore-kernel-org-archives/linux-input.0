Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0F39479B
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519336; cv=none; b=bwvxWF6s7V5gHsLjjFVZg8sjjVDJ+1f5mkywPiP15UOqEAwcYGQ5Q5C4YSK4hN12Fqlyhmvl9Mrbj/BCsdLcCltCqhVUSvbADuJ9P4ZA0g7H16QGEjyZLX9ISx+DQBQengs+iod2Mo0Hr3hNOriK/Stz/DZYK3KrF+t70rQSCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519336; c=relaxed/simple;
	bh=PNJwEi0jE4aByhJtGcacyRKZg6dIGw3MV95w7O39JAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jwJm/B6M7tms9AA6qco2ZtIh6ErddDAu0QDzqBPmw18AM4BsmuKLQypBiJen0d+9JMAoujWJTfDHBlOKElob/Ks6/53AA2T/tRHxzgaOXj4bRyRExLQnlcskeNU2XKi0Jfm/U1KhRqg/hF+VOAcSIqoa14ztjZcKb3x1ezonoLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPEDO+jT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPEDO+jT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D8C1F000E9;
	Mon, 20 Jul 2026 03:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784519335;
	bh=fA/EGbNqJBdDcXCpdVWpv1Gu5N7kAM2sgLrdqbUrlsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KPEDO+jT1QCP8xB7eibJxTf11pXk8nGp4AxV/aj3ey6658ufxqHKj7F66uVz/e0rL
	 o5J8/dCjhDWE+IDiL4jL3SS3DTE6TE+ngGKOVCFte9vUUAOfepRbmGvxEX7AHUkiJE
	 d/yMPHV3eJiP/XUYqtrjPCow3cZh4VIF+QKV9XxntEkOgFYPuiqy0qDnCoUI0wmXZQ
	 sUdR+pZ9WOExPar9ZuH4I7odrqUo7nWeSO66cjfizGAh5iNIfbyNLCyIiHvO+Tj1A8
	 lYHqdWP6tO/BcB+iPzEomZ3+0tO9fH5mZeCfbop+6lW5sihTH1K00f/hLYS75RwHhW
	 NOpnK3SUHd0fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: byd - synchronize timer deletion before freeing
 private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720033030.1580891-1-lilinmao@kylinos.cn>
References: <20260720033030.1580891-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 03:48:54 +0000
Message-Id: <20260720034855.07D8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free or NULL pointer dereference in byd_process_byte() d=
ue to missing RX synchronization during disconnect.
- [High] Improper timer teardown API allows the timer to be re-armed after =
sync, causing a delayed Use-After-Free.
--

--- Patch [1]: [PATCH] Input: byd - synchronize timer deletion before freei=
ng private data ---
commit eb1fe8255d54e5e900b504d5aed98e3fff1721fb
Author: Linmao Li <lilinmao@kylinos.cn>

Input: byd - synchronize timer deletion before freeing private data
   =20
byd_disconnect() uses timer_delete() before freeing the driver's private
data.  This does not wait for a running byd_clear_touch() callback, which
dereferences the private data and its psmouse pointer.  A callback racing
with disconnect can therefore access the private data after it has been
freed.
   =20
Use timer_delete_sync() to wait for any running callback before releasing
the private data.
   =20
Fixes: 2d5f5611dd0d ("Input: byd - enable absolute mode")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> index f5770a3af2f12..7a69724c1ac6b 100644
> --- a/drivers/input/mouse/byd.c
> +++ b/drivers/input/mouse/byd.c
> @@ -423,7 +423,7 @@ static void byd_disconnect(struct psmouse *psmouse)
>  	struct byd_data *priv =3D psmouse->private;
> =20
>  	if (priv) {
> -		timer_delete(&priv->timer);
> +		timer_delete_sync(&priv->timer);

[Severity: High]
This isn't a bug introduced by this patch, but does timer_delete_sync()
prevent the timer from being re-armed concurrently?

Because device interrupts are not disabled during byd_disconnect(),
byd_process_byte() can execute immediately after timer_delete_sync()
returns but before psmouse->private is freed.

If byd_process_byte() processes a touch event, it can call mod_timer()
and successfully re-arm the timer on the priv structure:

drivers/input/mouse/byd.c:byd_process_byte() {
	...
	mod_timer(&priv->timer, jiffies + BYD_TOUCH_TIMEOUT);
	...
}

When byd_disconnect() subsequently frees priv, won't the timer callback
execute on the freed memory?

Should this use timer_shutdown_sync() instead to permanently prevent the ti=
mer
from being re-armed during teardown?

>  		kfree(psmouse->private);
>  		psmouse->private =3D NULL;

[Severity: High]
This is a pre-existing issue, but is it possible for an interrupt to trigger
byd_process_byte() concurrently with or immediately after freeing this memo=
ry?

The core psmouse_disconnect() function invokes the driver's disconnect call=
back
without first stopping device interrupts (such as by using serio_pause_rx()=
).

If the hardware sends a byte during device teardown, ps2_interrupt() can
route the data to the active protocol handler byd_process_byte(). This
unconditionally dereferences the freed or NULL psmouse->private pointer:

drivers/input/mouse/byd.c:byd_process_byte() {
	struct byd_data *priv =3D psmouse->private;
	...
}

Does the receive path need to be paused or synchronized before freeing the
private data to prevent a use-after-free or NULL pointer dereference?

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720033030.1580=
891-1-lilinmao@kylinos.cn?part=3D1
