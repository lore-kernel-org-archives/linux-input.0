Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681241;
	b=WEqeKKBiTihXlp/BP9uYjXLwhLnq9MnuHmYVANvcIfiR/hWTD7OD3dS4sJ71Cbb4R+a8
	 CSEfCqVUhX0W156BkP9tnyVN5gr7ObYgl5azKJHgDNFxaqyopse+abcWSAEeWmdbt3SHJ
	 P1/iRlnqiLid632iZmZp08WdXS/h/QxzEle8ABatI+kYNWZrJ5n9obiXTgICP1F9RDrRp
	 9q5gr0jx3QCeE66iTLJqgrQsB2uqmDHGemXOmNaEhHm9TLacyFAMDd9k1cO34eOO8vozm
	 Z5a6dUFSKvQslXNEoHZMlG93dkYRHp4TtBpEDoI0AWztHztgyfUA1KLj+XLN9tKZ6NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Dza2NSY0k37SStuTd0HKpba9S7dkkdTFtyMIItC7+7Y=;
	b=ynGZ/dzny7+xZDfjuWxsa0JrBwlqfZjmkviR6Ir0wGhJc6IFTdTKOwGJLfYJOkzZ/TXw
	 YKn1QiBjlpmwYoaF19MHuQZpipK7FMD3ntGt27y5HzPKdlCrM/cnLbM5BgKH1CaAe1yCM
	 OS0ZB5AxBF63ScdmV0ZXuHWkc3rKU9YoeBmnL6DnoNGvfJO4r+5yqdGKaRs8ZGPy7a1ij
	 R0SoRAtr2qpOjqlHgaw2YfF/hlJGTALcrNhGIrDuK2k43CKAw7Ziq4eByoGdmH8MiC/Q+
	 cLxdrSCfH+UpyzNiYlNy82BRtLbR1I4YF1WdwEehdyACGNu9jzAlVMnRM51sZmxl7bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BLyOL2ak;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B4606A336
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B16B4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BLyOL2ak
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-369f33df08eso7312227eec.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793681240; x=1794286040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dza2NSY0k37SStuTd0HKpba9S7dkkdTFtyMIItC7+7Y=;
        b=BLyOL2akmOTFNSCdFt2TJihyuR8nNZwfQuESuFgWbuAgMUuvrANLqHuSpzqi28d1dw
         WBsHRVCYzUajzoUCBjlAyxJ2u8g0Nh7eH1ajCXjzrKko4QDRqabNi+YuJSsaQJ6nng0e
         ALTtcJZ38f64xTVGPvjvrAx1AzwhtxunjQgZ4Oo2rPePLSXoLW0O9DOQ/8bLqE7wFmQA
         q0kODqjGhtsAAS4zPoPz2si4UkgAq4VJbalv07Gf36GOt3Z6o+fhpTiQHwtHm4dFnKqT
         RUyoWy6TSfXA7oUCT+hL44yGAyEhxhagjr9YqEAoKH1ZPJ9a8xAhmaCg7ESvJ6oN+/YA
         DZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681240; x=1794286040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dza2NSY0k37SStuTd0HKpba9S7dkkdTFtyMIItC7+7Y=;
        b=tvqPUMcn9cpeCwioDBs9GEtxA1Q0ZNlVRiNUJ5e+lWHEfMJEb0IAyY02LaxTMjLYl3
         lE+EuxSeU40LvzhF89z3pOSmgYwj8oSCXNIAGmQxyonEy9+swE5KMUQQ72SYHTv95UIp
         AAqL2fEJBwoHY3doS/rZ6UJ9yfRiDVPnJgntu4DDZTgJHCsF4hiohErWYqjZ/3ncgS4Y
         x5h/XRME894LS7AvJuujcyeZNwNsI5Cf3TGmzCbmCAdxH67Pn7QohpkHF4GKpnoDbYeN
         5vSzY7G6LaJVVqD/EoID0miZk+eHmO5wqllGXpGitAY4m/2Ssls+uy6Ndwq29k7coccK
         STmA==
X-Forwarded-Encrypted: i=1; AKwUvBzqFKBSg+CRVWkl3EZ9SXL/NHtXe+LgoGlwJf/my62zIs82WWiUuNDALtAF2fTmYaWE92H4ZnkV4p0dfw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/CLTFMrecdlnmqImFkZXIE20sipbRk7amRPXHpO6vKGXrWILjp
	EH7rAOZHzFtAOpAorVsqLN0VXhdkxub/ywRwTjCay3ZYjn6MK433v0wV
