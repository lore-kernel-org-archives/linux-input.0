Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458729;
	b=EWs3vWoAaX7t8EzhpNtBYbnIMn419HPkm/GH3KqdWD0Wp0t4uaCbWbmgwYZzCToUHkZU
	 Mbi20bTeQwaXCj/4E6MOvZTDbUkgP7VcX9zoHNTa2fKxgrfRDnlfm642S571G+ehqBGkY
	 2f4RujpfjLH0BZ9rmLTgMCmk+Exm11s1Q8Tr6p9kA9V9EBrvYnt5YHCFwuFOr4JM68WaR
	 NAbem34vMzNvOkPaGW2x/pBCuZIdVwp5YFsx40sr5hynIAIpq9QOWWjedvdQoXNE7aS91
	 UvyGYHA8gabtTJwRLNxdhvD4wMs6JEJYUigZhbW9MYv3orzGx6wt30Zs5N86RUdnkBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458729;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w3cnyFXRTHoFwReHmudPZ5M2WczBBfc0l9gr3HBh5B4=;
	b=vwtqcwITc3olOS9pGcbrpA+ecW/phK1UVTJLWJ6f1uVQ5QdeCwnGm6KtQf2UKLlJ428T
	 Evuo9Y4hK2XEGSS1nFdsIu50mTL+LWRpSWM6RluSrXUlzv8NNclelzkiTDofPYFAtjwfo
	 V4tOovvlUicGsZzxNKFa3+M24pzxBPqK0/ZtSbe4yfc3ybktI8MW6QfzLQW1hQbgbl7Zp
	 rn+BOd7cWBUdrwxu9tvvboTAT+DLZl5ETY0gAQ/HCrQByRv+HKuS+yqajYZXdFInzO9W0
	 x+/zdi2IJ2rLOtIXuSEmpbxkt962jfJ/zapNc7E0w+r3A1xNRkU65kiNk83zOicFKNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqpqqUkm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793A606A31A;
	Mon, 23 Nov 2026 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqpqqUkm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873F61F000D0;
	Mon, 23 Nov 2026 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458728;
	bh=w3cnyFXRTHoFwReHmudPZ5M2WczBBfc0l9gr3HBh5B4=;
	h=From:To:Cc:Subject:Date;
	b=VqpqqUkmfi4DHoKE6YP7bpEvLzUv96RQgHL7OA8dKq/lyse5senryP7efA/DQlFeU
	 G7KhCVzmT7akQnmGu8o+F+6YwswzcqE91LE7xnPDU4W2u0aRrADHqRaqfRyCsPsd9F
	 9RfRdhobzagzcsJ09n80tNPXiNLIFSel+d4zHON0VgUp1MO7eFdeS17+pUsE/P1uKV
	 XWSULDlN9oFHahCFNc9I/LLeJrYpD/qCkZxWD3zz/QJtrLfsLFSS6csS5I/3zeGolP
	 8/WV0OLrgG8H1vEOua58Cx/znV6pnCH7AyHZPHLWNnzDhwq94mXnOnliFgZ6zNsuFM
	 saBdJino7XmEA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: "Cheng, Wacom" <pingc@wacom.com>,
	=?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Andrew Duggan <aduggan@synaptics.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Carlo Caione <carlo@caione.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dudley Du <dudl@cypress.com>,
	Fengping Yu <fengping.yu@mediatek.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Hans de Goede <hansg@kernel.org>,
	Ian Bridges <icb@fastmail.org>,
	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marek Vasut <marek.vasut@gmail.com>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Samuel Holland <samuel@sholland.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Vojtech Pavlik <vojtech@ucw.cz>
Subject: [PATCH 00/10] Input: assorted bug fixes across input drivers
Date: Mon, 23 Nov 2026 18:31:06 +0000
Message-ID: <20261123183200.3900004-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

None of these changes have been tested on physical hardware.

Cc: "Cheng, Wacom" <pingc@wacom.com>
Cc: "Ronald Tschalär" <ronald@innovation.ch>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Andrew Duggan <aduggan@synaptics.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dudley Du <dudl@cypress.com>
Cc: Fengping Yu <fengping.yu@mediatek.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Ian Bridges <icb@fastmail.org>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-input@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: Marco Felsch <m.felsch@pengutronix.de>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Vojtech Pavlik <vojtech@ucw.cz>

Lee Jones (10):
  Input: matrix_keypad - validate GPIO counts against matrix limits
  Input: cyapa - validate firmware image size in cyapa_pip_check_fw()
  Input: applespi - cancel touchpad registration work on removal
  Input: matrix_keypad - only stop and start active device across sleep
  Input: stinger - zero-initialise driver state in stinger_connect()
  Input: synaptics-rmi4 - check for NULL drvdata in rmi_set_attn_data()
  Input: axp20x-pek - skip IRQ handling during sleep without input
    device
  Input: mt6779-keypad - enable keypad clock before programming
    registers
  Input: pinephone-keyboard - request IRQ before registering input
    device
  Input: wacom_w8001 - use reinit_completion() in w8001_command()

 drivers/input/joystick/stinger.c            |  2 +-
 drivers/input/keyboard/applespi.c           |  1 +
 drivers/input/keyboard/matrix_keypad.c      | 19 +++++++++++++++----
 drivers/input/keyboard/mt6779-keypad.c      |  8 ++++----
 drivers/input/keyboard/pinephone-keyboard.c | 12 ++++++------
 drivers/input/misc/axp20x-pek.c             |  6 ++++++
 drivers/input/mouse/cyapa_gen5.c            | 15 +++++++++++++++
 drivers/input/rmi4/rmi_driver.c             |  2 +-
 drivers/input/touchscreen/wacom_w8001.c     |  2 +-
 9 files changed, 50 insertions(+), 17 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog

