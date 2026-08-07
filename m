Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51830EF91
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067633; cv=none; b=NYeGk2A304qwrj1vJaVgzQCO75YvLwiNfkyBcWNZC0g4XQ2UEGIJvr/zRJwivQtXhmphEPCvsMCkFPFGJLRRxppG9cuD6B96rwURVvcwNQGTLkQAL+AriFF+RMHTC0UhracfTQ/515E3nkvh9r6cu7+EzSDJTgHIM6EeL6//TXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067633; c=relaxed/simple;
	bh=+G4h7+i3V24pdHQqSNMm/c5Ugr8b5NJ65uA9LkgdbHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lLWxwKTjKA8TPKlFXF5AmjblmGKFjuVK6QRcVTRPGWPPe8fSapzq4vRYLv+uB+FyzI1PvJZfCWNU4K5NBP6E1Lf7xe4Kz8FXCzKaAmqB5u5IIUUnrCS9NleOwjbT401xBIYvbAGDcUhR+jEp1P48OzVWHxkupIpdhvrqS8zsbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqBpCmNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqBpCmNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CAF1F000E9;
	Fri,  7 Aug 2026 01:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786067631;
	bh=3tH/kR9zYt/c+VfU4t8BanRCclp4PzcizX2l2oSPcVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqBpCmNwurLXnlfoKvz7SbMICBkxCa9HGSuBMLSi3qOPvQR2eVOApWUmnNDW6I8wl
	 p4sr6NmwLrZ/+XTfrznV54WpABh0xfyuDiPzrAvBS+QOyfY90hyu15wQZeqH3waZSq
	 ILTO853sXWbzr+r932Oo7LbXP5svH00S6OAWiutWwrNAJET628ng2g9QfeOpkZJFDz
	 jwYRv5wqPtrfUWBjH33qbO+LgHEbvc5kDkVP/SnkgbVNBOVXXOnYrRCjsUv1Csg48D
	 Wv/zp+zfP/mQyydoC9i7lgQw6X/4MJw//uUxCQjFEoMfvmbbzVT8wEBeX8LN7WqdlH
	 ysf3U1cWQRyyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] HID: steam: Unregister battery on partial
 registration error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260807013334.2109386-2-vi@endrift.com>
References: <20260807013334.2109386-1-vi@endrift.com>
 <20260807013334.2109386-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 01:53:51 +0000
Message-Id: <20260807015351.75CAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Tearing down the battery on the error path without clearing `ste=
am->serial_no` prevents battery registration on subsequent retries.

Pre-existing issues:
- [High] Concurrent execution of unregistration functions allows unprotecte=
d RCU pointer modifications, causing potential double frees.
--

--- Patch [1]: [PATCH v3 1/6] HID: steam: Unregister battery on partial reg=
istration error ---
commit 024061e54a475950f36c1803b7d20aeb74ac4f96
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Unregister battery on partial registration error

In a previous refactor the code for unregistering a battery if later
registration steps failed was accidentally left out. As a result, a
lingering power_supply object could get left over after the steam object
was torn down.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 6199f67f3c4cd..967f12c7a599a 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1199,6 +1199,7 @@ static int steam_register(struct steam_device *stea=
m)
>  steam_register_sensors_fail:
>  	steam_input_unregister(steam);
>  steam_register_input_fail:
> +	steam_battery_unregister(steam);

[Severity: Medium]
Will this error path leave the device in an inconsistent state on retry?

If steam_register() fails and steam_battery_unregister() is called,
steam->serial_no[0] is not cleared.

On a subsequent retry (e.g. from steam_work_connect_cb()), steam_register()
will see the serial number populated and skip the initialization block where
steam_battery_register() is called.

This results in the input devices registering successfully, but the battery
object being permanently missing until a full device disconnect.

[Severity: High]
This is a pre-existing issue, but does calling steam_battery_unregister()
here expose a race condition?

When a user holds the HID device open, hid_hw_close(hdev) in steam_remove()
doesn't drop ll_open_count to zero, leaving the interrupt URB active.

After cancel_work_sync(&steam->work_connect), the active URB can still
receive raw events and re-queue work_connect.

This allows a worker thread to execute steam_register() or
steam_unregister() concurrently with steam_remove().

Since steam_battery_unregister() only uses rcu_read_lock() for reads, both
threads can observe a non-NULL battery pointer:

drivers/hid/hid-steam.c:steam_battery_unregister() {
	rcu_read_lock();
	battery =3D rcu_dereference(steam->battery);
	rcu_read_unlock();

	if (!battery)
		return;
	RCU_INIT_POINTER(steam->battery, NULL);
	synchronize_rcu();
	power_supply_unregister(battery);
	devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
}

Is it possible for both threads to proceed past the NULL check and
double-free the battery and its memory?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807013334.2109=
386-1-vi@endrift.com?part=3D1
