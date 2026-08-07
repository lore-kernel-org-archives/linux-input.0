Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C912B94
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 01:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067780; cv=none; b=e9syXbPf8QlDB9A33JQK/6zLd84xvPA+y4aeJ2FNZtWyfpjRXGuDPBjKagS9wYfzJ+mP5zHR9wmuT6S6ybAVv42fHOvk3YBLziEYsOqKaxhUQ0v/ibjWJe4diycenHsJbtgyTWQ43Ljf7TQbOZdBicRIWkDK9T1J4pSsThwUm+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067780; c=relaxed/simple;
	bh=f+ppHdO5f0GSxWEobdnmiHG05RVXCUJ7UfPIdTXjiTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mKnZPIFXpQDoLvmOHo64wDs+N59XJ4Fh8D0Glwv6GFpNe1ZmGtPUHY0ntKHYc53ZHWuV486HRAAORvOqa1R5GiETl5/pO8mNPJMxxKI3CH+5AXciEvFT+foTOp+Y+05uNnoZQgeuN5rRKp1CKAo2bK7ucfWkQIo0RudTU4FgTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okKcg5EJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okKcg5EJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD561F000E9;
	Fri,  7 Aug 2026 01:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786067778;
	bh=5aA85e+i+AHEe+FXkR0bAgC+Ep/llzNup5PGAlQ+EnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=okKcg5EJeNGCBGfnWD3h3EoAtsKS1g/na4mtyF4ISDa3Z5y5R7Nr925FQAsCo6cCi
	 n67sfGn15XE31sNELOggZkgQda/+MosyUCwMDXrwUbdalsQOP8J61+JcBZOvAodY07
	 6h+EHsJUzO6cD/DzE0ezmyg/jANYY3og9iaE2ub2TMvjWZ2EWJB9ODG/gBwqtSIsHh
	 j//fhvSSf0+fzVNYoEtP3SW+PWtlVbXtqfJ6MpmFg+XAKvM8SNAj5tI557oEP+2qRX
	 hSEgEPXRdmVfbBw6iInwDsswmRX1qHTgP5q+Q5tFzB323Ai8P4+9UXRQgNJQr68fKN
	 nxlZpoD6AGE7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] HID: steam: Clean up locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260807013334.2109386-6-vi@endrift.com>
References: <20260807013334.2109386-1-vi@endrift.com>
 <20260807013334.2109386-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 01:56:17 +0000
Message-Id: <20260807015618.4FD561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Recursive spinlock acquisition causes an immediate deadlock when p=
rocessing battery events.
--

--- Patch [5]: [PATCH v3 5/6] HID: steam: Clean up locking ---
commit d43242604b3382e36db4c7f009a0ddce883ed333
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Clean up locking
   =20
This cleans up several issues with locking behavior, including RCU accesses
not being guarded behind a lock.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index d95296b28f92b..0e0ccf263416f 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -2230,8 +2234,6 @@ static void steam_do_deck_sensors_event(struct stea=
m_device *steam,
>  static void steam_do_battery_event(struct steam_device *steam,
>  		struct power_supply *battery, u8 *data)
>  {
> -	unsigned long flags;
> -
>  	s16 volts =3D steam_le16(data + 12);
>  	u8 batt =3D data[14];
> =20
> @@ -2239,10 +2241,9 @@ static void steam_do_battery_event(struct steam_de=
vice *steam,
>  	rcu_read_lock();
>  	battery =3D rcu_dereference(steam->battery);
>  	if (likely(battery)) {
> -		spin_lock_irqsave(&steam->lock, flags);
> +		guard(spinlock_irqsave)(&steam->lock);

[Severity: High]
Does this code cause a recursive spinlock deadlock?

steam_raw_event() now acquires steam->lock for the entire function scope and
calls steam_do_battery_event().

When a battery event is received, we'll see this call chain:

steam_raw_event()
   guard(spinlock_irqsave)(&steam->lock);
   ...
   steam_do_battery_event()
       guard(spinlock_irqsave)(&steam->lock); <-- deadlock

>  		steam->battery_voltage =3D volts;
>  		steam->battery_charge =3D batt;
> -		spin_unlock_irqrestore(&steam->lock, flags);
>  		power_supply_changed(battery);
>  	}
>  	rcu_read_unlock();
[ ... ]
> @@ -2427,15 +2428,13 @@ static void steam_do_ibex_battery_event(struct st=
eam_device *steam,
>  		struct power_supply *battery,
>  		const struct steam_ibex_battery_status *data)
>  {
> -	unsigned long flags;
> -
>  	/* Creating the battery may have failed */
>  	guard(rcu)();
>  	battery =3D rcu_dereference(steam->battery);
>  	if (!likely(battery))
>  		return;
> =20
> -	spin_lock_irqsave(&steam->lock, flags);
> +	guard(spinlock_irqsave)(&steam->lock);

[Severity: High]
Can this also cause a deadlock for the same reason?

steam_raw_event()
   guard(spinlock_irqsave)(&steam->lock);
   ...
   steam_do_ibex_battery_event()
       guard(spinlock_irqsave)(&steam->lock); <-- deadlock

>  	steam->battery_voltage =3D get_unaligned_le16(&data->battery_voltage);
>  	steam->battery_current =3D get_unaligned_le16(&data->battery_current);
>  	steam->battery_temp =3D get_unaligned_le16(&data->temperature);
[ ... ]
> @@ -2470,6 +2468,7 @@ static int steam_raw_event(struct hid_device *hdev,
>  	if (!steam)
>  		return 0;
> =20
> +	guard(spinlock_irqsave)(&steam->lock);
>  	if (steam->client_opened)
>  		hid_input_report(steam->client_hdev, report->type, data, size, 0);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807013334.2109=
386-1-vi@endrift.com?part=3D5
