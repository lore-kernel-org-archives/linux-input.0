Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466208;
	b=f08wwUh353f4bQCpfOfGJ2VgtunTeyrdyWLIA9TyiGtoFTj3uYrEFadF4pQVNFipJus2
	 xTlU3Oii5Wd4aK4g13+dSLMMuByCV2PtUtBHBzkwURupe586fDZQyYOwOEg6SB+Jw+UuR
	 umjerChP7BLT12UvlTHij8mmni7o610iCIc4UxNvrPs125GvC4vNGzTdLOY3X08/LnLau
	 hOCTJLS4yZgmigjLWwX8W1KzlLBG9vkK1dKLYVztTVeO1BfX/0qok1t1GZecNLOw8mUqe
	 qYLdGdc7D4fQyl6vxFueNNHPHg2Kiywaf8TcMHh3Q9CTnDK7FjOuwJWNYq6SmT3DDFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b9b3tYu+beF9g/ZwB2Rnwljh+myz1+aTj2HUWSMtgl8=;
	b=zot2u96i7w/u5bAneoamTBGEIcJeykXrD2YKRokoVcD2EGjNg8l+yDglWUjQ1n5MMnYv
	 5RhGJrnSAiN/uOw91XZbjjzyDym475KOrTkhZpqQw1VNvbw80LB4O3HF6yBJAIV2KvPhb
	 RWHuyvwVVKoddPRHxiWaU+3P5cOOj3clug17ONeXLMYqWn2TJnS/8f07y4XuhLb0U8yxZ
	 ki1icX9DTRhgHpfxWt1yM0TqrzYxKklmstFmxcCKpWxQYODZyC7GQ0ZocnbzGGTJavtH+
	 Tev8HJsLCR2CMauBjRatEcqEYG5YRJ4YL/zHXVXTkaM/WhoD8MElN4i35W6j2GTuj9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgwHHH6R;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9560A5BC7
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BB9560A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgwHHH6R
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so4750309eec.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466208; x=1795071008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9b3tYu+beF9g/ZwB2Rnwljh+myz1+aTj2HUWSMtgl8=;
        b=SgwHHH6RYgrx0noh7brEbqdSa5d/fDZSvuAXPUJIHRvvV+j5ClLWPhI0JL0ULpv1Jv
         0VarGnytt4sarhu13itTjd07vwTPjpCspNi0HnqRtbz0JOr1hsR5/pqXwZ99FGDmHwf5
         rmXmfBFmDRXwXUulQFjmmGOoVNY4eCZWv7BEZY/TQljtwS0ZbX9oRn1K8paxFkVFijTL
         UWp2djiJnUa/JPioAkfE1nwfnGD7qgu5Zq2eg4sTrAgjdmNCzVDOLk0F5K1zws0QDhyi
         yTP6i+386VzhoW2oOnCMhyXn289l21H6fqZEgiRThTIv0Ailz81BvhaWtoT7yH1wXOEZ
         +pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466208; x=1795071008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b9b3tYu+beF9g/ZwB2Rnwljh+myz1+aTj2HUWSMtgl8=;
        b=pUdsGVP8RnA+p2XPqi8PYUbzHleiLgoROIoOVpS/oaQbq4IDTfhBp8AkgGFnhDRedA
         h0Nzrvjuzy5grKSOEoh2Y+rmvV/1H2yN1VUegMSO6yqtCEKBUKxMQns4EVxbvKQnx5AR
         V03bUCJdl9CNUdl13q98zYzrmEYy7Bq4753fYZgdB9cB513DQXeeKMkNpImKtjyKAgS6
         +1GLGzVFjxxkyhkruihH74WbjpWa8WNAqNwZV9PeV3oysRDaVEFhWoiF0kJ9FfAAEyA6
         /bocDrz292fqysSfbg/8YbzcedvMWWV119ANSLshABXjkS4ZacDGkYKQ5ynGcHQtVV1G
         V8HA==
