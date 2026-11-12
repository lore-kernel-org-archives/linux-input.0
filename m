Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466211;
	b=FUmZYw+v2CcUKJrUQ5FCiY9h6X7BG2Da9ISX7oY09Km5UG+UzobOJxpBB7fZD3azZAIr
	 AoQtYokWCYXkaXNZkwYm6E/1KHsRiOCeyayISUyt6EpwzffYhi0TmUzEO+7vgmPUG94L1
	 nN3T+dQPEmjpwyLh99pa5PomlZMHJqvhSVPFq/dcQu2Y+JEtw0oHAjzOlvvmcP/RU/Hqi
	 wLHRVYLn3AQQ9KakqzwKUQWNFMNTofsBu0OyNmI1lptkNNKSB1N9P8mPnHyWN7w+0Mcrv
	 F7l+or6rgYiUAW37JmNpHZ4AJRtVmbcOJt8JB23lhe90t35L6RxvIJWyzmQYA1K0NNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fSSCkqvwTZj1huGL8Zl26siSAmzWWRmX0EP+FjZ9eu0=;
	b=wXBjy9kS8sXxxFgQLrDNUZrcwMjKtTbsSlraxut5qFcsZ4B+w2nI9I0q+PX7sPKFZQhu
	 wVxYiRjL8UlQQeZcxr2MCpd0Jc1RxWwIoNV7Wp/NLNk14PdCOc3iNhGI9xczxZKu5N+kj
	 89oOjPp6j1wFnR0HJBZ1t7JpSznCjCEJNdf84xA01HcH9pjF3TerXgQsZ7P39KYfyKv7W
	 WWl1T7brwUUpCvs96SXF81NzNIrgqpW2a70SBRdLNq0UItcPhKEc797QElJQkg5MXeqsx
	 bPjMnohQseox0sNp429W+Hc6pB/lkb8U0BLiVdI74U7VwaoFcLlG+fRIt48vW0HPdOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hh2o3mX6;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9760A5BE3
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD9760A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hh2o3mX6
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-37628596783so3776233eec.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466209; x=1795071009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fSSCkqvwTZj1huGL8Zl26siSAmzWWRmX0EP+FjZ9eu0=;
        b=Hh2o3mX6TwMjHtUDQjFKWWLY9ICG8OkBWi672/jXglxlWUU05O1/0gHpLXjBXZewdv
         AWSNmysG6Fa3+DAwAIRat8C4MYGAzHqrzgAGCrktfuO2ZoZaRrP97bGPgqXWsTkPxAwt
         zS9JbAuwskdP+RwY6qaQhXZBP60lWB0Ea3z+HPat35mrfiM1/T8A7wgjAakx+/Ux6s+T
         3RfFZeM3BhJHFCFhGNIKOOZ6ymglbgDOCgrqeKEob9AKKgchWcX+tCbQCZGAGMHVG3bn
         iC8UKZfAPE1zD4JdVV4sKcTbguTnRL/c7dg4eQgelrtbwdKmTkjdr7IoYF1vAZsXVSuj
         HPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466209; x=1795071009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fSSCkqvwTZj1huGL8Zl26siSAmzWWRmX0EP+FjZ9eu0=;
        b=WCVBgjXlPfocSUmDhRkrM9JxM8KUOxw6qT1QoGiF+urrqHyjpT6DQM3k7NaGLlp6/B
         L472NjDYFfZtfcRvZWqBssXJR23b/nO86Amd/s+E1h7qlolTa7TlCEG4AXujceDqywQ5
         yFhaLJH0D5DWVdqTQMZxSRawwv6cSrcUrmrrd5rtIdLhrDp5YCvJnalOM6PE9ccXKmKZ
         S9krXu6PuPTgZgRBnWL9KyfaHI2MnDjluT6tchV5yCwzTqyLb3xU14ZHQqTjYFdPpMeA
         Jjh2vxyDxx//NLqhMp1o8q/F/yARHSsVR3z6lRvbNKd5ILpLJ1mApqwFvIVj44EWYSP/
         S9Xg==
X-Forwarded-Encrypted: i=1; AL+hErEI57Raa0BcBRX0LdaKjSWgx3MsteBZRYCcqrdcHJbifCrvb1tOn1aEFKF4Xh8MkoLV61YMDWjjarXong==@vger.kernel.org
X-Gm-Message-State: APuU4Z+HF1sVqUk7iTb/taLkfBBGa/A/KW/HpPQACMFuHikIJaGRy6vd
	qMKfWJL2NMjzP3jTULa1rumlfx+hp6FGdKaS8kv0zYT2S1bUagk9IMo+
