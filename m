Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9325393E
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760216; cv=none; b=FPyZqXhYMR5lY8ABolFSxIuoj07CxJCTY+3ohQq+jK3t43Mdg96hVjVEkgjngmE5haMzbWgJg3QYbIyQ8N5Z7STq4KySqLQm1pJX5dRL6F2U7mWYUYJBUIKKCCGQH8GGhQ0kT3mFb+zDNpOZZjO9lZ4/6Qlu901/nGkOt7vkqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760216; c=relaxed/simple;
	bh=BE0PEWoCrE/uqpYjK7COiN6c01PXOUiihThnkgUL9U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=salt50JWlnKX+6vWo5sU3Mwv7R/g6bKCmUUtfrwyh50rgW5tzIfXXeKZGDCZ7NcavUfpQkNmqVLRAIco9ssuE4h5FY7Qk73NrXdXVD1vaETQiZs/iuEgMxxYUZKbA/Edhd7O+ddTItHDeqU24atLwubBAyEMcm3kFBa2IekyxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnGL0fYD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnGL0fYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0855C2BCB3;
	Thu, 14 May 2026 12:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778760215;
	bh=BE0PEWoCrE/uqpYjK7COiN6c01PXOUiihThnkgUL9U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YnGL0fYDWCR+3WXReVZ1k+r3mEeVUOXgB1doDcJ3GP+ajMUOz+Z7i1KrftCzTxh/s
	 duxfQoWONEWwT8fwLLKKgrnV1/iNXmuohzCWpI3qJ9sIqSdYN+Ub+ncAxSrJ/sbJbt
	 icJXRghx5m9oPzOvMhz0JqQVfLhSfDgqDbD8xU8mbrjiuqqlLdXzAb2oR27kXpf6q/
	 xoLjNtO7JPLGtF9wLWV1VSEVcILN1+Ql59JBQrvlzTPfsvXRqyM8mWSNWDakwlmFde
	 E1sDvpuah1nWEAhxSD0Vr75z+rM7J32gjkeJxLU7bCNEPVg68JdnzsqAJqOJ20vMOJ
	 rK9mfgSbIZHyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] hid-asus: add prod-id, quirk for Zenbook Duo
 keyboard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260513163248.16483-8-p.pisati@gmail.com>
References: <20260513163248.16483-8-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 12:03:35 +0000
Message-Id: <20260514120335.C0855C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Out-of-bounds read and heap buffer overflow in report descript=
or fixup logic.
--

commit ad6b37250b171e419ae8bd990515ef1b0181a049
Author: Luke Jones <luke@ljones.dev>

hid-asus: add prod-id, quirk for Zenbook Duo keyboard

This commit adds product IDs and Bluetooth IDs for the 2024/2025/2026 ASUS
Zenbook Duo keyboards. It enables keyboard control, backlight, and Fn-lock
by applying the appropriate quirks.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 37e3aec612b6d..ba093f11f802f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1583,6 +1583,24 @@ static const struct hid_device_id asus_devices[] =
=3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_HID_FN_LOCK | QUIRK_ZENBOOK_DUO_KEYBO=
ARD },

This isn't a bug introduced in this patch, but adding these new device IDs =
with
QUIRK_ZENBOOK_DUO_KEYBOARD exposes them to an existing out-of-bounds read a=
nd
heap buffer overflow in asus_report_fixup().

When a device with this quirk connects, the driver attempts to strip traili=
ng
zeros from its report descriptor:

drivers/hid/hid-asus.c:asus_report_fixup() {
    ...
    if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI | QUIRK_ZENBOOK_DUO=
_KEYBOARD)) {
        ...
        if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
            if (hid_is_usb(hdev)) {
                rsize_orig =3D 90;
                offs =3D 66;
            ...
        }
       =20
        if (*rsize =3D=3D rsize_orig &&
            rdesc[offs] =3D=3D 0x09 && rdesc[offs + 1] =3D=3D 0x76) {
            __u8 *new_rdesc;
            unsigned int new_rsize =3D rsize_orig;

            /* Clear bogus trailing zero bytes. */
            while (rdesc[new_rsize + 1] =3D=3D 0)
                --new_rsize;
    ...
}

Does this evaluate rdesc[new_rsize + 1] reading 2 bytes past the end of the
dynamically allocated descriptor buffer, since new_rsize is initialized to =
the
exact size of the descriptor?

Furthermore, if the out-of-bounds bytes are non-zero, new_rsize remains its
original value. The code then copies rsize_orig + 2 bytes from the
rsize_orig-sized buffer:

drivers/hid/hid-asus.c:asus_report_fixup() {
    ...
            new_rsize +=3D 2;
            new_rdesc =3D devm_kzalloc(&hdev->dev, new_rsize, GFP_KERNEL);
            ...
            memcpy(new_rdesc, rdesc, new_rsize);
    ...
}

Can this result in an unconditional slab-out-of-bounds read?

Finally, if new_rsize shrank below offs + 14 due to trailing zeros, could t=
he
subsequent memmove and assignments write past the end of the newly allocated
buffer, causing a heap buffer overflow?

drivers/hid/hid-asus.c:asus_report_fixup() {
    ...
            memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
            ...
            rdesc[offs + 14] =3D 0x00;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513163248.1648=
3-1-p.pisati@gmail.com?part=3D7
