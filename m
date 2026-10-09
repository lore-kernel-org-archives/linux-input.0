Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921AE49D5BB
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560723; cv=none; b=lNWB6AtRs4jkbI89l0Bapzl2zhw5EVl9+fOwuJHVUNO5oTOfkbN22HGkaLYkrgu60up4pXfw8OpRfci1sVRVdPmp6Y3+/PJx5tLG27PITOon3Bb5jROnCRPruJKY0+cHA8NV5XLI9DYHgSgUemo3nk1XdQtYjlHVZyGNHgGB4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560723; c=relaxed/simple;
	bh=MH8Rln4yhM2xMA8jOwT7wEryesOt1RmXY/ykHVKZVqQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oIpMIL+rux8Cu6R7X7oDAs0r0bbNVZ7zldelqQhEkGTDKMCwCMV5hAAQL/dKVAqX0XPCol/KbyyDi0FCTAG7KBDmenaxNZms5TPTq4vsIkSHb6tIV7vis/sJGPxT0czakImHh2PoQHY0fvd/80aPttjtEst7vadAk/H99iSgWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqdVhrPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqdVhrPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D131F000FF;
	Fri,  9 Oct 2026 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560719;
	bh=zfdljkRIW9NgHBbeIHMPvIHW1h5Unpj1CBlGOt8HPX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BqdVhrPjdDEmswzK3Beaoec+tORGB86ed93d6TVXptDW/eC4GX45Ni4nTi5YBCJld
	 w8lhLXQas8rs+o3pRAhj0rj0kDOfFuCxDzdlMzyR4aipU2cQ6ZnWMnIA+/e/DlN5pu
	 cIrlTj9pIMk2c1o13Gyuslm2tpPW8KNqXhKQWXBcrfInmNEq36Yol4cZi/1nygj4Dx
	 q824+wV7abfm1iv0Cyj8Qn36X90PeJ42xGg0bVjRxSAOKcJ0HsWEeDAOfaA00j6nur
	 VxTiaj4WppqTW8ddljzQtfciwZfSTv+VoszI1otMlcQqpt4eovRXv+/tSDXaNN+O1X
	 u7/3E2BXtfp7g==
Message-ID: <sashiko-outbox-165792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] HID: asus: Cycle the platform profile from the
 Zenbook Duo profile key
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261009153459.124752-5-p.pisati@gmail.com>
References: <20261009153459.124752-1-p.pisati@gmail.com>
 <20261009153459.124752-5-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 15:45:19 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: asus: ABBA deadlock between driver_input_lock and worker canc=
ellation in remove()
- [High] hid: asus: unbounded GFP_ATOMIC allocation in profile cycle event
--

commit f048215156fec2e6351754bc8e9e549f5a266615
Author: Joshua Leivenzon <hacker1024@users.sourceforge.net>
Subject: HID: asus: Cycle the platform profile from the Zenbook Duo profile=
 key

This commit adds support for the Zenbook Duo performance mode key by routing
the 0x9d vendor usage event to cycle the platform profile. The processing is
deferred to the driver's workqueue to avoid taking mutexes in the HID input
path.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -423,6 +425,28 @@ static int asus_kbd_fn_lock_set(struct asus_drvdata =
*drvdata, bool enabled)
>  	return 0;
>  }
> =20
> +static int asus_platform_profile_cycle(struct asus_drvdata *drvdata)
> +{
> +	struct asus_work_action *action;
> +	unsigned long flags;
> +
> +	if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
> +		return 0;
> +
> +	action =3D kzalloc_obj(struct asus_work_action, GFP_ATOMIC);

[Severity: High]
Can a flood of 0x9d HID events cause memory exhaustion?

For each incoming event, asus_event() calls asus_platform_profile_cycle(),
which performs a GFP_ATOMIC allocation and appends it to the worker queue
without any length limit.

If a device sends these events continuously at a high rate, and the workque=
ue
thread stalls on the profile_lock mutex in platform_profile_cycle(), could
this interrupt-driven URB completion handler exhaust atomic memory reserves
before the workqueue can process them?

> +	if (!action)
> +		return -ENOMEM;
> +
> +	action->type =3D PLATFORM_PROFILE_CYCLE;
> +	INIT_LIST_HEAD(&action->node);
> +
> +	spin_lock_irqsave(&drvdata->worker->lock, flags);
> +	asus_worker_schedule(drvdata->worker, action);
> +	spin_unlock_irqrestore(&drvdata->worker->lock, flags);
> +
> +	return 0;
> +}

[ ... ]

> @@ -788,6 +830,13 @@ static void asus_work(struct work_struct *work)
>  	case WMI_FAN:
>  		asus_kbd_wmi_fan(worker->hdev, &action->data.fan_hid_data);
>  		break;
> +	case PLATFORM_PROFILE_CYCLE:
> +		if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
> +			break;
> +		ret =3D platform_profile_cycle();

[Severity: High]
This problem wasn't introduced by this patch, but does relying on this work=
er
architecture expose an ABBA deadlock during device removal?

If a user presses the fan control key, the WMI_FAN action is queued. If the
WMI driver is unavailable, asus_kbd_wmi_fan() acquires driver_input_lock:

asus_kbd_wmi_fan() {
        ...
        down(&hdev->driver_input_lock);
        hid_report_raw_event(...);
        up(&hdev->driver_input_lock);
}

However, if the device is unplugged or unbound simultaneously, the HID core
acquires driver_input_lock in hid_device_remove() before calling asus_remov=
e().
asus_remove() then waits for the worker to finish:

asus_remove() {
        ...
        asus_worker_stop(drvdata->worker);
            -> cancel_work_sync(&worker->work);
        hid_hw_stop(hdev);
}

This creates a situation where the worker thread blocks indefinitely on
driver_input_lock, while the remove thread blocks indefinitely waiting for =
the
worker via cancel_work_sync().

Since this patch extends the same worker thread design, could this lead to a
system hang if device removal races with the workqueue?

> +		if (ret)
> +			hid_dbg(worker->hdev, "Failed to cycle the platform profile: %d\n", r=
et);
> +		break;
>  	default:
>  		hid_err(worker->hdev, "Invalid action type: %d\n", action->type);
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009153459.1247=
52-1-p.pisati@gmail.com?part=3D4
