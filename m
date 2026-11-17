Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948653;
	b=HQZESIS2FBBODUMAXBHmxO5X++PlS4C5vRRTtIBKEKsp8ebPx84hrnuf64FQoEPbkEua
	 hNMAtkSs7cfEl2kpenKfvuJocIVuA/nn9oK+6FmTbr/IJ/jjXgqbykQ2267R/BjVE5pi/
	 +pvvUX1uy98VW8Gzjv32LSKNj6TcnUILO0BlWiQDnE6lmRpXjCYArfRgqrkgA6QH6eNqd
	 dx4mRhzWEFHAviIJRXef40laVacK/PGUE6aD3wvYdl3vYPuigawqAy/awnRAcEyVAWhtW
	 wx3hm0wdNS9nyLC8CNJ5Ol/cKohGghuI0cGs4kI7AwCdKYDyhAA/Wrzf8/2LZpCBMTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948653;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xkRnAzVjOgqw74PzyZVpExogHJ4eA0Zxv+ymfrWlxTE=;
	b=y481PBl8Gdb3M5fdGkGMVKc9WUzWWh7zOGeCtF+OMY00h6dRfyIGk12vdfb2gJJ1AsID
	 Dzbs3V+SWeOGeuZKn4Fzkg3xYenlA9xNnUKmtsF2ZLVeUg3pKfKGAG6F/YoAlvU7Hp4ns
	 xLQ1U94KiMMVOYuF6qKB7Hz1r25LofXcJ5SDd0sv5ZuEnh1ZAGCxsEynXFnERlPZKoDd8
	 +Z5z8HY+EgxJg8LLLhDP3n1yW2Pdv7gFn9VG64f/H4MAqm9HBgEtVhl4+5X4zQcFJmE+f
	 u2EY1+foOtvqyUN8yEClTtaVQ/h615+qDuKppW0SCCaFa/NcfNy252FCf/OG+KElnoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCyS2Y8h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A712606A31C;
	Tue, 17 Nov 2026 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCyS2Y8h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634A81F000C4;
	Tue, 17 Nov 2026 20:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794948652;
	bh=xkRnAzVjOgqw74PzyZVpExogHJ4eA0Zxv+ymfrWlxTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCyS2Y8hnU0YlRaqpazO+mCdcnJjPT5NrHCDxqqfj6Tzx588Z+41Y3MF+k1rtr0i2
	 5CIT4YRB2y0DAEsfBqJ5WymGCXG1IP3fgHm4+PE7hwYgIlWflsuGdJDHb7tyIhJ/wj
	 U0jPY/ihdspEHiMide9tPvy7gkH6GozeD0NrAkppba4b/rOOPd4FvU47ONsapkzFim
	 InZ4idXhYzrOAIICywegQRJx9dduPE/iZGFcN82aJ8eJRlZoZ0npn/HcXycfmOjV9W
	 nH4QbjF+olMNEg+TJq0JLBx8jdBaZF/oM9Ftvn//V0Q6p97GvFu9GIgt+LwnxnyChy
	 wSFWXdPhyot/w==
Message-ID: <sashiko-outbox-219658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/16] HID: ft260: workaround for TN_189 errata
 endpoint STALL after enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117200423.19561-12-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
 <20261117200423.19561-12-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:50:51 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: ft260: race between ft260_reset_and_rebind() and
  ft260_probe()
--

commit 4f2501f4550a54da3c0f10a72785d9919d317381
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: workaround for TN_189 errata endpoint STALL after enumeration

This commit adds a workaround for the FT260 TN_189 silicon errata by
checking interrupt IN endpoint health and device responsiveness during
probe, and scheduling a deferred USB device reset and interface rebind
when either check fails.

