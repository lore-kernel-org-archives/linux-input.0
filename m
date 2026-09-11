Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D684A3F1D
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145062; cv=none; b=iY+6WIiB0vlMpKzxFokm+XamHooQJrwYtL4BF6JQpI/oOnCgWxQiOZBC/9GkLcihR/NG0UrZml/USk/EumAq+PqFf6TUyUR5sLzTOiXXd/sFDSNNhquSzR4bwPD7SE2DLXSueP7m1yyvmntSXnxpTcXO+F00nunXIEhgqFtv/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145062; c=relaxed/simple;
	bh=d9jm6TFdz4XCVVY3r1UywdUpRNiEvVFoY82KtUXZUL4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tC4qTpdmFIPZjCHSk1fMyw59cN/JnyUc4PnOTulfQ4cNiMGAO5PWz4xyQJtyKoceRQBs7X0g43q2gclf6DF50qv1enJGlau1IFf90+NYWVvwTCWs14l/DshgZZtl6gP3fy1uxNUvk8CbQyLxqjL7hBiMWT6NDK66dEG6SNjiCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNPKRZu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNPKRZu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22341F000FF;
	Fri, 11 Sep 2026 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145060;
	bh=cJa2fJ9s+YFGZgYjsFsWbBkOHc3UP4w0/h0aDzBgea0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LNPKRZu/Oey4EK+nj6n4O4XRIocs/UogCfAzhzWbE+QJhE1zTBusITHXQ8rtGT/fc
	 6CNiQ7su/mda7794e0CwzY5iLvPJwvtPhbRdVRFdEovYYcb7bidCT+niSDg3v5MUT1
	 /zyywDkKVy2VCO4NjOsClFApxFsYQDwv+a4wPPEY9Vpifx0JGYgsEcC+UC3TbtdHB1
	 UWnCwDXmulphFR+EOb4uZjqpJI2MTczds3Dp4NYb5I4wceKqAMK4qJObic5QaCKuQD
	 BlWeysPCZb0uhmrTFif4544rqTjXn118zWtpzBMtkXAELOC8W8TmaH6jVuUW9nV7Wi
	 fHN81BtsaFeTQ==
Date: Fri, 11 Sep 2026 18:44:17 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rafael Passos <rafael@rcpassos.me>, David Rheinsberg <david@readahead.eu>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Shuah Khan <skhan@linuxfoundation.org>, 
    Brigham Campbell <me@brighamcampbell.com>, 
    Jori Koolstra <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 0/4] HID: wiimote: new LED behavior on connect +
 scoped_guards
In-Reply-To: <20260817213840.1053216-1-rafael@rcpassos.me>
Message-ID: <68qr53po-2n27-0qnp-5016-p438078rssnn@xreary.bet>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 Aug 2026, Rafael Passos wrote:

> Hi,
> This patchset contains one feature change, and 3 patches appying 
> scoped cleanup to locking and to the initialization functions for
> the led probing and the main wiimote probe call.
> 
> The feature is turning different LEDs for each of the first 4 wiimotes connected.
> >From id 5 forward, the LED will cycle back to 1, and so on.
> This uses the ida struct, so its quite simple and lightweight.
> The hid_info log message prints out the controller id.
> 
> While implementing this feature, I decided to cleanup the code using
> scoped_guard for the many spinlocks in the driver. There are two places
> where the original lock/unlock version fits best, and I left them
> untouched.
> I also used the __free scope cleanup in the wiimote_probe and LED probe.
> This was trivial for the LED probe.
> The wiimote_probe required a new state tracker bitmask, now the wiimote_destroy
> is used both on disconnect (hid_remove) and in the probe cleanup.
> 
> It was really fun working with this driver.
> I tested it with 4 Wii Motion Plus remotes (gen2).
> Video recording of my tests (48s video).
> https://rcpassos.me/video/wiimote-led-linux-driver
> 
> Thanks,
> Rafael Passos

David, it'd be nice to have your Ack on these. Thanks.

> 
> ---
> V1: https://lore.kernel.org/linux-input/20260710153456.2093889-1-rafael@rcpassos.me/
> Changes from v1:
>     (1/3):
>     - fix ida_alloc_min error handling to consider negative values
>     - remove fallback to 1 on ida_alloc_min failure
>     - move player_leds static array to hid-wiimote-core.c
>     - s/instance_id/player_id/g
>     - store player_id on an u8
>     (2/3):
>     - add header include for cleanup.h
>     - add identation to one-liner scoped_guards
>     (3/3):
>     - add scoped cleanup function to wiimote_probe, with a bitmask to track state
>       Patch used for testing this:
>       https://lore.kernel.org/linux-input/20260715213513.3929001-1-rafael@rcpassos.me/
>     (4/4) *new patch* :
>     - sashiko found a pre-existing uaf. Unlikely, but correct.
>       implemented using the playstation driver as an inspiration
> 
> V2: https://lore.kernel.org/linux-input/20260710153456.2093889-1-rafael@rcpassos.me/
> Changes from v2:
>     (2/4):
>     - join the last two locks into a single scoped_guard lock in wiimote_modules_load
> 
> V3: https://lore.rcpassos.me/wiimote/20260729164928.1138468-1-rafael@rcpassos.me/
> Changes from v3:
>     - dropped false uaf patch (previous 4/4). It was a false alarm.
>       Discussion in:
>       https://lore.kernel.org/linux-input/20260729164928.1138468-1-rafael@rcpassos.me/T/#t
> 
>     (1/4):
>     - I tested how the changes looked if using ida from 0 instead of 1,
>       and I believe it ended up less clean. I decided to keep them as is,
>       with a few additional comments.
>     - explicit initialization of player_id to 0 before allocating an id
>     - avoid using a new int during ida_alloc (use ret instead)
>     - use u8 instead of __u8
>     - move ida_remove from wiimote_hid_remove to wiimote_destroy
>     - add debugfs entry for the player_id entry
>     (3/4):
>     - move changes to wiimote_probe from this patch to the next
>     - update patch title
>     (4/4): *new patch*
>     - scoped cleanup in the wiimote_probe call, using a bitmask to keep
>       track of state during initialization
>     - update wiimote_destroy so it can be the cleanup function
>     - add a debugfs entry for this new entry
> 
> As we discussed in the v3, tell me if you like the changes in patch 4/4.
> If you prefer not to apply it, I can send a new patchset revision, or
> just drop it from the set if nothing else needs changes.
> 
> Thanks!
> 
> 
> Rafael Passos (4):
>   HID: wiimote: turn on the LEDs indicating the controller id
>   HID: wiimote: replace spinlock pairs with scoped_guard
>   HID: wiimote: led_probe with scoped cleanup
>   HID: wiimote: wiimote_probe with scoped cleanup
> 
>  drivers/hid/hid-wiimote-core.c    | 346 ++++++++++++++++--------------
>  drivers/hid/hid-wiimote-debug.c   |  71 +++---
>  drivers/hid/hid-wiimote-modules.c |  24 +--
>  drivers/hid/hid-wiimote.h         |  10 +
>  4 files changed, 240 insertions(+), 211 deletions(-)
> 
> -- 
> 2.55.0
> 

-- 
Jiri Kosina
SUSE Labs

