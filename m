Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680682;
	b=xEyd29sH1odtYh2IpgayPA9nC3On6v8eOQOdC7/HyqzUyra/+JiyUMqHs7rWW5BadRvm
	 EWK6Y9Vfd58yhq8Kghwdg7zy5+0Tv/Y2sQ0KCo8adKWR5t01D8nuqe+h62Po2G1IYjQmS
	 qLeJBJbXQpTtUHvH8IhEjAnu/VkkfO9yBw2PIGk6mHbWWTAAedhNbqg+W9lWlFRBVmpeI
	 MPzxyoGheprD0Fi73QcFdPanlFwzzPDJTjJgcUWo2TjGbtzydV/Mu7j8X83nfcBj0DPFm
	 fPYtiMepPvw47c2Rm44gIRH9rBcRp2bMILS8frzHid1o7sHVxuD8L61NuXIGhE0GvaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jwXE6HVPE3u8H2VoPGvf+65Nm9Ko3QG6ghTmXH3WIyI=;
	b=TTeO+L0wAVg9DgrGoZ3p3FqpfsaDugO9WNBO8BybyvFTOpBItZ03eLw4t6uJT1ddLlwr
	 lwFvwdrk0Cf/LVCkZEzi7BLT0m7HiWkz4XMj0FicVItHstKck4RFuI1XOymdl3arCrTG9
	 k3ux1Ej0e7w9WV0QfO5ZyHarmdxTccRdWXDZ2vcnLboCiyaYT40LmHYrur6fkBiYeQ0GR
	 cCyRTXkEoYy1aJUhkDNLdbaGIkEpI+qiR2uPDVjMSW7ZiNLt3Me/OVSYy8zDTFyeLHhK3
	 CXCI+SUuF7LhllWHWRWPns27Y4o5ujkMcL4glYeBsu5nodprZQL2J3Mh0zIPVM5myUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EjfUq8wZ;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC37606A33C
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EC37606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EjfUq8wZ
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so1994242a91.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680682; x=1794285482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jwXE6HVPE3u8H2VoPGvf+65Nm9Ko3QG6ghTmXH3WIyI=;
        b=EjfUq8wZKD3R/dDZ+kWoTopD8ZmC+9X4+EPqk09OXIxHyQJwsEL/xubPSC4orNaHsC
         +j/c1FlnEz1/o3R2o9ojMrNKFQ23qP0jDRDia+XjPzd6TuMFnBBOo48A9RaL8BJ7KaPx
         A1VcrY6HmIkHZq5Rsrz+3DJJmNd4RqZiZbUUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680682; x=1794285482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jwXE6HVPE3u8H2VoPGvf+65Nm9Ko3QG6ghTmXH3WIyI=;
        b=fhqXjt4Pfts9Ra3l0nxnwnALPhPpOHn0geIJTm4UBj/v7MdaaDLbDOwgaXr0AxlXPD
         +YSCFyGGPArDhPYj6z4SJdoN6zvQTR5hPu6VQXYDtUraDsl+RZRYGZ2MCBfCqmojNQjX
         ZF3rC94ZjQPF1VsruUw+8VYOMi+vNEBbwXcJ0wIRznrLcv+2/athH58geUdJ4Dzh964T
         MVkU/P9KqprcTE/62O+hTI4nZXJOEZvAFIR4vQ4GdkOAkwbl2ZBzlvFb5Z6y4VuD55+5
         siIr/V4Df4UCuktyaMffSSjoSQi44hahs/IVmD8PuIr6rpc4qblbQa00MCVOnUreFRZG
         LiZQ==
X-Forwarded-Encrypted: i=1; AKwUvByTcOCYVxCYL2JEvxeiArzBKjAdQ+adFaBY0DeIAupKzy5pXhYfoS67rtlRI89sdTCfsLScTwx7hxFMHQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+1muzrM+pyEvkOUQN0UtjncnZnmWPGvrouhlpFW9HSVg7VKtuq
	HGjoB9eXs0+5wYiSdZqzrWxqPjcZGMmrzb73xbH2n3yDbeOTctaVU4Ai42SCkbqIWw==
X-Gm-Gg: AYBFou3R5AVDMxf2KxFVGjpPqQAjHI58cS1/GWvOw1MkluoZX3YLN76aUIf9SdjBIZO
	s7C9FzJa9cqnaxS/kEh0Fg/KDAMJdxOqsw81MXaUE8cb4zyPiGP/67ynR04t+C3la46yDGUnIJq
	90rcUQKS4FdPIQ/fZr4OhK2AQzEX2kzAJ9p4+MCrLj5zh3PSzqo0cbt9h8DkqA+/86Ob3gjsd4z
	TFJ+gA+4tXpcOdFEj1MVLzzbM9BJbxmGg4R+6ZmR1tQrtRudzLSbbSFNmV4V/G15RwImo4XBeoO
	jYCvoVpTT+Nx9B0q74J/3xPBjHbynGTM0nIXylbOQhDochROQ9hOewEIOPHqcCdRTrfEbUHb9/P
	/4GqFH6pCrQjtj2E51o+4J2LnGb1U/7mZZOAGJHWih3OIDykTiz4EkJpg9W3B7kAbH9oEwFaVIc
	16x9HCCV6qLG7j8ydMSF6Y31Q/6cWn/cbOQ92o5VyuF6cfsZ0+GjgLIuyXj2iATMBbrFsYF++Ln
	qNspjutK6Rkamy6Tldxxk15GaRCBfbejE8aoh115xfIzI4vwvHlBdGKCHdO1fPbxiKS22FFdIV8
	pA4ml7CegkMdRELl1ULDgXJU5hTdi/4ThQ1sRyxbTVbuO6zZB2fuTQUOXQ4DtdybANmpYYPdLpY
	C+toNFVhPkDRr
X-Received: by 2002:a17:90b:2fcd:b0:3ac:a7ee:6780 with SMTP id 98e67ed59e1d1-3ae8986606fmr10535707a91.66.1793680681667;
        Mon, 02 Nov 2026 20:38:01 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:01 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/8] i2c: of-prober: skip post-power-on delay if powered on sufficiently long
Date: Tue,  3 Nov 2026 12:37:28 +0800
Message-ID: <20261103043734.2179858-5-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
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

On some devices the I2C component is powered from an always-on power
rail, or the power rail has been left on by either POR defaults or
the bootloader. By the time the prober probes the device, the device
most certainly has finished initializing and can respond. There is no
need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree and the component prober. This is undesired, as the device tree
is not fully describing the hardware.

Switch to the new regulator_enable_and_wait() function that makes sure
a certain amount of time has passed since the regulator supply was
actually enabled.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_enable_and_wait() API
---
 drivers/i2c/i2c-core-of-prober.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index 6a82b03809d4..f9f3c0ef93ff 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/time.h>
 
 /*
  * Some devices, such as Google Hana Chromebooks, are produced by multiple
@@ -226,13 +227,11 @@ static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_o
 
 	dev_dbg(dev, "Enabling regulator supply \"%s\"\n", ctx->opts->supply_name);
 
-	ret = regulator_enable(ctx->supply);
+	ret = regulator_enable_and_wait(ctx->supply,
+					ctx->opts->post_power_on_delay_ms * USEC_PER_MSEC);
 	if (ret)
 		return ret;
 
-	if (ctx->opts->post_power_on_delay_ms)
-		msleep(ctx->opts->post_power_on_delay_ms);
-
 	return 0;
 }
 
-- 
2.56.0.385.gac671c819a-goog

