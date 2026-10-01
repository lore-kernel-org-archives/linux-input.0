Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44D4E73CF;
	Thu,  1 Oct 2026 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852496; cv=none; b=dAGiPZ6oEoNWf01xJTr63ZVGbR9SXl9kPalLHhuWXxFabA7/af2pYdgnCRdwMsOGNo1tA/SR54NxboyDX9k0MrwIdCR+ATXQxPw2EX/Mphz/dpSepa0JhGQLBgvtTj8rhlYT/E6YnM9eaFAejYkerAOAU7fLbDSZh02o6GAVGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852496; c=relaxed/simple;
	bh=dT8GGhH0EnHDQq0rdbEd0i/FH5qFDgpZhHAGEdDLKUw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Caw60QZtZG1I0ajFki10YsgDFIeUNVbVF1rNtg8Puj0RzVxkzQV2JmI0jh+vUPnmNhowGDUOY6xAMQNJODl6NTErnzOnIttKHuUKGfEmrA5S7CVH4olLrqF0mUGr5avrX6fG8JGm/3Gn3Odpt7UpgXdqHZ1qTTGsjEpHTcfW2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFA11CdL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFA11CdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8AF1F000FF;
	Thu,  1 Oct 2026 11:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790852494;
	bh=+X2aXd86Zi6r1l4bysUmL99qaQvOwENf4UbPAbs02I8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZFA11CdLfXVaA4JhBK7h/eFvZ/hz5yzZozAEil0ojDNVu2uRhM6bPBGjEEuzOMxgU
	 +lWTna2at0DD70n5Ca3a1RSnF6R98+KMddq5AOrQteQTuUgajEGDXbJ4FCmF2S3fxA
	 N4oqNWl/1gU9urwsG+lwqJuhRt44Uxmiyhe/BzqeYQxTS4kSkDOUW9du6BhOj0vuOT
	 Bk/fvnPDFyL+Vf01kFnoWuygiF03UBuE1nLwK5ei8KVmAZgurOuwj+sG2HfuRiQtDo
	 NlJCseQaobS2h0u+hDRem9jQsf3ATHxV90e9fJ6v0aTj4k+Aoiwk8CS3TogNRl2gf9
	 WXGgPXH8iA8Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] Input: hynitron-cst816x: time out gesture key
 release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <ea9fa494cfb0a10cee72795a60ed5481fb227de5.1790851590.git.daniel@makrotopia.org>
References: <cover.1790851590.git.daniel@makrotopia.org>
 <ea9fa494cfb0a10cee72795a60ed5481fb227de5.1790851590.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 11:01:33 +0000
Message-Id: <20261001110133.AC8AF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: spurious key release due to timer callback race
--

commit 84ec9fce5971ed83d872b86322e5cd6170da5358
Author: Daniel Golle <daniel@makrotopia.org>

Input: hynitron-cst816x: time out gesture key release

This commit adds a 40ms timer to release gesture keys if a new touch
event with a gesture code is not reported in time. It helps prevent
keys from remaining stuck in the pressed state when the panel stops
sending events.

> diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input=
/touchscreen/hynitron-cst816x.c
> index e2093518e8af1..30f8ea314ed2c 100644
> --- a/drivers/input/touchscreen/hynitron-cst816x.c
> +++ b/drivers/input/touchscreen/hynitron-cst816x.c
[ ... ]
> @@ -177,33 +184,65 @@ static void cst816x_release_keys(struct cst816x_pri=
v *priv)
[ ... ]
> +static void cst816x_release_timeout(struct timer_list *t)
> +{
> +	struct cst816x_priv *priv =3D timer_container_of(priv, t, release_timer=
);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	if (cst816x_release_keys(priv))
> +		input_sync(priv->input);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}

[Severity: Medium]
Could this unconditionally release keys even if the timer was just
concurrently re-armed by the IRQ handler?

If the timer softirq and the threaded IRQ handler (cst816x_irq_cb) run
concurrently on different CPUs, the timer callback might spin waiting for
the lock while the IRQ handler is reporting a new key press and re-arming
the timer.

Once the IRQ handler drops the lock, the timer callback acquires it and
unconditionally executes cst816x_release_keys(), undoing the IRQ handler's
action and causing a spurious release of gesture keys.

Would it be safer to check if the timer was re-enqueued (e.g., via
timer_pending()) while waiting for the lock before releasing the keys?

>  static irqreturn_t cst816x_irq_cb(int irq, void *cookie)
>  {
>  	struct cst816x_priv *priv =3D cookie;
>  	struct cst816x_touch tch;
> +	unsigned long flags;
> =20
>  	if (!cst816x_process_touch(priv, &tch))
>  		return IRQ_HANDLED;
> =20
> +	spin_lock_irqsave(&priv->lock, flags);
> +
>  	touchscreen_report_pos(priv->input, &priv->prop,
>  			       tch.abs_x, tch.abs_y, false);
> =20
> -	if (tch.gest)
> +	if (tch.gest) {
>  		input_report_key(priv->input,
>  				 priv->keycode[cst816x_gest_idx(tch.gest)], 1);
> -	else
> +		mod_timer(&priv->release_timer,
> +			  jiffies + msecs_to_jiffies(CST816X_GEST_HOLD_MS));

[Severity: Medium]
Does re-arming the timer here race with the timer callback executing on
another CPU?

Because the timer callback does not check if the timer was re-armed, the
newly reported key press here could be immediately reversed by the racing
timer callback once the IRQ handler releases the lock.

> +	} else {
> +		timer_delete(&priv->release_timer);
>  		cst816x_release_keys(priv);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/d18629ede3f2fd5a08d=
0cbdaf82f4254e89500ed.1790851590.git.daniel@makrotopia.org?part=3D4
