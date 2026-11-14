Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614550;
	b=QN5q1aiSFSFECmHp3nUzT/jg2OyoiCLkcgT8BWnfUb3TfHhBQGPrkr655TyxH5/NagUM
	 MsvQZRTr04jn0aeK11kcnnC9TGn0+ZcAII0dS9o2cFm3kp/LcdtRhvNmQarSapGHV6XSE
	 Fk19kBLQb5ChKtu2tGsPJuCYvxxr+6SXrztrsfsIE7rYmDwbKQZMAYqD5KQdk6FsAkg4G
	 auSzkKqOPrlTqVuWitu5NMLwHMB5jKWoonLb/KxKTtrjvmQGbNPiZEhZ2so4bbbmv2HlS
	 X5+QWfm/GMYb4RxcphAYLb8PcaCnZwDEi/eklHJQ+u7qhcIfvSpxqA+wpVY2dpd3V8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8lrVpRwH1SeTUg4RP8YGcWrdy+NFCUl+Hj58HDsxC1g=;
	b=eKC8O6UnOYuI6KisqaQCPsl65Gga0Of/rsIhStckkuweRX3XVSaTUvAIAOA+KTaY7nJJ
	 7XhwtWdBUykbPgKe1tuUq8yVXSKWBLHxRCUN3YvYq5cWaD7iG0lyOqGOvKgPw6/grEvbj
	 lUcy40mwUFzftHXc7vv4Oc6FLGmyXdTjx25Il4pA83dpgXw/L/x8KOynpTD7+fv33sSXr
	 AsQC3kS+6yYJX4BlSA6DF9r4TrhgOk1ZMXV+YLBMxWrF/XHkFb1JXMzJSbNcfj/kvbPrm
	 PBdN0wIDiuaxZzEjDSNaVyuH6wqUI45rNXbcaYO6Q1oU6rURvwpzb8lKULDBe1Ia4Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IsCEFiPa;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E7606A896
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 00:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9E7606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IsCEFiPa
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-37071c0f42aso2302326eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 16:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614549; x=1795219349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lrVpRwH1SeTUg4RP8YGcWrdy+NFCUl+Hj58HDsxC1g=;
        b=IsCEFiParBLx0Mp5+uTGHZif0x9sISDjqiW20rSEn/+dj0tWesVoWF9A7YhZMB7rAz
         Z/tfEzU7GuLMW6WiKN284owZONH4T9RpCxlGDBvA6BvGY7No2W2gGLaKHqMbqsbJ8Dyh
         RwJKE3LwC8zxs+n/KYLORnoKl7uMc5EdHzeOKtdgX8XZOh2+TVMcbWsdL0h/vWvuTITj
         ZQinhgqmxoZ0Ig+HH2EucvilFBrehVRpEcT6Fg0fx8KK4X4E/li29R7tdaV5vWWCagUf
         F9oQ/GR9dmGsZGu3JyNsXVI0vyyVnm0+OkIen3lHnLWf8RIZa/d23S1SOw/fbgPdinOn
         Nbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614549; x=1795219349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lrVpRwH1SeTUg4RP8YGcWrdy+NFCUl+Hj58HDsxC1g=;
        b=cFgoXjlt6DiQomcj0b+yC2kRQK13qvOpAuTkmRyrkR72FiwiV/LK3rHWhKK3V2yIiz
         ivWisKbcMEjdR48HfcQ743MztGqQjSZce0XEa2vngYF+QafOLNshwG38VJ1noz6F3kl/
         tdbNhsdp0eJNoaIrAcKKcr7EPd+9Ak1PvbSIneUl1hReV08ETGNE1NdzH6OBgWmxbcQO
         f+Ey/FH2kbY5FbH9OSyJu+/3kSOEgXNGNI7fVcuKLg+g577FRmqbLp7udfB7vqJJC3B1
         ICZM8G+v5HWv/SEaTxHu4gVi09cZJBTfM3nSd/q6W2XzMxTHfTFBbrDurksP9q1paIWi
         HFcw==
X-Forwarded-Encrypted: i=1; AL+hErFf1i+s2wgMqt9vCQU7MjFkkNNDaAtLmxaiw56SHUjo6nqCF1oYAEQZE473SRXXcVtpqZu1RSunvvE9mg==@vger.kernel.org
X-Gm-Message-State: APuU4Z//yav4/QCSexlfo1o/1rWZMbvez0dwhQFSB/7Ty3/EjfDW25ma
	dGXuYq/+awLmnZCRCAy9rcNT5aG0uYx842tSgbRWIJyWz0wFcgIGSJrz
X-Gm-Gg: AYBFou0iAZIBJDquBNTerEPaQYmNFVTkPtmHWm22/Q4Cmn6Yj/5A7Po+h1tEYij10p4
	3zwPe/yQ4j1oEHBdhAVeuLSA5dgq4A6pGFGIq+tdfGy4lawq/iGF919lyujPualUlGJSO1NmlXs
	jyStTlM0NAUINie6wRQxfcTcX/t/pTRT+d+XG+Pnt/SwvaFxEQ9ijTHNVasqATGbvh7ShVnm7+O
	twDKfIkOMr4yZ0B98AwJ58n/j9RpmlevUWydAdDMi2nCEvDa/vpHVZCblTvemWyU45czwStWajk
	Dh6fjo9FadLsnrDHDk+JSwJ86o6Skk3pQkn9kHW9BUpT6KYuA/+5tq5o6qHjKf7Evc58o2qv5OR
	JRkGgaPqjTWjVSw1PTpdwpPsjk+ZSBvb2VyZPFzScEzfv492FZtaQgrr0WnDzWkZgSq8UH+KjNB
	/BeZLzI8vUUsOmeP6xQ53J5Av0EXqgMwPFeDj5gsqEtq6AX3XYfStnO0J2sTKYQ4Dt91R93CGL8
	HYtOrmRTjKg/Jr184h26Ypuppz4E2NJ/4xBwGTFmA2iz1cXte4CRE9/6LOAgl1C6MyAiwaMwHtc
	K1s6hrYMITrZYF6LVEi5EcLwYtCDDOqafej07uEdwcVMeGiJqSO7ThgX1dpZDezrUgUgFxgKUIJ
	X+MrugT5DD51DLgxb
X-Received: by 2002:a05:7301:2a9c:b0:372:79a0:e8a3 with SMTP id 5a478bee46e88-37963374fdemr3639036eec.1.1794614548709;
        Fri, 13 Nov 2026 16:02:28 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm11309849eec.23.2026.11.13.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:02:27 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: tsc2007 - drop redundant error message on IRQ request failure
Date: Fri, 13 Nov 2026 16:02:20 -0800
Message-ID: <20261114000220.1280581-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261114000220.1280581-1-dmitry.torokhov@gmail.com>
References: <20261114000220.1280581-1-dmitry.torokhov@gmail.com>
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

devm_request_threaded_irq() already logs an error message when
requesting the interrupt fails, so the additional dev_err() call in
tsc2007_input_configure() is redundant. Remove it.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index d55034914808..3597f71f6c33 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -276,10 +276,8 @@ static int tsc2007_input_configure(struct tsc2007 *ts)
 					NULL, tsc2007_soft_irq,
 					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					dev->driver->name, ts);
-	if (err) {
-		dev_err(dev, "Failed to request irq %d: %d\n", ts->irq, err);
+	if (err)
 		return err;
-	}
 
 	err = input_register_device(input_dev);
 	if (err) {
-- 
2.56.0.679.gc527c65306-goog

