Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05A3659F0
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798786; cv=none; b=juQJyf2BkmSFMvOn1ubYsWNtsfaf31+FM0RVsLxrmB/w3df2kDAXudCDs91zW+hWHMt9cIDfEmbw0jEbynKVWYAmZiXZLZyO+f9Y9sIhvmkvzZ6gcXrlXh8IfaQJ3gDkHvk0B2E2uYnSZbPo2NLIzpUsaQmnu8kcmMRw8JVlMX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798786; c=relaxed/simple;
	bh=q8iNQRclNimcvTVMz/xp0ANElWweIprPYt8rET1d6u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMGCtTQttVu0PNNpAUhsjAGmfCpu8pbOhz27yZnCdN27yINKJEb2xBoLUlGLmi4mLi28E33Nkt4x8nYyyiDXgnsn5QpoUXNcq/JxyxWFRsvgcMzSXYiKkVYTapeQ5M4uZGSZJVgsAzzWIXLwINTzSVbLHcStuC2MlSGmSGjplBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkh7R4wI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkh7R4wI"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c5b40f60so2628350f8f.0
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 04:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798783; x=1773403583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+y0veSsgUsUJmnxU5xqCTTpBOt5TLJfl8EzSd1maDY=;
        b=fkh7R4wIhYmfpptMYrrqKRXNhNMhDlYQD6yU52VfzlaukLS141fSbydQF9L2K1IyKd
         DKLtonRhlY/JuKJ85qnFTRbDWT0QWFpeSzx222wlsEMHN8gyTjIHZEq9ycITQwtWjpqV
         ZpJl20PJVPIhGvDL0Nf/kWMxu32WE6DmH/1zWfKAwyodo6Jtk8oAIRWt7Lp9adA9Gp8D
         qcgbXlhwYOMomuNaPd9xE4Xo0n2NFRoffcuR5cOnh0oOP0y2f9rlDcuf7I6ukFyLv4py
         t/Hs9zXRg97khQJdm663VAZ0TRH44faJyqrjyrBsvEV2DG9l0jrsinqp2XG+pZObXG7L
         4qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798783; x=1773403583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+y0veSsgUsUJmnxU5xqCTTpBOt5TLJfl8EzSd1maDY=;
        b=lRNSu6hnYykoapumT8FR1ENoI4gHcpheGXgJyL1/V72teAEsc87Z0YqIdhnM7pCAIL
         X1WY0KpV+OLyuTya6DJjm/rsi9O4+ys5fLNB1krEBLWt3mhtFUQWqXd/52OzsqA4jbry
         5Zing/R7Iez8IFnHYqTRjPAtZeLDPMm8BupP/9s2fo1BVPx66lco3w4f9N0wtdvdB4li
         xIOFyCFk7IgG9m2xUrbBErn7ipAZBysHm8OqvVEhAkXJxnPext4GO54INOGEliLGzu3N
         2DWKeJLfNMWbntX04kkI9b+1262dKQa1P2AdzZlWwkpEyWE9qIFK8pSZoRyOAEYeNwiK
         uAqw==
X-Forwarded-Encrypted: i=1; AJvYcCWG5dQl+9zDv5zgKda/naZLskV8l6SdOlJFSGzmbtzkc65e3+3ZrLm/1/vG+JtA3JKV8eD6bx0KEAEgtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb8bzzIi7dXw+sH4X/+irpdRLy1ObHeJNYf0S1sodZU5S6jq2M
	EOI7xBQimYeiUUEcmLsCC0FnWPfnxNAdlwaMhThW3qiyr8mERDEs9Ea+
X-Gm-Gg: ATEYQzwpgGm0WVsKAU6TVqRjtAivGe7HIxHQ33Gt4Li7CMKF3n5gyzK82pBZm0yFBa/
	BjH8oEHDOhcGh7Yw5uBbyr6vts8O+8JOu+FlcAwSABohXjc4PGMTQ6vxh8zzDMGPyKy3hBmIP2N
	nVyBgbVxzqu0umRaFzFNLVAwaGEOtQAeQXn75mCDc8bzPNTXX7cRRJexmb3ANwkMtK7+uZSGL6Y
	7Y+3WB2AYYBGPAnYsOZ+v+lth2Zw7EOM1WGQR+/ZbV+Zk2Ce9BZ3lffQQ007U99JJcOD3Naobh1
	LMfZawLtvcx0smJYqI2xZM2KCGQnw8EP8y4iK+D6QMZiuDnS3nRBk7X+cdw45K9sXd6FUsy+Ssx
	fBzkyM7t0XYmgS51Eyx6f5YmF7wNzDorJw/v+Y82tq10YT1DPXYN54jeRj6CP+WVI2OPW8Bn1uE
	cbgz3ttzFPrsp6QFlKvUk=
X-Received: by 2002:a05:6000:290f:b0:439:b715:6f49 with SMTP id ffacd0b85a97d-439da86fa3dmr3098642f8f.59.1772798783337;
        Fri, 06 Mar 2026 04:06:23 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:06:22 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
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
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/7] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date: Fri,  6 Mar 2026 12:03:07 +0000
Message-ID: <20260306120521.163654-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120521.163654-1-l.scorcia@gmail.com>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
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

