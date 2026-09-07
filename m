Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C4393DE9
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807782; cv=none; b=p+kldkEJxI6eUbUkQYat7QnnAsFu1EL/0HsUok5tEvLBGO7IwLEyHTrqDq6HfRkN+lYofKBM8T5KQgJAhxWyL6atJ8tdBnQmZDnRBoiiZtYSTF9ZpItT1MutvJiNG38Uzl4mUyvDzM8ytcvb/xq+f6MO/e1o0dFhQJEC8mno0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807782; c=relaxed/simple;
	bh=4Nf1MMPR6MSZZo2YwzdwZmo+Jr+KGlGU/OWoSsWgdvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n6KH4JrZGjif3gAWzV+rB0uAnCy75/blxODcKTZ5NM1oRE0vC8A6tnNXuIulkMY+J3MGh8xmcESgoqrN8ETrAXMDpsf7gjvSwetEeVPPb5WEi5AsPjtV7xnAAiq7OG56KwBhKs1ZpNjlOWODb5U1gQiRP/j1TcSvQ0GH0d+e6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCdGUCvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCdGUCvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B40E1F00A3A;
	Mon,  7 Sep 2026 19:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788807780;
	bh=bxF5fTWMz+IYl0sNS5wnsUiUJkIjuHgupYCjP91LMk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RCdGUCvMnEAuCG30QTp45CZ4ncT3WRl5Au598vqHyA3+CdJR/bwUMH4mgUeK/nkPu
	 2hsZ4qA/sZmMcUYYL+3Fo/HGflCsuyGyzhRCe3dVqittXXQTbwDUdEcQgAu6qQeASq
	 H1Vq3JG8XkeTnbSaPPeTtbSF36XylpSQJnMw4dqX41ugvF9jMr45Qf7mwoMV3PTQTa
	 IVB/rwZyYRC33avHpKZ7VS5OvZIfq2KUwQAER+yB3w6qAo2shL3hH0LlPevPH5QR/P
	 4D/lqqDOrohy2Yo69vCi0D2KQODnd+g26u6eboxcfNxvafsVAdr6LNgfjvrd+WsS25
	 /V161DYf2x9bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] Input: aiptek - validate raw macro indices before
 updating state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miguel Garcia" <miguelgarciaroman8@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
References: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 19:02:59 +0000
Message-Id: <20260907190300.6B40E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded user input in sysfs 'delay' attribute allows arbitrary u=
ninterruptible sleep, hanging USB unbind and device hotplug.
--

commit ba9154b0332977963ad5bed995346ca93b2e47dc
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

Input: aiptek - validate raw macro indices before updating state

This commit adds bounds checking for raw macro key indices derived from
tablet reports before updating the state in the driver. It ensures the
index does not exceed the macroKeyEvents array bounds to prevent out of
bounds access.

Link: https://patch.msgid.link/20260329001711.88076-1-pengpeng@iscas.ac.cn

> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index baabc51547b83..6210cd99d6291 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c

[ ... ]

[Severity: High]
This is a pre-existing issue, and was not introduced by the patch under
review, but while reviewing this file I noticed unbounded user input in the
sysfs delay attribute allows an arbitrary uninterruptible sleep.

In drivers/input/tablet/aiptek.c:store_tabletProgrammableDelay():

    err =3D kstrtoint(buf, 10, &d);
    if (err)
        return err;

    aiptek->newSetting.programmableDelay =3D d;

User input is parsed into an integer and stored without bounds checking.
When the execute attribute is subsequently written, this value is used
in aiptek_query():

    msleep(aiptek->curSetting.programmableDelay);

Can this cause a task to block indefinitely in TASK_UNINTERRUPTIBLE?

If a user writes a huge positive or negative integer to the delay sysfs
attribute, the unbounded value is passed to msleep(). While holding a sysfs
active reference, this prevents the sysfs node from being removed.

If this is triggered and the USB device is subsequently disconnected, does
this force the kernel's USB hub event thread to hang indefinitely in
kernfs_drain()? This would deadlock the USB hub and prevent further device
enumeration or disconnection.

Should this sysfs input be clamped to a safe maximum value before being
stored in programmableDelay?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907185001.1567=
957-1-miguelgarciaroman8@gmail.com?part=3D1
