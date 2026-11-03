Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673415;
	b=bHIr46TeluI/XWv124jZ7Tjkoif9rWVOsKYlmhXJ8BjJy2GigwvtBYuSPL/RhSyiBQ8O
	 v9ds3vS7tJMXdRtXl1OkuCTFgfQ5Yzkf0bDFdThgVvS77LkhpgE7URG5ehSUQCIMcOfIf
	 3B2EYxFWVM3BVEu13mHXUF4MhSChYMYbsHTDe+GGryRNPuh7Y4xJSuEbbcq3Z9206Jsnh
	 4eHJ6hBnvDToQhmE/jIvjPRZhQEhmTYx4M/WlmvEQpoL/e8FkNJ7ngpNJ2HrDnrIo4MZs
	 mI5QS187ZqFqoyQykAaKEOzZUivkrddS6z2jCF/y4k6AfrVmPbwNvdtM7PjKSbAbX6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673415;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XepaHarZg29S+epNvSlWsZuP2Z4SJO9WO+QCAJ3FBo4=;
	b=XXAYAXWbf6L6pVmoUbiA18b8P+JfLnCi1CkIeWFUmhOlJ3NxHHd0UhcBv5mezWgYVOGA
	 zG5q9miQATB6TujOLtw+nWvY9IK3w/GJ3LyRqA4ij5f5OYFCI9NVesIP+ROCPdyOxycYf
	 4E3KSvCBYBLmFuLpA+v7Ms9HYcS3EDb4rSD0mD89dbc6Z9OK1NjJ7Z9XFMg2Zspk4HYK+
	 OEQc/Ule6QhJDk6CvvAS21ym2brjjiQd7/5lFdwcPOIM2E/7qW+TCVQNPuxrvX0DETmZW
	 jY5t6FH6xCMawHf9G3gstypjTg7wZso1ynKE8GUANc3DgPWj9uMhbMDKB534odnX0og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3zsG+jc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D1E606A324
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3zsG+jc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A831F00919;
	Tue,  3 Nov 2026 02:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793673415;
	bh=XepaHarZg29S+epNvSlWsZuP2Z4SJO9WO+QCAJ3FBo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3zsG+jcGAv7hFeBFq9K0uWuDoXGnJ7hIOEgOYdQ7d4ciCOGhca+ynLvQDHHDV+b8
	 NW6HWO4PTSw7m/2s8ZvxgUW7T7oYsxC7EYRFGJxjUj4z0X0DtgzSlzBKLfMJ6EvYDd
	 oqDBbD9Zd9Muf4P0Gm1jJHeF0q+sCqgqtC43nsaV9ZBP/qIsKWgZGF4/QnCQMjJerq
	 T8uLSWfWTgPHhoU9HLHA6ZFOuDJ5+B1TSKLEr/pr9GfKW0DDxK9Qa/Qf4ogHqxi0RQ
	 inCSk7nH83+WBoEn1r5MpByViKxyUDU4MkS2ECIz6njvuowjrRcAkVp15pWruRapwB
	 dbxNy0mzVLCNg==
Message-ID: <sashiko-outbox-194465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11] Input: xpad - overhaul device data for wireless
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103021550.1054584-3-sanjay.govind9@gmail.com>
References: <20261021221009.361992-3-sanjay.govind9@gmail.com>
 <20261103021550.1054584-3-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:36:54 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Input: xpad - double read of volatile jiffies in xpad_presence_w=
ork()
- [Medium] Input: xpad - unlocked mod_delayed_work() race in xpad_presence_=
work()
- [Medium] Input: xpad - stale wireless pad_info across xpad_suspend() and =
xpad_resume()
--

commit 1369f7a52af03b86ab596cabb5b216cf2f7e0a71
Author: Sanjay Govind <sanjay.govind9@gmail.com>

Input: xpad - overhaul device data for wireless devices

