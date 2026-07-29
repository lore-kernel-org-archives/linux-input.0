Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F333344A
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291036; cv=none; b=uoquQ2B3B24/IFyEd3mAZJ0oTqocTTDatWhoF4tOYArdWadUEfUBryhsMWbOpAf7KuEw5gVYCmDPO0s44XN5EAJ/5RO9GKDpvFete3y4gG9j3iOsUmKTg4p1lAcFpuueYFnJzJVqd0W5TQfPb8lUdxLm2P1sSH4rNssR/MD4+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291036; c=relaxed/simple;
	bh=PnlIaLIoCgIuiz2414IvcHd4cgmgSCFNiLvogpfHksk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fppUdDbCXwxxOxg4ocUWaoey39QSZpfF9L5N1Np8cDywUYij234ShUBoIRhWEgwpP1kH1rZQmoyjbKOodXZnVg5Ralk7vwUQAXGkLdaQY/utFgOd3zZvxj7szt6wfaT/z62+HVO/lA2yn/2G/JmwEJwmCzwDNPWWmU48RyJq3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMQIvmqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMQIvmqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2371F000E9;
	Wed, 29 Jul 2026 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785291032;
	bh=5Y+nHeScO4N++TT3Oim/IYUGCB6TC2zMfACeHzcT5EU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMQIvmqIxelx/G4RD9dlXKYTx3/sgspOKseEIA3uAKPibB2IWYub0b+GkC7IS3i41
	 mQr82fKsAK10rlYiBQfOcRkL+JEcTqlf37WyDLFlKgBmDVRIqGdgXRBwE6W9BbPEq5
	 VFGa6OUdysI/MBjJ6vVZEYEXs5uyjYThyzYpHaYiOoMAiUYLioR/wQGNzJxg+aM4qZ
	 W07uFqw755rouoqyPUS7/uiiUecYE5ruVGMBWTwOyM20LcOPLQtgLTFjSl0AtokYWN
	 WExGhkoa1+cvPkx928FIKX5JKfJ407NnhN/JGi0T3VK0ncT2c7zDzkHAdm/0mzplVF
	 mtE8YzOhv/jrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/11] HID: steam: Zero-initialize reply in serial
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729015243.1170573-5-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
 <20260729015243.1170573-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 02:10:32 +0000
Message-Id: <20260729021032.9C2371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper teardown ordering in `steam_remove()` allows works to be =
re-scheduled and execute after `steam_device` is freed.
- [High] Race condition in `steam_probe()` error path allows a background w=
ork item to register a device and corrupt global state after error unwindin=
g.
--

--- Patch [4]: [PATCH v4 04/11] HID: steam: Zero-initialize reply in serial=
 lookup ---
commit 3fb5af0927e3da21c09244521c52f446d7eb0ba2
Author: Vicki Pfau <vi@endrift.com>

    HID: steam: Zero-initialize reply in serial lookup

    This patch eagerly zero-initializes the reply buffer in steam_get_seria=
l()
    instead of just null-terminating it at the end. This prevents potential
    leaks of uninitialized memory in error logging paths.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 983d18d1de4fe..8bad79205b570 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -447,7 +447,7 @@ static int steam_get_serial(struct steam_device *stea=
m)
>  	 */
>  	int ret =3D 0;
>  	u8 cmd[] =3D {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB=
_STR_UNIT_SERIAL};
> -	u8 reply[3 + STEAM_SERIAL_LEN + 1];
> +	u8 reply[3 + STEAM_SERIAL_LEN + 1] =3D {0};
> =20
>  	mutex_lock(&steam->report_mutex);
>  	ret =3D steam_send_report(steam, cmd, sizeof(cmd));

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for works to
be rescheduled after they are cancelled in steam_remove()?

Looking at the code, it appears work items are cancelled before the hardware
events are stopped:

drivers/hid/hid-steam.c:steam_remove() {
    ...
	cancel_delayed_work_sync(&steam->mode_switch);
	cancel_work_sync(&steam->work_connect);
	cancel_work_sync(&steam->rumble_work);
	cancel_work_sync(&steam->unregister_work);
    ...
	hid_hw_close(hdev);
	hid_hw_stop(hdev);
}

If the hardware is still active, could incoming events trigger
steam_raw_event() and reschedule these works?=20

Since steam_device is allocated via devm_kzalloc(), could this lead to a
use-after-free if the device is unplugged and a pending work later accesses
the freed memory?


[Severity: High]
This is a pre-existing issue, but I have a question about whether the error
handling in steam_probe() properly synchronizes with the background worker
thread.

If an error occurs during probe (for example, if steam_create_client_hid()
fails), the error path executes:

drivers/hid/hid-steam.c:steam_probe() {
    ...
err_steam_unregister:
	if (steam->connected)
		steam_unregister(steam);
err_hw_close:
	hid_hw_close(hdev);
err_hw_stop:
	hid_hw_stop(hdev);
err_cancel_work:
	cancel_work_sync(&steam->work_connect);
    ...
}

If the hardware concurrently triggers steam_work_connect_cb(), could the
worker thread be executing steam_register()?

In this scenario, steam_unregister() might do nothing if steam->serial_no
isn't set yet. Then cancel_work_sync() would block until the worker finishes
registering the input device and adding it to the global steam_devices list.

Once steam_probe() returns and the driver core frees the steam_device memor=
y,
could this leave dangling pointers in the global list and input subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729015243.1170=
573-1-vi@endrift.com?part=3D4
