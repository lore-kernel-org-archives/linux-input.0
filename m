Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464610;
	b=b8BHVXEqXyEoUnjSSDm2neJj3WnWZW9cmpEIuRW1mZx1oqLMZmfirSns7H77xKmI70Jf
	 WvVJAMfpNDI7HkZPQMyABlSmWseEHPB7ki6p9Zgr2QczoQPBvoHZkm9vzJA10p1tFWch9
	 6OQmpLXx/+VyFy4fNogoNvAiVDtxoKfK2nbcVabbEt21PRqrV6na2UJovzgnnqxJHaX7M
	 qsfuXaoa79hdjHifBz1no9Q1mSHfjWm423TrBghEa8+xKpMnGkGx/tRvzasTCq3+UqJB6
	 9WmUNfXJAc844yTEA9m6Me85GT/Am+OQddwyf/Jt3ALiri+XnjTk6gCwHwbs1vo83pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464610;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=U2e9p9Zu2nlVnVyFNep9yFbR1shK1d65RtzIIpMIIdo=;
	b=Un3QC5mILNLA78fQis5XYkr6ACtPoqjGe9b5yTjqgvfbC5xCYeYFCZSsEs/HP44pqJ1m
	 FJNU8ywdENlTmXcCcucF8l48Z/llV3Mz60lPp9U1R5c5xriRhJhGuu0LM5axDQHWRhuCk
	 BSKtOTCGoST+lXOhgawrUg6vFlejG3L1tGekM2woACKydSU3j9hqFSAZ1gzUcxkgatppk
	 H6B9fQEfGBJOzVi03tMfeyNXG7wUsP0ur8uLFygvuMWlCVO1+rEJqfwJeqJR9sJBpzLXd
	 +9gspYrqfyjlyXsGtQ26VOkEhcIIvr5RFBXqMTNX2ofjCznuIqvSyIObuzAa3cjsI3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=klTIdqvQ;
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23859606A31E;
	Mon, 23 Nov 2026 20:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23859606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=klTIdqvQ
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E8251320FA5;
	Mon, 23 Nov 2026 21:10:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1795464607; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=U2e9p9Zu2nlVnVyFNep9yFbR1shK1d65RtzIIpMIIdo=;
	b=klTIdqvQapbuVOF0KW+jZQxGr94jFISNywTRBzh4U1KRcnuL2e1/9GdjRGE40GAEvLUpI8
	qcR3Ln56Q67v0aQTgs5Azw5s9sBI/yuCqi3tX7tP/Byl2sI4OFAmiu9pDiWARikGWU+yCN
	NIXyv++BHewv2lDc5aS4HcyWgXkqjo4bPY2i4u8g0hgeWcUL3JsUVRcihn+YueMedoACqj
	5SoGsCcJBfZPJX53P3a0nigAnV4oRJUP4zGxZZ3WvgnOsyGWZ5iZrFEYNNffrIR2XO3J54
	/QjibKbknCurtGJQP0SMpEzkcvidBw3BhL4BmFLnbI7Hud2a9GVu0xcaBJPVxw==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: pulsar: complete the list of supported devices
Date: Mon, 23 Nov 2026 21:10:06 +0100
Message-ID: <20261123201006.66163-1-nikolas@koesling.info>
X-Mailer: git-send-email 2.56.1
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
X-Last-TLS-Session-Version: TLSv1.3

The Kysona M600 V2 and the VXE Dragonfly R1 Pro are supported by the
driver but missing from the HID_PULSAR help text. Add both, list the
M600 V2 in the header comment as well and fix the formatting of the
M600 entry.

Signed-off-by: Nikolas Koesling <nikolas@koesling.info>
---
 drivers/hid/Kconfig      | 3 ++-
 drivers/hid/hid-pulsar.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..7442197f5760 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1375,7 +1375,8 @@ config HID_PULSAR
 	  Provides battery level, voltage, and charging status
 	  monitoring via the power supply framework.
 
-	  Additional supported devices: Kysona M600, ATK VXE R1 SE+
+	  Additional supported devices: Kysona M600, Kysona M600 V2,
+	  ATK VXE R1 SE+, VXE Dragonfly R1 Pro
 
 config HID_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index a1f0dcda92df..4046d6a5a845 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -9,7 +9,8 @@
  *		- X2A
  *		- Xlite V3
  *	- Kysona
- *		-M600
+ *		- M600
+ *		- M600 V2
  *	- ATK
  *		- VXE R1 SE+
  *	- VXE

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1

