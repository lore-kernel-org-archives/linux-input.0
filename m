Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7040D594
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828584; cv=none; b=uHvDdV1jF3qNCLa3H9O6IK80jbkpYTWvrfY/HTKTRX1/aq6bzrSLcnUczA/BDKhe2rx9vp9uIMleuNMWDiwzWWGufuk6oSzM+Knut0ldddenfyyVa18huT7D+uloIDSvVovSp6GnAtjs6BSDmSj6dFnM/YzqBHxrOtxSaCgfahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828584; c=relaxed/simple;
	bh=PKe5UqVxmMf+c6u8kf+xeG5k0z5sAEtB19N7pS/P9yU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fEdmoM/4UqLTWQ0FAe7LGr6elW2RX0ffPnGpDtSDBMTAoj2rfvRYz2Gw0c68q3WDgli/bb5gP7zeIjplGKfeDW+TXXRfCX7m0JxTmNE62h4yPAezVfHlMi1KYF2uS/i3S9cAT9ByQMNs7sgSdqiNmsO5LRfRCvKrDoxYqi6seiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd9gVaQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd9gVaQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456721F000E9;
	Fri, 19 Jun 2026 00:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828583;
	bh=cmA1YimX5kc6E47grQl1hnjEpetc2wkXkmjFlh/BLPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qd9gVaQTUyACFgAD+Ecp8DGE+KcOgWyZgwLNVfec4a8lWTEM4MR4H4y5aSEuiyKyq
	 I9VD8HwNhndadgx0oLxVoUc0YgcjFwOOJAQ2IBGX+xCjPZuFy3/s8Jm80Pi5O/+tgY
	 sPl4BhrxSH0KMr4kHVMBEGeOGHhYwqtB+5cFIBX9//HDiDtN8Nce40dyrBjKt9FNjU
	 uXTbG25Lf6/IOnNDdc3XQtmZpBw1CdEqLhMrb1TWBaszZVt3XSuTQyo4cTh6atx38I
	 iBZ8SF2ErPnLXwk9FZJwe9r/Ehpfccmu8LpeFCbF+5vIPTHgacGEHtlbdgbd0TR/x0
	 YQaNNIq3PkaCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] HID: asus: refactor the two workqueues and init
 sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260619001103.1189200-2-denis.benato@linux.dev>
References: <20260619001103.1189200-1-denis.benato@linux.dev>
 <20260619001103.1189200-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:23:02 +0000
Message-Id: <20260619002303.456721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] ABBA deadlock between driver removal/probe failure and the deferre=
d WMI_FAN action in the workqueue due to inverted lock acquisition order of=
 `hdev->driver_input_lock`.
- [High] Unbounded dynamic allocation of workqueue actions allows an untrus=
ted USB device or unprivileged user to exhaust kernel atomic memory pools.
- [Medium] Passing the raw packet size as `bufsize` to `hid_report_raw_even=
t()` bypasses the HID core's automatic padding, leading to valid short pack=
ets being incorrectly rejected.
--

commit 656f5a6cc923dccccd418cd0aefa2239f221bf47
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: refactor the two workqueues and init sequence
   =20
Multiple issues have been found within the hid-asus driver. This patch
joins the two workqueues into one and reuses the stopping mechanism
of the brightness workqueue. It also moves the asus_wmi_send_event()
sleeping call away from atomic context.

Link: https://lore.kernel.org/all/20260613154732.60A4B1F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d34d74df3dc0b..40191eb9e2e86 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -331,25 +380,71 @@ static int asus_e1239t_event(struct asus_drvdata *d=
rvdat, u8 *data, int size)
>  }

[ ... ]

> +static int asus_kbd_wmi_fan_send(struct asus_drvdata *drvdata, u8 *repor=
t_data,
> +				 size_t report_size)
> +{
> +	struct asus_work_action *action;
> +	unsigned long flags;
> +
> +	if (report_size > FEATURE_KBD_REPORT_SIZE) {
> +		hid_err(drvdata->hdev, "Invalid report size for fan event: %zu\n", rep=
ort_size);
> +		return -EINVAL;
>  	}
> =20
> +	action =3D kzalloc(sizeof(struct asus_work_action), GFP_NOWAIT);

[Severity: High]
Does this code allow an unbounded number of allocations?

If a device sends a flood of fan events, or if a local user rapidly changes
the brightness, it seems this could queue an unlimited number of actions
using GFP_NOWAIT or GFP_ATOMIC.

Could this exhaust kernel atomic memory pools and lead to a local denial of
service?

> +	if (!action)
> +		return -ENOMEM;
> +
> +	action->type =3D WMI_FAN;
> +	action->data.fan_hid_data.report_size =3D report_size;
> +	memcpy(action->data.fan_hid_data.report_data, report_data, report_size);
> +	INIT_LIST_HEAD(&action->node);
> +
> +	spin_lock_irqsave(&drvdata->worker->lock, flags);
> +	asus_worker_schedule(drvdata->worker, action);
> +	spin_unlock_irqrestore(&drvdata->worker->lock, flags);
> =20
>  	return 0;
>  }

[ ... ]

> @@ -569,59 +668,157 @@ static int asus_kbd_disable_oobe(struct hid_device=
 *hdev)

[ ... ]

> +static void asus_kbd_wmi_fan(struct hid_device *hdev, struct hid_raw_eve=
nt_data *data)
>  {

[ ... ]

> +	/*
> +	 * Fallback: pass the raw event to the HID core; to avoid
> +	 * racing against the hid_report_raw_event() that generated
> +	 * this event use the same locking mechanism and wait for
> +	 * that function to terminate and signal the deferred execution
> +	 * before raising the stored event.
> +	 */
> +	down(&hdev->driver_input_lock);

[Severity: High]
Can this code cause an ABBA deadlock during device probe failure or removal?

The HID core holds hdev->driver_input_lock during hid_device_probe() and
hid_device_remove().

If asus_remove() or the error path in asus_probe() calls asus_worker_stop()
and blocks on cancel_work_sync(&worker->work) while driver_input_lock is
held:

HID core thread:
hid_device_remove() (acquires driver_input_lock)
  -> asus_remove()
    -> asus_worker_stop()
      -> cancel_work_sync() (waits for worker)

Worker thread:
asus_work()
  -> asus_kbd_wmi_fan()
    -> down(&hdev->driver_input_lock) (waits for HID core thread)

Would this lead to an unrecoverable deadlock?

> +	hid_report_raw_event(hdev, HID_INPUT_REPORT,
> +			     data->report_data, data->report_size,
> +			     data->report_size, 1);

[Severity: Medium]
Does passing data->report_size as the bufsize argument drop valid short
packets?

The HID core natively handles short packets by padding the buffer up to the
expected report descriptor size (rsize), provided the allocated buffer size
(bufsize) is large enough.

If bufsize is artificially restricted to data->report_size, the safety check
"if (bsize < rsize)" inside hid_report_raw_event() might falsely trigger and
reject the valid short event with -EINVAL.

Should FEATURE_KBD_REPORT_SIZE be used as the bufsize parameter instead?

> +	up(&hdev->driver_input_lock);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619001103.1189=
200-1-denis.benato@linux.dev?part=3D1
