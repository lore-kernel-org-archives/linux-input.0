Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE318EB0
	for <linux-input@vger.kernel.org>; Sat, 16 May 2026 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778907673; cv=none; b=pM3ZTtoI45wUSHRNckkzJs3MYXpt0icw6rccSMPEie/GsBUsoVCYBDG4zxZURk9IQqlk8lUTfwN48c3SuuDOLIhP0IzZC4N9aptOsChiSXnWejQ+kpvHBSX0vMhEptqZr5NXXlj54uh/R2MoUwyEYyQv3IOplG4ihfET2L3DNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778907673; c=relaxed/simple;
	bh=Nim0V5wEOLFHzcmiBZ4aLFUnJkseIuztvfcslbDvPcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KlFjEsWBMuMFKj+ujV9BBzIZQAEB3XVTouvr2/PS2fqh2Ht6Fc/gGxrVh3awMjvKuTb0udOk9267mW89RmnSiM4BpmCEUo8UhLwhsczqeD/jbViJlu+zkt3uyqCyTB4pOKjqcZeMS0j5d2HEnVjCXE2YdbkNWXQSi0VBsw66KmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0uN3gd3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0uN3gd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA9BC19425;
	Sat, 16 May 2026 05:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778907673;
	bh=Nim0V5wEOLFHzcmiBZ4aLFUnJkseIuztvfcslbDvPcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=F0uN3gd3MdKJa0HO9kkKf1LPFngcUtqEXta4r0uBmBFmhPAyG/4t1sYRgCAS5qHmE
	 vT8ONLKxmLSdpSYOnzxRTdgEtGIkFXxJ+sFSwGQ3L7kfSQi5iLO+CqCoEd58yUzcOz
	 namVAGDAwJStVrm5RhhQqIJ1QPoD3tVm/KDmVhqb+2csBs1Brh2d9PeARVzc0J0f2f
	 ad5SSM6+izcYcZryBAqg4Juj7H9TZMD+2Qe+bjdHLuPxCq2ugocTH+8ERv2CdpAklr
	 fBqm/I6HJXeFjvdjmrI/haubMjxYEvgcVVvQ+NMdxU516D3wSJOInE3Anc3y/w/RvZ
	 8G6lgkDniGDww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260516042841.500299-2-derekjohn.clark@gmail.com>
References: <20260516042841.500299-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 05:01:12 +0000
Message-Id: <20260516050112.EDA9BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] ABBA deadlock between `cfg_mutex` and sysfs kernfs active referenc=
es during device removal.
- [High] The `mode_mutex` in `struct claw_drvdata` is never initialized, le=
ading to kernel crashes upon contention.
- [High] Defensive error handling in `claw_remove()` introduces a double ex=
ecution of `hid_hw_stop()`.
- [High] Unconditional device disconnect and state loss upon system resume.
- [Medium] Sysfs attributes are permanently lost if the system suspends sho=
rtly after probe.
- [Medium] Fragile endpoint detection logic checks only the first endpoint =
in the interface.
- [Medium] Late ACKs from timed-out commands spuriously complete new comman=
ds.
- [Medium] Fragile 8ms timeout can cause spurious failures on systems with =
HZ=3D100.
--

commit 6fb3a7c70c0068c58170fcddbffdda870a23fe93
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add MSI Claw configuration driver

This commit adds a configuration HID driver for the MSI Claw series of
handheld PC's. It provides an interface to change the gamepad mode,
M-key behavior, and reset the device.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> +static int get_endpoint_address(struct hid_device *hdev)
> +{
> +	struct usb_host_endpoint *ep;
> +	struct usb_interface *intf;
> +
> +	intf =3D to_usb_interface(hdev->dev.parent);
> +	ep =3D intf->cur_altsetting->endpoint;

Does this correctly handle configurations where the target IN endpoint is n=
ot
at index 0? Since USB endpoint ordering is not strictly mandated, should th=
is
iterate over desc.bNumEndpoints instead of blindly selecting the first one?

[ ... ]
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

Could late ACKs from previously timed-out commands spuriously trigger this
completion? If a prior command times out and releases the mutex, and a new
command is issued, a delayed ACK might cause the new wait to return
prematurely with stale data.

[ ... ]
> +static ssize_t gamepad_mode_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int ret, i;
> +
> +	guard(mutex)(&drvdata->mode_mutex);
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE=
, NULL, 0, 8);

Could this 8ms timeout cause spurious failures on systems configured with
HZ=3D100? In that configuration, msecs_to_jiffies(8) evaluates to 1 jiffy,
which can expire in a fraction of a millisecond depending on when the system
timer tick occurs.

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

The commit message notes that sending the SWITCH_MODE command causes a USB
disconnect in the device. Does sending this unconditionally on system resume
force a physical USB disconnect and re-enumeration every time the host wakes
from sleep?

[ ... ]
> +static int claw_probe(struct hid_device *hdev, u8 ep)
> +{
> +	struct claw_drvdata *drvdata;
> +	int ret;
> +
> +	drvdata =3D devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->gamepad_mode =3D CLAW_GAMEPAD_MODE_XINPUT;
> +	drvdata->hdev =3D hdev;
> +	drvdata->ep =3D ep;
> +
> +	mutex_init(&drvdata->cfg_mutex);

Is there a missing mutex_init() for drvdata->mode_mutex here? Since the
structure is zero-allocated via devm_kzalloc, locking an uninitialized mutex
later in gamepad_mode_store() can trigger lockdep warnings or crashes.

[ ... ]
> +static void claw_remove(struct hid_device *hdev)
> +{
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +
> +	if (!drvdata) {
> +		hid_hw_stop(hdev);
> +		return;
> +	}

If drvdata is NULL, this function calls hid_hw_stop(hdev). Will this cause a
double-free or use-after-free since the caller msi_remove() also calls
hid_hw_stop(hdev) unconditionally after this returns?

> +
> +	cancel_delayed_work_sync(&drvdata->cfg_setup);
> +	cancel_delayed_work_sync(&drvdata->cfg_resume);
> +
> +	guard(mutex)(&drvdata->cfg_mutex);
> +	device_remove_group(&hdev->dev, &claw_gamepad_attr_group);

Can taking cfg_mutex here cause a deadlock during device removal?

device_remove_group() drains active sysfs operations and waits for them to
complete. However, callbacks like gamepad_mode_store() take cfg_mutex
internally. If a user is reading or writing an attribute concurrently, remo=
ve
will block waiting for sysfs, and sysfs will block waiting for cfg_mutex.

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

If the system suspends before the 500ms cfg_setup timer expires, this cance=
ls
the setup work. Since claw_resume() only schedules cfg_resume, will the
device silently fail to ever expose its sysfs attributes for the rest of its
lifecycle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516042841.5002=
99-1-derekjohn.clark@gmail.com?part=3D1
