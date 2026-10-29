Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268411;
	b=wkpAw5TIqiwTEj3hdZOJvxyFJxg2VZLORIsic3d0ihIuR0j3/J3+wY0QeuFrcWs/qhcq
	 AXlSfLYWRFW6yq+mWZLmOrGpBRbozELy/8BSJZSU5UbpnSyzJVaBBfBUbsQXjcqxdywiW
	 uj4S8TG1dsqX19Xt0ohfzxP9sa38EVCSv5Jy6W7gdgStNNuQwGp2oyCPiuLYdx8HGJ+o2
	 9BO84u73+LrzkFIb8KXaLUqtNU0AnjUG8skXVhY8UuMCvEd+AQG8Zt5NU0/OUhr65QsPV
	 YgIyOmSywllrzq1dtZQObOaXm6H04TvZV1L1mzg596VZXCna1sSrOdy94owvDYR09Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=C716tLFOYukgv8vVV1xiU5crvYZUQVn0gaj4X2Zv6Ao=;
	b=WwVp6KlcdrBfyvF7SdjB7P7ranNad2pANTC9kMoZJyFL3t9tC7jgI3ZTmqKxG4/URO+J
	 3M/7LD9VkiqV5aAfp4E/n0qwsG1a+joeQZs85F9VP/vd9Xszsu3i3OzHlnWXGGKLjICgo
	 mz81bCQ6+jF84NVl6BzPaKqN64JVAFsC4sIKeSUA4s2kISKZKNP0sfw6kMouE2K4cNOGd
	 nlloXTzluk6m4jib/ZV2ibn6RbjcTQAJIFkNm1q2Z4ykRLP7P6ooVuleySz7uIyPxia3w
	 ZqPFVDPdbR5NQhkz3yjSvsLEabdNAUKz0v7QTaDGoQ+7rjDswwdRjcLle8hgIlwaUhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=szocTkCB;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362E606A32E
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 10:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9362E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=szocTkCB
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so21107855e9.2
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268409; x=1793873209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C716tLFOYukgv8vVV1xiU5crvYZUQVn0gaj4X2Zv6Ao=;
        b=szocTkCBE7oOYlOgAnfB9taJGXNBjNX9zcXzpd0wS/9gRFlbmIQAsiPN9Okg54uQDG
         llCfgrEqY/JVWpzkz++b9QrLHfS25kOn09NJ1KGtKeY1KA1KFO23/3V2tGleKePIhNeX
         kE/SvLJei/zv/V7i73ARnuETTVDiHtgVudnm2epwrDUfeQtWM/Z2zmHVlIw6p8IS85mF
         46pFBrtjXtKyhz1vQz/YFJCYxeJbCo6QCH9h7QA4nCinUykNgFxZVtjsQw7bFTwa4dKR
         WadBPTwajaGI8BAIPVOA15AZ8rth4IWRCl11KxIFbnDAS4e+vAQxNKDropxb3yz6cAe3
         zPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268409; x=1793873209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C716tLFOYukgv8vVV1xiU5crvYZUQVn0gaj4X2Zv6Ao=;
        b=wQ+1Qns/nT2QmNC8RxhAThBv+ebGclSkXmpvAFnsYV8aCgn0bwflt9lHNVfZ+kv2tj
         5dGzjIZ9MhRU3QtcLL90iRlkG9865HR78nXEmwxaT/rhVoZn08QQmERTEL+PxkHUGPHw
         b/w39D3tj18WcwVP83FwE/8X2ilEdL9LnkAWNokD5lIsn6/4JGOfUFXL2SRm+RS8FVti
         m9pznP5SLDO/4oEKjAZuPngD/RGapB/tEb4rpdCCtVTRMG0NpEgaecadqVWcadCSteC1
         /AmkS8t3AK3pjNYHrymV1vbjFvHMbpg/CfUTCNL3UDvuCH0hnMmFnprZMVaP2XxoduQm
         RHKg==
X-Forwarded-Encrypted: i=1; AKwUvBwvKvsv0FwZHJk45XNncFj73R4rlidHafE8pE8p+rylccGEa30QH5zfLudGOjtP9PvFSLqQG4ZYxeGhZg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0/dELedPeJqlosZ0LTYXYV5hR53lhmUT8ayras6wR2i+4A+dd
	Z/Vf0LNdBcVcP22vyKgo9FSyTgdL0/8liSykCY3jCkX4QIENxcpQ+K09x+cgiAz0
X-Gm-Gg: AYBFou3vPn+Tu9QSxSkem9w2+eSGHRvgsCKDV97ow7wVGYo1esFvfcKU8iL1gOZgP+7
	5Mewb9es3dnur1Yl9CKMC3NyDMtelO9Jh27uB3tk9kdM7CfW6Qa84sAOsKETt01znEigIH6a1yZ
	pRvP+eNIUnpXFobGkMO4um2D9mubDOzwpeOPlJ754Jzyw0j3RNdoErqLAqN8MyEUY7ST+tdum1i
	7SjaVyrVw4B6gJV02Zx4SisCpx0YTMYCAuc8hwCucWTURMInCD5q/KJSZETX/E/XCKtrSD6JG8Q
	cGhMvJx35GVz560CYKNO51isDpfZfyhRfb6BXqQoAYw38vcvqd5UuKpBMWlpcgvSdQ6k69FTCml
	hoUMRD6Xzl26U+tdFJ2yZrbBGjgQgcJsC76jQm8DjzURPz36S0ODA7JM9iX+Kn1PyF+V/aBqNt3
	3cVUgs180cg9mN2trSRHhqxndCJcEthzRw6gRbXYCxbb35mj57S/1nree8RgHPh1GoEtrUt/SlN
	8MFeQg47O0nW+ZHASCWZjr9Nc1iZDWMbcUm/yFRulm2VVQBk08LkEbGLm3cys+oK04Y3G/BygiV
	k7sNGki3F66zQeCJXbGcHZVD0Z/f5wE9VNyGrpwiH7pd42HblLweGhu6QlNOpkRk8OTtnydDt3S
	X/4kig5aS
