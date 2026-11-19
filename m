Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095664;
	b=LFewT/lUqc8kA5IVFreklbq3qogPxNmF4Dz0m33d+FqHWzbwJAvS47mss9ka49hvDKHE
	 cpzhiuHiDPG1bAbb3WeQ7UBYs2G2qs0w9WW1BzxxfCt8nuT09oD2MJOWJ7EtbauoKUSRA
	 txueqV+soFG/QS+HCxRtgFoBwLYaqYOQt5kRhbYzJrcc64PO1kRS3xzNwIzfeCXJTg0Z5
	 VhXkugassU6qQ0US4yn9A33D9TapDgH+jjt2VbptNLp8COQT2VSkz6ZnvJ8Sgi72f7FSQ
	 byPDtL1DxwViErSgTNClQz3AyXsD5kgyFlKi3ZsHUK/F9xhb74UtQvoPPkP92Qfo9aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mhjd7qCe3jh9JBU7wRsKPF670mA/VW55TzY1RTvEnYI=;
	b=5qWFWEdcEGroeUNrl++tXsv2zCqgncCDeN50juDGfgoABx2GkBxHy2l0txN8hIFWaik0
	 TpExERg5wEHKvuQiwwT4sPw5D2exiwXnKmm0f+jmsenfmPcjp4ALEXjcckVuUCV/gHVWN
	 BtfZqF/4DIAuQEh6m8586lxSzg6K/Mj81ROjTuUQZESc60IA6PAWuhQXOHNMiA6CUL8TI
	 poeWtCDxJ1wCFz0MoAyaK9JayI3y75lNdrP2NGxowZAfS0vkuGhQN7yv5pp8CfMWeRBg3
	 SVA0qlUhGUpo70/k5nAQabtMeEhEs39kJkjdYjcYLnikV31MNLIMA9S0XuOVqitcP2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="e/U05xbt";
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154B606A335
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E154B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e/U05xbt
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99ac154431bso442568241.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 05:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095663; x=1795700463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhjd7qCe3jh9JBU7wRsKPF670mA/VW55TzY1RTvEnYI=;
        b=e/U05xbtSd5otnBRhSiLYb+iTFeJTRE5BGOH6JDpCrPI1tCFJwmhSxgCrWtid+bsCt
         SoVcOibC0+QUBOfu4+XtDZ2Dj7UMPUmNjiv+zlAsddzHWkM1+U+qv79x896tQdrqO2Xz
         AfW6HKqDmotgN1VrKLRA1u3udVKhLw+fMsrri8JnN/AnmfGhtmcH97/ED6DGjsEyHWUn
         rGEo71AaZyzQ4bBbusDudUZ1VpTsl22I7vE9QVxWRd6uGfHbVcjRyZ6Nixc/OO0xCA3d
         /0tjfc8h2I9/xz0a104M7JuH9h2jQFE0+psja0IrLv5w6o45VywGiOukFkvDn9XBovKG
         DjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095663; x=1795700463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhjd7qCe3jh9JBU7wRsKPF670mA/VW55TzY1RTvEnYI=;
        b=KovaiLCOm4wFK+5nqJkb/xxvEmipbGcmbw2xIZ1HleEABHEghABwCZ4b0p9bp6T+zv
         5Nc5dLJViJegbuMmfE7Iq0qggKsj0CXufFbTLm8940Fc3l9A3DSnnMw0mR6MhDVuB4ja
         9MGXdMjvN6jDiApifjKI+FlNLBviWGk/P5gjAvr7VeDNwBOLzDh4623UFjEMdhL25bwZ
         LzSuHdT+H4NbvreSd/4wLl6uvI5XXQmxwWnLFuEJnoLGVL6URkx65k7iBY/N9tRmdH+O
         jUAudJj4f9ALPz2E6nESaWhxxJKKTMYoq8TkSlonIfCCFcQGDkVzkLWay3dYg1GUXHo4
         /idg==