X-Gm-Gg: AYBFou00D/bUedElCER1i4bOoIMJQI9cJYGVY29O0Bdty7/cCI4+olAqt/s2+k9RnVb
	+WzC6zbIGu5yJPiLzVk7DNQYRELGTIuKOOxfv5i9qqEQagW9585xBK0kN75lDjqWUrOZKYTVHsS
	hI2YU2roL/6Z32c/sPElFhFMr8/VgQlIPHilJDmPz2oqCUsA4d3C/h/KabLSGc1FoNJrv4a+q11
	IfhG3aSoB/Jkh6+tSsYdATXW72V987z9sSwviMYsByq1BGO/A3L1rqLYXWusFPUKPLN22B3fB4g
	mS8FTRtwwbodbEk7xIUmA3y4Axb3B+QplhWPfv2kyljG0RKaZvUgRxvXXFrDpHqu2U2RJqv4H7+
	G481NLhKIUb9pFlkrpKFf1rcdKvOzhsy+pdWqooWGXCtgrwl6R29wuA0F0lfb695mu/1aeyYrLY
	VAvOWqFb0atPak6TUQBGMTE/uzrx5U7AcyrU3Hu6pQhkUzhF5fiJi0QwE0SZhmbzGwnYpimkf2b
	hZqpznSUxmiFreR9a8JwkkbDgCSqcne4DMWHV2Iu1OvbnVAVEbrkqDmCevZVYgioQd1bxfrAHT5
	rVrEY63orfDpk0UkpFjHC618jxuTcdCaKj9SnhYNnW6yuAbaQxTO/v4oTrsDAsNxBbskCtgEwg1
	GMiQgf4dDoCTWKtR/
X-Received: by 2002:a05:7300:f54b:b0:36c:a42d:9bc9 with SMTP id 5a478bee46e88-37685c7a866mr4653158eec.25.1794466209304;
        Wed, 11 Nov 2026 22:50:09 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm27190961eec.19.2026.11.11.22.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:08 -0800 (PST)
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
Subject: [PATCH 4/5] Input: ads7846 - remove unused code
Date: Wed, 11 Nov 2026 22:49:56 -0800
Message-ID: <20261112064957.1796975-5-dmitry.torokhov@gmail.com>
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

Remove the pwrdown_cmd member from struct ads7846_packet, unused since
commit 6965eece2a89 ("Input: ads7846 - convert to one message").

Also remove the unused REF_OFF macro definition and drop the CS_CHANGE()
macro along with its sole call in ads7846_read12_ser(), since the
request structure is allocated with kzalloc_obj() and cs_change is
already zero.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 6352117cd898..4a5a141bb4a6 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -84,8 +84,6 @@ struct ads7846_packet {
 	struct ads7846_buf *rx;
 	struct ads7846_buf *tx;
 
-	struct ads7846_buf pwrdown_cmd;
-
 	bool ignore;
 	u16 x, y, z1, z2;
 };
@@ -145,13 +143,6 @@ enum ads7846_filter {
 	ADS7846_FILTER_IGNORE,
 };
 
-/* leave chip selected when we're done, for quicker re-select? */
-#if	0
-#define	CS_CHANGE(xfer)	((xfer).cs_change = 1)
-#else
-#define	CS_CHANGE(xfer)	((xfer).cs_change = 0)
-#endif
-
 /*--------------------------------------------------------------------------*/
 
 /* The ADS7846 has touchscreen and other sensors.
@@ -195,7 +186,6 @@ enum ads7846_filter {
 	| ADS_12_BIT | ADS_SER)
 
 #define	REF_ON	(READ_12BIT_DFR(x, 1, 1))
-#define	REF_OFF	(READ_12BIT_DFR(y, 0, 0))
 
 /* Order commands in the most optimal way to reduce Vref switching and
  * settling time:
@@ -400,7 +390,6 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 
 	req->xfer[7].rx_buf = &req->scratch;
 	req->xfer[7].len = 2;
-	CS_CHANGE(req->xfer[7]);
 	spi_message_add_tail(&req->xfer[7], &req->msg);
 
 	scoped_guard(mutex, &ts->lock) {
-- 
2.56.0.567.gdb80ae8cd5-goog

