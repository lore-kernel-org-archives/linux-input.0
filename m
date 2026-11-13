Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596875;
	b=o3ozJuzIa6en9erzZAOcVNdE7uLdH/bZrIaCCLz9XqTqgXxBVNVP5oHI2Vv3ekwtM/Xj
	 OUMDUX3MNd9PUu1jT+jaYsHh5rJ9tjeE0PkJ6u9wOMwC4UEVF6ns7IRvZA/GMFSJJja3+
	 JrkoLu7mss9vr/0F8fOEp+T3qHhZ9356mquGeCQN2/HBxHyqpaqEL3WvCIs4J0PpfxMj4
	 3ofG6HuRi57JPz9N5Fo1JScCVEPtGNX06uaUSPTsYxVCwsLbDrZ7Va96HJ6HlZ3OO3DnP
	 YytNBzZlLFdGg0XZmxMAr1v6EyLGRF5iU9EDqQtsSHSGA2uwdQNrjqNwXhisa2v1JXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vksi6xdBiN572U8/PprSF6T1ZcI65MaLXrT+W5UPb/M=;
	b=Odkh/XdJYy1hZuE7YNj0brC4krp0D4v4tEgNd+Zg9DCyktgd1ZD5cfZTSM/hkb+QVQ7x
	 OK3ut8X6vV6z0RID1tBL1heGhKDno3HJto6cgaRbJBq0aUzUf7+boNH8831MLG4jtF9lP
	 uRiLhrXSKZ0g+BQL2+jKd7jJfnO6gvvzfnF8MDqR60ssuQmd645kD+hYJ/uzyoOHj35OE
	 9f7mSbvowVq3UI+OBTbymqw3nIb6HFZ6xnC5ybBD99flf3v2vMyFebrtMxvTCsB62WtFk
	 GsoxGg+jtn7XGo6lKiWf8y5q3H7ZDxHKaWWG5GuSpZZ1yLSawnH2iJbk9DN0C279XhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFjkGDON;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1160A262D
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 19:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5D1160A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFjkGDON
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c5067a2411bso255021766b.2
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596873; x=1795201673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vksi6xdBiN572U8/PprSF6T1ZcI65MaLXrT+W5UPb/M=;
        b=bFjkGDONSYnmUt0iBBDN+sBDopI7ikDsKpWVytszNlJgTae66dMDCiRZOAt5mLIY+s
         q1LywO7q27xilrn7scZ4dSAsbplZ1ghm5uDWf5LME2ful/5VEle53jfHvSJBkhpAjd3p
         O+9nm8RHUCbu6LNeCr8PQpqG9uY8s9AZpF+U4RMTeZsdd8Aov0vSFzmueef7+1xwzMpN
         6Q1jCE+2tveXveOZTjlik8Y4wllQipC/oRz/uHHKlYJH44dACS1fR3Hp1oUj628Pt94t
         uRP/PJpDgm9b6n4MM6qAaeWG3cE/6uJDdbnyGzFix+pPxfnA7fCUeAz+2RvCNZu8cGtk
         Yexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596873; x=1795201673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vksi6xdBiN572U8/PprSF6T1ZcI65MaLXrT+W5UPb/M=;
        b=mferz30xLV6fCBxhF6p5WN4HBS0p703wZWi5opnMxbvef8usxPJJXbYa8ZaCSaNX1b
         WOzgGdYZgO5b7aMMyhdgojqgJRZxKxLflUNbw5ucOE5xazS0SzHrnft6qHWwNJHpkCNS
         WsqseUVjRHqy3YPMavV8oaNlnkqF8djLee+PuoMoPPBQGdoh6tkuRolddjUEZlR4n3Bv
         pHg8TKVIoo8s6lDDHGGfGNB+/3zEoAvqpBtN7VVK3UBn/NG/RwvHtvTDgwyNILcKwHfR
         NbRX7MWRzGoYukmmPw/FJPczEUDILLbbm0O42w44ggyG8iJUSu8yhZHXq1uWLE3YifeK
         dElg==
X-Forwarded-Encrypted: i=1; AL+hErEicKNIaVXo05LJAv772DZHwGnhTH2Ga9cgPFlwNJaNP+F4jtU3iFF9fQt7hIgcIudB432DtYCvxBFz5Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9xLkptkilYlt0bnInpw3axZHFMGIochf+9ERlQEkeboKNBD762
	A8C3gPFRp7jkv+8QasNUDqp3peEDuizO5TEtnwT1WUNEFy9CRP2xOrrM
X-Gm-Gg: AYBFou1JYyWeKqVfeVT5T7ATv8r36rIpTEQgZ7jHZAFIub6p01HSs7UyZLeXMyO/MiU
	6Yc06ojgKAgE4rKo0/gplArGKh4Oz4tQH0nGt5/sRc+hj4/j/DVMHKTTM/Hy/I3y158wBirWnzo
	SS+jkvotiSCqN4kc8+jd1wceDj/+IA5mj0UU/i73CMF3DzDBSmFpfZF1kXMG8yTZvZ6lDjBRiKs
	cUVvxKTBMySJZEJg13/SKulNpMHucOFWaZsn7W9lE9OMI/tuOarSDbd1f8iGjPTKLbHWFRwbGZY
	TkZGz9RaQFUFq57JfbPPgEw4kceESrcxsqr1WvEfsq/IDjmY7JjHEZ49WCI3bw/ryS9QFbN56qK
	qHkaMMbHy45D4zss4QvaS12VX0yPmJVo/qnr0EHJwDMSzC0u3ev1KXi1jC4jkmkZ+2I01RehWZG
	lJInFiGaNW2QUE83rYWz++t3H6AnEBvEaches5EAGPmPIlJPA5S3hes22if9egRELZMmIenjR3g
	FD5Zadc2mPPIAbSVcX0DHBHs15owsYYI6mh2V7XwEbps/Qa2Fo/xKu9dSVviZCyJql8B5FssQRt
	bhe1CcYRksjDVEQw6/B95jsc1MedNNrx4X1iV8ukipZyrWSNnD8xLIabK8wFLuH9Bg==
X-Received: by 2002:a17:906:9fcd:b0:c50:9149:48e4 with SMTP id a640c23a62f3a-c50963db437mr297220766b.11.1794596872956;
        Fri, 13 Nov 2026 11:07:52 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:52 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:00 +0300
Subject: [PATCH v2 4/9] watchdog: mediatek: Add support for MT6895
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
Message-Id: <20261113-initial-mt6895-v2-4-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add the compatible for the watchdog of the MediaTek MT6895 (Dimensity
8000/8100) SoC. Its watchdog registers are the same as on the other
supported SoCs.

The TOPRGU reset layout of MT6895 is not known yet, so the entry has no
match data and no reset controller is registered.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index a210fe1569e4..d8755979021b 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -607,6 +607,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6589-wdt", .data = &mt6589_data },
 	{ .compatible = "mediatek,mt6735-wdt", .data = &mt6735_data },
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
+	{ .compatible = "mediatek,mt6895-wdt" },
 	{ .compatible = "mediatek,mt7629-wdt", .data = &mt7629_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },

-- 
2.56.0

