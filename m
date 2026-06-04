Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AA3932DE;
	Thu,  4 Jun 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564038; cv=none; b=iA4pU+aI2EPgiWN0gZLh8L0qYXPN9kiiQnF9JXAe1/IkaNhNjBUrcg/7IGaJr1KZHoerDU32tp8QNLY1hyn8EvqbxmWrCD3khDQ2HLuYGo3oWtu2Ohxlsx8+TOTUXLSmcjFchqPc7qL8JEVFI0crSODYVodOri6NosoDNWclNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564038; c=relaxed/simple;
	bh=4Dx8xQtIfAIcySZNUoWXOt6atbzKmOkatsT/ShKvXW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R61fOy2mNxcCxKRG8yvuj+b9SywRF+fu40hvIgRiqO7QA6Xgq7ZVzLgUBvWfuJKo4PeYg3pvvBFbKQX96Sa/28dxGkvc+RcEHSW+0AbWCf9BR2mrDGFcTNMtnNq9Fzu8SPIrgQMzpXYCzmRzMnkluJq0ykq0hrdtQnvzk2ZBhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxZnfaun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxZnfaun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838A11F00893;
	Thu,  4 Jun 2026 09:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564036;
	bh=SC5b14PD4rYt3pOOvOPzUWaxWhKrTB9E/EzGrureIHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxZnfauntMQGs8BcsHqRHpDmF44E55aht20coQ6m8wjww/a9nIAKlqGu3Ws+XHfzI
	 DS9bqEyohBP+aHgJQazWk2B9akdhUDGyCIqiJSEVUPbIhZa7SfLMT0qb0EuNTB4L51
	 hMmxwR24HAzvMIXHDifquj3yKTYR3szZNYsH5gAXgtLHFmF/YkhsN7MtwxslzPyn8i
	 RzB2zG1SbnbbHugmPGJXDfcJ89d8HZ2lZI12OSplfTPax7q94dREGw6uVD4IF/H5Ji
	 uoS7wxI2yt3SdTb0sBRz1W6YG05psJi5ewf9jWPEU0rgnywjf45Ngdj2TlGj8iq5V0
	 nX+qJlCooXMow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] Input: snvs_pwrkey - report press event in
 interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joy Zou" <joy.zou@nxp.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260604-pwrkey-cleanup-v2-4-59fa0ddf0d7c@nxp.com>
References: <20260604-pwrkey-cleanup-v2-4-59fa0ddf0d7c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 09:07:16 +0000
Message-Id: <20260604090716.838A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race between hardirq and timer softirq leads to desynchronize=
d key state
--

commit 9a729213fc1cfc21c866a352fad1a978bfa80359
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - report press event in interrupt handler

This commit modifies the snvs_pwrkey driver to directly report key press
events from the interrupt handler during system suspend. This bypasses the
debounce timer to prevent event loss during the no_irq resume phase.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> index 4a1d048984826..f212a6b26185d 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
[ ... ]
> @@ -92,6 +93,15 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, =
void *dev_id)
>  			input_sync(input);
>  			pm_relax(input->dev.parent);
>  		} else {
> +			/*
> +			 * Report key press events directly in interrupt handler to prevent e=
vent
> +			 * loss during system suspend.
> +			 */
> +			if (pdata->suspended) {
> +				pdata->keystate =3D 1;
> +				input_report_key(input, pdata->keycode, 1);
> +				input_sync(input);
> +			}

[Severity: High]
Does this introduce a data race with the timer callback
imx_imx_snvs_check_for_events()?

The new hardirq logic writes to pdata->keystate locklessly here, but
imx_imx_snvs_check_for_events() also reads and writes it locklessly in
softirq context.

Could this sequence occur:

1. The timer callback reads state =3D 0 (key released) and evaluates
   (state ^ pdata->keystate) as true.
2. The timer sets pdata->keystate =3D 0.
3. Before the timer calls input_event(), a key press triggers the hardirq
   on the same CPU (preemption) or another CPU.
4. The hardirq sees pdata->suspended =3D=3D true, sets pdata->keystate =3D =
1,
   and reports a key press (1).
5. The timer resumes and reports the release (0) to the input core.

This would leave pdata->keystate as 1, while the input subsystem's last
reported state is 0. On the next physical key press, the timer would read
state =3D 1, evaluate 1 ^ 1 as 0, and ignore the event. This might cause the
power key to become logically stuck until physically released again.

>  			mod_timer(&pdata->check_timer,
>  			          jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-pwrkey-cle=
anup-v2-0-59fa0ddf0d7c@nxp.com?part=3D4
