Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2EB70830
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778983865; cv=none; b=VIBiRpCyzoObQzKRlWSmdMgzY6/4j04WdZiZ2loFX49+xbyajg346c4nUAI5lnN3dG85YTVhye4K0MgZhbKxbpFXg9S/YqWJc+Pusrxx375YJTmSjbrUx5OQcZWVTnIT5ufvljHmSQmIUqnkI25TErNApOT34BQHy9t+e6fm3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778983865; c=relaxed/simple;
	bh=4/9NfymSYUS0jbtZcaxzSjNYobC22Eb+Af0immVS6kY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PZXqPIhFcNUYOnYDDvCHQaXcR/EUZHGoIKxaNs4ygV7aD7SeJeRWw0QBx1MHYbIidOmvkPXCbBO9ff7bOMh3fqjXJZxBeyamRTGGur7KfrG4LQeGUIo0j9uuqyAuh7xbO2wUC1IkjRR8cRbij4MN0Med0TNVLy8CzMdOvQDZaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTzEibw9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTzEibw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF60C19425;
	Sun, 17 May 2026 02:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778983864;
	bh=4/9NfymSYUS0jbtZcaxzSjNYobC22Eb+Af0immVS6kY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GTzEibw9wh52Nr6NUOjVXrVVgkTHZOHSXpxjlTaXDKXoVUzXkk16o3JThApYpseUy
	 2X1gqdeWH7fO/dJxdCtsICRKifUelVK3Ma7dDfDvYWWmgwelVLAjTPp1dsNC7WBpZP
	 Yi7/bzjsPfTensuqEC4NYP8Lu07j+EPRAFC0ryqQsXR6OnpAIfcxbbaL7QWe/B+1pK
	 uSbCUuXaMdyssdlWfZ2MsUnHNRvql9VBJiH/fTVvBMzHfE6dGBNnydmEo7on61aVgJ
	 zUuZGXCrfkinYee5y+UKXj5bZ1kH8sf4/vWnV6U0vo07QLymVgAlhDO9pVMDt98eMT
	 5NS0/Di1jghFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260517013925.3120314-2-derekjohn.clark@gmail.com>
References: <20260517013925.3120314-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 02:11:04 +0000
Message-Id: <20260517021104.9FF60C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] ABBA deadlock in `claw_remove` during sysfs group removal.
- [High] Dynamic endpoint querying in `msi_remove` can bypass cleanup on al=
ternate setting changes, leading to a Use-After-Free.
- [High] Unbalanced `hid_hw_close` call in `claw_remove` causes reference c=
ount underflow if `drvdata` is NULL.
- [High] Late ACKs from timed-out commands incorrectly fulfill the completi=
on wait of subsequent synchronous commands.
- [Medium] The 8ms timeout for hardware output reports is too short and wil=
l randomly fail due to jiffy timer granularity.
- [Medium] System suspend during initial probe permanently prevents sysfs a=
ttribute registration.
- [Medium] Kconfig dependency mismatch for LEDS_CLASS causes unmet dependen=
cy warnings.
- [Medium] cfg_resume_fn unconditionally forces a destructive USB disconnec=
t on every system resume.
- [Medium] Unprotected data race on `drvdata->gamepad_mode` and `drvdata->m=
keys_function` between interrupt and process contexts.
--

commit 518cb80b6362b58a1246f31d9fcaf94c7bfd77ee
Author: Derek J. Clark <derekjohn.clark@gmail.com>
Subject: HID: hid-msi: Add MSI Claw configuration driver

This commit adds a configuration driver for the MSI Claw series of handheld=
s.
It supports gamepad mode switching, M-key behavior, and a device reset via
sysfs attributes.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index ff2f580b660ba..ec412bba1e1ed 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -485,6 +485,18 @@ config HID_GT683R
>  	Currently the following devices are know to be supported:
>  	  - MSI GT683R
> =20
> +config HID_MSI
> +	tristate "MSI Claw Gamepad Support"
> +	depends on USB_HID
> +	select LEDS_CLASS
> +	select LEDS_CLASS_MULTICOLOR

Is it possible this will cause an unmet dependency Kconfig warning if NEW_L=
EDS
is not enabled?

