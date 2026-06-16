Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742B436365
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605622; cv=none; b=MujikZTYfIyPkvvAIB814p514bnH6w8UlRnbbK2BY/66SCQfbijyWqcFCnbD4ihqH8D37YfGPmvytoMQu3nXNeIxj2JE+WWFuXdPC2dL9JQTtSeTiPMyXORl/d+FGYX0eOsPxlJ4plTXU4cAE5PixDqak0v543QH+suB+PSKQ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605622; c=relaxed/simple;
	bh=b3q30hN8/8zTi8xRwokSZ6zlcxtUNegwQuHZnD/20BI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODXD3RwnFteL+31kvKe9REmaUXpR07Rc4Lp8jS7HXzMTHelS3tGYXkQNNnMgnsKXpNh6xFniLTaYDxIQ5ynz0jo8ql9RcXFDXSxX6M8zpWB4xEhIB9F9M9omLh7ZgnHgJyprdLtMPHoKFb+GcrJ4L7DT+dErtRkc9ENBEzYA+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/Z9ZdXy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/Z9ZdXy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so2921875a91.2
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605620; x=1782210420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIpkRPu/+gZceoyeLzf2KDGQKKvzitCGsNedMKc2VSQ=;
        b=B/Z9ZdXyGZIxs6xqJjtY70OhytMFXhWngEaJj3zVGVg5SWYbF+VWTeEzzyxwS+3OMc
         VplnEjdLA+fgq8FTPqWAUQPpFpJ9jzS1Zh4U91IPwZ0PoOHljtF5gjRTqollxXuR+8b2
         Gto4UAE9eG1ZjpshJGu8XQxMHqS2GGd3/EoZ5+1lf57ddSmEWvZIZXonWeuHZ5vtCm4e
         QCjihZVKnMLbPZgr91D17w91UlpUDNjhOex2GhksD19qh6oWd5r3tko2HSnDZyPAMX1F
         JUi13Zw1tcOVFhChFfHI8o5icyVz18lcpPqQZ5Jf9HKyIhTm+Lq+9+sfpJZQyYBNfRVt
         ydTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605620; x=1782210420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XIpkRPu/+gZceoyeLzf2KDGQKKvzitCGsNedMKc2VSQ=;
        b=f1NH8wBjh8ctQB1z6ajccXUInw8RMEDxFbWFNwSTC/ssoo0A+M2z5YgObYuCSctans
         xD6p54p71NPlTMlE5lQI0Q1hiOi7BdzuKMDbVyqEUKegfqyGmtdiG0mOZSrSZK0Kd0Sh
         MQkdP9cPmvczXC/l08GhB7FxvwpykD6oQbI0GmlK4AneJxZB8pObWnHagEpSCtMg5bNH
         IKlxlhYZdA03NgbQ/fW3Enc2Hqbm27DdvhPHOkNhW6LLq2nuA7ENfuPStQY+wFm15fzN
         TXCilhwG5E4HeZhtyjeH3hqBo7S70bVS0I7MA9FtHH/t56JajkLoB9nA5wc62izkb9Xu
         Fmsw==
X-Forwarded-Encrypted: i=1; AFNElJ+2jIHdaITGzvmB8Cd9emrgJviI3vaH+Hkkjgvr5qgaA6AmDrho+1N2d7qr9LIjcLL4fHMT75y7LFJxoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxshf45eTtUwamBI/nEX6J9ZT6NcV8/D9wTqMoGKJqieTn0/pjB
	B7/SrFYw7EsGQ2sbyOF0Ii0iCQPoiuJCJ/Rw0fR8mgaikLK4HFzKc1qh
X-Gm-Gg: Acq92OGWdoK2jx6O87Ldoe5nZrqI/EMJUtXax2l37Q+Zi8Z2YxjNOF+meA0Z8CNDqXJ
	9DOXUGC2vRREB9y2VUldLfdZuoYS4QRy48Ijg6HxCS8WdMfRuiO+EEAoAyqYdTeG8meirI93gFR
	IYxQm+Nr365vfQGowpYWoxmTIb4TdjR56X5bYtOnR+RY3//tkfwtkN/s6nZ6O4fihoxnW7Kq5rw
	MTpwiDKi+xXIW2t0ZuyshzGbEyh17U2vjZ6S5ASbUF1VBs19PhXX7APQwzfetSPIuVpG4aD7bdI
	2j0LLzkqT/5BA/tPWrg4DocDZBiHeP3NNhODwWA/d2+rogecfmbffwQiy8yVDzjdAw0V+GmY+Hl
	dC+x8NiPKnWhBS2jMHmTI3OrdnWoPf/JFEJPhQoo/K5XIbv0lUtOBBB8oLmZ9jGAq9K1XDOtaiR
	/+R7EexmlK3FHtifM+aFBqkqldjxJeNMxAkUkJXOZfge9bU300
X-Received: by 2002:a17:90a:6502:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-37c607b3288mr580665a91.0.1781605620467;
        Tue, 16 Jun 2026 03:27:00 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:27:00 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:12 +0530
Subject: [PATCH 07/11] iio: temperature: hid-sensor-temperature: use common
 device for devres
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-7-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

kmemdup() is used for memory that is logically tied to the HID
platform device, even though the driver binds into the IIO framework.

Using &indio_dev->dev for devres allocations works functionally, but it
results in two separate devres ownership trees—one for the HID
platform device (pdev) and another for the IIO device (indio_dev).

The devres framework is intended to have a single, well-defined parent
device. Since the memory originates from HID sensor probing and is not
IIO-specific, &pdev->dev is the correct and logical owner.

Switch to using the platform device for devm_kmemdup() so that all
resources are released deterministically and consistently.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..31ebfd1a1fe2 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -213,8 +213,8 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	temp_chans = devm_kmemdup(&indio_dev->dev, temperature_channels,
-				sizeof(temperature_channels), GFP_KERNEL);
+	temp_chans = devm_kmemdup(&pdev->dev, temperature_channels,
+				  sizeof(temperature_channels), GFP_KERNEL);
 	if (!temp_chans)
 		return -ENOMEM;
 

-- 
2.34.1

