Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CCE36B908
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364442; cv=none; b=Zj1p6DB9O/27hscFcnYv6AgjR1T12eyvm9WCvBXlI/qwmwh9T4jRKCW+PllGa0DXS+xNs65hemtW7HckveEUNo7tW5JG27+02lsLwxBeeSaFqtdIwZPesBmHGS8Im2E3btGGKe3/46QNRPrr+5HXJt0kviAlI/Ip3RT6VaXOGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364442; c=relaxed/simple;
	bh=xDqNIRi1Li7Xuv++DcXmrBhHb/u+cnpRRUoGBqc4M2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QPZ8oGv82yBZ3NMKVkiWky9iR7R1oXR+HNL49xunpBI5XxlRDtXdN0XYE4U8PQhbqHiGe47ebzy3brP76MXp+D5EGPdk0+1iORqg+7HB6qSFK4HbSfV34MlqTiKyqCKnrNcPYvG/aD7R8VXjyAJotGWMavxRO7GwBio1feKKdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqcaJ/Ft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqcaJ/Ft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2DA1F00A3A;
	Wed,  2 Sep 2026 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364440;
	bh=yXcEEhaijDMtiYvoiaJa6TjFFyel/6YvqFC9wRf18os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QqcaJ/FtSffIZgEPlZLxuuAYq0FgDsMMz/H9gYUm6OL33A3b8mnkbBtsglZ81UGCp
	 T8qcPPkAl6e64PExOI3n06wHrWdzN5QQYjETFCGTMsQSeVWr8G0G8K1a4Dzh3f48et
	 rQtErgsXeh8B6KIKv2irCACOb5pHt5gxcT/uuqI8azsxfPpkBDCPp3ZZFCqL0XKQIk
	 Wh7vqNfaZGuQmC5eXABTEJFW3Cn8QkxVUR6i+M/63Gzbw7s6S/vvu9+b5pOqOxjsSI
	 hkqngUOa17j2kyViQkj3nr+KewImKPxwel6O7E5HBUv81//W5UKaE8AcKYN4ulWHPf
	 6eweQmXlQtEUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: hp_sdc: shut down kicker timer on module exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902154004.3595416-1-runyu.xiao@seu.edu.cn>
References: <20260902154004.3595416-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:53:59 +0000
Message-Id: <20260902155400.0D2DA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `free_irq()` while holding a rwlock with interrupts disabl=
ed causes a sleep-in-atomic bug.
- [High] The `hil_mlc.c` module uses `timer_delete_sync()` during teardown =
for a self-rearming timer, which was the exact bug fixed in `hp_sdc.c`.
- [High] Module initialization failures in `hp_sdc_register()` return error=
 codes without performing proper cleanup, leaving the `hp_sdc_driver` regis=
tered.
- [High] Lockless access to transaction data in the interrupt handler races=
 with timeout processing, leading to a use-after-free and stack corruption.
- [High] `hp_sdc_spin_ibf()` uses an unbounded hardware polling loop with l=
ocal interrupts disabled, leading to a hard lockup on hardware failure.
- [High] The initialization sequence waits unconditionally for hardware int=
errupt completion using a semaphore without a timeout.
- [Medium] Data race on `hp_sdc.im` and `hp_sdc.set_im` leads to lost inter=
rupt mask updates.
--

commit d9f2250272742119b95aa94b3cafcae0b1dcbf92
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

Input: hp_sdc: shut down kicker timer on module exit

The commit changes timer_delete_sync() to timer_shutdown_sync() in hp_sdc_e=
xit()
to prevent the self-rearming kicker timer from firing after the module has =
exited,
ensuring safe teardown.

> diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
> index 1461ef319f92a..ecf5347b63ab7 100644
> --- a/drivers/input/serio/hp_sdc.c
> +++ b/drivers/input/serio/hp_sdc.c
> @@ -981,7 +981,7 @@ static void hp_sdc_exit(void)
>  	free_irq(hp_sdc.irq, &hp_sdc);
>  	write_unlock_irq(&hp_sdc.lock);

[Severity: High]
This is a pre-existing issue, but can free_irq() sleep while waiting for
executing IRQ handlers to finish? Since it is called while hp_sdc.lock is h=
eld
in write mode with local interrupts disabled, could this result in a
sleep-in-atomic bug when the module is unloaded?

> -	timer_delete_sync(&hp_sdc.kicker);
> +	timer_shutdown_sync(&hp_sdc.kicker);
> =20
>  	tasklet_kill(&hp_sdc.task);
> =20


[Severity: High]
This isn't a bug introduced by this patch, but could the hil_mlc driver be
suffering from the exact same timer teardown issue?

