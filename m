Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714F3EF0AF;
	Thu, 12 Mar 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338595; cv=none; b=ojqHx+UxvlYgctXcBIqFJ8daOalOamH5ANN5pcLfNqT5jSNryFl9ksBmRv3iWUunU4fQjeMF7hXSVIZvYcK6izRzLn0aGWuJ5gXM21/jgnLt99TLvXhr1BVDUOyWgwF2J1dmgR076iD3znarveVVRQQciOM8sXmqbDMjix6QUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338595; c=relaxed/simple;
	bh=OFGYfsHGmSwbtW+JBP9n7esUhzkXGYaYnKJ3B/MW9gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEobYUJ3X6nmWiLBLTpr/J5+Vzq2QZRRdbITQCTTLvHKHbf4/geYPCpiplBIx3+jxMkcg9SNwFwT239dywxb4SOQfcWS7AljB/70NpgGAIv+tlwU3BdPzFlyKlbUQ06S37Ahm88gozid+LzusSCjfy08W2/nwwJ7oVFGIjOaHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=fail (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=qMQtASNc reason="key not found in DNS"; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="qMQtASNc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=JR/B2dFDOfK/tmEdPLA1FD2R6WjIJ7KHea/shfA4u74=; b=qMQtASNc/qr6quYrPy2H+lf8ry
	jcAAZ/5H8x/HX8pKxRGVtSGKJNkhC+SG3AHMUMFVgt2wZJEL7FV1fTbA+Mz6dJzaz3S5z4h3+rf+u
	5UPUX9X+ZDMTjPxFgJhYyc+Z3cgiZXh6xKGmHsmzFjuLmu517lLsI+23PUWeKi4Y/Io8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1w0kNI-000000008Fl-00uW;
	Thu, 12 Mar 2026 14:03:08 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: robin@protonic.nl,
	andy@kernel.org,
	geert@linux-m68k.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	hvilleneuve@dimonoff.com,
	mkorpershoek@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lee@kernel.org,
	alexander.sverdlin@gmail.com,
	marek.vasut@gmail.com,
	akurz@blala.de
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	hugo@hugovil.com
Subject: [PATCH v5 0/4] input: add GPIO-based charlieplex keypad
Date: Thu, 12 Mar 2026 14:00:54 -0400
Message-ID: <20260312180304.3865850-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series add a new GPIO charlieplex keypad driver.

The first two patches simply commonize two properties that are present in
a few bindings, so that the actual patches for the charlieplex keypad driver
can reuse them instead of also redefining them.

I have tested the driver on a custom board with a Solidrun RZ/G2LC SOM
with three charlieplex keyboards, all connected thru a single PCAL6416 I2C GPIO
expander.

Link: [v1] https://lore.kernel.org/all/20260203155023.536103-1-hugo@hugovil.com/
Link: [v2] https://lore.kernel.org/all/20260213171431.2228814-1-hugo@hugovil.com/
Link: [v3] https://lore.kernel.org/all/20260225155409.612478-1-hugo@hugovil.com/
Link: [v4] https://lore.kernel.org/all/20260305192101.2125660-1-hugo@hugovil.com/

Changes for v5:
- Add Reviewed-by tags (Rob)
- Replace GPIO with line in settling-time-us property description (Rob)
- Reorder Makefile entry (Andy)
- Change copyright date to 2026 (Andy)
- Change some signed variables to unsigned (Andy)
- Move some variables declaration within loop (Andy)
- Add proper labels for GPIO pin names (Andy)

Changes for v4:
- Fix indentation in comments (Andy)
- Add missing includes (Andy)
- Remove OF dependency (Andy/Dmitry)
- Uniformize return code variables to "err" (Andy/Dmitry)
- Change signed iterator to unsigned and move within loop (Andy)
- Remove unused platform_set_drvdata() (Andy)
- Fixed typo in cover letter PCAL6416 (Geert)
- Changed name in bindings example (Geert)
- Added pull resistors to bindings doc and example (Geert)

Changes for v3:
- Add ASCII diagram in bindings, and reference to it in example
- Reorder properties alphabetically
- Add patch to define common input settling-time-us property
- Add patch to define common input debounce-delay-ms property

Changes for v2:
- Fix yamllint error for example
- Remove unused debug variable (nkeys)
- Remove support for custom linux,no-autorepeat DT property
- Remove support for custom gpio-activelow DT property

Thank you.

Hugo Villeneuve (4):
  dt-bindings: input: add debounce-delay-ms common property
  dt-bindings: input: add settling-time-us common property
  dt-bindings: input: add GPIO charlieplex keypad
  Input: charlieplex_keypad: add GPIO charlieplex keypad

 .../bindings/auxdisplay/holtek,ht16k33.yaml   |   5 +-
 .../bindings/input/cirrus,ep9307-keypad.yaml  |   7 +-
 .../input/gpio-charlieplex-keypad.yaml        | 108 +++++++++
 .../bindings/input/gpio-matrix-keypad.yaml    |   5 +-
 .../devicetree/bindings/input/input.yaml      |  16 ++
 .../input/mediatek,mt6779-keypad.yaml         |   1 +
 .../devicetree/bindings/mfd/fsl,mc13xxx.yaml  |   2 -
 MAINTAINERS                                   |   7 +
 drivers/input/keyboard/Kconfig                |  14 ++
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/charlieplex_keypad.c   | 223 ++++++++++++++++++
 11 files changed, 377 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
 create mode 100644 drivers/input/keyboard/charlieplex_keypad.c


base-commit: 6d4b67a2a76a4ff2393fe88119ae4332821b82b4
-- 
2.47.3

