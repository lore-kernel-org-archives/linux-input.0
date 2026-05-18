Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF430DD22
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145041; cv=none; b=Rugq+OcODTdSndQudlQR0XLwbst/fV14llQiaoYVPuYCHejM89NWkQGQ8LeLSZMaf3PgEL8cA0hWqtdeOFyYxqskXOOh5ZxVJX2L6/QwBDREwqsHAh8rW+pBKP+Y0ztEov18LJw25JVTliHgH9UbPwvSAJvzw7xZKNWsmI0jqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145041; c=relaxed/simple;
	bh=kFwLJs8ExYg2KWSpFWev0k+2etrG/M2l8OpxRShJrhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dBaDZR0o2nG/DkZyyBndLboRtVf4ISSvddataY6tFzeYv8eJeTdQQyvdKv1oGtXQvLoy2knx6qnIii5Bf+oRgFCf+OL89kDEFrhLQoqNmFLj1RMwXZkhBfRbvwRQhQLxx02gams5u2syg7aMCMbxz0Qqwliwfwb1WtBQEtX6zvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjtm3P/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjtm3P/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5F0C2BCB7;
	Mon, 18 May 2026 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779145040;
	bh=kFwLJs8ExYg2KWSpFWev0k+2etrG/M2l8OpxRShJrhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Bjtm3P/fIFARSzX1cgOfLOgLI9c94wEjgIi37LnaHt10rH9SqRZNxv3v4/Nqx7BV+
	 JNSj6nvRHyR8KDkpH0fB3ezkbvwP8DI/EUBQ7zs1MEbr1sFazhDaVLgvUxyS27iE2A
	 ZHIzQtaoTrZGLNmSF/zyvb+kMda642bTNg+a0O9LStktB+GCnSzAFiC5iRdHGgANjR
	 0h7a0jNYNTziq8/aQS90D/p4SbxpAE2vWhO6SUutH8MeZwWs+joVUXRd6KNgRFzn2r
	 nM/0oEToYkwke+eqT+n2v8vinESKSv+k3P94ShXbsBZGgMu2p9+DIpPtuim/uKbVs/
	 xeL34Oq/+xm8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260518222935.1802071-2-derekjohn.clark@gmail.com>
References: <20260518222935.1802071-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 22:57:20 +0000
Message-Id: <20260518225720.7A5F0C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Inverted registration check in `gamepad_mode_show` breaks function=
ality and allows access after device removal.
- [High] TOCTOU race in sysfs attributes leading to Use-After-Free during d=
evice teardown.
- [High] Race condition with `reinit_completion` and unprotected state on e=
rror paths in `claw_hw_output_report`.
- [High] Incorrect cancellation order of interdependent delayed works cause=
s a Use-After-Free.
- [High] Brittle endpoint check in `msi_remove` bypasses teardown and cause=
s unbalanced `hid_hw_close`.
--

commit bae529985c447afb063f1f68fb0ebbfec812a32f
Author: Derek J. Clark <derekjohn.clark@gmail.com>
Subject: HID: hid-msi: Add MSI Claw configuration driver

This commit adds a configuration HID driver for the MSI Claw series of
handheld PC's. It provides an initial driver outline and attributes for
changing the gamepad mode, M-key behavior, and handling resets.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> index 0000000000000..c79eb0bfeb776
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *=
data,
> +				 size_t len, unsigned int timeout)
> +{
> +	unsigned char *dmabuf __free(kfree) =3D NULL;
> +	u8 header[] =3D { CLAW_OUTPUT_REPORT_ID, 0, 0, 0x3c, index };
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	size_t header_size =3D ARRAY_SIZE(header);
> +	int ret;
> +
> +	if (header_size + len > CLAW_PACKET_SIZE)
> +		return -EINVAL;
> +
> +	/* We can't use a devm_alloc reusable buffer without side effects durin=
g suspend */
> +	dmabuf =3D kzalloc(CLAW_PACKET_SIZE, GFP_KERNEL);
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	memcpy(dmabuf, header, header_size);
> +	if (data && len)
> +		memcpy(dmabuf + header_size, data, len);
> +
> +	guard(mutex)(&drvdata->cfg_mutex);
> +	if (timeout) {
> +		scoped_guard(spinlock_irqsave, &drvdata->cmd_lock) {
> +			drvdata->waiting_cmd =3D index;
> +			drvdata->waiting_for_ack =3D true;
> +			drvdata->cmd_status =3D -ETIMEDOUT;
> +		}
> +		reinit_completion(&drvdata->send_cmd_complete);

Could this race with an incoming ACK? Since reinit_completion() is called
outside cmd_lock after setting waiting_for_ack =3D true, an ACK arriving in
this window could call complete(), which would then be overwritten, causing
a command timeout.

> +	}
> +
> +	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
> +		CLAW_PACKET_SIZE, dmabuf);
> +
> +	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ret =3D=3D CLAW_PACKET_SIZE ? 0 : -EIO;
> +	if (ret)
> +		return ret;

