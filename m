Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6913CBE7A
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031743; cv=none; b=GBNuaK2PqvCyd1uIt8J/hndWU7cWaBNGIl62po0FAeArlltRPNCYTBZXZNsBtjDfGUNSstJKtogZsbyUM9KIJoxhBoDcyUcv8zlhrV+xEc9y51PEuIHbz07Ex83jlahS52II3uOQn0VdNnXZJF7BeavanGuzhwxcydDEK3HyMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031743; c=relaxed/simple;
	bh=JmSr0SdC7RTqKz6/Zjo3mGXvy8C8bMi88E813HqTUl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=knoFAHdmK3jdLwaQ5enWhv7NDb1k7MLBVwnew2reRV4mMPdKhTRmUvmFy8fed85VxSpevjwaaDgqCfDFDV87aeGzuELY/d2pdC4jataKCa46G10XrALmOk6IaoHVnHkA6UyBJgMeLJe6We7dkAyi/qf2SS0OPjfvEGVoM9SS90s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6Yx9Ykj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6Yx9Ykj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9AC1F000E9;
	Thu,  2 Jul 2026 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783031736;
	bh=+RlWR7oO+PP90TcLlugJnSf3i2RJGC2Q8x51YwfKeus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P6Yx9Ykj9dtxcN3/C6kF6y6cIGmpu08nJdX/p1ssrhemzWflfI9xq4i/6DoLG6A4U
	 Jx3j8jJf8zA3mq5+tZ1D4tJl+4KXKKeYGFD7maPW7O0jS9s+QSf5CzBOHP2Rgu8dOB
	 7DHoZ51qgJATGc0Awlg3qXPmngyJXz2B1OL6P6vaRawIvRSBNA0LL7G6qjaorN7sCT
	 rcFhncXBAFTgcX4dOwvv6pkT7y7rFTw/1x0hhX4Iyvwm+gBunI0JqIN3iUb6nw7SiN
	 IjDJiq8uJViYmRApvNwuiX5zZVK0tFYvP5ucHgk7WuBLrvAKmXTojv9CnI05CFFEGD
	 b6h7C1biVBjng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] HID: steam: Rearrange deinitialization sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260702222145.1863104-7-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
 <20260702222145.1863104-7-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:35:35 +0000
Message-Id: <20260702223536.5D9AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free due to work item rescheduling during device removal
- [High] Double-free and Use-After-Free due to lockless concurrent executio=
n of steam_unregister()
--

commit 3f510b9fc8a4fe35042e364f53f44a52a7f1b526
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Rearrange deinitialization sequence
   =20
This fixes a narrow window during the deinitialization where callbacks
could still be scheduled during cleanup that would then have a dangling
pointer to the now-freed steam struct.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1443,18 +1443,18 @@ static void steam_remove(struct hid_device *hdev)
>  	}
> =20
>  	hid_destroy_device(steam->client_hdev);
> -	cancel_delayed_work_sync(&steam->mode_switch);
> -	cancel_work_sync(&steam->work_connect);
> -	cancel_work_sync(&steam->rumble_work);
> -	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
>  	steam->client_hdev =3D NULL;
> +	hid_hw_close(hdev);
> +	cancel_work_sync(&steam->work_connect);

[Severity: High]
This is a pre-existing issue, but does this still leave a window where the
work item can be rescheduled?

Because hid_hw_stop() has not been called yet, the hardware can still deliv=
er
a raw event like ID_CONTROLLER_WIRELESS. This calls steam_raw_event() which
calls steam_do_connect_event() and unconditionally queues the work item:

steam_do_connect_event()
    if (changed && schedule_work(&steam->work_connect) =3D=3D 0)

If this happens after cancel_work_sync() but before hid_hw_stop(), will the
delayed work item execute on a freed steam struct?

>  	steam->client_opened =3D 0;
>  	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
>  		hid_info(hdev, "Steam wireless receiver disconnected");
>  	}
> -	hid_hw_close(hdev);
> -	hid_hw_stop(hdev);
>  	steam_unregister(steam);

[Severity: High]
This is a pre-existing issue, but could concurrent calls to steam_unregiste=
r()
result in a double-free?

If a wireless disconnect event arrives concurrently with a device unplug,
the worker thread executing steam_work_connect_cb() and the unplug thread
executing steam_remove() might both call steam_unregister().

Since steam_unregister() relies on a lockless check of steam->serial_no[0],
could both threads pass the check simultaneously and call
steam_input_unregister()? Both threads would then read steam->input via RCU
and call input_unregister_device() on the same pointer.

Also, does this lack of serialization allow the probe error path to race
with steam_register(), potentially leaving active input devices pointing
to a freed steam struct?

> +	cancel_work_sync(&steam->rumble_work);
> +	cancel_delayed_work_sync(&steam->mode_switch);
> +	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> +	hid_hw_stop(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702222145.1863=
104-1-vi@endrift.com?part=3D7
