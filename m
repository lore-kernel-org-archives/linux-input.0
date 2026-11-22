Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795355811;
	b=QMWyohqDDgINkain8OhE0KMeS4/KqBogtVJcefwb4Px1O1jd2n4JPeFPxr+3MWNiTUVG
	 8HfBYTYetWNGB8tYDsQmYjgK7Ap84eP8F2exOJbdYDOF0uL0yA7meCTnfK37F2E/fbUFe
	 6JngQTnnCeiK/sbtr9qAQJMumtltneLR9pFIChLzUJz+i9GoCSM5N86L9X/vvGH9BFfKy
	 u1+YVxL7AmM51aSWovfwRsoTb+DlWk+uLdSaBziDWTKblrAUyNzYAkW18mharwCsa/Y+W
	 ernUwWTo037kUVCLCqiZdlQR29nTqhU4Xu6VLiBLyM+amaJ6Gv4iF1XRFuOoK53lu7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795355811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4F1FaLRdflLcEooEmXTTv6dAzB2XrE3alHZ05VYAH90=;
	b=xQExhIaF1SgVojBNfp9fLWRcKkh2DlmRWYEWBjQyYu162bDjPIFyUqbP57MSMTpxjpCf
	 TTIATVL19i4i21yq835RudEFsx8Z+G69tZQhBGGMRX/Lub5x2vIjqBHqPRm8NYJnE5wvM
	 EPCq+AdKJW6vAfhwpYl+xeREMtF9Zh3w4DM7bbwAbZPGsyaoseqlvKdsF6ByM3lJnILFK
	 bITHGqlsL5faJQw9k2tJGKqO7xehkaC0rkP3kQ3tpOTZyz66ouQ0/jVEkqVHLs6VjDZSu
	 yaRkAT/bilPDsvwMt4HOlQ3yFkjIWO8IP/lIWB54quMku24Vo+rv3HiYI99J/ESkoFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8AmfYQ5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCEC606A330;
	Sun, 22 Nov 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8AmfYQ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C215E1F000D3;
	Sun, 22 Nov 2026 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795355810;
	bh=4F1FaLRdflLcEooEmXTTv6dAzB2XrE3alHZ05VYAH90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i8AmfYQ5Jgy5ZOx5dPPAh6NaWgyESX6ZqNiX/EU/CPILqoI5Uwl/SiiQJwNj3zCn0
	 xXe2ZHwqoiBBj+RFsTtvBeUhW4sSvW0HTVGJHy3J1rX2KQDXgifCSbj3LWj+lIohLm
	 cwbSkU4CcZc99FT72SF6BYFM9/tNtlW+aQ/b5nLct5EfJ2mxkni/TmUVLkXHZ2Um56
	 XwMti9D7JEYK7ldUvFnG/BH5kW+VOYMLsvmVY/IJ4pIfC+MKktA4NJdjx3MivS0NTE
	 9agqnX8eYuVy9rRX8nxrlQlQdV6h3ZBAk/hiWe8J7Rx3YlQUN7IojTUrf3LzbogOOH
	 cyRH1a5F9aIDg==
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
Subject: [PATCH v2 4/4] power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_EC
Date: Sun, 22 Nov 2026 14:56:33 +0100
Message-ID: <c8cbb395ded4909dde824ce6a2e56e867867c894.1795355432.git.geert+renesas@glider.be>
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

The Asus Transformer's battery driver builds fine when
MFD_ASUS_TRANSFORMER_EC is not enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add missing dependency on I2C.
---
 drivers/power/supply/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e5398359fb5c64fd..eea3b1e336a3f509 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -124,7 +124,8 @@ config BATTERY_CHAGALL
 
 config BATTERY_ASUS_TRANSFORMER_EC
 	tristate "Asus Transformer's battery driver"
-	depends on MFD_ASUS_TRANSFORMER_EC
+	depends on I2C
+	depends on MFD_ASUS_TRANSFORMER_EC || COMPILE_TEST
 	help
 	  Say Y to enable support for battery status access on Tegra based
 	  ASUS Transformer devices.
-- 
2.43.0

