Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9A238D52
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719914; cv=none; b=ijx9Yh/w0OvtmyPgqIgx7uPcvA6QcvmXuwXq9xzmjBATBQcHWcpjoBfIY2akO6c2MnnsumNJyMObZEZW9+MhlYo+AorEFjfuhSGQxmlzCSuo7Zs9v+yf0id7giTrOn0vFjdx/gssdgCcAlCgwX7U/zqjTKuKL6j+MTtA71xqeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719914; c=relaxed/simple;
	bh=VALd5mxg46fI+4izPBbpnKGwuI5U6koEJ/zSgI6Ewjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sRsMXCxDJslWCpF57wR9zfnHbJ6/twJTCs/EyZFm6bILRnJXAge+QhP0Vd75+AegSP3/OCke+mYXCm8nj6Bi7SIjj6xpxgCzXSRebFy6Ozh1IgQleOp8T0WkAi1a/5JIXQbZJUPf/PQK1pbS3uiWz33EuUkiHlI/460tQBs8ers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOKpN+YU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOKpN+YU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A000D1F000E9;
	Mon,  3 Aug 2026 01:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785719912;
	bh=8ZrAN623CIJhBVwx3ZWRPOH+DP0NBdScQyEPDzHC/jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOKpN+YUFEift650DwMZQOeoO0Z06QcN1nBSJrWQtLBawXL49iGI4X4hvhaoWaY6C
	 9F0n6obZS2ZojCqA3eJCiWs8+ktbKZXxmIyig+6E9TaGJz1sq9oGZTXdHmH1Lagg1s
	 fbRMjqzP5DiZCln2D6HyEADcXUKnSyxOWBLFl0yChjwnyKUcUeIJkhK8IQb/aRp2YQ
	 aq/cuMXkeQBkItuoiqavz9Ira2j3DFXxhDi+ydXB769pnKEX0fdLniYEyOsLnpshgt
	 SxPeutobqujNaEMnDt7k1jIFe0QTr6MYyvXLS5Lb4wzxnt7a/odIsQsfSam481oInD
	 ET66bk1A/T7pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] Input: clear inhibited flag before re-opening
 device on uninhibit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260803005210.1251102-2-dmitry.torokhov@gmail.com>
References: <20260803005210.1251102-1-dmitry.torokhov@gmail.com>
 <20260803005210.1251102-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 01:18:32 +0000
Message-Id: <20260803011832.A000D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] When `dev->open()` fails during uninhibiting, restoring `dev->in=
hibited =3D true` without holding `dev->event_lock` and without releasing a=
ctive keys leaves events permanently stuck in userspace.
--

--- Patch [2]: [PATCH v2 2/4] Input: clear inhibited flag before re-opening=
 device on uninhibit ---
commit f055731a6a02bc8698a040a5af7e51e9039340a7
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: clear inhibited flag before re-opening device on uninhibit

This patch clears dev->inhibited before calling dev->open() when
uninhibiting a device. It ensures initial events are delivered to handlers,
and restores dev->inhibited if dev->open() fails.

> diff --git a/drivers/input/input.c b/drivers/input/input.c
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1813,24 +1813,26 @@ static int input_uninhibit_device(struct input_de=
v *dev)
>  	if (!dev->inhibited)
>  		return 0;
> =20
> +	dev->inhibited =3D false;
> +
>  	if (dev->users) {
>  		if (dev->open) {
>  			error =3D dev->open(dev);
> -			if (error)
> +			if (error) {
> +				dev->inhibited =3D true;

[Severity: Medium]
When dev->open() fails and dev->inhibited is restored to true, is there a
potential data race with concurrent input_handle_event() readers?

Since dev->inhibited was set to false earlier, the driver's open() method or
interrupts could have emitted events before the failure. Does restoring
dev->inhibited here without holding dev->event_lock and without synthesizing
key releases via input_dev_release_keys() risk leaving events permanently
stuck in userspace?

>  				return error;
> +			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803005210.1251=
102-1-dmitry.torokhov@gmail.com?part=3D2
