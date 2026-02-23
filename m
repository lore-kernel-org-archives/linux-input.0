Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2888331A4E
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867083; cv=none; b=ZVNKwDAGAeJiDqJRsmpSme0o9FCcOSV+M8IPA8VkhnZ7XzRaHFVFpbi2SK06/H64N/crpxxPq4gEIF5fTgyFigU55lUJvPsOMh5AA2fxSJyH2ENFK9OOgllFQHkbnDf+M/bEm/hFl5cn4sqzRK8qAKyRPQFoqiPLD+11st9wm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867083; c=relaxed/simple;
	bh=QP+MHdRsjcnE2pWi/W15VjcyLY1tuybVhE/EH7k4Tzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAcpW0GmTTDlUreSAy5xA7FpC+58+CZk5yBN69tK3oj6PxSxbY2rSakeL45Bu7OU8mk6SGlX0nK5P5eZKgy8hZVifhrufigiC6qaOH5JulGzNf0DA25G8rN55BZTeYtI5mvaycOkiHO6BttO5ArqFdjNAJ+WRYi0r0cY8FXvM7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh7wPiLd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh7wPiLd"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359a302794so3421204f8f.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 09:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867080; x=1772471880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZL3Fp+qjeYQN997X5TZmi0Oj1feAEcYEmK2ad84vbQ=;
        b=Mh7wPiLd36/EA8CClo/pheL0hEyyLWkmt2T/yk7MTGgbU7ZsWwjgo4MyD464Mu5TN8
         l5hp/Pv9c/yibRZ6qIXX6Ho2Wy42HKL9cmx9TBHhPSdmYgTGiu7hKM0GQEw6CcWI5A8z
         1eO3Jo3mz9GOZrorUIKjXue64XrSfaDtXpyiIGeiWA3+bmiMjeKqQNYuIRWanmfedPd0
         Swe0aZOx0xxqVjQFmQx+AuBT7JF2kx3j8GGVi1ndT661GO0CjhmCpQm7wXCugJDzUXgC
         UxmRwUGmcjK1KtWPiEE1Ftl2BzST1qz39qLI3mHwhvP3hMtGBoO/Ueu5lgto+pXxyfbv
         d1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867080; x=1772471880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZL3Fp+qjeYQN997X5TZmi0Oj1feAEcYEmK2ad84vbQ=;
        b=AlAxrU16I+IMhAfqWf0jKoEumcpuYxjGhCmePdtj9dK/DQI5DXTKAvIxNNrdGnmEH0
         Rv2j3pAAXqhDGzRKcfgDFCwo4qb/6cxNAEV3Yv+gl2dUP77SEiEO5PHhaoZfhld2vcJv
         m0PXNTK0Zm6PmQpG2WIep1CNl1GUar72KhWlqewsYh4QXOqlmm8eGMmXzbBKYNOhJ5zm
         CAngrSp72XnPJjQWaonz42MLjuBIfo56UQ8YznUDNN4Hd/MKdgvn2sV8epVpl7SU8Nse
         Q1prhPV05tcPC6qXYRK5jIeVmuJ5ESMPU4zn5sGBLOwHlF68F2Fs8tHh8YTmqVZOd60O
         zXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsI9NaOGF3Vmx8vlS4F7agTvDwwF6EiZ6e6k1Q5l0xVPZAdzYGvxniZOxJnT1gR7PSIx29ooBk1Sy0dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjPcJllSx9ejGohL3aODasweHG0x37clXyDA1uE2ltroAebxcT
	niNoSoX1jGDwdbfOK1U65oX6e8zZTdWQH+vwZ6gihsIMNX85qdbmBboM
X-Gm-Gg: ATEYQzyn07QKLt/uCF4GCkvPSU5Dlm3trpoYnj8hC+pIn4UXytR+oOmgE9zIMfBcPeg
	w+0u/XzybGLHWasMoffHfZJMkP5nnfDLnJprRf0qRjWDQrZ8GCZFc57ATJTVRJWbA0r42cgTRDX
	RhWJVbebTAjp/EytPGk/OW0Q8d72DgwJx26zbEVPWE8tL2OQGbPRgfBOsOX4fDNGAw9l6Pl47rJ
	tfN6MWAdJNRIzlzmWngCJ0zrdDQSgFTiY/n7ME8ZDeXx3ZFJYUloViob538kSkHiB8eBRtHTdDr
	RmZCFn0SDmaqYTmbnGMpVw8Yx1sN8K8ca3jx6cxB4hhAjESanC4LT0BbWD8zsobthyTXtWMyhuL
	mEh1luz9Wn1/wxa+2Lz92BhmRxjS8X314h3I8kw3V9EG78c8WYVXYgobo1q3z0HaIJDbYTzwSIS
	4NefArU8fW1h6J7JS/RgU=
X-Received: by 2002:a05:6000:2583:b0:436:145a:e54f with SMTP id ffacd0b85a97d-4396f169c6amr15272283f8f.24.1771867080189;
        Mon, 23 Feb 2026 09:18:00 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:17:59 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 5/9] soc: mediatek: mtk-pmic-wrap: add compatible for MT6392 PMIC
Date: Mon, 23 Feb 2026 17:12:44 +0000
Message-ID: <06b45142f4e6a30f9f53aa561a99b936ff72c035.1771865015.git.l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771865014.git.l.scorcia@gmail.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Val Packett <val@packett.cool>

The MT6392 PMIC is equivalent to the MT6323 in terms of pwrap.
Add the compatible to use the same configuration.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 0bcd85826375..4b8d49c6f34c 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2249,6 +2249,7 @@ static const struct pwrap_slv_type pmic_mt6397 = {
 
 static const struct of_device_id of_slave_match_tbl[] = {
 	{ .compatible = "mediatek,mt6323", .data = &pmic_mt6323 },
+	{ .compatible = "mediatek,mt6392", .data = &pmic_mt6323 },
 	{ .compatible = "mediatek,mt6331", .data = &pmic_mt6331 },
 	{ .compatible = "mediatek,mt6351", .data = &pmic_mt6351 },
 	{ .compatible = "mediatek,mt6357", .data = &pmic_mt6357 },
-- 
2.43.0

