Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096346;
	b=OEYDjgkJ0/qyr5ZRH35lT/9ooHFHgNwp+Oxx5oQS59HM8Txbs0Q0W+pegfhNoq48aULW
	 kuk8QCdPvir5618yw70tqiMsoRn2hE/onP/pNaz4OZX9I6Lvnt5MhjjF4Rc62nHoF48u+
	 0R9orO08aEvBZDTs5i+j6af02N4HRVsrhKMFxRz1kLTWncRFJT7hspohd6yRyw2XGGVs4
	 90meMpM5z672S3JnprK5p8vXji8E2jkvwXYdupbf6mm+c5aXGcKHFD7U/0ndjp+aTEnLA
	 Kse2v4v4bXwrXpnlhhFMLbVB1jr7Ya5PTwBeAoXBclLGbLyrblWdaRDxVw9kOsOLyiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096346;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=GFriNn5y+XA4FmnW88/9zuIopVokvZmBM5RGTr6p20Q=;
	b=QnByLBAluu0Jji/X1Rm4c9K0R7H83iAw/OrOrgql76LhvenkYcydGAlEoSkgo7u9xNjC
	 Huq1OlsOor8m3huVCeFzFlC8LKgJCuMmOA4pdyg9MezsyTrAQLkFIJ4XUGH9hlO/dWUQW
	 r/5aOjcuDaCjwTgKtBSCppUru/Gi3ReYoeBf9Er4o6OU7W+amZOcOo6pIg93tM3kvsl5y
	 bl9dQX8Zxndek8S7a5uS8OxkZ4B3STiNHo1Y2AjXpbQnMBHxaPbiY9vh+QDXgwf/4ujcM
	 flnULFbVu6Jp4mbhYepfCVmzgfvgUk8AQqe7FspVl61fuaxDuevuONCivfa4QYk7nlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F660A260A;
	Thu, 19 Nov 2026 13:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D3E1F000C4;
	Thu, 19 Nov 2026 13:52:24 +0000 (UTC)
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
Subject: [PATCH 3/4] input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
Date: Thu, 19 Nov 2026 14:52:11 +0100
Message-ID: <3beff0ff365277097d5678a9ee35fe8990f7e7da.1795095742.git.geert+renesas@glider.be>
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

The Asus Transformer's Dock keyboard and touchpad controller driver
builds fine when MFD_ASUS_TRANSFORMER_EC is not enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/serio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index eb6e20cd40ac703d..39c3c072803df90c 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -86,7 +86,7 @@ config SERIO_RPCKBD
 
 config SERIO_ASUS_TRANSFORMER_EC
 	tristate "Asus Transformer's Dock keyboard and touchpad controller"
-	depends on MFD_ASUS_TRANSFORMER_EC
+	depends on MFD_ASUS_TRANSFORMER_EC || COMPILE_TEST
 	help
 	  Say Y here if you want to use the keyboard and/or touchpad on
 	  Asus Transformed's Mobile Dock.
-- 
2.43.0

