Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E381135B654
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781580667; cv=none; b=Im9gpWhRJpO915+R+NDWmeKlCdP/KSJPJpDGT7GKhOxlFlzzgzop0Qf4/VhtA0pSFNHgGxjkmLvWXAJPEdJU5p9FCpIIvLhSBEnmmvqnRo9yKIqiH7ZLTppa1aXvSTGwOXG1cg/L45Le+qK3CQcHQcsy8Yd0D2JmfJpVt7vYEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781580667; c=relaxed/simple;
	bh=tXRDwX+knXPV59K4Tzs0XhSMkWEkoAbu+ZnqBrJ86uQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oLPZCmQw/wNMbzXRufxAsYBwzYaQWkxFs3bRCfZx3TYQw3WAod4m9UMEuHkS1ENAk76nZDo4zstmMQ1SVmQcFVxHTxoI0mLwLr/DFTYi203ZoaNjI/tpT02ftxJ8FGTykXeGPmFnjL7dTfcVLd4h7eNbwbx7EiAU/Zo2yKWA4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkyhuafY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkyhuafY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E561F000E9;
	Tue, 16 Jun 2026 03:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781580665;
	bh=2DWTflyIl+8F8IxZB7/hNJD5zYlN4e14sKRo3pgkZKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PkyhuafY3D87Iw3eLk9pq6ZbtRN+ldaawnqcE4S+UQi/QOlhv5wtFW34YAy8Bk/QV
	 vVL+1AIuQfxjiLti42ABZYHtcuHmsKSsQcLqasx+9o4bIGixNoI0D1Si5a8DnMRIA0
	 upWLF67YviGvReNxdfu1laG7aFci0Q1S+ZoJQWC70kFdedbOene3N35YHQwls/LlV3
	 YcQx8JAsGvFj/7pm7OiUAzUIV/vAvTabC9oG2hmef6rSsm3pCC7f2d47JBORsUJaMY
	 F4LUp/UrqY+o6wivpjUoAyDSBj1ibpY5/zgPce4WBiarIZjW5/scgauGh26VGAF0L6
	 iNnzy5K/dkS2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: yealink - stop URB resubmission on completion
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jie Wang" <jie.wang@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616110440.1073059-1-jie.wang@intel.com>
References: <20260616110440.1073059-1-jie.wang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 03:31:04 +0000
Message-Id: <20260616033105.51E561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The URB completion callbacks return early on any non-zero URB stat=
us, preventing resubmission on transient errors (like -EPROTO or -EILSEQ) a=
nd permanently breaking the device's polling loop.

Pre-existing issues:
- [High] Concurrent accesses to `yld->ctl_data` from sysfs and the asynchro=
nous URB polling loop cause DMA buffer corruption, and passing a coherent D=
MA buffer to a synchronous USB API violates DMA mappings.
- [High] Ping-pong URBs can escape `usb_kill_urb()` during `input_close()`,=
 leading to continuous background execution and use-after-free.
--

commit 02a6ac0b5f7fd710af199370b924a27f34ca574c
Author: Jie Wang <jie.wang@intel.com>

Input: yealink - stop URB resubmission on completion error

urb_irq_callback() and urb_ctl_callback() resubmit each other's URBs
regardless of completion status. When the device returns a persistent
error (-EPROTO), this creates an unthrottled resubmission loop that
starves the CPU and triggers RCU stalls.

Stop resubmitting on any non-zero URB status, following the standard
completion pattern used by other USB input drivers.

Reported-by: syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D039eab266c6321a174bd
Signed-off-by: Jie Wang <jie.wang@intel.com>

> diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
> index 560f895a00cda..fcf66912f86b6 100644
> --- a/drivers/input/misc/yealink.c
> +++ b/drivers/input/misc/yealink.c
> @@ -405,9 +405,20 @@ static void urb_irq_callback(struct urb *urb)
>  	struct yealink_dev *yld =3D urb->context;
>  	int ret, status =3D urb->status;
> =20
> -	if (status)
> +	switch (status) {
> +	case 0:
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		dev_dbg(&yld->intf->dev, "%s - urb shutting down with status %d\n",
> +			__func__, status);
> +		return;
> +	default:
>  		dev_err(&yld->intf->dev, "%s - urb status %d\n",
>  			__func__, status);
> +		return;
> +	}