X-Forwarded-Encrypted: i=1; AL+hErHL6H+xSEB+rMiR0p+12N459CxgBl05T5yv4of5oavfOzrmz5UCahYG7KwTf7WpIK7ESnSdW+o9F0JGgg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8OYVQI5eviNUmuhrN0/kXiIaf0/L3cYFULnlSC57YTddkFFi1Y
	dqmWLny0yk3Hb/AkMC6G+4L+gHYTXkwsj3d+Sz6pS5D5AwAerqRvJweS
X-Gm-Gg: AYBFou2cmgVZaV27rjqpLFsbVHGy8ex7KLyeW4yDfH3y8d2CvZeyRgbfjMbs0nF+ed1
	peyfUJjCJvH1iMDZ5Zw3bWfiwez5iNBXqdbqZdqjRATbQ9t4SBtm5zejE1F5joB1fWZllTtkK2Q
	ZThwhrnxYq7jLPpg70WGBJLF4UnazT0H3GxtryBs5ZiIEgJ9meVKT1SeqJ32L4fPKJA3OWDVrEv
	wNlRoL9oVjVFl4GhwCuPbJORjmJRBa5JCU8SrZSKmLDtmAUF2YNn94U6MScO+CXn3DO0IZpG40j
	j2vnlaZpVjPw33zq51gBaEGwuZkFV/c54xobqCBqoAYV/6CnQ88llekvuuzfwAy22IUl7mrtH3I
	uW0aR7+I226h5NfAbom07TDbhtBk2QYX3R1jvExo+LoO/45lBXRPxCzrk4Oezhhh7c/JmI4QzV0
	SeD4sTYtZOmYB7+pVdvhLNt04nPBz8G185LsVfp47nJECrwRHMEt11OVP2evbpQYW8P64kEftZo
	P16OyU8U37D6SfHtxHAEvywD/KZjKtJ77TL/GgPCQkD2C17eSp39pVke5w+kz7Pq0ulns5q6f8C
	toNg11GwFxUgqwD932VszxwWmUYIfxS/4cg0O8gjWIhmFaKfYz0xI7nbPMe3oWLdkLzfym/d3ZL
	UsVk8wQgzHznLhi+J/qk=
X-Received: by 2002:a05:6102:54a8:b0:7d0:6db8:dc3d with SMTP id ada2fe7eead31-7d6ba191168mr2215348137.5.1795095662707;
        Thu, 19 Nov 2026 05:41:02 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:f40:91:660f:4d51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a240ac5sm4134862241.7.2026.11.19.05.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:41:02 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	crofts@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/4] iio: adc: mxs-lradc: Fix trigger use-after-free on removal
Date: Thu, 19 Nov 2026 10:40:39 -0300
Message-ID: <20261119134041.16611-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119134041.16611-1-festevam@gmail.com>
References: <20261119134041.16611-1-festevam@gmail.com>
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

The LRADC trigger is devm-allocated against the IIO device, but it is
manually unregistered after iio_device_unregister(). The latter deletes
the IIO device and releases its managed resources, freeing the trigger
before mxs_lradc_adc_trigger_remove() accesses it.

Since commit 699fb50d9903 ("drivers: base: Free devm resources when
unregistering a device"), device_del() releases managed resources.
Consequently, iio_device_unregister() drops the trigger's allocation
reference before the driver unregisters it.

On an i.MX28 EVK with KASAN enabled, unbinding the LRADC parent with:

  echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind

reports a slab-use-after-free in device_release_driver_internal().

Allocate the managed trigger against the platform device instead. This
matches the trigger device's parent and keeps the allocation alive until
the platform driver's remove callback has unregistered the trigger.

Cc: stable@vger.kernel.org
Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Joshua Crofts <crofts@kernel.org>
---
Changes since v4:
- None. Only collected Joshua's tag.

 drivers/iio/adc/mxs-lradc-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index dda5182a5076..64dd3a9995ff 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -454,7 +454,7 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
 	struct iio_trigger *trig;
 	struct mxs_lradc_adc *adc = iio_priv(iio);
 
-	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
+	trig = devm_iio_trigger_alloc(adc->dev, "%s-dev%i", iio->name,
 				      iio_device_id(iio));
 	if (!trig)
 		return -ENOMEM;
-- 
2.43.0

