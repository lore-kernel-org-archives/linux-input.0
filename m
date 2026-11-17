Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923004;
	b=2iJ9FVthzVokx6TXwdDlOMdcV/AmZVU/u1O8uWViL//+HW3jFwCR3yFVIfib8GGKlBXX
	 VOPfxOWT/KV8HEG0nM21h2dWB3tu6Y+W9jab4bYL7oiRAhJvoND8zqLYjtZtOAwQz5kpt
	 iF38TWCN51QW3ZBCvo5ato2Q5wDd4uWuCpa9h1e2Uy+F3KH0NhWWclXrBmtYXfu/5c0nV
	 0sP3ymwe1heIg3ysJxSBXa2Qo2p4/qhcjEUlyABmN6s+Sb2ty7GJSj5Wmj0dAdsva8ecY
	 jM9kAQAonfGyltuaAVbcbZj0wnonn0V2lcv3LNAATsyoRZfyIvbD8ZADYKUn1fVqtBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923004;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aq1QlB9f0rwslTenErOUzzlTaS+RXbiPsuyp0pgQCik=;
	b=H9LOFYFBYUe5zGy7HZ4zm7XkPHKeeSchDXZ598RPj7ybO51S0WF6iryfBleTVXhE7JeS
	 7YJY6MuxAFcZC9HencqyNmuHuSBPGJjp4c03ANNdr8bqoNzh1XTGYv1OfZ4oi7hSttIs6
	 bvvJ6AUELajF93xPg8XzLOq2ENTH77ID7c/+OVcmKIdQ7AhnDE2ewZC02nkHmbI+W3aCx
	 WBL8z2VQH6wEGKM2aR06+A/+PUHKmc0vMKjdxbrQUbHwKo/EnwKahoYBFjTJPg/ZHferp
	 ej+GWLVPOl/nPihPgp+OYbRZxtwJDxnTHUkdz33XUTAN4zQucNWNskKR2ouvJ9pwEtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eTXvD8A/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D8606A31C;
	Tue, 17 Nov 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTXvD8A/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EC61F000C5;
	Tue, 17 Nov 2026 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923004;
	bh=aq1QlB9f0rwslTenErOUzzlTaS+RXbiPsuyp0pgQCik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTXvD8A/45f7EJn4JbWwK1sYfup224mA3iCH8pGJlsJP0ktrl1YpAj8fM9QriO1E5
	 Vk9dJZrTvz8vjSANiIr1A3P+ZyWcx/TbCvIj9gTxK9to6lZvh+oTpGx1voWqBYUyWX
	 gOx6hy03Nos/mMoRrXEJ9YaAbPjGtmlU/C8Ul6k2NN6YVFmUO29MiNrIhaqel9knwK
	 qw66vCppPqss2b1GBF1ZlnDb1johibUuGl3fVy6MFksqm8qG7h71x2RfxeWVIKk3H4
	 9OLpvzaZlFniF8LuknPXvZ1htvLVhhVFEZzJQo+CrQJOoz37Z0lBmlmU+OsPI3gi3F
	 JVXmebPJySowA==
Message-ID: <sashiko-outbox-218896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/6] clocksource: add the SiRF AT550 counter and
 match timer
Reply-To: sashiko-reviews@lists.linux.dev
To: yy-Local-LLM <yogo.0917.sabu@gmail.com>, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117-at550-rfc-v1-v1-3-5879573cb825@gmail.com>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
 <20261117-at550-rfc-v1-v1-3-5879573cb825@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:43:23 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] clocksource/drivers/at550: non-real-name handle in
  Signed-off-by trailer
- [Medium] clocksource/drivers/at550: MMIO read before clock enable in
  at550_timer_init()
- [Medium] clocksource/drivers/at550: missing set_state_oneshot_stopped
  in at550_timer_init()
- [Medium] clocksource/drivers/at550: stale match race in
  at550_next_event() status clear
--

commit b350bccc2b4d4235b5ab2d214012109afb381252
Author: yy-Local-LLM <yogo.0917.sabu@gmail.com>

