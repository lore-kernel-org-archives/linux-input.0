Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E337DE92
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587798; cv=pass; b=uI4oZCPrVvlC8jJNzxc39Pm+VftiwUV/RYtnPxuqekJ9gSH3w+W9bSZnbUjt23rCQS0gKxNiASOEQIcacSpPQ7oyXyLYnmCRgm5rWFnIBeOH1mUnr71W7iPjYnQrUfEIJOAUsUSSNlWRwqxA3kLXVCZ/zjzWl5Rs1ZLftw+hOtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587798; c=relaxed/simple;
	bh=xF/xDdGLaN60v3KrZg8JRwjzS+7vle4tIji8yDZpsZo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MPlyZYX4SO0sf0qNv4cRhPBpNPkbkU/Yzg/9ioeRQTneD9HGUYrLvszy6B0MVuMG4hdk9gxSbswPpOWBtDSTIPAsMg7hubySXvNklgC8pqZHvDwBU0YsNQdccbF6LxI5ARKE+CXmptb/AD1vnOIFfx08Ro3bgE9et4ZMfGvCPW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFwOrdc2; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFwOrdc2"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68bd4aec7b0so126746a12.0
        for <linux-input@vger.kernel.org>; Thu, 04 Jun 2026 08:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780587795; cv=none;
        d=google.com; s=arc-20240605;
        b=ZKhT0Z2lZc3FTOVRdG+fZFAVWV435piqP54e00OScVQB3zkSmi+qcz+sNi/9Zcvt3D
         8LyOGh8y3MNW3rx2oyOvlvPB3Ixj5D6ajUTnGD2EVaWwxsX2kUVv13qsEzcbLV/r7Rwb
         90+YXGxOYJgdvL2Jo6g+GgoFjKykvOAWsgBwlF2YiY34kdFCJHvrdDvgsaPAkGuvwQEH
         d0+6eeteaDi+hcUm+LkuDIQhEP13qCn2/+nFfKWfZKYTU66+dClZ8TjAVCyiZvdZSSJU
         EjJQF1tOa0XhyVVTAC/yPD2iWmNBlYPsK48bl7X0fOnRZCflxOdich6IVv94wrkw7JbQ
         Gy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=bLv6DLN3xdxjaftKSIdzPbh45mexUpP7ls3tzx5curI=;
        fh=XwKj7gG9OVj1Dec5bs1DuxS01yfr9xd2DnJG+jlzAhs=;
        b=TH9I1ZmbU6gEBvui4QUXZuRBYM5eC/4NXSFwk3SWy59tfEjj8pnsOckMgrrteX5HHx
         vJiYUuJ7t1a1B6IFW96mpux7dHUpYBSnzmY8otdBEpDIphuK05wH+jWuYkPWPqkeY4cT
         FdKkS942nP2ZLTdFrrS8R200oz5/WHrKSj/7usi1qbB0LjXq7B8Kxs/5ulituT3npqvU
         dQ9+mMb8Lvqmhj1aHjOOSkoNNKNr/kj7o7Q912akBLIesxFwmXDroKtA+hZm7M0nVlGs
         Ky3uZNIZaSKqy15JfIiNoJL45RNMT0/MdKCYm6eArzpJySpqctdud5juKbX8dF/uPxI+
         7/VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780587795; x=1781192595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLv6DLN3xdxjaftKSIdzPbh45mexUpP7ls3tzx5curI=;
        b=JFwOrdc208pTpMREhNk0yOOGsxVLjH5usjlS3YADQsi0uvqWvTZdsbEN43F+n9AwTI
         F9kmJn/bxG6n4bLYR1Uh38qI39Epv7MSW5ttPaS8BKLD8+QC3dgmQbMitW+iJCZp8Yfl
         xcG3PZk30QMt4IVuGet4w+kXngfqhQaNasYSwJztnPfJmdpkpNVS8k5H5mMZIRDfGALY
         EM+7Le8octBRzlx4K9KkGnci/y1h+lmp/2MXvczPnAKlSn+HpOAmWb5MdowIWS38FBTu
         SmdgYstP3QEEeIR1DuTQS2YPck6Mh6DI1lDDyrek3TYEwjlBVlJFbyLQXqCEzPGUKQey
         cxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780587795; x=1781192595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLv6DLN3xdxjaftKSIdzPbh45mexUpP7ls3tzx5curI=;
        b=tNjfy84XjhDaY4CfVNyvpKxhXxcF57lH7vV7eG8qXQ8frNciUNHz5PZvssAONXe7sL
         mvMc9hvDmNYx2jIzkTAf/3SMABpE7TO7bXua+3F27bDeBETrI2pmGSAWtJVkUxHG9lTQ
         M03N6dXUhigvDHxlyLLe9BBMODI2w6/VTy4xvawhZKasSdjOV9Izk7Mc0ZtPxepSPHox
         FJbgBkUgpX/yaRfDrzIStgCbzaxSp5vM93Jg4DRUdF1prNHXxbBC2p1a9mhSnbvfcyD6
         3EcsB0RfrHaIkMUoFN0LQA5vwkUcOG0zG0z8RyU/cisgjB70tzg6TLdWPezLFE+rxFcq
         oi7Q==
X-Gm-Message-State: AOJu0Yw6whbdV66i0j/OHUlKX2R/8EsUtrTjPOQXdzT/0/V2JsQazWCB
	o3/FDuvNy8KL9JVAsNsafDoPI+jEsWXQ+gajKl/7nIaCxGRn8W+HQI2IRxZ93LpSnu3cuk0tCR1
	geeHUkoWfXFW5yClF/b/vzXRhkdViMaVwpl07
