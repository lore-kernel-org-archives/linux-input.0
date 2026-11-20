Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167292;
	b=q/RFUYtehiXSmlhRv2XGqLeN++5/nbWPY1ZANMz+vY+3J/AhhgQORBGsJOYXOCyJewyO
	 o8+t1rCVIDbqn9R7USLOs7Rqs7PQJT0JShfJdxFw3VY4J+syb3r81GzaGFBWUhBONbvQc
	 2UzX32gRmSnA6DC0UjAuomC6Bwg6AkP68B9PXngLzgOVqDWF+EwVoK7wHFE4Yz59JLFLH
	 wpy9xXkino6t525xCfsxsBL07HM9sev0w+5J9CzzCmDWYBLCi/EES3x8Das0x0kxOe7Gh
	 JwvDS7P9Hwx0KM9acuR2a4izQZQLs7SP3R3dCFp5ANhXP9y4DNmI3NdJvp18Aqshakw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167292;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=//8vPCJvwnje4QQFveQhzSKC5C4LLObuXgIa26tTDEU=;
	b=T3XwRo6xEAEqPfkXfbb6hfz3+pciSIGzZLileCdzvJAqjsdwEb/789iI/Jvst25vZNOu
	 nzlDg6XAB2yaGaMkk9YwBbG0aVIhRSfYIbzo7+0Sjcy80U6Fe1hgxzO/9KeB7IyGo4msT
	 nHT7l0q2X0uFuLZu8Sv/pKJMIsES2lmcLw0ivbvJiJOJfxW903qQnF9eYCV7QRP1Pqb6F
	 44cbt46azDgDlKtspyME3pmp10+DxM2klzm82vDPM9vCe+PNvowshdGe4YrDU2OpNc/rn
	 naIj47080luhJSpP7kKliCTZgohefwGzsqvicaYSR2Fdwwe3cGjM4sIwEn0JZwhS2jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMybuWJo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048D606A320
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMybuWJo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC7B1F000C4;
	Fri, 20 Nov 2026 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795167292;
	bh=//8vPCJvwnje4QQFveQhzSKC5C4LLObuXgIa26tTDEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMybuWJoy8l1aVQUUs/sTnxOZii1VMzntjan2Ru6Xw4VKS9QmeZjOLPyi/6rgJcVf
	 my0Z4srXM4ed4kX5EGieopmEfD4DKXT7kLKIIAsbnV+wTNdMEqW7yncN6UIbFsSaGh
	 4/YX/aq3Z3rukkluRuj6qreJIx3Wtlf5KAK4h3q9OOdpURnnxJZWPLccBh6N3dIMOM
	 aC9fptlInJCkhFbyQdamo3+ht23UdM5A6wl6m4Yxdk9UNbqN42CbYwgv/gh1IufQqN
	 Z/L3R7tsQ9loBnxzkihXHF7UnkEc7e02YF9GbB/dW3Vdo5BoPBQRoYhDaztwbOsJ/9
	 IeR2cPlQk6+pw==
Message-ID: <sashiko-outbox-224861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: sensor-hub: Avoid holding spinlock across child
 iteration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zheng Shuhao" <viennaoffh@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 09:34:51 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: sensor-hub: missing Fixes trailer for commit 8a5b38c3fd70
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] HID: sensor-hub: NULL pointer dereference in
  sensor_hub_finalize_pending_fn() [1]
--

commit 243a16dd0439f8612b7bbc316ea2122b572ceb3b
Author: Zheng Shuhao <viennaoffh@gmail.com>

> HID: sensor-hub: Avoid holding spinlock across child iteration
>
> syzbot reports a SOFTIRQ-safe -> SOFTIRQ-unsafe lock order warning during
> sensor hub removal.
>
> sensor_hub_remove() currently holds sensor_data->lock while calling
> device_for_each_child(). The child iteration enters the device core and m=
ay
> acquire the klist lock. Since sensor_data->lock is also acquired with
> interrupts disabled by sensor_hub_raw_event(), lockdep reports a possible
> lock-order inversion.
>
> The callback only needs sensor_data->lock while checking pending.status a=
nd
> completing pending.ready. Pass sensor_data to the callback and take the l=
ock
> only around that short critical section instead of holding it across
> device_for_each_child().
>
> This preserves synchronization of pending.status while avoiding the lock-=
order
> dependency between sensor_data->lock and the device core's klist lock.
>
> The syzbot report is available at:
> https://syzkaller.appspot.com/bug?id=3Dc7c429f6851638ece81338f90c5b29ac9c=
0dea1f
>
> Testing:
> - Reproduced the target lockdep warning with the unmodified kernel in 3/3
>   two-CPU QEMU runs.
> - The warning was absent with this patch in 3/3 equivalent runs.
> - Ran the HID selftests against both baseline and patched kernels:
>   hid_bpf: 45 passed, 1 skipped, 0 failed
>   hidraw: 27 passed, 0 failed
>   hid-core, hid-apple, hid-gamepad, hid-ite, hid-keyboard, hid-mouse,
>   hid-multitouch, hid-sony, and hid-tablet all passed in both runs.
> - hid-usb_crash.sh and hid-wacom.sh produced TAP 1..0 / rc=3D2 in both
>   kernels because no executable test cases were collected in this minimal
>   QEMU environment.
> - No KASAN report, use-after-free, Oops, BUG, panic, or general protection
>   fault was observed.
> - checkpatch.pl --strict --no-signoff reports 0 errors and 0 warnings.
>
> Reported-by: syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.ap=
pspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=3Dc7c429f6851638ece81338f90c=
5b29ac9c0dea1f
> Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
> Tested-by: Zheng Shuhao <viennaoffh@gmail.com>

[Severity: Low]
This fixes the device_for_each_child() call under data->lock added in commit
8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-data on
remove").  Should this include:

  Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-data =
on remove")

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 028e70ec7bace..81015f5b82359 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -836,9 +836,13 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
>  {
>  	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> +	struct sensor_hub_data *sensor_data =3D data;
> +	unsigned long flags;
> =20
> +	spin_lock_irqsave(&sensor_data->lock, flags);
>  	if (hsdev->pending.status)
>  		complete(&hsdev->pending.ready);
> +	spin_unlock_irqrestore(&sensor_data->lock, flags);

[Severity: High]
This problem wasn't introduced by this patch, but can hsdev be NULL here and
cause a NULL pointer dereference [1]?

When CONFIG_HID_BATTERY_STRENGTH is enabled and a composite HID sensor hub
device also exposes a battery strength usage, hid_hw_start() ->
hidinput_setup_battery() registers a devm-managed power_supply child device
under &hdev->dev with dev->platform_data set to NULL.  On teardown,
sensor_hub_remove() runs before hid_device_remove() releases the devres
group, and hid_hw_stop() only removes input_dev children, so the
power_supply child is still attached when device_for_each_child() calls
sensor_hub_finalize_pending_fn().

[1] https://sashiko.dev/#/bug/linux-23655093-642a-447c-b416-776e47c98d55

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1795161418.hid-sens=
or-hub@viennaoffh.gmail.com?part=3D1
