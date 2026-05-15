Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAE3CB918
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 04:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819541; cv=none; b=MEvx4Pw1p248KuKo3b6gxjYAJa7p0VLc/rjiAePtEgguavKRhklgSPoVvB1tNV+lNdUqkTBPlVnXUfOQCmmIJGq866+ecsfN+Pw7pnF2dyv8HXTjIHi/ViJ1jsIiyF9KEAprPpuldVM9Iv7sWJQQ6jh0Yj2Vy7e+to46ZN47eEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819541; c=relaxed/simple;
	bh=gFpIhdbamtJqtigk68eOBz86I+a8hh05iqkyq9o1uHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bDd7hlGECrz5zA0enPtgZmtP5qi88HoL5GpGOJPzVZnEgkh5HpeuxuaHGW7hcIv7UeEJgA9zFsSejUnYSE9NoT2gyvtv0JG5bglD/enWLxmmw3YWyAiifhJVVgceOcBJXV8qw9FkkdMyTCPaW68piTYo3W8wrTTeiCzZcnGC4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss8VhDTE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss8VhDTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA3DC2BCB0;
	Fri, 15 May 2026 04:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778819541;
	bh=gFpIhdbamtJqtigk68eOBz86I+a8hh05iqkyq9o1uHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ss8VhDTECfUINRcB44iy0A7NzyosdPLeT/mcNeEW5WCRez7qs5AyV9tLRvAd7kvse
	 RyVqNvWVi15dDEDPnqe6lc/kjWRQsDhdreyG0A6gM5ca8WcxKcwUqHwt3IKheX6PPB
	 8XqBIMWshDfKJGnRtRlkRpWKNzhX77x8FEOA5ghkWD/Vj3lAqDAuI+epT1GbZ0qgb6
	 C5Wfja54ixDce2R+L8MbyKsUJYCjOoFoYdvKFjosWFR70/cUx9EqilImcKHealBRwV
	 1RtNB1/hqGcLHF2CibxGXMYppUL4FTgVD+ngBCizBvVAybvH0vBnGAhkU7IZz8VDZG
	 Vq1z7dhERKvpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260515033622.2095277-3-derekjohn.clark@gmail.com>
References: <20260515033622.2095277-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 04:32:20 +0000
Message-Id: <20260515043220.CEA3DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Unsynchronized state machine and shared completions cause data cor=
ruption and races.
- [High] Blind cast of parent device to `usb_interface` causes a kernel pan=
ic via uhid.
- [High] 8ms timeout for hardware operations is dangerously short and will =
cause spurious failures.
- [Medium] Mixing goto-based cleanup with `scoped_guard` violates cleanup s=
ubsystem guidelines.
- [Medium] Unbounded kernel log spam on unsolicited device events.
--

commit f6e1e19ecedd5b80861e87d4606aa90bac28941a
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes

Adds attributes that allow for remapping the M-keys with up to 5 values
when in macro mode.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 89bb32f00bfc3..6ccb9666daedf 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
> @@ -125,6 +294,31 @@ static int claw_gamepad_mode_event(struct claw_drvda=
ta *drvdata,
[ ... ]
> +static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_=
command_report *cmd_rep)
> +{
> +	u8 *codes;
> +	int i;
> +
> +	switch (drvdata->profile_pending) {
> +	case CLAW_M1_PENDING:
> +	case CLAW_M2_PENDING:
> +		codes =3D (drvdata->profile_pending =3D=3D CLAW_M1_PENDING) ?

Can reading drvdata->profile_pending locklessly here cause data races?

It is modified under profile_mutex in process context (e.g. in
claw_buttons_show), which could allow a delayed response to silently
overwrite the wrong profile's memory buffer if another thread is executing
a new request.

> +			drvdata->m1_codes : drvdata->m2_codes;
> +		/* Extract key codes; replace disabled (0xff) with 0x00, which is (nul=
l) in _show */
> +		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
> +			codes[i] =3D (cmd_rep->data[6 + i] !=3D 0xff) ? cmd_rep->data[6 + i] =
: 0x00;
> +		break;
> +	default:
> +		dev_warn(&drvdata->hdev->dev,
> +			 "Got profile event without changes pending from command: %x\n",
> +			 cmd_rep->cmd);

Could this cause unbounded kernel log spam?

Since HID devices act as untrusted input and can send up to 1000 reports
per second, a malicious or malfunctioning device could flood the system
and cause a local denial of service via excessive logging. Should this
use dev_warn_ratelimited() or silently drop unsolicited packets?

> +		return -EINVAL;
> +	}
> +	drvdata->profile_pending =3D CLAW_NO_PENDING;
> +
> +	return 0;
> +}
> +
>  static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_repor=
t *report,
>  			  u8 *data, int size)
>  {
> @@ -364,6 +561,163 @@ static ssize_t reset_store(struct device *dev, stru=
ct device_attribute *attr,
[ ... ]
> +static int claw_buttons_store(struct device *dev, const char *buf, u8 mk=
ey_idx)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	u8 data[] =3D { 0x01, (drvdata->bmap_addr[mkey_idx] >> 8) & 0xff,
> +		      drvdata->bmap_addr[mkey_idx] & 0xff, 0x07,
> +		      0x04, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff };
> +	size_t len =3D ARRAY_SIZE(data);
> +	int ret, key_count, i;
> +	char **raw_keys;
> +
> +	raw_keys =3D argv_split(GFP_KERNEL, buf, &key_count);
> +	if (!raw_keys)
> +		return -ENOMEM;
> +
> +	if (key_count > CLAW_KEYS_MAX) {
> +		ret =3D -EINVAL;
> +		goto err_free;
> +	}
> +
> +	if (key_count =3D=3D 0)
> +		goto set_buttons;
> +
> +	for (i =3D 0; i < key_count; i++) {
> +		ret =3D button_mapping_name_to_code(raw_keys[i]);
> +		if (ret < 0)
> +			goto err_free;
> +
> +		data[6 + i] =3D ret;
> +	}
> +
> +set_buttons:
> +	scoped_guard(mutex, &drvdata->rom_mutex) {
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DA=
TA,
> +					    data, len, 8);

Are these 8ms timeouts dangerously short?

On kernel configurations where HZ=3D100, msecs_to_jiffies(8) yields 1 jiffy=
. A
1-jiffy timeout can expire almost immediately depending on the timing of the
next timer tick. Will this falsely abort the wait and return -EBUSY before
the hardware has time to process the USB HID request?

> +		if (ret < 0)
> +			goto err_free;
> +
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NUL=
L, 0, 8);
> +	}
> +
> +err_free:

Does mixing goto-based cleanup labels with scoped_guard violate the cleanup
subsystem guidelines?

The kernel guidelines explicitly forbid mixing goto-based cleanups with
scope-based cleanups in the same function, as it creates confusing ownership
semantics and can lead to LIFO ordering bugs.

> +	argv_free(raw_keys);
> +	return ret;
> +}
> +
> +static int claw_buttons_show(struct device *dev, char *buf, enum claw_ke=
y_index m_key)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	u8 data[] =3D { 0x01, (drvdata->bmap_addr[m_key] >> 8) & 0xff,
> +		      drvdata->bmap_addr[m_key] & 0xff, 0x07 };
> +	size_t len =3D ARRAY_SIZE(data);
> +	int i, ret, count =3D 0;
> +	const char *name;
> +	u8 *codes;
> +
> +	codes =3D (m_key =3D=3D CLAW_KEY_M1) ? drvdata->m1_codes : drvdata->m2_=
codes;
> +
> +	guard(mutex)(&drvdata->profile_mutex);
> +	drvdata->profile_pending =3D (m_key =3D=3D CLAW_KEY_M1) ? CLAW_M1_PENDI=
NG : CLAW_M2_PENDING;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, dat=
a, len, 8);

Because the driver uses a single shared completion (send_cmd_complete) for =
all
hardware responses in claw_raw_event(), could a delayed reply from an
asynchronous command cause the wait_for_completion_interruptible_timeout() =
in
claw_hw_output_report() to return prematurely here?

This could result in uninitialized or stale data being returned to userspac=
e.

> +	if (ret) {
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;
> +		return ret;
> +	}
[ ... ]
> @@ -430,8 +796,31 @@ static void cfg_resume_fn(struct work_struct *work)
[ ... ]
>  static int claw_probe(struct hid_device *hdev, u8 ep)
>  {
> +	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> +	struct usb_device *udev =3D interface_to_usbdev(intf);

Can this blind cast cause a kernel panic?

If a virtual HID device is injected from user-space using the uhid subsystem
with a matching BUS_USB identifier, the parent device is the uhid virtual
device, not a usb_interface. Accessing udev->descriptor.bcdDevice in this c=
ase
would result in an out-of-bounds memory read.

Should this use hid_is_usb(hdev) to verify the transport before executing
USB-specific initialization?

>  	struct claw_drvdata *drvdata;
>  	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515033622.2095=
277-1-derekjohn.clark@gmail.com?part=3D2
