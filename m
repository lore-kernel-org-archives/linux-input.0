Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97B43787E
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620471; cv=none; b=IiK2iRH1zLcVNcmzoISqoRmAY9dwZrmGPXfNJ8ILv0x2z0nMV40PjmIIPgylGnvNHmashZcZQgMYTKJab9rRCF9v1dmZ0AcepMRb7tTWc6hTuZtvKQ73nt2AunO5TmE8OqL6opArdXJx+DXnYTymwitePnvIm/GfqkBN9RZ4Jmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620471; c=relaxed/simple;
	bh=27P+kO3E7rZQANAahmL4oW3JH5FufBpKYuQgwu7HS8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQK3uZrCzqu3j//smJC2tE5ZYHQ0tEiRCx8Wm1+0mOlpGY7KBf/yUNc2nNG/hCYXsGzjtE/Nl0JCSna3nFeHl5bm/aDldFoqRhNTfme2/+OXw+nNE3TvekSR8JJwE14P6I8Ed/kln0dshWxpaxiM9/pSD1HAMkT96ydwee67g/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ElZ+0RDB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ElZ+0RDB"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so70676885ad.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620469; x=1785225269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpTQ+x9JRSQEI1YUOvflUoQb8hjimFA84CnTWedUkpQ=;
        b=ElZ+0RDBacwKpPFwIIhI5VknHD0gb05C592rQtcqcctQFFwCNilZZJQtN+6kCigGOd
         OpNOz4TME4z3M3Ndf2zMyb/3/QdIWloDL/Lc8xLJdN4srHp/gZWQ9BLTlgLPvG4RhhJY
         AKlg0PHcQTTJ8GUcN1lDVhNOl8I2Qc4j7pdNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620469; x=1785225269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mpTQ+x9JRSQEI1YUOvflUoQb8hjimFA84CnTWedUkpQ=;
        b=bBELlOrI8jMM/vTcHe9mYch+8qCcgcJHQv6zSsv00iw1LQ9Nl/iXQIc0PnvfoxDg+U
         jArPX6aYxORyMOY9iGZK1cCdYcXanOS+M9rIlYUJj3r3iyx3wZu+9W7J8OF7KeKfnqTx
         GFl0o5eKFWictrQigQ2jrI2GDtikzBYCgEtN05O1DsEZa2aoexX6ENr+OVXhUEXy4TzJ
         W1ovs8JGj2DdyB/4rCylDqHpjK6D2lVdUb+x/mbH8Iv3wtUqiyGKc0hnkdock/LxtkHi
         O2Wpzt56bsnjt0AtEEXMbKaGVsRW65k4bMMJPjmRca6ktMZ17tBZTnCxrRjO1gXZNGGS
         Q3Zg==
X-Forwarded-Encrypted: i=1; AHgh+RpA12uQ20lrMT6XUFS2GOoTqsiv5OX5UtKDL90inWxo9YnEp7d+zCayb0ldExKEKDN1UWpqUMlsAxRJxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysg8b7iW5STqzTRKv40INdE017ropRbXwjl1cbhMqB2irm+UVz
	Qc5Rv2rYaRwD9Pbp8fXe3Kuwp6gZ/K8LQJTxVrLhcMBLXWA+AU0iLGr99VmPC5cWdA==
X-Gm-Gg: AR+sD125kxoBin2X6MdCIcNIWcSlv5qInX3XNeS6wCBkUeU0kcgbSvwNFYHiQ5a4ufq
	aciEfYQyahxeJX4tCXhr2NIqq++j9Kobr3oprvurGBgm1egsTzdDQV6Z9DXj+fj+VDZdsgPrUDo
	dKIWSp4Wv2EIc7yoXyWgI8Istc9XynDJagu6kRjw38ksLVoBcISuYnMr4X/se/Pfai6HnPK+UKp
	8a12GVArqKv7D+6UVf0twNXyJIH4k02OcwrWHdm1eXH70cZFr+tRy8fuksu2pUMLbrVsgN2r/q4
	BozKRd6ch2qk3NbDYy7/Xtq1skiXkWvLFX7c2abun91riyD/NGScZF8snCMvFlVu1q2/n/SoMpe
	lyoS1xx5UGqnlwTJCUOL147hoTmnTRLx9d3/UscPqG/XWpPEuxGZlIP+aKzkhunOWcvzvRVE/Nl
	EKEGQWvHnLZrtxJNtD6wowMc8Jg9WXz0NkkACnXmicmX+7hYR8Rx7vWqWNJws=
X-Received: by 2002:a17:902:ce84:b0:2ce:d957:59c4 with SMTP id d9443c01a7336-2cf348369cfmr185433115ad.6.1784620468826;
        Tue, 21 Jul 2026 00:54:28 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:28 -0700 (PDT)
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
Subject: [PATCH v3 8/9] arm64: dts: mediatek: mt8173-elm-hana: Unmark trackpad supply as always-on
Date: Tue, 21 Jul 2026 15:52:22 +0800
Message-ID: <20260721075226.2347933-9-wenst@chromium.org>
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

The Elan driver recently gained proper delays after power up, with
opportunistic skipping of the delay when the regulator was originally
on. The I2C HID driver gained similar opportunistic delay skipping.
So has the I2C OF component prober library.

Now fix the device tree to have the regulator not be always on, and
let the I2C HID device have the correct post-power-on delay time.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 8 +-------
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi      | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
index 1004eb8ea52c..b9e311fcd9a0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
@@ -62,13 +62,7 @@ trackpad2: trackpad@2c {
 		pinctrl-0 = <&trackpad_irq>;
 		reg = <0x2c>;
 		hid-descr-addr = <0x0020>;
-		/*
-		 * The trackpad needs a post-power-on delay of 100ms,
-		 * but at time of writing, the power supply for it on
-		 * this board is always on. The delay is therefore not
-		 * added to avoid impacting the readiness of the
-		 * trackpad.
-		 */
+		post-power-on-delay-ms = <100>;
 		vdd-supply = <&mt6397_vgp6_reg>;
 		wakeup-source;
 		status = "fail-needs-probe";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index a0573bc359fb..6b9f47f515c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -1093,7 +1093,6 @@ mt6397_vgp6_reg: ldo_vgp6 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-enable-ramp-delay = <218>;
-				regulator-always-on;
 			};
 
 			mt6397_vibr_reg: ldo_vibr {
-- 
2.55.0.229.g6434b31f56-goog

