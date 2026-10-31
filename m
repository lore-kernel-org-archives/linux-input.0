Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470274;
	b=uTjgRdC66pahRnLC3k7hR3ht/ltyS0suwGP5xbm4fSJBf6eKEuFNpmkJGPL2hQs51Vjh
	 EoaKdSxZ61o16mB0NUcp/6gJoBDzOberZMRjj436Zv3K6OabeBslbFZM5Nsl5v9zhLvnq
	 8ts78napwY3iTciS3osABih1Dk3X0i9+q8fK4CFpkFuYDxvfS/8BThyPWFv9pfhgZA7Gq
	 g2VZCzWpk3ldh8Iom/3/S+j9ZVt0GbfxmXAO10p5+KhiP2R/7cOfCRMJ/alIPRuSjwzZz
	 fzleSirqpDS/RytM0E40E77zD1pjohaEF4OeoqJLsVVLDxP2hxbckCbYJW42Tis+VHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eK6hG5EkH8UtRjNdWQWauwjtYq3+cYBZTePfgTRXCRA=;
	b=GJlG1O4ZTw19BGhDeCPg/rwG0jsxR5WLy0yuTStUlJM8AdhH9MqwtfE0EblWsanUVI9e
	 YAd8n19fTvupcFTyFg82UO0chz9lkH4IzJKapLVgKLpXujkNTz9lITRkUb1mGCuKWtAFl
	 RZ4iM17GG+DNaMZx8PsVwXpv4xy1V6rr82A1LI/4o2NgmU9GffU192dEp0CiqUbi+nF4Y
	 B+c2K6oDpOReKsJzvxpihFcHxeq3Hy+vAYle2CqXAqHjrxGyRWVtHmp8yyqjxZaUU05z4
	 tdLYNNCA0JDLHA/BHW20mhG/k0il1fi69ocYAk4e1Cpn+box5yuHACiMhDFpw2vZMKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5sLoq8W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5AB606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5sLoq8W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C071F000C1;
	Sat, 31 Oct 2026 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793470274;
	bh=eK6hG5EkH8UtRjNdWQWauwjtYq3+cYBZTePfgTRXCRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l5sLoq8WtbhLqIeWVLeqkvYcUav64L8FjPN0vMAmHex6S3y7UfUpOEQpeZIUE7Iuo
	 mOykAgq3ZFjb6hmccE2wC8HFbcq2hTSxrxsD8aECdaPGeV2b5ADBEyMfYVEtFotLni
	 VNASAiP9yqhlttKSXgTDqhS/pZytsOiyDEAr0YzE2cVlws9WJMjvizwS9hK+lAIUO+
	 LQNrELKXGag+F15GyOy7XQJ6U43gDaVnpmLVDADhDR9aXlClL2IbmMaEm4tzAfFtI0
	 nMvLJPCW5Vt9YsRqzmh7aiFOvphNfQbjOzrJnHIeT8z4ArT/h/tWzPvOEmlzzkYnqP
	 v75rCEYk4c0cA==
Message-ID: <sashiko-outbox-192089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/17] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261031174130.208240-3-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 18:11:13 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] HID: asus: stuck vendor keys in ally_vendor_keys() on button relea=
se
- [High] HID: asus: use-after-free in asus_resume() during ally_intf teardo=
wn
- [High] HID: asus: UAF and lifecycle inversion in ally_quiesce() and ally_=
free()
- [Medium] HID: asus: ally_dev_get_report() sizes 0x0D read from 0x5A repor=
t length
- [Medium] HID: asus: duplicate gamepad input_dev registered due to mapping=
 report 0x0B
- [Low] HID: asus: pre-setting mapped keybits in asus_input_mapping() unmap=
s usages
--

commit 6c3f0919161f970328ba824fb01ea511f2881f2b
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

This commit adds core HID support for ASUS ROG Ally handheld devices,
including device readiness initialization, Ally X gamepad input handling,
vendor button handling, and Ctrl+Alt+Del long-press filtering.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 327bb4ab1a0d6..552d3b25a1d10 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -239,12 +286,761 @@ static const struct asus_touchpad_info medion_e123=
9t_tp =3D {
[ ... ]
> +static void ally_quiesce(struct ally_intf *intf)
> +{
> +	if (!intf)
> +		return;
> +
> +	cancel_delayed_work_sync(&intf->resume_work);
> +}
> +
> +static void ally_free(struct ally_intf *intf)
> +{
> +	if (!intf)
> +		return;
> +
> +	if (intf->gamepad)
> +		input_unregister_device(intf->gamepad);
> +	kfree(intf);
> +}

[Severity: High]
In asus_remove() and the err_stop_hw path of asus_probe(), ally_quiesce() is
called before hid_hw_stop(hdev), while ally_free() is called after
hid_hw_stop(hdev) without clearing drvdata->ally:

	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)
		ally_quiesce(drvdata->ally);

	asus_worker_stop(drvdata->worker);
	hid_hw_stop(hdev);

	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)
		ally_free(drvdata->ally);

