Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52225B095
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 04:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790223457; cv=none; b=itRoS786xS9UXrm8lAQP8y5Jnz0skNwIv51GVEaxB4oSwWts3idOIiTk5W/fRrxKR4vo9ArxDQC5dSdRfIkDDRvzZQcHi8Hs9qXQ/G8zfDh/9D3wBiSl8yva92oO+3mZV0mR4rHmDq0OCK5S+x6KZPvUZDxgHruDX9v0Hi49kHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790223457; c=relaxed/simple;
	bh=kZ894kglcJqEhFAozY/MB/mfSz9TW3eS3B3+mP0z3LE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MJ/UbWOQiAjQQ4LL79zwcwISTEkTfgWo6TAOO4rAMSuikTwqMTHaGW/sqfLZwbzmB1ak6Qeu32vcXKR55uov8wBUWpL09QBE5c7ZMJq5FJx80kP1m0jaCQ/6D32+OaiZGgvwNhf4w7v+0myeMtG8AIOvbr56rjeZ4Pz6FcJ50pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE5OXTSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE5OXTSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FE81F000FF;
	Thu, 24 Sep 2026 04:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790223456;
	bh=52c69YQ72ivbamAb647oAGxnCA3EUcS+VGV/j+Ds+Zg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NE5OXTSKJO/otE3yG5UVTHyFmPMmk3krNgGWoAV3Pvlhuqg8OzxlKie51o6S2CyXg
	 tcqAbEMA1C1IRXkKKfAoXTI5eS7eOXjPGhND0Er+h/h7AecbNiybpLp/DFITFzqXs7
	 5qjyx7+uygJIx5rBbL+JMzvD476UB0WPwXCgyPMrPoD+bUrNePpfu1LtZpSNsqagBa
	 f/Y3ZqHS9J56yyIQy7Wdr4BZJCIS7ZAo7/KHYNwhyVuJtR47e7GXnT3sVSryj3HuRT
	 hHjWZfOUO58ehfdfv+0C/8C0bJYJTcjfAGXBNbJYQknej4r3qXUju5aW38E0l4rxZt
	 +OVWdxduqUxMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: serio - don't sleep on serio_mutex from
 drvctl_store()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260924040430.711439-1-ngocthang2710.1999@gmail.com>
References: <20260924040430.711439-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 04:17:35 +0000
Message-Id: <20260924041735.D5FE81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sysfs: write returning -EAGAIN breaks userspace ABI
--

commit 587df4e4a0dc7a2a601093d20c02612cf36f0cbd
Author: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Input: serio - don't sleep on serio_mutex from drvctl_store()

Writing to the drvctl attribute takes serio_mutex while holding the
attribute's kernfs active reference. serio_unregister_port() does the
opposite: it holds serio_mutex and device_del() then waits for active
references to drain in kernfs_drain(). If a drvctl write is in flight
when the port is unregistered, the writer waits for serio_mutex and the
unregistering task waits for the writer, and neither makes progress.

> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 54dd26249b027..5b650421e0663 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -357,7 +357,8 @@ static ssize_t drvctl_store(struct device *dev, struc=
t device_attribute *attr, c
>  	struct device_driver *drv;
>  	int error;
> =20
> -	scoped_cond_guard(mutex_intr, return -EINTR, &serio_mutex) {
> +	/* Port removal holds serio_mutex and drains us: don't wait for it. */
> +	scoped_cond_guard(mutex_try, return -EAGAIN, &serio_mutex) {

[Severity: High]
Does returning -EAGAIN directly to the VFS here break the userspace ABI?

Standard userspace tools (like echo) performing blocking writes do not
automatically retry on -EAGAIN. This causes them to fail outright with
'Resource temporarily unavailable' when the trylock fails in drvctl_store()
during concurrent port removal.

Could this be resolved by using sysfs_break_active_protection() or returning
restart_syscall() (which sets TIF_SIGPENDING and returns -ERESTARTNOINTR)
instead, to allow transparent restarting?

>  		if (!strncmp(buf, "none", count)) {
>  			serio_disconnect_port(serio);
>  		} else if (!strncmp(buf, "reconnect", count)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924040430.7114=
39-1-ngocthang2710.1999@gmail.com?part=3D1
