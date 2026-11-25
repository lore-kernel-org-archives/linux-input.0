Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591296;
	b=KaAioz6hSR+EXckjcYFRvQQ6cDd6yi/jCBCuMUTqhhU6YUN5fg3rGVx8FPJ2SVTEWzJF
	 acHggTzO3kPTLG7IToHhHeIPBZX4qoXvp1J5m2qeN1M+S/kJpEt6iJMJMekJPbgl6UM10
	 O8FmHADh/PuoNfwg0fYan9y5BoXk/pgzaS71fKpLKHA8ScJMvbTS7vO1/ObkqBR2fnrHZ
	 6UEKuLA1KciOTMRT/B+23ttVU7Rud/uMdTNjiUJjlVZj3bb8ic2fCiz6CcFUngY9J5u15
	 bK56F6+RZ6e89+uWpPyTzPUXunosP45eDRJtph2hQ+NuIRQoEgfscKf7/i7uS05YH4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mdnrXivS6pphO0ni+EiUpdP5k6p87bnP8SNlAtan2c0=;
	b=orM1LycKHBrFwjA8jGh7hjzMAFkxJxozf+RNU/RSuzAUQIFeJIlgiKv/5YN01c3MtsQg
	 6TPwpoZ3Zdxou4PtNQEx2q8kd+oij+PLMS6jd2Ie9PY5uERiobYu53a7kQCFkZW7YWN4c
	 G3ES2bhF6oh5LzSlZdvgpfvsz97NFgBq68FaDsG422s7ZbQYiOTA6mhLpX0X+zsK0u3+Z
	 MNEFiodg5dpm+KHb2nB1OjJZKfZZwuOepU1QewP2MGNV3M48HrdAEQQog2pjsssp2fRc+
	 dbtLSbN7eT7Ex+RdXI2c6baEzKAYutYbSKUocASLI+118PerRClme1ExkItiM590vog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+EsmyQk;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED2606A329
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CED2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+EsmyQk
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so9102650c88.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591294; x=1796196094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdnrXivS6pphO0ni+EiUpdP5k6p87bnP8SNlAtan2c0=;
        b=z+EsmyQkh2UInr8X+DgMVPLtYtbI6YPF3AN0RGUQKfn7J1y9Qls3DLhYrGX9hcxI8m
         F+wjmOY5uMJK4QmEo/TbbKu/eGpBK88pKowPoUYUGSQs6o16w1kUOywyrf5XR1Z0fBkG
         52DU1KukCNtjrbBee0UfSgf84u1DsWubM+RcHhZtF2kDABnlbfNpI7VGnf5O89HNn8ny
         +8gfF9eFHydZV4ubq0b6fgH04NT/P1tr9kRTRPrNR3g/AtzjugIJohzHBGP57kzhdjUa
         NZoC5lwJ+4B7CAqLfF5Vgd3wynVcmhEmCdQ4HEvWldp/Lqkue0EiIhg7b+Y00I2cfr2N
         gS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591294; x=1796196094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdnrXivS6pphO0ni+EiUpdP5k6p87bnP8SNlAtan2c0=;
        b=SQcwo5lymO4YnU/3J/wEsrVKSW2Hw+W+i0MHYEwJpJfJrqVA6nj1rqsMOeB6if7yyp
         f4HliJ20vsXiX1JP01pFw/jb1QI4KEpXfPetmqGPRxzTheL65txdAp3Nx0k56d0PqkSc
         YJVVwBg80SgXKrKDolVr8/5srhnsfEtGyCse5r78JQWzVgVajUiiC2zU2phVdR6dk1vi
         Y4Fq9o0jewrH4/6w5vtjWjZdLtqXxn5Ioqi4tQQBIshootvkXFvgoH++mDiVn/zrLkBB
         omhtNDdPvb1Vu2B1DUL2El05v4gRDNuBlcj0IzSpQLg+iAXzva3dcwpDVPqTmUy+Fot1
         mwLg==
X-Forwarded-Encrypted: i=1; AL+hErFXHT0vtd3PYwzmHmcrNxmDgdbQXNzkcuqcBH0IhQbxOMDbhF0sMcNoKcR7vcBlYe+Jx6r08z+PmHgEWQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dUV/hktNJo9WQSV2Sz6lS4WxTMsL8curR7UYgwB0FMpsuHOfi
	/TfvcG/0aZLOkzBFX51tM7knw/9bz9630wNfqbcnM7u1hJXKM5u0hHdP
