Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758022;
	b=gSMLV0mxAGlRUePTlmX8oBhm7lXCJPmL5lFd70adoFktykatbndAvGZ0h5NZ/xSQJhVe
	 SRYQG4gGBTXYf7A4CRDm+DzUPIIyhp3+tB/OzmfSBdrQYHH/XFu/A/diuH2R65q8Ll2PF
	 U8N38B0kZTLje1hHUhTWMSKnF2Qmtictjydcxa1PBvhhuOl2IvogWjJydM5VCU6k9UaH0
	 LY8sqv09qLEvtHOb85vOwhtSgREy/v8pBCyrpBMFw6Pp/UXWXGeBjCsisg+DdtJgseKQy
	 oXEp6BlMLaEA0gG9Id9s4XPMJvNZLoiT9BwHs6ZpRmJTpeb6Sl5Lu57PdhdgQ4d2qNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dFEKDp8oB+qyU44r4MLIpcm7wWI6obxjKcq3cBFXIZc=;
	b=EdtMCFeXIwMrW5Gi1WRrcMKOwzgpazx8lNHLnL3csutb9PvQ9aDKn5giPoqST+kD+ahM
	 RsisqWWN/+nS2UYda84G+vXb4F7WQ8Oqcubt+7i8rj9iKQyTwF5Hsoot/awE/9tsK73fL
	 fgSHnt1momSYvhWHc4Wr+FrOwXi/fxG/h7q2yFwqfuzdIs6QxQUZAuJBxSeVTv8MA+kZI
	 7ncMsjDFN85Q224g+IfLUSLMcFwuIOoErUg9HlHNUxKSq99bOUkwxI+9gIAHSv8zQ/4Wf
	 tmgkCa/2ZYgSIilGcGwkaLHRius9aZ5UhBCekfSK4ESw+COuFU38wDzB8/JHh+AS/rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgBMOElO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8A606A31B
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgBMOElO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF26A1F000C1;
	Wed,  4 Nov 2026 02:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793758022;
	bh=dFEKDp8oB+qyU44r4MLIpcm7wWI6obxjKcq3cBFXIZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bgBMOElOnSSzDD93zrhG2XBNNvKneuLeWUoiOuxpFJNonws2v2uMgpwL36vbWqe68
	 NG8ZGRwqy0sUv7+WBMn4XDQcz8dN8Cw5t2QlR9DCkhdr/fRT/RogSiUrChU0z0jAXI
	 uJ4I8QVZiTEI9FcjQOLuYG4nO96n6gJAOPoEq0p5iTiXX6jRuQtTCsXrebin4KDKBZ
	 kx7fmQLl1L2hr2A6ee/2xmE3gdYUyCq3M6hxda7PuoKTsskqwHUjZ37CVpqB4w2yL+
	 WtFcUKSepBysp2eie+hQTLoISimYHThy3flXGhfl+KI9z9tCSQvuU/G1Fis2u9iK65
	 VIXv3Y+Iee+JQ==
Message-ID: <sashiko-outbox-196432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/18] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104013935.512713-3-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
 <20261104013935.512713-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:07:01 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] HID: asus: use-after-free of struct ally_intf in asus_resume()
- [Medium] HID: asus: ally_vendor_keys() omits 0x93 (ROG Ally X AC button)
- [Medium] HID: asus: duplicate gamepad input_dev registered due to mapping=
 report 0x0B
- [Medium] HID: asus: ally_dev_get_report() sizes 0x0D read from 0x5A repor=
t length
--

commit 964cb88b58989515f1ea0adc56e4d20719f664a7
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

This commit adds core HID support for ASUS ROG Ally handhelds, including
device ready-state initialization, Ally X gamepad input mapping, vendor
key handling, and Ctrl+Alt+Del sequence filtering.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 46643022b68d0..2a3e8c399f0aa 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -239,12 +285,816 @@ static const struct asus_touchpad_info medion_e123=
9t_tp =3D {

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
> +		    data[1] =3D=3D 0xA7 || data[1] =3D=3D 0xA8;
> +
> +	/* Neither a vendor press nor a release: leave it to the other handlers=
. */
> +	if (!is_vendor && data[1] !=3D 0)
> +		return false;
> +
> +	if (input) {
> +		/* AC short press */
> +		input_report_key(input, KEY_PROG1, data[1] =3D=3D 0x38);
> +
> +		/* CC short press & release */
> +		input_report_key(input, KEY_F16,   data[1] =3D=3D 0xA6);
> +
> +		/* AC long press */
> +		input_report_key(input, KEY_F17,   data[1] =3D=3D 0xA7);
> +
> +		/* AC long release */
> +		input_report_key(input, KEY_F18,   data[1] =3D=3D 0xA8);
> +
> +		input_sync(input);
> +	}
> +
> +	/*
> +	 * Only the vendor codes are consumed. They are reported on this
> +	 * interface's evdev above, so hid-core never sees them pressed. Note
> +	 * that 0xA8 ("AC long release") is itself a usage the firmware sends,
> +	 * not the report that clears one. Everything else, including the 0x00
> +	 * report that clears a held usage, must still reach hid-core: it can
> +	 * only release the usages it saw pressed if it sees the report that
> +	 * clears them.
> +	 */
> +	return is_vendor;
> +}

