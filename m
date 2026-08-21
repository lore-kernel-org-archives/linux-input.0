Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA642E542C
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787296352; cv=none; b=XvZeYY+cWCjOptysWw+rOdRRsa2u8D4GIKCiABUee2wvZ8RfhLz6k2VL2Y5EmpTE8cRtD9R4BBPKSP9eF8cb9SmfE68APsLcGfWNYo9qxrO7doYMsgwda/2oTVeF9jj80UcV/KGsSxGKCFZHHH2sx8EOhBb1LNF2G52YByB4mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787296352; c=relaxed/simple;
	bh=fiy4GcFZdsC9yxetlH5+plrNHl5cqFDQooXiediiUNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o+Y5EoxmfgXh5ONlRvkJFzKgG4suH9vhrEeto9shKrrNMj3pXraghaVw4NlrbI8w113kf67wLNTlxZmQTEfMiSYT+A7KHS4mQqc6JqPrCgQg+wc01RhxWImmXpitxdNUx5oex8R+ElFCkc64CsSagnoGT4H0puZkgiErctEzp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=43dfNpDj; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="43dfNpDj"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso1235919a12.3
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1787296348; x=1787901148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TnFsJCxkFM/wIQ0nrP+EeILR/FRzepb2V/4lDFq/FBo=;
        b=43dfNpDj7etKUvarBjFCNceUORIxr9OwLRJdY5A3V4ufPdhXu92eZE3y7eyJd+Vxd/
         lSasRrsfjMbSo3LF47XUYQqTgWzKPvNcdDRi1rh4c/acqjJUr80axHTLRW59RaLdgRoW
         nQzfFR9wljpDsV17UWrKu+fTtZp78dOnc/h7ajxHDk6OnCd16jbGfzvqEVUe6co+jXFD
         zntaiLyr57lGe7LHb2R3jCEySQKRWJpcvHOormROHR1VQ+pxaSrOpEgAdLAkcuSr6Kx1
         vL5/n9sTZByyroDFCqE4uJOQT6Zmmgt7Su/TIvUyRVgVGgQf9Z0d8akKNR0vg/bfFmk6
         Gz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787296348; x=1787901148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TnFsJCxkFM/wIQ0nrP+EeILR/FRzepb2V/4lDFq/FBo=;
        b=qNymwdCA2rHX1fb7VoMc6o9bQvjHhX6Z1pY8OZSXswLeCLi/FtQMYaMYPj5gMiCPlf
         T9LIyWurwvPteJwxayuCjZKJ45RdkrE0Znz0lj34HkFabM75n2N+N1pxjsCzgLtjOKj3
         de5T+bTK/sUztfP3/zNzPH1YGw2EWRrIiKkqQZp9EyVp64vTZDZHlqQosR9+kCvbeNGR
         QFWdvPK4tKL26cl5SEB/CHkL8RbdddPNITEPRD/xaMs54fmECkDG58fp1OsZ5R9mlAvo
         OaxENjadS1z6mytGyOPWnY2qlwz0NdD+BJzrLy+ZHVhfHKd4/DY/hBqLnsM0GdKh7nVJ
         grxw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1k+33VGyWJoA1wJy2XnFrpoz2nplCfpX3L7GMOADPBenRNK7ZRE9N0T5561RcC9jG5t3IdmEaLDnphQ==@vger.kernel.org
X-Gm-Message-State: AFuF++knG1qzeWDnrzxrNG1oCiwechEjT8U2o//cP3vhCzGMOdr4WXDz
	sb/n6clIbQWaWsWib5//KQpEkDN6IDdhoqrS5uezSBkKWd5MqdyePIYQopIbExL2G54=
X-Gm-Gg: AR+sD129k+aM6Qz7JOakgGiLNf3T52gSKeVOOfEB0EfO8ErbEXTgKhkwZDHeV3sePVQ
	hWdlQjKXx4h30GxkFq/43lEnlzcfLUIHXdx2dgfQ2vM6QrHJhsPazQn3oAKZraD5hRkMraYv/M4
	IDMCd4u5KmKThSxyAIS/ufW6KYJ+Z5rPgYr0o0C+88HJXu2t3QURiU7Ut0Yzz2sY15wWa8T97FQ
	uQh5U6E98/BeAd4N6WeQMsIH0tnTPyFIYxT30vBvxPNpCEIqJwbJKZU8KENh0Nni8Nf7GnYS/nL
	jedcm8gaR7j/spNXVdJpSmFnaUwnbrwfB3nwala/RVejlsH6cWxRfROgkawpMtfi4S8wb162WUf
	nZ9HVFQDFFjYhZvI+PFE18wdxFCRZic43QdpU7BV668pK6hhIcmXE1K/p2hNkgFcpDUmfBdNVOD
	IKv8ccur6MVdlV9tTyjYxFLn7JkNp+9h8JMl5rGMwHVbm0tkzars+y4CyxcQRewQkITo/IiZm2b
	bk0YHWW9BhGmuzHT3rbaeVXCXQtkV3Vl6F8K8RsF/g=
