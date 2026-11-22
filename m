Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795355805;
	b=VEZvHLfZ4+QaJPbwpb2niPUinzMI/Xd+P4xlpzSEBzZBwlPcD5yxhS1DhkrTNHMw2WjI
	 8XpqVri4Gn+3ZQy3zq1wSo1gvhCTCOT+RyDFPNkW6gGg4eZivQboHf6IqzO3UVUfIY9A5
	 MTSaPfzwfeCarWsW6/cf1GMxrFOoMqqMPrqnj7TNNpRkNOhxCuPw8MPzCYlfKrwIzNHZ3
	 gAaWNGrOlzmdvGZwgP9qEmg6m27Cx/3y+tZygdnL2bH6seR/MMIjsdfOMaYEUwOxW2u54
	 5WJlnC0AJuhJZP727s08KcmgBFfVijqowHCqNxcfi+5RrORCktt/qTxBh+0/PJHb3Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795355805;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1TiXcC50OzEKTS/WtJLyFG6aJV9klghcyhqxgeU+Lis=;
	b=hZ8riC+fiQ6z2flx2tGzSbmHVNXeQbfP9vCPZ0k/LtLaEy6YjlzJ46qToQIkTRPl5KDr
	 HmFCn10q0i5hVONo56A8TQ/wjdkBTAu+fsP9LiKdyMaXZuvF5lIww+UatXRfs+HqaHTqF
	 JB2LreeVBQvpIDR7EbXoLvg+iaftfTY2oKdvOMM0nEoGn+6XM2dWrYWw8lbBBxGoR4Es5
	 dzVlU+HgUQA9HUGcUArQp5A490gDM9TNmIaVb6P/jl3lAH7rwHKeqAG90Peb3Y2St9mgb
	 rfGxvfqnW2I8EgLHCQv/WFjlFsM7YT3F8RUv0lae6pArp6OYJwWhO/M1c0jWkjNHDuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HO3XVb6G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99F606A32A;
	Sun, 22 Nov 2026 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HO3XVb6G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE2F1F000C0;
	Sun, 22 Nov 2026 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795355805;
	bh=1TiXcC50OzEKTS/WtJLyFG6aJV9klghcyhqxgeU+Lis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HO3XVb6G+QZlMKzObcP1POYOVaQyfhtE/zoc8Z6E7Maxdl6Fy0W+f3RyNbCr4cV55
	 XZTH9FG5yZqgFGKWuwf2e7MsCjsT2bHNF8kT4x7+8mZUEg/wjRHqIq2GzzIELc0FtV
	 4gLq/ib47aSUGEPRmoLEcZyoBpG/7kDZPstnpKkYnysJ9/52YbhsbdNPkGcUGhGGi5
	 Ei/P/K4QOB6EDT3lxe/VLIZUomc/V81+7q8L98x8Ue1OsKFH5opCG3QfmNIKblsVut
	 TdKFWBLEb6hWvsz71Llkg3DdIqwb2va7sY+n8wlJhojcZZsurBV22rknBvjMTeNjSH
	 oGt0cX6eD5Ddw==
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
Subject: [PATCH v2 2/4] input: keyboard: Enable compile-testing for KEYBOARD_ASUS_TRANSFORMER_EC
Date: Sun, 22 Nov 2026 14:56:31 +0100
Message-ID: <8b0c54dbf722168d9272a4bde9ed4618c19e8afb.1795355432.git.geert+renesas@glider.be>
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

The Asus Transformer's Mobile Dock multimedia keys driver builds fine
when MFD_ASUS_TRANSFORMER_EC is not enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add missing dependency on I2C.
---
 drivers/input/keyboard/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 728bc068667e7ee9..a2b92ca7e534affa 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -91,7 +91,8 @@ config KEYBOARD_APPLESPI
 
 config KEYBOARD_ASUS_TRANSFORMER_EC
 	tristate "Asus Transformer's Mobile Dock multimedia keys"
-	depends on MFD_ASUS_TRANSFORMER_EC
+	depends on I2C
+	depends on MFD_ASUS_TRANSFORMER_EC || COMPILE_TEST
 	help
 	  Say Y here if you want to use multimedia keys present on Asus
 	  Transformer's Mobile Dock.
-- 
2.43.0

