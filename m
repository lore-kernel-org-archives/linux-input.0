Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697708;
	b=313+heVUNN1qouQcoVQ1mwY5jq5h6oAO5A7O2h5wf0+1HnMdpHUwV8paRuoNsfx8xI4z
	 tBoWHOIDzVjD+LDgJ1WZgSVHbT81BgHKBTTgE9n8p7R/aQ+I3GoW2/wvcLE3PMXwKbojN
	 mEcTvSFf544y05t/1x1drRi9o2RciX1ZOIirOnimSKtxNVhE6BBHNb/wNnqM20eMxkOZ6
	 s6VfFitu51C50FgzmLZpAXZX4nhqGvsvpfW1pFE0mGC0CTH4aLxJt5WI60/9ZjFZ53PHp
	 Esp2w4DO10P4eYg4lDnXTT+ErE40Zvn96oXpIjQgG2wa4NaN/39AcZ8D1M+qZWwJMew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g3d2XlFtP2LnL1uN6DkbrX1buq38k9DXChMowTMr+K0=;
	b=TBY0FH39ZBq0uI6HjKDDR4I4weyCSKPCNawcIEmkDBt0N5lYbTlbll0d+RpeLs6TsHQA
	 fuPtB4+znUvDUTSMRhNba9BGTaQzZv3rmOhtY7tnNePtxpEXOTpL7kKb2HHN+qcJTzlXf
	 xY6fvWwvGM7e6MKcGdJ/Cgx8KaIalNQzxwW8iD4VgYGq/9S4AlQlKq7k6DfnDF8jnKEw8
	 GlKtGQ2OzJVEF48k3RACro8xagd5qpP4C32gTy6MRrTZixMmcW4T1ft/HdQlrlEVGlqCU
	 IhG3KJfM8KodJkVeRbnnFM0df2cM2KwHJZO4dOQwTO+0F/FvMbI/pWMaghtJnR2k5Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cqdym47L;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C065606A329
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C065606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cqdym47L
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-492690dd5daso2318145f8f.1
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 15:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697706; x=1795302506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3d2XlFtP2LnL1uN6DkbrX1buq38k9DXChMowTMr+K0=;
        b=cqdym47LSl2BS1Elr7bC87OSujH+RMhsg/HcT7LTTOagTTFJzhr+DRzG/SGSHg7o1L
         hkm706DEpLPOz8zXSIJQmSjAI+HoM/bxJoUugeo8Wmnakwv500qGCxrEHYlI3E/Ocl78
         nswZRZHgll/5v1e6hpPzTaav15Gecy71Uf2IXfc0aYkLR0Fvev2cTa7ZeacZBXrITm7G
         Sq7Y5pSLA0NCjQvv56YGMGFt/ZN1rHKEzKqtFmN4r71/Oh1aSYoGyVQeF2F4xDUKcLx8
         282Xkr+QQ5tReuLuTe/ruU/T+4CrmW536BAF0BRkoEMG6mGXzeU1D8JUveJxXxyRiFOC
         yZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697706; x=1795302506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3d2XlFtP2LnL1uN6DkbrX1buq38k9DXChMowTMr+K0=;
        b=OCFU3+cfyzgVo8rP7qVtg27/2bj3mja598mzLRojTtGlVWT8mJBNNb14i/hcOABUsS
         ISmhDDJaBKmzphTezobAAT1MscavMPimsG8oXdds+c2iXgbi/OyB6Nl00F9xzFMasDKp
         4eUalW0CHIE/DpYQoXY6tUJbn1WW2aDk0jqntnlwRYzUf003XQo1oKpZhqpQiWR73te4
         8rl2h1aaapSwR48kaNeleud4Zs16dSn+HX/fG+i/h1ab74jNSI7Pah4zqsBKW6CXlKSy
         ZpFJ0HeErfcT8s0Y2tvx0qaWdxGy6Zzrb1isc7hxQk6W+GPed3jsGYHvE2m22iYB7/jv
         AfmQ==
X-Forwarded-Encrypted: i=1; AL+hErGnqW4tabuRbuHGuJdVAIX9pW5k3Ll9d5F+9rMeyiHN1qNRpgHX1H4UJKLyF0P5qL67mpfHKs3+ECmmfQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/1a9Z7KYLWyq62g69TLWm7ukRdm80Qoe4XB+1WkGcocrpSRKtX
	OAf+yo33oquhh4JtzDsZe+da8nT/VBEJdUXGyPcvuJqRWTiZTZv/D9wa
