Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826202C0F8C;
	Fri, 21 Aug 2026 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348601; cv=none; b=KlNFvbLd0B+zYDVmya30TSCaNBjcYJ43ZwHYRwUl+NKlq3A0nQEQm7BmZ3n496CLGUhA3F8lNHJd/FuddWEXn1DnFN+FJIJutg94u+UlI/LQJxUGopijiYljqdPTYxqRZkkXLn/X2PpY4h+yIj36BSE6AJkntHbWYAj5MmwyYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348601; c=relaxed/simple;
	bh=cYnJW78Gehh4DGp2NUhOodN2Rt5ZWG4mO0FsuFnwkd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nKgvlIhTeebzicY6yTKcy3Lyukszk63MdDsocSrei3FV3hNfAVzl9a3EDDvcBwyQNM1VBTubtEyRnRcoxHUH5VYPxufstaGO7CVxgo6DlwtjxtOaLa3XiotRBEf2hPzYOtnfOpPnXY8Aeld4jao2KLCytyuR7yAdkWbkMvPfI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8vo7PMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8vo7PMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A8C1F000E9;
	Fri, 21 Aug 2026 21:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348600;
	bh=xhxUEOVMCv/7tpjqK84NcmqNMJxeo4z/9gJcc3n3n2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W8vo7PMCt1rtDAo1lP6Emu0MTGj/CaCdg/2rbvoDHg9HXo9chEjZaUN76olhCNs4L
	 iIJRB7I6n5tugdToEG/hxMuKcaKQMi9yhJ71QUCqZr1ci/46rM9rtunOen0j+vj+YJ
	 39DRJdnzzYkuDyRrSd1pLjSPGpjJVNPRy4/xCekpqrXwZl60K2sMrggXvkZX65iH3e
	 fi2jYmJ8ICiuTAkyw40dWX9Aj9ouhHqiX+U+I+4IX/hQPaz2OvjnjdmYJGdkxgsAP4
	 0YEt4OJciW9xvktbNf7UCpgMxCzpADPFUyf0cgbk8pKTI2J3WYAoZxlqxwgEuym5kl
	 i7snfehrsGBug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] Input: imagis - add support for the IST40xx touch
 reporting format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markuss Broks" <markuss.broks@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260822-imagis-40xx-v1-4-73e6d6cdf110@gmail.com>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
 <20260822-imagis-40xx-v1-4-73e6d6cdf110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:43:19 +0000
Message-Id: <20260821214319.C1A8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional use of INPUT_MT_DROP_UNUSED breaks multitouch tracki=
ng for the new event-based protocol.

Pre-existing issues:
- [High] Missing i2c_set_clientdata() in probe leads to a NULL pointer dere=
ference during suspend/resume.
--

--- Patch [4]: [PATCH 4/5] Input: imagis - add support for the IST40xx touc=
h reporting format ---
commit 5561fc562e0ffc99ddfa7c21852a4e2ad13ae0e3
Author: Markuss Broks <markuss.broks@gmail.com>

Input: imagis - add support for the IST40xx touch reporting format

This commit adds support for the IST40xx family to the Imagis touchscreen
driver. It introduces the IMAGIS_PROTOCOL_TOUCH_EVENTS protocol which=20
derives contact slots from hardware-assigned touch IDs and translates
press/release events into contact state.

> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscre=
en/imagis.c
> index 6552d97efe32e..5254cccdd653e 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
[ ... ]
> @@ -150,9 +162,31 @@ static irqreturn_t imagis_interrupt(int irq, void *d=
ev_id)
>  			goto out;
>  		}
> =20
> -		pressed =3D finger_pressed & BIT(i);
> +		if (ts->tdata->protocol =3D=3D IMAGIS_PROTOCOL_TOUCH_EVENTS) {
> +			unsigned int id =3D FIELD_GET(IST40XX_TOUCH_ID_MASK,
> +						    finger_status);
> +
> +			if (!id || id > IST3038C_MAX_FINGER_NUM)
> +				continue;
> +
> +			slot =3D id - 1;
> +
> +			switch (FIELD_GET(IST40XX_TOUCH_EVENT_MASK,
> +					  finger_status)) {
> +			case IST40XX_TOUCH_EVENT_PRESS:
> +				pressed =3D true;
> +				break;
> +			case IST40XX_TOUCH_EVENT_RELEASE:
> +				pressed =3D false;
> +				break;
> +			default:
> +				continue;

[Severity: High]
Will this continue cause active, stationary contacts to be erroneously drop=
ped?

When using the new IMAGIS_PROTOCOL_TOUCH_EVENTS protocol, records with an
unrecognized event type are skipped here. Additionally, if the hardware omi=
ts
stationary contacts from the event stream entirely, they will not be proces=
sed
in this loop.

Because imagis_init_input_dev() unconditionally initializes MT slots with
INPUT_MT_DROP_UNUSED:

	error =3D input_mt_init_slots(input_dev, IST3038C_MAX_FINGER_NUM,
				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);

If a slot is not explicitly updated with input_mt_report_slot_state() during
the frame, won't input_mt_sync_frame() incorrectly release these valid,
skipped contacts and break multitouch tracking?

> +			}
> +		} else {
> +			pressed =3D finger_pressed & BIT(i);
> +		}
> =20
> -		input_mt_slot(ts->input_dev, i);
> +		input_mt_slot(ts->input_dev, slot);
>  		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, pressed);
>  		if (!pressed)
>  			continue;

[Severity: High]
This is a pre-existing issue, but does the driver fail to set the I2C client
data during probe?

Looking at imagis_probe(), the private ts structure is allocated but never
attached to the I2C client device via i2c_set_clientdata().

Later, during suspend/resume:

imagis_suspend() {
	struct imagis_ts *ts =3D i2c_get_clientdata(client);
	...
	guard(mutex)(&ts->input_dev->mutex);
}

Since i2c_get_clientdata() will return NULL because it was never set, won't
this cause a NULL pointer dereference panic on suspend or resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-imagis-40x=
x-v1-0-73e6d6cdf110@gmail.com?part=3D4