Could this teardown sequence cause a use-after-free on intf and intf->input,
as well as invert the hid_hw_open() / hid_hw_close() lifetime relative to
hid_hw_stop()?

First, intf->gamepad is registered with ally_x_input_open() and
ally_x_input_close(), which call hid_hw_open(intf->hdev) and
hid_hw_close(intf->hdev). Because intf->gamepad is only unregistered in
ally_free() after hid_hw_stop(hdev) has already stopped the low-level
transport, an open intf->gamepad device will call hid_hw_close() after
hid_hw_stop(), or userspace can open intf->gamepad and call hid_hw_open()
after hid_hw_stop() has completed.

Second, hid_device_remove() leaves hdev->driver set until after asus_remove=
()
returns, and hid_bus_type does not lock or runtime-resume the parent USB
interface during driver release. If a runtime resume occurs after
ally_quiesce() runs cancel_delayed_work_sync(&intf->resume_work) (for examp=
le
via usbhid_open() -> usb_autopm_get_interface() when intf->gamepad is opene=
d,
or via activity on another interface of the composite USB device),
asus_resume() will still see the non-NULL drvdata->ally pointer and call
schedule_delayed_work(&intf->resume_work, ...). That re-queues resume_work
right before hid_hw_stop() frees intf->input and ally_free() frees intf, or
dereferences intf after kfree(intf).

Should intf->gamepad be unregistered before hid_hw_stop(hdev), and should
resume_work be disabled with disable_delayed_work_sync(&intf->resume_work)
(along with clearing drvdata->ally) before stopping the hardware and freeing
intf?

[ ... ]
> +static bool ally_vendor_keys(struct input_dev *input, const u8 *data, in=
t size)
> +{
> +	if (size < 2 || data[0] !=3D FEATURE_KBD_REPORT_ID)
> +		return false;
> +
> +	if (data[1] !=3D 0x38 && data[1] !=3D 0xA6 && data[1] !=3D 0xA7 &&
> +	    data[1] !=3D 0xA8)
> +		return false;
> +
> +	if (!input)
> +		return true;
> +
> +	input_report_key(input, KEY_PROG1, data[1] =3D=3D 0x38);
> +	input_report_key(input, KEY_F16, data[1] =3D=3D 0xA6);
> +	input_report_key(input, KEY_F17, data[1] =3D=3D 0xA7);
> +	input_report_key(input, KEY_F18, data[1] =3D=3D 0xA8);
> +	input_report_key(input, KEY_F19, data[1] =3D=3D 0x38);
> +	input_sync(input);
> +	return true;
> +}

[Severity: High]
When one of the ROG Ally vendor buttons (0x38, 0xA6, 0xA7, or 0xA8) is
pressed and then released, will the key remain stuck down and autorepeat
indefinitely?

On button press, the device sends report FEATURE_KBD_REPORT_ID (0x5A) with
data[1] set to the button code. ally_vendor_keys() reports the key press on
input and returns true, which causes asus_raw_event() to return -1. Because
asus_raw_event() returns -1, __hid_input_report() returns before
hid_report_raw_event() runs, so hid-core never records the pressed usage in
field->value[0] (and KEY_F19 is not mapped by hid-core at all).

When the button is released, the device sends report 0x5A with
data[1] =3D=3D 0x00. ally_vendor_keys() checks whether data[1] is 0x38, 0xA=
6,
0xA7, or 0xA8, so it returns false on the release report before reaching the
input_report_key(..., 0) calls. The release report then falls through to
hid_report_raw_event() -> hid_input_array_field(), which sees the previous
field->value[0] still at 0 and emits no key release event either.

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
As reported by Sashiko on v11 [1], ally_alloc_cmd() sizes its buffer from
FEATURE_KBD_REPORT_ID (0x5A), and ally_gamepad_send_receive_packet() passes
that length to ally_dev_get_report() to read HID_ALLY_GET_REPORT_ID (0x0D)
directly via hid_hw_raw_request().

