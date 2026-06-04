Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5243637C
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579675; cv=none; b=X+7DjlphIvH9mpBni6TH0fLiMqxZGmiYHi5MkXdynCEV50peo4KEPALCJoXzk8r1k/zkmBP+F9jy6E9aohc10mt6HH1l1mnKylS5E/WeJT1DiyAczEr05yyyKcYSC0SEGnn39ya1PfPv4+EljNBwffVsk4uuqpsmb5C98XPoPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579675; c=relaxed/simple;
	bh=P4UONK3Wt/WKXCJ6cnpNGYRhc1HDZucjXRj8jB6+Ggw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=se5UCICWOO9H7yCEVlfQLLnCxkm5QCO41VwRC2ogpNu9ZMu+Y8ozPaO3QAlI1RUVk+iBtS/oF3+s6QTecWrGmZBnhJCuo5ksK7pvfBJm7hC1ve76AweS/Sts4FNaccHFgrIg9fYDSkh6el/tbG5OnOfGJGIW9TF5wuBLsPs6fmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsqfTaMB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsqfTaMB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FEC1F00893;
	Thu,  4 Jun 2026 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780579673;
	bh=QtjfOArjGm5bBPO7xl6EtCBO4m/0iR7jdNhSTqamZXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PsqfTaMByPfS/08WCuOQ5/6EHdolqx8LwetXWLZTIw4JsKAcvmE5eFXX6xfr/qY3v
	 tQGEBmJoC567TYT0Ute10sPJ35sVxz5R/tnkXdD9fuENx3722liobQUXbUoN9UfwhH
	 Wzjhmlvkevy2oEMSPuFlSpMvdlCZZtqwS9wHWU7bsat2hBJLjX43yx41OBolYOtRyt
	 aOv4MkwI3p23oA13Z+hxGPSFLorw4bEUST3mRtbU3yPD1Hv0C6JSapgxEjgpMfGw7H
	 vysEgjfwLRmr4SsTEqLAT+DBmSPmzie0aNMfggkXsAzhUy8M+IfqqgwXWjImOaggsf
	 SsYjt9AniwfVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: psmouse-smbus - schedule deferred rescan when
 adapter present but device not ready
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmFwaGHDq2wgTGFyb2NxdWU=?= <rlarocque@disroot.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260604131211.9442-1-rlarocque@disroot.org>
References: <20260604131211.9442-1-rlarocque@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:27:53 +0000
Message-Id: <20260604132753.B4FEC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infinite unbind/rebind loop breaks the PS/2 fallback if the SMBus =
companion device never responds.
--

commit 18a210ed3c950add4486fdb9a71222e2b1590d6a
Author: Rapha=C3=ABl Larocque <rlarocque@disroot.org>

Input: psmouse-smbus - schedule deferred rescan when adapter present but de=
vice not ready

This commit addresses an issue where the SMBus adapter is registered early
but the companion device is not yet responsive. It schedules a deferred
rescan using a delayed work queue to retry the probe without blocking boot.

> diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/ps=
mouse-smbus.c
> index 7fb4cbb2aca2f..704d8c2a028ba 100644
> --- a/drivers/input/mouse/psmouse-smbus.c
> +++ b/drivers/input/mouse/psmouse-smbus.c

[ ... ]

> +static void psmouse_smbus_rescan_work_fn(struct work_struct *work)
> +{
> +	struct psmouse_smbus_dev *smbdev =3D
> +		container_of(to_delayed_work(work),
> +			     struct psmouse_smbus_dev, rescan_work);
> =20
>  	guard(mutex)(&psmouse_smbus_mutex);
> =20
> +	if (!smbdev->dead && !smbdev->client) {
> +		psmouse_dbg(smbdev->psmouse,
> +			    "SMBus adapter present but device not yet ready, retrying\n");
> +		serio_rescan(smbdev->psmouse->ps2dev.serio);

[Severity: High]
Does this serio_rescan() call introduce an infinite unbind/rebind loop if t=
he
SMBus companion device never responds?

When serio_rescan() triggers, it tears down the PS/2 driver and initiates a
reprobe. During the reprobe, psmouse_smbus_init() runs again.

> +	}
> +}

[ ... ]

> @@ -290,6 +372,18 @@ int psmouse_smbus_init(struct psmouse *psmouse,
>  		}
> =20
>  		kfree(smbdev);
> +	} else if (smbdev->adapter_seen) {
> +		/*
> +		 * A HOST_NOTIFY-capable adapter was already registered when we
> +		 * scanned (so BUS_NOTIFY_ADD_DEVICE has already fired for it
> +		 * and won't fire again), but the companion device at 0x2c was
> +		 * not yet responsive =E2=80=94 typical of a cold boot on machines like
> +		 * the ThinkPad T440p.  Schedule a deferred rescan so we retry
> +		 * without blocking the boot path, mirroring what
> +		 * psmouse_smbus_check_adapter() does for late-arriving adapters.
> +		 */
> +		queue_delayed_work(psmouse_smbus_wq, &smbdev->rescan_work,
> +				   msecs_to_jiffies(PSMOUSE_SMBUS_RESCAN_DELAY_MS));
>  	}
> =20
>  	return error < 0 ? error : -EAGAIN;

[Severity: High]
If the I2C device is permanently unresponsive (e.g. the hardware is physica=
lly
wired only for PS/2 despite firmware capabilities), won't the reprobe hit t=
his
path again?

Since a new smbdev is allocated on every probe and there is no persistent
state tracking the retry count, this appears to unconditionally queue the
rescan again.

This would repeatedly destroy and recreate the PS/2 fallback every 1 second,
rendering the touchpad unusable. Can we limit the number of retry attempts =
or
track the state to avoid this loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604131211.9442=
-1-rlarocque@disroot.org?part=3D1
