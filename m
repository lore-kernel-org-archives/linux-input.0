Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945904;
	b=3dovUEs4P5LfO9MxZzrTN/C3a5wB51ITVuO7x+nH/bj2akg2JzHeszXyWssxN1he4bbI
	 Sxs9oL8Tpc22LwgfquX+LlNvJ3oueFLgD+HM/HU8LC/aV9XZVXTrE1FUXjjM0hCQFcRrE
	 j+jbc2jsP2aPi24yuO71LLuSgu0mXah1BYEjUk4Bs92ZXCGdp43r2VkgZtBS07PpV3bNQ
	 ASmK5x5/v//gXka2DQdXiUdeim2VumO60ToSDwPwkgUSMOSWql23z085pO5GsQ0V57Hqs
	 MApP8PMaWkpbI5ZNeism63DGmUYxNlvQw6VMMiY3g0pEwcmlbyUaGSlQGs9KhODarew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rbt3Rhy1XEaIZQdvDh/UUWSNfD774dI3KIhZaPLXG14=;
	b=GoPlQBUkD71zyEQaXirwK5pabM5hqCBy4inAXRhICvmMlxfhMHEBI9MiXuvlcu+G8SS+
	 FrEWcUwzpu4mcmpGLGe6KtLfPzHzndXH+uxXmR6Mb6lJXCFtsFhg2Rzm/keRBswJllmkQ
	 DFkvEik12nYZpEdEkn356sVRtqqEVD4Qd9wu9FmHgj35k3EMP0GF0kLNkBdo1C/AkWzLy
	 fMzbFgagRJxiCyWw5+5LimYejpaJi4XKL+whmeoxWvXgZv3VtJeyHd+f4vFMts3yFdVoa
	 lrPrjQVOFoQnahvqeeUOs+KsgaMgfbfgh1slPGfeRHuM92YZfHcaGUps1Qh1Ec7wRpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Rl3RG/9/";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA97606A8AF
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 20:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA97606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rl3RG/9/
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490d59c3edaso51271f8f.1
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945902; x=1795550702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbt3Rhy1XEaIZQdvDh/UUWSNfD774dI3KIhZaPLXG14=;
        b=Rl3RG/9/xZYVC0CxWmQNFvRhK2NwjXwdPqGVzkDVM0hVx4uVtIf5s+llV6tvNAe5sL
         j8sg1nBHfVJzwU3v7Iwkm35zWbvB+T0tWqMYr2HCVCV+MdEsTqArWfYtNK013VpVBtBw
         XB10U3MY58xqgocAUcU7JPFon23tpiyycY1uJjcp51uNugRdWgLxDKkVCYMwBCBXcTZ0
         MZcyqBKLsCj394UHMGmbX9LeIWI+tlSD65ls1aIOpa0wEmirfHKlDDJWrv5wEbNU/VvS
         Qbb2KAVJJLoavkN5TLKhapxwJPG9zZeQ8N9cAsic2igbnbSOM2SYO7ERc2hYjlNRqQyx
         DVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945902; x=1795550702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbt3Rhy1XEaIZQdvDh/UUWSNfD774dI3KIhZaPLXG14=;
        b=IJij8Ep7ztGBGGSX48JPVJKtoCiKR1xDTzhTUtT13ZUdXkwCAqOHvWoOt49IPEYgJO
         f5h9xa+wGESYVlw3mMpqqATa2+e9l+y7KPWF5CuEMQ1P66tQPqF2xTaofxWjDV9hyA38
         n8B/E+znXj7kSUxyTBEntXAMttnAO2K9/HMx5hc+zgDX7KoATlP1ylgImBrOwSouBaPc
         7PnUTpkj0Efl7Htrp23ZNFS6N4y6HwBtsen0+vCOopBG4d0B+vcJZGbDt2r8TGm0LHTe
         d4j51oKqwx6HejLTo2gBp5UFvLKIQnPHstAcBuo+lqC9DUZC+Dd4dedqgLUkK1/PALMW
         aFJw==
X-Forwarded-Encrypted: i=1; AL+hErGn/qh3oyey5AvYHgDIXhFf9gRubm8rHLQM5K570QFATaR8JQ91PDLrt5OR+YIxLuolrSphhhD5gVIJ5Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+HcNFFcQjliVAMZkWwJLhTx5brMEBrUHfdlkOUNxqWRUtI0V9g
	4paUdyJpBwwqrVwNNXv/XF7DJawz19UeYMVpykkNb2LdxC0Og9HZu6pc
