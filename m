Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697949C4D4;
	Fri,  2 Oct 2026 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946877; cv=none; b=KM3NhsPjHFcYAtNtmLHSYGwfTFnDdoVv2CqUuLHqvJPwwnI76MdjGE9KfRj1CFKrdKITlmJ3+C7Ytl3I1EliP0s4BFtut4K7Ij5M/f5HA3+I3TvSScOsegyLfqYFpfl6oIaZzL8Xb9uxhTkJvyLPGBMbW8nBgti7z6AgyD3zFW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946877; c=relaxed/simple;
	bh=z0iIc2tve1rNuxj2OFEUTRxpGF2GkGvJrNH0erFscH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oUB9fsrcWQ1QJw2aPTWOtjruiiQH8JslBGR+uhz8iDkHkrNt/x9Or3BMg16Q3TXI3ddbEQtojvftBpI+krYKleBS/JtpBgBG4MHldkfsdLk+Mp3F5etqczMh0Yqry3rxBbe3dOMchusO/ZQCm8toRMGA97RTArSS+hx+nnSj/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwAJ2+2v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwAJ2+2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E641F00893;
	Fri,  2 Oct 2026 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790946875;
	bh=8/Std+9B1ry0MSHmZ2fFkOi48SGFV8Bgcd3WKbni33Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwAJ2+2vCmSj0n0KTww4OZsmotsnLJKIlSm+kBi4r3mLLprD1BvA8GJsHfpD0nFni
	 0jCUeuKo9dCA7hm1GRe2mx35YTl7mu70/wgNxTBGZjvFONl/jazv7ARlHLnsyzm7e2
	 2oBLh8ofKQUeJE5ZbLLzO79NiDkVcTLA0qWdgObjc+8djkZ6siCO4ughTh92bz4lI2
	 zJF4rbF5eQsTW9qfXgVs0h7XUOPogAbR/s4EbBGmBNc9DSMTqYma+F1gC2WMGB202n
	 jQSrkLc0s/7upD2lKJc1VcaYmKtmAXHk8iHEtLU6EmNVbsWPWa+M/7LMPde4AN49Yg
	 Y9quAVn/hlmQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] Input: hynitron-cst816x: time out gesture key
 release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <909d4a3a2182ede94e76f60954279774d5f91b15.1790944534.git.daniel@makrotopia.org>
References: <cover.1790944534.git.daniel@makrotopia.org>
 <909d4a3a2182ede94e76f60954279774d5f91b15.1790944534.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 13:14:34 +0000
Message-Id: <20261002131435.66E641F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] timers: use timer_shutdown_sync() for devres teardown path
--

commit f56704648dd845b470f4641ef231af0c72507d76
Author: Daniel Golle <daniel@makrotopia.org>

Input: hynitron-cst816x: time out gesture key release

This commit introduces a timer to release the gesture keys 40 ms after the
last report containing a gesture code. This prevents the gesture key from
remaining pressed indefinitely if the panel stops reporting after the
initial gesture event.

> diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input=
/touchscreen/hynitron-cst816x.c
> --- a/drivers/input/touchscreen/hynitron-cst816x.c
> +++ b/drivers/input/touchscreen/hynitron-cst816x.c
[ ... ]
> +static void cst816x_timer_stop(void *data)
> +{
> +	struct cst816x_priv *priv =3D data;
> +
> +	timer_delete_sync(&priv->release_timer);

[Severity: Low]
Does this devres teardown path need to use timer_shutdown_sync() instead of
timer_delete_sync()?

Using timer_delete_sync() in a final teardown path is deprecated. The timer
subsystem introduced timer_shutdown_sync() to permanently disable timers
during teardown.

Because devres executes actions in last-in, first-out order, the interrupt
is already freed and synchronized before the timer is stopped. A re-arm race
is structurally impossible here, making this an API compliance regression
rather than a use-after-free bug.

> +}
> +
>  static int cst816x_probe(struct i2c_client *client)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790944534.gi=
t.daniel@makrotopia.org?part=3D4
