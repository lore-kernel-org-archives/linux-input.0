Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751581;
	b=SztUzgmeWouzkKG0wFPtHF4WQuMhpeQIcsY1VLR+D5clapf7HzEw+CGcY9QqZxo0W0tm
	 3FH7LwJtopkjeZgWZWUeHQfVm4yNWHtut8cEFTPHQZhO7Q/fJZfGv/IRhpWGDrSN0hQ0Y
	 0KPdhGjrofIvHO2XsC0qbTC7rkWxc3eYa5aCKboLB9vd6dh5vJ6of3d74Q/OBw0/kKc5X
	 9PejZjrHxuMqRqGHLNyElAK+U4eYncU1oM4bfRJDpKSiSSK/BV6CYIYq9b5BGaMnsMnIF
	 raulq4xV/oOPTjlh857MyIQ2xq+FJKe/cW2RfesJEakQIPaHZoe8sHoD4Q2zvlUcfew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+2fLl+Dwc2NkV1qUrBq7rvYrQ0pDagFJzMN2WwxuH58=;
	b=xNwtA2oJiGQdUbrbvA50Uefmh1iV+QKnTRJPGx8DE0diV+9kJteMdz2IfGfO05zwJQRr
	 y+5d74k+Z2BYDRpLhpKvUvrIziPY2wNZE6eXPJlmlXNSHvxfOisA/6qEI/2ZXzWo9TEbp
	 XSkB5wFuzfG3FJeCw8A/yUOBv9hI7BfFdWctYH+MXZJlna9IUH9CMY3pA4oCYBHZI9L9C
	 ZIXWGgv1RXviDigN3Mq88qIBQNeCWOAibKsbpDVux/lihjyDMDYYJj9/4Zk0Hdf5ESOXU
	 5wOO3o1bx1I1F5oQf0RjdQrv/T/NvYSYxQzU592OvLL1p7c4tYD441x5aBgrCAqnwnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOloeqNN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F8606A31A
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOloeqNN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82691F000C4;
	Sun, 15 Nov 2026 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751581;
	bh=+2fLl+Dwc2NkV1qUrBq7rvYrQ0pDagFJzMN2WwxuH58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BOloeqNN6ihhXxCVJzPknLUDiMS/D15QVrqhVvhHQ1VP8VVyuBMfjPvoPdaRwq52X
	 iUcKJJ+KkbeRYkJH/y7V1wXSBjVajEn/BnApFZFVkfCUiqGKHA3RKqiMHpnFwJoIEh
	 DS1Wbok18yOJP+lZfF6LMATZt/kirYqHvpir82ncXfXeW2TiEuiubwJd2HiL+8Fque
	 IWW7bunFGh9g0z1e+EyF0mO2BaKM2YlSou9wZJNBsWIaEY2Z1jXuewomAgYQZSLFN4
	 LbfvbYAzx5LRCZXII4cTRbGbuzqBnlpjh1lXztsYXe+muluxpXeI4ZFia5CYJ/HlUk
	 /TroZ94fct9aA==
Message-ID: <sashiko-outbox-215556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - add support for GameSir G7 Pro dongle in
 Xbox mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gollings" <levirootsmanuva2@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261115135814.34031-1-levirootsmanuva2@gmail.com>
References: <20261115135814.34031-1-levirootsmanuva2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:06:20 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] Input: xpad - use-after-free in xpad_probe() [1]
--

commit 9da1d473121c33d6a51bd41a4411539bd2d0fc9a
Author: Alexander Gollings <levirootsmanuva2@gmail.com>

Input: xpad - add support for GameSir G7 Pro dongle in Xbox mode

This commit adds an Xbox One device entry for the GameSir G7 Pro 2.4GHz
dongle and skips Xbox 360 entries in xpad_probe() when the USB interface
uses the GIP protocol.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index d2eb48d98fead..f0ceb78e40a36 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -2065,8 +2090,7 @@ static int xpad_probe(struct usb_interface *intf, c=
onst struct usb_device_id *id
>  		return -ENODEV;
> =20
>  	for (i =3D 0; xpad_device[i].idVendor; i++) {
> -		if ((le16_to_cpu(udev->descriptor.idVendor) =3D=3D xpad_device[i].idVe=
ndor) &&
> -		    (le16_to_cpu(udev->descriptor.idProduct) =3D=3D xpad_device[i].idP=
roduct))
> +		if (xpad_device_match(&xpad_device[i], udev, intf))
>  			break;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but can xpad_probe() cause a
use-after-free on xpad [1] if xpad360w_start_input() fails after
submitting xpad->irq_in?

When probing an XTYPE_XBOX360W device, xpad360w_start_input() submits
xpad->irq_in before calling xpad_inquiry_pad_presence():

drivers/input/joystick/xpad.c:xpad360w_start_input() {
	error =3D usb_submit_urb(xpad->irq_in, GFP_KERNEL);
	if (error)
		return -EIO;

	/*
	 * Send presence packet.
	 * This will force the controller to resend connection packets.
	 * This is useful in case we have connected a controller before
	 * the module was loaded.
	 */
	error =3D xpad_inquiry_pad_presence(xpad);
	if (error) {
		usb_kill_urb(xpad->irq_in);
		return error;
	}
}

If a packet arrives before xpad_inquiry_pad_presence() fails, xpad_irq_in()
schedules xpad->work, and the error path in xpad_probe() frees xpad without
canceling the work:

CPU0                              CPU1
xpad_probe()
  INIT_WORK(&xpad->work, ...)
  xpad360w_start_input()
    usb_submit_urb(xpad->irq_in)
                                  xpad_irq_in()
                                    xpad360w_process_packet()
                                      schedule_work(&xpad->work)
    xpad_inquiry_pad_presence()
      /* fails */
    usb_kill_urb(xpad->irq_in)
  goto err_deinit_output;
  ...
  kfree(xpad)
                                  xpad_presence_work()
                                    /* dereferences freed xpad */
                                    <-- use-after-free

Calling cancel_work_sync(&xpad->work) after usb_kill_urb(xpad->irq_in) in
xpad360w_start_input() (matching xpad360w_stop_input()) would prevent the
work item from running after xpad is freed.

[1] https://sashiko.dev/#/bug/linux-0c0def42-a340-45bb-860d-c99ba757f43b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115135814.3403=
1-1-levirootsmanuva2@gmail.com?part=3D1
