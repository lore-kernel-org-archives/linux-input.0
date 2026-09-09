Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D60548543
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953506; cv=none; b=Tuu2eIm0LXZBqn0OBWXZVGbFoRuwd50m2ayBw3ip/WOyY9PIlkaBlwaGRPxYtYdg/MeJ2GVfcfRNnOrtRWFGFCzzep9d1+AIRH4m22aw9BpuJ/u/XW8KWGhfrcxZmqC9XlAPqd85BfFZBjbEyEGO/bz6fgDnuMa3xhP4cR+Z2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953506; c=relaxed/simple;
	bh=gwj11CwQ4BByctKNjXE5RutBIBFKQJx3pQCEqmcLA+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lMAGqWrzVEgiwfmvWpraxwyB1KPe0Rclhju3MKaLDglf3F3yyypaWM0JvhTHBxhH3BwiTvUtEjYQVzcGaLTDRzXylI2lVry4hCQ/9DcOgELvBbsqSa6q+B3guntHPoLLNzEfW6cQAn/vV3EtscIpMXX6PxUkNJFbB9wPGEFv2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4h+01aB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4h+01aB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028DA1F00A3E;
	Wed,  9 Sep 2026 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953505;
	bh=HLTJ8/irDR/RTE3H5poGbE84uhafXoC/Bxx2CoQ0OEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E4h+01aBTri0dZxlyORRSBJRwe4cSbiRt2ND2ZWNlBrB1P+8HYsIK/i2JKMwCMhWv
	 i1bbbSmV16/sQvKUKePwiCp5n4VXg5Hy3rQXKLSxQiVxAqbBAArG4w01pFhy9eBrbd
	 f1/zz9p2DTrp+i+GtTp4IkOMee56cLEy+g7M1cioPllSktBOTN5wT94YRqUAUDiQAb
	 i5uPshbN3yprV5tEqtNPtYk0KLKp1wZfSXbt4f6zjbvMfrcMR1WyKJ8CVqccjy11w3
	 5hHQFjXMgWVL8vWkXplAi9gqYNdfpAwe6j/zZMC4cmAZvo+wL6Rwa5wGGmwLzspJLw
	 GozKaZkvw+rWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/5] HID: wacom: Use hdev->product in
 wacom_setup_touch_input_capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:31:44 +0000
Message-Id: <20260909113145.028DA1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing cancellation of asynchronous works and timers in the p=
robe error path leads to use-after-free.
--

commit ca8b53c76679ad840d06b68ac883d22ba58fe317
Author: Lee Jones <lee@kernel.org>
Subject: HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilit=
ies

This commit replaces lookup-dependent touch product references with
hdev->product inside wacom_setup_touch_input_capabilities(). This
simplifies the code since hdev is already available via container_of
and represents the touch device itself.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 8feb8027be95e..7cf2b4de52be7 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
[ ... ]

While reviewing the wacom driver lifecycle, I noticed a potential issue in
a related file during the probe error path:

drivers/hid/wacom_sys.c:wacom_parse_and_register() {
        ...
        if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
                error =3D hid_hw_open(hdev);
                if (error) {
                        hid_err(hdev, "hw open failed\n");
                        goto fail_hw_stop;
                }
        }
        ...
fail_hw_stop:
        hid_hw_stop(hdev);
fail:
        wacom_release_resources(wacom);
        return error;
}

[Severity: Critical]
This is a pre-existing issue, but does this error path leave asynchronous
works and timers running after freeing the wacom structure?

The driver allocates the wacom structure using devm_kzalloc(). If an
initialization step fails after hid_hw_start() is called, such as
hid_hw_open() failing, the code jumps to the fail_hw_stop label.

While hid_hw_stop() is called, it appears to omit cancelling other
asynchronous resources like wireless_work, battery_work, remote_work,
mode_change_work, aes_battery_work, and idleprox_timer.

Since hid_hw_start() enables hardware interrupts, an incoming interrupt can
trigger wacom_raw_event() -> wacom_wac_irq() -> wacom_schedule_work(),
which queues these works.

If the probe function returns an error, devres will automatically free the
wacom structure. Could an untrusted device triggering rapid reports cause
these pending works to execute later and dereference the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/fa3cb42f7b58c1b3022=
d8208969a81882783a5ec.1788868602.git.lee@kernel.org?part=3D1
