Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5F4446EE
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450869; cv=none; b=osxspsJolHI21k8DxVXMRrFWqr/pvEPJpA9PKQjC2ckrerjCleNmIWwlpejY4wuC0Zoeqw0LK77pZ+mH6ziy5pZJXNPckoUYzZVkF7/9InMW7JNo8p9/NInsKOHarHc2F0CSPPPec8IS5aMArmTrMmx7DbMCUqzU6OCabSn8kjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450869; c=relaxed/simple;
	bh=uwYCui3c4XPv1rsWnK/RPsaDrOamMJWwHcg3hSpC47c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1D2ZA+2vB7MMgGe0v5AL5ssYOSh+mttPDQF1ybNrzltgE0699GmWTx5pH/LEoLDLge6dTrORliKxyHYNo834DnewHb2Nl8CPu8uwZuwj1h/eCR5C0w/u7PPVafuuvxZuVnn5ZaUoZCm6Jy5gG4QbgMBQiltEkzao1VXg8IlVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mt0pGgZR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mt0pGgZR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3046378b3a.2
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450866; x=1787055666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dA0DiMJYo6Co7ip9aLY71U3LlTdqy5LziCnokKFtcGE=;
        b=Mt0pGgZRc+dMa2v2Jtyuct2spmGKye97vRGWyNhkzFej6BiqmCMkw0CDCBQXn6DBlC
         yzq3Ra4XxWvU/X3utTCIlFd8oYR90cn/KbgLOSpOQao/M8fZvIzK+VY8jv7Oby8qg+s7
         9dYDux8EqV9kZNtESFbJp1HiumNLjwBgqys84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450866; x=1787055666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dA0DiMJYo6Co7ip9aLY71U3LlTdqy5LziCnokKFtcGE=;
        b=tL6az37p5utFwZIWPM1sGutATnV7M8+quQoDUr0mE6c4NzCClBrKiaZruxeoHWQZsB
         3tNa5FfArvdYyIzhMG2Hh5tofyOqBKhHcj+k5CPHqYwwEKAIlc+tnKkeHT9ypblFtvwx
         z9i2rSo5Ujbb4fioWkrrxeZXDAGHaKnzNmnnlh7ZwPrctff9rX0CeJdH7DOYXyryb+ys
         rn9LHXJ3DI57EsAcDIRcYo0I3xAAf2cxSMc78DGLQo0KLuN5F24o4UaPZQV1JirEHEBg
         VLrPCQRKLJ9I0YxrXxXo9wJkhTelwwK+uWURrKf0RlM9zeQIeUdC6RLf1jAEamUJc92U
         26Bw==
X-Forwarded-Encrypted: i=1; AHgh+RpsXqHaL4jyGdJ6lji+4V75QTlQ1c84UkunMgei3Z0KQ/u2AAxfAcLih3QbXoTw1mIJh3n1O6fDLz1ilg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXScVH7bfxzfyInHhivLO6KxWAawGdR2U5DEoI8ZgEBYMWQ2h
	IPqYoRfXQvYJlXsc4NNfRwvS+/XpqYSDUp8lAY4V3rRyO6PKi/v9RlHQGWJH1bvZNQ==
X-Gm-Gg: AR+sD12pd2Xw5Rt/jFxAqGIkHjF1OnKbTb4Uw/Nc88arKAzb0ijWqTqiDZMeM3Xp+Il
	LwDzalVvjCAY+ekNQ4rbWqBGYvUPMc0/TsBr7702SUq9h8LYGsNV2+OAfEGY+WnC9k3wMKXKmY6
	DygSstEWoYRwv8/HIinq58ydk1qDWWXmYHAJxEyCgwDm4ff3piDd/bcs80/ilhjG5HeE3QPE8DR
	4FNBsyqivOat6uO3SUl/3n3JBZ6DGD+zPdqFHFjH9sgcQ575GOWYtf5Ui4iOEhNS0x7j6KosKVT
	JtpyAHzppRLsQ4mbtiBxqvR52aVI+7EF83hxsqEzrwww1WmRzqc1g2En8AzYkzOY916ll4QwMxT
	kVgOUUWSdNE8IB1HLB1Q55/aDEeJ7cEXH7ah/SvH7spAHXxMdQvma1sYP6cC7CIOe6XLk3rE0Ip
	paRIGGH8EHcOA4+Xw05TBkx6sFga9MYxc0+WayRNx20wy9mOfNUc5IK45CjV+mebE9PzpDbi3EF
	IjcVgosjpnqs26yg2w8lrHxd9srz+AfdKCRuvmjrI3GgQ==
X-Received: by 2002:a05:6a00:181b:b0:847:8504:9946 with SMTP id d2e1a72fcca58-84fa882d05emr2571459b3a.25.1786450866341;
        Tue, 11 Aug 2026 05:21:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:21:05 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: [PATCH v4 7/9] platform/chrome: of_hw_prober: Add delay for hana trackpads
Date: Tue, 11 Aug 2026 20:20:07 +0800
Message-ID: <20260811122011.3539250-8-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260811122011.3539250-1-wenst@chromium.org>
References: <20260811122011.3539250-1-wenst@chromium.org>
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
2.55.0.679.g6767b8d81c-goog

