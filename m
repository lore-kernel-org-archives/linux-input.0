Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010F3BCD32
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885018; cv=none; b=kfKTO4CoJ7ikDrz/dBQBRjOD7Ens0ebPaX8dC4U1NLKDOmpR16QZa7EyiAuWaG+Ol8jT1uG5y+WqAGC0NOEmX04LVILGiOv8+SWT3Y0tUtZS7rHL3sX0I0Cm5EXPrbjPXFgw+ofTpoyJ9zMWTtQL5KTplhQQzCiv7DwtlYVqkvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885018; c=relaxed/simple;
	bh=6g4taLyQY4QjozWUGK7h/nWUuJ9axoKcIPiXBkQyaO0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=s29iut8R0igewLRfCkwfZqvTrOngv9HqAFMMzuTDtQ96Ugqut7W5h38BL/Mmoob0RsT7g827Up/bB6RkTQLfvZNMnSS2ZX9v7KoDyy9ewnSRlSSKFx51r9g/THLw1UHXApsP8IPKSR5my/L6ibp1JfaEWVGQVylh66JB7p/HCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKUMyf7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKUMyf7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D55D1F000FF;
	Tue, 13 Oct 2026 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885016;
	bh=lu44BAZj5A4Cfv5KTn5SW8PzptNLECkr85GyS8gUH8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKUMyf7dY0XIfPDoVkrXHS/+NktumnVelBMsnP3PM2VqXndN4+VzDuRWa6GpO4+Na
	 g9Yb1caZ5dI3wNS6RDf3VoJ8D7k+8Oy/KJPyEIctweMSsbF0XwgzAxAZZhF7Oina9C
	 VF/gfuxuA9g4Gw/avoYgvS4mALSpl4b6IUAfCJ6MGHo8v8eIkPKbjL8aEVnJ62504S
	 HgPmiaUJa5GpjYXI11qLpygkd41rvUNa0+tYFr/AeujL/r5eCepVmZu1jp/bMS8Ma3
	 JJ5R1BxB/poup1dows0vObBcXZyC+d3V6hZAtOZdmdKyx182UFULZxlLYDYsrQydco
	 m2QKrj+MXvEJQ==
Message-ID: <sashiko-outbox-169386@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [STABLE v5.15-v5.10 3/6] HID: steam: Fully unregister
 controller when hidraw is opened
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261013091215.529531-3-lee@kernel.org>
References: <20261013091215.529531-1-lee@kernel.org>
 <20261013091215.529531-3-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:50:15 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: steam: Use-after-free of battery name in class iterators
--

commit ac4de628ad44ddc16c1b1fd80453897f658181f6
Author: Vicki Pfau <vi@endrift.com>

    HID: steam: Fully unregister controller when hidraw is opened

To avoid conflicts between anything touching the hidraw and the driver, this
commit changes the driver to fully unregister the controller internally when
hidraw is opened. It also unifies the unregister and connect callbacks.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 78104e1246e82..cf1a3da36478c 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -494,12 +495,15 @@ static void steam_battery_unregister(struct steam_d=
evice *steam)
>  	RCU_INIT_POINTER(steam->battery, NULL);
>  	synchronize_rcu();
>  	power_supply_unregister(battery);
> +	devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
>  }

[Severity: High]
Can this introduce a use-after-free for the battery name string?

steam_battery_unregister() calls power_supply_unregister(battery), which
eventually delegates to device_del() and klist_del().

klist_del() drops the hierarchy reference asynchronously and does not block
waiting for active class iterators to finish.

If a concurrent caller to power_supply_get_by_name() iterates over the
power_supply_class, it will call power_supply_match_device_by_name() which
executes strcmp(psy->desc->name, name).=20

Since devm_kfree() explicitly frees steam->battery_desc.name immediately
after unregistering, couldn't this dereference the freed name string and
cause a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013091215.5295=
31-1-lee@kernel.org?part=3D3