LEDS_CLASS depends on NEW_LEDS, so selecting it without inheriting the
dependency can cause build issues on some configurations.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> index 0000000000000..3f809dc70a4cc
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
> +				   struct claw_command_report *cmd_rep)
> +{
> +	if (cmd_rep->data[0] >=3D ARRAY_SIZE(claw_gamepad_mode_text) ||
> +	    !claw_gamepad_mode_text[cmd_rep->data[0]] ||
> +	    cmd_rep->data[1] >=3D ARRAY_SIZE(claw_mkeys_function_text))
> +		return -EINVAL;
> +
> +	drvdata->gamepad_mode =3D cmd_rep->data[0];
> +	drvdata->mkeys_function =3D cmd_rep->data[1];

Is there a potential data race here?

These fields are written from the raw event callback (which runs in interru=
pt
context), but they are read in process context by functions like cfg_resume=
_fn
and gamepad_mode_show without acquiring a shared lock.

> +
> +	return 0;
> +}
> +
> +static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_repor=
t *report,
> +			  u8 *data, int size)
> +{

[ ... ]

> +	switch (cmd_rep->cmd) {
> +	case CLAW_COMMAND_TYPE_GAMEPAD_MODE_ACK:
> +		ret =3D claw_gamepad_mode_event(drvdata, cmd_rep);
> +		break;
> +	case CLAW_COMMAND_TYPE_ACK:
> +		break;
> +	default:
> +		dev_dbg(&drvdata->hdev->dev, "Unknown command: %x\n", cmd_rep->cmd);
> +		return 0;
> +	}
> +
> +	complete(&drvdata->send_cmd_complete);

If a previous synchronous command timed out, but the device later sends an =
ACK,
will this unconditionally complete the completion?

When the next command calls reinit_completion(), an immediate late ACK from=
 the
previous command might falsely complete the new command's wait, causing the
driver to read stale state.

> +
> +	return ret;
> +}

[ ... ]

> +static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *=
data,
> +				 size_t len, unsigned int timeout)
> +{

[ ... ]

> +	if (timeout) {
> +		ret =3D wait_for_completion_interruptible_timeout(&drvdata->send_cmd_c=
omplete,
> +								msecs_to_jiffies(timeout));

Could this timeout prematurely?

When the timeout is very short (like 8ms as used in gamepad_mode_show),
msecs_to_jiffies(8) evaluates to 1 jiffy on HZ=3D100 kernels.

A 1-jiffy timeout can expire almost instantly if the system jiffy tick occu=
rs
immediately after wait_for_completion_interruptible_timeout() is called,
leading to a spurious -EBUSY.

> +
> +		dev_dbg(&hdev->dev, "Remaining timeout: %u\n", ret);
> +		if (ret >=3D 0) /* preserve errors */
> +			ret =3D ret =3D=3D 0 ? -EBUSY : 0; /* timeout occurred : time remaine=
d */
> +	}
> +
> +	return ret;
> +}

[ ... ]

> +static void cfg_resume_fn(struct work_struct *work)
> +{
> +	struct delayed_work *dwork =3D container_of(work, struct delayed_work, =
work);
> +	struct claw_drvdata *drvdata =3D container_of(dwork, struct claw_drvdat=
a, cfg_resume);
> +	u8 data[2] =3D { drvdata->gamepad_mode, drvdata->mkeys_function };
> +	int ret;
> +
> +	ret =3D claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_SWITCH_M=
ODE, data,
> +				    ARRAY_SIZE(data), 0);

The commit message mentions that sending the SWITCH_MODE command causes a U=
SB
disconnect in the device.

Will this unconditional SWITCH_MODE call on every system resume forcibly
disconnect and re-enumerate the gamepad, potentially breaking active
applications holding an open file descriptor?

> +	if (ret)
> +		dev_err(&drvdata->hdev->dev, "Failed to set gamepad mode settings: %d\=
n", ret);
> +}

[ ... ]

> +static void claw_remove(struct hid_device *hdev)
> +{
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +
> +	if (!drvdata) {
> +		hid_hw_close(hdev);

If drvdata is NULL (meaning claw_probe was never called or failed), will
calling hid_hw_close() underflow the hdev->ll_open_count, since hid_hw_open=
()
was never successfully called?

> +		return;
> +	}
> +
> +	cancel_delayed_work_sync(&drvdata->cfg_setup);
> +	cancel_delayed_work_sync(&drvdata->cfg_resume);
> +
> +	guard(mutex)(&drvdata->cfg_mutex);
> +	if (drvdata->gamepad_registered)
> +		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);

Will holding the cfg_mutex while removing the sysfs group cause an ABBA
deadlock?

The sysfs core's removal blocks until active references to attributes are
drained. If a user concurrently accesses an attribute, the sysfs callback w=
ill
try to acquire the cfg_mutex (via claw_hw_output_report).

The driver would hold the mutex waiting for the sysfs reference to drop, wh=
ile
the callback holds the sysfs reference waiting for the mutex.

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

If userspace dynamically changes the USB alternate setting via
USBDEVFS_SETINTERFACE, the endpoint check here could fail and bypass
claw_remove().

If claw_remove() is bypassed, the delayed works (cfg_setup and cfg_resume)
are never cancelled. Could this result in a use-after-free when those works
eventually execute and access the freed drvdata?

> +
> +hw_stop:
> +	hid_hw_stop(hdev);
> +}

[ ... ]

> +static int claw_suspend(struct hid_device *hdev)
> +{
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +
> +	if (!drvdata)
> +		return -ENODEV;
> +
> +	cancel_delayed_work_sync(&drvdata->cfg_setup);

If the system suspends before the cfg_setup delayed work fires, the work is
synchronously cancelled here.

Since claw_resume schedules cfg_resume but does not reschedule cfg_setup,
will drvdata->gamepad_registered remain false forever, permanently
preventing sysfs attribute registration?

> +	cancel_delayed_work_sync(&drvdata->cfg_resume);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517013925.3120=
314-1-derekjohn.clark@gmail.com?part=3D1
