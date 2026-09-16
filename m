Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7A3F1043
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542051; cv=none; b=FXBcT07ADQEfBGCNgGFsiAKzwx++lwGTpM1zaXK/494tbyWwx3qASNmy75xNY702dp2CeCdK+vqfhCYZ1ZQ/3pcg78JusPSRZl9ckvPdz7KJr6eWLnSvDgSzJDUa88PD36StK3T53mo1Jn3/fusseUHjqPwGNPexMel5yXhS7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542051; c=relaxed/simple;
	bh=15VHq37KK3EFFSPH4QUDPhWIFIBLKGpmssDFAnjz4yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbnEpB6cl/LOozohUyE5xhRF1skCu2uYPl1QFVUxh6PFz0LCkeVCLU4SLH3HzJ4xAka5wt5w5uExiYJ8DxNd0l8U1gpqvJ7Lcii0vLixuqkkEZ6lCSZo4+PtfCgFCvejjCEfs6u9Tz9RBeuuKpL7Tbb2VK5LPJjdXfgu3g+q6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9YNEfCc; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9YNEfCc"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so472702a12.3
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789542049; x=1790146849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f6eIVfRHGn9lTWHWO+UqCxzeZX3yXWYyVss2vdTuNRc=;
        b=F9YNEfCcQfxAKESCOLrVhlsslPOhbKA6Adb5LODpD9sm9o3/PKKaxsuh1p8xfnPUXk
         5IJ6rkb9GvmWu0Y0OLDPQ3mKK5nAerPzZuSVELyJoBZG4QGx2ekd+oUTpBdbPEAP+bgy
         xn5VhaJYXgrwmJ7FpUJDzzMm0kInyzoGVB4SVAn9pa/BGtoTqCSezOb8GMI7V4FdEIfD
         5CqyGOeXaXcCCaJfw4zBOE5R+TPtX5yPD2JvifibmKxyAp4zHnbPne+u/73nINBV+0NR
         TwEBrts9ve8qnjW80J3IkyB+EzY99HaM3DyjyQXSSrWI+NzM3ib+wPR7dCd6+GD/DkGg
         V6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789542049; x=1790146849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f6eIVfRHGn9lTWHWO+UqCxzeZX3yXWYyVss2vdTuNRc=;
        b=MzBqxDKBsus5FTYsomeMmTqBxArPhf6w3gI1iOTFAtY5l4gcRhQA7dlz+wpm8nMNkv
         6kCwlbSiA2POIHRfpPlUdmAm4m1CVIoIHJSGKZ7tPn6vIIoy3aq2HKP3Oh0Da5GiKHHK
         Un2Tc3ALtOwYSOMeUhQp/U8AZbhPWY/b/8bly8v3F+G16UJ7tqXunB7bhlW5FzK14+i7
         x3r2a6Xn6f3teZYJWxhL7mc9kpiMoQH/XE68FMMsOrPveIRFnW18aSkI0+vGsbxSPSfX
         hheByjucEAIp96YQH3o4CztZgAWCDA1XJxLNCdCy0s8DNSa71GSwRUOR2r9kdGVzN7v9
         UEfw==
X-Forwarded-Encrypted: i=1; AKwUvBwgih/93jJHF+eQ8DfGKkDxEHkudgbtP1KMvFnWoPMjH9jWgmZ0hPvnG/4RejHKQpCzDCQMMOwTImhQ/Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lV/4E5Q5F5D9RncRLj0YzLVox+UV7c0OQUt0MQ8NT+vQUrVdgr
	DOXWBtaEVp3qOROgvY+EOlRqRhl2Oubx902KLCmVttwZugQkMQtEG/w0I5k7rq9+
X-Gm-Gg: AYBFou1QomDVU2oCrd0zcIHE0fCJNZ3OCeyxhrOXxlyUdBwBg5VWCXCVY3qb/U5OehN
	oCL0rOuFmXyTFfcHArzu+rIxgosK5m5Khm8durW8a39SqmD13IwMuFdzGuhE6THRmw+jmK9wAWf
	Ewz1FVfWUm3LWxjkSXpHF5n05Z7B9a5XS9WsoMmFaWz6gLLIj6c+kNV0py+VJ+6ckBP3tvhd8GL
	XJwKMMxBXYXSDaF1IDfFcZp/FkohwHgxXauowqzLZJIZ4V6omNCtkbGf7WaR1S23ssSI/JDgPFs
	nbrKW0Pj32hNdTUTDG2h/wNPTcvO5W5Wqe8aMeOLpunEixi0fLaragMLTu038TBXx2G5gkRNJo8
	IYU8XyGsbqXfTW5m9Rx4ZT5svDEdcmwyCn7mZJ4MZPWRajNJf+GTJkCZXLuDdznfvdGGcyonGFH
	4FMRY4j/P1kHVBBiSc00lrXpovGp78zsDRcjFwN1JXEGuCPM46h/wewvNJ5D0RKC/FF69jGx8r8
	/3fnhzJXa7+yto6mrHF6soj9LHeYGLykoXu5nr++7sQVit5oCY+mnZzvb1s3dLhrv4=
