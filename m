Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145985;
	b=SrYu8iHCY5Hnemom9gJl5SXFAeysVVyJZ0+u/zy9DuR++5aQ0TVgibWCuC/l7MdR4tgm
	 s8D1KChSYq/Kuj7ZVv5WNB4RdomDObX4CkCUFtpwa4WbqoPyJGVgV6FuIGyFicUMBKo6c
	 8/5rlDWYh+2M2V2zae1A2K6ql2AK9cWdmRtq8ONK4pZj5jIQeNOMQIBaIb3X/BnmxUycL
	 7pfbKVpY6mJNDeBhL1PxDnqQYRSBF51r6IzqgoJpjD6hZzwP9AYfMtoe1ZCVtjGVcNqP6
	 WwOVd2vj5bjVFprlTdGpqdz8XtO/hhZqX1ardoS1Hc1xcHR2shZXEV2HOg5JoOw+9yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145985;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EJUykuVM7vjRkU7hAALPxfVfB3Nciahn4z48VWhOBT4=;
	b=dxW4u0r65+Dkl/DLba1MPA9e2Sg3ygjH4+1G7Hr31tsee/QyepY5KT4ZSqcsqwR3BQme
	 XcZ7NKM84IYgQr2WIU6HRKCBkwvEAZ1WW6IHGrG9h08251do4m4Q3ZRtZvTbt0N/3UgMV
	 9n+M7naHrEPJbZu67nwC9OlZn9MQZh0mrAKYz+PyvSc0AV6fH3WqUulAktK04TXNTkFtS
	 dLacFyx7gN6wyIHluGpyYukzXmRqn9Ti6zmQM5IZxTBkxKvx96SByMtSnrIhHUedZKOkr
	 wKwdi78/0nq98QabE61gr6lqoW/t3e3+/iMb4+OLE5SOrdJlvZpqYQGTvY+8PjkTa/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rae9zO/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CE606A320
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rae9zO/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A741F0089F;
	Sun,  8 Nov 2026 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794145985;
	bh=EJUykuVM7vjRkU7hAALPxfVfB3Nciahn4z48VWhOBT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rae9zO/30zb621sokEO7HjBJt5y5Qqn3Htw4r4RPSQcDK8xJGCfDofgdUQblhNs/2
	 IyMbB3S4+Jfi8zvNZsIfrfqRjn/hAbjsJkmmAUQgV96nm1eJMr1wGLgWQKzYbldcek
	 Sla8vG89O1sdCR43vMpVU49Fsis9n05SlzCYDcJV76eWcVP+iVhuPWPHGK9WitetJH
	 jKQT1ja9mCJBrtoGG1DoWq4zwjElBAt3c8+Ng02CJPCy1APXduocGJz12ML+JALZDP
	 86G1/Pz/FNEZiafF7DMGN81I8F3hPbFurZRhFK48fD9YQpBoIervkaeTWO8xJpClZK
	 yee00QTvp1R8w==
Message-ID: <sashiko-outbox-203788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: microsoft: cancel ff_worker on remove to avoid
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: hyunjungg <hj351016@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108133821.535139-1-hj351016@gmail.com>
References: <20261108133821.535139-1-hj351016@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:53:04 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] HID: microsoft: UAF in ms_remove() as hid_hw_stop() reschedules
  ff_worker
- [Medium] HID: microsoft: WARN_ON in ms_remove() on uninitialized
  ff_worker
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] HID: microsoft: use-after-free in ms_probe() [1]
--

commit 7c761c76a759b981259737d50e309dc8e6d24ed9
Author: Hyunjung Ko <hj351016@gmail.com>

HID: microsoft: cancel ff_worker on remove to avoid use-after-free

This commit cancels ms->ff_worker in ms_remove() before stopping the HID
hardware to prevent the worker from running after device removal.

> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index a7d3493a6141e..462fdaf9c65cb 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -384,6 +384,9 @@ static int ms_probe(struct hid_device *hdev, const st=
ruct hid_device_id *id)
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can a failed
hid_hw_start() in ms_probe() leave ms->ff_worker queued and cause a
use-after-free [1]?

If hid_hw_start() fails after ms_input_configured() has registered force
feedback, unwinding the input device runs input_ff_flush() ->
ms_play_effect() and schedules ms->ff_worker.  ms_probe() then returns the
error without cancelling ms->ff_worker, so ms_ff_worker() can run after
devres frees ms and ms->output_report_dmabuf.

>  static void ms_remove(struct hid_device *hdev)
>  {
> +	struct ms_data *ms =3D hid_get_drvdata(hdev);
> +
> +	cancel_work_sync(&ms->ff_worker);

[Severity: Medium]
Does calling cancel_work_sync(&ms->ff_worker) unconditionally here trigger
a warning in __flush_work() when removing a device that never initialized
ms->ff_worker?

ms->ff_worker is only initialized in ms_input_configured() for devices with
force-feedback support:

drivers/hid/hid-microsoft.c:ms_input_configured() {
	if (!(ms->quirks & MS_QUIRK_FF))
		return 0;

	if (!list_is_first(&hidinput->list, &hdev->inputs))
		return 0;

	ms->hdev =3D hdev;
	INIT_WORK(&ms->ff_worker, ms_ff_worker);
...
}

For the Microsoft devices in ms_devices[] without that quirk,
ms->ff_worker.func remains zero, and cancel_work_sync() ->
__cancel_work_sync() unconditionally calls __flush_work(), which warns on a
uninitialized work item:

kernel/workqueue.c:__flush_work() {
	if (WARN_ON(!work->func))
		return false;
...
}

>  	hid_hw_stop(hdev);
>  }

[Severity: High]
Can hid_hw_stop(hdev) reschedule ms->ff_worker after cancel_work_sync() has
already returned, still leaving a use-after-free once ms_remove() finishes?

cancel_work_sync() leaves the work item enabled, and the input device is
still registered until hid_hw_stop() disconnects it:

ms_remove()
  cancel_work_sync(&ms->ff_worker)
  hid_hw_stop(hdev)
    hid_disconnect(hdev)
      ...
        input_unregister_device(...)
          evdev_cleanup()
            input_flush_device()
              input_ff_flush()
                erase_effect()
                  ml_ff_playback()
                    ms_play_effect()
                      schedule_work(&ms->ff_worker)
  /* devres frees ms and ms->output_report_dmabuf */
  ms_ff_worker()                                    <-- use-after-free

When an open evdev handle has an active effect during disconnect (or if the
ff-memless timer fires before input_unregister_device() stops it),
ms_play_effect() queues ms->ff_worker again after cancel_work_sync(), and
ms_ff_worker() can run after devres frees ms.  Using disable_work_sync() or
cancelling the work after input unregistration would prevent it from being
requeued.

[1] https://sashiko.dev/#/bug/linux-0e0c2d3d-cc31-46f2-bb9c-fdbd250adb84

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108133821.5351=
39-1-hj351016@gmail.com?part=3D1
