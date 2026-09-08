Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1F3A453A
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898858; cv=none; b=VdjaOTeuq5GhWnNRPUiSdXfeWFebXpDPzk8ZJ2Bkih5CUY6XQ21eOS4MeGaV8WSnRuaVTHmHQeaT2jNd34hKwRtysKWoH5aPRhBSozlYYgWHahe9wm8OOs1rABh/ELkCZlU7dUN/SrIy3TN9BQbcnvSRDkV24aZde9sLYJJYeFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898858; c=relaxed/simple;
	bh=mCMALLQ3vGFhIeJLPowS1Osd2WpRBQN2Yx3aftX2k5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/dWfcvQgs8MdumOp6RtYvWoO1wEaCPtFFQmCBFzbI6qqFjq9DpeC1E+BkmGik0ei83uz/gcY6pbcz3QmdZuOKOklmWFB0zib3YlCoo1cN5cJRTgHhvviYCxIuJZruRFCgwGaoSPfyju9HiFrqSyGjmVdPIbY06MLd3wpPAtM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tka8awqV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tka8awqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698371F00A3A;
	Tue,  8 Sep 2026 20:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788898856;
	bh=2H0TbvRIe9rDag1qIMz2ewV5uckDhQXGJplzUmJIdbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tka8awqVp0dJ05ev1S0ulY3oF8STqNg4qCiKpzHptaEj5MpOFWX4TM1aO6TmBwePh
	 OTcXaOiGc/q/EKWxkDbHYf7rabGTEABK/6vz8X3GuDETfLn93MwYGfNFrR9LNMP0i2
	 yxeragAzsAk8FrZDoVoZyGyKHYrzS8Tn6WtD/04CzSoKeFztpbRh4CpAiPwlbk5g7L
	 /8uXvDCkXftrcdEoAiHFyIGhYi7yI/H3f85dy0ihyQdv370CpOdlsSZ+ByVhhi5BY5
	 5kbP4jynLP/Lf9ydyiSkYr/U7jlnh5wMxp8rp6Yb6y+4ULTex+LJbv8eVBWAoLrbm7
	 laRqp0lvBMGhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: core: Avoid leaking field ordering on repeated
 connect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nazarii Tupitsa" <nazarii.tupitsa@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908200655.139098-1-nazarii.tupitsa@gmail.com>
References: <20260908200655.139098-1-nazarii.tupitsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:20:55 +0000
Message-Id: <20260908202056.698371F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Cross-interface Use-After-Free / NULL pointer dereference in wacom=
_wireless_work().
- [Medium] Memory leak of bpf.device_data in hid_connect() error path.
--

commit adb3570e35e55b2d9bb649e1af25cf6ef4c95c01
Author: Nazarii Tupitsa <nazarii.tupitsa@gmail.com>

HID: core: Avoid leaking field ordering on repeated connect

hid_connect() builds report->field_entries for every input report. Some
drivers stop and restart the same parsed HID device. Wacom wireless does
this when the connected tablet changes. Each subsequent hid_connect()
overwrites field_entries and leaks the previous allocation.

[ ... ]

>     A representative kmemleak entry was:
>    =20
>       unreferenced object (size 512):
>         backtrace:
>           __kmalloc_noprof
>           hid_connect
>           hid_hw_start
>           wacom_parse_and_register [wacom]
>           wacom_wireless_work [wacom]

[Severity: High]
This is a pre-existing issue, but can wacom_wireless_work() cause a
use-after-free or NULL pointer dereference when accessing sibling interface=
s?

It accesses sibling USB interfaces directly without holding any locks or ta=
king
reference counts:

drivers/hid/wacom_sys.c:wacom_wireless_work() {
    ...
	/* Stylus interface */
	hdev1 =3D usb_get_intfdata(usbdev->config->interface[1]);
	wacom1 =3D hid_get_drvdata(hdev1);
	wacom_wac1 =3D &(wacom1->wacom_wac);
	wacom_release_resources(wacom1);
    ...
}

If the sibling interface is concurrently unbound (e.g. by userspace unbindi=
ng
the driver from interface 1 via sysfs, or during a race in hot-unplug),
usbhid_disconnect() destroys the hid_device and clears the intfdata.

Would wacom_wireless_work() then read a NULL pointer (causing a crash in
hid_get_drvdata()) or dereference a freed hid_device or wacom structure?

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a3ff0514f9cdf..9f4ba5f60adca 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c

[Severity: Medium]
This isn't a bug introduced by this patch, but does the error path in
hid_connect() leak the dynamically allocated hdev->bpf.device_data?

In hid_connect(), hid_bpf_connect_device() is called first, which successfu=
lly
allocates hdev->bpf.device_data.

If the device has no listeners, hid_connect() returns -ENODEV without calli=
ng
hid_bpf_disconnect_device():

drivers/hid/hid-core.c:hid_connect() {
    ...
	if (!hdev->claimed && !hdev->driver->raw_event) {
		hid_err(hdev, "device has no listeners, quitting\n");
		return -ENODEV;
	}
    ...
}

The caller hid_hw_start() stops the LL driver and propagates the error,
preventing the execution of hid_hw_stop() (which normally triggers
hid_disconnect() and frees the BPF data).

Ultimately, when the device is unbound, hid_destroy_device() calls
hid_bpf_destroy_device(), which does not free bpf.device_data.

Could this leave the bpf.device_data memory permanently leaked on device
probe failures for unclaimed devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908200655.1390=
98-1-nazarii.tupitsa@gmail.com?part=3D1