[Severity: High]
Does returning early on any non-zero status prevent resubmission on transie=
nt
errors?

If an error like -EPROTO or -EILSEQ is encountered due to electrical noise,
this early return completely drops the URB. Because the driver has no backo=
ff
timer or error retry mechanism, a single transient error will permanently s=
top
the polling state machine. Sysfs updates and key presses will silently be
ignored until the device is physically replugged.

[ ... ]

> @@ -443,9 +454,20 @@ static void urb_ctl_callback(struct urb *urb)
>  	struct yealink_dev *yld =3D urb->context;
>  	int ret =3D 0, status =3D urb->status;
> =20
> -	if (status)
> +	switch (status) {
> +	case 0:
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		dev_dbg(&yld->intf->dev, "%s - urb shutting down with status %d\n",
> +			__func__, status);
> +		return;
> +	default:
>  		dev_err(&yld->intf->dev, "%s - urb status %d\n",
>  			__func__, status);
> +		return;
> +	}

[Severity: High]
Will the same issue happen here, breaking the ping-pong URB loop on transie=
nt
USB errors and permanently freezing the device state machine?

[Severity: High]
This is a pre-existing issue, but does concurrent access to the shared cont=
rol
buffer from sysfs cause DMA corruption?

Looking at yealink_set_ringtone(), it modifies the shared control buffer
without locking:

drivers/input/misc/yealink.c:yealink_set_ringtone() {
    ...
    memset(yld->ctl_data, 0, sizeof(*(yld->ctl_data)));
    yld->ctl_data->cmd =3D CMD_RING_VOLUME;
    ...
}

Since yld->ctl_data is used as the dedicated DMA transfer buffer for the
asynchronous control URB which runs continuously in a background loop, modi=
fying
it from sysfs without locking against the async loop could corrupt an activ=
e DMA
transfer.

Additionally, yealink_set_ringtone() synchronously sends this buffer:

drivers/input/misc/yealink.c:yealink_cmd() {
    ...
    return usb_control_msg(yld->udev,
            usb_sndctrlpipe(yld->udev, 0),
            USB_REQ_SET_CONFIGURATION,
            USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
            0x200, 3,
            p, sizeof(*p),
            USB_CTRL_SET_TIMEOUT);
}

Because yld->ctl_data is allocated with usb_alloc_coherent(), does this vio=
late
the DMA API by attempting to dma_map_single() already-coherent memory?

[Severity: High]
This is a pre-existing issue, but can ping-pong URBs escape the shutdown
sequence and cause a use-after-free?

The driver attempts to stop the ping-pong URBs in input_close() by setting a
flag and killing them:

drivers/input/misc/yealink.c:input_close() {
    ...
    yld->shutdown =3D 1;
    usb_kill_urb(yld->urb_ctl);
    usb_kill_urb(yld->urb_irq);
    ...
}

If urb_irq_callback() evaluates !yld->shutdown as true but is preempted:

drivers/input/misc/yealink.c:urb_irq_callback() {
    ...
    if (!yld->shutdown) {
        ret =3D usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
    ...
}

And input_close() then sets shutdown =3D 1, kills urb_ctl (which isn't in f=
light
yet), and blocks killing urb_irq. When urb_irq_callback() resumes, it submi=
ts
urb_ctl. Because usb_kill_urb(urb_ctl) already returned and cleared the rej=
ect
count, the submission succeeds.

If the device is disconnected, usb_cleanup() frees the yealink_dev structur=
e,
but the runaway URB will dereference it upon completion. Should this use
usb_poison_urb() instead to reliably stop the loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616110440.1073=
059-1-jie.wang@intel.com?part=3D1
