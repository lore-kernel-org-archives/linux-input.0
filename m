Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6293DDDAF
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658673; cv=none; b=Z818nshA/G5WTWw1uhRs6qTRR/o89tctnfNfzQbtsXU1lLvmG7jC00UoFDHyyL075hu4QhjPHsszdQu/fTdeYSWaAyWXaRluSmWRuHWLNetTzXn0qV/mnuk1ACn4bxGUr5j1mODa67hkLzgAqgvX4SeBO1gc5TL/RSSytheqqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658673; c=relaxed/simple;
	bh=E9Tb1Id2U9ItUj9jAaqP/azb+CpmIvCvAfJRrf3rSpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cV+xL0DI/WvM3JUPkkf1T4+c+kLf/1Ry6wa6Vt0TPD7COHyEZUxzJGjqvYUfStUo3yEFaFU1tVE+HhcFvajZScb1KW08kwwn7UxACDlJKPiieO9h80BRpqBAL9sn6uJsyWlp74HGtSUTnlmec575RAH9EiIu8QPGk4axG0WcUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0J30jrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0J30jrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681361F000FF;
	Tue, 29 Sep 2026 05:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790658671;
	bh=HIS1eskXn7bJ95+pGBVW+OdYn9QfWe5cgvlN8SwmrMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0J30jrF5w1VffbM/EqftCC/5yPiXQpmzHq2/sVK6YmVxc2E9JML4PqBcla01wpis
	 Ncw6xGdaxZTyjFR6XuhoXI4lLdN8loxSNkgcBbPwzXPzKbGMA7Gngym1WP50o+RRlg
	 2CoAXfoD54Ky9PYiYPIME2WtoXMT9x1IqVEewW07tnCSpLbRgoQXmXZqpG5rKDTE1B
	 E3DyA82q8MC35KCg2LL/ck0C/GCHcAPg2+hKezYPFjjJDUJ2sAwS/bpqe45WdV8Gn7
	 XpzltOK0jJlMAtDNeKRqfbiy42Fej394iELLRaheOOyKlb6opylhOX5Rv1MGkTlP5h
	 lFuknc5TF161A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 1/4] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260929045607.2106149-2-vi@endrift.com>
References: <20260929045607.2106149-1-vi@endrift.com>
 <20260929045607.2106149-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 05:11:10 +0000
Message-Id: <20260929051111.681361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] input: memory leak and UAF due to devm actions on unmanaged input_=
dev
- [High] usb: TOCTOU race condition causing UAF in message_in_work
- [High] usb: infinite interrupt storm on -EPIPE URB completion
--

commit 276f7b7da744b926faf29e3e4027c0cc47d9bc19
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: nintendo: Add preliminary Switch 2 controller driver

This commit introduces preliminary support for the Nintendo Switch 2
controllers. It uses a split-driver design with a main HID interface driver
and a secondary configuration interface driver to handle input and non-stan=
dard
communications over USB and Bluetooth.

> diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nin=
tendo-switch2-usb.c
> new file mode 100644
> index 0000000000000..fabe6b3f4163c
> --- /dev/null
> +++ b/drivers/hid/hid-nintendo-switch2-usb.c
[ ... ]
> +static void switch2_bulk_in(struct urb *urb)
> +{
> +	struct switch2_usb *ns2_usb =3D urb->context;
> +	int i;
> +	bool schedule =3D false;
> +	unsigned long flags;
> +
> +	switch (urb->status) {
> +	case 0:
> +		schedule =3D true;
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		dev_dbg(&ns2_usb->udev->dev, "shutting down input urb: %d\n", urb->sta=
tus);
> +		return;
> +	case -EPIPE:
> +		break;

[Severity: High]
Does this error path handle halted endpoints correctly? The EPIPE status
indicates a stalled endpoint. By breaking out here without setting the
schedule flag, the code avoids scheduling work, but it proceeds to the
loop below where it immediately re-anchors and resubmits the URB via
usb_submit_urb() without clearing the halt condition. This can cause the
hardware to instantly complete the new URB with EPIPE again, leading to an
infinite interrupt storm in softirq context and a CPU lockup.

> +	default:
> +		dev_dbg(&ns2_usb->udev->dev, "unknown input urb status: %d\n", urb->st=
atus);
> +		break;
> +	}
> +
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	if (ns2_usb->shutdown)
> +		schedule =3D false;
> +
> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> +		int err;
> +		struct switch2_urb *ns2_urb;
> +
> +		if (ns2_usb->bulk_in[i].urb =3D=3D urb) {
> +			if (schedule) {
> +				ns2_usb->bulk_in[i].state =3D NS2_URB_IN;
> +				continue;
> +			} else {
> +				ns2_usb->bulk_in[i].state =3D NS2_URB_FREE;
> +			}
> +		}
> +
> +		if (ns2_usb->bulk_in[i].state !=3D NS2_URB_FREE)
> +			continue;
> +
> +		/*
> +		 * We want exactly one bulk in URB scheduled at a time, so only
> +		 * reschedule this immediately if nothing else is scheduled
> +		 * currently.
> +		 */
> +		if (!usb_anchor_empty(&ns2_usb->bulk_in_anchor) || ns2_usb->shutdown)
> +			continue;
> +
> +		ns2_urb =3D &ns2_usb->bulk_in[i];
> +		if (!ns2_urb)
> +			continue;
> +
> +		usb_anchor_urb(ns2_urb->urb, &ns2_usb->bulk_in_anchor);
> +		err =3D usb_submit_urb(ns2_urb->urb, GFP_ATOMIC);
> +		if (err) {
> +			usb_unanchor_urb(ns2_urb->urb);
> +			dev_dbg(&ns2_usb->udev->dev, "failed to queue input urb: %d\n", err);
> +		} else {
> +			ns2_urb->state =3D NS2_URB_OUT;
> +		}
> +	}
> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +
> +	if (schedule)
> +		schedule_work(&ns2_usb->message_in_work);