drivers/input/serio/hil_mlc.c:hil_mlc_exit() {
    ...
    timer_delete_sync(&hil_mlcs_kicker);
    ...
}

Because hil_mlcs_timer() rearms itself with mod_timer(), timer_delete_sync()
cannot prevent the timer from being rescheduled. If the callback runs
concurrently during module unload, does the timer remain active after the
driver memory is freed, causing a use-after-free?


[Severity: High]
This is a pre-existing issue, but I am wondering if the module initializati=
on
failures in hp_sdc_register() return error codes without performing proper
cleanup?

drivers/input/serio/hp_sdc.c:hp_sdc_register() {
    ...
    if (hp_sdc.dev =3D=3D NULL) {
        printk(KERN_WARNING PREFIX "No SDC found.\n");
        return hp_sdc.dev_err;
    }
    ...
}

If hp_sdc_register() returns early here, or when reading the extended config
byte fails, it bypasses calling unregister_parisc_driver(). Might this leave
the hp_sdc_driver registered after the module memory is freed, potentially
leading to a use-after-free during a subsequent device probe?


[Severity: High]
This is a pre-existing issue, but is there a race condition between lockless
access to transaction data in the interrupt handler and timeout processing?

In hp_sdc_take(), the transaction pointer curr is read under hp_sdc.rtq_loc=
k,
which is then immediately released:

drivers/input/serio/hp_sdc.c:hp_sdc_take() {
    ...
    read_lock(&hp_sdc.rtq_lock);
    if (hp_sdc.rcurr < 0) {
        read_unlock(&hp_sdc.rtq_lock);
        return;
    }
    curr =3D hp_sdc.tq[hp_sdc.rcurr];
    read_unlock(&hp_sdc.rtq_lock);

    curr->seq[curr->idx++] =3D status;
    ...
}

Concurrently, can hp_sdc_tasklet() detect a timeout, wake up the submitter
via up(curr->act.semaphore), and allow the submitter to free the transaction
structure while hp_sdc_take() is still executing? Could this lead to memory
or stack corruption when hp_sdc_take() writes to curr->seq?


[Severity: Medium]
This is a pre-existing issue, but might there be a data race on hp_sdc.im a=
nd
hp_sdc.set_im leading to lost interrupt mask updates?

In configuration functions like hp_sdc_request_hil_irq(), the mask and flag
are updated under hp_sdc.hook_lock:

drivers/input/serio/hp_sdc.c:hp_sdc_request_hil_irq() {
    ...
    hp_sdc.im &=3D ~(HP_SDC_IM_HIL | HP_SDC_IM_RESET);
    hp_sdc.set_im =3D 1;
    write_unlock_irq(&hp_sdc.hook_lock);
    ...
}

However, hp_sdc_put() evaluates and clears these variables under hp_sdc.loc=
k:

drivers/input/serio/hp_sdc.c:hp_sdc_put() {
    ...
    if (hp_sdc.set_im) {
        hp_sdc_status_out8(hp_sdc.im | HP_SDC_CMD_SET_IM);
        hp_sdc.set_im =3D 0;
        goto finish;
    }
    ...
}

If hp_sdc_put() evaluates hp_sdc.set_im as true, and before it is cleared,
another thread updates the mask under hp_sdc.hook_lock, will hp_sdc_put()
blindly clear hp_sdc.set_im to 0? Could this cause the newly requested mask
to never be sent to the hardware?


[Severity: High]
This is a pre-existing issue, but I noticed hp_sdc_spin_ibf() uses an unbou=
nded
hardware polling loop with local interrupts disabled:

drivers/input/serio/hp_sdc.c:hp_sdc_spin_ibf() {
    ...
    while (sdc_readb(hp_sdc.status_io) & HP_SDC_STATUS_IBF)
        { }
    ...
}

If the hardware becomes unresponsive and fails to clear the IBF flag,
does this loop spin indefinitely, causing a CPU hard lockup?


[Severity: High]
This is a pre-existing issue, but does the initialization sequence wait
unconditionally for hardware interrupt completion?

drivers/input/serio/hp_sdc.c:hp_sdc_init() {
    ...
    hp_sdc_enqueue_transaction(&t_sync);
    down(&s_sync); /* Wait for t_sync to complete */
    ...
}

If the hardware state machine hangs or fails to assert an interrupt, the
transaction is never processed and the tasklet never calls up(&s_sync).
Does this cause the kernel thread to hang forever in uninterruptible sleep
during module load?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902154004.3595=
416-1-runyu.xiao@seu.edu.cn?part=3D1
