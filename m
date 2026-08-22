Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA3493646
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436128; cv=none; b=Rha6vz9cG6XlijhuMYjboCrtBUxffjtGm0fqV1yEoslNzDfZ3oJRKGIaDB4ez9Fsg/sws+e8nqC2NWHVTQy7XlY74Eeha/nOVpmjaRJSNIMQK9FzYnfwzeHIGH/8hvBJTv7UeqwDGYrnm3uDC0titVds53xGpLFivdwXGjeWmrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436128; c=relaxed/simple;
	bh=g1roQjQNOMdTEykuVSnQEJ5Wn0x5oqDSj2TR8p9FQj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=URXmEAICynFh1c9OHWffoDCJU5xfru039vC0qgVbGRYAG3p6bp1gvjddeTE9wFIeh0FGp4gBTE7E7SgELAWE7/wLN+MBFBWPWPq1+ehP+GwQ0I13OzCvudZwYWzbnu6a09eqeVemqc/Zs7gX3g/XqljZneiskTQDTi+SUswBcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvCCbM+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvCCbM+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D791F000E9;
	Sat, 22 Aug 2026 22:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787436127;
	bh=g7aUGhMslghcrVsnQETlSduVaDOFbuMo+QIHsX8uazM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvCCbM+o/t44FuGnaJvkGtboXjKYUgVxASdMy5ZJkGgSwqacCbAEcITYMtaRQB79F
	 CCT9VRUN0gn8/Gqecu0vFzxd45+JsgZ9rFL1DSSSmXJLS0GAjrkYdfzF9RLWEi3m1k
	 tdwuSRkBZTt9jOD4IVfEbIDNDM8YzlGpNcVKi+dhLAIrqs+7hE5gsME3PZAMNSXcQO
	 gx8X+2V5eBu2sTuJQOH9LIBeM9KgNUMFxz/6DfopXHpTJV0SZGg+Bzp9AkxcDQ6BzG
	 gf9+Rd5IEjvzEp1EY9HVytz994wNSyDSpBLtObl+IPCfG6DEcs6iKEYof79kZ4xCx1
	 ONundQ6L285sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] HID: ft260: i2c: fix large write transaction
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822213941.98882-12-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-12-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 22:02:06 +0000
Message-Id: <20260822220207.00D791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `ft260_device` structure is freed before the HID hardware is s=
topped, creating a use-after-free vulnerability in the event handler.
- [High] A malicious USB device can cause a kernel panic via division by ze=
ro by reporting a clock frequency of 0, or by stalling the feature report r=
ead.
- [High] A malicious USB device can trigger an out-of-bounds heap read in `=
ft260_gpio_init` via an unvalidated `uart_mode` value.
--

--- Patch [11]: [PATCH 11/13] HID: ft260: i2c: fix large write transaction =
failure ---
commit 194ff3edbd401c08d64eb7640df73c9f274ff9ea
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: i2c: fix large write transaction failure

Fixes a regression where multi-report I2C writes failed because middle
reports were treated like a final STOP. It passes the bus-busy check
policy from the caller so intermediate chunks and the command phase of
combined transfers do not wait for idle.

Link: https://github.com/MichaelZaidman/hid-ft260/issues/35
Link: https://github.com/MichaelZaidman/hid-ft260/issues/42

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index a2f4b6e5a16bb..36687c086b408 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -566,9 +566,14 @@ static int ft260_xfer_status(struct ft260_device *de=
v, u8 bus_busy)
>  	}
> =20
>  	dev->clock =3D le16_to_cpu(report.clock);

[Severity: High]
This is a pre-existing issue, but can a malicious USB device cause a
kernel panic here via division by zero?

In ft260_xfer_status(), dev->clock is populated from the device's
FT260_I2C_STATUS feature report without validation against zero.

Later, during an I2C transfer in ft260_hid_output_report_check_status():

drivers/hid/hid-ft260.c:ft260_hid_output_report_check_status() {
    ...
    ret =3D ft260_hid_output_report(hdev, data, len);
    if (ret < 0) {
        ...
        return ret;
    }

    /* transfer time =3D 1 / clock(KHz) * 9 bits * bytes */
    usec =3D len * 9000 / dev->clock;
    ...
}

A malicious device could return a clock frequency of 0, or stall the
initial feature report read (leaving dev->clock at its initialized 0).
When the first I2C payload is processed, does this cause a division by
zero?

> -	ft260_dbg("bus_status %#02x, clock %u\n", report.bus_status,
> -		  dev->clock);
> +	ft260_dbg("bus_status %#02x, clock %u, bus_busy %#02x\n",
> +		  report.bus_status, dev->clock, bus_busy);
> =20

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free
vulnerability in the event handler during device removal?

In ft260_remove(), the ft260_device structure is freed before the HID
hardware is stopped:

drivers/hid/hid-ft260.c:ft260_remove() {
    ...
        kfree(dev);
    }

    hid_hw_close(hdev);
    hid_hw_stop(hdev);
}

If an incoming hardware report is received between the memory being freed
and the hardware being stopped, the HID core will call ft260_raw_event().
This function retrieves the freed ft260_device and immediately dereferences
it:

drivers/hid/hid-ft260.c:ft260_raw_event() {
    ...
    spin_lock_irqsave(&dev->read_lock, irqflags);
    ...
}

Can an attacker time incoming reports to race with remove() and trigger a
use-after-free?

[Severity: High]
This is also a pre-existing issue, but does ft260_gpio_init() have an
out-of-bounds read when parsing the UART mode?

During device initialization, cfg->uart_mode is completely controlled by
the device. In ft260_gpio_init(), this value is used as an index into a
5-element array without bounds checking:

drivers/hid/hid-ft260.c:ft260_gpio_init() {
    ...
    if (mode & FT260_MODE_UART)
        dev->gpio_en |=3D dev->gpio_uart_mode[cfg->uart_mode];

    hid_info(hdev, "enabled GPIOs: %04x\n", dev->gpio_en);
    ...
}

Could a device returning a uart_mode value between 5 and 255 cause an
out-of-bounds read past the end of the ft260_device structure into
adjacent heap memory, and leak that 16-bit OOB value to the kernel log?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D11
