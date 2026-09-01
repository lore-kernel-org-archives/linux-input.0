Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB7471275
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249021; cv=none; b=LZB019sctVQv41XblkjNsg7pnnvd9CAAtUiPPaM+MM5XL3kDiII8S0pOumIoTPGlKwU4BJgYdFkT7Jl+5KD/sazdtiu0zzy2yYfzFSMW4nHnFIBsqHLEcLGlzO3rtbsAHqCCPjP3xy015uFjTS9SJy2DsqiPq24M12YKdjNQ+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249021; c=relaxed/simple;
	bh=/rbvHcyLFzkOkhdGFkadotpTkB6WTk/HoLFqLifD8i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4Mkz0ezK/zM33ne470BgnxvmVPuEGrRRnFJDEmgbQw5HTISOIid9p0hx9dIH5c4Ygrm9tw5D662l0YRkSycn7DcUGILPZwQ7ZRuPgNWVnYWK92KUpa7CZtSlFedXVH53rXtZbDOt11FkPcNdmedPxwcRUux5O84yn79KnIinu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WqypnplQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqypnplQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d71a50caa9so7542635ad.0
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 00:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788249019; x=1788853819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ehsC4fkcGYgZxU5YfTTtJEKH9Dtw/4IjhfNmBesfrM=;
        b=WqypnplQyVWsYZqIG85/APXZrVaLZMa5u3WqpFXEkkKjbClBhfvPLbN1GRxNgMzLMO
         AZdP9/+Yto4wK5TR3mQmZ/qxx1OHofL+O6uy5a7Y4qsPVk2XIxg9E1snvDjtAHy9/BoB
         yiRZne9aNo9S0PiBiWJ4DxUk9yuw+sqaUbSXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249019; x=1788853819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ehsC4fkcGYgZxU5YfTTtJEKH9Dtw/4IjhfNmBesfrM=;
        b=jK0hM2L2nUaYJhntlxxNBkyWJ6HFqyIQ7ZQMD7OTS2sk4MysDdpOyGDCx4HtwrhwLt
         S5s66MCQ4sdocy5YGov+EBZecEZZmrATsBohMixJV4PFPLmsCYr6fp0r1mTqpOcTGhqc
         KQD9pp9DMb3ZE7pzxrLcL6InBH4afSV+PhyVf+qOFbxpXkzNkQgzAyYF2igMQC/N+At6
         6DPZBja2djvLmhhnrRIKnOK2E4QAh3djKiaL916jf/+eq5MLGJHfV+vOIfQy807UPPxR
         u4JuaTHDi+0K6+aFj1hM+R47b61q5ibQqqesdte9XeL0Xea3IEkHVzoPyOxFSJHLPI5l
         GlUg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4tLSPa91LExKhUCuu/XZBWcn8xoNnAuPvh6KTwliDbopo2ELeesS5Jlg4N5FshzAtiIShP+tv/+jkAQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mghgBkhD3diNNpeEtGy5klJ9eMZVxKvOZ6jTIKhACzo7VTg6tC
	P/u2NKTypXQ56661Cn+hazyx+nC6oBd30ZBOmvDV9PrMzRkfcyWWXvzatmDedCSDiw==
X-Gm-Gg: AYBFou2ueVzpO1Tsyz6sEElMsnSYI07O6j/gsm2+MUF1Dk/GD/eMmTbp9MW7ntnR2MH
	QgQx0fkU6GDMD25nrQmcYm+JOCNUnuec3l/xFTcq8MzTFJdo7rsgHPpjOyeLRaTa3VPk7QZzShN
	HqIOnzAKWMRuVx6M1zpF6AsOAHU/TmX4fkRdEA5jTmqlKKfm16CF3oKN5ISWDvf1aXV/+mtZ9I/
	9v6qvO7oWiwJ7OekKjI4ku/38krr2ar/QatUP9Cj/qGfXpkvOAKZ9n22no88NwTF/2XJMwb4yxY
	JBFJRFd51Es5D52CXcp8M4BViiQ8H5Cv8SKyAOCpz6TXnYhzr7QNRwc7spd0LM91LB1afE610+7
	oyM5ogkKm6hL5pms7VSmDsqCaOlhW+evmlXadHuI1XWLkr7mEMQBocf2Vq/Ybz/Hk420zEi7VBJ
	DwaF3lbcKtNKW872c2S3Jidkv4NOJwbh0ejp5F6YtxmN1FvzM8VISsWC2Fb0ok4RzvtgLqjkGOL
	1U0LnwZyON8p0sUV3z4opCP7cT9/jR2q0GnJatlSOKbgSs=
X-Received: by 2002:a17:902:f791:b0:2d9:1dee:43db with SMTP id d9443c01a7336-2d91dee456dmr196089085ad.15.1788249019467;
        Tue, 01 Sep 2026 00:50:19 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:8cf:6df0:9c4e:f5e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm48142515ad.59.2026.09.01.00.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:50:19 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v6 8/8] arm64: dts: mediatek: mt8192-asurada-spherion: Add Synaptics trackpad's supply
Date: Tue,  1 Sep 2026 15:49:26 +0800
Message-ID: <20260901074930.764550-9-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260901074930.764550-1-wenst@chromium.org>
References: <20260901074930.764550-1-wenst@chromium.org>
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
2.55.0.897.gb25b4bd76c-goog