X-Received: by 2002:a05:600c:5246:b0:4a2:14af:1ead with SMTP id 5b1f17b1804b1-4a9676d1514mr113081845e9.25.1793268408743;
        Thu, 29 Oct 2026 03:06:48 -0700 (PDT)
Received: from [127.0.1.1] (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7fdb7691sm53082825e9.11.2026.10.29.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:06:48 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Date: Thu, 29 Oct 2026 11:06:23 +0100
Subject: [PATCH 1/4] Input: rk805-pwrkey - enable the wakeup interrupt
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
Message-Id: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-1-cb12621c1fb4@cherry.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793268406; l=3230;
 i=jakob.unterwurzacher@cherry.de; s=20261029; h=from:subject:message-id;
 bh=3qBapWKlE9gnNc1OkRIJoQ7rj2z5kJO1plv4vMvRaIE=;
 b=Gax9ATA7YcEykEZRoU8HuTbsJxxf2tMvfTF8fzq4d1vXJVAPuOzgirPI7o+V26V3EhSkl5nP5
 acS+c8VRtbJBrDNorA6RDsnaahLsnJ730MdZY7glDerfZxdequzJfBG
X-Developer-Key: i=jakob.unterwurzacher@cherry.de; a=ed25519;
 pk=0v1L7pjG4d7PcaYPMOmzP4SjaRtnB+8bMzZLZCRzB8I=

From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

The driver marks the device as wakeup capable, but never enables the
power key interrupt as a wakeup interrupt. As a consequence, the PMIC
interrupt line is masked during system suspend and the power key cannot
wake up the system, e.g. from suspend-to-ram on RK3588 with an RK806.

Enable the interrupt as wakeup interrupt in the suspend callback if the
device may wake up the system, and disable it again on resume.

This is done in the regular suspend phase on purpose, rather than with
dev_pm_set_wake_irq(), which arms the wakeup in the noirq phase: there,
enabling it updates the PMIC's interrupt registers through regmap-irq,
which fails when the PMIC is connected via SPI:

  spi_master spi2: Failed to power device: -13
  rk8xx-spi spi2.0: Failed to sync masks in 7a

Fixes: 5a35b85c2d92 ("Input: add power key driver for Rockchip RK805 PMIC")
---
 drivers/input/misc/rk805-pwrkey.c | 42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/rk805-pwrkey.c b/drivers/input/misc/rk805-pwrkey.c
index 76873aa005b41..9b64ec7463c62 100644
--- a/drivers/input/misc/rk805-pwrkey.c
+++ b/drivers/input/misc/rk805-pwrkey.c
@@ -15,6 +15,10 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+struct rk805_pwrkey {
+	int irq;
+};
+
 static irqreturn_t pwrkey_fall_irq(int irq, void *_pwr)
 {
 	struct input_dev *pwr = _pwr;
@@ -37,10 +41,15 @@ static irqreturn_t pwrkey_rise_irq(int irq, void *_pwr)
 
 static int rk805_pwrkey_probe(struct platform_device *pdev)
 {
+	struct rk805_pwrkey *priv;
 	struct input_dev *pwr;
 	int fall_irq, rise_irq;
 	int err;
 
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
 	pwr = devm_input_allocate_device(&pdev->dev);
 	if (!pwr) {
 		dev_err(&pdev->dev, "Can't allocate power button\n");
@@ -84,16 +93,47 @@ static int rk805_pwrkey_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, pwr);
+	priv->irq = fall_irq;
+	platform_set_drvdata(pdev, priv);
 	device_init_wakeup(&pdev->dev, true);
 
 	return 0;
 }
 
+/*
+ * Arm the wakeup in the regular suspend phase rather than with
+ * dev_pm_set_wake_irq(), which does it in the noirq phase: enabling the
+ * wakeup updates the PMIC's interrupt registers, which is no longer
+ * possible once the bus to the PMIC (e.g. SPI on RK806) is suspended.
+ */
+static int rk805_pwrkey_suspend(struct device *dev)
+{
+	struct rk805_pwrkey *priv = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(priv->irq);
+
+	return 0;
+}
+
+static int rk805_pwrkey_resume(struct device *dev)
+{
+	struct rk805_pwrkey *priv = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(priv->irq);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rk805_pwrkey_pm_ops, rk805_pwrkey_suspend,
+				rk805_pwrkey_resume);
+
 static struct platform_driver rk805_pwrkey_driver = {
 	.probe	= rk805_pwrkey_probe,
 	.driver	= {
 		.name = "rk805-pwrkey",
+		.pm = pm_sleep_ptr(&rk805_pwrkey_pm_ops),
 	},
 };
 module_platform_driver(rk805_pwrkey_driver);

-- 
2.47.3

