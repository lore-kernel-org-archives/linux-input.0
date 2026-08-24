Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B994393DCA
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608886; cv=none; b=qgjnJdcleIW4g1I020dVRmCZ2fxSLczKdT7DLSh7y6uaJGfvkOepOe6PQYQnHDSPBhw1bWmVvrt4csEa6N8LacqNp7i1qwIjy5ZNC+HxMccyucXDn0/45t5+hVZHru8wFVgMpH3/YM3kgKPKdXd5XY0gBFhG8cAYNS6mKE8QHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608886; c=relaxed/simple;
	bh=E2HDIJlxW3IQjlLgDOvgfOlSTKJFS+ZbITgkrPHiU5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DHKq4t8lumytl6Olv/QtVsGKOy7RD27dzxpACfnolwEidmWo/Jfq/kXwWSrurCu+sTACWwnhnKJlGM7O7J4r1t7EpBD8JYHtX9Tt8WORTqhIM+9LhpD6HJEoVeK20gDBwjmD9GUsE/LPgkbvQmDUiim2uMfM0bkDB5vch8RWs/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3Jg/K+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3Jg/K+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297EE1F000E9;
	Mon, 24 Aug 2026 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608885;
	bh=CEEJDpZDvjRSfoiyJyhgtLodYjdyrign37r2+eJfSVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R3Jg/K+Yuo+C+gsGykpxFYy3zapNXf6h1ILY6gxXf+aGrlNgJCCHbX7tTSVgnyGrY
	 brjcBiTfA8oJgpUpEn+rHojlo/uBTW+uLJGDD2L+pTZC2l3D5fBqJrvhf9bCQubAAN
	 t2HPuHLHnwWOgKSuKImpQOi7SapgLLKWqOf6FEMrN6CksKLXY9X20qjMDQGRd01vQC
	 DKuX0CR23lWMRlr1cqmidKUvSlF3iNknDMlxNXn8pjdqrlDpGmk0HIgTnw9DjFvn7y
	 9sYgoAASSnXVR5Qz8ZIL9j+zcnIDXngHKC1afAw+i354C/zC0KF4GAn6L+4+qH1RTi
	 120NX98v6NgWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: ayaneo: Add AYANEO 3 detachable controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0acyBYXMgTWFydGnMgW5leg==?= <hello@matias.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260824215041.79892-1-hello@matias.me>
References: <20260824215041.79892-1-hello@matias.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:01:24 +0000
Message-Id: <20260824220125.297EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Out-of-Bounds/NULL Pointer Dereference when `hdev->maxcollection =
=3D=3D 0`
- [High] Use-After-Free due to Devres LIFO Violation on `hid_hw_stop`
- [Medium] Resource Lifecycle Stall in `eject_store` on hardware errors
- [Medium] Data Race allowing new commands to read a stale payload
--

--- Patch [1]: [PATCH] HID: ayaneo: Add AYANEO 3 detachable controller driv=
er ---
commit fb4fc36a684a0e10b09f75f11cd5139de0102be2
Author: Mati=CC=81as Marti=CC=81nez <hello@matias.me>

HID: ayaneo: Add AYANEO 3 detachable controller driver

The AYANEO 3 handheld has a detachable controller with swappable
modules ("Magic Modules"). The controller exposes three USB HID
interfaces behind 1c4f:0002 (a generic SigmaMicro VID/PID, hence the
DMI gate): a gamepad, a keyboard for the extra buttons, and a vendor
interface accepting 65-byte commands.

> diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/hid/hid-ayaneo.c
[ ... ]
> +static int aya3_cmd(struct aya3 *aya, u8 *resp)
> +{
> +	int attempt, ret;
> +
> +	lockdep_assert_held(&aya->lock);
> +
> +	for (attempt =3D 0; attempt < AYA3_CMD_ATTEMPTS; attempt++) {
> +		reinit_completion(&aya->resp_done);
> +		aya->resp_expect =3D aya->xfer[4];
> +		WRITE_ONCE(aya->resp_pending, true);
> +
> +		ret =3D aya3_send(aya);
> +		if (ret) {
> +			WRITE_ONCE(aya->resp_pending, false);
> +			return ret;
> +		}
> +
> +		if (wait_for_completion_timeout(&aya->resp_done,
> +						msecs_to_jiffies(AYA3_CMD_TIMEOUT_MS))) {
> +			if (resp)
> +				memcpy(resp, aya->resp, AYA3_RESP_SIZE);
> +			return 0;
> +		}
> +	}
> +	WRITE_ONCE(aya->resp_pending, false);
> +	return -ETIMEDOUT;
> +}
[ ... ]
> +static int aya3_raw_event(struct hid_device *hdev, struct hid_report *re=
port,
> +			  u8 *data, int size)
> +{
> +	struct aya3 *aya =3D hid_get_drvdata(hdev);
> +
> +	if (!READ_ONCE(aya->resp_pending) || size < AYA3_RESP_SIZE)
> +		return 0;
> +	if (data[AYA3_RESP_CMD] !=3D aya->resp_expect)
> +		return 0;
> +
> +	memcpy(aya->resp, data, AYA3_RESP_SIZE);
> +	WRITE_ONCE(aya->resp_pending, false);
> +	complete(&aya->resp_done);
> +	return 0;
> +}

[Severity: Medium]
Is there a race condition here if a command times out just as the reply
arrives?

If aya3_cmd() times out, it clears aya->resp_pending and returns. However,
a concurrent aya3_raw_event() might have already read aya->resp_pending as
true.=20

If a new command is issued immediately, could this delayed event copy stale
data and trigger complete() for the new command?

[ ... ]
> +static ssize_t eject_store(struct device *dev, struct device_attribute *=
attr,
> +			   const char *buf, size_t count)
> +{
[ ... ]
> +	/*
> +	 * Wait for the firmware to report the eject as done. Userspace
> +	 * must then cut power through ayaneo-ec's controller_power for
> +	 * the module to be physically released.
> +	 */
> +	ret =3D -ETIMEDOUT;
> +	for (i =3D 0; i < 20; i++) {
> +		msleep(400);
> +		if (aya3_check(aya, resp))
> +			continue;
> +		if (!(resp[AYA3_RESP_EJECT_STATUS] & ~AYA3_EJECT_DONE_MASK)) {
> +			ret =3D 0;
> +			break;
> +		}
> +	}

[Severity: Medium]
Could this loop stall for up to 8 seconds if the hardware is abruptly
unplugged?

If the device is physically removed, aya3_check() will immediately return
a fatal error, such as -ENODEV.

Since this continue statement ignores the error unconditionally, won't it k=
eep
sleeping for all 20 iterations even though the hardware is permanently gone?

[ ... ]
> +static int aya3_probe(struct hid_device *hdev, const struct hid_device_i=
d *id)
> +{
> +	struct aya3 *aya;
> +	int ret;
> +
> +	/* The VID/PID is a generic SigmaMicro ID; bind on AYANEO 3 only */
> +	if (!dmi_check_system(aya3_dmi_table))
> +		return -ENODEV;
> +
> +	if (!hid_is_usb(hdev))
> +		return -ENODEV;
> +
> +	ret =3D hid_parse(hdev);
> +	if (ret)
> +		return ret;
> +
> +	/* Bind only the vendor interface, not the gamepad/keyboard ones */
> +	if (hdev->collection->usage !=3D (HID_UP_MSVENDOR | 0x0001))
> +		return -ENODEV;

[Severity: High]
Can this dereference a NULL or uninitialized pointer if the device presents=
 a
report descriptor with zero collections?

A malformed USB HID device could pass hid_parse() but leave
hdev->maxcollection as 0.

Should this code check that hdev->maxcollection is greater than 0 before
accessing hdev->collection->usage?

[ ... ]
> +static void aya3_remove(struct hid_device *hdev)
> +{
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}

[Severity: High]
Does this manual hid_hw_stop() call violate the devres release order and
create a use-after-free window?

The driver registers the LED class device earlier in aya3_probe() using
the managed devm_led_classdev_multicolor_register().

Because devres actions run after the aya3_remove() callback finishes, calli=
ng
hid_hw_stop() here tears down the HID transport while the LED sysfs attribu=
tes
are still active.

If user space writes to the LED sysfs attribute during this window,
could aya3_led_set() attempt to send commands over the stopped transport?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824215041.7989=
2-1-hello@matias.me?part=3D1
