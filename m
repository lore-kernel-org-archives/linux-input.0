Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293B38F25F
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721022; cv=none; b=ZNLXixr70hJCcNGs8AYN3eAtKNT2o8yeFtSP3YS0YmthlCTGSf9Hpd+ozUFTNaTRG2bB5lBVfuG7gYMQj5b4XO0rAA9Yy8k5Qm/4haxKCzrjJHXjn4zrU7FRPLTm1eTyZVLb34/d6/gls+8Q9XqH43MVx0KQGxTlBRfDNPuFiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721022; c=relaxed/simple;
	bh=8avPzjkVf9V7xqsFuREDbJnx4rKI5nF9UCQknqLhMxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX/ABH6PkBa8Q+5HeJ95YH5X1yOi7vQZD7VN8uxpgJoZhSIdFskHQIcAGDsU8QmVpvcaLGZpIYJxgTYi+oB8WVFokwQzQ8tEFH3Ip04kAQTCOWuLWbAcBxt08OqdvRFq28oYtPdjbs8pfxuAGT5wgsMZ4iTs1gSvUtrN/sRy8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIVzQOng; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIVzQOng"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48896199cbaso36926965e9.1
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776721018; x=1777325818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vndNgbOdyTJpKLwuHM5pad07Ye98EZiTxW8ph85Wc58=;
        b=SIVzQOngeh1ibnbriZVEw7KtAeRK5U364aE4zfXi97A74xg0YSIoUbjgKtlyO9Nv20
         /Of7Ba4l6se4q4taGQE0YCG7/xRYCX/ci8QjMzuIM2LN1MjCSms4RrcfrKKaks4uQa8Q
         JDE7PH0b+sJGDmly5ZVF+qL0JetVpHu4H7QAH+LxYxxDgu846R7CQgLgXC3TCO5IvAki
         UcdpaqWHoC3MkzoWLrz9u7tHH83Syf8FZHBqd1wCMmUXXX210qUywwCUi5bVdHy17zq6
         T5h9jQGSzRMcWsO7BgZl9S0LFT4P8h6vWhnirDqR6ZBlbCEsSKa+yCBmMHZRsJ/DqtI8
         B62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721018; x=1777325818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vndNgbOdyTJpKLwuHM5pad07Ye98EZiTxW8ph85Wc58=;
        b=eHcUGY+lVchyxf4GTM0ELB/rm6d4Gi34wA6C4OsgsOuThWESOklrP6A1XDbbgk4Ujp
         8+S48nbmyW1uFYNGxg1IpkRZg8dD7xrolgN2jd/EMOtJKytCiSeAOD2vyBIncvTQ0P1k
         XwxGNXaR9UtY/SOx7Vz+yxVbhIiIXib5HQp1wntlxBiZQbWOaVU1Dfn3M6FXFOh2n1MS
         hYJQXZt4XWy8KcJro8MeUmAhihqWKhnFm54o7IXiouSnRzZjOMYi7h+HEDT4+sKlkYZ3
         jWBAFjWDZ80TddiDlZqr03QyW6CIyXPB7DoYZd1hxHc8tu5h64LfBzXZ1JyEQZb3/K53
         MPPg==
X-Forwarded-Encrypted: i=1; AFNElJ8NqLx86PCeuUv3v89vH8Bgwh7NM+pcj+cK/Zjq+teHLK8oVRJibstopxSEzWc4UuGAVj9KzG9EMyfwJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0VhV+l2lTDHOLC8zblyksuxoPBG/SisBAgmOLS9Lb+AUbY5B
	C8M9p8UBeJKV/QWJLRVfOgGCaG7kftitAPbJ4y/WByozoxRf5x84bZ3G
X-Gm-Gg: AeBDieupxfC1ffD2Asq6XA5+sZr5Ar/i/x1fmfk+TY/gH10Os9blQyZut/COH547R9L
	Naoi6IIPajm9z2odnOTHlg6jiXTo5fSWrA/yCGWkJoZpvVwAaEZXihpXx3jQWaZQ1H+YWF4FSFw
	CxXv00py/eTkOoqM5ljK978dPG8G4oy0XUrjfkVK2EPIbg3+hcs9dl0FR5qG+fY0Q7KpZYwu87T
	5q/+RDjSSn5pC0fSvQ8pdGY59aGqLWY/c7+EqSAc72jigKzju2MzEvVDhPGK+ix2BkybmBoR55/
	ELGqoS46qXUAdc78AFw5L+sammX8QFMPkl2QJhiwbELlYu/1JhW32S1ZQg6I8O/c82K0NSil9pB
	SWI0fg6VSayQjkw/0Jsz3KcT/I7CiPhOytbgXJTy7LPtZJ/+iswSpl08KsUNBTPN5b/Q6W3K6Ga
	HBkrI5Bc7t2rKxbFOldviqc4BSfRtGX8wIy0t66BPx
X-Received: by 2002:a05:600c:34d3:b0:489:1cda:bbb7 with SMTP id 5b1f17b1804b1-4891cdabf13mr74014935e9.25.1776721018309;
        Mon, 20 Apr 2026 14:36:58 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm289500355e9.12.2026.04.20.14.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:36:57 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v5 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Mon, 20 Apr 2026 22:30:01 +0100
Message-ID: <20260420213529.1645560-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420213529.1645560-1-l.scorcia@gmail.com>
References: <20260420213529.1645560-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of mtk-pmic-keys for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index b95435bd6a9b..2d3c4161a7f8 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -30,6 +30,7 @@ properties:
       - mediatek,mt6357-keys
       - mediatek,mt6358-keys
       - mediatek,mt6359-keys
+      - mediatek,mt6392-keys
       - mediatek,mt6397-keys
 
   power-off-time-sec: true
-- 
2.43.0

