Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065033F59E
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291334; cv=none; b=jS+sV2gaq6l/+LGQR6E409L/XvD7df1pJCIVnryzEQDm2WxPSTDzOxV4P3+goDyppaoaC9sBoLmbDaD0YVNvgvpGmPUkkzB/cW6K1N0xArMbhKuhItArnAYzsxvT45RaayctlVVA68Kun4fcap8ut/GWNfukoOPMsLcalWYZ1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291334; c=relaxed/simple;
	bh=a+PMCcEYQ5n+23PpIdJW3mVibbVZRMySOFq7NwLWmw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KTm6eccP14OSRHCcGHXZ/f8uLXHVSqZethwU97oy5h1YceK5jCXv/C/JI0cNaWODsNZqcaeUTIfwEXWEyniypW+1efJGNkV0veSJTh9kTH6Xeto6eShTiGCexqJT1YHxEWSyHhYWf5KCdO8qyitJmRwP2HzMfAIb/y5zvKcJs+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq1fTvRt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq1fTvRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370011F000E9;
	Wed, 29 Jul 2026 02:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785291333;
	bh=7eNtAorPe/ETssFvOPDh4xlX96/OXc9rpBAqPBoLPkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jq1fTvRtvzMXuRCm49X4LAkBJlkVcbDu19RIS007gKu7iy4Ey/n0KPSIZeW/pAYKX
	 gnleT+PLl+GQ1Q830qspsbWmwVYbdQtdOmKYaB9ds0B8HeeKPxibC2y66c3QNCNBVL
	 +QeMWa5HrRrE5dyhfYPdy4iu5OOoVfN0id0sisHxEx2GleRxYZoxmk7L6aLcYxoX4e
	 fVa6JrrnoL+rXpr04Zp18uCc6S0niiZaCWNOeMdiwerPEtS1OHBhtYMfzOKeuzWEzH
	 KQDtbIOtdfppNnyOMXsD6PwlIkodB2sxwRLYgKSjdn4YJ0zixRgOgWVQs1Ui7c+8h5
	 OxlRUOQcN1/Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/11] HID: steam: Rearrange teardown sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729015243.1170573-9-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
 <20260729015243.1170573-9-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 02:15:32 +0000
Message-Id: <20260729021533.370011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Calling `hid_hw_start()` before initializing driver data structure=
s exposes the device to events early, leading to crashes from uninitialized=
 locks and work_structs.
- [High] The modified error path in `steam_probe()` skips the cancellation =
of `work_connect` and `mode_switch`, leaving them dangling on probe failure.

Pre-existing issues:
- [High] Teardown ordering in `steam_remove()` allows `work_connect` to be =
re-scheduled by raw events after it has been explicitly cancelled.
- [High] `steam->client_hdev` is destroyed before the `client_opened` flag =
is cleared, allowing asynchronous events to dereference the freed device.
- [High] If `steam_register()` fails during initialization, the `steam` obj=
ect is freed but remains linked in the global `steam_devices` list.
--

--- Patch [8]: [PATCH v4 08/11] HID: steam: Rearrange teardown sequence ---
commit 4778053b21e62ca367e7570ac85b4132006adade
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Rearrange teardown sequence