X-Gm-Gg: AYBFou2YF+7W0zyx8ZgliqErK3d1fd0meAVsfz52FNKihJ621AZ5oeAO5UGsZIdA0p+
	RVgJUdm5DUjRC7ago4jymXIVPwSskrvWPfwCdCZZpLyIWoy8U/X6HHo/C0AzrkGpB/VoVf2P/ah
	qphNYM6IVtsG0ld2qzRGfHsuXYLv0tSKz1BsOuwhZ0e2ak72oWAKE1nDTm+52CzH4Mo2vAwYcjo
	Do/sub2IuZEzPsPdCSKvlH7nI4fZx99d0oj2RuwHAUVY/1RiNDssYoiC1Dd43Niv5NDebRQR4Gy
	U6qFYPY+F3jzOtq/zhWWev5504h3J88FZwawKejBb9LP/KjDxfLitUBQmCSe7wYOia5UJoCEZ1y
	0G2WludQEFhEYUhUn8kh0FtUx/0X3UvZIboJkbk6iOt1t0G5UdvNi9Uzx5yKvGLvbeqkGHW05nc
	/BTyUHgkibD4UehKdqWVBlS09gl6HLuOzYzAgDWOGq3KNhL+dyb7RQ2nYxDYE9YFNeKPoQnovtj
	xQrk/dTb6N+UYU4SMw1jLUH6rjtamYHyScoX2KwSQi5RYF4OG2hx1t+fYk90ij8ANSBlWIkd54n
	lD4aCer9tPYJS0OQ9LCXpIcLBCm1
X-Received: by 2002:adf:e013:0:20b0:49b:b93d:9631 with SMTP id ffacd0b85a97d-49c71970581mr9775551f8f.48.1794697705616;
        Sat, 14 Nov 2026 15:08:25 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:25 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v3 00/16] HID: ft260: add UART and GPIO support, plus I2C fixes
Date: Sun, 15 Nov 2026 01:07:44 +0200
Message-ID: <20261114230800.1344401-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mainline supports only the FT260's I2C bridge. This series adds the
UART/TTY interface and GPIO on top of it, and carries the I2C fixes
made alongside them [1].

Patch 1 is Christina Quast's v4 serial driver, ported to the current
I2C code. Patch 2 holds the fixes it needed on hardware and the fixes
for the review findings in the patch 1 code. As agreed with Jiri, the
series keeps the order in which the code was developed, and each patch
keeps its own author. So the UART work is split: patches 7 and 8 add
flow control and the modem pins after the GPIO and I2C patches.

The v1 and v2 threads:
https://lore.kernel.org/linux-input/20260822213941.98882-1-michael.zaidman@gmail.com/T/#t
https://lore.kernel.org/linux-input/20261030223637.86907-1-michael.zaidman@gmail.com/T/#t

Changes in v3:

All 21 issues Sashiko reported on v2 are fixed. The v3 note of each
patch lists its changes, with the same words as below. A patch with
no v3 note is unchanged from v2.

Patch 1:
Unchanged. From v3 on, review fixes for the serial driver go into
patch 2 (the v3 note of patch 1 says why).

Patch 2:
Fixes for the issues reported by Sashiko:
- Wakeup timer shut down and its work cancelled in
  ft260_uart_port_remove(), so a tty call during removal cannot
  re-arm it; the probe error path also cancels the work.
- -ENODEV for an unknown chip mode, so probe does not return 0 after
  it frees dev.
- Port list sorted by index, so a re-added port does not get an index
  that is in use.
- TX from a work item, because write() may not sleep; no shared
  buffer, no endless loop on a FIFO reset; disabled before the FIFO is
  freed.
- TTY registered last, so userspace cannot open it before the UART is
  configured.
- UART reports passed to the tty code only on the UART interface; the
  I2C interface has no tty port.
- TX report limited to 60 bytes, so 61 or 62 bytes do not give the
  undefined report ID 0xFF.
- Unneeded ft260_uart_wakeup() prototype removed, changelog text
  corrected.
- port_activate() sets the wakeup workaround from the baud rate and
  arms the timer only when it is on, as ft260_uart_change_speed() does.

Patch 3:
Fixes for the issues reported by Sashiko:
- The gpiochip is registered without devm and removed in
  ft260_remove(), so a GPIO write that races an unbind does not use
  the freed dev.
