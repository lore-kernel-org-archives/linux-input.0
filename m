Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795355808;
	b=Z8o05mHDTcDeccA9MmdTfmqrP5eY4RXzUvhQdXBaOg5Shv5IhG+7/QYs3GzRvZ//9Q48
	 par/ZkibjtztH0DimgzYHosJB9kdieFhKKOKDB+KRqwSdncHbMlFCnQG7qkeWnQaIAWX/
	 LHDsiowSz9vo0QmTz4ORvq/xwDqRz7FsbqXbv9wLnhA8k75GGxoDv8LAwqN6OIpmyLRtV
	 PGqOxA9m8JvcbcVgZkaJFMfG7WUJt3cfDg9iJZXYkSZ45obdgnR6UFcGNUzipLobDS6aX
	 WjjigGCZS6yLH6Wm2kN2oTaebtwmhHm83m8TU+0D7btOdgdp3QbdmNfgKLeX8nR+rDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795355808;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yUrPrNWffIryjUGVZtv7FcuNjtx+cYotgmd5VoAMAjE=;
	b=TakQZWGip9fSOKBDpdor0JVEcxIRU0XtSWwlZyj+RqIT7lUJW+U8KYIrKQ8l3DPYAmLz
	 Dy495mdXi6BrQeIiGsu7hDI6K2HVCryXAVvy+e0196GYsuK35wHnjIMmcqdpwv719FNQH
	 WgJgWI5lMRWOmD04x4wzIp+Rvf+urBKFwBvG2EmTsUXh/huVlcuJi3a/RRZW98hV2Rqze
	 jrZOz+jxBEcqDRwGnWFUwyhJnlam2F4s2rm+cUb8B/kRERion/UAH4WBPwIF6M0FwYyBM
	 bL6qhDrqOe6XgXKrPNEbog709rZA4aUrW+52phquT7e7MCv+PIn8cJeilSBqiGzHqrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYvkuqcU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61978606A32A;
	Sun, 22 Nov 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYvkuqcU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D4F1F000C0;
	Sun, 22 Nov 2026 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795355807;
	bh=yUrPrNWffIryjUGVZtv7FcuNjtx+cYotgmd5VoAMAjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YYvkuqcUOrj5tG+AiNgYwDRuJ0EX2UNp9//1J2wqu+bDlp5YAvWhW/G+RT00luOL6
	 eSoE36dRFTDZri1bcEb0JGV9MlbT0t005Fnib0TVeNK86nuZiswTwGEyzvIoqdRx1t
	 9wBmczUzXWCip6Ih/2T7DL6O3qVl1MbTBA4Bwas7CkSc5o+ynaQXIzbZzPzK9YdS/z
	 YNIf4bca0jcPkQeiSWyBzX0/DgbgQPBs6/EyOwuAkl4NqmHEU5vE+9oprXkO0oVGt/
	 H7Tp1DvhgvEHUyt1r29YT6iFIzS5FJri4yhUrC+yOC8ouuv+oqyJ7c9pVcQo5lDeke
	 eRQEhAmWQrW7g==
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
Subject: [PATCH v2 3/4] input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
Date: Sun, 22 Nov 2026 14:56:32 +0100
Message-ID: <234c01e4ac98bf72e3e2bbfa7b4fba635530ab8c.1795355432.git.geert+renesas@glider.be>
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

The Asus Transformer's Dock keyboard and touchpad controller driver
builds fine when MFD_ASUS_TRANSFORMER_EC is not enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add missing dependency on I2C.
---
 drivers/input/serio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index eb6e20cd40ac703d..5151ac75a82b041c 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -86,7 +86,8 @@ config SERIO_RPCKBD
 
 config SERIO_ASUS_TRANSFORMER_EC
 	tristate "Asus Transformer's Dock keyboard and touchpad controller"
-	depends on MFD_ASUS_TRANSFORMER_EC
+	depends on I2C
+	depends on MFD_ASUS_TRANSFORMER_EC || COMPILE_TEST
 	help
 	  Say Y here if you want to use the keyboard and/or touchpad on
 	  Asus Transformed's Mobile Dock.
-- 
2.43.0