This fixes a narrow window during the teardown sequence where callbacks
could still be scheduled during cleanup that would then have a dangling
pointer to the now-freed steam struct. This also puts work canceling
for rumble and mode switch in steam_unregister, as that shouldn't persist
while the client hdev is open.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index ff112aa1b0e91..5ab4396a241e0 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -1352,6 +1356,14 @@ static int steam_probe(struct hid_device *hdev,
>  	if (!steam)
>  		return -ENOMEM;
> =20
> +	/*
> +	 * With the real steam controller interface, do not connect hidraw.
> +	 * Instead, create the client_hid and connect that.
> +	 */
> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
> +	if (ret)
> +		return ret;
> +
>  	steam->hdev =3D hdev;
>  	hid_set_drvdata(hdev, steam);
>  	spin_lock_init(&steam->lock);

[Severity: High]
Does calling hid_hw_start() before initializing driver data structures expo=
se
the device to events early?

Moving hid_hw_start() here makes the input devices visible to userspace.
If a userspace process opens the input node, hid_hw_open() is called, start=
ing
URB polling. An incoming hardware interrupt can then invoke steam_raw_event=
().

Because hid_set_drvdata() is called right after hid_hw_start(),
steam_raw_event() could access the non-NULL steam pointer and call
steam_do_connect_event(), which might attempt to acquire the uninitialized
spinlock and schedule the uninitialized work_connect, potentially leading to
a crash.

[ ... ]
> @@ -1397,14 +1393,22 @@ static int steam_probe(struct hid_device *hdev,
>  			hid_err(hdev,
>  				"%s:steam_register failed with error %d\n",
>  				__func__, ret);
> -			goto err_hw_close;
> +			goto err_hw_stop;

[Severity: High]
This is a pre-existing issue, but if steam_register() fails during
initialization, does the steam object remain linked in the global
steam_devices list after being freed?

During steam_register(), the device is added to the global steam_devices li=
st.
If a subsequent step like steam_input_register() fails, the function returns
an error without removing the device from the list.

When this failure jumps to err_hw_stop in steam_probe(), it bypasses
steam_unregister(), which is responsible for removing it from the list.
If devres then frees the object, could a dangling pointer be left in the
global list?

[ ... ]
>  err_destroy:
>  	hid_destroy_device(steam->client_hdev);
> -err_steam_unregister:
> -	if (steam->connected)
> -		steam_unregister(steam);
>  err_hw_close:
>  	hid_hw_close(hdev);
> -err_hw_stop:
> -	hid_hw_stop(hdev);
> -err_cancel_work:
> +err_steam_unregister:
> +	spin_lock_irqsave(&steam->lock, flags);
> +	steam->client_opened =3D 0;
> +	spin_unlock_irqrestore(&steam->lock, flags);
>  	cancel_work_sync(&steam->work_connect);
> +	if (steam->connected)
> +		steam_unregister(steam);
>  	cancel_delayed_work_sync(&steam->mode_switch);
> +err_hw_stop:

[Severity: High]
Does the modified error path in steam_probe() skip the cancellation of
work_connect and mode_switch when a probe failure jumps to err_hw_stop?

Because hid_hw_start() was moved earlier in the probe, raw events might alr=
eady
queue work_connect. If the probe fails and jumps directly to err_hw_stop,
bypassing err_steam_unregister, could it leave these work items dangling wh=
en
devres frees the steam object?

>  	cancel_work_sync(&steam->rumble_work);
>  	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> +	hid_hw_stop(hdev);
> =20
>  	return ret;
>  }
> @@ -1435,25 +1441,24 @@ static int steam_probe(struct hid_device *hdev,
>  static void steam_remove(struct hid_device *hdev)
>  {
>  	struct steam_device *steam =3D hid_get_drvdata(hdev);
> +	unsigned long flags;
> =20
>  	if (!steam || hdev->group =3D=3D HID_GROUP_STEAM) {
>  		hid_hw_stop(hdev);
>  		return;
>  	}
> =20
> +	hid_hw_close(hdev);
>  	hid_destroy_device(steam->client_hdev);
> -	cancel_delayed_work_sync(&steam->mode_switch);
> -	cancel_work_sync(&steam->work_connect);
> -	cancel_work_sync(&steam->rumble_work);
> -	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> -	steam->client_hdev =3D NULL;
> +	spin_lock_irqsave(&steam->lock, flags);
>  	steam->client_opened =3D 0;
> +	spin_unlock_irqrestore(&steam->lock, flags);

[Severity: High]
This is a pre-existing issue, but is steam->client_hdev destroyed before
the client_opened flag is cleared?

Because steam_raw_event() runs in softirq context without taking a lock aro=
und
the client_opened check, there could be a race condition.

If an interrupt sees client_opened > 0 right before hid_destroy_device()
completes, could it pass the freed client_hdev pointer to hid_input_report(=
)?

> +	cancel_work_sync(&steam->work_connect);
>  	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
>  		hid_info(hdev, "Steam wireless receiver disconnected");
>  	}
> -	hid_hw_close(hdev);
> -	hid_hw_stop(hdev);
>  	steam_unregister(steam);
> +	hid_hw_stop(hdev);

[Severity: High]
This is a pre-existing issue, but does the teardown ordering in steam_remov=
e()
allow work_connect to be re-scheduled by raw events after it has been expli=
citly
cancelled?

cancel_work_sync(&steam->work_connect) is called above, but URB polling is =
only
guaranteed to stop at the end of the function when hid_hw_stop() is called.

If a hardware event arrives after the cancellation but before hid_hw_stop(),
could it re-queue work_connect via steam_raw_event(), leaving the work pend=
ing
after the driver finishes removal and frees the device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729015243.1170=
573-1-vi@endrift.com?part=3D8
