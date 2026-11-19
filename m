Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096344;
	b=fMu3d/pnzSNpgVtvB2kETHQU5Ek/yNTdSCidOJeMX/H8eidaCnHrFL96PiGV5lHjwis9
	 jjvR0dnaYatrLhgv9elqq8IrlETRURpnkrj5jQNVUAGewMYVigyjPhx4FCp4bb884sOnf
	 dN/ULpXtCGAWgXfnz+dtLBmwCg6IIekFzzFLWCXpn9iD0ThdmJRJfh1rPa81K6bG6GnoU
	 6IHveOHY+CeTznLZWSpUWwoe3VyhBCRM2FPAQfepp2Q1rqlQ+qmU3X0g9p/hZWAzHxzIt
	 NA+i/MKs82w+cKghBZRTV6lGcNt0qe2iECdinRyHtuWt/utacAkLJgnF7jGKImxNCYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096344;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=SY150LehtwY+8E3DsboI1K8P1YxqiMEO52EgHejX3Ak=;
	b=c8P8yzQWiIv0dYD0vcAWo4Xmd9SuVx9WyaXxZv80tFzh0THpiQZL0Pi0gGZzAW/rykn5
	 sFbZfWCA8f2ZRIuXFIk5HZD1uWH9WGEzRQYlRRN6ONixVXJS0HXV1ZzMvuDJFVxKpKBM/
	 n0WXuzN8UDYXTBAn1jNZoSKzK10J7hb+qNALE1LAEaO44yecb3/MA7sBv5Jx2BwPiFtAN
	 Yu2o+sGmoGnhFyySloSc9pcZMSHRZjm2j5girJVSgdvfUZZCigFhlPa8Yx0BPkBoC3bJg
	 KHXGE14EuY2vmr5nUZbat4qugdiQmJkPAmX/rZ8PmwZc7pjx4UfPM4cNee4L2PLjxQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C811606A325;
	Thu, 19 Nov 2026 13:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C0C1F000C5;
	Thu, 19 Nov 2026 13:52:21 +0000 (UTC)
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
Subject: [PATCH 2/4] input: keyboard: Enable compile-testing for KEYBOARD_ASUS_TRANSFORMER_EC
Date: Thu, 19 Nov 2026 14:52:10 +0100
Message-ID: <27990d37c1b7854d9d5f0d0a0f45193af4b9ec51.1795095742.git.geert+renesas@glider.be>
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

The Asus Transformer's Mobile Dock multimedia keys driver builds fine
when MFD_ASUS_TRANSFORMER_EC is not enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 728bc068667e7ee9..2709cff6d00bc93e 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -91,7 +91,7 @@ config KEYBOARD_APPLESPI
 
 config KEYBOARD_ASUS_TRANSFORMER_EC
 	tristate "Asus Transformer's Mobile Dock multimedia keys"
-	depends on MFD_ASUS_TRANSFORMER_EC
+	depends on MFD_ASUS_TRANSFORMER_EC || COMPILE_TEST
 	help
 	  Say Y here if you want to use multimedia keys present on Asus
 	  Transformer's Mobile Dock.
-- 
2.43.0

