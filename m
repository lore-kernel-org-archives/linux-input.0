Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096341;
	b=BldJw6gST0G/TRtTE1EhSTxBIgzs9Vjld4i1oqPGz9hhtDHAGB0/iBKHTENU27xMQLOz
	 e1+iSsqZOqtKZSMHyD5JV3Ci9sw4sJpp27iwsY5GW6zv8ByCg4dZyJc4uBogURrL7sZh8
	 Aw07ACTWVALWZx7nYEM0E2J0fJ0nofBC/ey7MM498bJJWeL1djMhUfdoYoav+14ERGlta
	 1GPYeZmAibfRytnhNE203WhFgk4nPi2A4qlHIa2VFFq+Q34cBIhEhUf8NplSLOZnF2Whn
	 7gsnBNVJx5Nw71qKtAd7jgfAj+zC43ZGfC62Q5J4PVX8i88zQFejLrfVcYCljCIHTGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096341;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=uvsLCLgD+2GlK/ZO9dP5Vd1GUDLn62fnjVZevtDNlHQ=;
	b=hyu47rHLSkEzMNTqqIVXWvftS6XQzu6IVOYL0EzAt3L2H8wYLmT6KRLdBk2np1cOBT0Q
	 lmPRHiIp3HpbmuHjUFLGqpUXUcP/WiFx3FjPqw9r/mO0p44qNYDBeZ7FwSqr3cCwRHTYO
	 rWd+JhosUwInYFLupHAnruEQ7+lOnprwgxsOQcmLDzxTRP61bM6EyDqd6+cBshSOr3RzN
	 ZzGW8CwLHRB479UuTrzp1ryhVzHLTEWOZG2FTlXZgSiTymIr7Pe8Cl/1mltrdTbTE9sL1
	 BbCVsgVyAg7MoeEeW8XYsyxLpQjQZoxf8IVBahbAHUL7DyHUAeBHxe7VXKVIaPdBtpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95A606A331;
	Thu, 19 Nov 2026 13:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183491F000C6;
	Thu, 19 Nov 2026 13:52:18 +0000 (UTC)
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
Subject: [PATCH 1/4] mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
Date: Thu, 19 Nov 2026 14:52:09 +0100
Message-ID: <a26023673d5ff120812f67aee3728154694cb69c.1795095742.git.geert+renesas@glider.be>
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

The ASUS Transformer's Embedded Controller is only found in Tegra-based
ASUS Transformer series tablets and mobile docks.  Hence add a
dependency on ARCH_TEGRA, to prevent asking the user about this
functionality when configuring a kernel without NVIDIA Tegra SoC
support.

Fixes: ccb21236e307ff60 ("mfd: Add driver for ASUS Transformer embedded controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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

