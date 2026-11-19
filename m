Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096349;
	b=2QNzR071td17ONicebnJGWiSh8Rw/zLq/4v2XcMA4Fc0nTW5y8heQIDZEfpkbiInqq9G
	 bUUEmibc6pBYwKyMzQT3Y7dQ30fMrSGrpkV2DzjLk/vrIq8gWz+nG5oSDcUOV3mn5q0Ps
	 +m5JFRUT+ysFyNOlW/LOUwNBw2S0Y4BrnlT/TG750ztP6kF+6G/lcOe+Fw3g9lI1Sgdol
	 5eYyr+w6dAL5IS51okDUlZr/XQhjw76e4mi5bJfqYg7QelTDNImf9yZHUPyy4s29SPUas
	 ugrcxJlx8WhkjfkLlY089DfMZQtO1sBIo6BgdAwn638CpJv2ZLblq7hcELLX/2+plRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096349;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=UnguO7NPqZ+ZfnXUb+hybrNZKt/QbC0wujR1W5gdFyQ=;
	b=m7ev6LcZd1PklRs8tmcQCuXDkFdTsHVzMA4gxPItd0BSHhz7/OpfL1p7iMSTuzHw6Rq1
	 pGHJwzd6Y8M0GUb8GbAYO+GbWtbHW06V0jvFMMa6FRAlMXxh6txbbtKz26NWwbmrhfxFJ
	 A7Faz4DrFvBiuLzIoYrzj8VMVM5KnwVLnOmZigzFTDrr+BI//u8jj+DcQWV08nT+R3ISd
	 imLUC1KbQpisaQOrxs6LYSslCJfUnv3WvNqUb+PS+42rinAG6Ky5bnZJR9IFX4dfQAaEK
	 cczJcIK26ydC5ahOisaqL2JZj+d6PxSyn00Q05l/g9cPufROrOgclvIxJgbTlt56oYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60198606A335;
	Thu, 19 Nov 2026 13:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E6F1F000CA;
	Thu, 19 Nov 2026 13:52:26 +0000 (UTC)
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
Subject: [PATCH 4/4] power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_EC
Date: Thu, 19 Nov 2026 14:52:12 +0100
Message-ID: <8258f896cccf3c27d3034a6eb9bb6f7becfbc1dc.1795095742.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795095742.git.geert+renesas@glider.be>
References: <cover.1795095742.git.geert+renesas@glider.be>
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

The Asus Transformer's battery driver builds fine when
MFD_ASUS_TRANSFORMER_EC is not enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/power/supply/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e5398359fb5c64fd..32435f650a61d603 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -124,7 +124,7 @@ config BATTERY_CHAGALL
 
 config BATTERY_ASUS_TRANSFORMER_EC
 	tristate "Asus Transformer's battery driver"
-	depends on MFD_ASUS_TRANSFORMER_EC
+	depends on MFD_ASUS_TRANSFORMER_EC || COMPILE_TEST
 	help
 	  Say Y to enable support for battery status access on Tegra based
 	  ASUS Transformer devices.
-- 
2.43.0