[Severity: Medium]
Should ally_vendor_keys() also check for 0x93 when handling KEY_PROG1?

Later in asus_input_mapping(), this patch maps usage 0x93 to KEY_PROG1 as
the ROG Ally X AC button:

    case 0x38: asus_map_key_clear(KEY_PROG1); break; /* ROG key */
    case 0x93: asus_map_key_clear(KEY_PROG1); break; /* ROG Ally X AC butto=
n */

Because ally_vendor_keys() only checks data[1] against 0x38, 0xA6, 0xA7,
and 0xA8, a report with data[1] =3D=3D 0x93 on the ROG Ally X returns false
and falls through to hid-core, which records 0x93 in field->value[0] and
reports KEY_PROG1 =3D 1.

If the release report (data[1] =3D=3D 0x00) is missed across suspend/resume
(where ally_resume_work_fn() -> ally_release_vendor_keys() clears
KEY_PROG1 directly on intf->input without clearing hid-core's
field->value[]), or if the firmware transitions from 0x93 to 0xA7 (AC
long press, which ally_vendor_keys() consumes while reporting
KEY_PROG1 =3D 0), field->value[0] in hid-core will retain 0x93 while
intf->input has KEY_PROG1 released. Wouldn't hid-core then ignore the
next 0x93 press because 0x93 is still present in field->value[]?

[ ... ]

> +static int ally_dev_set_report(struct hid_device *hdev, const u8 *buf, s=
ize_t len)
> +{
> +	return asus_kbd_set_report(hdev, buf, len);
> +}
> +
> +static int ally_dev_get_report(struct hid_device *hdev, u8 *out, size_t =
len)
> +{
> +	return hid_hw_raw_request(hdev, HID_ALLY_GET_REPORT_ID, out, len,
> +				  HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +}
> +
> +/**
> + * ally_gamepad_send_packet() - Send a raw packet to the gamepad device
> + * @hdev: HID device
> + * @buf: buffer containing the packet data
> + * @len: length of data to send
> + *
> + * Return: count of data transferred, negative if error.
> + */
> +static int ally_gamepad_send_packet(struct hid_device *hdev, const u8 *b=
uf, size_t len)
> +{
> +	return ally_dev_set_report(hdev, buf, len);
> +}
> +
> +/**
> + * ally_gamepad_send_receive_packet() - Send a packet and receive the re=
sponse
> + * @hdev: HID device
> + * @buf: buffer containing the packet data to send and receive response =
in
> + * @len: length of buffer
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int ally_gamepad_send_receive_packet(struct hid_device *hdev,
> +					    u8 *buf, size_t len)
> +{
> +	int ret;
> +
> +	ret =3D ally_dev_set_report(hdev, buf, len);
> +	if (ret >=3D 0) {
> +		memset(buf, 0, len);
> +		ret =3D ally_dev_get_report(hdev, buf, len);
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
As reported by Sashiko on v11 [1], ally_alloc_cmd() sizes the buffer from
FEATURE_KBD_REPORT_ID (0x5A) via asus_report_len(), and
ally_gamepad_send_receive_packet() passes that length to
ally_dev_get_report() to read HID_ALLY_GET_REPORT_ID (0x0D).

Since asus_kbd_get_report() was moved just above ally_dev_set_report(),
should ally_dev_get_report() call asus_kbd_get_report(hdev,
HID_ALLY_GET_REPORT_ID, out, len) instead of calling hid_hw_raw_request()
directly? That would both size the GET_REPORT transfer from report 0x0D's
descriptor entry and return 0 on success as documented in the kernel-doc
for ally_gamepad_send_receive_packet().

[ ... ]

> @@ -512,6 +1363,19 @@ static int asus_raw_event(struct hid_device *hdev,
>  	if (drvdata->quirks & QUIRK_MEDION_E1239T)
>  		return asus_e1239t_event(drvdata, data, size);
> =20
> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +		/*
> +		 * Return -1 to suppress further processing by the generic HID
> +		 * input parser for reports we fully handle. The interface is
> +		 * published with smp_store_release() only after its fields
> +		 * are set. Letting report 0x0B reach the default parser
> +		 * creates a generic gamepad and Steam Input overlaps.
> +		 */
> +		intf =3D smp_load_acquire(&drvdata->ally); /* fields are published */
> +		if (hid_asus_ally_raw_event(hdev, intf, data, size))
> +			return -1;
> +	}

