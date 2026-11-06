Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976709;
	b=Gd5dLWutlA5cSBFWI1FpwqPL8oo1PTzT5R75tNNAhKLjAr296NgrmW5ytkm4BJQlJbig
	 uiFerdher9K0EBp/+T8cnAmpz7ebNmYK0V+xlrHwru/+CSGRzOtNtdDoa65wDUlNd79ki
	 +1dQuXL4mgznF68Vz1WIgPJ972mjEUmsSFnlgIhsUCKO/tyWwzK2IubgNYYYn7Ci6fnYT
	 qkeGoQr32Wm9B7arPwvrt4t/1903TGNHLzm4rsXLMIcsC0x7NtR37OKjiis0c2fv/6uXh
	 MGUKo+ZxTDCajWsL9OZcSjhp6QPF0vXM3854B6dCMg/TUccAglj38Y7FJSQEFMHDCRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976709;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HSabH8l+HxqXtjZszEgQDErZ45j79Lt8wkMPSeieqbE=;
	b=Az2TzazK0yCWTwDM6+CAcgP266TvXxqLJjPONJ9yzpt5THehj/2OJ+qcyO3Dg1hJaK/o
	 a7MU7DJXnUJSdXHUnPzeffo4DbW7Xp4pqY80npGOVJ1X9tmOBTLcYOS11wrLMhFYnAFDk
	 9gr0crI3ErZXTKy88tgJEdGPVYvyD+GRwY/FTQfBiyy3noQlu2rVFFjSu1LlB/oZw62XM
	 8B9YXY9vjRqxuy8EbCMGqb/OEVC+Pf1qbQbsDVoXuTZ3/tmvfh1OW2mh/uDQ1Xlhs6Ht8
	 gDZW6B+3QENoKLF8H9ykJQTtbCZEGifrTe5Cn4VtQNjizalCcyeTQumTysutv6VHtVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqTT7Jtw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D2606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqTT7Jtw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31FD1F008A5;
	Fri,  6 Nov 2026 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976709;
	bh=HSabH8l+HxqXtjZszEgQDErZ45j79Lt8wkMPSeieqbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eqTT7JtwcUIK6s03nG0WSjURpgHpsm8FbFumzg5/XGxOXrdKsTwC8ynIwN7sZOvET
	 YyTWGrna9MB87y3Qn50G1PwGNdOc/N9RqkocjCgzmdj3tl+XV8aMuiovpelMPuPh81
	 NaLPZPILpI38BsJZBEn3EHEFjkaI9GJm89sOlKcnSxXLzFkJ6paXdgq7WYFs+JRrFy
	 bCTTogFpkH1tZRsK+djzvf7jWWASfUyHxLai7pZh4/y62sLZQs4rD/81IP1HQIVNU8
	 zYz+UDTTShm1fkRMTPBBFgzZn9EOWPRIBdPviVFepLgndeq6H2+w360MBGmB45gzR6
	 UFgOKQln4ZIsA==
Message-ID: <sashiko-outbox-201620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/18] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261106142334.1881-3-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
 <20261106142334.1881-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:51:48 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] HID: asus: duplicate KEY_PROG1 report in ally_vendor_keys()
  clobbers press
- [Medium] HID: asus: unignored report 0x0B in asus_input_mapping()
  duplicates gamepad
- [Medium] HID: asus: wrong report type and interface for FF off in
  hid_asus_ally_init()
- [Low] HID: asus: missing __rcu annotation on drvdata->ally pointer
--

commit 1bb5ac5d2f0b1934ac4c2fed917f199e9d5f52d6
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

