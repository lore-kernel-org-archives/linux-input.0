Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15035AC3B
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974293; cv=none; b=YT/m2vxm9HjzjGv6c/aQ0E/bIPgEyjdXMdv+L/gN1azQ+W5F1D6dpSPowf+H3wPgqJ+uSt65uBRSbhvRnGyInMztC8zik2WhIjmzu1qPEByCCyKvNFFYJzpK0uZIuwjguxvUiybn3b+YGfKJdUfHndVDBnZN7R/eZ9s3J62fdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974293; c=relaxed/simple;
	bh=5R4kvOIWabsyjYOK4L/u13wdZYAT+ONYhDwqiprdn0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jOtoPq1g8U/Y6Mv8JvHuG4PJaIwWWJOZsjypHSKtTCAtlR9k4DwLZSuQSrjAH6B+fB1tT7nCTSgURwvyvh5MoJmLAkW5tpaLoY2Gy+O+THzPk5mAukpFodo1LB15skMYmeXyquKJgmYLAGCMD/EROH5ni05QxznU5c/1CkfDzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghmGtsBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghmGtsBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8C01F000E9;
	Mon, 13 Jul 2026 20:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783974291;
	bh=TVLMSJjO73UUyuYYHBekxLAtNJjVsjmBw2UwikboJKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ghmGtsBwSYtQdAn+bCNokq/qpuc+xV/cvtehpLi+veCyCch4llxdienqu9ElWGdEf
	 4+YEGM7tTVB3lIAVNTH0qYtT9ynQmC/Gd8SWnRMsi5LykNRept3hmFSF5QPo6oeSvh
	 cb607xuwXqdIcz5DFSIpgOB4t7bpj1ZSWkdQoDnhpldGEO4ewSO27JZqobj9xdcUe9
	 yPaevb3RubayQxnBwJxIHcC8UvJWWr+cT5z8l5jStcoPbDVC0HHb6xDwh3c3KPoxj3
	 TLLwx/EwPdvN9QpBl6kZcjGyqiKuhgtgjEArCSsnkap1YZutlfy/+2w6Tdy873WIrZ
	 y1ixDhPfC19kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RXJpayBIw6VrYW5zc29u?= <erikhakan@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260713201201.391538-2-erikhakan@gmail.com>
References: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
 <20260713201201.391538-1-erikhakan@gmail.com>
 <20260713201201.391538-2-erikhakan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 20:24:51 +0000
Message-Id: <20260713202451.9F8C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] logi_dj_remove() cancels djrcv_dev->work before disabling hardware=
 interrupts, allowing new work to be scheduled during teardown and causing =
a Use-After-Free.
--

--- Patch [1]: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for =
Logitech HID++ devices ---
commit 971b266887902a1a6dc0bffd56ec903cd5386ed8
Author: Erik H=C3=A5kansson <erikhakan@gmail.com>
HID: logitech: add Bolt receiver support for Logitech HID++ devices

Add Logitech Bolt receiver support to the Logitech HID receiver and HID++
drivers. This allows Bolt-connected HID++ devices to expose battery
information through the kernel power_supply path.

Link: https://lore.kernel.org/linux-input/345f7347-30a8-4568-a7a6-c70f54a52=
a8d@mcld.eu/

> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 381e4dc5aba7a..112ea6a7b2a65 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c

[ ... ]

> @@ -1745,6 +1750,24 @@ static int logi_dj_hidpp_event(struct hid_device *=
hdev,
> =20
>  	dj_dev =3D djrcv_dev->paired_dj_devices[device_index];
> =20
> +	/*
> +	 * Bolt receivers send explicit unpair notifications as HID++ events;
> +	 * queue device removal when we receive one.
> +	 */
> +	if (djrcv_dev->type =3D=3D recvr_type_bolt &&
> +	    hidpp_report->report_id =3D=3D REPORT_ID_HIDPP_SHORT &&
> +	    hidpp_report->sub_id =3D=3D REPORT_TYPE_NOTIF_DEVICE_UNPAIRED) {
> +		struct dj_workitem workitem =3D {
> +			.device_index =3D device_index,
> +			.type =3D WORKITEM_TYPE_UNPAIRED,
> +		};
> +
> +		kfifo_in(&djrcv_dev->notif_fifo, &workitem, sizeof(workitem));
> +		schedule_work(&djrcv_dev->work);

[Severity: High]
This is a pre-existing issue, but can this sequence cause a use-after-free
during device removal?

Looking at logi_dj_remove() in drivers/hid/hid-logitech-dj.c, it cancels
the work queue before stopping the hardware:

drivers/hid/hid-logitech-dj.c:logi_dj_remove() {
	...
	cancel_work_sync(&djrcv_dev->work);

	hid_hw_close(hdev);
	hid_hw_stop(hdev);
	...
}

If a user unplugs the USB receiver, and a Bolt unpair notification arrives
right after cancel_work_sync() finishes but before hid_hw_stop() disables
hardware events, will this schedule_work() call queue a new work item on a
djrcv_dev structure that is about to be freed?

> +		spin_unlock_irqrestore(&djrcv_dev->lock, flags);
> +		return false;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713201201.3915=
38-2-erikhakan@gmail.com?part=3D1
