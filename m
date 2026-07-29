Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0C2798EA
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291223; cv=none; b=tXRAxDbW1VJQ7Jkz2iloDVl5Nk5dDGSmZvbqhiUvq0LQYgQYJ6N/YJKl2RTco/hD5X3wVc+ec8GgXzZs+SA5/abSWCcRY8UtSUQsS2KWIifmPTz5VJOaNVLNQTfMpvIUcFDeolD47UE/vCuLH2Jb0jrPkUk3fldooWrYrTqGLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291223; c=relaxed/simple;
	bh=z/s3ddwX+JNr9zHLDUSYSCbOELMSqO8/gHJZWKji7xs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NfhZEtelFS/udm4rUMjnzbDzlDcGuavDChqsA3azgdq8ijZ/YsLfJNbK/qIwPwTJr3ccAaMaATaHPp1eX0IrXNFw+/IGUMnMDsVMsH89JNaGluGKp9a2eW3yWmuxvywY5wg3idBuuIU75li2bO3CTP1dRWCxFINcFX885eVCp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5+uIrYe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5+uIrYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEBF1F000E9;
	Wed, 29 Jul 2026 02:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785291221;
	bh=tdMQVGGoYL3RX0RmPIzF2aHkjtRm7pKZqNsdddNSjKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5+uIrYeDpqxPR+kavxBNrfZHsCLCPKIfQziCVr7x0c70teKpyjqohpHLDUE8uw/5
	 vlSxZLPdW4csTBS8T4tFgFiisTSLnZ1TOUyZunqBCh7uFjN4j2D+xJyzYNe31vTY4a
	 dZO9NX78O+497Rucu6wCI3qHAWNeoiE21ujVqn8cbTDI8R63q/j+dd/Ifh5p017cwW
	 EFYtg8E8KmdXbM83WKO+k9V4ZZ+UgHd7Ns6dyg0bNgkl2NF9ERapJaWBNtGSokXcJh
	 xSAFr1HVZuf27e+q8XzTUdaPd5p0N9HnNrdpyphSj1LpA06G1Wx6tO+8u6S1yiDZvI
	 RcAnLYzaPZQ6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/11] HID: steam: Coalesce rumble packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260729015243.1170573-7-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
 <20260729015243.1170573-7-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 02:13:41 +0000
Message-Id: <20260729021341.AEEBF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The coalescing logic unintentionally creates an infinite loop of r=
edundant rumble packets and always sends an immediate duplicate, violating =
the stated goal.
- [Medium] Data race on rumble magnitude variables `rumble_left` and `rumbl=
e_right`.

Pre-existing issues:
- [High] Incorrect teardown order in `steam_remove()` leads to a Use-After-=
Free of `steam_device` by requeued work items.
--

--- Patch [6]: [PATCH v4 06/11] HID: steam: Coalesce rumble packets ---
commit 49ddfbfccce223ca7429a2e5dad77eb7b4ef0fbe
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Coalesce rumble packets

The Steam Deck resets the haptic pattern every time it receives a rumble
packet, leading to weird discontinuities or sometimes cutting out entirely.
Instead of overloading the interface, Steam interally rate-limits sending
these packets, so we should too.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -602,10 +603,24 @@ static void steam_haptic_rumble_cb(struct work_stru=
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

[Severity: Medium]
Can this lead to stale magnitude values being read? The rumble_left and
rumble_right variables are read here by the asynchronous worker thread with=
out
acquiring a lock or using READ_ONCE().

> +	if (steam->rumble_left || steam->rumble_right)
> +		schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
> +}

[Severity: High]
Does this create an infinite polling loop? The delayed work reschedules its=
elf
unconditionally based only on non-zero magnitudes. It appears this will
repeatedly spam the interface with identical values, causing the haptic
pattern to reset continuously at 20Hz.

> +
>  #ifdef CONFIG_STEAM_FF
>  static int steam_play_effect(struct input_dev *dev, void *data,
>  				struct ff_effect *effect)
> @@ -615,6 +630,14 @@ static int steam_play_effect(struct input_dev *dev, =
void *data,
>  	steam->rumble_left =3D effect->u.rumble.strong_magnitude;
>  	steam->rumble_right =3D effect->u.rumble.weak_magnitude;

[Severity: Medium]
When delayed_work_pending() returns true below, this function returns early.
Does this mean the magnitudes are written locklessly without generating a
memory barrier, potentially causing the worker thread to read incorrect rum=
ble
intensities?

> +	/*
> +	 * The interface gets somewhat overloaded when too many rumble
> +	 * packets are sent in a row, so Steam throttles it to 20 Hz
> +	 */
> +	if (delayed_work_pending(&steam->coalesce_rumble_work))
> +		return 0;
> +
> +	schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
>  	return schedule_work(&steam->rumble_work);
>  }

[Severity: High]
When a new effect starts, both an immediate work and a delayed work are
queued here. Doesn't this guarantee a duplicate packet is sent 50ms later
even if no changes occurred?

[ ... ]

> @@ -1443,6 +1468,7 @@ static void steam_remove(struct hid_device *hdev)
>  	cancel_delayed_work_sync(&steam->mode_switch);
>  	cancel_work_sync(&steam->work_connect);
>  	cancel_work_sync(&steam->rumble_work);
> +	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
>  	cancel_work_sync(&steam->unregister_work);
>  	steam->client_hdev =3D NULL;
>  	steam->client_opened =3D 0;

[Severity: High]
This is a pre-existing issue, but does this teardown order in steam_remove()
lead to a use-after-free of the steam_device struct?

During device removal, the work items are cancelled before unregistering the
input device. If a userspace process still holds the device open when
steam_unregister() is subsequently called, it will synchronously flush acti=
ve
effects via input_ff_flush().

This flush ultimately calls steam_play_effect() to stop the rumble, which
re-arms both rumble_work and coalesce_rumble_work after they were already
cancelled here. Will those requeued work items execute after the device mem=
ory
has been freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729015243.1170=
573-1-vi@endrift.com?part=3D6
