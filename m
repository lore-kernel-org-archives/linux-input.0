Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546E332913
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147000; cv=none; b=GNNUksGPReFfiJO374ZYjx8levdqIcL5LEL3NuPuInq1ejBOSdHJfoEc/lZtEb8WcXciOk4FFfWT04uJszNANqUMAGeriHSMyEtaA3rK9Qcu5dGQ36h4qW8PZR4zwTgKeIejLA4Yx9xxMAyHIiwT/36fKpaD4uxU1VeQsbuGCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147000; c=relaxed/simple;
	bh=54TQNJEMX0ptLOTRvWRstOIkCrxr5T9yETrnjTAcElU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5MPqKT+SaAIHgRflIaB3HcSyBWVRNhFZGDcNh+YnyZea+VzfwMjUG7NrCqooCJyf7Qf4r1JzpR0/uP9ETL6vsleuvlxnljvWXyopNLUiL4DSXuChXtzDZm8y/8VFJNjKlL+83YwAAwSsMXwwvJcTvrDgOMx9vq2q9m+fSYIArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1OCjWwt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1OCjWwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F8C2BCC7;
	Mon, 18 May 2026 23:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147000;
	bh=54TQNJEMX0ptLOTRvWRstOIkCrxr5T9yETrnjTAcElU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=V1OCjWwtERRtyUoZwGCz4J9rSo1Mz/2sNmplyEyt7yt1yqjOh1m9phmKTBLy3R7q6
	 gYu88HGDINXetMHt8uYXZo5Z2LdJjtnkUUefxkLEiMsvmqnwP8SKbDgql1C4CLyPjk
	 DLhG4D7LA67fj+Shz7NydeKTSwyPBLSljgBdR3mAI/1VW2a40ZNIWt1uziHBB40y7x
	 PJh265v4Raylebpr6vQlr7VAn0N1QqQIubalRJqjld1w5uekxC/xbCR4FwCQG42L/x
	 ip40SudjypkyLWEGlgJhF/+TAmgvgiYizz1WHGUwb6Q8vZ+HHHWwRM7ZM2gp2xQ3L3
	 DvacIReKhk9rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260518222935.1802071-3-derekjohn.clark@gmail.com>
References: <20260518222935.1802071-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 23:29:59 +0000
Message-Id: <20260518232959.D69F8C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Data race and state desynchronization in `profile_pending` allows =
delayed ACKs to corrupt profile data.
- [High] Race window in `claw_hw_output_report()` causes spurious command t=
imeouts.
- [High] Use-After-Free during module teardown due to incorrect delayed wor=
k cancellation order.
--

commit d45c51fc226fdd946c2d70a93c254be199300dc7
Author: Derek J. Clark <derekjohn.clark@gmail.com>
Subject: HID: hid-msi: Add M-key mapping attributes

This commit introduces M-key mapping attributes for the MSI Claw device.
It adds the ability to read and write profile mappings for two back buttons
(M1 and M2) via sysfs, using custom HID commands to communicate with the
hardware.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index c79eb0bfeb776..e58d35dba5b40 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

>  struct claw_drvdata {
>  	/* MCU General Variables */
> +	enum claw_profile_ack_pending profile_pending;
>  	struct completion send_cmd_complete;
>  	struct delayed_work cfg_resume;
>  	struct delayed_work cfg_setup;

This problem wasn't introduced by this patch, but does the cancellation ord=
er
of these delayed works cause a use-after-free regression during module
teardown?

In cfg_resume_fn(), cfg_setup is unconditionally queued via
schedule_delayed_work(). During module removal, if
cancel_delayed_work_sync(&drvdata->cfg_setup) is executed before
cancel_delayed_work_sync(&drvdata->cfg_resume), and cfg_resume_fn is
actively executing:

The first cancellation would return immediately because cfg_setup is not
yet pending. cfg_resume_fn would then queue cfg_setup. The second
cancellation would wait for cfg_resume_fn to finish.

Once the removal completes and drvdata is freed by devres, could the
newly queued cfg_setup fire 500ms later and dereference the freed
drvdata pointer?

[ ... ]

> +static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_=
command_report *cmd_rep)
> +{
> +	u8 *codes;
> +	int i;
> +
> +	switch (drvdata->profile_pending) {
> +	case CLAW_M1_PENDING:
> +	case CLAW_M2_PENDING:
> +		codes =3D (drvdata->profile_pending =3D=3D CLAW_M1_PENDING) ?
> +			drvdata->m1_codes : drvdata->m2_codes;
> +		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
> +			codes[i] =3D (cmd_rep->data[6 + i]);
> +		break;
> +	default:
> +		dev_dbg(&drvdata->hdev->dev,
> +			"Got profile event without changes pending from command: %x\n",
> +			cmd_rep->cmd);
> +		return -EINVAL;
> +	}
> +	drvdata->profile_pending =3D CLAW_NO_PENDING;
> +
> +	return 0;
> +}

Is there a data race and potential state desynchronization with
profile_pending here?

drvdata->profile_pending is written under profile_mutex in process context
in claw_buttons_show(), but it is read and cleared locklessly here in the
atomic HID event handler.

If a request (like an M1 read) times out, profile_pending is cleared by the
sysfs thread. If a subsequent request then sets profile_pending to
CLAW_M2_PENDING, could a concurrently arriving delayed ACK for the original
M1 read cause this lockless handler to mistakenly parse the M1 payload into
drvdata->m2_codes?

This would reset profile_pending and prematurely wake the waiting thread,
corrupting the profile data.

[ ... ]

> +static int claw_buttons_store(struct device *dev, const char *buf, u8 mk=
ey_idx)
> +{

[ ... ]

> +set_buttons:
> +	scoped_guard(mutex, &drvdata->rom_mutex) {
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DA=
TA,
> +					    data, len, 25);

This problem wasn't introduced by this patch, but is there a race window in
claw_hw_output_report() that could cause spurious command timeouts?

Looking at claw_hw_output_report(), drvdata->waiting_for_ack is set to
true inside a cmd_lock critical section. Immediately after releasing the
spinlock, it calls reinit_completion(&drvdata->send_cmd_complete).

If the hardware responds exceptionally quickly, or if a delayed ACK from a
previous timed-out command arrives in the small window between the spinlock
release and the reinit_completion() call:

Could the interrupt handler clear waiting_for_ack and call complete(),
only for the main thread to immediately erase the completion event with
reinit_completion()?

This would cause wait_for_completion_interruptible_timeout() to block and
incorrectly return -ETIMEDOUT to userspace.

Should reinit_completion() be called before setting waiting_for_ack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518222935.1802=
071-1-derekjohn.clark@gmail.com?part=3D2
