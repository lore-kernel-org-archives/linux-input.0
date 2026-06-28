Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B912DECA3
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782689273; cv=none; b=UB/toT/QzlJkup1zHz/uwxus4GNRQKnG957+deDxJYjZFs14VuWbwEphCxdddBf0k7giFkRpGhlZ79VljVMSCGMiytO6nAtRKJU43+7sJval1vO28dC8D+l+VVs0W09XL79//A4AMyH03HB6O9uXsfN8FjtKZsPsgCsb4aPmVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782689273; c=relaxed/simple;
	bh=PHnzK6aUBT7f39oCFoCCAtuTlrASNMK810CZCqwRTTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N31TGQuKesSaatmOGltGPoTJm5UWqvP0bBKKgC4E33TVp8iCVyEAsmboHTXsTYr1O0QpZZ4Md1kidDJTutDouA06F4ll7LUxXplk0xF6vSPsVPYKl8HMvmsvdv7m6ziMVlCWpjFjbDukUuDgwFxrmclDwxnk5w4ELA9WPETknl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4ngQ57Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4ngQ57Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F1E1F000E9;
	Sun, 28 Jun 2026 23:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782689271;
	bh=SB2VP+DN82GSu/ynzStd9wbdnKEgRvpuIicoYRbPlTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T4ngQ57YJqwd/4Wt6ETTjlJ7xVWGzZEwU6ML3vZhGV3GqWYKdg2NWRL19mytB44/Z
	 L2LSzMGJn+WvQ76pbqIIn15Jq0cwYRQzDcWQb3SOZclPOxN6WlfE5APkxEL4+tHw84
	 fe1BmkOFhJbu91uIy4eJLb4aSoBZVbagoTd/Upb38wH/hGGfPSHe7++tIzuY4hi6Wn
	 ZJc4LhpbAe1goj5VROkW4avaOeMn2TslvQI2ZV81m4+QHR501JlqDoa3vz6WyXTnZp
	 vnPVIP84Du/uhjdYxaU8Hynquw3Pa13yaMKZ38SyBu+t0GMrEmscKAcBFMd7VJT3m2
	 eOHOfxsoEn6DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: maplemouse - fix NULL pointer dereference in
 open()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fuchs" <fuchsfl@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628230715.2982552-1-fuchsfl@gmail.com>
References: <20260628230715.2982552-1-fuchsfl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 23:27:51 +0000
Message-Id: <20260628232751.90F1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Initialization of maple bus driver data occurs after exposing the =
input device to userspace, leading to a potential NULL pointer dereference.
- [High] Teardown asymmetry causes a race condition where a background call=
back is inadvertently re-armed during device removal, leading to UAF or NUL=
L pointer dereference.
--

commit 5babe5754528798c9e3476330c1a7834fe83388a
Author: Florian Fuchs <fuchsfl@gmail.com>

Input: maplemouse - fix NULL pointer dereference in open()

Commit 555c765b0cc2 dropped the input_set_drvdata() call in probe, which
caused a NULL pointer dereference in open() because maple_get_drvdata()
was still being used. This patch restores input_set_drvdata() and
converts open() and close() to use input_get_drvdata().

> diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maple=
mouse.c
> index c99f7e2342191..c41182766538a 100644
> --- a/drivers/input/mouse/maplemouse.c
> +++ b/drivers/input/mouse/maplemouse.c

[ ... ]

> @@ -58,7 +58,7 @@ static int dc_mouse_open(struct input_dev *dev)
> =20
>  static void dc_mouse_close(struct input_dev *dev)
>  {
> -	struct dc_mouse *mse =3D maple_get_drvdata(to_maple_dev(&dev->dev));
> +	struct dc_mouse *mse =3D input_get_drvdata(dev);
> =20
>  	maple_getcond_callback(mse->mdev, dc_mouse_callback, 0,
>  		MAPLE_FUNC_MOUSE);
>  }

[Severity: High]
This is a pre-existing issue, but does calling maple_getcond_callback() here
create a race condition during device removal?

During removal, remove_maple_mouse() clears the callback before unregisteri=
ng
the device:

drivers/input/mouse/maplemouse.c:remove_maple_mouse() {
	...
	mdev->callback =3D NULL;
	input_unregister_device(mse->dev);
	...
}

If the device is open, input_unregister_device() synchronously calls
dc_mouse_close(). This unconditionally calls maple_getcond_callback(), which
re-arms mdev->callback back to dc_mouse_callback.

After input_unregister_device() returns, remove_maple_mouse() clears the
driver data and frees mse. If a delayed maple bus packet arrives after this,
dc_mouse_callback() will execute and attempt to use a freed mse pointer or a
NULL driver data pointer, causing a kernel panic.

Would it be safer to avoid re-arming the callback if the device is being
removed?

[ ... ]

> @@ -88,6 +88,7 @@ static int probe_maple_mouse(struct device *dev)
>  	mse->dev =3D input_dev;
>  	mse->mdev =3D mdev;
> =20
> +	input_set_drvdata(input_dev, mse);
>  	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
>  	input_dev->keybit[BIT_WORD(BTN_MOUSE)] =3D BIT_MASK(BTN_LEFT) |
>  		BIT_MASK(BTN_RIGHT) | BIT_MASK(BTN_MIDDLE);

[Severity: High]
This is a pre-existing issue, but is it possible for a callback to fire
before driver data is fully initialized?

Later in probe_maple_mouse(), the device is registered:

drivers/input/mouse/maplemouse.c:probe_maple_mouse() {
	...
	error =3D input_register_device(input_dev);
	if (error)
		goto fail_register;

	mdev->driver =3D mdrv;
	maple_set_drvdata(mdev, mse);
	...
}

If userspace immediately opens the device upon registration, dc_mouse_open()
will schedule dc_mouse_callback(). If the callback executes before
maple_set_drvdata() completes, maple_get_drvdata(mapledev) inside the
callback will return NULL, leading to a NULL pointer dereference when
accessing mse->dev.

Could the maple_set_drvdata() call be moved before input_register_device()
to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628230715.2982=
552-1-fuchsfl@gmail.com?part=3D1
