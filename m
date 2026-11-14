Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636011;
	b=Y5BQyS8XghRUhjEYqHI/lA8SPbbx5ptRe4W2wwKFkxOTik6W2rkss3nrKjLTX7WGfomc
	 eP9c2qZG5soZz5JRWEAscVxcT6AZ8zpu0L3UZRWnM3xt/cS/eKDdsNV7RLExqcY2V4qbx
	 gTcA2aQZpmkPCV+JTMZ+40fLg/oSVH0ydzzxdxEOU9txt2wdZX5dREAgyjTAPOUkuxhhO
	 nKgdIb83Pi+JbfJ9qcDLzgybHwyKLp0teEzxIGiHdk87FGl7aPyD2neR76PppZZBTJyfO
	 D7ZDe54BYVv9rdYwr6Azx4NQ6k5kpRZpg7gDgkcJX5dX9Qi9rVo12rpngYB0WNEMikg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=E5f69N1afNwnZIbIaExQBEbVt7VaM+P2Su75ERCUnMk=;
	b=sLAHVE+nrvY6FaRMt/AB5tTjfAU8b39oX5JBJOBnhAE28QBjRicNVtMiKQkrM44MnL7F
	 NeD19ALmL2jXvZTu/bbxLNIAVUfLtdRk0Oa757QMUxP5R2tW8V4lsEnyYb+7ZRwuDEaLT
	 54jlPh2+vkrgY62VlyiHmTWCAfQMWlGcN4wE36hixukRZAHurK11T6YK1m60OSJtdnfOs
	 LOAD/1Rjf1jzZi0aw/QW4HLdUwgTZ09swHESuWa7lEiXh7xDf3g+TuviFmxcn88tFY8oh
	 7H+y7NnSje61KyPXh3Ujspq7tkXAATUp2k6ayObTVXQwWNA4W3oxS8gq7OndnNI7FzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ncv6SjoU;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D460A261E
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C1D460A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ncv6SjoU
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37628596783so2992694eec.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636010; x=1795240810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5f69N1afNwnZIbIaExQBEbVt7VaM+P2Su75ERCUnMk=;
        b=ncv6SjoUxDlbxsBnSYYXSk60WhpJ0DfxQ2wQE/BSwhPivcpr1UrEp7n/voQVMccGeU
         hW9fCkvcW4VoBqwLx1Q0fTScheRBw18CUY09XrD/DV0EMZb2jvKeRIKFUOBXNgeZQPPz
         7GCOIcX6Cl4JBhdWKhZACF47kfiJtK23u0j6oMaZuWS6IZVRhSEXVPIJSc+kmiF1tv+T
         rqtvOxlS+bTI6f99F5vPkcN+Gghf/ovnKY7q1a1eI5AoqcKMwREsW8DjR7c2rmaVU+8A
         9wT9bsUILLDgsPK1GIp9Gkvq11WL/yKcvvMYyMVdqOSGQArticrOYeM42E2s36PvnybY
         W+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636010; x=1795240810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5f69N1afNwnZIbIaExQBEbVt7VaM+P2Su75ERCUnMk=;
        b=ZSbhu1rYcX8zddNXe/9AEQ3ah8GetMaa3jv7GpuPdpF1PdfizoyKd6jijm504ZwxJ1
         9hUylaiHlfNCLh4IaXNA+xkZIU0OHvxVFfaFf/anBe2u3euMm5+qNCLcjn3wY+vgfN6R
         r6jXBDuh5DbxqJd17WNaT+tzS38ASkKV5kkqVpYixXZ71U7Y3S8REcp6TrtBJUxiwPVq
         soNf0a2OP4N05n9fvFNizVfJswqdfBCWsFid3mhmXjW2kpxdAIUtnx8Iy3ikzOjh3bUW
         uCrmwKWUzPv09KEOHaWVzObRwGiCL7yRmNZCGlOh48fU3baPAY1MIXj9GGELP+mgHQmt
         QsZg==
X-Gm-Message-State: APuU4Z+tDNAkFJFkBQKqpMZ/fvR/1ecvcxw0vW79t/u9DiiDEOwelB8n
	4upWSCb8hY1KJuG0LCg/G8GHmg6AtUnIlAkMDheCcY87XXzBf9qXiv9mQBZY8g==
X-Gm-Gg: AYBFou38QsfNuBMxLFmne/QgX8V2iMHK0n8k9CrHMHa9oRn9jB19hsKvzirpqOELHz3
	DOhxd9i3J5LLUFn8/axDA72N8EHlffMoylHfXDFzWarPf+jBIKm7G8j9O85ykDRZojn1chji8Zt
	CANpJspWgBFUV/bYbGDfTQFxo2bxsHXtqs07zS3jmTkwE3ObSsQjqCq0tqV01dxndk8kZyO6RXz
	fc91Oo/vHIfpTOc1xt2GZ2sKZSHhY/b0LCw58GIYKqAWO4lWVax/diMX+Q8HZxjJwa5DSn2dDlr
	q6yY1qLqOv3HTkP+NI2LmRQxMMzraUFcX9Z7ojqdqdVzC4kXHRZfyB2Xz/6gwV7eddo0iKv16tb
	UUvx51SLVWtpiL04ULZOSeG4e2bwR1+WqEIjGFgGdTm7jCWmF9xxSdNJwZBreT83dw6bKjqJkN4
	XaPcvkgrnyPoYPGUoRzfrQ77iq6g2ora1oCX/dkE8RKdfnHW8y13Z0ngi/0ELu2m5LuaQyjl8EK
	AVMcb2S65BrKpEIqIjYA0pFFES5tWC28xWLoB5spuBIuw6MbbVZh/A8ikq0xc2ipHzygwPOyiHI
	rmQr2o2fl7ZVrMZ3jw6WDQBQo/i6xQfe0FkyBjiNTjRUB+FFa6KkSFfT4vdhgTMJ6jYzkY/GB26
	N0AZZALfvk2zWDNMB
X-Received: by 2002:a05:7023:a4b:10b0:185:33ab:4d55 with SMTP id a92af1059eb24-1b503115c0fmr4167409c88.29.1794636010082;
        Fri, 13 Nov 2026 22:00:10 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:09 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 21:59:56 -0800
Subject: [PATCH 06/12] HID: rmi: avoid GFP_ATOMIC allocation with hard IRQs
 disabled
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
Message-Id: <20261113-hid-rmi-v1-6-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Storing incoming attention data allocates memory with GFP_ATOMIC while
hard interrupts are disabled, triggering sleeping lock warnings on
real-time configurations.

Stage attention data before disabling interrupts and use the safe
generic interrupt handler helper.

Fixes: 0b2c7a897378 ("HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d3e4ee0f62f0..a4406bc6af43 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -362,7 +362,6 @@ static int rmi_input_event(struct hid_device *hdev, u8 *data, int size)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
 	struct rmi_device *rmi_dev = hdata->xport.rmi_dev;
-	unsigned long flags;
 
 	if (!(test_bit(RMI_STARTED, &hdata->flags)))
 		return 0;
@@ -373,13 +372,9 @@ static int rmi_input_event(struct hid_device *hdev, u8 *data, int size)
 
 	pm_wakeup_event(hdev->dev.parent, 0);
 
-	local_irq_save(flags);
-
 	rmi_set_attn_data(rmi_dev, data[1], &data[2], size - 2);
 
-	generic_handle_irq(hdata->rmi_irq);
-
-	local_irq_restore(flags);
+	generic_handle_irq_safe(hdata->rmi_irq);
 
 	return 1;
 }

-- 
2.56.0.679.gc527c65306-goog

