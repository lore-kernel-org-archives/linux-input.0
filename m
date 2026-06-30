Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061F37A498
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810474; cv=none; b=b6Kc7XeCBs0EK5oGuUeIk+HOpdsxK86Gl2zQut+AigAOIWRymWOxu0YvvCc/wmyKz8OQA1k4WkFl8LhGf8FgJj4M0O4oLn6/f1g+p1GhGb3Vh/4KEHOsqVoNMAPXMnEwflbBMxdGdKYol+8AZY9mQs27f+T5QsgvV9Ti5RAi2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810474; c=relaxed/simple;
	bh=plm8L2Jt5sQr02Az7mKNE4nJ+96WgXXQNPoSgDyXuUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ue3W094GF5dU615cr6C/FukVyexngWbIH6dzzEniFB/suwxnQpDsl/M/Jislkh/6pdabSaw9i6HTmi995wm8jeohXL5MAWxc1CsD7BpzHAqAmeBiprUPEvdcsSTJhQfbwo1JBuC150HgX9bofz6+/kke0OoS5sivkyH1uirxr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh6KZLqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh6KZLqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D111F000E9;
	Tue, 30 Jun 2026 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782810473;
	bh=0qYzEn13Kg3gX3o0Kx9BXKqFKudXTlVX9hHvmXVaWU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sh6KZLqoqby5E0qE2dTz3V9VscoYx/O7HppzUE2IJdXkrK618X2Qzg06ekcBaQTlx
	 6PugYiNcHDdI+C4TBnb40V4u8mDmNSTOtylLkUjuHsmq+lURn5HriXEN+h4+S0EjJw
	 V3X0muMdH99hu+Shr0Tzrz4euji5hc3xbQ6PzuK+iarDb8D2aEyu+XCr5j1ZtfayCr
	 QC2l8LkIis74px0v/d+Tz4zc2MbaoKyANve5JHKOS+oOOoDD/cqeS4X/jGemwTwtfT
	 kpekEyGILT8eHpGAIkTrzk0h+Qc6MAhZfuO1IToKajbKv1NXywJFwljLzo09Ubn/kw
	 rVah2dudwrx4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260630084838.2313379-3-vi@endrift.com>
References: <20260630084838.2313379-1-vi@endrift.com>
 <20260630084838.2313379-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:07:52 +0000
Message-Id: <20260630090753.05D111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The delay calculation in `switch2_rumble_work` causes an unbounded=
 timer catch-up loop, flooding the USB bus with back-to-back output reports=
 if the worker is delayed.
- [High] Sending an embedded, non-cacheline-aligned struct member (`ns2->ru=
mble_buffer`) to `hid_hw_output_report()` can cause memory corruption durin=
g DMA.
- [High] The teardown sequence calls `hid_hw_stop()` before cancelling the =
rumble work and unregistering the input device, allowing output reports to =
be sent to a stopped device.
--

commit 6d9250862d78279cc28f8c0b3c447d3a7da2e69c
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add rumble support for Switch 2 controllers

This adds rumble support for both the "HD Rumble" linear resonant actuator
type as used in the Joy-Cons and Pro Controller, as well as the eccentric
rotating mass type used in the GameCube controller. Note that since there's
currently no API for exposing full control of LRAs with evdev, it only
simulates a basic rumble for now.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index b9e2e708e28f3..a53c554a54ae3 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> @@ -3043,8 +3056,45 @@ struct switch2_controller {
> =20
>  	uint32_t player_id;
>  	struct led_classdev leds[4];
> +
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	spinlock_t rumble_lock;
> +	uint8_t rumble_seq;
> +	union {
> +		struct switch2_hd_rumble hd;
> +		struct switch2_erm_rumble sd;
> +	} rumble;
> +	uint64_t last_rumble_work;
> +	struct delayed_work rumble_work;
> +	uint8_t rumble_buffer[64];

[Severity: High]
Does this pass an embedded, non-cacheline-aligned array to the DMA layer?

The USB DMA API requires that data buffers passed to it are dynamically
allocated (e.g., via kmalloc()) to ensure they are cache-line aligned.
Because rumble_buffer is embedded directly in struct switch2_controller, it
shares a cache line with other members like rumble_work.

Could this lead to memory corruption of adjacent struct members during
DMA cache invalidation on non-coherent architectures when passed to
hid_hw_output_report() in switch2_rumble_work()?

> +#endif
>  };
[ ... ]
> +static void switch2_rumble_work(struct work_struct *work)
> +{
[ ... ]
> +	if (active) {
> +		unsigned long interval =3D msecs_to_jiffies(2);
> +		uint64_t current_jiffies =3D get_jiffies_64();
> +
> +		if (!ns2->last_rumble_work)
> +			ns2->last_rumble_work =3D current_jiffies;
> +		else
> +			ns2->last_rumble_work +=3D interval;
> +
> +		if (ns2->last_rumble_work + interval >=3D current_jiffies)
> +			schedule_delayed_work(&ns2->rumble_work,
> +				ns2->last_rumble_work + interval - current_jiffies);
> +		else
> +			schedule_delayed_work(&ns2->rumble_work, 0);

[Severity: High]
Can this delay calculation result in an unbounded timer catch-up loop?

If the switch2_rumble_work() worker is delayed (e.g., due to system load
or slow synchronous transfers), last_rumble_work will fall behind
current_jiffies. The function appears to attempt to catch up by continually
adding the fixed 2ms interval to last_rumble_work and scheduling the next
execution with 0 delay.

For example, a 100ms stall might result in 50 back-to-back executions.
Could this flood the USB bus with zero-delay output reports, wasting CPU
resources and potentially degrading the device or bus?

> +	} else {
> +		ns2->last_rumble_work =3D 0;
> +	}
> +
> +	mutex_lock(&ns2->lock);
> +	if (!ns2->hdev) {
> +		cancel_delayed_work(&ns2->rumble_work);
> +	} else {
> +		ret =3D hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);
[ ... ]
> @@ -4009,6 +4210,9 @@ static void switch2_remove(struct hid_device *hdev)
> =20
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	cancel_delayed_work_sync(&ns2->rumble_work);
> +#endif
>  	mutex_lock(&ns2->lock);
>  	ida_free(&nintendo_player_id_allocator, ns2->player_id);
>  	WARN_ON(ns2->hdev !=3D hdev);
> +	ns2->hdev =3D NULL;

[Severity: High]
Does this teardown sequence allow output reports to be sent to a stopped
device?

Here, hid_hw_stop() is called to stop the underlying HID transport,
followed by cancel_delayed_work_sync(&ns2->rumble_work). If the worker
thread was preempted just before acquiring ns2->lock in
switch2_rumble_work():

Worker thread:
    mutex_lock(&ns2->lock);
    // preempted before lock acquisition

Teardown:
    hid_hw_stop(hdev);
    cancel_delayed_work_sync(&ns2->rumble_work); // waits for worker

Worker thread resumes:
    if (!ns2->hdev) // hdev is still valid here, set to NULL later
        ...
    else
        ret =3D hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);

Could the worker thread then execute hid_hw_output_report() on the stopped
device, potentially causing undefined behavior in the transport drivers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630084838.2313=
379-1-vi@endrift.com?part=3D2