- The uart_dcd_ri setting is kept across UART mode changes, so a mode
  change does not give GPIO4 and GPIO5 back to the GPIO function while
  they are DCD and RI.

Struct gpio_chip embedded in ft260_device, label from
devm_kasprintf(), the "initialize gpio chip" messages dropped and
"enabled GPIOs" moved to debug output (Bartosz Golaszewski).

Patch 5:
Subject reworded after the original out-of-tree commit, "Get rid of
sysfs store big numbers failure notice". The v2 subject read as if the
patch hid big values. No i2c: prefix, because FT260_ATTR_STORE serves
all store attributes, not only the I2C ones.

Patch 8:
Fixes for the issues reported by Sashiko:
- gpio_en checked under port->lock in tiocmget() and tiocmset(), so a
  termios or sysfs change cannot switch the pins between the check and
  the GPIO report.
- tiocmget() and tiocmset() return -ENODEV after ft260_remove(), so
  they do not use hdev after hid_hw_stop().
- tiocmget() cannot run before dev->gc is set, because
  ft260_uart_probe() registers the TTY last since patch 2.

Patch 9:
The err_register_tty path, which patch 3 adds to ft260_uart_probe(),
removes the UART attribute group of patch 9.

Patch 11:
Fixes for the issues reported by Sashiko:
- One reset per chip: struct ft260_chip, shared by the two interfaces,
  is added here, so a reset queued by the second interface does not
  tear down the chip that the first reset has recovered.
- Interfaces unbound before the USB reset, not after, so the reset
  does not run while a failing probe stops usbhid and frees its URBs.
- -ENOMEM from usb_control_msg() returned as it is, not turned into
  -ENODEV and a reset.

Patch 15:
Recovery info per adapter in struct ft260_device, not one static
copy, because i2c_init_recovery() writes into it for each adapter.

Fix for the issue reported by Sashiko:
- GPIO report lock in the ft260_chip, shared by the I2C and UART
  interfaces of one chip, so a GPIO write from one interface is not
  lost by a write from the other; tiocmset() reads the report.

Patch 16:
New patch (suggested by Bartosz Golaszewski). It is the last patch,
so the out-of-tree driver for kernels older than 6.5, which do not
have linux/cleanup.h, can leave it out.

Testing:

The kernel is built from hid/for-next 720806515cb6 with KASAN,
PROVE_LOCKING and DEBUG_ATOMIC_SLEEP, and booted with
kasan_multi_shot. The driver is built as a module from the last patch.

The pytest suite [2] of 206 tests passed, with no KASAN or lockdep
report. The v2 driver on the same kernel fails the new gpiochip unbind
test with the KASAN report that patch 3 fixes.

For the TN_189 workaround, a HW setup that resets the FT260 chip by
its RESETN pin ran 7,781 cycles. 101 of them hit the endpoint STALL,
and each of these recovered with one USB reset (details in patch 11).

Every patch builds with W=1 without warnings. checkpatch --strict
reports no errors. It warns once, in patch 15, for a quoted kernel log
line.

[1] https://github.com/MichaelZaidman/hid-ft260
[2] https://github.com/MichaelZaidman/hid-ft260/tree/main/tests

Christina Quast (1):
  HID: ft260: add serial driver

Michael Zaidman (15):
  HID: ft260: uart: fix the serial driver
  HID: ft260: add GPIO support
  HID: ft260: i2c: reduce driver module loading time
  HID: ft260: fix sysfs store failure notice for big numbers
  HID: ft260: i2c: reduce bus-error message severity
  HID: ft260: uart: enable flow control
  HID: ft260: uart: add modem pins control via ioctl
  HID: ft260: group sysfs attrs per HID interface
  HID: ft260: i2c: fix large write transaction failure
  HID: ft260: workaround for TN_189 errata endpoint STALL after
    enumeration
  HID: ft260: i2c: abort in-flight transfers with STOP before reset
  HID: ft260: i2c: reject an I2C clock outside the supported range
  HID: ft260: i2c: fix i2c_reset sysfs store return value
  HID: ft260: i2c: recover a bus held by a slave
  HID: ft260: use lock guards

 drivers/hid/Kconfig     |   10 +-
 drivers/hid/hid-ft260.c | 2579 +++++++++++++++++++++++++++++++++++----
 2 files changed, 2319 insertions(+), 270 deletions(-)


base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
-- 
2.43.0

