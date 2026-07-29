Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BCE4156C6
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366651; cv=none; b=UPhFjh/gEJx1CZdvXHyohcqtsZ22r1/qUZL9kHO/Xt6/+upS7x/4Sle+OhirnPA+lBWrkZpnhlzeMH+nFXqsWZv1BmH7brOzX3XeCGWjQVRPVTkuffHO72AwwTAAWaqzmjBag0pJxgCaYW/aQp7IJrjnJcvVF+fQzon3xqvSOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366651; c=relaxed/simple;
	bh=FiKBdl2m9zLzYypT+jbOJ+LtV/yH1/G4C6EIR0jCFRk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E/Jd6PBWY0gqWPpvyDR9WYIMAEvsgXP8n/w1jsWjc9DSLXDRnsSD+D9MT0ztg13zu3fh9+g4vJo2vCVT9iWIkNo45RSTbHMNRziKfEHOkE5C1jAVStp9ji0MnGunw95TdhsIHL63AWCzHs+Z1qg8qCe9/MtiQgL/42OKAmi8cQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2RqXYCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2RqXYCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D041B1F00A3A;
	Wed, 29 Jul 2026 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785366650;
	bh=BgHqScF8FkAhN01E/0EaMvaRk+2rP+ZDvR32x7g5rok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d2RqXYCyH8DC196oT9mkYeCiKFcTT75oTKaKT3o5GxPMOoo56ge44HrcXznWAe+Ts
	 MN3LXr7kiqQegFYNbp0Fd0idU8C4sNowGxK2qOUfK40ENFLBjEnlJLOxgwpplCt5H7
	 j9wImWHRo3gZnPRdMH4x2dBO3Nr2u3f7TIVjCcU9VxVr/000Qap8cmPIl//svBBcLV
	 /QsDSIUvTrNXMsdE1DvxqxRw3OglTfeepmAFQ2jsMzXVtz5Hd79YQbDmf+IYih/Q12
	 yF98L4M8+7NPTSll3KaR5/Wk2Qi3GmXGswdGOAinZwj02XNnAfBjJfITnIEP68lJ0t
	 WGq0Qv5+7/Jzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: wacom_w8001 - compose the device basename in one
 place
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Bridges" <icb@fastmail.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <amqGsb0A6_dr9JLA@dev>
References: <amqGsb0A6_dr9JLA@dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 23:10:49 +0000
Message-Id: <20260729231049.D041B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `input_free_device()` on a successfully registered device =
pointer during the error path, leading to a double-free.
--

--- Patch [1]: [PATCH] Input: wacom_w8001 - compose the device basename in =
one place ---
commit c5b975c9cd0e7f7aaa34347ef2a6ab2d8f4d90b0
Author: Ian Bridges <icb@fastmail.org>

Input: wacom_w8001 - compose the device basename in one place
   =20
This commit simplifies the device basename composition in the wacom_w8001
driver. It removes the append helper and instead records the touch name
suffix in the device structure, allowing the basename to be assembled in a
single step using scnprintf(). The patch resolves format truncation
warnings while keeping the produced names identical.

Link: https://lore.kernel.org/r/20260716103236.28c1b5bb@pumpkin

> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touc=
hscreen/wacom_w8001.c
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c

[ ... ]

> @@ -654,8 +648,8 @@ static int w8001_connect(struct serio *serio, struct =
serio_driver *drv)
>  	}
> =20
>  	if (!err_touch) {
> -		snprintf(w8001->touch_name, sizeof(w8001->touch_name),
> -			 "%s Finger", basename);
> +		scnprintf(w8001->touch_name, sizeof(w8001->touch_name),
> +			  "%s Finger", basename);
>  		input_dev_touch->name =3D w8001->touch_name;
> =20
>  		w8001_set_devdata(input_dev_touch, w8001, serio);

[Severity: High]
This is a pre-existing issue, but I noticed a potential double-free in the
error handling path of w8001_connect() that occurs just after this code blo=
ck.

If input_register_device(w8001->touch_dev) fails, the code jumps to the fai=
l4
label:

fail4:
        if (w8001->pen_dev)
                input_unregister_device(w8001->pen_dev);
fail3:
        serio_close(serio);
fail2:
        serio_set_drvdata(serio, NULL);
fail1:
        input_free_device(input_dev_pen);
        input_free_device(input_dev_touch);

Since input_unregister_device() manages dropping the reference count for
successfully registered devices, falling through to fail1 calls
input_free_device(input_dev_pen) on the same non-NULL pointer, which will
drop the reference count a second time.

Could this cause a double-free of the input_dev structure? Would it be safer
to set input_dev_pen =3D NULL in the fail4 block after unregistering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/amqGsb0A6_dr9JLA@de=
v?part=3D1
