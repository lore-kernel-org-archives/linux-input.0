Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499254;
	b=oWh5geWwQ3963sGeyvaGx/folscmy1qlS+aWVppM5lrwyXyQE8XLVKqj2OdYn8vdH4vc
	 e1SADeh/4Ir8tnfy8Ue0RGuc1uLlPnpffJ1ylgjYEivtGOzOmOGgMQoNQmfUJJZVvCpNY
	 0g9Wh2bWukOK5uIbW9MZ/zYSyG+qJRKFt5f0K1C0Om0rJOGHiCqjkUWt3svg8F1FJrCeL
	 Qrw1ReCuv1AvIHsvm7FCUX1T3Au6h1EGY+yS/4x/stN33nwYxVG6yd+x4jualN2f6puPe
	 dK1O6FLMrci+PVw/qFEbAhj2p0JLmuf5TXO2gsF5VPJ70h5EpeLbLvA00Hw8hk+MDQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=datZWh14WO+4vzm/A7OIElTb2FmU2wSjN+th3EqRvGM=;
	b=kTnMbAKj1piuvi2AsDJwu6oKK7WjEDh/QNWkzG3lYK2t0KqRETCC7ZAcoDig7AoPeR8S
	 5tnatUEcQthP18uMcGFKsyFjbu5Rm9slgWExyefqarDIWR4lpvqejjkhktlrytJU2UNQO
	 ZloEIDT/QjZHBAIKHBhWjJOZUmTfjPIWMEYMw8gch98w1/ti1OlYm8bw+WxvB8gdNRRav
	 0Vp/z/NvDcQGzCfYf40vFrzXECnhtK7QaE4JJ2YiSKpS9rRSjYohWb7UhdASUsl3ICjrn
	 8nsSLUEgxJdXN8ONZY0+gGjK71thi0p15hfj3Qg05MeTvTBKhf4dVdtFPr7EZRmj8Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D8LIp5jX;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E6606A329
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 12:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160E6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D8LIp5jX
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1ddc7c9beso15127385e9.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792499251; x=1793104051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=datZWh14WO+4vzm/A7OIElTb2FmU2wSjN+th3EqRvGM=;
        b=D8LIp5jXKn3Kxmp2zc+NNJP9naLAUQRgmWigq4I8Tm9iK6aeAFrsk79CI1kL8BWI+x
         bLytbuKF3L5rfZaKaQ06oLGsc6uRjTvjYsnA+dTMkH3840qasLMxwSWRRDYhNqUvV3+E
         G/TSO8zrSG4PUsvr+7o2LLdK5SLaIWKXISzP0Gu7HZC+gHm8SIj2fSHnyQFgZ/mTavx1
         ELGoKOMp3VTFpwrlNlAdQgiS9W82FzS+JulnHgMP5Xz8itZn66iZp62nzbls/iustRqV
         gZBNu7s+jkRYjxDvYt5HeIksHgCqpMs14gvYt1H3hEQXPbIEW0yAs+8ZWV4iTm7RSjUM
         NX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499251; x=1793104051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=datZWh14WO+4vzm/A7OIElTb2FmU2wSjN+th3EqRvGM=;
        b=ZN7k7Iza/0HfZrSS24Yw4L02dxGeD5Pb8L7OCWY3h7ApJunMt8DNNcOkJWoaIW4jSf
         bRMj5PjicRavf5DrVFwDNSUEPHuPVhOKBgMJYEgLGIlmhQWe8HHlw46Jk3N2iUBrw3kt
         +YymATfzoJYzgI5yXCn36Zy9xxhUDfJY8NJw+sEXCUqcMEGVMs9S4TRkyOCQwbiyOPk5
         DT/3bjsnqNc1MW9EnvrTPYTlA2CkE25aWPBXGCU01zZJySNmWq+G0j0cc58SdbRaFY62
         ZnNR/QVIeGoiAEnVGprqc82LuioTFNjz7e28/fOGsFr2Q/a0wxKNJnzyKhlqGvvjS5X2
         6ruw==
