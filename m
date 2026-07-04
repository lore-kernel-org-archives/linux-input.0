Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058738886A
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145628; cv=none; b=EzzllLOu7p8bBpfdgmtilhMi38bSZFDVTMGg+xUknBQ4gGQKbnwCMul2qXH2FyZR+5U8a6J6b7fyXDZi88oTDs4Dexa8Y9xyzVecxPWFUHHWQNEEYYit3xyaQLUIBBnffsx+3CroemEl6qiN819gvHXAqJJDXN9nS76GVlF0BXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145628; c=relaxed/simple;
	bh=x9jQNhVc0PTULd/Nv6UJoCxWTG1ctvABZeAdt0UutGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eKTyG52bC1gCf3QQZTK5iRtcPtWVc8MNZb58KVZ9CezBwEyeBTuFVC3hqlmg1Om8FTTWB4NIBUdlHjWOTJYw8GChN4bongRPxR2ZKV/fUo9srF3FfE7iogX/rAVNegJJlqqi5OGbksr7rrUJj8s0KnbyNYZEUgS9rrT4abV7PxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsIibU0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsIibU0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DD01F00A3A;
	Sat,  4 Jul 2026 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145627;
	bh=wY9D0PAeNsligFzI1gp20Qah4pcy/r7bFB0Sd/oc6Zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZsIibU0E5Rm/SyzCoWIXkbQs4DtDfuW7cqIYY93Xe60t4xG6UUITGRAA4nwXn2n0i
	 CMBHS+RUmG1EOJ45xXzsL2qUUfB50nbEVFUo/VE3TTru/Dc1rkG2uSqt/TwZc67axg
	 Wn0vOg0JzIZqtzbS9DJnK2YpySLva7YoJdx3viy7y092NNcAamgZBryccd33EIoRQd
	 verFQ7elGsQVGlimrSwaeKBFiXTRTKVhFRHPCpW7eiPgfsUKCKnFrZe0B5taVEZGVN
	 nYOtW+u71kvTd1azqUWxK96Yfe6eSCYDDFoovphdqOMWprSIjCBLUpqTCrpDZTIwwW
	 T4ti2HqQtV72Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/26] Input: maplecontrol - convert to devm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-b4-maple-cleanup-v1-22-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-22-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:13:46 +0000
Message-Id: <20260704061347.38DD01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the event report=
ing callback `dc_pad_callback` fails to call `input_sync()` after reporting=
 key and absolute axis events, preventing state updates from reaching users=
pace promptly.
--

commit bb1e0ba07531193e46d25e174ec864860b0026be
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: maplecontrol - convert to devm
   =20
Convert the driver to use managed resources to simplify resource
lifecycle management. This eliminates manual error handling in probe()
and allows removing the remove() callback entirely, as all cleanup is
handled automatically.

> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joysti=
ck/maplecontrol.c
> index 6864243b0b4a2..3ef6652d40cb6 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c

[ ... ]

> @@ -129,33 +130,20 @@ static int probe_maple_controller(struct maple_devi=
ce *mdev)
>  	if (idev->keybit[BIT_WORD(BTN_JOYSTICK)])
>  		idev->evbit[0] |=3D BIT_MASK(EV_KEY);
> =20
> -	idev->dev.parent =3D &mdev->dev;
>  	idev->name =3D mdev->product_name;
>  	idev->id.bustype =3D BUS_HOST;
> =20
>  	error =3D input_register_device(idev);
>  	if (error)
> -		goto fail;
> -	return 0;
> +		return error;
> =20
> -fail:
> -	input_free_device(idev);
> -	kfree(pad);
> -	return error;
> -}

[Severity: High]
This isn't a bug introduced by this patch, but I noticed the event reporting
callback dc_pad_callback() fails to call input_sync() after reporting key a=
nd
absolute axis events:

drivers/input/joystick/maplecontrol.c:dc_pad_callback() {
    ...
	input_report_abs(dev, ABS_RX,     res[14]);
	input_report_abs(dev, ABS_RY,     res[15]);
}

Without a final input_sync(dev), will state updates be prevented from
reaching userspace promptly, causing events to get stuck until the internal
buffers fill up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D22
