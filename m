Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4BA1531E8
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649932; cv=none; b=IwydcON4J/tunl71MOuoE4YUsVV800OGxlDHwYvOfXBVl8xhnzpHcgVdJU+T6T2kAiYD4zjFfTaPW4FIQo6VWAHJi0qlnYmeTF4rfWaIxrFG/rsPKTiYXI6EPjKyyMpCzsdHD4jGEqMFVjXyHobRtI54xygCUpt4Qyk/A7T/aYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649932; c=relaxed/simple;
	bh=HM5k/ZokxhrD87FDxYcKK9cMLzAfufV/l8BwD5H7RWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iRODZsOEAKr/5zgb/ZnF/3kM1Yp2ZzPsoUx8othcWgVcIllsGKHWz7RD7jZG5PtYRz5XdQXndl93Bo+W3uY9RrndJ9RjaS1gwVQ8mavnF9A8I3Yd2o3t/LaZbi4f9bDY+WHogC3wS8+M09nueRKf9av9JwiS/NKD/HgMGbPrh8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f454lhgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f454lhgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D8B1F000E9;
	Fri, 10 Jul 2026 02:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783649931;
	bh=ZnLk6HSOaVCaIkYlP+xHAciINU30hT+WR3jZ3ioN94c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f454lhgyN+8/9XEmc7sR9AJwI79dm3vgt1ASie7srLKGLcljhtJniTOS0ff3WT5sm
	 EroyO0uVXwM/Ovx4Hk7FmoO3cKqX3tRJTcAkSJZ8mvzhO9sK4L2jXKmRWC8fdkEzT1
	 F40Exr3ByPhui7VrSEIqDPC7kLg8zhNpi8mljvFUTQilDFgKX4NOWe9sK69bfX6YNb
	 T+QQvkSW7aO3rTN8ercUYvnnim3Hwi+cNWjjVUF4ss6wHMWIvjXUbD9/WCydjcr3q1
	 Lj5oml20oKN8VX15N8jbtqGY5xQG+KvhUa7JbEyMY0evob1Dt4ZJfHFfubG+q0S6Ip
	 +Ylt/8xRXyjCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] HID: steam: Rearrange teardown sequences
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710020048.2337655-8-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
 <20260710020048.2337655-8-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:18:50 +0000
Message-Id: <20260710021850.B7D8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Moving hid_hw_start before initialization creates a window for=
 Use-Before-Initialization
- [Critical] Probe error path skips cancellation of work_connect and mode_s=
witch

Pre-existing issues:
- [Critical] Hardware interrupts can re-queue work_connect after it is canc=
elled during teardown
- [Critical] Failure inside steam_register leaves dangling pointers in a gl=
obal list
- [Critical] Incoming reports can access a freed client_hdev due to lockles=
s state checking
--

--- Patch [7]: [PATCH v3 07/10] HID: steam: Rearrange teardown sequences ---
commit 9242f209b3856143cba9d679406bd9c9784d93c2
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Rearrange teardown sequences

This patch fixes a narrow window during the teardown sequences in probe
and remove where callbacks could still be scheduled during cleanup. It
reorders the teardown steps to prevent dangling pointers to the freed
steam struct.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 0771ad4f5f2c2..9dc77cd76edb0 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1353,6 +1354,14 @@ static int steam_probe(struct hid_device *hdev,
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

[Severity: Critical]
Does calling hid_hw_start() here enable hardware interrupts before the
steam struct is fully initialized?=20

If an unprompted wireless connect event arrives immediately after
hid_set_drvdata(), could steam_raw_event() -> steam_do_connect_event()
attempt to acquire the uninitialized steam->lock and pass a zero-initialized
steam->work_connect to the workqueue?

[ ... ]

> @@ -1398,14 +1391,22 @@ static int steam_probe(struct hid_device *hdev,
>  			hid_err(hdev,
>  				"%s:steam_register failed with error %d\n",
>  				__func__, ret);
> -			goto err_hw_close;
> +			goto err_hw_stop;
>  		}
>  	}

[Severity: Critical]
If steam_register() fails and jumps directly to err_hw_stop, does this bypa=
ss
the cancellation of work_connect and mode_switch at the err_steam_unregister
label?=20

Since hid_hw_start() is now called earlier, could an incoming interrupt have
already scheduled these works, resulting in a use-after-free when the steam
struct is freed?

[Severity: Critical]
This is a pre-existing issue, but if steam_register() fails here:

drivers/hid/hid-steam.c:steam_register() {
    ...
    mutex_lock(&steam_devices_lock);
    if (list_empty(&steam->list))
        list_add(&steam->list, &steam_devices);
    mutex_unlock(&steam_devices_lock);
    ...
    if (!client_opened) {
        ret =3D steam_input_register(steam);
        if (ret !=3D 0)
            goto steam_register_input_fail;
        ...
}

Since the error path jumps to err_hw_stop, bypassing steam_unregister(),
does this leave a dangling pointer to the freed steam struct in the global
steam_devices list?

[ ... ]

> @@ -1436,25 +1439,27 @@ static int steam_probe(struct hid_device *hdev,
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

[Severity: Critical]
This isn't a bug introduced by this patch, but calling
hid_destroy_device(steam->client_hdev) before clearing steam->client_opened
seems risky.

Since steam_raw_event() checks client_opened without holding locks or memory
barriers:

drivers/hid/hid-steam.c:steam_raw_event() {
    ...
    if (steam->client_opened)
        hid_input_report(steam->client_hdev, HID_FEATURE_REPORT,
                         data, size, 0);
    ...
}

Could a concurrent interrupt read a stale non-zero value for client_opened
and access the already-freed client_hdev?

> +	cancel_work_sync(&steam->work_connect);
>  	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
>  		hid_info(hdev, "Steam wireless receiver disconnected");
>  	}
> -	hid_hw_close(hdev);
> -	hid_hw_stop(hdev);
>  	steam_unregister(steam);
> +	cancel_work_sync(&steam->rumble_work);
> +	cancel_delayed_work_sync(&steam->mode_switch);
> +	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> +	hid_hw_stop(hdev);
>  }

[Severity: Critical]
This is a pre-existing issue, but does calling
cancel_work_sync(&steam->work_connect) while hardware interrupts are still
active leave a race window?

If another user has the device open, hid_hw_close() doesn't fully stop the
transport interrupts until hid_hw_stop() is called.=20

Could an incoming ID_CONTROLLER_WIRELESS report trigger
steam_do_connect_event() and unconditionally re-queue work_connect after it
was cancelled, leading to a use-after-free when the steam struct is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710020048.2337=
655-1-vi@endrift.com?part=3D7