X-Received: by 2002:a17:906:6a25:b0:c16:12ff:dc8d with SMTP id a640c23a62f3a-c246a69a22fmr393921866b.14.1787296348403;
        Fri, 21 Aug 2026 00:12:28 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589e04b5sm339431866b.5.2026.08.21.00.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:12:28 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 21 Aug 2026 09:12:19 +0200
Subject: [PATCH 2/3] Input: himax_hx83112b - Add HX83112A support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-fp4-hx83112a-v1-2-474941bd8860@fairphone.com>
References: <20260821-fp4-hx83112a-v1-0-474941bd8860@fairphone.com>
In-Reply-To: <20260821-fp4-hx83112a-v1-0-474941bd8860@fairphone.com>
To: Job Noorman <job@noorman.info>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787296346; l=3188;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=fiy4GcFZdsC9yxetlH5+plrNHl5cqFDQooXiediiUNk=;
 b=7WvOSkB+YtikXSJZsjpEaaIeJ0pySPNkReYF4txiBimvkVap6UafneVGgaHcvM8K6ID8XIcbf
 M/ujWmt7PrHB6ANQxRMzVAZd3fHvWIZrngnt2rc6gx7b00XtZ+dFBca
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

The HX83112A touch controller works nearly identical to other supported
chips, we just need a small dance before we can start using the
touchscreen.

For that a new 'init' callback is introduced to facilitate that.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/input/touchscreen/himax_hx83112b.c | 46 ++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
index 0aa67dfacbad..cc8b904d88e6 100644
--- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -62,6 +62,7 @@ struct himax_ts_data;
 struct himax_chip {
 	u32 id;
 	int (*check_id)(struct himax_ts_data *ts);
+	int (*init)(struct himax_ts_data *ts);
 	int (*read_events)(struct himax_ts_data *ts, struct himax_event *event,
 			   size_t length);
 };
@@ -364,6 +365,12 @@ static int himax_probe(struct i2c_client *client)
 			return error;
 	}
 
+	if (ts->chip->init) {
+		error = ts->chip->init(ts);
+		if (error)
+			return error;
+	}
+
 	error = himax_input_register(ts);
 	if (error)
 		return error;
@@ -395,10 +402,47 @@ static int himax_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(himax_pm_ops, himax_suspend, himax_resume);
 
+static int hx83112a_init(struct himax_ts_data *ts)
+{
+	int error;
+	u32 buf[2];
+
+	/*
+	 * By default, the chip boots into safe mode. We clear the FW ISR
+	 * register and perform a second hardware reset to boot normally.
+	 */
+	buf[0] = 0x9000005c;
+	buf[1] = 0x00000000;
+	error = regmap_bulk_write(ts->regmap, HIMAX_AHB_ADDR_BYTE_0, buf, 2);
+	if (error)
+		return error;
+
+	himax_reset(ts);
+
+	/* Give the MCU time to reload firmware */
+	msleep(100);
+
+	/* Enable the touch algorithm */
+	buf[0] = 0x1000748c;
+	buf[1] = 0xa55aa55a;
+	error = regmap_bulk_write(ts->regmap, HIMAX_AHB_ADDR_BYTE_0, buf, 2);
+	if (error)
+		return error;
+
+	return 0;
+}
+
 static const struct himax_chip hx83100a_chip = {
 	.read_events = hx83100a_read_events,
 };
 
+static const struct himax_chip hx83112a_chip = {
+	.id = 0x83112a,
+	.check_id = himax_check_product_id,
+	.init = hx83112a_init,
+	.read_events = himax_read_events,
+};
+
 static const struct himax_chip hx83112b_chip = {
 	.id = 0x83112b,
 	.check_id = himax_check_product_id,
@@ -407,6 +451,7 @@ static const struct himax_chip hx83112b_chip = {
 
 static const struct i2c_device_id himax_ts_id[] = {
 	{ .name = "hx83100a", .driver_data = (kernel_ulong_t)&hx83100a_chip },
+	{ .name = "hx83112a", .driver_data = (kernel_ulong_t)&hx83112a_chip },
 	{ .name = "hx83112b", .driver_data = (kernel_ulong_t)&hx83112b_chip },
 	{ /* sentinel */ }
 };
@@ -415,6 +460,7 @@ MODULE_DEVICE_TABLE(i2c, himax_ts_id);
 #ifdef CONFIG_OF
 static const struct of_device_id himax_of_match[] = {
 	{ .compatible = "himax,hx83100a", .data = &hx83100a_chip },
+	{ .compatible = "himax,hx83112a", .data = &hx83112a_chip },
 	{ .compatible = "himax,hx83112b", .data = &hx83112b_chip },
 	{ /* sentinel */ }
 };

-- 
2.55.0

