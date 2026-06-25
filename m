Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFBE3BB4A
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364715; cv=none; b=fa2AqydULVLA+uNPEiB9ssYObqacbi9VRjeUgjAqddH22F9l93CtSUfBCPjh9sK540lWCseQc2i3VEp0IjEXsPDnOy1oGbHg5cFX49gu8b/tHZ7+ono6ITjD/OO97MV1zT+vjTH6OnkCY9ZQYsLHyNjetpAaz0rxaMwjjmYSdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364715; c=relaxed/simple;
	bh=YPYP6C2do4cpD7E+AHuV1qTn0sHeDP+cEywUkrMbtGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yhy65AVBW2lYhW1UZb/RQtEe0LF3OvsxERQ2M69B0XCcHomFcEM63k239eLkR1gjG0nAYG05maOFD1s7koatBhaZgimCSm0C0mUvuJKoe1ZZcjXh/vjJSmTJb2aMcIoO5KLZpfUkN2elry2XOynlb+mE+gttkXchUxQc5L2+Bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeIomRwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeIomRwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A131F000E9;
	Thu, 25 Jun 2026 05:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364714;
	bh=uw7D8O0BrRN48a6tyjoGSpKjyVTdv/HTZcVTxx+/Pw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WeIomRwNAnLb9Jm4vUIVtHQmsoUdyt22LY9bkXUk/fQ2gjK0aFbtdWy1YYK7jluO4
	 JBUhi6vgvh5SHDyS4EIxxbj4N5dHeiiBCvOdRck5SwmtgAe6yqTPCC3XHYyzZDKrn+
	 LqpEIr1xsMkvPAc46MGWLSjCJmKYhpYz3NeosFWcIiyt+Ez6koqged85eELvvzIaod
	 O4iM5l51MMPoejBgHc9OCV/qKAyTP0gWYg3DGzTSlcTe3+DeTxvToT9QS7QAtX40XN
	 VhcjH0yVQbsIMkITws1LlNdqguUO28tABkJv5ef8PtfwBkDgBmMQpTbdHRpeniJTKM
	 dHf7TPo0Z3EGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260625045948.2343168-3-vi@endrift.com>
References: <20260625045948.2343168-1-vi@endrift.com>
 <20260625045948.2343168-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 05:18:33 +0000
Message-Id: <20260625051833.C1A131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Unsynchronized accesses to ns2->hdev allow rumble work to read a c=
losing device pointer, leading to a TOCTOU NULL pointer dereference.
- [High] cancel_delayed_work_sync() is called on an uninitialized work stru=
cture if the configuration interface detaches without the HID interface pro=
bing.
- [High] Use-after-free of ns2 due to the input core's memless force feedba=
ck timer outliving the driver's private data.
- [Medium] Arithmetic underflow in schedule_delayed_work() delay calculatio=
n causes the rumble worker to permanently hang if its execution is delayed.
- [Low] Unused static constant array switch2_zero_data leads to dead code.
--

commit 93841885eb908e1356dc311955f33fee3d1428c6
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add rumble support for Switch 2 controllers
   =20
This commit adds basic rumble support for the Switch 2 controllers. It
introduces delayed work and force feedback support.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 6573fd31a232a..ae360f4d15d1a 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

> @@ -3133,9 +3183,12 @@ static const uint8_t switch2_init_cmd_data[] =3D {
>  };
> =20
>  static const uint8_t switch2_one_data[] =3D { 0x01, 0x00, 0x00, 0x00 };
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +static const uint8_t switch2_zero_data[] =3D { 0x00, 0x00, 0x00, 0x00 };
> +#endif

[Severity: Low]
Is this unused variable intentional? It appears switch2_zero_data is never
utilized anywhere in the codebase.

[ ... ]

> +static int switch2_play_effect(struct input_dev *dev, void *data, struct=
 ff_effect *effect)
> +{
> +	struct switch2_controller *ns2 =3D input_get_drvdata(dev);
> +
> +	if (effect->type !=3D FF_RUMBLE)
> +		return 0;
> +
> +	guard(spinlock_irqsave)(&ns2->rumble_lock);

[Severity: High]
Can this result in a use-after-free when the input device outlives the driv=
er
data?

During device removal, switch2_controller_put() explicitly calls kfree(ns2).
However, the input device is devres-managed and its lifetime is tied to
userspace holding its file descriptor open. Since the input core's memless
force feedback timer is only destroyed when the input device is released,
the timer callback switch2_play_effect() could potentially fire after ns2
has been freed.

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
> +		schedule_delayed_work(&ns2->rumble_work,
> +			ns2->last_rumble_work + interval - current_jiffies);

[Severity: Medium]
Could this delay calculation underflow?

If the worker thread is delayed by the scheduler such that current_jiffies
exceeds the expected execution time (ns2->last_rumble_work + interval), the
unsigned arithmetic could underflow to a value near ULONG_MAX. This would
schedule the next rumble update weeks in the future, permanently hanging the
force feedback mechanism.

> +	} else {
> +		ns2->last_rumble_work =3D 0;
> +	}
> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
> +
> +	if (!ns2->hdev)
> +		cancel_delayed_work(&ns2->rumble_work);
> +	else
> +		ret =3D hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);

[Severity: High]
Is it possible for a concurrent removal to cause a NULL pointer dereference
here?

Because ns2->hdev is read outside of any lock, there may be a window where =
it
is verified as non-NULL, but then set to NULL by a concurrent
switch2_remove() before being passed to hid_hw_output_report(). This appears
structurally possible if userspace invokes switch2_play_effect() and
reschedules the worker right after the initial cancellation in
switch2_remove().

[ ... ]

> @@ -3358,6 +3521,10 @@ static void switch2_controller_put(struct switch2_=
controller *ns2)
>  	if (input)
>  		input_unregister_device(input);
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	cancel_delayed_work_sync(&ns2->rumble_work);
> +#endif

[Severity: High]
Could this cancel operation act on an uninitialized work structure?

The switch2_probe() function initializes the work structure:

    INIT_DELAYED_WORK(&ns2->rumble_work, switch2_rumble_work);

If the configuration interface detaches before the HID interface probes,
ns2->rumble_work might remain zero-initialized. When switch2_controller_put=
()
is called, unconditionally invoking cancel_delayed_work_sync() on this
uninitialized work structure could trigger lockdep warnings and kernel pani=
cs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625045948.2343=
168-1-vi@endrift.com?part=3D2
