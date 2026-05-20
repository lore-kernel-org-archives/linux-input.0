Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAA2C3245
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242911; cv=none; b=VQODXJ5ZjbDyLqDdNwjNGDbKhp1i+q3wQ2CbdYHtWp64tfQUusJDcVghWk5sUaBrB6Eotou4Xo+MRXoG3PQ+v3O+zh2lOstagF1za804mWDDAsLO/u80I/ky7DAopfXvY8L0Vuv1STMR3RDxbEeMky+Ibuvm3tyUeLIRb3u9zWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242911; c=relaxed/simple;
	bh=bM2mL9rYoj0JgX1lKF/c5IWYjUm0AgDBskIB1ApJUSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PatnLnIstxrJt8qtmxhd0fg7kiJkEm43yAq41hIWgeMsbLbfDxuOBv3If5snoTESsvGLXwYzMwtyxrRR2Yu/Bl3ILQSwY+t4yFY1Smg4Mi6Mzj8UEQzDHIgkr/YiYI+biR1mQIs9+yCwngwu2U5UiCUR24cnW3fT8Rjqg5W+5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTD3Khib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTD3Khib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4791F000E9;
	Wed, 20 May 2026 02:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779242909;
	bh=IJMKEFtX4kFe3aDINMffAWqZxyc6acu0AIwKi0XtwRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LTD3KhibxEHhQDB5VZxgq4QPqj+nFe96+kPAi10q+1WrC9p0Obboz6OKtx+ns5U5A
	 T3ZRJ91l2X6yokjbpNNPZ9ffTQRCyVi5PBDNOHlSufeXxmyySQ2PlA5ETLjtqJr78z
	 Pv7B/4NVYkJpYe0tXWiqctZk0A7vkB/wfF8TRLmLtZi/isYAGevQSEJrzjwKjUqzJg
	 iZ++IB1FKxTiVxip4KV1lKX4cLol+NYQRXSOF0e2dCxiqzTrvlPQGqX3N38r2vlvRF
	 mg8xYXERXn9+iCRBeMg/lJWU1DhEA67QclAzwetQ7Bjaw4ZlLO45eftjc5BOF//piW
	 J0wLLOj+7X9NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260520013158.3633277-2-derekjohn.clark@gmail.com>
References: <20260520013158.3633277-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 02:08:28 +0000
Message-Id: <20260520020829.6D4791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in the sysf=
s attribute handlers allows hardware access after device teardown.
- [Medium] State machine is not reset if hid_hw_output_report() returns a n=
egative error code.
--

commit 4222880100fe04d05b88fc8c07f6d4c9f2dcb27c
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add MSI Claw configuration driver

Adds a configuration HID driver for the MSI Claw series of handheld PCs
to support gamepad mode switching, M-key behavior adjustments, and device
reset functions.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> index 0000000000000..d95483907a5e5
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *=
data,
> +				 size_t len, unsigned int timeout)
> +{

[ ... ]

> +	guard(mutex)(&drvdata->cfg_mutex);
> +	if (timeout) {
> +		reinit_completion(&drvdata->send_cmd_complete);
> +		scoped_guard(spinlock_irqsave, &drvdata->cmd_lock) {
> +			drvdata->waiting_cmd =3D index;
> +			drvdata->waiting_for_ack =3D true;
> +			drvdata->cmd_status =3D -ETIMEDOUT;
> +		}
> +	}
> +
> +	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
> +		CLAW_PACKET_SIZE, dmabuf);
> +
> +	ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
> +	if (ret < 0)
> +		return ret;

[Severity: Medium]
Does this leave the state machine armed if hid_hw_output_report() returns a
negative error code (like -EPIPE)?

If the early return is taken, waiting_for_ack and waiting_cmd remain set.
If a subsequent command is sent with timeout =3D=3D 0, and an unexpected in=
put
report arrives that matches the stale waiting_cmd, could it improperly
trigger a completion and corrupt the internal state?

Would it be safer to clear waiting_cmd and waiting_for_ack on all error pat=
hs
before returning?

> +
> +	ret =3D ret =3D=3D CLAW_PACKET_SIZE ? 0 : -EIO;
> +	if (ret) {
> +		scoped_guard(spinlock_irqsave, &drvdata->cmd_lock) {
> +			drvdata->waiting_cmd =3D CLAW_COMMAND_TYPE_NONE;
> +			drvdata->waiting_for_ack =3D false;
> +		}
> +		return ret;
> +	}

[ ... ]

> +static ssize_t gamepad_mode_store(struct device *dev, struct device_attr=
ibute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int i, ret =3D -EINVAL;
> +	u8 data[2];
> +
> +	/* Pairs with smp_store_release from cfg_setup_fn in system_wq context =
*/
> +	if (!smp_load_acquire(&drvdata->gamepad_registered))
> +		return -ENODEV;

[Severity: High]
Can a sysfs thread race with device removal here and cause a use-after-free?

The lockless check of gamepad_registered does not appear to prevent
msi_remove() from running concurrently once the check passes. If the USB
device is disconnected, a sysfs thread could evaluate the flag as true
and then get preempted.

Concurrently, msi_remove() could run, set the flag to false, and call
hid_hw_stop(), which tears down the lower-level USB HID resources.

When the sysfs thread resumes, it would eventually call:
claw_hw_output_report() -> hid_hw_output_report() -> usbhid_output_report()
on the torn-down hdev structure.

Should a mutex or other synchronization mechanism be used to safely seriali=
ze
the sysfs execution against hardware teardown?

> +
> +	for (i =3D 0; i < ARRAY_SIZE(claw_gamepad_mode_text); i++) {
> +		if (claw_gamepad_mode_text[i] && sysfs_streq(buf, claw_gamepad_mode_te=
xt[i])) {
> +			ret =3D i;
> +			break;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520013158.3633=
277-1-derekjohn.clark@gmail.com?part=3D1
