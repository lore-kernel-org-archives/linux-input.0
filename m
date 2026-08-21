Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9D3148A7
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280623; cv=none; b=EuG54fgFsBF21rwyYgdwvzPnzsPvzBp3FjuaOD6vtX56t6LsgqBOq4ZkUUzvnP0bfQNogBibEF5E1CTZwfQTWuFSrKr+vPWK1osOTI6cnCA8DXZHhN85fzCuY9zQtW4IOwRoQDk5nUiAJKLBFeg8EgwDIap4HLn7VnItWd+d4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280623; c=relaxed/simple;
	bh=3DDFjDuyhAJEDoDHgx4yiGFJWskw+GbQ2FsVPxlnDY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BDMLwpyB8miKtwK8I7jLyzfjpKUTf86xgBRPU2IQp8nXq2Y3Hgvggki+SimVFZhGlRCael3t1JOIQvU6gnypRS6Z5QPWhymabzWLBtp1K9XurT1IfCFtLIK7YgfRqQtKbknmETDmGuhhjKQn9TI/7Mjye5i2SD8pdvZZEvKSji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM50OR9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM50OR9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9891F000E9;
	Fri, 21 Aug 2026 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787280621;
	bh=elqJ4QO8WL/Wco/Znbiwlc20nFuAe3YBhwlUNvmksyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TM50OR9NMBw5BIB21HtmvSIp/giNgYX/ZnpfSqqaeI0wc0fr9GOGFHLaiFwqYQSWl
	 kG2P2xka0fSExdbmt1jL0x+icmBcQGcFjYVc5zoBzTKeB/kl+pmP2riVT3+I8tTM8s
	 cNA60Ec9P+/zWUq4BBv+sw5c6Rx+ZkWPEfAf7RAnSIjcN951V6JItttJpfPkVFeMQz
	 wft0mNnLLgGP5OBD36FTuoY6CYoiAsdehpsUD0UwltrkdiqTO1GBxL3HxeO1CkRMdg
	 pAkkrzso/5Eexaqv/98R1DN5pZOjRpy17fRB0xKmSVPaz/5BEeHR+Q4KqU5iSBmUC1
	 6rtdQQsLDXmoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260821024215.55188-1-triet.hoang.dev@gmail.com>
References: <20260821024215.55188-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 02:50:21 +0000
Message-Id: <20260821025021.9F9891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch breaks the build when `CONFIG_PM` is disabled because `pm=
80x_dev_suspend` and `pm80x_dev_resume` become undeclared identifiers.
--

--- Patch [1]: [PATCH] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS() -=
--
commit 831b6a38a335cea06b4312be1068bf63ef9bd3c9
Author: Triet Hoang <triet.hoang.dev@gmail.com>

input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Convert deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS and
pm_sleep_ptr(). This drops the __maybe_unused annotations from the resume
callbacks and reduces kernel size when PM is disabled.

> diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm=
80x_onkey.c
> index fee28e537898a..d4f344e2bf5c4 100644
> --- a/drivers/input/misc/88pm80x_onkey.c
> +++ b/drivers/input/misc/88pm80x_onkey.c
[ ... ]
> @@ -47,7 +47,7 @@ static irqreturn_t pm80x_onkey_handler(int irq, void *d=
ata)
>  	return IRQ_HANDLED;
>  }
> =20
> -static SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
> +static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
>  			 pm80x_dev_resume);

[Severity: Low]
Does this break the build when CONFIG_PM is disabled?

Unlike SIMPLE_DEV_PM_OPS, DEFINE_SIMPLE_DEV_PM_OPS uses pm_sleep_ptr() which
evaluates the C ternary operator with IS_ENABLED(). This means the compiler
still parses the arguments and requires them to be declared, even if they a=
re
ultimately discarded.

Looking at include/linux/mfd/88pm80x.h, pm80x_dev_suspend and pm80x_dev_res=
ume
are wrapped in #ifdef CONFIG_PM without providing empty fallback stubs:

#ifdef CONFIG_PM
static inline int pm80x_dev_suspend(struct device *dev)
{
...

Will this result in undeclared identifier compilation errors when building =
with
CONFIG_PM=3Dn?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821024215.5518=
8-1-triet.hoang.dev@gmail.com?part=3D1