If hid_hw_output_report() fails or returns a partial write, the function
returns early without resetting waiting_for_ack to false. Could this corrupt
the state machine and cause stray ACKs to trigger spurious completions late=
r?

[ ... ]

> +static ssize_t gamepad_mode_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int ret, i;
> +
> +	if (drvdata->gamepad_registered)
> +		return -ENODEV;

Should this be if (!drvdata->gamepad_registered)? Without the logical NOT,
this prevents reading the mode during normal operation and allows access
during teardown, which could lead to a use-after-free since the sysfs
attribute can be accessed after device removal.

[ ... ]

> +static ssize_t mkeys_function_store(struct device *dev, struct device_at=
tribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int i, ret =3D -EINVAL;
> +	u8 data[2];
> +
> +	if (!drvdata->gamepad_registered)
> +		return -ENODEV;

Is there a race condition here during device teardown? The check for
gamepad_registered happens locklessly before cfg_mutex is acquired in
claw_hw_output_report().

If claw_remove() executes concurrently, sets gamepad_registered to false,
and closes the hardware, could this result in calling hid_hw_output_report()
on a stopped device and causing a use-after-free when the sysfs thread
resumes?

[ ... ]

> +static void claw_remove(struct hid_device *hdev)
> +{
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +
> +	if (!drvdata) {
> +		hid_hw_close(hdev);
> +		return;
> +	}
> +
> +	cancel_delayed_work_sync(&drvdata->cfg_setup);
> +	cancel_delayed_work_sync(&drvdata->cfg_resume);

Should cfg_resume be cancelled before cfg_setup? Since cfg_resume_fn() can
schedule cfg_setup, cancelling cfg_setup first might allow cfg_resume_fn()
to queue it again. If this happens, the newly scheduled cfg_setup work could
access freed drvdata memory after claw_remove() finishes.

> +
> +	drvdata->gamepad_registered =3D false;
> +
> +	hid_hw_close(hdev);
> +}
> +
> +static void msi_remove(struct hid_device *hdev)
> +{
> +	int ret;
> +	u8 ep;
> +
> +	ret =3D get_endpoint_address(hdev);
> +	if (ret <=3D 0)
> +		goto hw_stop;
> +
> +	ep =3D ret;
> +	if (ep =3D=3D CLAW_XINPUT_CFG_INTF_IN || ep =3D=3D CLAW_DINPUT_CFG_INTF=
_IN)
> +		claw_remove(hdev);

Is it safe to rely on get_endpoint_address() during removal?

If userspace modifies the USB alternate setting via usbfs while the driver
is bound, the endpoint could change, causing claw_remove() to be skipped
and leaving the workqueues running, leading to a use-after-free.

Conversely, if the endpoint didn't match during probe but does match during
removal, claw_remove() might be called with a NULL drvdata and execute
hid_hw_close() without a prior hid_hw_open(), underflowing ll_open_count.

[ ... ]

> +static int claw_suspend(struct hid_device *hdev)
> +{
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +
> +	if (!drvdata)
> +		return -ENODEV;
> +
> +	cancel_delayed_work_sync(&drvdata->cfg_setup);
> +	cancel_delayed_work_sync(&drvdata->cfg_resume);

Does this have the same cancellation order issue as claw_remove(), where
cfg_resume_fn() could reschedule cfg_setup after it has been cancelled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518222935.1802=
071-1-derekjohn.clark@gmail.com?part=3D1
