Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795355802;
	b=j3/KV6+sZe5+28wO4+WKloiBN0oTbR63jgIH7qZrgyl/8lL05jJeM4fkRL4eOEbAzvOu
	 bPjJCw/GuqiTaH4A4O4yPXXHAG/hqBsm/mMhfodGJeNonhrcA5Gj4c7n0v9nLqCND2UOv
	 MhHu5fgkkuEydH46JjNrEu+uXuQW764ozcQV7xurm7BPrJJSPKtAQ6afQP8+aLuy+cmNg
	 xB6kzbDTwQxnl9ROS0GBWHQZhxVMFTpHjLpBsjavq6krJasu6Z3sfNp+2w6DW5tU9DU7n
	 hcpPSiKpQrNuqASm/7IzzE7byZ0PYTAOkuUZJjXCnbJcUzUi3qtLBSJmWx+LCUImjHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795355802;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PA3crHdm9uzFAnFkW2A1LJCtJxFu/8IaBFADCEA/6DU=;
	b=Jm0PC2h+/owulOtuNtMdqYv2Au63zfnORYxKY0XJZI2btsmVXPHaGGIOQMHA8r2MCg1+
	 5jTdxiq9cnHtmAd7LryUg3ViotkjAXWU6mtjAkaJ4URHKSJEVXzpTgHa8pObQ/DYBDttt
	 VlVqR8JwihLKKEuPZ6UZOTlXeIfcRO6RKWJM9rVU5CzyecgQYJiqkoTGiRwQXJc5IWkqi
	 bg1x4GI7WxZyNTTu522Yo1h8cxQS4SHb04bkmz/MVLCjg/+tS1AZMw2Vqg2B6FvsbnjNb
	 9+pFGgT66qR60ysxQYQNgH0V/YzFm7WhWuc/wE9kBjQgLCpVwvXF6ahvnNaD4lK6B1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJ2SiTlF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7D606A32A;
	Sun, 22 Nov 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJ2SiTlF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934321F000C4;
	Sun, 22 Nov 2026 13:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795355802;
	bh=PA3crHdm9uzFAnFkW2A1LJCtJxFu/8IaBFADCEA/6DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LJ2SiTlFipYonMcEj0Qee3LluqdJDx0SaHk9dMnCDe2KEhdor1vEtUQMvnL0+9rDq
	 CyuXCCFcBRQz6qoJH2xqG5HTCqXtmFgshBW8ZmUkc4TWtRcaeLVZ6Mi2X9KknPBp+l
	 Y0NfAyYnt+bf80XHdlAlm90Bl55dCh1j/KmYGopH4ZtDyqCkEgQT4wkuRIhYJjujlF
	 Yy+25RyXOUsvkJZf+34zwixAryYKvbBA3jGJ7T6xZ6OsFSNN/W9FeuZIHfsx2N2CaI
	 7MxigOY/3MbzXctTnuLRp2hDaJUovHAB8Cb5XSlfiGBTpV+cxWCHl9z86daZ8hrd61
	 MUypyKMlBD+XA==
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
Subject: [PATCH v2 1/4] mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
Date: Sun, 22 Nov 2026 14:56:30 +0100
Message-ID: <ccc2e605282d3abc63cee49eaed4300992aa1416.1795355432.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795355432.git.geert+renesas@glider.be>
References: <cover.1795355432.git.geert+renesas@glider.be>
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

The ASUS Transformer's Embedded Controller is currently only found in
Tegra-based ASUS Transformer series tablets and mobile docks.  Hence add
a dependency on ARCH_TEGRA, to prevent asking the user about this
functionality when configuring a kernel without NVIDIA Tegra SoC
support.

Fixes: ccb21236e307ff60 ("mfd: Add driver for ASUS Transformer embedded controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - s/is only found/is currently only found/.

 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2b2b7bced40017b0..d64be4bb0ed19a4c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -141,6 +141,7 @@ config MFD_ASUS_TRANSFORMER_EC
 	tristate "ASUS Transformer's embedded controller"
 	select MFD_CORE
 	depends on I2C && OF
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  Select this to enable support for the Embedded Controller (EC)
 	  found in Tegra based ASUS Transformer series tablets and mobile
-- 
2.43.0

