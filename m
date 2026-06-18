Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B4361DBC;
	Thu, 18 Jun 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768500; cv=none; b=nBjtfz0nlhmZui7jeZosY5WXsptQNFzkkX0OayVi1MVcsAQhxQA52pVjc9ZNWA4RIhCYnOfsVCKokiNeDLjrbHLySZQQYMDCVbdXrbasTGxsEwU99L2WruhmaMREnl82MnGSGeMW+eKT6RzX4mmse/iWl7nyoZAjSfiuV9dgUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768500; c=relaxed/simple;
	bh=Abdi6JVxKaEyCxcFb8cyE6HqSI8Q5MtGOktnH08J16M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZ8mIZDGvg9pu9PMkVUIftiZQ1g/IlHPzSMwRAAjJe767ylD2R8JkArsZ7H+/iBHPvc+bU+0fpUzP/kqzkQW2bNmD0k2YqdffSmP/zykLTSVFcgkLU6gCfbvilusC7LCbtDJiidoPAJLeS3wAosUkTpyqG9qMBoKE1GxOD4p9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDaH29aZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDaH29aZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592941F000E9;
	Thu, 18 Jun 2026 07:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781768498;
	bh=ME1s5F3V6jeiNYpnqaDUaD2BD3/7PvMOS5kYRVYpk8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDaH29aZuTMaa3cMecDc1r16Ya+ZigqPxEYgmxSWZtPHFdxeBh6t+9T0rP+c/kNI0
	 l7H+M+QsMc5dzs8A6hVTbsi7o0DP3R3Hw4eFE4jLwfrNHV0wo9AWP+L7/9ITjwUwmY
	 M6gRswZ06j1JmiErTMTCjkeytVWLFPdn7s2xPyb/s+Zq2dzF8AQI+rCa9DV4svSJiT
	 af9Pf4SwAUDzpqcQUVcoayNNMpP2a9iQQtkRIz7NywkZlScfRu2KVuhoc19+u8GbNn
	 NBGgAOepKhR3uxZ3jDhh6kdWc8eypYDyiYEkHBq9OuCu1EwiIgQpZYvAsuns934Qdp
	 a6IJ8JUPsrcyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] Input: snvs_pwrkey - report press event in
 interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260618-b4-pwrkey-v4-4-4bfda105bdf3@oss.nxp.com>
References: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
 <20260618-b4-pwrkey-v4-4-4bfda105bdf3@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 07:41:37 +0000
Message-Id: <20260618074138.592941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The spinlock scope is too narrow, allowing the timer softirq and i=
nterrupt handler to interleave their event reporting, which can leave the k=
ey permanently stuck in the pressed state.
--

commit 115416424bcbaae3f95f1195f01f6e828f579e10
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - report press event in interrupt handler

This patch modifies the driver to report key press events directly in the
interrupt handler during system suspend to prevent event loss. It also adds=
 a
spinlock to protect the keystate and suspended tracking flag.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c

[ ... ]

> @@ -49,14 +51,21 @@ static void imx_imx_snvs_check_for_events(struct time=
r_list *t)
>  	struct pwrkey_drv_data *pdata =3D timer_container_of(pdata, t,
>  							   check_timer);
>  	struct input_dev *input =3D pdata->input;
> +	bool state_changed =3D false;
>  	u32 state;
> =20
>  	regmap_read(pdata->snvs, SNVS_HPSR_REG, &state);
>  	state =3D state & SNVS_HPSR_BTN ? 1 : 0;
> =20
> -	/* only report new event if status changed */
> -	if (state ^ pdata->keystate) {
> -		pdata->keystate =3D state;
> +	scoped_guard(spinlock_irqsave, &pdata->lock) {
> +		/* only report new event if status changed */
> +		if (state ^ pdata->keystate) {
> +			pdata->keystate =3D state;
> +			state_changed =3D true;
> +		}
> +	}
> +
> +	if (state_changed) {
>  		input_event(input, EV_KEY, pdata->keycode, state);

[Severity: High]
Is the spinlock scope here too narrow?=20

Because the lock is dropped before calling input_event(), it seems the
interrupt handler could preempt this thread and reorder the event delivery
to the input core.

>  		input_sync(input);
>  		pm_relax(pdata->input->dev.parent);

[ ... ]

> @@ -92,6 +103,21 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq,=
 void *dev_id)
>  			input_sync(input);
>  			pm_relax(input->dev.parent);
>  		} else {
> +			/*
> +			 * Report key press events directly in interrupt handler to prevent e=
vent
> +			 * loss during system suspend.
> +			 */
> +			scoped_guard(spinlock_irqsave, &pdata->lock) {
> +				suspended =3D pdata->suspended;
> +				if (suspended) {
> +					pdata->keystate =3D 1;
> +					keystate =3D pdata->keystate;
> +				}
> +			}
> +			if (suspended) {
> +				input_report_key(input, pdata->keycode, keystate);

[Severity: High]
Could dropping the lock before calling input_report_key() lead to a race
with the timer softirq emitting its own input events?

For example, if the timer softirq reads state as 0 in
imx_imx_snvs_check_for_events(), updates pdata->keystate to 0, and drops
the lock, an interrupt could then preempt it:

CPU0 (timer softirq)
    scoped_guard(...) {
        pdata->keystate =3D 0;
    }

CPU0 (hardirq preempts before input_event is called)
    scoped_guard(...) {
        pdata->keystate =3D 1;
    }
    input_report_key(..., 1); // PRESS emitted

CPU0 (timer softirq resumes)
    input_event(..., 0);      // RELEASE emitted

In this scenario, the input core would receive PRESS followed by RELEASE,
leaving the final input state as RELEASE (0). However, pdata->keystate
remains PRESS (1).

Would this cause the next physical key press to be ignored since the timer
will see state=3D1, but the XOR against keystate (already 1) evaluates to 0,
effectively losing the event permanently?

> +				input_sync(input);
> +			}
>  			mod_timer(&pdata->check_timer,
>  			          jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-b4-pwrkey-=
v4-0-4bfda105bdf3@oss.nxp.com?part=3D4
