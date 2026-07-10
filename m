Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E518DB1F
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649841; cv=none; b=TPn5UftfZ7+A8HRPleBmQRzkWDjgYicGERlmeJEbyUb5Nn0eStyI1EFPRkmXdFJI8ZzKxENrkTEkjCS/0/uTv9fUC4nX9h9r3JuOR5RAV0dJsXoxfp5eWcNXiR/nVbGIRYQ5E7N55E0xcRwo6xi4aAjongB6SBtal5s/U5Dh6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649841; c=relaxed/simple;
	bh=E6HObAC9KaI5ouY/w0PIqeIrrc2KqWciJIZxrBaFozc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mlJqGk9+zSP0eAE2IEzgJ6/GO/4nxTClLnaVgDjA1AoGdiouJw7fjM5zhCX5i6PkYRYV25uLAmFwmdcA8VqmuIdcIwh6qK0GANlnKZFpnHhZkqzsV+UujDQtojj1fsofCfFJxVzo7HrbtH/jDsa5fMUIc9tVzWS9eOOItSjHPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rym/DbQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rym/DbQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53ED1F000E9;
	Fri, 10 Jul 2026 02:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783649840;
	bh=NbVgbkLHtcE0Ja7mrYhlzV/dqBp68VuJ5klTiq6jGj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rym/DbQ6NZQ9HDi+6UyIL9c8O51PTc3X4AQuxHnPALjnDnnRCtAdboMefMRicm87I
	 UH6RrlVkF8dgtSo+AFd12zyK9X6sLOyLYbrhU0X9Ui8VMU9ASqIFrTky3p14dP4oRI
	 NcWdTP5iRuZTZpifyEmpeRiLnC7Ekrwu4mJHNffAbPRzuU/QrE4B59U3fR4AuiHH4B
	 NvWnLV3SC0Rg6QZM+WKAnQJnUb/HDS5N3X9cw8OvuSqTWtmEFSAy1BtOhF0bgifN9H
	 AxjhtPryVJw0FG5I5FbpmOji3h1nR1gaKtv2gObtNVPJ2sy9asUgGkW5542gTcz5yM
	 tJsmFtery3bjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] HID: steam: Fully unregister controller when
 hidraw is opened
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710020048.2337655-7-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
 <20260710020048.2337655-7-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:17:19 +0000
Message-Id: <20260710021719.B53ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `steam_register()` fails during `steam_probe()`, the device is =
left in the global `steam_devices` list, leading to a Use-After-Free.
- [High] In `steam_remove()`, workqueues are cancelled before stopping the =
HID hardware and unregistering input devices, allowing works to be re-queue=
d and executed after the device is freed.
--

--- Patch [6]: [PATCH v3 06/10] HID: steam: Fully unregister controller whe=
n hidraw is opened ---
commit b7eebc07a61af5a54e2737e2f58726a8f773d095
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Fully unregister controller when hidraw is opened

To avoid conflicts between anything touching the hidraw and the driver we
had previously detached the evdev nodes when the hidraw is opened. However,
this isn't sufficient to avoid FEATURE reports from conflicting, so we
change to fully unregistering the controller internally, leaving only the
hidraw active until it's closed.

This also unifies the unregister and connect callbacks, as now the logic
between these two callbacks is identical.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 5537488139011..0771ad4f5f2c2 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -1451,7 +1429,6 @@ static int steam_probe(struct hid_device *hdev,
>  	cancel_delayed_work_sync(&steam->mode_switch);
>  	cancel_work_sync(&steam->rumble_work);
>  	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> -	cancel_work_sync(&steam->unregister_work);
> =20
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a failed
probe to leak the device pointer in the global steam_devices list?

If steam_register() fails during a wired controller's steam_probe(), the
failure causes steam_probe() to jump to an error label that bypasses
err_steam_unregister, which would have cleanly removed it via
steam_unregister().

The devres subsystem then frees the steam structure. Any subsequent iterati=
on
of steam_devices=E2=80=94such as modifying the lizard_mode module parameter=
 via sysfs
or plugging in another controller=E2=80=94will dereference this freed memor=
y.

> @@ -1470,7 +1447,6 @@ static void steam_remove(struct hid_device *hdev)
>  	cancel_work_sync(&steam->work_connect);
>  	cancel_work_sync(&steam->rumble_work);
>  	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> -	cancel_work_sync(&steam->unregister_work);
>  	steam->client_hdev =3D NULL;
>  	steam->client_opened =3D 0;

[Severity: High]
This is a pre-existing issue, but does cancelling the workqueues here create
a race condition?

In steam_remove(), workqueues (like rumble_work and work_connect) are
cancelled early in the teardown sequence. However, hid_hw_stop() is called
after these cancellations, meaning the HID transport is still active and
incoming reports can trigger steam_do_connect_event(), which re-queues
work_connect.

Furthermore, steam_unregister() is called at the very end of steam_remove().
Because the input device is still active, userspace can send force-feedback
events that call steam_play_effect(), re-queuing rumble_work and
coalesce_rumble_work.

Since these works are re-queued after the cancel_work_sync() calls, could
they execute after the steam structure is freed by devres, causing a
Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710020048.2337=
655-1-vi@endrift.com?part=3D6
