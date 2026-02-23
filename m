Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59D330D38
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867113; cv=none; b=BzBim2kEATgWMESJfiWjVQ23do6ovb2iMnb7XD2YXl988KdcLQZ1cGiF5I15YGPVpD5a28b0rpH7m5dI4eR2QplnjTYlsTZZJ5BGJ373XpckLdL+l/Thv3vhUhdjzGA5PbCkMlezzWAfNuVmK4049uZisCOCvZvBj3PAlOzXYqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867113; c=relaxed/simple;
	bh=uxYGaJ3P458lu3G0cMf5GUqhaAntuF9M6oJUdaMzBds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZ6SNFWQoiXInJvH/73mpGwUnfoKFW3ktLYWj92wfYSHZCO3eYXFC8vVQO2/TrbENdujyl4smmalZAvIv2RN9Xx0EfDhg8v3qhMjc3rS8W2Oivw8fNjvOgvLgnMGRj/hvvxtz7OUCF8okYbsUWsNORvTRvRhLGV74ipI0Kldx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TErMkM4w; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TErMkM4w"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43626796202so3938874f8f.3
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 09:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867110; x=1772471910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tprEZO19LVPoDO66HWFcNuv9Wp3nvVBibsZ70DTJ4o=;
        b=TErMkM4wRQpR1nFCnXHkQeJsWXpycU2gjujrVwJPNfyXYxgIHNJgSddm61znd4XdCg
         lTCJB7RSNvBJS/xR/97fXUT1+yr2jWQwS+1sglHjGCGDrQBYULluoJwyrf3U2X3tDWgU
         lYtbwAES+138DGCmF7bogZBLrE68B3uNa+IYRn5huREfbauMOATpDmnUrEoQ9+p4+WeD
         ZwMHlZMLqEN8ffGPeQaGo8OrltUPcbbRmLBcb7CK9LdK73pCgCvLLX8i/j8SlT7UhCjt
         mtKLp9xxOLyZ50EK8VmeImDuRKNiRhFs3A9Zsj1ol3noKJRCyIbT4c8TlApnH9IpDr70
         /uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867110; x=1772471910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4tprEZO19LVPoDO66HWFcNuv9Wp3nvVBibsZ70DTJ4o=;
        b=fE2pDnaKa+ARzz1UXOHXYzmsU2vA0v1xp29hJjhjb5jXh+jBXJZSt6xHiMh8pM+d0U
         RvCtMJ3OwB7Rq4RKes6OElmuRyNrUt/EVNcWysyjCt/01LiUBd/D6nbKl+rD9lhQfZJT
         YLavtibIO+aBCJ5S3IMRRq9xN1nahngxNrBYurNnmijzo700pG0z+aO2rGC+XpzVp5aM
         EIVb4894y0EUu/I+A9FFSJJQU64C5cqPrhp8FXixaNB++Y7o909vPJtwxwyNG+YRs+SU
         WCQ1nfotlnMzAKkvWeFHKWvy3Kvd8UpdmqpEtqKDZfXHk1SzB6kbCwS9TSfQZeYn4X7Z
         xq0g==
X-Forwarded-Encrypted: i=1; AJvYcCWedRJW8oCJ1+xkNoylrxvg18eKvft3pm59wFUASbHJwuvM8p9UuTfONmr0bW/2SRm6bo3Q2GUXtDa1bA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOic8PjVHZ6QNXdI+7ahBVuA7mzFotzbaOjfcEB4UEoANgga2K
	KmhkWSjwa8zYxDCf0hCSt1UjS4RBkAAotvM71DajWUsl/0loW68fVYpk
X-Gm-Gg: ATEYQzzuqdMXT8EEKA3576i2rUXgnZ7iM+e1qS3nGuypZYb/4VRmfTW5qVds0D8osY4
	5Owit1V/+SKRJlgwFBDx5mU2VfOM7FWKoQGkA2P/DYmd5vK2fdoUCi2FZZ/01F7oCHV+qjBI5Ti
	+hAecJYpYHViig8Ccpiq47WfH1HFSk8YOmRJrr4o3oQR/B/NqI8aNy0abKbXiPT5PHyA2ruCAEL
	HdHalKZL3jx0ybJyXbctISX8j2qXJD3LA+xjZaplvIgKW7X1ThR51JoNuo22Gh56NGfJ78yq85E
	vqwuUokptOT8AsOb1okyZHb8tzPpbv+RlBmTLu/xM/vINuL95QIfwCwSrIARm0WRifPRqPIzHKa
	2qW7iNYoZ0dcQLdtnh5DDZtQPOadSWaswXQkFlGNdxenT6EnJXr3V4J+E2JdC9tWz14QXP0xu5o
	DRneot+fHAWJ2I+eER6Yk=
X-Received: by 2002:a05:6000:2486:b0:437:81a2:46eb with SMTP id ffacd0b85a97d-4396f17b1b8mr18714978f8f.41.1771867110323;
        Mon, 23 Feb 2026 09:18:30 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:18:29 -0800 (PST)
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
Subject: [PATCH 8/9] rtc: mt6397: add compatible for MT6392 PMIC
Date: Mon, 23 Feb 2026 17:12:47 +0000
Message-ID: <1d7d0048eb2d51c7b5551deb765951d33dacfec6.1771865015.git.l.scorcia@gmail.com>
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

Add a compatible, using the same data as the MT6397.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/rtc/rtc-mt6397.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 692c00ff544b..6b67d917f8d5 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -334,6 +334,7 @@ static const struct of_device_id mt6397_rtc_of_match[] = {
 	{ .compatible = "mediatek,mt6323-rtc", .data = &mt6397_rtc_data },
 	{ .compatible = "mediatek,mt6357-rtc", .data = &mt6358_rtc_data },
 	{ .compatible = "mediatek,mt6358-rtc", .data = &mt6358_rtc_data },
+	{ .compatible = "mediatek,mt6392-rtc", .data = &mt6397_rtc_data },
 	{ .compatible = "mediatek,mt6397-rtc", .data = &mt6397_rtc_data },
 	{ }
 };
-- 
2.43.0

