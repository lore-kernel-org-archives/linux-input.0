Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC044C4F0;
	Fri, 25 Sep 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372109; cv=none; b=lE2+0iBAmH2ZRfqM+Eh5vdY3T5opMLjXq70y8D9qOluPG/VH8LsNgwH1RLsTqFO2TU0SCG8DbjBYXfJDKrSlWJiQ/uOB5uqzokYhGPMUTM/oGp95IFzjUf5zTgTluCKpjdxmk3Y1qAEsZytPj5b3s+5YZLFbDtHy/JKVcW4Oi7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372109; c=relaxed/simple;
	bh=DJubZJPIsLRxQd8vGUEF+UEZuBN400W8yA6sRMKnZms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EEV6Ux+IbSUb3Eg18h5XJ7jeZbQKRZcEYe0wNJIsD6qt1A5Fe/DoR+SSYloLqihOMw4NCWbzeMp8Btw86EWUDs1VA0XGY3Oq1UUAVXmcCjON4+ZXU+Zebmv6XyxbRPHO5Sn71r48JKroEBN0pxDVaa1vsyNJXKVzaKpRTLYW2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly2qc/op; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly2qc/op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744941F00893;
	Fri, 25 Sep 2026 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790372107;
	bh=QCKSgqjS+D+OFm+RznZEEWN/XkrrUXeNBokxLDetjqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ly2qc/opRn+HZc4nVX82TGc50wnkvWTRmIirnULuAwyZK+WnAJtgtOw5JP4KlGGeT
	 4x8aSYAvdISwc5yKwMPCKKKeg6dmPnk5yBVUyjOguPvrat8FOLshmpn3YOzGkxvDHW
	 7Dbw0OvEmGQcHR4+rd4IK3PLsM4f0Xy7Zo1xbc530FRHmtsK0sL7SJyThoy301E4ey
	 WVw3+5Z+VPhP3GZ9p8PD6dQ+g3JSYGwoR7YHqgc9/WmfYqqmH1pL6obfr8QiyB7g8Z
	 XYo4LJz6cp+2E5sFqTG02SM1NRRdNqF8HI5KVrMt48J+oB/XMSE+ge9xhreL3uTYzl
	 iMEMtUIi6ucsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/5] Input: stmfts - wait for controller ready after
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260925-stmfts5-v8-1-0fcf49e2c85f@ixit.cz>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
 <20260925-stmfts5-v8-1-0fcf49e2c85f@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:35:06 +0000
Message-Id: <20260925213507.744941F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] input: stmfts: premature command completion due to missing event f=
lush
--

commit 980291fffea4f1302d4d35aa190de1039c220daa
Author: David Heidelberg <david@ixit.cz>

    Input: stmfts - wait for controller ready after reset
   =20
This commit removes fixed sleeps in favor of waiting for a controller ready
event after reset. It adds a wait_for_completion_timeout for the reset
GPIO path, while preserving a 70ms sleep for boards without a reset GPIO.

> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscre=
en/stmfts.c
> index 972687797f826..1720202d6186b 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
[ ... ]
> @@ -587,27 +580,50 @@ static int stmfts_power_on(struct stmfts_data *sdat=
a)
[ ... ]
> +	} else {
> +		/*
> +		 * We do not know the real controller state (was it powered
> +		 * off or reset). Let's hope that this is enough time to
> +		 * initialize.
> +		 */
> +		msleep(70);
> +
> +		enable_irq(sdata->client->irq);
> +	}
> =20
> -	msleep(50);
> +	err =3D stmfts_read_system_info(sdata);
> +	if (err)
> +		goto err_disable_irq;
> =20
>  	err =3D stmfts_configure(sdata);

[Severity: High]
Does removing the msleep(50) here introduce a race condition on boards
without a reset GPIO?

By enabling the IRQ and immediately proceeding without the 50ms flush windo=
w,
the threaded IRQ handler can process the pending STMFTS_EV_CONTROLLER_READY
boot event concurrently with stmfts_configure().

If stmfts_configure() calls stmfts_command() to send STMFTS_SYSTEM_RESET:

stmfts_command()
    reinit_completion(&sdata->cmd_done);
    err =3D i2c_smbus_write_byte(sdata->client, cmd);
    ...
    if (!wait_for_completion_timeout(&sdata->cmd_done, ...))

And the concurrent IRQ handler processes the boot event and completes the
same completion:

IRQ handler
    ...
    complete(&sdata->cmd_done);

Will this cause the wait_for_completion_timeout() in stmfts_command() to
falsely succeed before the hardware actually processes the reset command?

If so, the driver might send subsequent initialization commands while the
hardware is still physically executing the reset, potentially causing the
touchscreen to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-stmfts5-v8=
-0-0fcf49e2c85f@ixit.cz?part=3D1
