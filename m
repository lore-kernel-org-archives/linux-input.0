Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591301;
	b=qaMLfKrTPue2RZUAhrMD9qsIJnUGL+KWIVt3L04kNcmE0g0SbT4JUuZ6cVbcQzeQpBEg
	 YR3cbWDviI8zXdp03bSJRQMalk0TFbe1uQafOGrk9mZVWwlxrwHP6BiqUNNwvHDYJOfU5
	 89tW1Vepos91Tk9Uoi8KMdfzzxMDQQobDx/Drrg9ssNR896SDpsroIKsBuPa9wdxRPc9Y
	 whk1JZaoTvpgS+jGvMMh3D0koTDiyIOYWLr2WdaOa5h79U+nGaXJTbK666jiogqcc3xgM
	 NhGe9zAwJO+KNGmoZ1M4mJD7wUWd4dVMgVIVYGUXHnAqEd5aUG7x4G+40weltkm6D5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BGofZF7WnGSF9gs6MjlInhn49MlqjmtmyUenZnGkdj4=;
	b=fqeYvTP2p9W4ildviGaMH2oo0SwKX0RqCyhy5dgiuydHmgWgwvk6RGuO6nu6F3BWNd0O
	 bKLOTu/QwOuMoAb8wMNpfMftzx3YTTd/f4hpR7ecDoUA6zdBQ0xAyGD4eBtyY5L34gCFI
	 gjOMu5u/QKGSAh8DKQyLtPtm/GF1sOGx/d5CsjtXZlHKidu/VGcguhBhGn78Bdke7jU9x
	 uuU9LJjUdPGmmaeqksTfFn0/RXnIymv20wDPm1/pwLX/BDD/iBfi1eOG2+KXb8TbnZilm
	 9U0V1JsavvNsjwJENXMQHwmz3wXDaf0fsGxBIK4dSfjnlqsztMD4hDIw0YcDU3Ey8JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OMu+zBxh;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D51B606A33B
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D51B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OMu+zBxh
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso2472570eec.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591299; x=1796196099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BGofZF7WnGSF9gs6MjlInhn49MlqjmtmyUenZnGkdj4=;
        b=OMu+zBxhNH1LJMMlaZFvbj78ECK+H/Hp6FiQ1SXAkKgusvg1oPgcSK/Ursuk1sIu7R
         NzpvQWwI9oi9NlZJ3LuiRIgfaTtymI1r8K0ZLmsg670JMeF4IWRkbBfxYjHweKL0CooX
         S1fR1+gbZKcKECc923hc9PMsvUPTF02CWFck1TABY7OrkwAzYG4wEB+MXUfI2AVdJB99
         6FVk81qDCA7LAjJnGg5OJVSeusPs5wOAreivNmqmFqPECNygzp172qHwKjYL2Rvo37pa
         ILxl9JE/qDaxNWxbxC+0gVwgFRq/5w4ILYyHrlD9NuSIrAMPgrK/WhDx7HKnXHJJoTqf
         l8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591299; x=1796196099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BGofZF7WnGSF9gs6MjlInhn49MlqjmtmyUenZnGkdj4=;
        b=txfs4Hu68talNGGK+AEKKTmp4L/TSK+euQKVM/TR1jntKLeD5UhnyEiRQYXo4nvhAW
         0VGLXq1NnbELGPuLoPURCXmdjs+nGTApLD3Jx8nQQihNi0t8Y+rZ6V+JJK+zf2kcT9xF
         uWwgkQwU2e4SRflI3MA218lwnyOFbQ3KoypeSJFuI9zXR3QYIfK/zUEa7TPZI2eLxZs4
         kmr5IIZzYGXIITC4sq4r2CyjUPoAMxyDcUgIbgjROZU2Oy6CflOQxQpFkMq9Kti1ckuC
         XGVs3iNdLrSJytFGXwwf4H3xTF3re5NgViWc9hAoh4JHPf5P17jZ++alTlY/iN1bysh1
         P5bA==
X-Forwarded-Encrypted: i=1; AL+hErHIDoT/+aFv2uP4i4tzg52zhGkIK7uDN6qudZGbnadcP+L0LZiOe6K3WANi9aDTSF56jirsBEerNO4Kvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/bexB/uKWROB8kHP30lXGkZvvEaiwFlDNHV1Grkll0N/MKVHmJ
	CC77L2SOqPR751GIEnLTgonfqUQO6SY1TM/CA/hkLHlhrC70O/kL7AkC
X-Gm-Gg: AZFdTZdcHuNOa50lTgiSqNn3jP228mnQX0MdR1u5wRoRk2sHltwdPGstxZKokd/7b20
	snYgUFZHklYTnfOxUXghukQQmn6J+nHZpsITU5Q7PL9IxL0NJkLlBajxA6GjB0fsmv1j8Wgy/UP
	CBRsqJE8e4OVevzlkCpaQ4L9CxNTDB6j47zbB4SQZsOTAPbCDtYONgfbG06j/RCzCX4LSYuWteA
	Zkm/yV11sefTMYtK2GciTOFQqyu7/BrQwEGMIIuQoJvf5Q4oHlfdXE8p7RkAfPBdT05ZeaaDkSV
	tRzQHqfq3NGY3s2fz9mthvaQQC8vtAKKVufp2IvdfpmxEnlsFe4oczbbgfqsRHZnvXAYX/CCe2x
	r3PN2/8ZdsAZsP2Kuj1b8exYJfd9X7hpBB/0GTPRE3IySfSLT3F+TIhXqAP6H7jEutRUJrvoWUJ
	f0sNY7u6m5FcmSyOPShZpNOEnWBMWoXrycbi7+TFqzLHLqCJwj6Bsoi8wEhd1cBSilROc/OjaVC
	N5HVapLRZANmhWmzzTliXQ/T1rV6r904ZKjF57O+oxstEf8CL/48wf4EVwoL08C2IoOUUu2930b
	M8i9cubDyvS+4wdApTL6Fn6izy1GqLoqTngB+n2k4Ald3Id1OrmXQthASGHCFuo6YFnS61fRN0z
	DfAyhdOKoPg==
X-Received: by 2002:a05:693c:69dc:b0:386:aff0:6109 with SMTP id 5a478bee46e88-386aff061f8mr9195868eec.2.1795591299376;
        Tue, 24 Nov 2026 23:21:39 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm62232352eec.11.2026.11.24.23.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:21:39 -0800 (PST)
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
Subject: [PATCH 3/3] Input: da9063 - clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:21:24 +0900
Message-Id: <20261125072124.2997511-4-prasanth.r@lineo.co.jp>
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

When the driver is bound again, dev_pm_set_wake_irq() finds the old wake
IRQ, warns "wake irq already initialized" and returns -EEXIST, so the
driver warns that it failed to set the wake IRQ and does not enable
wakeup.

Use the device-managed variants so both are released on unbind.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: d7781232b5b2 ("Input: da9063 - add wakeup support")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/input/misc/da9063_onkey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 98297ca1d..304fd674d 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -229,13 +229,13 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, error,
 				     "Failed to allocate onkey IRQ\n");
 
-	error = dev_pm_set_wake_irq(&pdev->dev, irq);
+	error = devm_pm_set_wake_irq(&pdev->dev, irq);
 	if (error)
 		dev_warn(&pdev->dev,
 			 "Failed to set IRQ %d as a wake IRQ: %d\n",
 			 irq, error);
 	else
-		device_init_wakeup(&pdev->dev, true);
+		devm_device_init_wakeup(&pdev->dev);
 
 	error = input_register_device(onkey->input);
 	if (error)
-- 
2.43.0

