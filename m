Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73724227BB9
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468376; cv=none; b=aRW+rqaLvrf+sBY9ImFrPli4wnDu8k3/Bh8qbCLbO//nu1Q298mVGfKQWKxDmfksdimwMybHKu4pW9UsFcklMb7RiNZ2UrU6odaVjZAyADhQze6cGwO7vVdl3YOMNVvhXIU371FPvN1F16WFDPL8b0oq4B26DcUZ50H7YXDmxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468376; c=relaxed/simple;
	bh=pavoN57pWScSAGdID5mpnxJtTWMKHeRatrhWV2aHaMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a+ACnx95mKq9/uQUbNB+aq5QACp6PWQ9HU1xM2R1I2DeLnYWYkjy7+5RDdO+S3RU5rrzUXdjPzs6PIsCQsg67WLfjl8DqEIJ3ZhkL6IuiALTgwDH/wCoOvT3aFqM3pJ6m6ZirjUyHFVJ8S0cD30DlaIpOf2wtG7xyP13d68kLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsK4vy4t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsK4vy4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055FA1F000E9;
	Tue,  7 Jul 2026 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783468375;
	bh=H9wvs2ScKb0rhnUHYydEgRVToCg+MkUhmw915GWsmdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bsK4vy4tTmbHxlAOGG8gNR9zuJi1mSc3DD+IR+fnicCOF20cuYehjGPM4F9V04HZi
	 BZvKpuD5KLJkPLSB/04LjrlB62ttkphYq1Xb38qCIssIsiJTH04Ah+Orie2+O6/RSR
	 xw6ZjdCknN4QIhKq4/l50u4+9cXB96ECNyMIP13hEWdNYwetJO+Tvn6/5wKAzwveWU
	 KW3IiWwzd1KnT/+rBa95hKF5DNDizjv5LOW8C+Bzc+od5MkbU3rJO5Gisl2XSydveR
	 Q7CwNHo6+rlb9ImYGnxkGjdoTrJWSThCg30gq2DLfYXw9fNEG6Rcg+0wC0nf/FOF05
	 0biW/MBjXp+zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] HID: steam: Fully unregister controller when
 hidraw is opened
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260707233241.2644971-7-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
 <20260707233241.2644971-7-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 23:52:54 +0000
Message-Id: <20260707235255.055FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Memory leak of devm-allocated battery name if power_supply_regis=
ter() fails.

Pre-existing issues:
- [High] Race condition in steam_remove leading to Use-After-Free of steam_=
device.
- [High] List corruption and Memory Leak when steam_register fails during p=
robe.
- [High] Race condition in hidraw open/close callbacks leading to Use-After=
-Free.
- [High] TOCTOU race in steam_raw_event accessing steam->client_hdev during=
 device removal.
--

--- Patch [6]: [PATCH v2 06/10] HID: steam: Fully unregister controller whe=
n hidraw is opened ---
commit d361e686d46a1745e3d9d699aff5bb87aea155b9
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Fully unregister controller when hidraw is opened

This patch changes the driver to fully unregister the controller internally
when hidraw is opened, rather than just detaching the evdev nodes. This
also unifies the unregister and connect callbacks.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 5537488139011..3f1dbdcad23c8 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -1077,6 +1076,7 @@ static void steam_battery_unregister(struct steam_d=
evice *steam)
>  	RCU_INIT_POINTER(steam->battery, NULL);
>  	synchronize_rcu();
>  	power_supply_unregister(battery);
> +	devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
>  }

[Severity: Medium]
If power_supply_register() fails in steam_battery_register(), steam->battery
is not set. When this unregister function is called, an early return on
!battery could skip this newly added devm_kfree():

steam_battery_unregister()
{
        ...
        if (!battery)
                return;
        ...
        devm_kfree(&steam->hdev->dev, steam->battery_desc.name);
}

Since this unregister function is now dynamically triggered every time the
hidraw node is opened, could an unprivileged user repeatedly open and close
the hidraw node to continuously leak the devm-allocated string?

[ ... ]

> @@ -1277,7 +1255,7 @@ static int steam_client_ll_open(struct hid_device *=
hdev)
>  	steam->client_opened++;
>  	spin_unlock_irqrestore(&steam->lock, flags);
> =20
> -	schedule_work(&steam->unregister_work);
> +	schedule_work(&steam->work_connect);
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but releasing the lock here befo=
re
scheduling work appears to open a race window:

steam_client_ll_open()
{
        ...
        spin_unlock_irqrestore(&steam->lock, flags);
        schedule_work(&steam->work_connect);
        ...
}

If the thread is preempted immediately after releasing the lock, and the
physical device is removed concurrently, steam_remove() could execute, free
the steam structure, and leave the resumed schedule_work() call to access
freed memory. Is there a way to safely synchronize this against device
removal?

[ ... ]

> @@ -1389,7 +1367,6 @@ static int steam_probe(struct hid_device *hdev,
>  		steam->sensor_update_rate_us =3D 4000;
>  	else
>  		steam->sensor_update_rate_us =3D 9000;
> -	INIT_WORK(&steam->unregister_work, steam_work_unregister_cb);

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the error handling
path in steam_probe() since it is closely related to driver registration:

steam_probe()
{
        ...
        ret =3D steam_register(steam);
        if (ret) {
                hid_err(hdev, ...);
                goto err_hw_close;
        }
        ...
}

If steam_register() adds the device to the steam_devices list, but a
subsequent step like steam_input_register() fails, steam_register() returns
an error but leaves the device on the global list.

Since the err_hw_close path bypasses unregistering, could this lead to a
use-after-free when the lizard_mode module parameter later traverses the
steam_devices list?

[ ... ]

> @@ -1470,7 +1446,6 @@ static void steam_remove(struct hid_device *hdev)
>  	cancel_work_sync(&steam->work_connect);
>  	cancel_work_sync(&steam->rumble_work);
>  	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> -	cancel_work_sync(&steam->unregister_work);
>  	steam->client_hdev =3D NULL;
>  	steam->client_opened =3D 0;

[Severity: High]
This is a pre-existing issue, but does calling cancel_work_sync() here befo=
re
stopping the hardware leave a race window?

steam_remove()
{
        ...
        cancel_work_sync(&steam->work_connect);
        ...
} // hid_hw_stop() is called later

Because the HID hardware is still active, could an incoming connection event
interrupt trigger steam_raw_event() and re-schedule work_connect after it w=
as
canceled?

Once steam_remove() completes and frees the steam object, this might cause =
the
workqueue to execute the asynchronous callback using the freed steam struct=
ure.

[Severity: High]
This is also a pre-existing issue in the raw event handler, but could this
unlocked check lead to a time-of-check to time-of-use race?

steam_raw_event()
{
        ...
        if (steam->client_opened)
                hid_input_report(steam->client_hdev, ...);
        ...
}

If the thread is preempted after reading a non-zero client_opened value, and
the physical device is concurrently unplugged, steam_remove() could run and
destroy client_hdev.

When steam_raw_event() resumes, will it attempt to call hid_input_report()
with the freed steam->client_hdev pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707233241.2644=
971-1-vi@endrift.com?part=3D6
