Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA036D51B
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024741; cv=none; b=SQ27VzTYkRQooJE39IoYmxo0Xnkf6dLVufy0tCbTG0nX71Nqz0d3uEXPR07Z7nq3jxJdEjxVUTLavSitsE/2oJex3vF6jllSxbDiV2y9jNGNp3AuQ78T4LxYN++wlznJm5VlXdnPJrhqxEkkG0DagIVjKOGDiFJHbGOTkpGqMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024741; c=relaxed/simple;
	bh=yVriT+KHCbJZxLbggUcsjRvLXwxkAtxe8trTlz0sFwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V7rhuR7uMfuBetZLWlln7ZsPH2zrBHlvxPzkjh9V/QUpavwuJt5UjVs4utujL5EkQrbgPJ42AODRTE9iFOw6ZrvJV9rKMF/CAuf2IRWP4hEAP9rSZMKfPLwLHJ0L5WoqqMOH4fLKeXYC6SiK2eenkK5tW31H/9fv82frOMHnrSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLEm8cX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLEm8cX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB2E1F000E9;
	Tue, 14 Jul 2026 10:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784024740;
	bh=osf9tHhiFbYE14tDIIg5oEMhMFyZvHTiY39hC7JRgA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oLEm8cX33JFRUvAyq+apGfQYKS/HxUFk8C4ZaN7VhUlFs723hqzabmc9dsTILux/a
	 An827sj6UsI2g56KKSBXGMwjKLdQiAgYXWRvPVtVm/kGAy0W0xR/q5Xxo/0Dw4W7/V
	 yI93Nr30lpcjyzdhK4ViI+FJqOWiTgJDpchUJBxj372Pp71R6W2q/ATBgkIRmO1H6s
	 6MawJJbT6UX2Vx6ZUnUx8vkaj+IjWS2whMaWuT53jlasspwWVfMS2WLI52juzkzadK
	 hTzCJY0aEIKUn9bbAA5lLHpbcr1YSeMA7AMqgs/HJ0Jw8ptovt8Gvh/3QZCcvBvfbM
	 ZK4h8ItsdxTWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] HID: magicmouse: report charge status over
 Bluetooth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alec Hall" <signshop.alec@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260714101235.99447-4-signshop.alec@gmail.com>
References: <20260714101235.99447-1-signshop.alec@gmail.com>
 <20260714101235.99447-4-signshop.alec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:25:39 +0000
Message-Id: <20260714102540.3EB2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver unconditionally dereferences `msc->input` in `magicmous=
e_raw_event` and `magicmouse_emit_touch`, leading to a kernel panic if `msc=
->input` is NULL.
- [High] A malicious device can send a deeply nested sequence of `DOUBLE_RE=
PORT_ID` (0xf7) reports in a single packet, causing `magicmouse_raw_event` =
to recurse until it overflows the kernel stack.
--

--- Patch [3]: [PATCH 3/3] HID: magicmouse: report charge status over Bluet=
ooth ---
commit 7588bfd842ef79dc73b3904f9e721e709d0dc4fe
Author: Alec Hall <signshop.alec@gmail.com>

HID: magicmouse: report charge status over Bluetooth

This commit adds parsing for the status byte in raw battery input reports
for the Magic Mouse/Trackpad. It extracts external power and charge complete
bits and reports them to user space via power_supply_changed().

> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 6d0e76314b105..8bb791efef3a8 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c

[ ... ]

> @@ -394,6 +428,9 @@ static int magicmouse_raw_event(struct hid_device *hd=
ev,
>  	if (size < 1)
>  		return 0;
> =20
> +	if (data[0] =3D=3D MAGICMOUSE_BATTERY_REPORT_ID && size >=3D 3)
> +		magicmouse_report_charge_status(hdev, data[1]);
> +
>  	switch (data[0]) {
>  	case TRACKPAD_REPORT_ID:
>  	case TRACKPAD2_BT_REPORT_ID:

[Severity: High]
This is a pre-existing issue, but can this function trigger a kernel panic
due to a NULL pointer dereference on msc->input?

If a malicious USB device spoofs the Magic Mouse or Trackpad 2 product IDs,
magicmouse_probe() can return early without validating !msc->input:

drivers/hid/hid-magicmouse.c:magicmouse_probe() {
    if (is_usb_magicmouse2(id->vendor, id->product) ||
        (is_usb_magictrackpad2(id->vendor, id->product) &&
         hdev->type !=3D HID_TYPE_USBMOUSE))
        return 0;

    if (!msc->input) {
        ...
    }
}

When this device later sends a raw HID report, magicmouse_raw_event() will
unconditionally dereference input->id.product at the end of the function:

    if (input->id.product =3D=3D USB_DEVICE_ID_APPLE_MAGICMOUSE || ...

This might also happen if hid_hw_start() enables interrupts and processes
incoming raw events before hid_connect() finishes initializing msc->input.

Could a check for msc->input be added to prevent this?

[Severity: High]
This is also a pre-existing issue, but does this function have a potential
stack overflow vulnerability via unbounded recursion?

If a malicious device sends a nested sequence of DOUBLE_REPORT_ID (0xf7)
reports in a single packet with a size payload of 0, the recursive calls
will consume only 2 bytes of the payload per call:

drivers/hid/hid-magicmouse.c:magicmouse_raw_event() {
    ...
    case DOUBLE_REPORT_ID:
        ...
        magicmouse_raw_event(hdev, report, data + 2, data[1]);
        magicmouse_raw_event(hdev, report, data + 2 + data[1],
            size - 2 - data[1]);
        return 0;
    ...
}

With a maximum USB/HID packet size of 16KB, could this result in up to
8,192 recursive calls and exhaust the kernel stack?

Is there a way to limit the maximum recursion depth here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714101235.9944=
7-1-signshop.alec@gmail.com?part=3D3
