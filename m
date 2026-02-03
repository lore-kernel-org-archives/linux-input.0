Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C83C198F;
	Tue,  3 Feb 2026 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134771; cv=none; b=LTZX3p/q5tWHDEjiTTh98UllkJd+NELAQaJyv0XTYm7H6IwppFXYW+CQ1H4qE5XRffVvSTCFjxPgu6wE3axorcYLYz+/rWCQ4Fbded/OD172Vs+SDQEyb1mUAPmolotj/B0JpPO0b+PUqfLbgEwn4+c5jzMbjnQUKoMQWMRYJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134771; c=relaxed/simple;
	bh=0LAmB812iyj9zmW/euXRvVW7EvM2Y0+uob/pzAN78DE=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=EsTPuNgga8hmzUg0K2EUMfmpfoeOWv9JEtO5YfhfTUqmsVFFQkShxsYCjvg99W0h3OY1pcFX4qyJ75V/fFBseduVsmdHcqYvb+JRhb4GJ0hkQmq4DOB+BwAITctfXadpAPRU4R/lIIsuMfHgnD2j7W5ALehkHW9mrgitZksJk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=rdbePBqf; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="rdbePBqf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=aYGVyeZ//rBGZUOON5iROdUT5Y8ysUNZDJxfBY/jK04=; b=rdbePBqfLvbAk2Pe7raKUVaJLc
	br7MLaa4qrDZE2T/Vudt0fGvvxxafFRLemctQR2TCBKg2TGuxiJZDbpO1aDYGZXUHycrVvH9WagEi
	CtuwvsaUcTbIL+JK4DCxHWBuDOZC6OuXWpyuos8p5R4tiKJDTF8aEd//Ydwnso9Aml78=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:53840 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vnIfa-0000uz-KA; Tue, 03 Feb 2026 10:50:28 -0500
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
Date: Tue,  3 Feb 2026 10:49:46 -0500
Message-ID: <20260203155023.536103-1-hugo@hugovil.com>
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
Subject: [PATCH 0/2] input: add GPIO-based charlieplex keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series add a new GPIO charlieplex keypad driver.

I have tested the driver on a custom board with a Solidrun RZ/G2LC SOM
with three charlieplex keyboards, all connected thru a a PCA9416 I2C GPIO
expander.

Thank you.

Hugo Villeneuve (2):
  dt-bindings: input: add GPIO charlieplex keypad
  Input: charlieplex_keypad: add GPIO charlieplex keypad

 .../input/gpio-charlieplex-keypad.yaml        |  88 +++++++
 MAINTAINERS                                   |   7 +
 drivers/input/keyboard/Kconfig                |  14 ++
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/charlieplex_keypad.c   | 223 ++++++++++++++++++
 5 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
 create mode 100644 drivers/input/keyboard/charlieplex_keypad.c


base-commit: ed8a4ef29da3821ee3155d3b1925fa67fc92aae2
-- 
2.47.3

