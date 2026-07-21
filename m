Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F350A438003
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620475; cv=none; b=loDXl5XHDyAfDtAKElWIB7ATOwvVMlQeCOEjasAe0uQ2I8Kyexq8qocN6Fgs/85tcLqxdOorFGSB0wXBBqyh8cGfSYZcFOFb4VZMCPEMHhhJxsjdxXSyvt7Sqtyvlj+GlHlDRvYI3XJ9X3bN3jzqK8VVhWmSkIA2JmAT6/MeXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620475; c=relaxed/simple;
	bh=YmTP+U2Zeto/TOo03rVHUOI/jAzel7OhJkJFnUSba3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwLdwN3xTcXul0APdqN1sgSQi+WExivxZuz/ImOlaHemRioFBmjsyBQztF1WKzVu+kn02Hc3wPlk+kmJsWgHQQfIlWBUW8HUen9KUby8dpCbkCbxmRvSrWEEeYgjk1n8AgOZhgh+Ia1qvg5NPiXJ0KUT4cbVBhyFgKoxUqp7PgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MDS+uyY5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MDS+uyY5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3811f512167so10749302a91.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620472; x=1785225272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XcG83pWDuxaLzQNicOj1pF1B6XObkyNl+NSmg3vDNXs=;
        b=MDS+uyY5XftEq1uR5cmUwi+v84CjXBTLfiNC5c4T6NnSUEn9MKKbUZ1A0oRCTswDLk
         LD/qdSPlEXGvimFxAAxA+uOxm16hqD77zcGariCV+CO4GtfaGGAO4W7vhbvdI+bPdujO
         5O5OXmaKy4H5KWnYju83Q/13kyZXHSw5Czfc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620472; x=1785225272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XcG83pWDuxaLzQNicOj1pF1B6XObkyNl+NSmg3vDNXs=;
        b=gG+NY7aHjs2i7BosRySWgoWEcfLz6InNzTaNnQuv+aw0pdg8xHTn78+GXOq7+ThkIl
         md1+fO7F7DLD0kVagcgFtlapCfbTNwlOxHN+KbzUejQlNoC5J0Q93FSa6sI6kql/du7p
         fg8oo00mKNqrrGqEB9BgoMaUq+Bzms2LzoO4ysGZEXTIjHVBDx92Ok37iVvJjD8HpIoB
         tyN6UOIKYbmizazIvJOfLYtaDGUuUoMNfsAaUJJSpssbpu9Mgb4DNsHS7SMBxsaQ+BL+
         et5dDiLSyD1A4bznfZgMnvKVAVfIXYlxYf8lXaiRbIMTtaVtyrHoBTR2MM4jCEEfOLRm
         x6IA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3dfRiP1XTZ+gba4/TCDInlCp5ckuU1ttaSyVycsK63ZucE8wYJzpoRMbfu0YdgS98a68jK+f0MFr6Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhky8ElPQ9pzb3Z+A6rTFZ1K8wqRWjKUDjm3Ufs5p++TGRFsOp
	hfT7uMGKOH2JzH5wWhNVqYhSLkzsz5jDibaS2cFAfhYnKiTlUWIt40oip5Aelbs4mg==
X-Gm-Gg: AR+sD11NV2svHlcWTaL4dppECBXrDQNd3I1z4yO+oyuQJwCL28rEW6HWW10JZmN8lLt
	cLTwjLL9lpGuCrLLzo7E95rBcFV/eNrtQN3+g3B60UAEcg6osKNsmhBbhyFY6uGabJUl4Qdnm1I
	Ehc13EC8fdVEx+vu2aqe5rY3ja5LmYVgvaM54jb6SZ0WF6OnAJcqcefpxXuBKSghkltJOmg7UjQ
	/GIHNWyqQqxHvwFtFJLPQqUmlG16k0AWAv+Jk/vMfvGNp10yWnZZWUsJYptRatcm8CBf8RSn7Ng
	KcOLC0DvXhTjhMIfgJ9tYHYwDStvXfekM8gv1HqeS3mwqrgq3TKuZ4qVH4S/lI68QudhI/7h6em
	RwVo4LvsMckK/tY0YX8UqHouR+9qilMSGmrMnbqkatWKVqY9BalhZrs5ch5gORQlzk/elqSj7Y6
	HoEm/9/148cjoqOopiamuCo5avJXFCQDZaTgNGqwS0r5mwl9bv6ChB4Ctw2tignh5TnrbPNg==
X-Received: by 2002:a17:903:2b06:b0:2cf:8363:5ab7 with SMTP id d9443c01a7336-2cf83635d95mr15956285ad.26.1784620472296;
        Tue, 21 Jul 2026 00:54:32 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:31 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v3 9/9] arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics trackpad's supply
Date: Tue, 21 Jul 2026 15:52:23 +0800
Message-ID: <20260721075226.2347933-10-wenst@chromium.org>
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

The Synaptics trackpad, like the Elan trackpad option, is fed from the
system 3.3V power rail. Add it to the trackpad device node.

Also add the correct post-power-on delay, even though in practice it is
not required. The Synaptics trackpad requires 100ms after power-on (or
deasserting the reset, whichever comes later) to fully initialize. The
power is always on and the reset pin is not routed out, so the
implementation could try skipping the delay.

Cc: <stable+noautosel@kernel.org> # Without driver changes only lengthens probe time
Fixes: 925ebc0cd55c ("arm64: dts: mt8192-asurada-spherion: Add Synaptics trackpad support")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
I think this shouldn't be backported, as backporting it without the
driver enhancements just delays the trackpad probing with no real
gains.
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index 68caf4c58cfe..8adbfc307fca 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -94,6 +94,8 @@ trackpad@2c {
 		hid-descr-addr = <0x20>;
 		interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
+		vdd-supply = <&pp3300_u>;
+		post-power-on-delay-ms = <100>;
 		status = "fail-needs-probe";
 	};
 };
-- 
2.55.0.229.g6434b31f56-goog