X-Gm-Gg: Acq92OEJbHWdp5S7E7ZodG2V678VQQNbC55zrxFcsTGl1yP7UmcaStEnkymuXIhknh+
	Yf9jyaM8216jtrnLGQwq/9PcZqxdgCJ/Ipv4WU98+N5Z7c0UHSsTEYuT4n3/UOWJdjwsQhVlIlW
	LxFBoZYgMKf+ow8M+uLxSU+j+tSeKAmJBRYQJhAZgTGM0PGq6llGf9DneQo49WQL3+YB4lY6tBa
	9TkopjBE7iIf08eola983c9eBuLIKdZgtTmS3NuaMfwTcu7VJwWuJkGzyiKDtfKXK3XmnQIkURS
	adorR6DgQrsiZPZxEXY=
X-Received: by 2002:a05:6402:4585:b0:670:8ccd:704a with SMTP id
 4fb4d7f45d1cf-68f3ed9e9c8mr824858a12.5.1780587795121; Thu, 04 Jun 2026
 08:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Orlando Ulises Aguilar Rojas <orlandoulisesit@gmail.com>
Date: Thu, 4 Jun 2026 09:43:02 -0600
X-Gm-Features: AVHnY4LdlNpOF7JHwNf8PU4kuakHAj_CA4_d8ht9SGOaXdiYhOTQfO2HLxfQmMU
Message-ID: <CAE=pYEp=RZCeRbAtweZ0_zkPr7cUZUu=uoDRkqko7xduVUMEKA@mail.gmail.com>
Subject: [REGRESSION] Sino Wealth 258a:002a keyboard enters stuck shift state
 on USB disconnect
To: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I am reporting a regression that I first observed in linux-zen
7.0.8-zen1. The zen-kernel maintainer (heftig) confirmed that the
responsible commits also landed in upstream stable 7.0.10, so this is
not zen-specific:
  - HID: pass the buffer size to hid_report_raw_event
  - HID: core: introduce hid_safe_input_report()


--- Summary ---

A Sino Wealth 258a:002a generic mechanical keyboard (Machenike K500)
enters a permanent "stuck shift" / modifier ghosting state when any
other USB device disconnects from the host. This worked flawlessly on
7.0.7.

--- Root cause ---

Before these commits, a report where csize < rsize returned -EINVAL
and was discarded in hid_report_raw_event().

After the commits, the same condition is silently zero-padded and
processed. Additionally, drivers/hid/usbhid/hid-core.c was updated to
call hid_safe_input_report() passing urb->transfer_buffer_length as
bufsize instead of urb->actual_length. Since the USB transfer
buffer (typically 64 bytes) is always larger than rsize for this
device, the new bsize < rsize early-exit guard never fires. The code
reaches the zero-fill path unconditionally.

This produces no kernel warnings =E2=80=94 dbg_hid is not visible in normal
dmesg =E2=80=94 which is why the fault leaves no trace in the logs.


--- Affected device ---

Bus 001 Device XXX: ID 258a:002a Sino Wealth (Machenike K500)
USB Host: Intel xHCI 0000:00:14.0, port 1-2.2

This keyboard uses a non-compliant NKRO implementation. It registers a
spurious mouse interface alongside its real keyboard interfaces:

  SINO WEALTH Gaming Keyboard        -> input0 (interface 0)
  SINO WEALTH Gaming Keyboard        -> input1 (interface 1)
  SINO WEALTH Gaming Keyboard Mouse  -> input1 (interface 1) <- spurious

That spurious mouse interface has always emitted short/malformed
reports. Under 7.0.7 those reports were safely discarded. Under 7.0.8+
they are zero-padded, processed, and produce a modifier key event with
Shift held.


--- Exact trigger ---

The fault occurs at runtime, not at boot. Boot dmesg is structurally
identical on both kernels.

Trigger captured via udevadm monitor: when a separate Realtek wireless
mouse receiver fires unbind -> remove on the USB bus, the Sino Wealth
spurious mouse interface reacts to the hub topology change, emits a
short report, and the zero-fill behavior causes the keyboard to output
"!@#!@#" (Shift held). Physically unplugging and replugging the
keyboard does not clear this state; a system reboot is required to
restore normal functionality.


--- What does NOT mitigate the issue ---

  - Forcing power/control =3D on on the device USB path
  - usbhid.quirks=3D0x258a:002a:0x00000004 boot parameter


--- Suggested fix ---

Reconsider the zero-fill path introduced in hid_report_raw_event():
the pre-7.0.8 behavior (discard short reports with -EINVAL) was safer
for devices with non-compliant NKRO implementations that have always
emitted structurally invalid reports.

If the zero-fill behavior is intentional, adding 258a:002a to the HID
quirks table with a discard-on-short-report quirk would be an
acceptable mitigation.

--- System ---

OS:             CachyOS x86_64
Working kernel: Linux 7.0.7-zen2-1-zen
Broken kernel:  Linux 7.0.8-zen1 through 7.0.11-zen (upstream: 7.0.10+)
CPU:            Intel Core i5-13600KF

dmesg (working/broken) and udev runtime event logs are available on
request, or can be viewed in the downstream zen-kernel issue:
https://github.com/zen-kernel/zen-kernel/issues/414

Thanks for your time.
