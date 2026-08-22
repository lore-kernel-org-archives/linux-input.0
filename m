Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FC2EEE65
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436726; cv=none; b=cwMXWi48C18aP0M/ZCnfgu7AjPQZ89RJihX0WiL4ud2TKpk0DnpuxehQn8PHWYxPxqqz4st1hnySFwEVDGx9UxsNLwXpuaEA57U/rs7bP24TcYmsdyAP4YqIRz9O0Kqdng4KsxpHfBwC5gZ2vNjENWIRvmCQipq7qV8daD2d1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436726; c=relaxed/simple;
	bh=og4cGe0SkCVYqROi5ukmQS1X1vOlK0oUuxIZg/P4QZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jwXcXO3Xsb5VDW0DaW+JHQVZTll0U1VZrZ35wXG62kNPbd13KJz3gGl7EBfNIZXkg1NOsVR4HeKJozH449IEqEfdj8Ymemh8au4oSv2o4EUuffiieQ94v3Q217tkbn/1C8CVVMGvAS2RPK41vSZuRFExTYcwbuAxUbRr9YTftso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTs7PSG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTs7PSG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB3F1F000E9;
	Sat, 22 Aug 2026 22:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787436724;
	bh=u9Yp7JysmnXaN7GHPwKUndPCmPdrxBMVFM0O+sEPS4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTs7PSG7LJWMykxht+LLp6CyowtDDaK1xTiiGVtGMfIKyY+A+jcIxEtGY4y0WwG7O
	 lSOOgTpZ9mQWzdm7nLCAa3pJb0Bux9VtVY8miDw9xc7YHC3SCLIcsvs6jjKrady9BD
	 5sxmYjoAFu572mJ3wzL2fG/hhILf9vX8powa/pc6wkDruJSbTcA3AqqQvY69NY5jGs
	 YU2fFboX2t6CaIjbKES50x5MvJyErrhaayW8VPw9cmHz41EzA0rABF80EuojXBDvxQ
	 C9EVyYrj/hfqlFTuPRxGUQwZFwUd+OISBlcJGR0mdo6LZrpeD2ZSGY0TTNuJoYbhvh
	 q5Wo5OtS9jL/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] HID: ft260: i2c: abort in-flight transfers with
 STOP before reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822213941.98882-14-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-14-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 22:12:04 +0000
Message-Id: <20260822221204.9BB3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free in ft260_remove() due to premature kfree(dev) befor=
e stopping hardware.
- [High] Flawed cleanup order in UART device removal leads to Use-After-Fre=
e.

Pre-existing issues:
- [High] Divide-by-zero panic in `ft260_hid_output_report_check_status` if =
the device provides a clock frequency of 0.
--

--- Patch [13]: [PATCH 13/13] HID: ft260: i2c: abort in-flight transfers wi=
th STOP before reset ---
commit c3cb7a3558ab0556a46bf87d920daa2c07f916c4
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: i2c: abort in-flight transfers with STOP before reset

This commit introduces ft260_i2c_abort() to issue a STOP-only write before
resetting the I2C controller when a transaction needs to be torn down. This
prevents the controller from being stuck in a BUS_BUSY state which can block
subsequent START conditions. It updates various I2C and SMBus read/write
status checks to use this new abort mechanism instead of a simple reset.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 9ae688f6208f2..a35a1af2d7e57 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -538,6 +538,33 @@ static int ft260_i2c_reset(struct hid_device *hdev)
[ ... ]
> +static int ft260_i2c_abort(struct hid_device *hdev, u8 addr)
> +{
> +	ft260_i2c_stop(hdev, addr);
> +	return ft260_i2c_reset(hdev);
> +}
> +
>  static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
>  {
>  	struct hid_device *hdev =3D dev->hdev;

[Severity: High]
This is a pre-existing issue, but can this lead to a divide-by-zero panic if
a misbehaving USB device provides a clock value of 0?

In ft260_xfer_status(), the device-provided clock value is trusted without
bounds checking:

    dev->clock =3D le16_to_cpu(report.clock);

Then in ft260_hid_output_report_check_status(), an unchecked division by
dev->clock occurs:

    usec =3D len * 9000 / dev->clock;

[ ... ]

While reviewing this patch, I also noticed a couple of other issues in code
not directly modified by this commit:

[Severity: High]
Can an incoming HID report access the dev structure after it has been freed?

In ft260_remove(), dev is explicitly freed:

drivers/hid/hid-ft260.c:ft260_remove() {
    ...
    kfree(dev);
    ...
}

But if hid_hw_stop() is called after this, an incoming report could trigger
ft260_raw_event(), which dereferences the freed dev:

drivers/hid/hid-ft260.c:ft260_raw_event() {
    ...
    spin_lock_irqsave(&dev->read_lock, irqflags);
    ...
}

[Severity: High]
Does this cleanup order leave a window where the work could be re-queued and
execute after the port is freed?

In ft260_remove(), the work is cancelled:

drivers/hid/hid-ft260.c:ft260_remove() {
    ...
    cancel_work_sync(&dev->wakeup_work);
    ...
}

However, the timer that queues this work isn't deleted until later in
ft260_uart_port_remove():

drivers/hid/hid-ft260.c:ft260_uart_port_remove() {
    ...
    timer_delete_sync(&port->wakeup_timer);
    ...
}

If the timer fires in this window, it can re-queue the work. Later, the
structure is freed:

drivers/hid/hid-ft260.c:ft260_uart_port_destroy() {
    ...
    kfree(port);
    ...
}

If the asynchronously queued work executes after the port is freed, could it
cause a use-after-free in ft260_uart_do_wakeup()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D13
