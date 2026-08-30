Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AE2690EC
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102530; cv=none; b=SbK8ThVkT+QchMCgbL3i9Q8/ac6oR7Aa2MTfw+FX0zXgeNdFAIAzmhF6TfCIn+LZI/RoBog2GYDlVsHeaRGr0wxnm5NscTVLvmixlNj0Ai0yb0QMckfAA55jOxeBglzP4mc82w3vUlMrAYyfWGVCakJHDWvQVSERSBKvHLQZ1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102530; c=relaxed/simple;
	bh=ffrQNKUGxX5b86/6FnGE4srzl7Gq+7xF7xyhQizLEf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/rHjNyBDnTTrmc2Rps1KkUiKHoyd5xbGslc67vcy7BvILTrI9YvB/895Q/Bm+5SgvDLU7bCe/jct+L29rpFh9wL0DCPKvO/eXZPZyr00nC0NpZp7dj4YKjjE7jifJGrYgrGfG8cvMUZX0TwCcL7HU8vvSuQSiTY7hcBkrB8BTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3h9LbLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3h9LbLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50191F000E9;
	Sun, 30 Aug 2026 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788102529;
	bh=rcxDacx4xIrI0o8g/OFvARlBq2BMzYNxWpSFar+Z8K4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g3h9LbLfEB/4P4vw+hjupHeC1tWhcp4LPkT4KQn6EkCjmo+UpmvclGArtvQkKAFTO
	 ySwDWOhQlI6Joq5RPW74YklPrR4ZQwQpi5N6P46rQsG3B//Zd7LUTLH85wEgL/1iEs
	 qlpzgRJs4LLZPvQWoDZZeU0lJmEFoPo2/+kcVTnhuHIZyBjrkf79z3bIP1n2bHDbpT
	 PyR9T/XuHM5quSgIza5iqGssDjO74a6Myo7rsOH4tP/O8xbdNu5gYzK03bHnoxZnVI
	 XYdR8Cfv9vGfOjeY1QWfwQeFwKyMurQh8cnbxaXG5gD2RD6pmwui01iavGA05BKKnr
	 td6LW/C+AD8UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] HID: hid-lenovo-go: normalize calibration
 failure status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <c7b6d167fae5846377d49b57b0f542063fd80ad1.1788096668.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
 <c7b6d167fae5846377d49b57b0f542063fd80ad1.1788096668.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:08:48 +0000
Message-Id: <20260830150848.E50191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The drivers use static global variables for per-device state a=
nd LED registration, preventing support for multiple devices and causing st=
ate corruption.
- [High] Missing `hid_hw_stop()` and `hid_hw_close()` in probe error paths.
- [High] LED devres unregistration happens after `hid_hw_stop()`, leaving a=
 window for illegal hardware access.
- [High] The LED `brightness_set` callback illegally sleeps.
- [High] Hardware stop leaked during device removal if endpoint address ret=
rieval fails.
--

commit 6f9c422af24bce1a678acc087e7d364da24c0f75
Author: Aditya Dash <mradityadash@gmail.com>

HID: hid-lenovo-go: normalize calibration failure status

The driver stores the firmware result byte as an index into the
calibration status text. A Legion Go 1 returned 0x08 after an idle Stop.
The status table has only three entries, so a later read returns -EINVAL.

Keep the defined values 0x00 through 0x02. Treat larger result values as
failure before storing them.

Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index dbfacbb70394b..c7a2e621a4ade 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak
the HID hardware state?

drivers/hid/hid-lenovo-go.c:hid_go_probe() {
	...
	ret =3D hid_go_cfg_probe(hdev, id);
	if (ret)
		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface\n=
");

	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);

	return ret;
}

If hid_go_cfg_probe() fails, the function returns an error without unwinding
the started hardware with hid_hw_stop() and hid_hw_close(). Since the custom
remove callback overrides the core's default unbind behavior, could this le=
ad
to a use-after-free?

The hid-lenovo-go-s driver has the identical omission in its nested probe
error path:

drivers/hid/hid-lenovo-go-s.c:hid_gos_probe() {
	...
	ret =3D hid_gos_cfg_probe(hdev, id);
	if (ret)
		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface");
	...
}

[Severity: Critical]
This is a pre-existing issue, but does using a static global variable for
per-device state prevent support for multiple devices?

drivers/hid/hid-lenovo-go.c:
static struct hid_go_cfg {
	struct delayed_work go_cfg_setup;
	struct hid_go_cmd cmd;
...

If a second Lenovo Go controller is connected, the second probe overwrites
the global drvdata.hdev pointer in hid_go_cfg_probe():

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
	...
	mutex_init(&drvdata.cfg_mutex);
	init_completion(&drvdata.cmd.done);
	spin_lock_init(&drvdata.cmd.lock);
	drvdata.cmd.pending =3D false;
	hid_set_drvdata(hdev, &drvdata);
	drvdata.hdev =3D hdev;
	...
	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
	...
}

Does registering the exact same static go_cdev_rgb struct with devres
corrupt the LED core lists and crash the kernel?

[Severity: High]
This is a pre-existing issue, but does manually stopping the hardware here
leave a window for illegal hardware access?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
	...
	hid_hw_close(hdev);
	hid_hw_stop(hdev);
	hid_set_drvdata(hdev, NULL);
	...
}

Because the LED is cleaned up asynchronously by devres after remove()
returns, could a user writing to the LED brightness sysfs file in this
window invoke hid_go_brightness_set(), sending an output report to a
stopped HID device using a dangling drvdata.hdev pointer?

[Severity: High]
This is a pre-existing issue, but does the LED brightness_set callback
illegally sleep?

drivers/hid/hid-lenovo-go.c:hid_go_brightness_set() {
	...
	ret =3D rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
	...
}

The brightness_set LED callback is expected to be non-blocking, but it calls
rgb_cfg_call() which waits on a completion. If the LED is controlled by a
timer trigger, could this callback execute in a softirq/timer context and
cause a kernel panic?

[Severity: High]
This is a pre-existing issue, but does this early return leak the hardware
start state?

drivers/hid/hid-lenovo-go.c:hid_go_remove() {
	...
	int ep =3D get_endpoint_address(hdev);

	if (ep <=3D 0)
		return;
	...
}

If a USB HID interface with no endpoints successfully passes probe() by
bypassing the config probe, does returning early here during removal entire=
ly
bypass hid_hw_close() and hid_hw_stop(), leading to unbalanced HID core
reference counts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788096666.gi=
t.mradityadash@gmail.com?part=3D4
