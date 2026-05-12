Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE63A59BC;
	Tue, 12 May 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601680; cv=none; b=lcbcQZwagqyFGvVWF4QQ36dbyuGLVCAKJD8j4wRNSHLI+rlD1lmLMVryb/MSvCtsCgHrXJ4DojIOhIwgkA2fVVk3FdQ0ZucncZO5gtyw3x6O0ogmfU0pkfAqyFM/nkvAN1/Cz6gMDnKp3Fm9yES7abbpYOMowwOOqxLAeOR/QSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601680; c=relaxed/simple;
	bh=tMDdrST2+MqJfp4GnEJfnV05SbobE0mVhowzdQ04JD0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CCU2ei7NcIOH1IrBKcaqlMZd5geF7Sj1KNDwS8RYsOpKTSIjuT6niNaxlNL4MjBrxm13QhbjEzQ0s9o8JCg/D/IGrta6utShOq140EimxHr2gegkzoPe8gcvVElA3owEvkzOtimvtQn5gTaBK1X/Dk1T8Y5LA1eCA0MEuYSslvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUw6IM7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUw6IM7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C4FC2BCB0;
	Tue, 12 May 2026 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601679;
	bh=tMDdrST2+MqJfp4GnEJfnV05SbobE0mVhowzdQ04JD0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KUw6IM7DScIaUiiKa07oG+vCzNsgjj8aq1uU4Sv3TtRZ4a/0gGS8zAVrIQ+YFFafF
	 fphURbnCKHJDYUI5qw11lToWuBXjHSaU0AwW6XumnR5JfsTSqB8F6+5RdXEmPFOYof
	 nlR1YXwd8n4GZd8HxheIGhXZx1rQH8tslJCS5heH2im/OyIWz+hKYDh6QaGXmczQy3
	 kA6G4Yuj1jPIW41eH3RRfjN4nzws4MQyRflGaV6xuMtJ74kUwF/527cnZUgxwIRjbq
	 JlHVqXoqMbysUXY/C01VL/aFR3LNBTbkwtMya5Cx5uBQdpMQ95R1Ub44bfJYHNi8Xc
	 26I29cr2ARUng==
Date: Tue, 12 May 2026 18:01:17 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?EUC-KR?B?udq47cjG?= <mhun512@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: google: hammer: stop hardware on devres action
 failure
In-Reply-To: <20260424125043.52639-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
Message-ID: <42o9po52-64po-n8o8-or3q-q439o09s2p0p@xreary.bet>
References: <20260424125043.52639-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 24 Apr 2026, =B9=DA=B8=ED=C8=C6 wrote:

> From: Myeonghun Pak <mhun512@gmail.com>
>=20
> hammer_probe() starts the HID hardware before registering the devres
> action that stops it. If devm_add_action() fails, probe returns an
> error with the hardware still started because the cleanup action was
> never registered and the driver's remove callback is not called after a
> failed probe.
>=20
> Use devm_add_action_or_reset() so the stop action runs immediately on
> registration failure while preserving the existing devres-managed cleanup
> path for later probe failures and remove.
>=20
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/hid/hid-google-hammer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-ham=
mer.c
> index 1af477e584..c99c3c0d44 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -496,7 +496,7 @@ static int hammer_probe(struct hid_device *hdev,
>  =09if (error)
>  =09=09return error;
> =20
> -=09error =3D devm_add_action(&hdev->dev, hammer_stop, hdev);
> +=09error =3D devm_add_action_or_reset(&hdev->dev, hammer_stop, hdev);

Makes sense, thanks for catching it. Applied.

--=20
Jiri Kosina
SUSE Labs

