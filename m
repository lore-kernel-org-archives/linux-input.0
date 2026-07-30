Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD38222597
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386028; cv=none; b=oaD6ZTDnahJZArImKDsaHEgJUxRlFAXDCwOfi94pVRrWAFioktqwRE1pkaUkYL9x90Wn66JFfGOTp20KTBXb0QTlWWIYEcihcCABs+oUL6F34wfto4l/7zQjdJH22d80b/+x6F+3I3l8kGKBFZpNs21G/EM9RXfRHGVWDcF+bZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386028; c=relaxed/simple;
	bh=MX05MpoBRjVdj9hfidiC5wjE7Ka5hqH1aUMNSYVbutA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NgJK8Wl7rwKtfUM69htuyO2lA31yeXS7uEkAQSqar/72L9JiCsyjWVTOhNPW1Hm1bpjlOKrqx8P3ZCdBQ0egNGr+exsozEFvjCTJoVOD95oRoiGB2oYUUHwGyAL7ItiVama9/PK1AKyvgrheysr/uYoYPjwndEXqyzwJMkCiO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJYlch30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJYlch30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BD01F000E9;
	Thu, 30 Jul 2026 04:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386026;
	bh=StvZtfGZhojiR8IpS8BcQ4cGvlxkeJxx6h5X54rhA9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJYlch30hiJb6mE5YIXO4mpR53zycMR1fjSpAMim55SVJbrRdg5OPD/eukDa15eJq
	 B+6oDQme4w1xtJFXfkLpUxv+ZsZ9sZOZ9SK03NPW3AZi+zDE2yEJRgl6aGXrzY9v4Z
	 QZjY8fM10X/5UMNRWCCXQpoELGAWim4gpKQD6pQw+90w1IzWkbTFDQaaqKkZEydEeO
	 9h1Fyfa0FWHbqYn2xVoz0fVlHKt4Dg1MnjFvGXRWuA4AQef7RXyAhmi+WQbzXJaf/e
	 TQwhIKnuXat4B/NxQ5CemxqGDRdK0DjoXJ6WkX72i9aUfmpC6tVOl81EBf0hsJerUI
	 Db7x1LARHVFRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/11] HID: steam: Coalesce rumble packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260730041251.1659029-6-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
 <20260730041251.1659029-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:33:46 +0000
Message-Id: <20260730043346.84BD01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Dynamic device unregistration fails to cancel `coalesce_rumble_wor=
k`, causing an infinite loop and resource leak.
- [Medium] Lockless `delayed_work_pending()` check bypasses rate limiting, =
causing haptic reset bugs.

Pre-existing issues:
- [High] Teardown order in `steam_remove()` causes Use-After-Free by cancel=
ling work items before unregistering the input device.
--

--- Patch [5]: [PATCH v5 05/11] HID: steam: Coalesce rumble packets ---
commit d8418fccc5859b59417d02482c0b768383aa61ef
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Coalesce rumble packets

This commit introduces a 20Hz rate limit for rumble packets sent to the Ste=
am
Deck to prevent the hardware from resetting haptic patterns on every packet.
It implements this rate limiting by using a delayed work queue to coalesce=
=20
rumble updates.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -603,10 +604,24 @@ static void steam_haptic_rumble_cb(struct work_stru=
ct *work)
>  {
>  	struct steam_device *steam =3D container_of(work, struct steam_device,
>  							rumble_work);
> +
>  	steam_haptic_rumble(steam, 0, steam->rumble_left,
>  		steam->rumble_right, 2, 0);
>  }
> =20
> +static void steam_coalesce_rumble_cb(struct work_struct *work)
> +{
> +	struct steam_device *steam =3D container_of(to_delayed_work(work),
> +							struct steam_device,
> +							coalesce_rumble_work);
> +
> +	steam_haptic_rumble(steam, 0, steam->rumble_left,
> +		steam->rumble_right, 2, 0);
> +
> +	if (steam->rumble_left || steam->rumble_right)
> +		schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
> +}

[Severity: High]
Will this work item reschedule itself indefinitely if the device is dynamic=
ally
unregistered while a haptic effect is playing?

When the device is dynamically unregistered, such as during a wireless
disconnect or a mode switch, steam_unregister() destroys the input device
via steam_input_unregister().

However, steam_unregister() does not cancel coalesce_rumble_work, and the
input core does not proactively clear the rumble_left and rumble_right
magnitudes when an input device is destroyed. Because the input device is
gone, userspace can never send a 0-magnitude effect to stop the rumble,
leaving this worker to loop indefinitely every 50ms and leak CPU cycles
and USB bandwidth.

> +
>  #ifdef CONFIG_STEAM_FF
>  static int steam_play_effect(struct input_dev *dev, void *data,
>  				struct ff_effect *effect)
> @@ -616,6 +631,14 @@ static int steam_play_effect(struct input_dev *dev, =
void *data,
>  	steam->rumble_left =3D effect->u.rumble.strong_magnitude;
>  	steam->rumble_right =3D effect->u.rumble.weak_magnitude;
> =20
> +	/*
> +	 * The interface gets somewhat overloaded when too many rumble
> +	 * packets are sent in a row, so Steam throttles it to 20 Hz
> +	 */
> +	if (delayed_work_pending(&steam->coalesce_rumble_work))
> +		return 0;
> +
> +	schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
> +	return schedule_work(&steam->rumble_work);
>  }

[Severity: Medium]
Could this lockless check of delayed_work_pending() defeat the intended
rate limiting?

The workqueue core clears the pending bit immediately before executing the
worker callback. Because steam_coalesce_rumble_cb() acquires a mutex and
performs synchronous USB I/O, its execution time can be relatively large.

If a userspace process updates force feedback effects while the callback is
actively executing, delayed_work_pending() will evaluate to false. This
causes steam_play_effect() to immediately queue another rumble_work, which
then executes right after the callback finishes, sending two packets
back-to-back and bypassing the 50ms throttle.

[ ... ]
> @@ -1444,6 +1469,7 @@ static void steam_remove(struct hid_device *hdev)
>  	cancel_delayed_work_sync(&steam->mode_switch);
>  	cancel_work_sync(&steam->work_connect);
>  	cancel_work_sync(&steam->rumble_work);
> +	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
>  	cancel_work_sync(&steam->unregister_work);
>  	steam->client_hdev =3D NULL;
>  	steam->client_opened =3D 0;

[Severity: High]
This is a pre-existing issue, but does the teardown order in steam_remove()
allow a use-after-free?

The works are cancelled before the input device is unregistered:

steam_remove() {
    ...
    cancel_work_sync(&steam->rumble_work);
    cancel_delayed_work_sync(&steam->coalesce_rumble_work);
    ...
    steam_unregister(steam);
}

If a userspace process continuously calls the EVIOCSFF ioctl to play
force-feedback effects while the device is being removed, the ioctl
path in steam_play_effect() can queue new rumble_work and
coalesce_rumble_work items after they have been cancelled.

Once steam_remove() completes, the devm-managed steam structure is freed,
but the newly queued work items will eventually execute and dereference
the freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730041251.1659=
029-1-vi@endrift.com?part=3D5
