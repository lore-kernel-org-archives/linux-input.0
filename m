Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76D28488F
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162835; cv=none; b=sRyG7yJbQJ79KVyeeX3TgbNcxCIAuoXFp5L9Otj0BJJMQXxb1vsmVanfKoxCB5uDrSMS/qmPYl6ayDLG2xOoRgu9VOB3zzw5qSbAEDoX4BipV1ZWH762BgmRqfaeHzyPaPSwq09aaVTs3g1emcGE7VVwZ0LWt7/diL7xupBQ8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162835; c=relaxed/simple;
	bh=7S+iUy5eArRJMvzBLpuo2DioLGXOoypvCvSXr7EZT0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iAPBMiqsR51HD/s0fd3NM4TtAtcAjJqyhyVE/UAiW2JDUGbLr6EjLXdZKY9uD+ecbvaDPmzlrsZFAsYe1Hzxq2GHP2aOdIDaHCtt8SAv3JxjKCPjXQd992EBpj1uovPm5WqHDfLSlvwR3CLa45+qn3eRZWzL9QviygC0/3401xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOHidzNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOHidzNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEBB1F000E9;
	Mon, 31 Aug 2026 07:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788162833;
	bh=uRF6vhfvrmr0m7fzEbjV5DcsPzC7DAQsK6qj4J9Ik0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOHidzNb+D/dQNMrTY2VPuarkCZpKWTvry4H7VhHgjSEZ2DGeJ9zt3/0fH0pAcvWW
	 DGPmwtppNA2tlP2EluOzKnslhl6d33U1el58rg9hRD2JC2bqGuoGvPWLLpQxQlOCHr
	 1vSc9BIFJoWqxHvoErHKvRKoq60KShhRUJmkG4b4OKf3xYVHCtlh5wHxoawFcQvDyC
	 gHwRaZ5z6USQkAeEtOykudiv+g/YgPGgq9WFNaSX1QM+AiBhlNbELTtJiQ80CSXvjT
	 xsZfmyDdPzY0XPyYvX9cQsf7ArOnX72WUpZxWKsBLWA6pXXlRWwpVv1DQ77m/gD/oR
	 gepDe9Nr+v5ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: corsair: do not re-schedule LED worker after it
 has been cancelled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260831074130.71683-1-chenchangcheng@kylinos.cn>
References: <20260831074130.71683-1-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:53:53 +0000
Message-Id: <20260831075353.9EEBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The lockless `led->removed` flag check leaves a TOCTOU race wi=
ndow, allowing concurrent sysfs writes to schedule work after `cancel_work_=
sync()` has completed, leading to a Use-After-Free.
- [Medium] The patch prevents the physical LED from being turned off when t=
he driver is unbound or fails to probe.
--

commit 682f4ec73cf3b2f84d2fd794aa7a7a3df0638944
Author: Chen Changcheng <chenchangcheng@kylinos.cn>

HID: corsair: do not re-schedule LED worker after it has been cancelled

This commit attempts to fix a use-after-free issue by setting a removed
flag to prevent a cancelled LED worker from being re-scheduled during
device unregistration. It adds a check in k90_brightness_set() and
adjusts the probe error path teardown order.

Link: https://lore.kernel.org/all/6a937393.1d9ded08.62e62.0113.GAE@google.c=
om/

> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 278c6efb565df..73b3c1ff78c6d 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c
> @@ -194,6 +194,9 @@ static void k90_brightness_set(struct led_classdev *l=
ed_cdev,
>  {
>  	struct k90_led *led =3D container_of(led_cdev, struct k90_led, cdev);
> =20
> +	if (led->removed)
> +		return;
> +

[Severity: Medium]
Does this prevent the physical LED from being turned off when the driver
is unbound or fails to probe?

During unbinding or a probe error, led->removed is set to true before the
driver calls led_classdev_unregister(). The LED core attempts to cleanly
turn off the hardware by calling led_set_brightness(led_cdev, LED_OFF).
This call reaches k90_brightness_set(), which immediately returns due to
this check, silently dropping the hardware command and leaving the LEDs on.

[Severity: Critical]
Can this lockless check cause a memory corruption due to a Time-of-Check to
Time-of-Use race?

If a thread performing a sysfs write enters k90_brightness_set(), evaluates
led->removed as false, and is preempted:

Another thread handling cleanup can set led->removed to true and call
cancel_work_sync(), which returns immediately since no work is queued yet.
When the cleanup thread calls led_classdev_unregister(), it blocks in
device_unregister() waiting for the sysfs active reference to drain.

The sysfs thread can then resume, execute schedule_work(&led->work),
complete the write, and drop the reference. The cleanup thread unblocks,
finishes unregistration, and calls kfree(), leaving the workqueue to
execute the queued work using the freed memory.

>  	led->brightness =3D brightness;
>  	schedule_work(&led->work);
>  }

[ ... ]

> @@ -507,8 +510,8 @@ static int k90_init_macro_functions(struct hid_device=
 *dev)
> =20
>  fail_sysfs:
>  	k90->record_led.removed =3D true;
> -	led_classdev_unregister(&k90->record_led.cdev);
>  	cancel_work_sync(&k90->record_led.work);
> +	led_classdev_unregister(&k90->record_led.cdev);

[Severity: Critical]
Does propagating this teardown ordering into the probe error path cement
the race condition discussed above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831074130.7168=
3-1-chenchangcheng@kylinos.cn?part=3D1
