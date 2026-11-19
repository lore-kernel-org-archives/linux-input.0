Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096339;
	b=og8pGNlU/nZamEFdgBe4t2vTBdaDwQIH5qstofwpJlGQnRWkNE3fMeKXWw9JGDgPAdqt
	 6BOX5zLzSBGTfAtbpKtxq80GlhGYrMK1H6z7rQ9sqvwhuHJ+cD0FBmb24blNvijEhd9Oy
	 TDqr4MTRuTnnLqMOJreRDOHlsOtwn/5wOaW23XlUbxC3u4xNBteVox9JTU7AP5NBVI/q9
	 XEisCXnMxT4S6yqrSOuB/qAXDqwZ4K+Ohw5pd+E0KM6wMRAf4AWyRtG2GvqxzJ6a79zec
	 mSMrrQTRVAlQAqUIC4l8TwDN1RPUI+IltMVli2n8wpXfwBhkQL8fyDsk7jb134sMC7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096339;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AMAYEv8YrNXF1Htx6L31nCeOdPyJr9slwQNX9p/dNI0=;
	b=1B8Jo+NeH2nXWWqW5Qx7Y11cS1FT59Y+J4PaZ+C2pcQ8u/5OXQD3orGwrwrJ6JbLmclx
	 3jAHgQLXAcjwcPi8M6B9CydBMQ2cJpDTSsIDnLBEfF8CjQxcqE4yGwIu6XQf+6HIZgeG2
	 2Le4EM4KJkgQaJZ+72dWCXvI58VivIhIQQxEZsu61rPXMhsF/OJ80xnpH/LvTgrrfc3Zc
	 DnvJZ8ZoEBkJy2/tQDg3cpzJqbSB6pOUSJ0aWVudyIO04RjPEaPQAtnyM+6YaNbb3d2lV
	 gENmQRbLgeEwa/qLVhhwyl/5/rBZNW/Rz92eH8rF10ff3leuk1M1ZiAtss3LAfJ4WKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA11606A320;
	Thu, 19 Nov 2026 13:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB311F000C4;
	Thu, 19 Nov 2026 13:52:16 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
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
Subject: [PATCH 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
Date: Thu, 19 Nov 2026 14:52:08 +0100
Message-ID: <cover.1795095742.git.geert+renesas@glider.be>
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

	Hi all,

This patch series improves dependencies for the MFD_ASUS_TRANSFORMER_EC
MFD driver and its various subdrivers:
  - The first patch adds a missing dependency for the MFD driver,
  - The other patches enable compile-testing for the input, serio, and
    battery subdrivers.

Note that compile-testing cannot be enabled for the LED and charger
subdrivers, as they have a hard dependency on the MFD driver.

Thanks for your comments!

Geert Uytterhoeven (4):
  mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
  input: keyboard: Enable compile-testing for
    KEYBOARD_ASUS_TRANSFORMER_EC
  input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
  power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_EC

 drivers/input/keyboard/Kconfig | 2 +-
 drivers/input/serio/Kconfig    | 2 +-
 drivers/mfd/Kconfig            | 1 +
 drivers/power/supply/Kconfig   | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
