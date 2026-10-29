Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268412;
	b=XCpj5RAwcioy6/Qycho9Ac21YQK5p06fL3JFgHZ2afkvX2E3dIYgQ47banyFzP55kRJ5
	 7vABlPvFs5GSrp34b7cNgGpNZO2cfrls/T+dIFfq/QlaMZH5mwnsHBiS5mDtbLYVBrHMf
	 UtsF0F5qFnoUvYAjK2RSHe4BliEgISgp+6XrbSextUgOkJBZ4rxPI+9/gk4wJ5YZGdJLr
	 56zgHIcgCv+rnb5Vvp9DqVR/AKF4WQjSB3yj2StLvNF7v/o1y+woRwN1r1yo5shAh5wWf
	 oR62shFn3dh3orhOJkdhCYqm2i0dSQPJAeIHpagTAsa8u5c41Uc4UCQrWBmzmQYhJ8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=AR2X8NVRTcLGsxmelwGtGxXnKtbtxnjUeTJFNKukauU=;
	b=WHxP/fvZv99QNM70rTmwBGCWCFa39Q5CLlLanPGnEV7WR/YvDyysofevtIaDrwd21cfF
	 8guhbdoSUAF9z3ZU2ljSPpU1ELVaCXSbx1kDVfAd5PibLMVkRB6C/Ww4ZjxHVZ+RNXdaY
	 s022u+NEbp8trd+nGBfz1NciRQUjQGxivPguRYRIXy0diWrcWmCXb8+ttk/jqe7BdVdIr
	 2q7Grn70hzfNZAYHwgEonPQMC4gSzzkcDMEG5i9N3lRcYNzcmHptOV4fI80UqB3tGKF8f
	 GAQG5Po/lny7LbNF/ywKK19fmiUis5KoUFqFPiU6GaIKi+plhF77D8mMN+HlPeWE6ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8DaMXRq;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2C606A320
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 10:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C2C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8DaMXRq
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so18141885e9.2
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268410; x=1793873210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AR2X8NVRTcLGsxmelwGtGxXnKtbtxnjUeTJFNKukauU=;
        b=g8DaMXRqXQHsWP5RYCoTjKZb6HnLyosxq5FmZQ6TeA2o2vjrOGausXQlCGA8o5RIlP
         XdOmZMBDPrjelgWO0XWrx49n21MX0gDLWqVDAFhjxGo0r15IHn13A1mWYPdH+kVGztbq
         Z8qz/A/Hw53ImmLdKYUvs3sriEtQIJyP0IW7cUElV3CEyarGrhLy1hHYyR3PkH4WFtDd
         8fXoCeOVpKQcVDV9q3cMYUl/Pyyy9hNGWE71pyj5KvUrjyKGt1m4yIejFzBtNpiFe0ke
         ik83SaomozZ4tJRh4YGa9jRSEtvLy7RgOMnB0gPl5tYk/nDkXcUpVcnDFCM568NVcauz
         EErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268410; x=1793873210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AR2X8NVRTcLGsxmelwGtGxXnKtbtxnjUeTJFNKukauU=;
        b=WBlMsTcFI6iz6POKhyG2PbC8yXzrRFLH7wTIUzY3/8B7zoKDmfElM+n+vRImP1GB2k
         mOhAdfqrV8IstPg7VZ1k1fNz2lgTNyZLLni9HsLlv2qzs/seOYNmlyrKXAphlTfsL62b
         +NeBAt4v8tZFx741JDThSHbd3JvT+MsRxKvSuz+DWMt+GYmPusZx5KO4OvERA6hrV/bV
         Dt3w8jJsNlo5V+JLWUfhlcp1tGDtyqIDNyEtbus4JXNStCnbgchJeYjBHB6vwRgYxHUI
         QTi48bjXFJ9M82DqfcCq3WTGxCJxfJWJtTP0zDvRujgzeDZ5fKox/R0vwkYVoCmvfHpL
         vQsg==
X-Forwarded-Encrypted: i=1; AKwUvBzkG//CMJgYIaiECc2kU2qglnAYezbhXFQukoUjZPpOlLyIK2esyQ7tIxnZc0Qy26fA7FLGwZ16JfFe7Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLoKaOqInYGD6nr1NI9GkVH8DmvuRmGRG4rAFX12hRrTnDQQHQF
	+mfd/rc4zsJvyv91R3KFTZjHt+OrCd9qOIZbpeX9f6eChdCSxHlRoNMd