X-Received: by 2002:a05:6a20:cf88:b0:3db:3d0b:31fd with SMTP id adf61e73a8af0-3dd5f3f86fdmr3920854637.1.1789542049031;
        Wed, 16 Sep 2026 00:00:49 -0700 (PDT)
Received: from gwaihir ([50.125.254.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab50d67sm1040887a12.6.2026.09.16.00.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:00:48 -0700 (PDT)
From: Strider Jones <stridera@gmail.com>
To: mail@dennisfoster.us
Cc: benjamin.tissoires@gmail.com,
	jikos@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	Strider Jones <stridera@gmail.com>
Subject: Re: i2c_hid_acpi: ELAN2514 touchscreen causes IRQ flood on HP Omnibook X 14 (Lunar Lake)
Date: Wed, 16 Sep 2026 00:00:45 -0700
Message-ID: <20260916070045.52663-1-stridera@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <19e3858758e.779469783489550.85756750264043334@dennisfoster.us>
References: <19e3858758e.779469783489550.85756750264043334@dennisfoster.us>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a second machine with the same failure, in case it helps get this
looked at. Happy to test patches or collect more data.

Hardware
  HP OmniBook 7 Flip Laptop 16-au0xxx (SKU B88B1UA#ABA), board 8DA0
  Intel Core Ultra 7 258V (Lunar Lake), Insyde BIOS F.10 (2025-10-22),
  latest available on LVFS as of 2026-09-15
  Touchscreen: ELAN2514:00, 04F3:43F0 (yours is 43F4)
  ACPI path \_SB.PC00.I2C4.TPL1 on I2C #4, PCI 00:19.0
  (8086 Core Ultra 200V I2C #4), i2c_designware.2, IRQ 20
  Ubuntu 26.10 development branch, kernels 7.0.0-30 and 7.2.0-5 both
  affected; first seen 2026-08-09.

Symptoms match your report exactly. At probe:

  i2c_hid_acpi i2c-ELAN2514:00: i2c_hid_get_input: IRQ triggered but there's no data

and then IRQ 20 (the i2c-designware controller line, IR-IO-APIC level)
never stops. Measured today by binding the driver by hand with my udev
workaround disabled:

  - ~49,500 interrupts on IRQ 20 within 2 s of the bind
  - steady state ~21,500/s, all on one CPU
  - the irq/108-ELAN2514:00 thread sits in D state; on an earlier
    occurrence (2026-09-03) its kernel stack was inside i2c_dw_xfer and
    the log had repeated
      i2c_hid_get_input: incomplete report (67/65280)
    i.e. reads returning 0xff filler.
  - echo i2c-ELAN2514:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/unbind
    drops IRQ 20 to 0/s immediately.

The device's own interrupt is IRQ 108 (IR-IO-APIC, level). The touchpad
(SYNA3503:00 on I2C #5 / i2c_designware.3) on the same platform is fine.

DSDT details, consistent with your Interrupt()-vs-GpioInt() finding:
TPL1 carries two resource buffers; SBFI is an Extended Interrupt
descriptor with flags 0x05 (level, active-low, exclusive) and its vector
is patched at _INI with INT2 = INUM(GPLI). _CRS returns the GpioInt()
variant (G_IN(GPLI,...)) only when TPLM == 0; this firmware has
TPLM != 0, so we get the APIC path. _HID is rewritten to "ELAN2514" at
_INI when TPLT == 7.

Storm frequency is intermittent on my box rather than every boot: some
boots ran for days without it, others hit it at probe. When it happens
it takes the desktop down (compositor waits on the stuck I2C bus), so
I'm running the same unbind-at-probe udev rule you described:

  ACTION=="add|bind", SUBSYSTEM=="i2c", KERNEL=="i2c-ELAN2514:00", \
    RUN+="/bin/sh -c 'echo i2c-ELAN2514:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/unbind'"

Interesting aside: when hid-multitouch binds it registers the usual
touchscreen/stylus nodes plus five "UNKNOWN" input nodes and a
"Keyboard" node, same odd set you saw. When it probed via hid-generic on
one boot the primary node was reported as "I2C HID v1.00 Keyboard".

I can provide the decompiled DSDT, an acpidump, dmesg with
i2c-designware/i2c-hid dynamic debug, or test a quirk against 04F3:43F0
on request.

Strider Jones