[Severity: Medium]
As reported by Sashiko on v12 [2], does returning -1 in asus_raw_event()
actually prevent hid-core from creating a duplicate generic gamepad input
device for report 0x0B?

During asus_probe(), hid_hw_start(hdev, HID_CONNECT_DEFAULT) runs
hidinput_connect() -> hidinput_configure_usages() -> asus_input_mapping()
before any raw events arrive. Because asus_input_mapping() does not return
-1 for usages in report 0x0B (HID_ALLY_X_INPUT_REPORT), hid-core maps all
of the standard gamepad usages in report 0x0B and registers a generic
gamepad input_dev on that interface in addition to the custom
intf->gamepad device registered by ally_x_setup_input().

Should asus_input_mapping() return -1 when QUIRK_ROG_ALLY_XPAD is set and
field->report->id =3D=3D HID_ALLY_X_INPUT_REPORT so that the duplicate input
device is not created?

[ ... ]

> @@ -1569,6 +2336,8 @@ static int asus_xgm_init(struct hid_device *hdev, s=
truct asus_drvdata *drvdata)
>  static int __maybe_unused asus_resume(struct hid_device *hdev)
>  {
>  	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	/* Published with smp_store_release() after the fields are set. */
> +	struct ally_intf *intf =3D smp_load_acquire(&drvdata->ally);
> =20
>  	/*
>  	 * If we have a backlight listener registered, restore the previous sta=
te,
> @@ -1578,12 +2347,16 @@ static int __maybe_unused asus_resume(struct hid_=
device *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brig=
htness);
> =20
> +	if (intf)
> +		schedule_delayed_work(&intf->resume_work, msecs_to_jiffies(500));
> +
>  	return 0;
>  }

[ ... ]

> @@ -1763,6 +2564,7 @@ static int asus_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
>  static void asus_remove(struct hid_device *hdev)
>  {
>  	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_intf *ally;
> =20
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
> @@ -1770,6 +2572,14 @@ static void asus_remove(struct hid_device *hdev)
>  	if (drvdata->xgm_led)
>  		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
> =20
> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +		ally =3D hid_asus_ally_terminate(drvdata);
> +		asus_worker_stop(drvdata->worker);
> +		hid_hw_stop(hdev);
> +		ally_free(ally);
> +		return;
> +	}

[Severity: High]
As reported by Sashiko on v12 [3], can asus_resume() access freed memory
in intf->resume_work if it races with asus_remove() or the err_stop_hw
path in asus_probe()?

In hid_asus_ally_terminate() -> ally_quiesce(), disable_delayed_work_sync()
marks intf->resume_work disabled in intf->resume_work.work.data so a
concurrent asus_resume() cannot re-queue it, and then ally_free(ally)
frees the struct ally_intf with kfree().

However, if asus_resume() has already loaded the non-NULL drvdata->ally
pointer via smp_load_acquire(&drvdata->ally) before
hid_asus_ally_terminate() clears drvdata->ally, and reaches
schedule_delayed_work(&intf->resume_work, ...) after ally_free(ally) runs,
schedule_delayed_work() will access and modify intf->resume_work.work.data
after intf has been freed. Could intf be allocated with devm_kzalloc() on
&hdev->dev (or freed via kfree_rcu() with RCU read protection in
asus_resume()) so that intf->resume_work remains valid until the driver
is unbound?

[1] https://lore.kernel.org/r/20261025235232.129945-16-denis.benato@linux.d=
ev
[2] https://lore.kernel.org/r/20261031174130.208240-3-denis.benato@linux.dev
[3] https://lore.kernel.org/r/20261031174130.208240-3-denis.benato@linux.dev

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104013935.5127=
13-1-denis.benato@linux.dev?part=3D2
