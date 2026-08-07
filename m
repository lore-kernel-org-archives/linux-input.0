Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C63A784F
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068428; cv=none; b=OsmxFTSsldEDSdYEFMBbdRFe/AdayETFJrkvzdM07SVD5lRBOywSv7LJD1kH3lZyknsJ8g33lKMC7W2i6E05LOaTU6CIOpJ44tjfISf9sYwGVJq1YGBNrKBs2rrZt7pUd6HSZHvT2kcEFbGRhSkK+lR9XPnRxx9PVrKd6WRZGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068428; c=relaxed/simple;
	bh=alFkPKYMbgUECCazKUG+eGLpjhtMTMh0AznUtvYE5n8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W7fN0+RsKcD9IEf4O1GdJbUzWMvfHdN8MiqZqstFQqBJ6lLPWfoHDUDxaMN4N9JuTzY+kWREM6OEQ8JhcEsixnN0qyinuW1Qm6J5qnxm0HAZPX8kXnUQ1TYaZ4fR9gaTqZOqvwAE+VK48787CeP+I0wCnDWh/q7fJgyCc+tXTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3zBAx3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3zBAx3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611381F000E9;
	Fri,  7 Aug 2026 02:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786068426;
	bh=HBKd/Jb2i+rP0pgSYlBOprr9ZsYzsQHD0SZ5k+5afyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R3zBAx3pr9JMVCyseABrBOE98A1Dk9/p5LfwZUnMLPQdtjhWH1SWWbrFdbYncLGOW
	 V5Mfv7hmKav9VzbaFoT+iHV3RqSDexql48mTlUn3ABBXfb/tUrG3jxLiDVMy5OQ0s4
	 uxx0oA8NHbfGOQlszJ3qew1vcEFRRY03J7XVerWOiW1GpWrqe9o9hYDL2igN3BIp2O
	 h3/0JFAGAEffqi2xtPsWYTNWEHvoqXaJ0JIgxT8RvBTEkD0gBuUx5UnStm+cZEAqCT
	 jBw7h7+rFTmi50hPvBSM8TQ8InWjeAN6diciVHH46Td5NDjCi6er9nma+qKNVnAHoS
	 4tkRMDbI1mh9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] HID: steam: Initial 2026 Steam Controller
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260807013334.2109386-3-vi@endrift.com>
References: <20260807013334.2109386-1-vi@endrift.com>
 <20260807013334.2109386-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 02:07:05 +0000
Message-Id: <20260807020706.611381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of `steam_register` between `steam_probe` and=
 `steam_work_connect_cb` leads to data races, double registration, memory l=
eaks, and Use-After-Free (UAF).
- [High] Teardown ordering in `steam_remove` incorrectly cancels works befo=
re stopping hardware events, leading to Use-After-Free.
--

--- Patch [2]: [PATCH v3 2/6] HID: steam: Initial 2026 Steam Controller sup=
port ---
commit d704660582137e2d95967bceb5a602df38e73e5e
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: steam: Initial 2026 Steam Controller support

This commit brings support for the 2026 Steam Controller, adding new
capabilities comparable to the Steam Deck. It also includes cleanup of
the registration flow to make it cleaner and avoid potential pitfalls.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 967f12c7a599a..ec7ccbe5aba09 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -1139,61 +1371,49 @@ static void steam_battery_unregister(struct steam=
_device *steam)
>  static int steam_register(struct steam_device *steam)
>  {
>  	int ret;
> -	unsigned long client_opened;
> -	unsigned long flags;
> -	bool do_add;
> =20
>  	/*
>  	 * This function can be called several times in a row with the
>  	 * wireless adaptor, without steam_unregister() between them, because
>  	 * another client send a get_connection_status command, for example.
> -	 * The battery and serial number are set just once per device.
>  	 */
> -	if (!steam->serial_no[0]) {
> -		/*
> -		 * Unlikely, but getting the serial could fail, and it is not so
> -		 * important, so make up a serial number and go on.
> -		 */
> -		if (steam_get_serial(steam) < 0)
> -			strscpy(steam->serial_no, "XXXXXXXXXX",
> -					sizeof(steam->serial_no));
> -
> -		ret =3D steam_get_attributes(steam);
> -		if (ret < 0)
> -			hid_err(steam->hdev,
> -				"%s:steam_get_attributes failed with error %d\n",
> -				__func__, ret);
> +	if (steam->registered)
> +		return 0;

[Severity: High]
This is a pre-existing issue, but does this lockless check allow concurrent
registration?

When hid_hw_open() is called in steam_probe(), the hardware can immediately
generate a wireless connect event. This triggers steam_do_connect_event(),
which schedules steam_work_connect_cb() to run on a workqueue concurrently
with the remainder of steam_probe().

Both threads call steam_register(), which performs a lockless check of this
registration state. Both threads can see it as false and concurrently execu=
te
the registration sequence.

This results in multiple concurrency bugs: steam_battery_register()
concurrently allocates and frees steam->battery_desc.name using
devm_kasprintf()/devm_kfree(), causing the power supply subsystem to access
freed memory (UAF). Additionally, input_allocate_device() is called twice
with the first pointer leaked via RCU pointer overwrite.

Does this need a lock around the registration check to prevent double
registration and memory corruption?

[ ... ]
> @@ -1219,7 +1440,6 @@ static void steam_unregister(struct steam_device *s=
team)
>  	mutex_lock(&steam_devices_lock);
>  	list_del_init(&steam->list);
>  	mutex_unlock(&steam_devices_lock);
> -	steam->serial_no[0] =3D 0;
>  }

[Severity: High]
This is a pre-existing issue, but does the teardown ordering in steam_remov=
e()
incorrectly cancel works before stopping hardware events, leading to a UAF?

During device removal, cancel_work_sync(&steam->work_connect) and
steam_unregister() are called before hid_hw_stop(hdev):

static void steam_remove(struct hid_device *hdev)
{
        ...
        cancel_work_sync(&steam->work_connect);
        ...
        steam_unregister(steam);
        hid_hw_stop(hdev);
}

While hid_hw_close(hdev) is called earlier, it only drops the logical open
count and does not reliably guarantee the immediate cessation of all incomi=
ng
hardware events across all possible low-level transport drivers.

Because hid_hw_stop() is the definitive function for stopping the underlying
transport and killing pending events, an incoming interrupt can trigger
steam_raw_event() in the window after the works are canceled but before the
hardware is stopped.

If a connect or disconnect event is received, steam_raw_event() calls
steam_do_connect_event(), which queues steam->work_connect. After
steam_remove() completes, devres frees the steam_device structure. When the
newly scheduled work executes, it accesses the freed steam_device, resulting
in a UAF memory corruption.

Should hid_hw_stop() be called before canceling the workqueues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807013334.2109=
386-1-vi@endrift.com?part=3D2
