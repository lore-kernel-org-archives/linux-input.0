Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4EF3F54C5
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788494576; cv=none; b=KnNnl3lbVCZEAcuaSb+GcP9afmNEMBbmbtBww+GhZkcihpb86wEP/GbFc0CVkrDS+E1tJ0XyirPU26d3Hp9rkX0JTaGSJiqiZ1WCiaMjLPzaTMsvzqjqhO/RiS5wNQMTY0vxWFjoQaHOuQ/i0UD6pGgzH9dIwXKYnuSuDUczlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788494576; c=relaxed/simple;
	bh=vqS7uAQE2V8QdQC9hAoLvGz3Wgh9zJB2thncoFqrpWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D7ApyPz1pF8BwvteCkum9ROyR0OEcuEkEkNWhL3kYYSC3H53xBKDvtVbRhlVvRWcJk+SlOFxUph0InmUZsVI8n9BrqQdPdaQiAJmcRjhS/s2IwURklRfDQK1IdTN2jSt44mWTAkge9ef8dg0fcTnzQAisy4XL4rDpvVWcSsFH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRrkxHKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRrkxHKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0257D1F00A3D;
	Fri,  4 Sep 2026 04:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788494575;
	bh=8SaFynkBtG6D1V8Q6OXwP9LQIgXUhq/OFQrlib3w9eA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRrkxHKlGw0FnHQtI34FL6xPCow71HRg0X+cEvirOu4OJsydTujeXugfRc09HARAY
	 NYeMxe0Ycuh64NBt8gzOUBBpI7nXGyaDBwUqcwiLbpxylPPClYYf8pnaQuksd0aSV2
	 ze3XZ7aoNPkLO4ahsKpm1Z8JQvVjvKY31PNOJgJFHT62dA1leGDp4ebw+TvBNd9Y/5
	 lIUKOVGMsX0fHyHQYpWu9NQ3Ogp+/1D4KIUXnebdntx8AFDrMVvfmgQAWeVoE64/Jo
	 mGoER1ks9vQlBit9eWWLTB9uOnxs7mVpPpnyUYkBd/3PNmrUdq2hoOTW1KzCp+xiQ1
	 3aP7PWSVQZlcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for
 Bolt-connected MX Master
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904034843.1340846-1-rafael@rcpassos.me>
References: <20260904034843.1340846-1-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 04:02:54 +0000
Message-Id: <20260904040255.0257D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional and improperly guarded cast of the parent device to =
`struct hid_device` in `hidpp_is_bolt_child()` causes type confusion and ou=
t-of-bounds memory access for Bluetooth and native USB devices.
- [High] Time-of-check to time-of-use (TOCTOU) data race between `hidpp20_h=
ires_wheel_raw_event()` and `hidpp_connect_event()` leading to a Use-After-=
Free of `hidpp->input`.
--

commit 1aae454b03bbd4a45bdfdb3bc2a196f15d06fbfa
Author: Rafael Passos <rafael@rcpassos.me>

HID: logitech-hidpp: fix hi-res scroll for Bolt-connected MX Master

This commit fixes hi-res scrolling on the MX Master 3S when connected
via the Bolt receiver by routing wheel events through the HID++ driver
instead of hid_generic. It also adjusts initialization checks for Bolt
devices.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 1504de32b1c84..960543bfd5ea1 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3900,6 +3900,19 @@ static int hidpp10_consumer_keys_raw_event(struct =
hidpp_device *hidpp,
>  	return 1;
>  }
> =20
> +static bool hidpp_is_bolt_child(struct hid_device *hdev)
> +{
> +	struct device *parent =3D hdev->dev.parent;
> +	struct hid_device *receiver_hdev;
> +
> +	if (!parent)
> +		return false;
> +
> +	receiver_hdev =3D to_hid_device(parent);
> +	return receiver_hdev->vendor =3D=3D USB_VENDOR_ID_LOGITECH &&
> +	       receiver_hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_BOLT_RECEIV=
ER;
> +}
> +

[Severity: High]
Does this safely handle native USB devices? When this is called for a native
USB device, the parent device is a struct usb_interface, not a struct
hid_device.=20

Using to_hid_device(parent) subtracts the container_of offset for a
hid_device from the dev pointer, resulting in a pointer well before the
allocated usb_interface structure. Accessing receiver_hdev->vendor will then
cause an out-of-bounds memory read.

[ ... ]

> @@ -3910,7 +3923,9 @@ static int hi_res_scroll_enable(struct hidpp_device=
 *hidpp)
>  	u8 multiplier =3D 1;
> =20
>  	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
> -		ret =3D hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
> +		bool use_hidpp =3D hidpp_is_bolt_child(hidpp->hid_dev);
> +

[Severity: High]
Could this unconditionally trigger the out-of-bounds read described above f=
or
all HID++ 2.0 devices? This includes native USB and Bluetooth devices where
the parent is not a hid_device.

[ ... ]

> @@ -3998,6 +4013,19 @@ static int hidpp20_hires_wheel_raw_event(struct hi=
dpp_device *hidpp,
>  		return 1;
>  	}
> =20
> +	/* wheel movement event: 16-bit signed delta in HID++ ticks */
> +	if ((data[3] & 0xf0) =3D=3D 0x00 && size >=3D 7 && hidpp->input &&
> +	    hidpp->vertical_wheel_counter.wheel_multiplier) {
> +		s16 delta =3D get_unaligned_be16(&data[5]);
> +
> +		if (delta) {
> +			hidpp_scroll_counter_handle_scroll(hidpp->input,
> +				&hidpp->vertical_wheel_counter, delta);

[Severity: High]
Is there a Time-of-Check to Time-of-Use (TOCTOU) race condition here?

Since hid_device_io_start() has already been called during probe, hardware
events can fire concurrently with hidpp_connect_event().

If this raw event handler checks hidpp->input and proceeds, but
concurrently hidpp_connect_event() encounters an error (e.g. from
input_register_device failing) and executes:

    hidpp->input =3D NULL;
    input_free_device(input);

Could this lockless dereference of hidpp->input in
hidpp_scroll_counter_handle_scroll() result in a use-after-free?

[ ... ]

> @@ -4579,7 +4594,9 @@ static void hidpp_connect_event(struct work_struct =
*work)
>  	}
> =20
>  	hidpp_initialize_battery(hidpp);
> -	if (!hid_is_usb(hidpp->hid_dev))
> +
> +	if (!hid_is_usb(hidpp->hid_dev) ||
> +	    hidpp_is_bolt_child(hidpp->hid_dev))
>  		hidpp_initialize_hires_scroll(hidpp);

[Severity: High]
Could this also trigger the out-of-bounds read in hidpp_is_bolt_child() for
native USB devices?

For a native USB device, hid_is_usb() is true, so !hid_is_usb() evaluates to
false. This forces the logical OR to evaluate hidpp_is_bolt_child(), passing
the USB device into the function that unsafely casts the parent device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904034843.1340=
846-1-rafael@rcpassos.me?part=3D1
