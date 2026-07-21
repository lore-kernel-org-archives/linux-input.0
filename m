Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB81438479
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620467; cv=none; b=Pq2Wo4fhWEGHgxsYsYQWUi7+2fw9l2Ij24t/r1HNIsLoSbz9Joi6rHrbso3Zxkpw1j9TMX0xsTFFY8ksNGbj8Mnu3xciwQBqGznV683RITc9+8ds+1lLAd7wHIZnNQaFMJDF2+weK/DrZMGn2vYdolIF2YsAcYu0sIcU0oYauJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620467; c=relaxed/simple;
	bh=k0D8mghOQr74tTyVbSbMDMu8qtmXQ7oexCZsNGmSAYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt70VPGhwfvyGasd2XmhpAIdiuTzFKlXhoYhMp2AJRPJ/OuiLeIcf4wMLoCNAlv41QtSgAzoISGvJ9JTEFf4kuvsT0Rb/Iv5NxWYFTeSuTxNArJ7iGCz4N3Q4xSRoIiCmcISeOaf+stzMAA2Sdhy6LMmOmlaHJ2K6V7JgsspPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H0UyOfHb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0UyOfHb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cae1a3a744so83060615ad.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620465; x=1785225265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HjmAlbOs1MBYQdjObhXrJEH8vF2H5aB6qgUxYH+azw=;
        b=H0UyOfHbMoVbSMtbKSA9+4Vawhs5WsNK6Qwrs1rsatzKguCDzflc4o8TlEEyBwE0eZ
         KfLsGjf0qcZI8LSit3TvPAzXQyA8ULXf8iGWef5Hc0E/Npn3+/xRZxwAMwlyHhcDdavO
         ls3qCWN4FN3ouhrtr/WCjT4stCNE8EjOlp6Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620465; x=1785225265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+HjmAlbOs1MBYQdjObhXrJEH8vF2H5aB6qgUxYH+azw=;
        b=T0SoYOW8cUCbTtxggOcIX9nc3FaHyqZV3ZxwNsPwJStd7KrPQAvenZqHZqL57nlEXK
         0EyagcwNWOeSAFdljsNZ5BPgSdNCUNqvleILEHlRRw294vTRjyHp8N1cxWAm5jhfGu6d
         54O+DpqPCdf+aRA3omicKqNMgkXk3+ntI9Pcuf4f78g8l9VgVa2ROumfow7swQQVySn1
         IP8SXTjsTY5cJa41k8J7jXFnZG9hfGuKmL6Zygjd5pSU4WFav5fenqUrY9NDrE94P5Sl
         UAc8j3/wydFnfHjcck+oHQexKcB59k2EQi0oYP7V48HPuTlfOaeyABKZ0ME0vW3Yxxjt
         EbBA==
X-Forwarded-Encrypted: i=1; AHgh+RpqXTgzz98CIk6EuPIOEhYELw45wTukHKYdAbhv5B350jaryDavrZEuxKTKTrBtS23IAiK3FURF7UyBqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRY7E2RzYBWyMbmKJQXSqYvI8yje2GbDAZsxc/QdOArPVWnAm0
	ga7HA3Jl5/vtoXJba0vV7/2KwFkALfE0Cz2yOZVyqeKVyZWZtfsfEjWAm2fZ1fL5gg==
X-Gm-Gg: AR+sD10leaW4yl1viJdc81qrcgOfyJE6Xt7GPNATDoIlgtMP01bHHK2txwetmHQZW3k
	DvcPrNqlZUdC+bVnrquLteU90WQvMhgkskQYYQbbb3Ky6zRltLMHcHGiKRsKwk5wUBYEfgSYrx/
	8KeuU/GfoTbyErExdxlLaCD34vGZ7DFtBdJJyf2gxLdRXIzTWFhqBD7YfjVFflDZrK7IlQ17eAd
	j2T2Kz47uMQDiRL6/egs4H7blz3YnZlAr3JPNNTL1bxR8h7O0ZkOOhjLbrG1reXliv9DzcjJe7S
	o9vcfZXo705dGj7/72YXR/OCpsoKGWffVIy6RTMSB5/01JkdVhey18MaRnMME3xLUDxOOeImBW6
	macVbMWYL9TMujrHYWPh3sg3WwkySe9BQcsqt2aYp8xaef468rS3tfpMKGQy9wXc6irn/JGiqbN
	CdILCu+pH3B2x1gJvhoNxvTv/FGKNu9WMbFkVTBKRc2ttrXcJMx3YZQCLjj7w=
X-Received: by 2002:a17:902:ef08:b0:2ca:5970:732d with SMTP id d9443c01a7336-2cf349d0276mr183734525ad.41.1784620465520;
        Tue, 21 Jul 2026 00:54:25 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:25 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] platform/chrome: of_hw_prober: Add delay for hana trackpads
Date: Tue, 21 Jul 2026 15:52:21 +0800
Message-ID: <20260721075226.2347933-8-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721075226.2347933-1-wenst@chromium.org>
References: <20260721075226.2347933-1-wenst@chromium.org>
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
2.55.0.229.g6434b31f56-goog