X-Gm-Gg: AYBFou3dNAncxX6m+XYCrxPHonsq23Wj6OLJPpSf4Bk4P5p8eLZa7cPk5xrWO55L0Bo
	K+LAQY3UxifAFpKS//UzCoNXPTelXtJQWtXcinZsFF8slzap0AQNAiX7plJyhwJ/nT1n7GOBY1M
	4snnUWaGVE61fWWWcJkaumbpm4Up2z5nUWHz7vkD3l5wo7vEasuuOAV48MJBOv5jWzOPVQ3aFY0
	AZ/BP24kfKCOlW1lCIWXeRLbf6lTa/3vFkz0Aks6DyP6txfZ9wuYeC0BncK7WPjLBmf7k3sZGTX
	f3xwCQG8Fn/5et0Gt3/vM5mfIYutNHDSV6J22njKWIcuh1PTOcl69m0rpCrOTHRGtwSmlBH+iDS
	8WlVsdhykFRNNW5YNIm9uqYr+VpYNhPg0xZhbwzwx2a+5Rx8nPnZRUOnECHSF6eBphzZr3MsrzS
	0PIP3ahKO7ejOcvVSJph7+KBxU86uoNqKR+4GaVxgz0EZtcXZaMnPIgx8NU3rp++huozb6lJ2Wy
	BTvD6la98Xb56UNqzikeZEZZCw8MBdZ8iFD+YQAInby4EIlC/82jzuWoSeqBtKWnnhSuXs76YSG
	EFwT2Pvh9scTYjAmrD8m9687JAiH2FUgxGB4NPIzn/iwq6kax3so0FL4S+v9uD/e3J2v4a89a/+
	heRcpuS8tHf0YYcFzFlKe/LDgcMoyJ5S19u6OIQ==
X-Received: by 2002:a05:693c:880d:10b0:34e:9923:e372 with SMTP id 5a478bee46e88-36a4241a810mr19587443eec.29.1793681239614;
        Mon, 02 Nov 2026 20:47:19 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:98f:6bcd:858b:7a64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm48385807eec.11.2026.11.02.20.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:47:18 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Val Packett <val@packett.cool>,
	Hendrik Noack <hendrik-noack@gmx.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Jeff LaBundy <jeff@labundy.com>,
	linux-input@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Input: apple_z2 - set default resolution before parsing properties
Date: Mon,  2 Nov 2026 20:47:07 -0800
Message-ID: <20261103044708.2461481-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
References: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
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

apple_z2_probe() currently sets the default 100 units/mm resolution on
ABS_MT_POSITION_X and ABS_MT_POSITION_Y after calling
touchscreen_parse_properties(). This unconditionally overwrites any axis
resolution calculated by touchscreen_parse_properties() from
touchscreen-x-mm and touchscreen-y-mm device properties.

Set the default resolution before calling touchscreen_parse_properties()
so the default resolution remains in place when physical dimensions are
omitted, while allowing touchscreen-x-mm and touchscreen-y-mm to
override it when present.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/apple_z2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/apple_z2.c b/drivers/input/touchscreen/apple_z2.c
index 271ababf0ad5..e7863f8f1d5a 100644
--- a/drivers/input/touchscreen/apple_z2.c
+++ b/drivers/input/touchscreen/apple_z2.c
@@ -397,9 +397,9 @@ static int apple_z2_probe(struct spi_device *spi)
 	/* Allocate the axes before setting from DT */
 	input_set_abs_params(z2->input_dev, ABS_MT_POSITION_X, 0, 0, 0, 0);
 	input_set_abs_params(z2->input_dev, ABS_MT_POSITION_Y, 0, 0, 0, 0);
-	touchscreen_parse_properties(z2->input_dev, true, &z2->props);
 	input_abs_set_res(z2->input_dev, ABS_MT_POSITION_X, 100);
 	input_abs_set_res(z2->input_dev, ABS_MT_POSITION_Y, 100);
+	touchscreen_parse_properties(z2->input_dev, true, &z2->props);
 	input_set_abs_params(z2->input_dev, ABS_MT_WIDTH_MAJOR, 0, 65535, 0, 0);
 	input_set_abs_params(z2->input_dev, ABS_MT_WIDTH_MINOR, 0, 65535, 0, 0);
 	input_set_abs_params(z2->input_dev, ABS_MT_TOUCH_MAJOR, 0, 65535, 0, 0);
-- 
2.56.0.385.gac671c819a-goog

