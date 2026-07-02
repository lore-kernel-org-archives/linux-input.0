Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6DF3803C1
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029868; cv=none; b=FKdBuCS/LlUjG2a9cYKIBq+aqhQEajEfOx1OtmGDSeU+BxNvpPeCTPFKXyI63GfEfgqticl2tPPawvZH67TINH92EnA4e+CsxVh/J9fuxTGdgmwFr4altB6izlzKD9bp63m/v2DGtSTP47UK8UHvFncrrGUYszQyWubmn9oALoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029868; c=relaxed/simple;
	bh=lK29aeAiJJ/wPjtfk2os/tYRHZ0ETp2LXPFlVEDQc+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bTo7vD3O/BY9tF7ZZdPPtAZmBxHp9bbX5KSs9Uo0/ACQBLSo/dsIR35qenFYx0ab1p6tWOpCaD+tdut2W+lYhIvGGIvnrXIUTT1qYCWAsKfZJ+86cq80hoxVgtSQnJcOPz5v0/MIJ/PobofYF58HV0dL2RdfZWEWBsNVUBjZ/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSJfrRV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSJfrRV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593851F000E9;
	Thu,  2 Jul 2026 22:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783029867;
	bh=grA/B8iZUc0iF5a1prRmjg17K5GipFD8ePhOrMlzzTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FSJfrRV9usQhIXBb0VxEHo+3lQbulOTfSlHQYpe3SFYhuSG2PgdvDW+GpZnSe09Et
	 H+u/oUObdtZFmnTL3XEtlwPLLEW2EWJNorxbYyhCgjf9S4dHQNNC3x0Y6O3Q+VzxRe
	 jdF4DmuICJZYKj4qVCRVRcutjgpH+q8FK/p1WvmI3HyHmFAJBd6e2Na1PffLPpAsWW
	 5sOxqxy5FpHH+4u9svY5C61P8UxscFw0F1Mo/STXEHpRwsrt2DD8Rplz/ADuNHxSes
	 Ufnt2rzwL/ukUmKA0C5VokJdGAK+ea0MnNL2v1WkhipejwSvAM6/asQD6C5e9jvZHU
	 jqMBRCk6BNB9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260702214704.1859350-3-vi@endrift.com>
References: <20260702214704.1859350-1-vi@endrift.com>
 <20260702214704.1859350-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:04:24 +0000
Message-Id: <20260702220426.593851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free of rumble_work and controller state due to devm lif=
ecycle mismatch

Pre-existing issues:
- [High] Circular reference in LED devm registration causes permanent memor=
y leak and Use-After-Free
--

commit 24b9a46372beedd9b4a7b187b2ec2e8fa3058997
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add rumble support for Switch 2 controllers

This adds rumble support for both the "HD Rumble" linear resonant actuator
type as used in the Joy-Cons and Pro Controller, as well as the eccentric
rotating mass type used in the GameCube controller.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e21c369218325..a36f4fd9a1da5 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> @@ -3209,6 +3260,125 @@ static void switch2_kref_put(struct kref *refcoun=
t)
>  	kfree(ns2);
>  }
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
[ ... ]
> +static void switch2_rumble_work(struct work_struct *work)
> +{
> +	struct switch2_controller *ns2 =3D container_of(to_delayed_work(work),
> +						      struct switch2_controller, rumble_work);
> +	unsigned long flags;
> +	bool active;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&ns2->rumble_lock, flags);

[Severity: High]
If the device is unplugged and `ns2` is manually freed, can this work
function execute concurrently and attempt to acquire `ns2->rumble_lock`
on freed memory?

> +	ns2->rumble_buffer[0x1] =3D 0x50 | ns2->rumble_seq;
[ ... ]
> @@ -3332,6 +3502,26 @@ static int switch2_init_input(struct switch2_contr=
oller *ns2)
>  		return -EINVAL;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does registering the LED devices with
devm create a circular reference by binding the LED devres to the input
device while simultaneously setting it as the parent?

The driver core's device_add() function automatically takes a reference to
the parent device (&input->dev). Since devres is attached to the same
parent, it waits for the parent's refcount to drop to 0 before unregistering
the LEDs, which means neither can be released.=20

Does this permanently leak the input device, LED devices, and devm
allocations?=20

Furthermore, because `ns2` is freed manually upon device removal, could
lingering LED sysfs attributes trigger a use-after-free crash if a user
writes to them, causing switch2_player_led_brightness_set() to dereference
the freed `ns2` pointer?

> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	ns2->rumble_buffer =3D devm_kzalloc(&input->dev, 64, GFP_KERNEL);
> +	if (!ns2->rumble_buffer) {
> +		input_free_device(input);
> +		return -ENOMEM;
> +	}
> +	ret =3D devm_delayed_work_autocancel(&input->dev, &ns2->rumble_work, sw=
itch2_rumble_work);

[Severity: High]
Does binding the rumble work lifecycle to &input->dev cause a
use-after-free when `ns2` is manually freed?

If a user unplugs the controller while holding the input device open,
`ns2` is freed in the removal path, but the devres cleanup for the input
device will run later.=20

Will this result in the devres cleanup unconditionally calling
cancel_delayed_work_sync(&ns2->rumble_work) on the already-freed
`ns2` pointer?

> +	if (ret < 0) {
> +		input_free_device(input);
> +		return ret;
> +	}
> +
> +	input_set_capability(input, EV_FF, FF_RUMBLE);
> +	ret =3D input_ff_create_memless(input, NULL, switch2_play_effect);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702214704.1859=
350-1-vi@endrift.com?part=3D2
