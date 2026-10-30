Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399820;
	b=jjQ/nSqYxkZaH9hxv2MhjTwv6HR+67n6CphdEhjg0HAyXj75t+KFUSLhfwqPsYkuEIVZ
	 OWuIeAM7UdP4YcexmUlW0WE2hQrRpweE7h5568KU1Fa2wlsRBVj4atdXxyR/1Cb09pnTu
	 okuBgZTfQHujPiXVPBU9d+1hAsgwiW3Nv3km1HJh2JUamIm+AQqgWckV4/zw9kPWVlqND
	 aMKGIvkEx5OVuZbDvgs6dcnEylTlXVut+09DOzrKLrz7DJeONctOKRhbvMPf83H1u8bly
	 3J/oGNeNCWvwSs7I+JtL2StdLlbB4Mu51ByKe7EZ5LdaD2Tr7oTJ3edq4PFpsgMP9HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ut+9IA7+uboYNcIm8+J4cxAe0hs4W7L46fYN/DTBCtw=;
	b=UfnY1sha8ztQN7/e9B6RoDMKkFtO2Drr3vY0l69awklqAlH9/2A9PTiUKH40xnb6ZkSZ
	 INbaWosG6Wva8tZyMhKujjhIz3/WzKABUS1tc1dXImNUD404yJHcAS432rptNE5Wti2wb
	 caVrn+5ksnGWcBfv56xjl6v4vlS8QNzr3q78+Lt7nIEHESkNdfJelyRkZG7QegfDnSsv7
	 ENOlpWyrpxjZFHj18bYgoC8RPmz2GsjdyYyAjGq+fApwX4Z2WNJlxC14tCLVA85b/1RHz
	 zIZi+kstyJ2SU/pNv1lRiI0YWv6qBkQPGkk8y14/LBUwZhHNLUgOc6ky64EGy2vUxMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LeQ3hKdr;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89976606A31D
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 22:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89976606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LeQ3hKdr
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso519102f8f.1
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793399818; x=1794004618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ut+9IA7+uboYNcIm8+J4cxAe0hs4W7L46fYN/DTBCtw=;
        b=LeQ3hKdrRiIwJ9WYm2818uTU6CMcLXU7f11PkZfTD8EzLL97P/fnUbqAy9BMBy7E03
         6NPK8ze4FplLeq+oWoDl8osUEVLq7vY0i2zZl33ZWEGfHBt3x7kjE1ug950xIjyIs/r6
         ZQTcm+jnDmaNFUNfpyD6PmhPMVbpEKR8+xqdbUxul3IDlgDYtYOLWIjzZGEoFVG5LllS
         8PvQmfguG0350jsGWGl1AosdCZq9lQTCPAZwKLE0Be979prA6RaajtpJIGRk4Skeq4m9
         EaSqtNO0hDj46Ev/wTqpwvzdMwm9j24iVUDRYeG9stAOQsATLOe+zwS8Y7891vAz745N
         Kl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793399818; x=1794004618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ut+9IA7+uboYNcIm8+J4cxAe0hs4W7L46fYN/DTBCtw=;
        b=Rqj/qJT7TFOiTi9QugSgxyoA76Oltw9WOSFJ2Ez3m1UgvJVZOA0tUI0/q682il9c6z
         mD9hsKGhYj3S+ROt+ptifi6HG31nPYObDHjw3uifUIdbc0BAr2o9GV6K0gnNBhLDYtBE
         pvLfrenqAsoKnkZwREOT2vo6TkNw2aS5EX8tsSVbkpl8jH3A2eZMTJp8omAsB6lRv3cI
         8OaVXXS1O6AAfWavp6IDxi2i1YGdw9+27k5ZFghURDYyUa9dHCv1bFxMqBi55lybIRq0
         lA8arj8niaV6h/QlwMMzXYhAC7gwu9XAaB8ywGOdlfc6c0lPu64s+fE+bff2JWVO8U+Z
         7OSA==
X-Forwarded-Encrypted: i=1; AKwUvBxN6vHvVWWhSrG0HVvUT4o5Xk8uGn7GG0mCgvRtGLSC2FhDTakH4IKFyWzBlMLFmUCG50S04xZr3tPDGw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL5yq1Fj7JyHQp8wXo2emJslG22QcqqhV23Wy8dPs2jORzjK4Ts
	zG1Xf/M/hP0zAXVjKkCfdvxOMd15Cy1FpoxFWWFllTp4eTos5i2qkQ4D
X-Gm-Gg: AYBFou29y0yRVzUomTXFiNGhL3G01cSre30zYoxZoO4mcVbRf2odjzxmpPlbRo0LbMs
	FjlXly8bB+gKVE6nnzxt19X05SylTQLkxWod2HRS7sRkbAfXtYslhoH0+7IFlRsVsuvloLrUQHE
	m7+uvI177Iy4sk49uKNx0phOn9K8psAVaP2J5sLfGP4Aufew5M0zKTIcrOsLZlTm0A/k6mO9nVq
	ALE27qAXuL6OuXlj8bdHn1fMSuBWAibKdbZBxuqoTbrlwTESGwzxDkt7xCiG+ZutqSP34SYx++c
	1Y870Lqe3H9XHPVyDlyIvkm+81WeJdKmSRa09A+Yr3Tc1zqRrjE+RjwXiHcPMca/9lhFqkoZVVe
	U+54zIYnRXBB3cpltqnCZpPLYNzBg8FJvRkFN/06lr8yfvpJpxcoeHdirQFU8p5wD2ouAf0Vm0e
	FEvA6zZtIb6jBdGuVgzJkuK1zTZGvWXNF/5S9vnR46bfctHzhtptYJwn3PEOq0ENRkRSIwRZBmJ
	QC6tXOlZeQlR9YJOxp+8sZdmOlO6gIAtZhZeo/dja4af5G/tVOJWcxACQCdLSgO6Lcb5FhmH/hi
	/o8lBwwYyWKjtCUtDlrSIN36Q/+S
X-Received: by 2002:a05:6000:2011:b0:48d:f14a:917e with SMTP id ffacd0b85a97d-48e6e2f24f9mr9160016f8f.11.1793399817797;
        Fri, 30 Oct 2026 15:36:57 -0700 (PDT)
Received: from m2.. ([37.142.145.227])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm5457300f8f.45.2026.10.30.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:36:57 -0700 (PDT)
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
Subject: [PATCH v2 00/15] HID: ft260: add UART and GPIO support, plus I2C fixes
Date: Sat, 31 Oct 2026 00:36:22 +0200
Message-ID: <20261030223637.86907-1-michael.zaidman@gmail.com>
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
I2C code. Patch 2 holds the fixes it needed on hardware. They stay
two patches, as agreed with Jiri, so that each has its own author.
Patches 7 and 8 add flow control and the modem pins.

The v1 thread:
https://lore.kernel.org/all/20260822213941.98882-1-michael.zaidman@gmail.com/T/#t

As said in the v1 thread, this series lands the current driver first.
The MFD split follows as its own series once this one is in the tree.

Changes in v2:

- Patch 1: the UART config enums are split per field and use the
  UART_ infix from the start (Linus Walleij). Lock, read_lock and
  wait are initialised before hid_hw_open(). Lifetime and TTY fixes
  (reported by Sashiko).
- Patch 2: subject now says what it fixes. FT260_UART_RI_DCD_STATUS
  corrected to 0xE2, as in AN_394 section 4.3. 0xB1 length check and
  wake-up timer re-arm (Sashiko).
- Patch 3: subject drops "on top of UART". linux/bits.h, GENMASK()
  and BIT() for the GPIO masks, FT260_GPIO_MAX renamed (Linus
  Walleij). GPIO shadow, combined direction/value report, uart_mode
  OFF (Sashiko).
- Patch 4: timeout of the last I2C read chunk from its length
  (Sashiko).
- Patch 5: a failed feature report is no longer masked; word stores
  use cpu_to_le16() (Sashiko).
- Patch 6: __func__ is printed once (Sashiko).
- Patch 8: v1 patch 10, Rio Liu's RTS/CTS/DTR/DSR polarity fix, is
  folded in, with Co-developed-by. Error paths of tiocmget and
  tiocmset (Sashiko). The TIOCM ioctls stay; the switch to the
  serial_mctrl_gpio helpers needs serial core changes first, as
  discussed with Linus Walleij.
- Patch 9: subject drops "gpio:". i2c_enable moves to the interface
  that owns the gpiochip, so it changes the mask the gpiochip uses.
- Patch 11: the reset work is flushed on unload, and -ENOMEM does not
  trigger a reset (Sashiko).
- Patches 13 to 15 are new: reject an I2C clock outside 60-3400 kHz,
  return the byte count from the i2c_reset store, and recover a bus
  that a slave holds low.

Testing: two FT260 boards, one in chip mode 0x03 with a 24LC512 and
an FT2232 wired to its UART, one with a 24C02. A pytest suite of 202
tests [2] drives sysfs, the gpiochip, the I2C adapter and the tty. It
ran on 7.3.0-rc4 with this series applied, built with PROVE_LOCKING
and DEBUG_ATOMIC_SLEEP, loading the in-tree module. The second board
was strapped to 0x00, 0x01 and 0x02 in turn; each of the 202 tests
passed in at least one of the three runs, with no lockdep report.
Every patch builds with W=1 without warnings.
checkpatch --strict reports no errors and one warning, for a quoted
kernel log line in patch 15.

[1] https://github.com/MichaelZaidman/hid-ft260
[2] https://github.com/MichaelZaidman/hid-ft260/tree/main/tests

Christina Quast (1):
  HID: ft260: add serial driver

Michael Zaidman (14):
  HID: ft260: uart: fix the serial driver
  HID: ft260: add GPIO support
  HID: ft260: i2c: reduce driver module loading time
  HID: ft260: i2c: silence sysfs store big-numbers
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

 drivers/hid/Kconfig     |   10 +-
 drivers/hid/hid-ft260.c | 2435 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 2175 insertions(+), 270 deletions(-)


base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
-- 
2.43.0