X-Gm-Gg: AYBFou35yxE0j0i9KWIjVhDz2gsv3g3vtHDEZ1YaKzDM/08xlcI3AohQ8zZw6HVzb8s
	wD6AXaCLsVGJsSUGY3tRcAloNO2vjm2T1bj/RYQwYybrLnG33LfPQZ5B2s0hQMJ6rKS+IEMJto/
	x3f+mTs8NI25fqvBaDzJBZGLpNl45++CEw01UZh4KKiRgLUgLMCqUWJwwr+ZhkKEnQnkcKBTPnU
	7CINOyEowRJK3MPSj6V2HBvQBS+b9QnyP+zITIsKxyMGEGp0QZJpyVcCGoyYRIqtsgZTFhJ0qnr
	nEIhm0yublIERiG+IyWx6n3z87WyVTSg9VZkTO6jTBxGYvxSE8S/GkEnljvpC1yHojAl5ixrd58
	RNp7aFMavG42L8MZpUCGW4SXL6NmZ8mcs7gisiHGwxcjVuQpglbnEaA+BNaPKktQiS0prMT6ax/
	CKxppxnfub2H1BCC2M79HHy87ludd6aY7MIQq36raOy+UDkwRbGZ0slgYlU4Hj93W+XJS7Gc40C
	SqxALkWRgP1F0gEsaKHSRVO8BkkT3wBvunnORPfPObwsGTai55UxCr+TleaCIw/8SNOUmhcFcnf
	e/kkYq64QuJpTAmlA9dlSNqDqNAvTto9f4dYD5RADO2QTFA9tBE6w06BC3+0Fg4LAe9QHwRiT28
	bBnIWGakD
X-Received: by 2002:a05:600c:8184:b0:4a5:1c2a:4bb6 with SMTP id 5b1f17b1804b1-4a967ab15c5mr99622405e9.32.1793268409952;
        Thu, 29 Oct 2026 03:06:49 -0700 (PDT)
Received: from [127.0.1.1] (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7fdb7691sm53082825e9.11.2026.10.29.03.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:06:49 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Date: Thu, 29 Oct 2026 11:06:24 +0100
Subject: [PATCH 2/4] mfd: rk8xx-core: keep the PMIC interrupt disabled
 during system suspend
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-2-cb12621c1fb4@cherry.de>
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
In-Reply-To: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793268406; l=2691;
 i=jakob.unterwurzacher@cherry.de; s=20261029; h=from:subject:message-id;
 bh=L2myRTbrcpVngJZXrNjm8FAaUWxZTcJOyBmmVMEVxWs=;
 b=5roX3q8fy0xNI6ewi2I12L2R2JapjPSuuY5TaRN3vlegp1g1Oc3/GfvhvCPzLXeWV3msOj/r3
 ynNr0KDMGwyD0+1RWAD6ZSNcsvIFpjK3KJMTq3YCxA49RRB0C9KieTE
X-Developer-Key: i=jakob.unterwurzacher@cherry.de; a=ed25519;
 pk=0v1L7pjG4d7PcaYPMOmzP4SjaRtnB+8bMzZLZCRzB8I=

From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

When the system is woken up by the PMIC (e.g. by the power key), the
PMIC interrupt is handled as soon as interrupts are re-enabled on
resume. At that point, the bus to the PMIC may not have resumed yet, so
reading and acking the interrupt status fails. On RK3588 with an RK806
on SPI:

  spi_master spi2: noqueue transfer failed
  rk8xx-spi spi2.0: Failed to ack 0x79: -13

Disable the interrupt at the end of rk8xx_suspend() and re-enable it at
the start of rk8xx_resume(). Both run in the regular suspend/resume
phase, while the parent bus controller is active. If the interrupt is a
wakeup source, it stays armed while disabled, and the pending event is
replayed by enable_irq() on resume.

Store the interrupt number in struct rk808 for this.
---
 drivers/mfd/rk8xx-core.c  | 19 ++++++++++++++++++-
 include/linux/mfd/rk808.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index 21182df45d1b6..2ae9107fc5161 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -851,6 +851,8 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 	if (!irq)
 		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
 
+	rk808->irq = irq;
+
 	ret = devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
 				       IRQF_ONESHOT | dual_support, -1,
 				       rk808->regmap_irq_chip, &rk808->irq_data);
@@ -929,7 +931,20 @@ int rk8xx_suspend(struct device *dev)
 		break;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	/*
+	 * Keep the interrupt disabled while the bus to the PMIC may be
+	 * suspended: otherwise a wakeup event (e.g. the power key) is handled
+	 * as soon as interrupts are re-enabled on resume, before the bus has
+	 * resumed, and reading/acking the interrupt status fails. If the
+	 * interrupt is a wakeup source, it stays armed, and the pending event
+	 * is replayed by enable_irq() on resume.
+	 */
+	disable_irq(rk808->irq);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(rk8xx_suspend);
 
@@ -938,6 +953,8 @@ int rk8xx_resume(struct device *dev)
 	struct rk808 *rk808 = dev_get_drvdata(dev);
 	int ret = 0;
 
+	enable_irq(rk808->irq);
+
 	switch (rk808->variant) {
 	case RK809_ID:
 	case RK817_ID:
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index 7ffc904c864c9..1255de484ab51 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -1461,6 +1461,7 @@ enum {
 
 struct rk808 {
 	struct device			*dev;
+	unsigned int			irq;
 	struct regmap_irq_chip_data	*irq_data;
 	struct regmap			*regmap;
 	long				variant;

-- 
2.47.3