[Severity: High]
Can calling schedule_work() outside the spinlock create a TOCTOU race
against switch2_usb_disconnect()?

If switch2_bulk_in() checks ns2_usb->shutdown, releases the lock, and is
then preempted before calling schedule_work(), switch2_usb_disconnect()
could run. It would acquire the lock, set shutdown to true, release the loc=
k,
and call cancel_work_sync(&ns2_usb->message_in_work). Since the work is not
yet queued, cancel_work_sync() returns immediately, and devres frees
ns2_usb. When switch2_bulk_in() resumes, it will call schedule_work() on
freed memory, causing a use-after-free.

> +}
[ ... ]
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index b1fcf3e5767ba..3a7c35375be60 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> +static int switch2_player_led_brightness_set(struct led_classdev *led,
> +					    enum led_brightness brightness)
> +{
> +	struct device *dev =3D led->dev->parent;
> +	struct input_dev *input =3D to_input_dev(dev);
> +	struct switch2_controller *ns2 =3D input_get_drvdata(input);
> +
> +	if (!ns2)
> +		return -ENODEV;
> +
> +	guard(mutex)(&ns2->lock);
> +	return switch2_set_leds(ns2);
> +}
[ ... ]
> +static int switch2_init_input(struct switch2_controller *ns2)
> +{
> +	struct input_dev *input;
[ ... ]
> +	input =3D input_allocate_device();
> +	if (!input)
> +		return -ENOMEM;
[ ... ]
> +	ns2->leds =3D devm_kcalloc(&input->dev, JC_NUM_LEDS, sizeof(*ns2->leds)=
, GFP_KERNEL);

[Severity: High]
Does allocating devm resources tied to an unmanaged input device create a
memory leak and use-after-free risk?

The input device here is allocated manually with input_allocate_device().
Using devm_kcalloc() and later devm_led_classdev_register() with
&input->dev as the parent means the LED devices take a reference to their
parent input device. When the device is removed, input_unregister_device()
is called, but the child LED devices hold the reference so the input device
is never freed.

This leaves the devres actions unexecuted, leaking the input device and
leaving the LED devices active in sysfs. Meanwhile, the driver frees the
ns2 structure. If userspace then writes to the LED brightness file,
switch2_player_led_brightness_set() will execute, fetch the freed ns2
pointer, and dereference it, leading to a deterministic use-after-free.

> +	if (!ns2->leds) {
> +		hid_err(ns2->hdev, "Failed to allocate LEDs\n");
> +		input_unregister_device(input);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < JC_NUM_LEDS; i++) {
> +		struct led_classdev *led =3D &ns2->leds[i];
[ ... ]
> +		ret =3D devm_led_classdev_register(&input->dev, led);
> +		if (ret < 0) {
> +			dev_err(&input->dev, "Failed to register player %d LED; ret=3D%d\n",
> +				i + 1, ret);
> +			break;
> +		}
> +	}
> +
> +	rcu_assign_pointer(ns2->input, input);
> +	synchronize_rcu();
> +
> +	switch2_init_step_done(ns2, NS2_INIT_INPUT);
> +	return switch2_init_controller(ns2);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929045607.2106=
149-1-vi@endrift.com?part=3D1