X-Gm-Message-State: AFq9FYIBita3Iuh+rcT1QA63l9F+Sjgfn6Ry+Yyrs2lhIM36rgh3Bm+2
	Or9TxMjCLDfkH1D4KXicUT42z3+viS7LJA5v8MldCELopQSHkj0ebO0fuIo4+A==
X-Gm-Gg: AYBFou0OILYWOuW073Imp5jCydOES2JbPSOLZewrbiPoUV2shgAY1/Ue4W26aXw+7uF
	SszaIRkMKigPMEuANeX60nEta2aHQDQK6pMQVpYodwGUwY1mep9AUdUFt3Gn/RVAzEbwVcbEcYv
	CoCERpWci3QQ8GYHL8uV22kVdhMU5auKzBl4Zop4BOU8Fz0tY4/MHBogo6aXbV+dl3QlmNj23Z4
	PZpIQzLDIOCXhUp7NzChWrDkjw2jF1jwNBy6qPgP6fByrLcGuVKhOgpECzhxzLk2403Tt3dkeho
	6iJqsar8Xm5aTkaXNpt3MeH164xeQF1PZQ8q4pozVxSx2XnacpOUcOokAAvnqcDAWMzBShOMxur
	H0KfujS92BkI3fI4MeFUcKhsyIITwW/l/sbzvbaRVnjZIjfPUKm989oHjATgEzErALl4BJmlxDc
	1/dLELGG6pDZjVXAjFVaFTNnI3dU/Xyeq6+i6UsVB6ENQIY9cM6hetVUQMJvdgd2eAXQ==
X-Received: by 2002:a05:600c:1d0a:b0:4a1:f377:5c6e with SMTP id 5b1f17b1804b1-4a1f4172b01mr47842795e9.7.1792499251128;
        Tue, 20 Oct 2026 05:27:31 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d817f8dsm5617092f8f.23.2026.10.20.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:27:30 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-input@vger.kernel.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Input: goodix - sync the irq controller while starting firmware
Date: Tue, 20 Oct 2026 14:26:48 +0200
Message-ID: <20261020122712.526797-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
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

On the Lenovo Tab E7 TB-7104F which has a Goodix GT-912F touch screen,
the touch screen fails to come online after loading firmware, producing
the error "Error reading 1 bytes from 0x8041: -6".

Comparing the upstream code with the Android stock sources a call to
goodix_int_sync is required between the upload of the firmware and the
watchdog restart. With this change the touchscreen is correctly detected
and working.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
Relevant bit of the stock source driver at [1].

Credits for noticing the issue and finding its cause go to matemiller992
on the postmarketOS forums, I cannot provide tags as he wants to stay
anonymous.

[1] https://github.com/lscorcia/linux-lenovo-tb7104f/blob/2dad69c9f28611ac6d3db2f1ee11b480a60d83ee/kernel-4.4/drivers/input/touchscreen/mediatek/gt912_p98996/gt9xx_driver.c#L1529

 drivers/input/touchscreen/goodix_fwupload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/touchscreen/goodix_fwupload.c b/drivers/input/touchscreen/goodix_fwupload.c
index 5ae9a109ba0d..01e7705ef515 100644
--- a/drivers/input/touchscreen/goodix_fwupload.c
+++ b/drivers/input/touchscreen/goodix_fwupload.c
@@ -155,6 +155,7 @@ static int goodix_enter_upload_mode(struct i2c_client *client)
 
 static int goodix_start_firmware(struct i2c_client *client)
 {
+	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 	int error;
 	u8 val;
 
@@ -168,6 +169,10 @@ static int goodix_start_firmware(struct i2c_client *client)
 	if (error)
 		return error;
 
+	error = goodix_int_sync(ts);
+	if (error)
+		return error;
+
 	error = goodix_i2c_read(client, GOODIX_REG_SW_WDT, &val, 1);
 	if (error)
 		return error;
-- 
2.43.0