Link: https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-T=
echnical-Note.pdf

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index e708b1be734c7..096e46836d743 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -2504,15 +2566,276 @@ static int ft260_uart_probe(struct ft260_device =
*dev,

[ ... ]

> +static void ft260_reset_and_rebind(struct work_struct *ws)
> +{

[ ... ]

> +	/*
> +	 * usb_reset_device() keeps usbhid bound (its pre_reset/post_reset
> +	 * both return 0) and does not re-trigger HID-level driver probing.
> +	 * Unbind all USB interfaces, reset, and bind them again to force
> +	 * usbhid to destroy stale HID devices and create new ones, which
> +	 * triggers fresh ft260_probe() calls. Unbind before the reset: it
> +	 * waits for a probe still running on either interface, so the
> +	 * reset does not run while that probe stops usbhid.
> +	 */
> +	actconfig =3D usbdev->actconfig;
> +	for (i =3D 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
> +		struct usb_interface *intf =3D actconfig->interface[i];
> +
> +		if (intf && intf->dev.driver)
> +			device_release_driver(&intf->dev);
> +	}

[ ... ]

> +static int ft260_check_intr_ep_health(struct hid_device *hdev)
> +{

[ ... ]

> +	pipe =3D usb_rcvintpipe(usbdev, ep->bEndpointAddress);
> +	ret =3D usb_interrupt_msg(usbdev, pipe, buf, FT260_REPORT_MAX_LEN,
> +				&actual_length, 100);
> +	kfree(buf);
> +
> +	if (ret =3D=3D -EPIPE) {
> +		hid_warn(hdev,
> +			 "interrupt IN ep %#x halted (TN_189 errata), scheduling USB reset an=
d rebind\n",
> +			 ep->bEndpointAddress);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -2540,6 +2869,27 @@ static int ft260_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  		goto hid_fail;
>  	}
> =20
> +	/*
> +	 * TN_189 errata workaround: bail out fast on a broken device so
> +	 * that hub_event releases the device lock quickly, allowing the
> +	 * scheduled reset work to acquire it and recover the device.
> +	 */
> +	ret =3D ft260_check_intr_ep_health(hdev);
> +	if (ret =3D=3D -ENODEV) {
> +		ft260_schedule_reset(usbif);
> +		goto err_hid_stop;
> +	}

[Severity: Medium]
Can ft260_reset_and_rebind() race with an active ft260_probe() when the
driver is bound outside USB enumeration?

Unlike usb_bus_type, hid_bus_type does not set need_parent_lock.  When
hid-ft260 is loaded after hid-generic has already bound during USB
enumeration (or when reprobed via sysfs), hid_register_driver() probes the
two HID interfaces holding only device_lock(&hdev->dev), without holding
usb_lock_device(usbdev) or device_lock(&intf->dev).

When the first interface (hid0) detects a stalled endpoint and schedules
the reset work, ft260_reset_and_rebind() immediately acquires
usb_lock_device_for_reset() and calls device_release_driver(&intf->dev).
That enters usb_unbind_interface() and usbhid_disconnect() before
device_del(&hdev->dev) waits on device_lock(&hdev->dev):

CPU0 (modprobe hid-ft260)           CPU1 (ft260_reset_wq)
ft260_probe(hid0)
  ft260_check_intr_ep_health(hid0)
  ft260_schedule_reset()
  hid_hw_stop(hid0)
ft260_probe(hid1)
                                    ft260_reset_and_rebind()
                                      usb_lock_device_for_reset(usbdev)
                                      device_release_driver(&intf1->dev)
                                        usb_unbind_interface(intf1)
                                          usb_disable_interface(intf1)
                                          usbhid_disconnect(intf1)
                                            set_bit(HID_DISCONNECTED, ...)
                                            ...
                                            device_del(&hid1->dev)
                                              /* blocks on hid1 lock */
  hid_hw_start(hid1, 0)
    usbhid_start(hid1)
      clear_bit(HID_DISCONNECTED)
  ft260_check_intr_ep_health(hid1)
    usb_interrupt_msg() -> -ENOENT
    returns 0
  ft260_check_dev_responsive(hid1)
    usb_control_msg(ep0) -> 0
  hid_hw_open(hid1)                 <-- arms io_retry on disconnecting hid1

Because usb_disable_interface() has already disabled the interrupt IN
endpoint on intf1, usb_interrupt_msg() fails with -ENOENT, which
ft260_check_intr_ep_health() ignores because it only checks for -EPIPE.
When only the interrupt endpoints are halted under TN_189, ep0 still
answers USB_REQ_GET_STATUS, so ft260_probe(hid1) continues through
hid_hw_open() (with HID_DISCONNECTED cleared by usbhid_start()) and
registers the subdevices on a half-disconnected hid_device.  On hid0,
usb_disable_interface() and hid_bpf_destroy_device() can also run
concurrently with hid_hw_stop(hid0) if the work starts before hid0 finishes
unwinding.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200423.1956=
1-1-michael.zaidman@gmail.com?part=3D11
