Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0C13B5B3
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366498; cv=none; b=k2xGIlQj5Kvygp8da7IGb9C6bxfJyx/D1BAUMTV4J8x5vojn424Wq0SGVlsKjDXKu2zijkBfCu3UXIugjZ2/nzWFqvLi+jlNnYMoCSPDfHl8Y8lsnoAau1FWdm6Sm0KkFYuGYInuIj2hiKzGwrhbs8pCRdkaXTRqNf826KxxXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366498; c=relaxed/simple;
	bh=0eI2nU6j78PsTagnVgsWYNPGt5WXkJUZP3Q4JI6CJYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q7FzCI8VVnIglFcsy6tS6OjMGd90RZ9ItRjJTeBzDCHhDlK1qMuRcGPhjYvLXxJsMpnSjDYtWzije+kcEqZBiQ3LJZg4YiKesA2erRyhUtCgXecwdROyG9KgZJxW+1XniHXklgofPQMeYtW4CWDtWgoBT6JiQWpw+ldmiq/pi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+QXWwZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+QXWwZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1D91F000E9;
	Sat, 22 Aug 2026 02:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787366497;
	bh=D4cOiVjgvysQIG/NGP314yjkLXSDFEljD5TSSLjJ7EM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+QXWwZ1D+4BTY4tvPbB3Xj+7ap5TBlZdIg1Vy0SIxLfFDp/kmgQHgGS1fHrjD3zN
	 TZ6inxgi2SD/ACHNHm5zzojp71VnaPVQM0JPGf95fVSQk4rp9jkdYAdxkd+ylmsdlg
	 3Lvp1nWOxaPGCaKl6yfIwXoKsDDU+lWPBtJFW3MJOou8x4UWMMJVjvkaXuULK/yN4l
	 EI2x1ohMlLRTtlZLRwFE3L2gNiMs9Tth/KX8ANN+6oj5fxU6/+lz132pXaaEMqyyae
	 4eKpz6HLbKVDYQ+YNJ9haGGfO2yYunmLYIkkwi19/8V519+PSfX5i70VTWJDTAq/Yi
	 EOX78TZZ4jj9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/12] Input: xpad - Remove Xbox One support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822021140.1149546-3-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:41:36 +0000
Message-Id: <20260822024137.6D1D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Incomplete feature removal leaves behind dead code related to Xbox =
One support.

Pre-existing issues:
- [High] Use-after-free due to missing cancel_work_sync() in xpad_probe err=
or path.
--

--- Patch [2]: [PATCH v4 02/12] Input: xpad - Remove Xbox One support ---
commit 5a5aa152af89fbca852a5ae95c5acba0ea842ea5
Author: Vicki Pfau <vi@endrift.com>

Input: xpad - Remove Xbox One support

This commit removes Xbox One controller support from the xpad driver, as
it has been superseded by the xbox_gip driver.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -754,7 +476,6 @@ struct usb_xpad {
>  	struct urb *irq_out;		/* urb for interrupt out report */
>  	struct usb_anchor irq_out_anchor;
>  	bool irq_out_active;		/* we must not use an active URB */
> -	u8 odata_serial;		/* serial number for xbox one protocol */
>  	unsigned char *odata;		/* output data */
>  	dma_addr_t odata_dma;
>  	spinlock_t odata_lock;

[Severity: Low]
Since Xbox One support is being removed, is it intentional that fields like
init_seq, packet_type, delay_init, and delayed_init_done were left in struct
usb_xpad? They appear to be completely unused now and could cause confusion.

For example, xpad_probe() still contains a large block of logic detecting
Elite firmware revisions purely to set xpad->packet_type:

xpad_probe() {
...
        /* Packet type detection */
        if (le16_to_cpu(udev->descriptor.idVendor) =3D=3D 0x045e) {
                if (le16_to_cpu(udev->descriptor.idProduct) =3D=3D 0x02e3) {
                        /* The original elite controller always uses the ol=
dest
...
}

Could this dead code be cleaned up as part of the removal?

[ ... ]

> @@ -2090,8 +1484,6 @@ static int xpad_probe(struct usb_interface *intf, c=
onst struct usb_device_id *id
>  		if (intf->cur_altsetting->desc.bInterfaceClass =3D=3D USB_CLASS_VENDOR=
_SPEC) {
>  			if (intf->cur_altsetting->desc.bInterfaceProtocol =3D=3D 129)
>  				xpad->xtype =3D XTYPE_XBOX360W;
> -			else if (intf->cur_altsetting->desc.bInterfaceProtocol =3D=3D 208)
> -				xpad->xtype =3D XTYPE_XBOXONE;
>  			else
>  				xpad->xtype =3D XTYPE_XBOX360;
>  		} else {

[Severity: High]
This is a pre-existing issue, but does the error path in xpad_probe() conta=
in
a use-after-free risk if xpad360w_start_input() fails?

If xpad360w_start_input() fails after submitting the input URB (for instanc=
e,
if xpad_inquiry_pad_presence() fails), it returns an error. The error path =
in
xpad_probe() then frees the xpad struct:

err_deinit_output:
    xpad_deinit_output(xpad);
err_free_in_urb:
    usb_free_urb(xpad->irq_in);
err_free_idata:
    usb_free_coherent(udev, XPAD_PKT_LEN, xpad->idata, xpad->idata_dma);
err_free_mem:
    kfree(xpad);
    return error;

However, if the URB completes before being fully killed and
xpad360w_process_packet() handles a presence change, it calls
schedule_work(&xpad->work).

Because the error path never calls cancel_work_sync(&xpad->work), the
workqueue might dereference the freed xpad pointer when xpad_presence_work()
executes. Could a malicious USB device trigger this race by intentionally
failing the presence inquiry while sending a valid URB completion?

[ ... ]

> @@ -2291,15 +1672,6 @@ static int xpad_resume(struct usb_interface *intf)
>  	if (input_device_enabled(input))
>  		return xpad_start_input(xpad);
> =20
> -	if (xpad->xtype =3D=3D XTYPE_XBOXONE) {
> -		/*
> -		 * Even if there are no users, we'll send Xbox One pads
> -		 * the startup sequence so they don't sit there and
> -		 * blink until somebody opens the input device again.
> -		 */
> -		return xpad_start_xbox_one(xpad);
> -	}
> -
>  	return 0;
>  }

[Severity: Low]
The delayed_init_done flag is still being cleared at the start of
xpad_resume() despite being unused elsewhere. Should this assignment be
removed as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D2