This commit updates the Xbox 360 wireless controller driver to populate inp=
ut
device identification from link and capabilities reports rather than using
static receiver-derived defaults. It defers input registration until
capabilities discovery completes or a 500ms timeout expires, protecting the
discovery state with a spinlock and tracking controller generations across
disconnect and suspend.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 810e52782ae89..82408e1c0e044 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -993,6 +1037,54 @@ static void xpad_presence_work(struct work_struct *=
work)
>  		 */
>  		xpad_deinit_input(xpad);
>  	}
> +
> +	if (!info.present || xpad->input_created)
> +		return;
> +
> +	/*
> +	 * The work may already be running when a new pad connects, so its
> +	 * original delayed execution cannot be relied on to finish discovery.
> +	 */
> +	scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
> +		if (!xpad->pad_info.present || xpad->pad_info.gen !=3D info.gen)
> +			return;
> +
> +		if (!xpad->pad_info.discovery_ready &&
> +		    time_before(jiffies, xpad->pad_info.discovery_deadline)) {
> +			delay =3D xpad->pad_info.discovery_deadline - jiffies;
> +		} else {
> +			xpad->pad_info.discovery_ready =3D true;
> +			info =3D xpad->pad_info;
> +		}
> +	}
> +
> +	if (delay) {
> +		mod_delayed_work(system_percpu_wq, &xpad->work, delay);
> +		return;
> +	}
> +
> +	if (info.discovery_ready) {

[Severity: Medium]
In xpad_presence_work() in drivers/input/joystick/xpad.c, jiffies is read
twice when checking the discovery deadline:

	if (!xpad->pad_info.discovery_ready &&
	    time_before(jiffies, xpad->pad_info.discovery_deadline)) {
		delay =3D xpad->pad_info.discovery_deadline - jiffies;
	}

Because jiffies is volatile, the compiler emits two separate loads. Even wi=
th
local interrupts disabled under xpad->x360w_lock, another CPU can advance
jiffies between the time_before() check and the subtraction.

If jiffies is discovery_deadline - 1 during time_before() and ticks to
discovery_deadline before the subtraction, time_before() succeeds so
info.discovery_ready remains false, while delay evaluates to 0. Both
if (delay) and if (info.discovery_ready) then evaluate to false, causing
xpad_presence_work() to return without rescheduling xpad->work or calling
xpad_init_input(). If the controller does not send a capabilities report,
will it ever be registered?

Similarly, if jiffies advances by two or more ticks between the two reads,
could discovery_deadline - jiffies underflow unsigned long and schedule
xpad->work far in the future? Snapshotting jiffies into a local variable
before time_before() and the subtraction would avoid both issues.

[ ... ]

> @@ -1009,19 +1101,102 @@ static void xpad_presence_work(struct work_struc=
t *work)

[ ... ]

> +	/* Capabilities report */
> +	if (len >=3D 21 && data[0] =3D=3D 0x00 && data[1] =3D=3D 0x05 && data[5=
] =3D=3D 0x12) {
> +		discovery_complete =3D false;
> +
> +		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
> +			if (info->present && info->link_report_received &&
> +			    !info->discovery_ready) {
> +				info->flags |=3D data[20];
> +				/*
> +				 * Some vendors encode identification in the stick
> +				 * capabilities. Only trust it when the VID matches
> +				 * the link report.
> +				 */
> +				if (info->vid &&
> +				    get_unaligned_le16(data + 10) =3D=3D info->vid &&
> +				    get_unaligned_le16(data + 12)) {
> +					info->pid =3D get_unaligned_le16(data + 12);
> +					info->version =3D get_unaligned_le16(data + 14);
> +				}
> +
> +				info->discovery_ready =3D true;
> +				discovery_complete =3D true;
> +			}
> +		}
> +
> +		if (discovery_complete)
> +			mod_delayed_work(system_percpu_wq, &xpad->work, 0);
>  	}

[Severity: Medium]
Can mod_delayed_work() in xpad_presence_work() race with
xpad360w_process_packet() and overwrite an immediate 0-delay schedule with a
stale timeout delay?

Consider the following sequence in drivers/input/joystick/xpad.c:

CPU0 (xpad_presence_work)
  scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
      /* sees !discovery_ready and time_before(jiffies, discovery_deadline)=
 */
      delay =3D xpad->pad_info.discovery_deadline - jiffies;
  }
  /* lock is released */

