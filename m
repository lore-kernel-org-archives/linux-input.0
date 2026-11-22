Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795355800;
	b=P7n/rmTzYvVgdxeQoK23s2ijINki51R65bBgsuEQ1WSOLqvX31CwU1STx6RUXrCdbO0w
	 UDtyPtpHIMds5ucQsNrn5grnXJjxg/y4bvgxYk4vNItJEUaT/BTqej/Y12AQPwk9AC7bp
	 RkPuPbF5h4V1+qjXQsGXtv16IcbeMihGetw1+1PfWHjQ8CYDByWhb1BYd8Pa9KagxJ+CE
	 krVAiGkeG4SL2mvT0lOXKBNPnkQO/051XXqfgplttOSoI+9w/NO1DRvufOp1YakxvX1fX
	 lrBmme/jNoy/BDT924CJLQn7tJ5Bvl/SqLXBdR4X5HVChs6xchnU7ZkT8s6q2wCG4HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795355800;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G/WdTtQSROSLrn837YYgbig1TKg++uOCFXqqP6VdarQ=;
	b=t/ziZ+98+ywzTO731E6mWF7+65zaERP35D3BF4CJRitTU48B6BhkbyvpC0fDNQbd6VYN
	 JaNiR0zdfLU17VhZcKUWiuhlgRQacmDdzaIdWGmTa+UT3TtA3rPU+PJCjjVXvjZBW5T0+
	 +Q0CAsFVT9Ct0QZuDG3zdXu6iwHELfHEwiEFUG1dc2IKD7DuF3AxZUQdDnDxvSjVAiUWP
	 PyVx8y5KODYIv/SFU4AHq+69KZ6TRRfJ4nsx5a/db31RKh1Ey0oCMB0Nna/q/gP6XGNbG
	 cCgvEhVhdbE2TCmzD7rFgwXHlRwMHL5NM/XgPjXHYmfDpba0t9hd0x/4fDkE/VHnjyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlGhsWEl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606B606A320;
	Sun, 22 Nov 2026 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlGhsWEl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076461F000CA;
	Sun, 22 Nov 2026 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795355800;
	bh=G/WdTtQSROSLrn837YYgbig1TKg++uOCFXqqP6VdarQ=;
	h=From:To:Cc:Subject:Date;
	b=IlGhsWElHygfBdeLG5MLbBSkQtgOwo+WW7E16kw0T0xmhhwLu2kEBfc5vq6oUN4X3
	 jIXxZKcYmlZOY9emTDgmhicMuAh57z7PTfbPUK1/hvyHIAcVwgbr8oCvqm50ixS5Zp
	 8JoTY9g5BsN6/bqs40/nkxeA9hVbj8CMDDkO6NYCz0X86i3lIv80B4v6sHnL7u/YeF
	 KbpZJiEeHtOUZRNFp2tAfY7gmxOK9qdiO1rtUHa4ryeimSVB75qTWWfyZGNRiOkELs
	 5JSpFNlxD1o6/bY5X4C1tfRcYStpSdwunKUsdIpkkFpfExVl+3ODYkzuq17lp6KmTE
	 bW16nP7vCVoNg==
From: Geert Uytterhoeven <geert@kernel.org>
To: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: mfd@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
Date: Sun, 22 Nov 2026 14:56:29 +0100
Message-ID: <cover.1795355432.git.geert+renesas@glider.be>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

This patch series improves dependencies for the MFD_ASUS_TRANSFORMER_EC
MFD driver and its various subdrivers:
  - The first patch adds a missing dependency for the MFD driver,
  - The other patches enable compile-testing for the input, serio, and
    battery subdrivers.

Note that compile-testing cannot be enabled for the LED and charger
subdrivers, as they have a hard dependency on the MFD driver.

Changes compared to v1[1]:
  - s/is only found/is currently only found/,
  - Add missing dependencies on I2C.

Thanks for your comments!

[1] https://lore.kernel.org/cover.1795095742.git.geert+renesas@glider.be

Geert Uytterhoeven (4):
  mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
  input: keyboard: Enable compile-testing for
    KEYBOARD_ASUS_TRANSFORMER_EC
  input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
  power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_EC

 drivers/input/keyboard/Kconfig | 3 ++-
 drivers/input/serio/Kconfig    | 3 ++-
 drivers/mfd/Kconfig            | 1 +
 drivers/power/supply/Kconfig   | 3 ++-
 4 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
