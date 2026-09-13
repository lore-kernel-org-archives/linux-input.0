Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E921ABC9
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311007; cv=none; b=Nsm+rO5yXiMzFH2wcrUXPbZYYGQXmjQZ0Gal50wbm5TL4TZW2TPAUTdJtJA6g7bP7lzxiQauDGW07J0Mr+V4nxJ6dMMW+tQUH059kj4Y0U6B+Lvk2XQ8fPwf38xMgAib2a2OpRPdIN8qaBcc97Hw/ka0veE/1m0b7CZYazdx4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311007; c=relaxed/simple;
	bh=L5BMBgSAUHSLyRpHF7qlWPvh5NbVSyy2j6kfFv0hZzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=otG5FBTYfDc3yjG4rU8tKSRUHymVLJto8i0Pdxq1oIr3V4icV971gf4aPjsgnvQHg3/wrH4Hog9woxJ1iK9Y8ACaPSokF+XKxoLr/e5VU5LrwBfeZ7R/pi1SYiTAmNem6exUunIf4Y2fMtFRMr8VLm30qPDCeRiPEkTU6K9DRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PICfDp37; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PICfDp37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C831F00893;
	Sun, 13 Sep 2026 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789311003;
	bh=H5IYVlQaMF8DFpnz9wroawfxKcX+AAfEWi9rusEv6r4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PICfDp37skEzw6r9RgbzVyb+VPC5/UDSPGpRlXL0uNdau0XsczwEAM2WLWsKbh9b6
	 Npou2t8faV9sgWJqDiXA3aUa/uUmLnnTxE8IMP0g6cL8Hqh5RkrPYF5WLVtk7pifxb
	 9go0uN239WaSSWqiEQO6+yZDycrGwflnGBgONbQ5pqn4EchjkcgKHtu2iO6bbZNF+U
	 PsA/6enhB3YnyVgqdnFbORt4Wqsg5TnXmKmc3l15E5996TEkaxvfn9PAWl7APW7iup
	 2itQA7lzGWWQXHejNAozA2IECtcnV2Vl1i+qR4j7ImwhtyH8Q8+62aaE8qUco2KDv6
	 Q484Gk39BmGtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: winwing: remove unpaired hid_hw_close()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260913143909.1589019-1-lgs201920130244@gmail.com>
References: <20260913143909.1589019-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 14:50:03 +0000
Message-Id: <20260913145003.A5C831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of driver data via the rumble workqueue due to inco=
rrect cleanup order in `winwing_remove()`.
- [High] The `lights_lock` mutex in `struct winwing_drv_data` is never expl=
icitly initialized.
- [High] Memory leak and `led_classdev` list corruption if `winwing_input_c=
onfigured` is called for multiple input devices.
--

commit 375f4f6d6b1105352d34b843ee4acf96e3723a66
Author: Guangshuo Li <lgs201920130244@gmail.com>
HID: winwing: remove unpaired hid_hw_close()

This commit removes an unpaired hid_hw_close() call in winwing_remove() tha=
t=20
was present without a matching hid_hw_open(). This prevents the underflow of
the hdev->ll_open_count variable.

> diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
> index 9cd25a77999e6..e18728f215aea 100644
> --- a/drivers/hid/hid-winwing.c
> +++ b/drivers/hid/hid-winwing.c
> @@ -388,7 +388,6 @@ static void winwing_remove(struct hid_device *hdev)
>  	if (data)
>  		cancel_work_sync(&data->rumble_work);
> =20
> -	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
>  }

[Severity: High]
This is a pre-existing issue, but does this cleanup order leave a window for
a use-after-free of the driver's private data?

Because hid_hw_stop() unregisters the input device, the device remains acti=
ve
while the rumble work is being cancelled. Could a local user issue an EVIOC=
SFF
ioctl in this narrow window, which schedules the work again?

If so, the remove callback would finish, devres would free the data structu=
re,
and the scheduled work could subsequently execute and access the freed memo=
ry.

Should hid_hw_stop() be called before cancel_work_sync()?

Additionally, looking at the driver initialization path:

drivers/hid/hid-winwing.c:winwing_probe() {
	...
	data =3D devm_kzalloc(&hdev->dev, data_size, GFP_KERNEL);

	if (!data)
		return -ENOMEM;
	...
}

[Severity: High]
This isn't a bug introduced by this patch, but is the lights_lock mutex in
struct winwing_drv_data ever explicitly initialized?

Since data is allocated using devm_kzalloc(), the memory is zero-initialize=
d,
but mutex_init(&data->lights_lock) is never called. When userspace writes to
the LED brightness sysfs file, winwing_led_write() is invoked and acquires
the lock:

drivers/hid/hid-winwing.c:winwing_led_write() {
	...
	mutex_lock(&data->lights_lock);
	...
}

Will locking this uninitialized mutex lead to undefined behavior or a kernel
panic when accessed?

Lastly, examining the input configuration:

drivers/hid/hid-winwing.c:winwing_input_configured() {
	...
	ret =3D winwing_init_led(hdev, hidinput->input);

	if (ret)
		hid_err(hdev, "led init failed\n");

	if (data->has_grip15)
		winwing_init_ff(hdev, hidinput);
	...
}

[Severity: High]
This is a pre-existing issue, but does this unconditionally initialize LEDs
and force feedback capabilities for every input node?

winwing_input_configured() is called by the HID core for each input applica=
tion
exposed by the device. Unconditionally calling winwing_init_led() for each
allocates new buffers and re-registers the same three struct winwing_led
elements.=20

Could re-registering an already-linked led_classdev overwrite its list nodes
and corrupt the LED subsystem's linked lists? Are the devres allocations fr=
om
the earlier calls leaked in this scenario?=20

Should this setup be restricted to only happen for the first input node?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913143909.1589=
019-1-lgs201920130244@gmail.com?part=3D1