X-Forwarded-Encrypted: i=1; AL+hErGHxGeTFB5PwfW1iG3ddHtxJGLS51eaOYLMPzGuk8ZXLS/4Q1odjnKVss4JpyI55CFPHeVkv50rw9VGPw==@vger.kernel.org
X-Gm-Message-State: APuU4Z93eeCnYVVaifSr6mj9AbMq4TQtobmJKzP8clqKCPf8gJfIFG0D
	mU6ywRYyUDhgT8rfHhWkVj4mPRQQu0LUng+Sk1OzJ5s0LPWrGGIFU4Pq
X-Gm-Gg: AYBFou3x36i2/jx+t+7+OntwO1Wffyla1Z6gA7oKpRZCYe/N07VdH50/D7u3/jY7R+5
	SDolNPTfzzTsZzEZ2XaEvdr5kpjSBjXCqeCHxCmxhBZoG0FiEz5geYE2Mm1mVzKuXDr0tdPxdBf
	AEWku0/6C0fHkGNxwmZsYtCDTBljNou/zqX5q/C7K0Zkf+XBKHs+y0Z/I1uPzGnG9qDqJHwWA1l
	7CzhjPNtQvXFncd7/ZyC4AVUF6enE896qIoOXz47RAJS7DHBdL5CxdcutMp8MBEUv6tMIXAg83N
	bC2w6zZMOGpF3QQw8Q9oa0oPn87jvOZywY8o63rGvY5LnJc5KJnQ24l3FraTDQkA5otzwrymhKR
	ovviB0ZhMwpW5bOjhj7GV875jkxUrUb8EP/ICqEa7+umxeQGsViWQIWiDtTox9s16q8HYqHe4KU
	MChaiBl9aWKOqiHY7Z8T6F0pK5eKlW+tIxp1gyj/1UtmeZtHOrRDfi6Sb5HJ1j7ChtL7qK+gN+s
	4IcdsyQfEivEin7QnOzH/OSX83cU5m3BHW0nhFJcH7DTro0riQJ01fIYDfnM5PHhuoqUrh8mDai
	6r8inJSRCxoLqzd63UPKj0qJ2wTrRz8vUOaWw5Tp+JoM+LJsXyB8q1S+ZYQ+919tOX9nCgDephH
	/gPlXmtw8tSwD/RPl
X-Received: by 2002:a05:693c:68c7:b0:374:e25e:a533 with SMTP id 5a478bee46e88-376864688a8mr4910852eec.35.1794466207572;
        Wed, 11 Nov 2026 22:50:07 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm27190961eec.19.2026.11.11.22.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:06 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Kris Bahnsen <kris@embeddedTS.com>,
	Mark Featherston <mark@embeddedTS.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Input: ads7846 - remove unneeded memory barriers
Date: Wed, 11 Nov 2026 22:49:55 -0800
Message-ID: <20261112064957.1796975-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
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

The driver invokes mb() after setting the stopped flag in ads7846_stop()
and ads7846_restart(). These mandatory barriers lack pairing barriers on
the reader side and are unnecessary.

The wait queue operations wake_up() and wait_event_timeout(), along
with disable_irq() and enable_irq(), already provide the required
synchronization and memory ordering when stopping and restarting the
device polling. Remove the redundant barriers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f1827684c902..6352117cd898 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -235,7 +235,6 @@ static void ads7846_stop(struct ads7846 *ts)
 	if (!ts->disabled && !ts->suspended) {
 		/* Signal IRQ thread to stop polling and disable the handler. */
 		ts->stopped = true;
-		mb();
 		wake_up(&ts->wait);
 		disable_irq(ts->spi->irq);
 	}
@@ -251,7 +250,6 @@ static void ads7846_restart(struct ads7846 *ts)
 
 		/* Tell IRQ thread that it may poll the device. */
 		ts->stopped = false;
-		mb();
 		enable_irq(ts->spi->irq);
 	}
 }
-- 
2.56.0.567.gdb80ae8cd5-goog

