Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C33F9FB
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929021; cv=none; b=Bc20VPtfzm87dErGXYsXvw6MS2IjpTAsqkuq1daB6m36QL/j37/4RcDilAa7vZz1dfyJ2jGowD6DnCUSEm1E0+18ZwDLl+rkGnkOzFaT87sm29mOrPxd7ByGwh0DHfuQzzkcbU6+6YPBzr9S6pwqrG7aEqH8Dz/wKg+ECm0q2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929021; c=relaxed/simple;
	bh=ScrP8Pe2AqhO1UpbTgwC1vcVPaIMkL4RDyn22ew6oxE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EFJEUG1yE+E+7sVpGPvtbSL4vXIapWY2t+GqO6g9TPlHDnRIvhUH0aj2jA/t2n/x5sBnWwUHhVgxJFe0EiBZnzKMri/DtL3Gqf3cHbyvL1Nmn5yjLDGW8SX594plQGR52IiiLKcMNTwNmXxGEbIvD3A9KrzfeiJCxcCdZiSiKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLtvp/oW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLtvp/oW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3D91F00A3A;
	Thu, 28 May 2026 00:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779929020;
	bh=SJYieYMbyJ7outbkFFkY72afxqI1RDU9d2+AwsmfhZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RLtvp/oWTLQUZioyedN1ja7lBXzwmJ2vm2BH0Zban33UYqI/WWL4fogck4r+RP4IK
	 I/SilYz0SOWFhhQR9LZPTFY9xqy9Yku4FakgfgDSw+PNsp/YUhC7UtapYu90tJHuQD
	 K9GyJxZr0rtzuMXoDsoXWehRI4fW8UcHxfTzKxA76WWRkfUadmtftCX5RxSfOCoxrc
	 jtFJ1+HNqOy2HWdzYeFX9iwtMPhuti7oWi+sRp3JemqlmKzY0K3vsm/lNk9955SHW3
	 Uaf5esnJwFROZyYN/clfKBXt0+aX+/T8n/bEsnzXLtH+169tIk3mutPbT+MMSW+zTP
	 ejKvJ7nYXe5oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260527222122.10620-5-derekjohn.clark@gmail.com>
References: <20260527222122.10620-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 00:43:39 +0000
Message-Id: <20260528004340.2C3D91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Missing functional implementation for rumble intensity feature.

Pre-existing issues:
- [High] Race condition during device teardown leading to Use-After-Free of=
 drvdata.
--

commit 902919289c1cf51c111590532df6640b717c3236
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add Rumble Intensity Attributes

Adds intensity adjustment for the left and right rumble motors. The patch=20
introduces the data structures and driver variables for this feature.

>     Claude was used during the reverse-engineering data gathering for this
>     feature done by Zhouwang Huang. As the code had already been affected,
>     I used Claude to create the initial framing for the feature, then did
>     manual cleanup of the _show and _store functions afterwards to fix bu=
gs
>     and keep the coding style consistent. Claude was also used as an init=
ial
>     reviewer of this patch.

[Severity: Medium]
Are the _show and _store functions missing from this patch?

The commit message mentions manual cleanup of these functions, but the diff
only introduces the data structures (like struct claw_rumble_report and
rumble_addr) without any sysfs attributes or functional implementation.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 96710d80543d4..17b0707ecd46d 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -332,8 +343,12 @@ struct claw_drvdata {
>  	enum claw_gamepad_mode_index gamepad_mode;
>  	u8 m1_codes[CLAW_KEYS_MAX];
>  	u8 m2_codes[CLAW_KEYS_MAX];
> -	spinlock_t mode_lock; /* Lock for mode data read/write */
> +	u8 rumble_intensity_right;
> +	u8 rumble_intensity_left;
>  	const u16 *bmap_addr;
> +	spinlock_t rumble_lock; /* lock for rumble_intensity read/write */
> +	spinlock_t mode_lock; /* Lock for mode data read/write */

[Severity: High]
This is a pre-existing issue, but can the device teardown in claw_remove()
cause a use-after-free of this drvdata structure?

In claw_remove(), cancel_delayed_work_sync(&drvdata->rgb_queue) is called
before led_classdev_multicolor_unregister(&drvdata->led_mc).

If a concurrent sysfs write triggers claw_led_brightness_set(), it checks
rgb_registered under a lock but calls mod_delayed_work() after unlocking.

If preempted between these steps, claw_remove() could set the flag to false,
cancel the workqueue, and then block in led_classdev_multicolor_unregister()
waiting for the sysfs operation to finish:

CPU1                                CPU2
claw_led_brightness_set()
  scoped_guard(...) {
    if (!smp_load_acquire(...))
      return;
  }
  // preempted

                                    claw_remove()
                                      smp_store_release(..., false);
                                      cancel_delayed_work_sync(...);
                                      led_classdev_multicolor_unregister(..=
.);
                                      // blocks waiting for CPU1

  mod_delayed_work(...);
  // finishes, CPU2 unblocks

                                      hid_hw_close(hdev);
                                      // drvdata is freed

When the sysfs thread resumes, it schedules the delayed work on the freed
drvdata.

Should the LED subsystem be unregistered before cancelling the associated
workqueues to flush active sysfs writes?

> +	bool rumble_support;
>  	bool gp_registered;
>  	bool bmap_support;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527222122.1062=
0-1-derekjohn.clark@gmail.com?part=3D4