X-Gm-Gg: AZFdTZdkqyPk0a9OTBWUGnE0oxMMnacNhp1QEoaryej61ksKiNt3CGHPFbw2ZjbtggX
	pvDi6ByDOhx626zOUifid3rqWjqLAtyy1FJeW3XglZmwa3HD0bi1oSlTbIZ6r/ti3Ry3dPRkUaf
	kHSvCxFMSLw89ydlfIpVoyfGy/kL7C6Cp7i54xSg3JRprI6gXdmlZoQ2xYLpjFc686SZ3Sgkz+9
	KB5jGrTnzeYtEe+m41RCZO+GzH6Pn0vk38IVUvpXRUyn0KD/BHijPGFm6u2D0cHJhsr7+CpokLQ
	L/3oBMZG2WrF+u5axaNnnv9H4Rk1MGYBf+ORJ962PNlrT+tE4eA78t5VJz+WwBX2Glox24XAxuL
	0QboBOzHmUoMWiIFADqNUlEa51XHSPsJwyW4KChAbs8/Ksl9RQ9OoC8nWi3nIhQjkw1nMTA0k48
	8NgEmQaofqs+5/FssR/soYPU+jxOdyiZJ3KkF0+B7wrDXpvt0wcKczTywoIjO1nbeI2qBrOs6mf
	vQPgxNlq054SI8S4tFxAVTquBc8ovXxApyJyoWCUvJy/HpLqYEHjFM55cfEHqi1fItVBZivA1vC
	KT2p4Rky47euSgMDTH6QlDyIsY2zIyYq8mJwXi2azsAn4EbRyIqihMGCQvg6DoYv
X-Received: by 2002:a05:7301:6184:20b0:386:b006:c8 with SMTP id 5a478bee46e88-386b0060806mr8919262eec.35.1795591294367;
        Tue, 24 Nov 2026 23:21:34 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm62232352eec.11.2026.11.24.23.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:21:34 -0800 (PST)
From: Prasanth R <ragaprasanth@gmail.com>
X-Google-Original-From: Prasanth R <prasanth.r@lineo.co.jp>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Prasanth R <ragaprasanth@gmail.com>,
	Prasanth R <prasanth.r@lineo.co.jp>
Subject: [PATCH 1/3] Input: snvs_pwrkey - clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:21:22 +0900
Message-Id: <20261125072124.2997511-2-prasanth.r@lineo.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125072124.2997511-1-prasanth.r@lineo.co.jp>
References: <20261125072124.2997511-1-prasanth.r@lineo.co.jp>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Prasanth R <ragaprasanth@gmail.com>

The driver has no remove callback, so the wake IRQ set with
dev_pm_set_wake_irq() and the wakeup source enabled with
device_init_wakeup() are never released on unbind.

When the driver is bound again, dev_pm_set_wake_irq() finds the old
wake IRQ, warns "wake irq already initialized" and returns -EEXIST, so
the driver prints "irq wake enable failed.".

Use the device-managed variants so both are released on unbind. Only
enable the wakeup source when "wakeup-source" is set, as before.

Tested on an i.MX6Q SABRE-SD board by unbinding and binding the driver
through sysfs.

I used an AI assistant (Claude) to find this and write the change.

Fixes: fb3c09ba20ff ("Input: snvs_pwrkey - use dev_pm_set_wake_irq() to simplify code")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/input/keyboard/snvs_pwrkey.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 33bc3bd0b..513fb9bbd 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -245,8 +245,13 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	if (error)
 		return dev_err_probe(dev, error, "failed to register input device\n");
 
-	device_init_wakeup(dev, pdata->wakeup);
-	error = dev_pm_set_wake_irq(dev, pdata->irq);
+	if (pdata->wakeup) {
+		error = devm_device_init_wakeup(dev);
+		if (error)
+			dev_err(dev, "failed to init wakeup: %d\n", error);
+	}
+
+	error = devm_pm_set_wake_irq(dev, pdata->irq);
 	if (error)
 		dev_err(dev, "irq wake enable failed.\n");
 
-- 
2.43.0

