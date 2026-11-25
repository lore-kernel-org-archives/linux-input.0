Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591298;
	b=BBeGyvXFtUHaQiN8X/zG0jVCGAC/iC0SIKICHgfPcNFVoK9KmqNB+oxOk+aeuY5hUs8m
	 dAHIeQEC4V99gqvHkE6lpX1jMT3B6KuVz6oWeCoSeJkLwzinvUCn/aF+CtY1+7UPGwea/
	 ljFBYinPJaJzLq4kMhFHVwKUBFtZFMcYbf+Nt+UNX2MY2XKLHmidV9ZwOinL3Mc4yhqtM
	 7UQaNlDhgywOJX2MKwiSpP1UaskVEa+LQpZO66B+stoC6OKAkzNSdBDhfuZ84le24JQAx
	 X7pNvBNuUqbXmZFRaGEa6X765xPW0rEC2f/uvSWs9379UbrOQSKEC7L+QbLTloOUEEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uP6f2xqQXzq54FxHQMZJOGM6VDsROKZT+DhRoGkRjNw=;
	b=U24EuFAouXpBgk1Gut22bxxNGslf9cueCaTv09zFaxnckmp3ytJVGJvud8JUeB33076D
	 jS7ER52ln6++Unj0E/vDZ4srmJ1aTZ8ZfDYFL+U4l/XilkTqFwj6iEZ1C+XdterEsCKOP
	 RDnqHnplnsxyT7ABmY5UaMVzwzpQI/nEf/N3P4I7pFaXTTN1G22CitwNMlFBFVdV5Uz63
	 WVqPwmUxcc4nC1mfyOA8mYzJZ+D6c0jan3RltYghQCQPh8udW9M2yWXz8apxHuZBeJ5FY
	 Qt321EzqCVA1UYlV5yhXcgyAh3nyifdQP0GdlD+mFR9T1v5NSLj/N3iooBX5A2N7Lbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cy5jtFi0;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C4606A331
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 404C4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cy5jtFi0
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-386cf1041cdso885487eec.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591297; x=1796196097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uP6f2xqQXzq54FxHQMZJOGM6VDsROKZT+DhRoGkRjNw=;
        b=Cy5jtFi05mRJIRAc0bvTimLpSMFusZf7Exu6x0hYvGnOyZ04uSpGST57sZ3dwylPBa
         kyJZAe4/mNv7d4ei8cZB9e02pghhIAW5Dw+Jze60275/bCC+5r5JtU0uu9wYCQsm0WCD
         UOMV+Fc7seZbl35eMQ1n4WfilnYmBj0DhYUItxsgVREJ6qf973zHKPa9Wvy4TlWwD7G7
         WIgIQ0NzQsriC0cnYFM1yQQQ+nBCJ18hVS3xWsvSGqkikOpbsJDrT4T5J3yYsYGiCa4f
         SkIbH5Vq5x4EWCs5ENabm8sjCTjOSequf/kENZ5X17exaD3K8tGpVOiysxL+zpEVE68V
         PPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591297; x=1796196097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uP6f2xqQXzq54FxHQMZJOGM6VDsROKZT+DhRoGkRjNw=;
        b=Jdew/3zZLyrCzilYqn2dS669x2+nQxlQnN3BpzdQOliY3qtgc+BfQOiWF3Ep+P79Da
         JETUI/e3JDxHsMvs1jFYN3XMkZcyKdMsYeCGXgSXjtXMhPutstffTNX4sUzDtEFX7y3M
         7sghhxV8W2JTS1Y3BKYmQz44ZMb76AOFXWkw8W2bRKGxrbKztsI/0kJlMZaVUTW5Qg6j
         Xi8kBlEAbyM96ZZ/Q/zsO8DhKGodqocB4oeSz1cWBMRy8aZDzSbO8NPU8B4aPpHMiZi6
         Z7bqY2buvzVW/zcgkyA+uJT676JlSHd8fNpYV6ROiwW6LLF/Rx39dUZoNRpp2kzgl6E9
         vkxg==
X-Forwarded-Encrypted: i=1; AL+hErEyuGVSWl0Pb7o4851eT5bDToRkij3tmDY1j/EkByQVdjjz6Vzeys+8Q+R7WJVWlxBsBLZKiOcOlfaqiA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+GeWsrrAOrJEQ6T5i2eLe8c7ga1L/xBBaddft6KN5GFuaGBSuR
	jV+lcd/9mdRQG70y+2rMuw4ssN6bTZ+wGAk7bqgnpmDKN3ooxnGtZm5Z
X-Gm-Gg: AZFdTZcKvAj25LE/n3RPkSZumwb2b4uAWTGOWgkcA9UOxi7OrHMQ3yHiNX/3tz0dPJ/
	awQcrWl4OK6fleyEBuU3cXjwheo44Rqg3yscT/2tm6vzLuGT4xykuZGvdhGppllFRtSS/bxfJgM
	XqZIbXvC/cydpTUtMVXi2n5e3Cmg7xruC0sSNUWDdMfELCcvH0Jt3zodBV52pwU8LZWFeMsTzrK
	yzg09SD6ZyDu6ZQydlZPXtkfIrBzUPqAWXYsKJYKuCSdIxqCiSGcX+fK5FrBbiqqSnJcZR8hYVV
	BQ9FUWp6JPuVnR0JqPgoympe6NlbqRYmjxQ8a3KVDgQsnUdTeeiYFANYOvcH5Yod6OF/yP8tIbb
	uCaxqrEu3a3VfO97gX/UZn4YIsrRFQcQM/qkibCkc6D+rmn6q1NCz2Oee/N13/L6U/efAX8P4S8
	zkPA0oa0TG5WLpkNiygWa/zm3vpbPRmqDxWEgYSW0aff632t8XtsbD+nVwbUEeNlCxZjLuzYHBR
	9+po4Dn83pifNPKIygwZwWLVHBCNfeOIhnkMV7vy+HUfTet8sMHDHpFcATISso+EnlU9okRhMUd
	25WaGMPzQ4ylz2VGJM/kt8E4MfcPxGm6XK2G8ShFXONeGarXOFKbYcaZxrtGQw8vPg==
X-Received: by 2002:a05:7301:6083:b0:386:a01f:a36b with SMTP id 5a478bee46e88-386a01fa8d8mr18967962eec.35.1795591296844;
        Tue, 24 Nov 2026 23:21:36 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm62232352eec.11.2026.11.24.23.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:21:36 -0800 (PST)
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
Subject: [PATCH 2/3] Input: sun4i-lradc-keys - clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:21:23 +0900
Message-Id: <20261125072124.2997511-3-prasanth.r@lineo.co.jp>
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
dev_pm_set_wake_irq() is never released on unbind.

When the driver is bound again, dev_pm_set_wake_irq() finds the old wake
IRQ, warns "wake irq already initialized" and returns -EEXIST, so the
driver warns that it failed to set the wake IRQ.

Use devm_pm_set_wake_irq() so the wake IRQ is released on unbind.

Compile-tested only.

I used an AI assistant (Claude) to find this and write the change.

Fixes: b243018eafeb ("Input: sun4i-lradc-keys - add wakeup support")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 drivers/input/keyboard/sun4i-lradc-keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 05983db3f..eea04d27e 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -321,7 +321,7 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 		return error;
 
 	if (device_property_read_bool(dev, "wakeup-source")) {
-		error = dev_pm_set_wake_irq(dev, irq);
+		error = devm_pm_set_wake_irq(dev, irq);
 		if (error)
 			dev_warn(dev,
 				 "Failed to set IRQ %d as a wake IRQ: %d\n",
-- 
2.43.0

