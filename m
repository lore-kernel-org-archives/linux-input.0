Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBDB331EB3
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788646154; cv=none; b=hAt/QiuHOucAJS9klwF74LK1fP29+m3YiDlQ4vJP1/ZippysGY+TcKIp0c9RCJMDBytpFM2kdJIfum7PuGyz3VMC3/qneg/WrtVH1E07fnYGu09JtX/xXvwH6Zxu0Wygtaw5oNENrEjogcyYVbAkyBKphqPCtlWG5Pu2+DKHxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788646154; c=relaxed/simple;
	bh=wHcQ5HgGMjVMQTN78BaVxXvxvXISkf6HevQyQ6z/9vw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qwatRzLdP172HMdsdWb0cPi6uKAiveUwog+jReCqBPws4DykReljrnXN9ot0K7/ffKPgkV8kefKLRJj2DgtRRQ66dBOhAwAGu5/DFxFvs6/SqS9952DcFxyosNZM45ykemMwc766icbEBHD2uPAIPsTxEvE6mPQbMd+BSq8mmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvDMRSFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvDMRSFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1711F00A3A;
	Sat,  5 Sep 2026 22:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788646152;
	bh=r7mZkt7HJj8rXKdAlfljRqNPCbrATST867ztUss0guk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cvDMRSFT5NO8QLyQO/dgnEu9nWt+j+KUhjSVbpTulGKH5im5B4Bma9e2R/CCbN0r1
	 w5nzFKBlVrxuqt8eq4I87+iv7RsXgWqyGvm8+N9o2Vdw4pXrub9mTtnSnmN0i4DPR2
	 FL+r1IfF2YHNvzF+bCacFr8iGt584dSXSh7ZfHy4sRVupq958NE/AJeSdHL+nMhs6d
	 Wd7EeAfaWQfr9XIMTwh+Z8mlVQGaZN74uh8X1vkMTftElqb6WohQuyggJ67AADW6lh
	 +VL8xaGkMglXmYi5nsh4loFsKOs+1VLS+kEWTBVOhopIo87ueszeDNd3Qrv0XLDYCq
	 dbzE1TxVdELBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: Cancel init_work when probe fails after
 scheduling it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aamir Ahmed" <elb12345@hotmail.co.uk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <PAXP251MB001050EFD88752318EBA75F5C8B42@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
References: <PAXP251MB001050EFD88752318EBA75F5C8B42@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 22:09:12 +0000
Message-Id: <20260905220912.AC1711F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uncancelled background workers and timers in the wacom_parse_and_r=
egister() error path lead to UAF when called outside of probe().
--

commit 611f293eb48407c71bbdfd98b12f13ec53358ab0
Author: Aamir Ahmed <elb12345@hotmail.co.uk>

HID: wacom: Cancel init_work when probe fails after scheduling it

This commit cancels init_work on the shared error path in
wacom_parse_and_register() to prevent a use-after-free when probe fails
and devres cleans up driver resources.

Closes: https://lore.kernel.org/linux-input/20260905102908.ADE1F1F00A3D@smt=
p.kernel.org/

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f75..ba8adefd93266 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
[ ... ]
> @@ -2501,6 +2501,7 @@ static int wacom_parse_and_register(struct wacom *w=
acom, bool wireless)
> =20
>  fail_hw_stop:
>  	hid_hw_stop(hdev);
> +	cancel_delayed_work_sync(&wacom->init_work);
>  fail:
>  	wacom_release_resources(wacom);
>  	return error;

[Severity: High]
This is a pre-existing issue, but can this error path still result in a
use-after-free if it is reached outside of probe()?

The commit message notes that reports cannot reach the driver during probe
because driver_input_lock is held, preventing other work items from being
scheduled.

However, looking at wacom_wireless_work() and wacom_mode_change_work(),
they also call wacom_parse_and_register(). In these workqueue contexts,
driver_input_lock is not held.

Once hid_hw_start() is called earlier in this function, could incoming
reports immediately schedule asynchronous tasks like remote_work,
battery_work, and aes_battery_work?

If a subsequent step like hid_hw_open() fails, execution jumps to
fail_hw_stop. While init_work is cancelled here, the other background
tasks are not.

Will wacom_release_resources() then free the devres group containing
wacom->remote and other structures, leaving those uncancelled tasks to
execute and access freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/PAXP251MB001050EFD8=
8752318EBA75F5C8B42@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM?part=3D1
