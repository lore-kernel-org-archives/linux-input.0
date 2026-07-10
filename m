Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08D1531E8
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649959; cv=none; b=Su4Ztu7oxFajvudI9FKssGTLkeIDqpVrN24oqhLGTBYiCjVwCpAzTtDSf9+tNtmI+fIk2hC7LERWG9p839i7nEx/ulmVJ/+rDwn5pahkQc6zIh3dWaghBvyarSXzAAh0LezLPf1CYJye4IbnMuxpaBKy7FJUaWzQXFjzUJeOsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649959; c=relaxed/simple;
	bh=4hEss740s2iMV1k9OnE+r7gojv+VlnTpMvy9BmsvjFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OAeBHK7BggByc6ACuAJNLpVZzhpeNXmXX0GY+LCAWiDn5E5qDCiiFFi1wcViS6fDSDArev5S98PKreL/D5ilHND++L2waiLhbTnuzWJk5L83bjnLoTLtTO4BvVG6PeWN20M8AWLj6cZsojDvAzXa8gjq/yWvdHj23sdRScMxDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Thwhvnex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thwhvnex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E5E1F000E9;
	Fri, 10 Jul 2026 02:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783649958;
	bh=3cEu2LqZSbMJmz9a/0IbVZR3azYiwLI9VeQ/jwYAoBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ThwhvnexqqYPIH+IX/xZUGSZBnBNpjBkXbgx5nGJvVWqlVWgoLg7SqnEPuvS7OLrR
	 6mrWO5tewoUmg7mXmrvDkJFEcFTGrwgyoNnAkcmiJft9uXiCFq04sBpg9rliuBw7bw
	 U/P8V+d8uWF114ww/PubCtF8/KgifSwizuBV0Av1dsT+GfVH0g8kuvpCce3iBI51a8
	 oSV7mH3+k39dM7w68Icau8pJjOwae2RhrV/5GISNnbgTVPOcdGQIgWIXJlJ7Xlt29Z
	 B5s1RDUcbIw4sj4/yKLY3vl41DmFAIJelW7GT7oJKfuf51jnIwNbomJoNuIY65l0v3
	 DpcJsaZ4EXqTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] HID: steam: Coalesce rumble packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260710020048.2337655-6-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
 <20260710020048.2337655-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:19:17 +0000
Message-Id: <20260710021917.C7E5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditional self-rescheduling causes severe haptic stutter by =
spamming redundant packets at 20Hz.

Pre-existing issues:
- [High] Use-after-free during device removal when a force-feedback effect =
is active.
--

--- Patch [5]: [PATCH v3 05/10] HID: steam: Coalesce rumble packets ---
commit 8356fb642b10f58402cd235e2f8093f10a60cd43
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Coalesce rumble packets

The Steam Deck resets the haptic pattern every time it receives a rumble
packet. This patch rate-limits sending these packets to 20Hz to prevent
discontinuities and cutting out.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 6029c055a6cf3..5537488139011 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -603,10 +604,24 @@ static void steam_haptic_rumble_cb(struct work_stru=
ct *work)
>  {
>  	struct steam_device *steam =3D container_of(work, struct steam_device,
>  							rumble_work);
> +
>  	steam_haptic_rumble(steam, 0, steam->rumble_left,
>  		steam->rumble_right, 2, 0);
>  }
> =20
> +static void steam_coalesce_rumble_cb(struct work_struct *work)
> +{
> +	struct steam_device *steam =3D container_of(to_delayed_work(work),
> +							struct steam_device,
> +							coalesce_rumble_work);
> +
> +	steam_haptic_rumble(steam, 0, steam->rumble_left,
> +		steam->rumble_right, 2, 0);
> +
> +	if (steam->rumble_left || steam->rumble_right)
> +		schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
> +}

[Severity: Medium]
Will this unconditionally self-reschedule and send identical packets at 20Hz
as long as a continuous force-feedback effect is active?

If a constant rumble effect is playing, this worker will continuously send
hardware reports and reschedule itself at 20Hz even if the magnitude has not
changed.

Since the commit message notes that the Steam Deck resets its haptic pattern
upon receiving a rumble packet, won't spamming these redundant packets force
continuous resets and cause the exact haptic stutter this patch is trying to
fix?

Could we add a check to only send packets and reschedule if the requested
rumble magnitudes have actually changed?

[ ... ]

> @@ -1444,6 +1469,7 @@ static void steam_remove(struct hid_device *hdev)
>  	cancel_delayed_work_sync(&steam->mode_switch);
>  	cancel_work_sync(&steam->work_connect);
>  	cancel_work_sync(&steam->rumble_work);
> +	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
>  	cancel_work_sync(&steam->unregister_work);
>  	steam->client_hdev =3D NULL;
>  	steam->client_opened =3D 0;

[Severity: High]
This is a pre-existing issue, but does canceling these work items before
unregistering the input device cause a use-after-free on device removal?

If the device is physically unplugged while a force-feedback effect is
playing, the removal path cancels the rumble works and then proceeds to call
steam_unregister().

When the input device is unregistered, the input core flushes and stops all
active effects. This operation routes through to steam_play_effect() with a
zero magnitude.

Since steam_play_effect() unconditionally re-arms the work items by calling
schedule_work() and schedule_delayed_work(), the work items we just cancell=
ed
will be queued again. When device removal completes, the steam_device
structure memory is freed by devres.

The re-armed works will execute later and dereference the freed memory. Sho=
uld
the work items be cancelled after steam_unregister() instead to prevent thi=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710020048.2337=
655-1-vi@endrift.com?part=3D5