Why does ally_dev_get_report() call hid_hw_raw_request() directly with the
caller's buffer size instead of using asus_kbd_get_report(hdev,
HID_ALLY_GET_REPORT_ID, out, len), which sizes the transfer from the report
descriptor for HID_ALLY_GET_REPORT_ID and returns 0 on success as documented
by ally_gamepad_send_receive_packet()?

[ ... ]
> @@ -512,6 +1308,21 @@ static int asus_raw_event(struct hid_device *hdev,
>  	if (drvdata->quirks & QUIRK_MEDION_E1239T)
>  		return asus_e1239t_event(drvdata, data, size);
> =20
> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +		struct ally_intf *intf;
> +
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
The comment here notes that letting report 0x0B (HID_ALLY_X_INPUT_REPORT)
reach the default parser creates a generic gamepad that overlaps with Steam
Input. However, returning -1 from asus_raw_event() only stops runtime events
from being processed after the device is already registered.

During asus_probe(), hid_hw_start(hdev, HID_CONNECT_DEFAULT) runs
hidinput_connect() -> hidinput_configure_usages() -> asus_input_mapping()
before hid_asus_ally_probe() is called. Because asus_input_mapping() return=
s 0
for the standard Generic Desktop and Button usages in report 0x0B, doesn't
hidinput_connect() still map report 0x0B and register a duplicate, dead
generic gamepad input_dev alongside the custom intf->gamepad device registe=
red
by ally_x_setup_input()?

Should asus_input_mapping() return -1 when QUIRK_ROG_ALLY_XPAD is set and
field->report->id =3D=3D HID_ALLY_X_INPUT_REPORT so that hid-input does not=
 map
report 0x0B at all?

[ ... ]
> @@ -1415,6 +2129,25 @@ static int asus_input_mapping(struct hid_device *h=
dev,
>  			return -1;
>  		}
> =20
> +		/*
> +		 * Declare the Ally vendor keys before this input is registered.
> +		 * KEY_F19 is the second event of the ROG key (usage 0x38).
> +		 */
> +		if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +			switch (usage->hid & HID_USAGE) {
> +			case 0x38:
> +			case 0xa6:
> +			case 0xa7:
> +			case 0xa8:
> +				input_set_capability(hi->input, EV_KEY, KEY_PROG1);
> +				input_set_capability(hi->input, EV_KEY, KEY_F16);
> +				input_set_capability(hi->input, EV_KEY, KEY_F17);
> +				input_set_capability(hi->input, EV_KEY, KEY_F18);
> +				input_set_capability(hi->input, EV_KEY, KEY_F19);
> +				break;
> +			}
> +		}
> +
>  		set_bit(EV_REP, hi->input->evbit);
>  		return 1;
>  	}

[Severity: Low]
In asus_input_mapping(), usages 0x38, 0xa6, 0xa7, and 0xa8 first call
asus_map_key_clear(), which calls hid_map_usage_clear() to set usage->code
and clear that bit in hi->input->keybit. Calling input_set_capability()
immediately afterwards sets KEY_PROG1, KEY_F16, KEY_F17, and KEY_F18 in
hi->input->keybit before asus_input_mapping() returns 1.

When asus_input_mapping() returns 1 to hidinput_configure_usage() in
drivers/hid/hid-input.c:

	while (usage->code <=3D max && test_and_set_bit(usage->code, bit)) {
		if (device->quirks & HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE) {
			usage->code =3D find_next_zero_bit(bit,
							 max + 1,
							 usage->code);
		} else {
			device->status |=3D HID_STAT_DUP_DETECTED;
			goto ignore;
		}
	}

test_and_set_bit(usage->code, bit) sees the bit already set, flags
HID_STAT_DUP_DETECTED, and jumps to ignore:, which zeroes usage->type and
usage->code. If hid_asus_ally_probe() fails or returns NULL on an interface
and the device falls back to generic HID handling, those vendor usages end =
up
unmapped.

Would it be better to only call input_set_capability(hi->input, EV_KEY,
KEY_F19) for the extra unmapped key here, and let hidinput_configure_usage()
set the mapped usage bits itself?

[1] https://lore.kernel.org/r/20261025235232.129945-16-denis.benato@linux.d=
ev

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031174130.2082=
40-1-denis.benato@linux.dev?part=3D2
