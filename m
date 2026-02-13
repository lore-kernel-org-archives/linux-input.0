Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D3361664;
	Fri, 13 Feb 2026 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002878; cv=none; b=hQsvUULuZYwl1ITQEwBKqwjwKtIRBC/2SnPLS6Yjb7ITy1hHZImuH5/1AQJttMXSF3ReqzslF0uAGweB/w769wAwqYO3AYn1LMS67BvarsCuql/MQr+IT7kyyHY/6dp21OVZzQZiWRrs7PXEBsSANqvgYP+yChrQ31r2QRh+bYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002878; c=relaxed/simple;
	bh=QgdNQfGjQmARgSLVkgxyvnLR8N26L55cwC8uLbSK2sM=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=nUQyA9Yz+LZbTz2dOZeklGWgG4bv4zk/JtSK1Z7BexzmDZnuBrDCrX0+NGKswZ7RpS+t8JfyFtRcBnPtZ0Q6Okb7KQbZye+x+3y5avHuko3jDrdgSs0UYo7x6SxsdTLWJ794sDqXgDAxjxVylCGObuxG8a+FIPd1ysPqetttg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=hODR5zBM; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="hODR5zBM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=grRG3DYuwZKkPYMV7bV5WeA82KikqE5SWdsEo80aIE4=; b=hODR5zBMHFtB6Eki7bBMldX2OE
	oJWN8DTjs8fAxiDsdVvkGlrxpyXlfnhE/upyKdGb0NNTpiLPPrZvbU5r5gB35VAixWFXqKS8lJjt/
	xesg6771zlQs+MePRykTeIJ1k5YtMy5Chx/Zcd7JfhiUnlhAivZEu4H1zYUA7LPIdio4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49782 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vqwkU-0007VX-Kj; Fri, 13 Feb 2026 12:14:34 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hugo@hugovil.com
Date: Fri, 13 Feb 2026 12:14:24 -0500
Message-ID: <20260213171431.2228814-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v2 0/2] input: add GPIO-based charlieplex keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series add a new GPIO charlieplex keypad driver.

I have tested the driver on a custom board with a Solidrun RZ/G2LC SOM
with three charlieplex keyboards, all connected thru a a PCA9416 I2C GPIO
expander.

Link: [v1] https://lore.kernel.org/linux-serial/20250924153740.806444-1-hugo@hugovil.com/raw

Changes for v2:
- Fix yamllint error for example
- Remove unused debug variable (nkeys)
- Remove support for custom linux,no-autorepeat DT property
- Remove support for custom gpio-activelow DT property

Thank you.

Hugo Villeneuve (2):
  dt-bindings: input: add GPIO charlieplex keypad
  Input: charlieplex_keypad: add GPIO charlieplex keypad

 .../input/gpio-charlieplex-keypad.yaml        |  82 +++++++
 MAINTAINERS                                   |   7 +
 drivers/input/keyboard/Kconfig                |  14 ++
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/charlieplex_keypad.c   | 213 ++++++++++++++++++
 5 files changed, 317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
 create mode 100644 drivers/input/keyboard/charlieplex_keypad.c


base-commit: ed8a4ef29da3821ee3155d3b1925fa67fc92aae2
-- 
2.47.3