X-Gm-Gg: AZFdTZeuTn3HlLPFSOaidf4/nUqXbgEKpcitWxZmz1rFT8is73O7KpTlcg1TPDZzBsh
	os0kWY4l1MhWOHZfqjyP7AOBNiT8/1js7ZUQAfa5IKbOsM1CRvo0ubqK/mzHglk0LWXeexJPL0D
	hiK26HZmtUV7LXpSwNTmX5aQ+P5qhoG9r2/dCcDnFddA5ejiDMS7dDC2gexNDe6+dLGp0ebjgR8
	xkwMLQwYVx/Cqmn1h9+CflZsLXpT9U5p3ZzQ8Etx5pjJHvPG8IUKfLq2uh4Jp/NoqzZ8/YJe6Io
	OFgrUlgxBz9vKUeY+vXtrIt+F2ECv7fEwfy4O4sPBrTD2R5WGv5Krw6uuea14LBQ0hn5Str1Em0
	cbUAAslNJ4yBtwA+iM0WJI9SdRvS3ED411yk+Owa1q8LOZMGUjr0Zya66/F+lcPSPcINRDTxvxr
	rjLD8PjBCW+ne+yRMw2GerVzGYgDGo+HCwSUKlbZmNosDDW9aonWGpW5y30QjcH0s1LdIgDGeDo
	IU+DiKnIwbIRJMk0pY4ad9EMxJmy3d75lhsyWoH3t8PgW1F5NGILtlsGS5/IM+0G4uehnbYVyBH
	6CZpm/6AJBATEJetCnps5eXj37wG
X-Received: by 2002:adf:e18a:0:b0:491:d721:548f with SMTP id ffacd0b85a97d-4a3735b4463mr8160153f8f.12.1794945901961;
        Tue, 17 Nov 2026 12:05:01 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:01 -0800 (PST)
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
	Michael Zaidman <michael.zaidman@gmail.com>,
	Maarten Brock <Maarten.Brock@sttls.nl>
Subject: [PATCH v4 00/16] HID: ft260: add UART and GPIO support, plus I2C fixes
Date: Tue, 17 Nov 2026 22:04:06 +0200
Message-ID: <20261117200423.19561-1-michael.zaidman@gmail.com>
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

The v1, v2 and v3 threads:
https://lore.kernel.org/linux-input/20260822213941.98882-1-michael.zaidman@gmail.com/T/#t
https://lore.kernel.org/linux-input/20261030223637.86907-1-michael.zaidman@gmail.com/T/#t
https://lore.kernel.org/linux-input/20261114230800.1344401-1-michael.zaidman@gmail.com/T/#t

Changes in v4:

All 5 issues Sashiko reported on v3 are fixed, and patch 8 changes
after Maarten Brock's question on it. The v4 note of each patch lists
its changes, with the same words as below. Patches 7, 9, 11 and 15
change only in the context lines that patches 2 and 8 changed. The
other patches are unchanged from v3.

Patch 2:
Fixes for the issues reported by Sashiko:
- Port marked as removed at unplug; port get, activate and the speed
  change refuse it, so an open that races with the unplug does not
  use the freed HID device.
- Port taken off the list only in ->destruct, so a new device does
  not get the index of a tty that is still open.
- FIFO reset after a failed output report, and .flush_buffer added,
  so tcdrain() and TCSETSW do not wait for data that is never sent.
- Probe fails with -ENOSPC when all tty indexes are in use, in place
  of a WARN_ON in tty_port_link_device().

Patch 3:
ft260_uart_change_speed() does not take port->lock here any more,
because patch 2 takes it for the whole function since v4.

Patch 8:
TIOCMGET does not fail while modem pins are in UART function. It
reports such a line as serial_core.h asks, and RTS or DTR under flow
control as active (Maarten Brock).

TIOCMSET ignores the line that flow control owns and sets the other
one, in place of -EINVAL.

The removed flag is now added and set by patch 2, in
ft260_uart_port_remove() before the hangup. This patch only checks it.

Patch 16:
The scoped_guard() list follows the patch 2 changes of v4:
ft260_uart_port_get() and ft260_uart_port_destroy() added,
ft260_remove() removed.

Fix for the issue reported by Sashiko:
- The i2c_exit and smbus_exit labels removed, so goto and guard are
  not mixed in one function.

Testing:

The kernel is built from hid/for-next 720806515cb6 with KASAN,
PROVE_LOCKING and DEBUG_ATOMIC_SLEEP. The driver is built as a module
from the last patch.

The pytest suite [2] passed: 198 tests passed and 22 were skipped,
with no KASAN or lockdep report. 5 of the skipped tests need fault
injection; they passed with a test-only build of the driver that adds
it. Without the patch 2 FIFO fix, the two new UART TX error tests
fail: the data stays queued, and the unbind waits for the TCSETSW
caller.

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
  HID: ft260: uart: fix serial driver
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
 drivers/hid/hid-ft260.c | 2667 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 2390 insertions(+), 287 deletions(-)


base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
-- 
2.43.0

