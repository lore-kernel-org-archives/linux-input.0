Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000EF34A3AB
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902378; cv=none; b=tjiFsFceYD9w2radl6bPXk2n8D4M2QaAmB2UI94v22P45UvcJwo3ZnzHZ4T8wbYU8AZGBsn26v4mprk1oj+pVO2ZzZjLYPMEXshAB0DDw+0WdoeXeSGCPhULOTj+1oSktUewUSnhBAJv8byfae3d0+by0qQECNQdR4Ly6I4zAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902378; c=relaxed/simple;
	bh=vgn7lq0sh759LKjMkub401OD0F35SEg8bb1NUclpZ/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Eflg3bP1zUH7pqhKGpyN3aJPijdDrwT145LnoO+rUe/PGKpphWfhN3m7uBmDnWCXiFLo0kaptN9QzwbRRYEMoRPKxsqOsd1E8EgCF7EP9ILNYv3yRRdiXDj6wAV0iAUPahxvJwK+YuxspAwJRc1QySvq2VTpuxiWu/vufvPHkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2N+Kcif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2N+Kcif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EE41F000E9;
	Wed,  5 Aug 2026 03:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785902376;
	bh=6yqp1Jw4epOvQu9mUyRNaKK7LLjRZFmmFju5aqvbybA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2N+Kcifcw8IKydrA6OA4mSrXY2EUB/zrUv9M83c8invWybs2AB6BNAUHk3BDkbXp
	 lfjkCswEBv6guZ7ylLOB265LMOFJPy1hIkDW/bkD9HhqfxjIVPAACq0lToOvEbuS7W
	 buOMfbkMcKyfyIjwATK3KYBh/1nDUpZww1Ex7jnflMSTyfvFVSstrR5FloFYu/vUsy
	 hsYCsZeA/5Z0zDTGVaAK3d+pCKtBMTlpdV/yNo4Fd+4Fennhjy7sUs1bFxiGyLRpwQ
	 Et7gEKa8dnv9A5SDWGqg2/5Gcc1S8Yrkw1+MSF8zFihYF0HbrQZdQA4vrnpQ7b58wv
	 2Q+oVu3azN6JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: mms114 - fix touch slot corruption in suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <anKxGkyRRu5A92Q_@google.com>
References: <anKxGkyRRu5A92Q_@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 03:59:35 +0000
Message-Id: <20260805035936.52EE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Active touchkeys are not released during suspend, potentially caus=
ing them to be stuck upon resume.
--

--- Patch [1]: [PATCH] Input: mms114 - fix touch slot corruption in suspend=
 ---
commit 1d29053929170cae6a2ebfa311bed7d55133b74a
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: mms114 - fix touch slot corruption in suspend

This commit fixes a race condition during suspend by disabling the IRQ and
synchronizing with the interrupt handler before synthesizing touch release
events. It also ensures touch release events are only synthesized if the
input device is enabled, protecting the sequence with the input device mute=
x.

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index 27911a9f4e9eb..734c37579f5a4 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -679,6 +679,13 @@ static int mms114_suspend(struct device *dev)
[ ... ]
> +	mms114_stop(data);
> +
>  	/* Release all touch */
>  	for (id =3D 0; id < MMS114_MAX_TOUCH; id++) {
>  		input_mt_slot(input_dev, id);
>  		input_mt_report_slot_inactive(input_dev);
>  	}
> =20
>  	input_mt_report_pointer_emulation(input_dev, true);
>  	input_sync(input_dev);

[Severity: High]
This is a pre-existing issue, but does this sequence also need to synthesize
release events for active touchkeys?

If a touchkey (such as Back or Menu) is pressed when the device suspends,
mms114_stop() powers down the hardware without sending a hardware release
interrupt. Since this loop only releases multitouch slots, it seems the
touchkey could remain logically stuck in the active state in the input core
upon resume.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anKxGkyRRu5A92Q_@go=
ogle.com?part=3D1
