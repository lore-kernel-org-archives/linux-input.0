Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0B1FCFEF;
	Fri,  5 Jun 2026 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643027; cv=none; b=oI/vB1oP4kwt2vQlsBDriGqpZmcPq7FwXZy7sF5NzmUwxsbEzkPaM7vxb3/TK/cTX3yantpXjxbjOQedN4yIVRN1pKvffoj8ORou8bJpJ3OILTbHJwswd0/eSxcwAR/XzzFu+P+pgOtgwk5J2GWjOMd1vrUkORSYGx308vDviaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643027; c=relaxed/simple;
	bh=LDhNLU/eqAKEdxuLB19vSkHwp8j2Cx4hdelP1za4lIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUj9YfEfibrT0pIcqu2LvbCB+/WEcCOr8CPqkgVc0n/bBdo0EqYnM11X64P+t4qfEMqsJyTiAP1BY5W/8Fy0aLHFfR/Osjuyx/K7wyc9Gs/bW5p8mdjLC13WSCU0xFCMowypw2fdQrHvnRFv9rp9xjGCKk/EDF++HAFXhXLchgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlFMrhXS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlFMrhXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A261F00893;
	Fri,  5 Jun 2026 07:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780643025;
	bh=d0lNIUYbaJpxJPUjbObqZ5hC9LAq9HJV/MiAblmp2XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jlFMrhXSOKgRX36HamaKINA7dZTeooGX1aHruR4WM56RRIOWCAF7cvJ2kdHL8u/b5
	 AgM7rqgKGMDfdBXbIRQQXbXPifvENmiQVVqTdrx7YHoQJ+Vq9SMFd6r71+l5RsHHs4
	 s7FCKuNISYa+L1QFpPUL9tnllSI1u2mRldnmwle3dIcEozENHKRP3wJ7Xp9hwJOwHJ
	 HRIM/YywG/HVD5JswPYmxH6/3krgFXKz9epknM+x5Xivw+tA9c2e611ytW60wQcE0U
	 HwmMYYeKkHMNJGkJ6RKHNp9H7pt9NKbDpjUU+yvimMNLmLLIwHRsBfSKdCZG0Pnf+r
	 MnfxuHbHcfsbQ==
Date: Fri, 5 Jun 2026 09:03:42 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Orlando Ulises Aguilar Rojas <orlandoulisesit@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
	benjamin.tissoires@redhat.com
Subject: Re: [REGRESSION] Sino Wealth 258a:002a keyboard enters stuck shift
 state on USB disconnect
Message-ID: <aiJvV_DEOOFcqTtZ@beelink>
References: <CAE=pYEp=RZCeRbAtweZ0_zkPr7cUZUu=uoDRkqko7xduVUMEKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE=pYEp=RZCeRbAtweZ0_zkPr7cUZUu=uoDRkqko7xduVUMEKA@mail.gmail.com>

Hi,

On Jun 04 2026, Orlando Ulises Aguilar Rojas wrote:
> Hi everyone,
> 
> I am reporting a regression that I first observed in linux-zen
> 7.0.8-zen1. The zen-kernel maintainer (heftig) confirmed that the
> responsible commits also landed in upstream stable 7.0.10, so this is
> not zen-specific:
>   - HID: pass the buffer size to hid_report_raw_event
>   - HID: core: introduce hid_safe_input_report()

This is... surprising:
these commits are restoring the previous behavior that has been running
under linux for the past 20+ years, that was broken by 0a3fe972a7cb
("HID: core: Mitigate potential OOB by removing bogus memset()").

So basically, there was a short period of time in 7.0 (it was introduced
in 7.0-rc5) where the device would have been working fine.

Can you check if kernel v6.18.21 (the last one before 0a3fe972a7cb was
backported to the 6.18 series) was also showing the behavior? I strongly
suspect it will, unless there was a USB change that also triggered this
bug.

anyway...

> 
> 
> --- Summary ---
> 
> A Sino Wealth 258a:002a generic mechanical keyboard (Machenike K500)
> enters a permanent "stuck shift" / modifier ghosting state when any
> other USB device disconnects from the host. This worked flawlessly on
> 7.0.7.

ouch, very much ouch