This commit adds per-interface ROG Ally and ROG Ally X handheld support to
hid-asus, including MCU readiness checks, vendor key handling, Ctrl+Alt+Del
long-press translation, and a dedicated gamepad input device for Ally X
input report 0x0B.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 46643022b68d0..ae596a8475718 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -129,121 +164,964 @@ struct asus_work_action {
[ ... ]
> +struct asus_drvdata {
> +	unsigned long quirks;
> +	struct hid_device *hdev;
> +	struct input_dev *input;
> +	struct input_dev *tp_kbd_input;
> +	struct asus_worker *worker;
> +	unsigned int kbd_backlight_brightness;
> +	struct ally_intf *ally;

[Severity: Low]
Should drvdata->ally be annotated with __rcu?  Every access to it uses
rcu_dereference(), rcu_dereference_protected(), rcu_access_pointer(), or
rcu_assign_pointer(), which triggers Sparse address-space warnings without
the __rcu qualifier.

[ ... ]

> +static bool ally_vendor_keys(struct input_dev *input, const u8 *data, in=
t size)
> +{
> +	bool is_vendor;
> +
> +	if (size < 2 || data[0] !=3D FEATURE_KBD_REPORT_ID)
> +		return false;
> +
> +	is_vendor =3D data[1] =3D=3D 0x38 || data[1] =3D=3D 0xA6 ||
> +		    data[1] =3D=3D 0xA7 || data[1] =3D=3D 0xA8 ||
> +		    data[1] =3D=3D 0x93;
> +
> +	/* Neither a vendor press nor a release: leave it to the other handlers=
. */
> +	if (!is_vendor && data[1] !=3D 0)
> +		return false;
> +
> +	if (input) {
> +		/* AC short press (ROG Ally) */
> +		input_report_key(input, KEY_PROG1, data[1] =3D=3D 0x38);
> +
> +		/* AC short release (ROG Ally X) */
> +		input_report_key(input, KEY_PROG1, data[1] =3D=3D 0x93);

[Severity: Medium]
Does the second input_report_key(input, KEY_PROG1, ...) call clobber the
first one when data[1] =3D=3D 0x38?

On the original ROG Ally, pressing the AC button sends data[1] =3D=3D 0x38.
The first call reports KEY_PROG1 as pressed (1), and the second call
immediately reports KEY_PROG1 as released (0) before input_sync(), so the
key cannot be held down and the subsequent 0x00 release report becomes a
no-op.  Combining both checks into a single call:

	input_report_key(input, KEY_PROG1, data[1] =3D=3D 0x38 || data[1] =3D=3D 0=
x93);

avoids overwriting the state.

[ ... ]

> +static int hid_asus_ally_init(struct hid_device *hdev)
> +{
> +	int ret;
> +
> +	/* Failure at this point is non-critical. The packet goes to this inter=
face. */
> +	ret =3D ally_gamepad_send_packet(hdev, ally_force_feedback_off,
> +				       sizeof(ally_force_feedback_off));
> +	if (ret < 0)
> +		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> +
> +	return 0;
> +}

[Severity: Medium]
Does hid_asus_ally_init() send ally_force_feedback_off with the wrong
report type and on the wrong USB interface?

ally_force_feedback_off has report ID 0x0D, which is an output report on
the gamepad interface (endpoint 0x87, HID_ALLY_X_INTF_IN), as later modeled
in commit "HID: asus: add support to force feedback".  Here,
hid_asus_ally_init() runs on the configuration interface (endpoint 0x83,
HID_ALLY_INTF_CFG_IN) and calls ally_gamepad_send_packet() ->
asus_kbd_set_report(), which looks up buf[0] (0x0D) as a feature report in
hdev->report_enum[HID_FEATURE_REPORT].  When endpoint 0x83 does not declare
feature report 0x0D, asus_kbd_set_report() returns -EINVAL and logs an
error on every probe and reset_resume.

[ ... ]

> @@ -512,6 +1392,25 @@ static int asus_raw_event(struct hid_device *hdev,
>  	if (drvdata->quirks & QUIRK_MEDION_E1239T)
>  		return asus_e1239t_event(drvdata, data, size);
> =20
> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +		/*
> +		 * Return -1 to suppress further processing by the generic HID
> +		 * input parser for reports we fully handle. The interface is
> +		 * published with rcu_assign_pointer() only after its fields
> +		 * are set, and is kept alive by the RCU read-side lock even
> +		 * if it races with the teardown in asus_remove(). Letting
> +		 * report 0x0B reach the default parser creates a generic
> +		 * gamepad and Steam Input overlaps.
> +		 */
> +		rcu_read_lock();
> +		intf =3D rcu_dereference(drvdata->ally); /* fields are published */
> +		stop_parsing =3D hid_asus_ally_raw_event(hdev, intf, data, size);
> +		rcu_read_unlock();
> +
> +		if (stop_parsing)
> +			return -1;
> +	}

[Severity: Medium]
Does suppressing report 0x0B (HID_ALLY_X_INPUT_REPORT) only in
asus_raw_event() still leave a duplicate generic gamepad input device
registered on the Ally X?

Returning -1 from asus_raw_event() drops runtime packets after
drvdata->ally is published, but hid_hw_start(hdev, HID_CONNECT_DEFAULT)
has already run hidinput_connect() -> asus_input_mapping() before
hid_asus_ally_probe().  Because asus_input_mapping() does not return -1 for
field->report->id =3D=3D HID_ALLY_X_INPUT_REPORT when QUIRK_ROG_ALLY_XPAD is
set, hid-input maps all of report 0x0B's gamepad usages onto the generic
hidinput->input device in addition to the dedicated intf->gamepad device
registered by ally_x_setup_input().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106142334.1881=
-1-denis.benato@linux.dev?part=3D2
