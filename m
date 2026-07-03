Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC213CCFAF
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079790; cv=none; b=jMMoMS8R1vNB5kVXxC+KvVNkRxdnfQPWDj2h2+Kl7dpZISoeVqIoFL8yvXLmbZx3uKB5qkoiGFQUY85l2DRdjB/XvOWgUOi0lFHlRQtsw5XBTqVmnI+XSnRKZ0Rm/1nVLgtmslif4uNdbM+cYW0LnWnevtHgyIq+d9RoZTA2sro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079790; c=relaxed/simple;
	bh=hOFZgLaEu0fgbaHLQ2K0UZhu3A++ABratulLxCJEZq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDq/qoaugtb0D2/ho52HrG4H1bNzbDZ7Ss1xnsYOpJC4S1gLZbQeoORYeFJOPgBn7hEev/ThCFdH7u6sROD8ecJ2Xj0VqFFaNWuIiIG0FjeRFuMLsrMeGwoj6s2MY/6uuFyw4q0zg8fZ/InKMjAyTYfvbsleOQ/nsSvaqSfshjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B41Lxoci; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B41Lxoci"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96d2bebca3so288975a12.3
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079788; x=1783684588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzs61HZr2e08vLjlcHcnU81Qx3P3Xyhgqf6PYo21bZc=;
        b=B41LxocigSMqSi2e71qckO4dG9zNUkMV3sd3FznDwmrLjgj6726PhT2j7KA64EbiUH
         JwCIZu6gf/G8eO2FALDLKhF3r5VZGC0+e+isR0AN0nFGLkfx4hBCZZQl2Wec5C1qI2Oj
         NBvmtI4Y88G++6y3EGo4+N6WVzJ31qFCsma7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079788; x=1783684588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzs61HZr2e08vLjlcHcnU81Qx3P3Xyhgqf6PYo21bZc=;
        b=K4nfHI6HV1FWxK+puA5UjsQrjEWinKib5PQqPiRgzMXpG91oL+pc1YHoZ2XuQWBjCv
         OsHGn0zuEUnXBjGZoRce3QbmkVTnr3wkfkbRLthsjPOyy045c50EIgN5cOfpXuwlgGvG
         mGbaAzvefmWcCTbY+JoVAyy92pj7fa1hST/gB6rcwpjWwsMjFI50fEDCX5sAQarz2FN3
         WwpXEwGZQOBkpow4mZ/oLy9sO4EdvpFudLh9woJELetgvpF8xyUCft76YIV9yGcM1aNY
         gsoANxZK75Rir9Iegb3LnsG2ivBbRh0ZDtBE6y0fMzCyTL2TUN4bPJgKZgmpetRiG8tA
         exCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ayHZOUr9zXECkLI58WwnOBwtvAwi2VxU3cLBdrhfcjRqph5J5/oG1UiL9vv2b00L0zEwW8kr1F7j7xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycLlIPCqYalBuUGWanVAb3OHTuXuHlhXoiFj/CiLjss3V4ipNK
	BZwO+5Sz4UDrndKi2Hyp2murWw6BTYqkyclMlYXh2mp9PNFSOIww7tYNo7nttlaEFw==
X-Gm-Gg: AfdE7ckrs0UgM/vbixnPO3BhwGdXMR0FUDvH/Q1mB669SvqvPTPmkO4UxkYk5MoCNHU
	T1k7nlouLwrMG9jeKP/pdUCoxsG0vTnuHMaOwx/QEeRSZ3ok6b9QyoCl3vaXf9BOAW4F40isruT
	FokAeQi/4xShWI+sy0fgkrpLPADl6uoSNZv2mtNuwURonQ030iyb8IH4vsbUmIUdRrhL5NWr2ZF
	I//gomoYXCj0+pT10lf2wu/8l4LqBsxqJ4+L8nG6G0L6abtVYkHl8fCTDDUIa111zrvuCIBpDO+
	X9wOnQNBieTNSTjs12V/Rbz/F93r+QIxthOYCg41zk/2hSo2tXvzdzwqtaSTIrWj/N7r8jubt6t
	h/xBkiel1exn9R7Si68csq2vzfT7ElNE7lpi3mu93QgkLG5/U15uVWdsHCWiYib0FyUPVVjaOrH
	BF9sChCwxU4xRQKmr5NwyHIjXtTiB4eCfqE2zkUw4BeztlDwDf3jdz4jhJ46oZtMoAc1ckgg==
X-Received: by 2002:a05:6a21:1f84:b0:3bf:77d7:667d with SMTP id adf61e73a8af0-3bfed47019dmr11801134637.28.1783079787514;
        Fri, 03 Jul 2026 04:56:27 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:27 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] platform/chrome: of_hw_prober: Add delay for hana trackpads
Date: Fri,  3 Jul 2026 19:55:58 +0800
Message-ID: <20260703115601.1323491-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703115601.1323491-1-wenst@chromium.org>
References: <20260703115601.1323491-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up until now, the MT8173 elm/hana device tree has set the dedicated
regulator supplying the trackpad as always-on, simply because the Elan
driver was missing proper delays. As a result the delay for the
Synaptics trackpad was also omitted, as it was not strictly required
under such a model and delayed the availability of the trackpad to the
user.

The Elan driver recently gained proper delays after power-up, with
adaptive skipping of the delay if the regulator was originally
on. The I2C HID driver and I2C OF component prober library gained
similar adaptive delay skipping. The device tree will be fixed to have
the regulator not be always on, and proper post-power-on delay time
added to the I2C HID device.

Also add the post-power-on delay to the ChromeOS OF component prober,
so that if the regulator is off at the time of probing, the prober knows
to wait for the hardware to initialize.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/platform/chrome/chromeos_of_hw_prober.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_of_hw_prober.c b/drivers/platform/chrome/chromeos_of_hw_prober.c
index 8562a0e89dc6..54d8941617e2 100644
--- a/drivers/platform/chrome/chromeos_of_hw_prober.c
+++ b/drivers/platform/chrome/chromeos_of_hw_prober.c
@@ -70,10 +70,8 @@ static const struct chromeos_i2c_probe_data chromeos_i2c_probe_hana_trackpad = {
 		/*
 		 * ELAN trackpad needs 2 ms for H/W init and 100 ms for F/W init.
 		 * Synaptics trackpad needs 100 ms.
-		 * However, the regulator is set to "always-on", presumably to
-		 * avoid this delay. The ELAN driver is also missing delays.
 		 */
-		.post_power_on_delay_ms = 0,
+		.post_power_on_delay_ms = 110,
 	},
 };
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