> clocksource: add the SiRF AT550 counter and match timer
>
> Use the low 32-bit counter as clocksource/sched_clock and match zero as
> a one-shot clockevent. Obtain its rate through the common clock
> framework. Preserve the firmware counter/divider and refuse a running
> watchdog. Unwind IRQ, clock and I/O resources if initialization fails.
>
> Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>

[Severity: High]
Under Documentation/process/submitting-patches.rst, the Developer's
Certificate of Origin requires a real human name (known identity) in the
Author header and Signed-off-by trailer rather than a handle or LLM
identifier.

> diff --git a/drivers/clocksource/timer-at550.c b/drivers/clocksource/time=
r-at550.c
> new file mode 100644
> index 0000000000000..a47dadfb9554f
> --- /dev/null
> +++ b/drivers/clocksource/timer-at550.c
[ ... ]
> +static int at550_next_event(unsigned long delta,
> +			    struct clock_event_device *event)
> +{
> +	u32 target =3D readl(at550_timer) + delta;
> +
> +	writel(0, at550_timer + AT550_ENABLE);
> +	writel(1, at550_timer + AT550_STATUS);
> +	writel(target, at550_timer + AT550_MATCH0);
> +	writel(1, at550_timer + AT550_ENABLE);

[Severity: Medium]
Can a stale value in AT550_MATCH0 fire a premature interrupt when
at550_next_event() clears AT550_STATUS before updating AT550_MATCH0?

Because the counter is free-running and AT550_MATCH0 still holds the
previous comparator value when writel(1, at550_timer + AT550_STATUS)
runs, the counter reaching that old comparator value before the new
target is written to AT550_MATCH0 re-latches bit 0 in AT550_STATUS.
Setting AT550_ENABLE to 1 then immediately triggers an interrupt even
though the new target is still in the future.  Disabling AT550_ENABLE
first, computing target and writing AT550_MATCH0 before clearing
AT550_STATUS avoids latching a match from the old comparator value.

[ ... ]
> +static int __init at550_timer_init(struct device_node *node)
> +{
> +	struct clk *clk;
> +	unsigned long rate;
> +	unsigned int irq;
> +	int ret;
> +
> +	if (at550_timer)
> +		return -EINVAL;
> +	at550_timer =3D of_iomap(node, 0);
> +	if (!at550_timer)
> +		return -ENOMEM;
> +	/* Do not disturb a running firmware watchdog or unknown divider bits. =
*/
> +	if (readl(at550_timer + AT550_WATCHDOG) ||
> +	    readl(at550_timer + AT550_DIVIDER) > 0xffff) {
> +		ret =3D -EBUSY;
> +		goto unmap;
> +	}
> +	clk =3D of_clk_get(node, 0);
> +	if (IS_ERR(clk)) {
> +		ret =3D PTR_ERR(clk);
> +		goto unmap;
> +	}
> +	ret =3D clk_prepare_enable(clk);

[Severity: Medium]
Does at550_timer_init() read AT550_WATCHDOG and AT550_DIVIDER before
enabling the timer clock?  If the peripheral clock is gated prior to
clk_prepare_enable(), reading those registers can cause a bus hang or
synchronous external abort during boot.

[ ... ]
> +	at550_event.name =3D "at550-match0";
> +	at550_event.features =3D CLOCK_EVT_FEAT_ONESHOT;
> +	at550_event.rating =3D 200;
> +	at550_event.set_next_event =3D at550_next_event;
> +	at550_event.set_state_shutdown =3D at550_shutdown;
> +	at550_event.set_state_oneshot =3D at550_shutdown;
> +	at550_event.tick_resume =3D at550_shutdown;

[Severity: Medium]
Should at550_event.set_state_oneshot_stopped also be set to
at550_shutdown?

When the last pending timer event is cancelled and tick_program_event()
is called with expires =3D=3D KTIME_MAX, it switches the device to
CLOCK_EVT_STATE_ONESHOT_STOPPED without calling set_next_event().
Without set_state_oneshot_stopped, __clockevents_switch_state() returns
-ENOSYS and leaves AT550_ENABLE set, causing the previous AT550_MATCH0
value to fire a spurious interrupt when the counter reaches it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-at550-rfc-=
v1-v1-0-5879573cb825@gmail.com?part=3D3
