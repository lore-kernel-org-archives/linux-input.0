Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52037A498
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386086; cv=none; b=WuZhUZtMdgcGqq8P8va4gwoN+P7dhK49I0RsZwo8e0ROMewZLoj1caBeGjGYqJAchBAo+Uj/dmFz/iATmkVnlT6/TkF0xp7lK/lkVQuUx0qeBfFvxtLfyT1+6+9XKNUj4S3gjFt9sDk3CqT/m2fIISdIEW4nR9bvZ+9winhhnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386086; c=relaxed/simple;
	bh=bIEdGsB8SaNt+bXDSQU3pOWRssusOHKJzdvNYBJO2TM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kiP4U4tBvbSbm8xrOWQg2NWLQ31flaiyP93LSVN0c8K5BfweAW1MSzi9ex2n+HLEEEeDAFbCAFBEPB9JcUJCpUFtz0iH00VrSuqsRwDrYg/i94cPm7Rz7h044zOZji1jSf+rhCpWX1LfzDrudL6sgN+ZDZQPL9UKj8a6n4W1B2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2fnxSwL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2fnxSwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960E31F000E9;
	Thu, 30 Jul 2026 04:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386083;
	bh=kDP9DTJvUf5FstPkIyrQCjyu/oCjGUFCXpBNoNDoZEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b2fnxSwLhC3YqNu0nNgXWkfX7E99UYYNkKkfQO0661izJ7cn/PtbQrmIjdq1Kn7rb
	 1eZFLydsdQHSzQT4c5ysmOBDGdmgEIPRulhE+Q3cK/ZGa1yuD1iu1/UNk3M6swG09L
	 Sj3ezOxAUzK+Fwcd13S9edoQhLCR2TK8DU4Y8mXMKRzAqc9iOB9sQbp0gEAXKHPl49
	 MI3NB4ghSu74jSTMOUXMMeoZdOE67F/Masv0GjaDTsjmjTfv777z/Zzdubb3BoP2IF
	 NZI4dMhsYl7T6KeNLJZ2p8ED9F/vlkO+YzWxBrRQFbheTLc4NHtt4fliLO3eqWudb4
	 sjp4p4o3xShKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/11] HID: steam: Fully unregister controller when
 hidraw is opened
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260730041251.1659029-7-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
 <20260730041251.1659029-7-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:34:43 +0000
Message-Id: <20260730043443.960E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The local variable `do_add` in `steam_register()` can be evaluat=
ed uninitialized.

Pre-existing issues:
- [High] Teardown order in `steam_remove()` causes Use-After-Free and doubl=
e-free vulnerabilities.
--

--- Patch [6]: [PATCH v5 06/11] HID: steam: Fully unregister controller whe=
n hidraw is opened ---
commit 14e48fa0937746f55f6b26048f8ecca7fe02bb3e
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: steam: Fully unregister controller when hidraw is opened

This patch changes the driver to fully unregister the controller
internally when hidraw is opened, leaving only the hidraw active until
it is closed. It also unifies the unregister and connect callbacks to
share identical logic.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 87b3817a2f69d..12203d61922f7 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -1084,6 +1085,7 @@ static int steam_register(struct steam_device *stea=
m)
>  	int ret;
>  	unsigned long client_opened;
>  	unsigned long flags;
> +	bool do_add;
> =20
>  	/*
>  	 * This function can be called several times in a row with the
> @@ -1113,10 +1115,7 @@ static int steam_register(struct steam_device *ste=
am)
>  		if (steam->quirks & STEAM_QUIRK_WIRELESS)
>  			steam_battery_register(steam);
> =20
> -		mutex_lock(&steam_devices_lock);
> -		if (list_empty(&steam->list))
> -			list_add(&steam->list, &steam_devices);
> -		mutex_unlock(&steam_devices_lock);
> +		do_add =3D true;
>  	}
> =20
>  	spin_lock_irqsave(&steam->lock, flags);
> @@ -1132,6 +1131,13 @@ static int steam_register(struct steam_device *ste=
am)
>  		if (ret !=3D 0)
>  			goto steam_register_sensors_fail;
>  	}
> +
> +	if (do_add) {

[Severity: Medium]
Is it possible for do_add to be evaluated uninitialized here?

When steam_register() is invoked on an already-registered device,
steam->serial_no[0] is already populated. This causes the initialization bl=
ock
for "if (!steam->serial_no[0])" to be skipped, meaning do_add is never
assigned a value. Could this undefined behavior lead to compiler
optimizations altering the control flow or causing redundant lock
acquisitions?

> +		mutex_lock(&steam_devices_lock);
> +		if (list_empty(&steam->list))
> +			list_add(&steam->list, &steam_devices);
> +		mutex_unlock(&steam_devices_lock);
> +	}
>  	return 0;

[ ... ]

> @@ -1470,7 +1452,6 @@ static void steam_remove(struct hid_device *hdev)
>  	cancel_work_sync(&steam->work_connect);
>  	cancel_work_sync(&steam->rumble_work);
>  	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> -	cancel_work_sync(&steam->unregister_work);

[Severity: High]
This is a pre-existing issue, but does the teardown order in steam_remove()
cause a Use-After-Free and double-free vulnerability?

Currently, work items like steam->work_connect are canceled before calling
hid_hw_stop(). Since the HID event stream is still active, an incoming
interrupt (such as a connection status report) can trigger steam_raw_event(=
):

steam_raw_event()
  steam_do_connect_event()
    schedule_work(&steam->work_connect)

When steam_remove() completes, devres frees the steam_device struct, leaving
a dangling work item in the queue that triggers a UAF when executed.

Furthermore, if the rescheduled work executes concurrently with the end of
steam_remove(), both threads can invoke steam_unregister() simultaneously.
Because steam_unregister() lacks mutual exclusion, does this lead to
concurrent double-frees of the input and sensor devices?

>  	steam->client_hdev =3D NULL;
>  	steam->client_opened =3D 0;
>  	if (steam->quirks & STEAM_QUIRK_WIRELESS) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730041251.1659=
029-1-vi@endrift.com?part=3D6
