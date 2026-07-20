Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633540926E
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565367; cv=none; b=FuLQ43HIfkw83F0wkbe8la7RAAeiZKLA9PW79KsDI8SAUFhZd95Tnsh1JqQjt++EyUJnYsUwD87+peDYrhwylDT8re+NSnYalM2lMsHylhTQGtPR6CVi1CeqjQHXj/NdZlRmDNoiS97f/79Cewx3ndQXHS8oEqHCgfUvKz+5Xis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565367; c=relaxed/simple;
	bh=MMPPB4zQA7fezNdwXWSU132cW41pij7CeUjFaeEZKfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rcro9bkZD3PqQawoY54yrgBvCsVJ96vSvIvgRGt9iCP2mNd6JCAXNSARkoTQe3Rk1hJVIScGPsUUzqZvgE/YoWkb1dqy3Xo0+83+sA7m+CcvObuP0IzVVGdU+6N+z+5kbS5nvAlknXdhOMPoEQb0ckzDhhzP1rX5PP1gYsPsHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDngkeAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDngkeAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7E31F000E9;
	Mon, 20 Jul 2026 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784565364;
	bh=LlloDetgarS1TDFV41qQBEhDXooe3BCTwDL9FZf5cn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oDngkeAnCw3kyds3+iE0W0h3mBiAHW1TOYMwb4cjx0U63ygXGcxQXtwnUMjuPhgIv
	 dilengPzhVLuTqizhrA2IkA6P/2k7hkwGOdJuGw0TgrWbCNcdRomGEPDKih68R0FQE
	 A8KhxA+5jlQZjEC6IkB8rNw4jB8huBm/7jp17BR8rePhf1CsKz26r2nVwS51eSwGzp
	 keKXeuSPNb84n3wvxQYtP2dwHw/qTt1NINLrMHSrDflFbo+erGcd/MQBJqj83U4xWp
	 7zMGUUnv+FDsrhgq5nMT8Z21r3uu8HBiI6v6D8CSabtpRN2/RTbkdPuJfPW/D8i8ck
	 ZgsEdqjO6tGwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] Input: applespi - track asynchronous SPI
 transfers in flight
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720162219.32324-3-fourdollars@debian.org>
References: <20260720162219.32324-1-fourdollars@debian.org>
 <20260720162219.32324-3-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:36:03 +0000
Message-Id: <20260720163604.1F7E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Teardown threads wake up prematurely and free `applespi` while `ap=
plespi_async_complete` is still running, causing a Use-After-Free.
- [High] Consecutive SPI transfers fail with -EBUSY due to occupied trackin=
g slots, dropping commands and stalling the driver.
- [High] The driver becomes completely broken after a suspend/resume cycle =
because `cancel_spi` is never reset.

Pre-existing issues:
- [High] Missing cancellation of `applespi->work` in `applespi_remove()` le=
ads to a Use-After-Free.
--

--- Patch [2]: [PATCH v3 2/5] Input: applespi - track asynchronous SPI tran=
sfers in flight ---
commit 461be9b81e79a5a61b76018d2f876c28cc39167f
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - track asynchronous SPI transfers in flight

The driver queues read and write packets asynchronously. When shutting
down, removing, or suspending, the driver must guarantee that no
asynchronous transfers remain in flight to prevent memory corruption or
use-after-free conditions. This commit introduces a tracking mechanism
for these async transfers using a spi_complete slot array.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index c501bf7e517e4..c9bbceaf06718 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c

[ ... ]

> @@ -607,13 +613,73 @@ static void applespi_setup_write_txfrs(struct apple=
spi_data *applespi)
>  	spi_message_add_tail(st_t, msg);
>  }
> =20
> +static bool applespi_async_outstanding(struct applespi_data *applespi)
> +{
> +	return applespi->spi_complete[0].complete ||
> +	       applespi->spi_complete[1].complete;
> +}
> +
> +static void applespi_async_complete(void *context)
> +{
> +	struct applespi_complete_info *info =3D context;
> +	struct applespi_data *applespi =3D info->applespi;
> +	void (*complete)(void *context);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +	complete =3D info->complete;
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +
> +	if (complete)
> +		complete(applespi);

[Severity: High]
If the inner complete callback queues a new write command, will
applespi_async() see the first slot as still occupied because info->complete
has not been cleared yet?

If a read transfer happens to be active in the other slot, could this cause
applespi_async() to return -EBUSY and drop the new command, permanently
stalling driver initialization?

> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +	info->complete =3D NULL;
> +
> +	if (applespi->cancel_spi && !applespi_async_outstanding(applespi))
> +		wake_up_all(&applespi->wait_queue);
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +}

[Severity: High]
Can this sequence cause a use-after-free regression?

If applespi_drain_writes() is waiting for write_active to become false:

CPU1 running applespi_async_complete():
    complete(applespi);

The inner callback sets write_active =3D false and wakes wait_queue.

CPU2 running applespi_drain_writes():
    wakes up, finishes applespi_remove(), and frees the applespi structure

Could CPU1 then try to acquire the spinlock and clear info->complete on the
freed applespi structure?

[ ... ]

> @@ -1799,6 +1865,7 @@ static void applespi_drain_writes(struct applespi_d=
ata *applespi)
>  	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> =20
>  	applespi->drain =3D true;
> +	applespi->cancel_spi =3D true;
>  	ret =3D wait_event_lock_irq_timeout(applespi->wait_queue,
>  					  !applespi->write_active,
>  					  applespi->cmd_msg_lock,

[Severity: High]
If applespi_drain_writes() sets cancel_spi to true during applespi_suspend(=
),
is it ever reset to false in applespi_resume()?

Could this cause applespi_async() to permanently reject new transfers with
-ESHUTDOWN after the system resumes?

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the driver
teardown path, does applespi_remove() need to call
cancel_work_sync(&applespi->work)?

If applespi->work is queued to register the touchpad and the module is
unbound, could devres free the applespi structure before applespi_worker()
executes, resulting in a use-after-free regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720162219.3232=
4-1-fourdollars@debian.org?part=3D2