> 
> --- Root cause ---
> 
> Before these commits, a report where csize < rsize returned -EINVAL
> and was discarded in hid_report_raw_event().
> 
> After the commits, the same condition is silently zero-padded and
> processed. Additionally, drivers/hid/usbhid/hid-core.c was updated to
> call hid_safe_input_report() passing urb->transfer_buffer_length as
> bufsize instead of urb->actual_length. Since the USB transfer
> buffer (typically 64 bytes) is always larger than rsize for this
> device, the new bsize < rsize early-exit guard never fires. The code
> reaches the zero-fill path unconditionally.

Yes. This is expected

> 
> This produces no kernel warnings — dbg_hid is not visible in normal
> dmesg — which is why the fault leaves no trace in the logs.
> 
> 
> --- Affected device ---
> 
> Bus 001 Device XXX: ID 258a:002a Sino Wealth (Machenike K500)
> USB Host: Intel xHCI 0000:00:14.0, port 1-2.2
> 
> This keyboard uses a non-compliant NKRO implementation. It registers a
> spurious mouse interface alongside its real keyboard interfaces:
> 
>   SINO WEALTH Gaming Keyboard        -> input0 (interface 0)
>   SINO WEALTH Gaming Keyboard        -> input1 (interface 1)
>   SINO WEALTH Gaming Keyboard Mouse  -> input1 (interface 1) <- spurious
> 
> That spurious mouse interface has always emitted short/malformed
> reports. Under 7.0.7 those reports were safely discarded. Under 7.0.8+
> they are zero-padded, processed, and produce a modifier key event with
> Shift held.
> 
> 
> --- Exact trigger ---
> 
> The fault occurs at runtime, not at boot. Boot dmesg is structurally
> identical on both kernels.
> 
> Trigger captured via udevadm monitor: when a separate Realtek wireless
> mouse receiver fires unbind -> remove on the USB bus, the Sino Wealth
> spurious mouse interface reacts to the hub topology change, emits a
> short report, and the zero-fill behavior causes the keyboard to output
> "!@#!@#" (Shift held).

That is seriously wrong. It's not uncommon for keyboards to expose a
mouse node when the support "macros" that you can configure in their
firmware. That allows them to send button events, or even control the mouse.

That being said, if your keyboard reacts to USB events from other
devices, then there is something seriously wrong in the firmware.

In any cases, the fix is not to revert the restored behavior, but to fix
your bogus device.

> Physically unplugging and replugging the
> keyboard does not clear this state; a system reboot is required to
> restore normal functionality.
> 
> 
> --- What does NOT mitigate the issue ---
> 
>   - Forcing power/control = on on the device USB path
>   - usbhid.quirks=0x258a:002a:0x00000004 boot parameter
> 
> 
> --- Suggested fix ---
> 
> Reconsider the zero-fill path introduced in hid_report_raw_event():
> the pre-7.0.8 behavior (discard short reports with -EINVAL) was safer
> for devices with non-compliant NKRO implementations that have always
> emitted structurally invalid reports.

No, this is not possible, the behavior was restored because it broke
several devices.

> 
> If the zero-fill behavior is intentional, adding 258a:002a to the HID
> quirks table with a discard-on-short-report quirk would be an
> acceptable mitigation.

Well, you have 2 options actually:
- write a new kernel driver that maps to the device and discards short
  reports emitted on the mouse node
- or write a HID-BPF program (see
  https://libevdev.pages.freedesktop.org/udev-hid-bpf/tutorial.html)
  that does exactly that as well, but it's simpler to debug/implement
  because you don't need a full kernel rebuild.

I don't see the benefit of adding a new generic quirk for fixing 1
device.

If I were you, I would seriously lean toward a HID-BPF program, because
that's much easier to write and test.

Cheers,
Benjamin

> 
> --- System ---
> 
> OS:             CachyOS x86_64
> Working kernel: Linux 7.0.7-zen2-1-zen
> Broken kernel:  Linux 7.0.8-zen1 through 7.0.11-zen (upstream: 7.0.10+)
> CPU:            Intel Core i5-13600KF
> 
> dmesg (working/broken) and udev runtime event logs are available on
> request, or can be viewed in the downstream zen-kernel issue:
> https://github.com/zen-kernel/zen-kernel/issues/414
> 
> Thanks for your time.
> 
