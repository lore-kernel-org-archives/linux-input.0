Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938FD386443
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377700; cv=none; b=J7+HO9kou+wvXLByNVU9NVlfAS94jd9Mer9+X7EWKCW7vr3DlUaJL8Alf4wNhk5IhvRW2AQMTmEFLTd/VqbLZscBVKOZm1dlKL2kJ5nyFonhWrJ1CJoO8vhvcQDqeNR6VUb/mEciIlnOmGaL4QRgyqdSKOM4qU4LYdbfAM8TciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377700; c=relaxed/simple;
	bh=UGIM3aTui+shPbVvhLT3b5f6OpTvEv4JPJold/DY6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE+IvYHiGFpsQ50wadpUrJylKWSxGhYhKaIpDf65QNlNmvM6BbweLp50oNHeScDzHY69uCy3gtSXo48Hg3wJMGRROjj17PyQk+Npr3/sV8+fVtjWjkFIsMwsw7DWA2DDbELZi1U3FLSWJ20VqkX+1MVc6H5CBpJvl2w+HlvnU0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK9fhsdq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK9fhsdq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482e2fdf6ebso1593805f8f.1
        for <linux-input@vger.kernel.org>; Wed, 02 Sep 2026 12:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377682; x=1788982482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=XK9fhsdqDFBXhDjSuvWJfNE5vT/jVeNPYAPP/NsbbmaD3WbbBJ8NmTOZ9mY8+VzunN
         KdMH+E+kYoUcuDdKeZfyf+1jRkx1ke28J3+mJxybitnpa9GE4lBGiOwLiQyZUrsi3NaQ
         d0itTIUnxjzeyI0qb1nEyA1sVdhEI0tKyoJylS0I1fofsuoD2XAW9fSCMkYPTeFTR51l
         J2JLqSmJjWuq2NXZP3vy/SS3Qsn/0TSbIo6dLmvzySLHrtcj8M3mS79hUxkWp5KYUrsH
         VwRRvKTb6J64DZPSekFwGbiuS66QqX8vv8Q5C+MqTKv8BFOQABLWhFgiZZv2eUPkPR5i
         ffDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377682; x=1788982482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=qksGTswhHJfhHCeaTxwvup+jHbTFiayEE6MSmmzB2drVMi645Xy/LY1YFDw2tTA18B
         EI0gOyayF9VxPLmWIu+jWeCNAVO+8Dn+ZxXR16YZJX20cAgAz9SSCKRoTy+bDBalRgMw
         ZqPM4R6PiTAx74LJZL9pm/VWT9Nzxv5ynRXHhzCjL2x2x2b8YzSyNqouONxy+z1zRGc+
         RSHG1+F7/F+1Ly6Hpo4x9jvQp4A4NjHJoKDoYcbWUogS6QEn71PZ3F8KML1xQ8Al0atZ
         F7JxP+EE2mXHIMdxhQNFXH2KMzzI3taOzQi93f20GlorBu8I775NOyT3Jp/FxNNr+BUq
         sKug==
X-Forwarded-Encrypted: i=1; AKwUvByt+XkVl6GnIiGcqdc6GiNng7hKqILl0GYc1qR6bo7YFeXjlRRwvGLOegWoe2osViAed7WHKzL8RxzaWw==@vger.kernel.org
X-Gm-Message-State: AFuF++krcFNzsREPD1ipJ0FGorUEBzpp9h1i64sACo8Z/NnFXhNBoeov
	JlmCITrlaOYri88WOvcUEvASkAR4Nry5PuC7tF+7GqhVq6qaN5A1au8B
X-Gm-Gg: AYBFou1Zxbx0vLxDhBfWSCge9zaSqtmu9aA/Otsr84Yn7sDm40IkVNJ1INFg7brWjSi
	aQxrzlh2fugoecJDPuQnyKCXc3bNisbR6GHzHTMUqwyS+ShQ1B6GSdVWvBKFG+iJusicEO+AE2e
	wy+5pA+UkN7XQL1gmjNGenAUeE0/lMEMrU4WZhq6vCHke4wBeZWsTt5LZCduwfSSH7dmH6kRrv3
	xI/FmYb18Xe1Fr5YFyW/peBTbOuePwP0Unb81j4CHCRFlEpQIZeaT1LuvVxPmKq2hTMwsGAH57s
	xK38fmKXPD+KaDSC1Cebk4E/z34JNbXeP5UmTabsU7dLgrYE1PSLTWhiXDBy+Zwq65Dp18FOKwb
	IE64dQhQ/ZUsR4ishnb/T5jKNfJoXOX75y9+404vqpO3IuKgd29O5y9+ilCLm0ftLuYle8pCyn3
	cyZpcdcdmvyKW/GUXh+fJlAMpqeZL642g/F7qXX3qTlB6Yquv+Zar0jnnS
X-Received: by 2002:a05:6000:480a:b0:47f:eac2:6f55 with SMTP id ffacd0b85a97d-48488f2229cmr14997817f8f.19.1788377682430;
        Wed, 02 Sep 2026 12:34:42 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm8889191f8f.34.2026.09.02.12.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:42 -0700 (PDT)
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v10 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Wed,  2 Sep 2026 21:25:38 +0200
Message-ID: <20260902193351.185771-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902193351.185771-1-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
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
index 140a862ecfbe..ff720588128b 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -31,6 +31,7 @@ properties:
           - mediatek,mt6357-keys
           - mediatek,mt6358-keys
           - mediatek,mt6359-keys
+          - mediatek,mt6392-keys
           - mediatek,mt6397-keys
       - items:
           - enum:
-- 
2.43.0

