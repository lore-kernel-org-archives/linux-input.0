Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570B38E120
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798775; cv=none; b=kzt9KnHUkNAKqmFAVf4Vi6OM/vcFskCOFhGtSzqIY7RM7kYaxPgShLYGrb7rWZhwLgHubQRHueO0SAhsnrf3KEOh9F73h9GWYLe47ZZxZk0Yry/X/LzK2ig0bFW24gKSXaINlyqaiMKS05q1NOshoKegStje+xtR5CzY6EOZasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798775; c=relaxed/simple;
	bh=skkrqdaR/0vPKuUeSwmb6iwhZ8r9gu0r7vVQvuCbBik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErInjEJit6JxeAs15hEToAq3Pg5Tb+cprbjD9483cbWQ0NtFxCZXh/bsud7TuGKLMagpUyFtMDCv53br8Wt72OY4v0HP142yYFnEffFmbQGX8bRylEub9WNkkB+GOyAh0SsMEdYRE6B4jnIWzCqnzY7tS7BIOpcXDsGuiIcqN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUSSrAph; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUSSrAph"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b7c2788dso3970924f8f.1
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 04:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798773; x=1773403573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWHYFXyM7zqNoEaGGLabRt6WO8B9aIWRMhobpXYX2k4=;
        b=kUSSrAph8/UVQPztSZw6A1jhHFfGaT6qA/DAJ4/5HsqnIuClA8jEItkmmWq6/UP+kf
         UYiPomSHwQhyn0IkvRxOSN1NHO6bfE1zaPLFDn9ruR6W/W6GydZdr4jz5wqmTU6s74Jb
         MPLtCdEZIYlx0D4eTUWWIW4WvTYM+ZwHk2IOGZCC/7ybXxBTHLdjTDVKBlDkWSD0obyb
         acMgl/B1L8BggiYpMkDGZXR/ESPTFwx5XfVMX8GY5SHaapgK8pjd29XjJVnJeXxjAOUf
         iofpYaCMPay5bnA69StNLsblT5oXkCKVcRbaLhhacZW0+edSJRyZijnPnuYuTrdvAkyf
         GOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798773; x=1773403573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWHYFXyM7zqNoEaGGLabRt6WO8B9aIWRMhobpXYX2k4=;
        b=Xj5MItL0LWAzy6VN4bt9b0/jwKYp9p/vXAmVuEobo/b5Qp8Rw9fdsLX0h9nkwM9JmN
         VQbWL3myQxq85YHnnbO0u7oD46v9goQL9cSpL3JWtxsAID7b8tt0DtPc3wGw/7TDou3M
         f1a/FdL4L1Z8EUPVfkoais8Wkmggyhu2YAC7PRofJ6cThkK8LHHJbf/XpgrR/3VNcErH
         kjvFav+ccUwOg5qXuiCWgsxGwBJ+Erbp1xWFIOaL9pSdNTUpyhwf6qUEFAhWNRxsy0ts
         HfVYo7bRM5wKLECqXgpDz0VXagmC7qIshrQgMtYJ62RUYIF/iamYzJlcOfE9VJzIdYY3
         O9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD4TkUO6T6psX5xuQuXr+0oEorx+y2x8kVvO1AGjpnz+3suDIXy0cuDwQqdZ1bPLBavfHtO/FCb+YirQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvLN8L2HXYiPQsHH0K/ZJhPTusRJ/R79Un4qiG1CPDMLqCjAD
	3uhE3sJJrPhcvORtmCENUtjxhL/sGExiGSQ4I10x8wd9Ttpf9StYDfxr
X-Gm-Gg: ATEYQzxc92VwcAaRVtiHsH3e0BLj5PkpJOMbgZZoL4eGR3SXuQJXSP6mtgP7d+grtAi
	nVo/ZvyQXv5mDmJosYeGRssCKPkQmyGJhLAVizCDb5mmc03x1/Bo0jT8enqayHvl37V8yeaVaFp
	d8QTUvEQxuyI7UsfjEDsyY1MUSH8xK32eqTutpXcLKeop6ebDPecARBIPARx97/FRX5nokqXvxg
	79WDQ3ZvQf8LSVu40HRC/cQ8CFqCT8CicHnMheVPUv9ijPSybpNU+LFZl4QOeRXyyj9CM/W0bLD
	PWh08zZiU8xfh9YKvgLn1ruX98DTmtTJ6AGYiChFiyrp56jmPZADa5Va66VCnFfeySpfAEoVhZc
	7LeTAVEFs5yLrPlkMt/Swx+cFAH1nnUa8nc4LlrnoAz31Wl7onpOBNFfmYWbCLLfXdLOt5qoX0V
	o4duCEyKEoaW6fcP8Ymkajf+xxUCU7FQ==
X-Received: by 2002:a05:6000:4283:b0:439:b912:7391 with SMTP id ffacd0b85a97d-439da34840bmr3145089f8f.10.1772798772610;
        Fri, 06 Mar 2026 04:06:12 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:06:12 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/7] dt-bindings: regulator: add support for MT6392
Date: Fri,  6 Mar 2026 12:03:06 +0000
Message-ID: <20260306120521.163654-3-l.scorcia@gmail.com>
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

Add binding documentation of the regulator for MT6392 SoCs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index c358b2f8059c..bb1456d01ba9 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -100,6 +100,7 @@ properties:
               - mediatek,mt6328-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

