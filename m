Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51145481FAA;
	Fri, 25 Sep 2026 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343434; cv=none; b=p0H0QwLxrRrl/msEBdDc1XKQn+fi+eZNiXqeMVfWrprFcQeRfITfgP0LglB2s7qSIH9hbgTkiW2aiaH08tyzv6+9y49pkBFCTHk5VEiYcFjB0XlD7g7smS4apawmRclP1/ogZ/KWnQXEFK/6cXN/02RSpn07BjVIW7Pc2lGhVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343434; c=relaxed/simple;
	bh=tppLKGihpPbrBaoD6zrC97omhc4nZCVt4fENCagZiKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ce+UF4dJbRKBB1Kv8yXyASIGE2CdLwIZ8ghtDF6n29KV08pss0CepBVjIRwIbY9jQGZYp0UtbR4HOWASZTSSUAbA7Gy4IstEQBBsjpE2KFrS5Msi0mhG+9prtCv2eoj5dJJ1RojZqDWA/YZitqqNvcExwKJdBfnwhYarMJcP7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D0a7jcAT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D0a7jcAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rz
	F04bESnonyKgD5D1eC1a+7YoFMLwMQxE8AgHg55KQ=; b=D0a7jcAT4BrkA0qSV1
	7Jsick2GZ/50XBPro1ifVUVbEDKF1B9kyrY2MlatMcgdJsmol4n5jUj3H4Krhf6Y
	IvpM++cNSGFq9BOfVyiJvTM8ppAeqvnETqItvz83Y8p9SIfstn8vnKXWw8+60ijf
	BfQcewQKb/ni3m/Fa8hl8jGvk=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3P5vpeLZqaNgdAw--.65146S2;
	Fri, 25 Sep 2026 21:36:42 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jens Reidel <adrian@mainlining.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] Input: goodix_berlin - reject devices without match data
Date: Fri, 25 Sep 2026 21:36:38 +0800
Message-Id: <20260925133639.2229728-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P5vpeLZqaNgdAw--.65146S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFW8Ww45CryrArykCw1xKrg_yoW8GFW3pF
	W5Ca4xKryUXa13tw48tryDZFya9w18Ww4rKFyqk3y093s8WryUZr1akrW3Za4YyFW5J3WU
	Ary7Z3sru3sxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEjg4wUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wqg2mq2eOrHmgAA3M

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but goodix_berlin_spi_probe() dereferences the result while calculating
the regmap transfer limits.

Reject devices without match data before using the chip information.

Fixes: 4d395cb071a3 ("Input: goodix_berlin - add support for Berlin-A series")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/input/touchscreen/goodix_berlin_spi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix_berlin_spi.c b/drivers/input/touchscreen/goodix_berlin_spi.c
index 01f850f484c2..db9e151ced65 100644
--- a/drivers/input/touchscreen/goodix_berlin_spi.c
+++ b/drivers/input/touchscreen/goodix_berlin_spi.c
@@ -127,12 +127,16 @@ static const struct input_id goodix_berlin_spi_input_id = {
 
 static int goodix_berlin_spi_probe(struct spi_device *spi)
 {
-	const struct goodix_berlin_ic_data *ic_data = spi_get_device_match_data(spi);
+	const struct goodix_berlin_ic_data *ic_data;
 	struct regmap_config regmap_config;
 	struct regmap *regmap;
 	size_t max_size;
 	int error = 0;
 
+	ic_data = spi_get_device_match_data(spi);
+	if (!ic_data)
+		return -ENODATA;
+
 	spi->mode = SPI_MODE_0;
 	spi->bits_per_word = 8;
 	error = spi_setup(spi);
-- 
2.34.1

