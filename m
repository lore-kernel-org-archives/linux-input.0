Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975182949E0
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222623; cv=none; b=RgZKDBwS7QEUs0YZv5mizTgjawQ6opXRt3mf90x5qxWbn2CXP49fmfyzPxCAyba3Cjj9nI9RfQTyMI7hUuqqlPO5Yliw/VghmqaXIbdkjrPlWrpyqZEKtTPzdW00vLfF3JMoUzSvkLgG7HbAUC3umcgJoe3VymFyYgOfgjYhtWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222623; c=relaxed/simple;
	bh=jTf2qB8/e4ptLCMj92hebj6woDKGVJuF1AWYO3sOHJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uQuVzVjz2AzLqnm5DeYldmbyEk0W1+KqNGLRNMwn/DHWlcscNTPEuGOo6ikY9zfTJ+raisxG7O/mSY1yCTtEaf5TSqjNzy0Xfj89JJ29x/zhS5InHu3tAg1DqdPBQBcf7zgmi7yC/oOKhQs6APCJoXCaFhOHC7spUpQLRtZ4fgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbB2XGuq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbB2XGuq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EB21F000E9;
	Tue, 28 Jul 2026 07:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785222620;
	bh=z7uAnV5dzsyxWUDqIRR2souYWRUgeheDVY2Gmk2V+m0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TbB2XGuq8SQtV4+RDYsekJOPLX7Fb+gMLuwYNEj62xWNZ3e/d4xXK2tQp1TzpfW4+
	 Zza4r4NdMWE1+kpZehroqBZUuKRP6XM3uhGlzke8Ja+Zqa6g6SBbks/gBMcVaYiFk2
	 uaA/Pfh8N2w6lzuGAWRjKYvNf2WatJNVSmBQxcJDRfCYWOHmgNpfI5cP24EtPUGXQ5
	 N2SF00KcKNaVf4PtHnVSO7zqkDBLyhba+B2sGEH8xIFaGNx4UpAfRee9uxNpUOEEft
	 OO3DO+0MLs2GXZ6Y7fFo8B2FHHpyi6yrLdf59R/5wKHKlfyPFqx+WT10QhkDwChRC3
	 JoFzrA0cQqvgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: lm8323 - cancel PWM work before releasing device
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongyan Xu" <getshell@seu.edu.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260728065518.489-1-getshell@seu.edu.cn>
References: <20260728065518.489-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 07:10:19 +0000
Message-Id: <20260728071019.F0EB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Canceling the PWM work synchronously during teardown leaves the LE=
D permanently ON.

Pre-existing issues:
- [High] The LED brightness_set callback unconditionally acquires a mutex, =
causing a kernel panic when triggered from an atomic context.
--

--- Patch [1]: [PATCH] Input: lm8323 - cancel PWM work before releasing dev=
ice data ---
commit c5dd51a9a738c81ec9f9a4442ce237316cd3f671
Author: Hongyan Xu <getshell@seu.edu.cn>

Input: lm8323 - cancel PWM work before releasing device data

LED class device teardown sets the LED brightness to off. The LM8323
brightness callback responds by scheduling its private PWM work, while
LED core only flushes the class device's own work item.

> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8=
323.c
> index 8eac63b2d3046..88981de9a90fb 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -548,6 +548,13 @@ static struct attribute *lm8323_pwm_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(lm8323_pwm);
> =20
> +static void lm8323_cancel_pwm_work(void *data)
> +{
> +	struct lm8323_pwm *pwm =3D data;
> +
> +	cancel_work_sync(&pwm->work);

[Severity: High]
During device unbind, devres executes teardown actions in LIFO order.
led_classdev_unregister() attempts to turn off the LED by calling the
driver's brightness_set callback, which asynchronously schedules pwm->work.

Immediately after, this newly added devm action calls
cancel_work_sync(&pwm->work). Because the work was just queued, it is
synchronously canceled without executing, and the I2C commands to shut off =
the
hardware LED are never dispatched. This leaves the hardware LED powered on
indefinitely after the driver is unbound.

Should flush_work(&pwm->work) be used instead of cancel_work_sync() here to
ensure the shutdown commands reach the hardware?

> +}
> +
>  static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
>  		    const char *name)
>  {
> @@ -568,6 +575,10 @@ static int init_pwm(struct lm8323_chip *lm, int id, =
struct device *dev,
>  	mutex_init(&pwm->lock);
>  	pwm->chip =3D lm;
> =20
> +	err =3D devm_add_action_or_reset(dev, lm8323_cancel_pwm_work, pwm);
> +	if (err)
> +		return err;
> +
>  	if (name) {
>  		pwm->cdev.name =3D name;
>  		pwm->cdev.brightness_set =3D lm8323_pwm_set_brightness;

[Severity: High]
This is a pre-existing issue, but this callback implementation appears
problematic for atomic contexts.

The LED core allows brightness_set to be called directly from atomic contex=
ts
(e.g., by the timer or heartbeat triggers running in softirq context).
However, lm8323_pwm_set_brightness() unconditionally acquires a mutex at the
start of the function:

drivers/input/keyboard/lm8323.c:lm8323_pwm_set_brightness() {
    ...
    scoped_guard(mutex, &pwm->lock) {
        pwm->desired_brightness =3D brightness;
    }
    ...
}

Does acquiring this mutex unconditionally before checking in_interrupt() ca=
use
a 'scheduling while atomic' panic if used with a trigger like timer?

>  		pwm->cdev.groups =3D lm8323_pwm_groups;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728065518.489-=
1-getshell@seu.edu.cn?part=3D1