CPU1 (xpad_irq_in -> xpad360w_process_packet)
  /* capabilities report arrives (or pad disconnects) */
  info->discovery_ready =3D true;
  mod_delayed_work(system_percpu_wq, &xpad->work, 0);

CPU0 (xpad_presence_work)
  if (delay) {
      mod_delayed_work(system_percpu_wq, &xpad->work, delay);
      return;
  }

Because xpad_presence_work() is still running when CPU1 queues xpad->work
with delay 0, the work item is pending when CPU0 calls mod_delayed_work()
outside xpad->x360w_lock. CPU0 then replaces the 0-delay timer with the sta=
le
non-zero delay, stalling controller registration or disconnect teardown unt=
il
the discovery timeout expires.

Should mod_delayed_work() be called while holding xpad->x360w_lock in
xpad_presence_work() and in the capabilities completion path of
xpad360w_process_packet(), matching the presence-change path?

[ ... ]

> @@ -2271,14 +2533,38 @@ static int xpad_suspend(struct usb_interface *int=
f, pm_message_t message)
>  		 */
>  		xpad360w_stop_input(xpad);
> =20
> +		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
> +			info =3D xpad->pad_info;
> +		}
> +
>  		/*
>  		 * The wireless adapter is going off now, so the
>  		 * gamepads are going to become disconnected.
>  		 * Unless explicitly disabled, power them down
>  		 * so they don't just sit there flashing.
>  		 */
> -		if (auto_poweroff && xpad->pad_present)
> +		if (auto_poweroff && info.present)
>  			xpad360w_poweroff_controller(xpad);
> +
> +		/* Finish teardown if suspend cancelled work for an old pad. */
> +		if (xpad->input_created &&
> +		    (!info.present || xpad->input_gen !=3D info.gen)) {
> +			RCU_INIT_POINTER(xpad->x360w_dev, NULL);
> +			synchronize_rcu();
> +			xpad_deinit_input(xpad);
> +		}
> +
> +		/*
> +		 * A cancelled discovery must be restarted by the resume inquiry.
> +		 * Clear its metadata so late reports cannot seed the next pad.
> +		 */
> +		if (!xpad->input_created) {
> +			scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
> +				xpad->pad_info =3D (struct xpad360w_pad_info) {
> +					.gen =3D xpad->pad_info.gen,
> +				};
> +			}
> +		}
>  	} else {

[Severity: Medium]
As reported by Sashiko on v10 [1], what happens across xpad_suspend() and
xpad_resume() in drivers/input/joystick/xpad.c when a wireless controller is
already registered before suspend (xpad->input_created is true and
xpad->input_gen =3D=3D info.gen) and is replaced while xpad->irq_in is stop=
ped?

In xpad_suspend(), when xpad->input_created is true and info.present is true
with matching generation, the function stops xpad->irq_in and powers off the
controller via xpad360w_poweroff_controller(), but skips both the teardown
block and the !xpad->input_created reset block. As a result,
xpad->pad_info.present and xpad->pad_info.discovery_ready remain true.

If xpad_resume() subsequently runs without an interface unbind/rebind (for
example during hibernation freeze/thaw or if port suspend fails during syst=
em
suspend) and calls xpad360w_start_input() -> xpad_inquiry_pad_presence()
while a different controller is connected to that slot,
xpad360w_process_packet() sees info->present =3D=3D true and
info->discovery_ready =3D=3D true:

	if (info->present !=3D present) {
		...
	}

	/* Link report */
	if (len >=3D 26 && data[0] =3D=3D 0x00 && data[1] =3D=3D 0x0F) {
		...
		scoped_guard(spinlock_irqsave, &xpad->x360w_lock) {
			if (info->present && !info->discovery_ready) {

Wouldn't this cause the replacement controller's presence, link, and
capabilities reports to be ignored so it continues using the previous
controller's input_dev and identity?

[1] https://lore.kernel.org/r/20261021221009.361992-3-sanjay.govind9@gmail.=
com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103021550.1054=
584-3-sanjay.govind9@gmail.com?part=3D1
