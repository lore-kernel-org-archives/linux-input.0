Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794921988;
	b=c6iInFHa2S0gTA7k/n4v9Lkrkqnxi/oEobRXMmaek1apd+OD4icN5L0WzHk1nGwhKxIq
	 cKngXVQqI08caYcqn9NJ13PH2l3mK8xZRsnBzDaw+na7aq2GxeJS8prc6u8HOJ2VAo6bm
	 JlCv4RrLI8PPBUCokpgI7UzL9d79XBgYw5//3MOTsut3JL29OqK6CYDqvfxNa0pZrp3O7
	 nXXzCdZnxZgtiMcfX/WNXu/BnPOKht3nDjHFm8qG5vcuN2FaUOJDhiQSAbPxgZuTQaOxi
	 0TxMetqvTxftnq9rDpQrvSKamSj9397awRm5421I3JeOurSOfl2YpCqINFpjWpdBA0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921988;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=ivwsWDpMxt3u9ZDGitRO0hmUHFO149xyZsPbyhGqEts=;
	b=HQxapE75Nn1b8HTZvMRauca296qL+TodEsyXjqUBjtNwjd5hJSLsvJ4kiLxLxjDVTuKF
	 sY5Q6OiiwL2xdyZ30NbR3uyK1vzlkZIlWNZ0NsLimnArcn10glBcqkcs0f64C+el1tsrT
	 PaEJecFq/4ReLBvDcetu1ncAtB4xBWAQ0XdcjbaR/2pGxyHI/e0Ft5cAzkreHVDMT8AHj
	 CKY4jdFDsiDxtxUl51MlQsjxZlFcZ9H0yjRNWfkF8FaJLzAr+l9Iv8veHt8QCB7omcEXy
	 ZQY/WlEUgatIsbfnNlVDYVD/+vPcHO47v/i/T/jOGLxGyBQ6YcaEpEcVPoatgIQzGGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=ommer.net;
	spf=fail smtp.mailfrom=ommer.net;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=F3OOwJKN;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=RZJf5Ybt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55B606A33D;
	Tue, 17 Nov 2026 13:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED55B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ommer.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ommer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ommer.net header.i=@ommer.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=F3OOwJKN;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=RZJf5Ybt
ARC-Seal: i=1; a=rsa-sha256; t=1794921985; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZIe0ra2Wq44Q5qNARxBT3IcX0HGWyKI32ugq2A22YZV9NfqXyR0iQFHW1u85NcAJiS
    1UaMBsvGv+ZpcswMSQmO1N71+vNkRi5+l9qIBNb8Nm5bSqLKyfxR/3XRg8z8zUbctq7J
    ig6n0ncuKYOwpoIKmoy6CDs5vNJYGFaRaSq1l1gdMHmeoZqr34vCCbEtfDCduN+eGdme
    hJEggnMQ4x/3QqvLWS6jwN9Qrbih7SeEesAMEU3708IV2OCf49ypaR3R/dDJj/Ji0y4X
    zSdtzl9x1a+vt3hucFexeDmAWRHxPqTWzVpP0BOJF6K7u6/Kwk4DAtKJfxEpAtqjgJZ6
    t1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794921985;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ivwsWDpMxt3u9ZDGitRO0hmUHFO149xyZsPbyhGqEts=;
    b=U8WNwSWMnfgdNNvDSpLvzFqVLaqrJXQBojWOm1XFxZlFh41EpXyHqUBfTY5ZRad97f
    wtJkEzZ/+94H5Zl6zZF/MplztiaPTCY0RHHepmGHJOTXnKhRZ1n/CNZIBoGZGzY42326
    TTraxl/1yvTA1oFjt76gF85WiGVftHaRKL2pwvBiPxdJq/pxevwQIfFe2hOchcigURQb
    7PXnVcJqCgyFkoaD3KEVaxC5GcXmxuOyoEiQ+aV74FXJbGxdbrEGZt2AGYpSbl4qD3uY
    OLTksZIz1NZRCWOM5+HxDq1me3HchXzyfqYw84190i6Adkkg33bGDu0EsqYoSvKHNoA1
    hDXA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794921985;
    s=strato-dkim-0002; d=ommer.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ivwsWDpMxt3u9ZDGitRO0hmUHFO149xyZsPbyhGqEts=;
    b=F3OOwJKNcCfnIP3P7uRD1Oyx5lK1OaLx1yiOYqpJsvGYW9zq+D/GrApd9rABL8W4dd
    0CFlATPYuLvdjiDnw1LWLIHX20yzJ+gMnFtIzfHovE9XR9W3zcI58oHE5CmRv3g1po7c
    DIK+C44lEfy+FIaZGVz3MY1EobqNcS5JSitT3ye7smvOzApU1vuagk6CAKjxzjXIuzU4
    6zY+xtcBDuRY8qLThAq7+FiSpFB7cmOavX8CeJkMGqFKJddYQt9vKIy8yN/JTysik34s
    skWZMjjVSzQuLNMsqxrqrKD86W/cArADgkmki85EFcasgT+IF1N7egaj8jnPfFgi10c/
    UyIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794921985;
    s=strato-dkim-0003; d=ommer.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ivwsWDpMxt3u9ZDGitRO0hmUHFO149xyZsPbyhGqEts=;
    b=RZJf5YbtWuvyBkNUpiJNInAbkgSHKg3G1wNjDiBWV1bX5CrbQcSzjnVM/lnXcbS0/Z
    oy0CaJnmtC4LV56foMAA==
X-RZG-AUTH: ":JGkKZ0mIdPJLfj3rk5MOrv6kH/tvwFubxUqMvsWOyVXJkOABZnPqvKUstHY8FQgnq3rT6NoXCyjULwIut1Tf8meVypGj6A=="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id n2f42d2AHDQOvuW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 14:26:24 +0100 (CET)
From: Henri Ommer <henri@ommer.net>
To: job@noorman.info,
	dmitry.torokhov@gmail.com
Cc: phone-devel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henri Ommer <henri@ommer.net>
Subject: [PATCH v2 2/3] input: himax_hx83112b: Add hx83102d support
Date: Tue, 17 Nov 2026 14:26:22 +0100
Message-ID: <20261117132622.12178-1-henri@ommer.net>
X-Mailer: git-send-email 2.56.0
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
Content-Type: text/plain; charset="us-ascii"

The core functionality of the hx83102d is software-compatible with the hx83112b. As with the hx83112b, firmware flashing is unimplemented.

Tested on: Samsung Galaxy A20e (SM-A202F)

Signed-off-by: Henri Ommer <henri@ommer.net>
---
 drivers/input/touchscreen/himax_hx83112b.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
index 3521b05d509f..4bd52c1e8f4a 100644
--- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -7,6 +7,9 @@
  * HX83100A support
  * Copyright (C) 2024 Felix Kaechele <felix@kaechele.ca>
  *
+ * HX83102D support
+ * Copyright (C) 2026 Henri Ommer <henri@ommer.net>
+ *
  * This code is based on "Himax Android Driver Sample Code for QCT platform":
  *
  * Copyright (C) 2017 Himax Corporation.
@@ -407,6 +410,12 @@ static const struct himax_chip hx83100a_chip = {
 	.read_events = hx83100a_read_events,
 };
 
+static const struct himax_chip hx83102d_chip = {
+	.id = 0x83102d,
+	.check_id = himax_check_product_id,
+	.read_events = himax_read_events,
+};
+
 static const struct himax_chip hx83112b_chip = {
 	.id = 0x83112b,
 	.check_id = himax_check_product_id,
@@ -415,6 +424,7 @@ static const struct himax_chip hx83112b_chip = {
 
 static const struct i2c_device_id himax_ts_id[] = {
 	{ .name = "hx83100a", .driver_data = (kernel_ulong_t)&hx83100a_chip },
+	{ .name = "hx83102d", .driver_data = (kernel_ulong_t)&hx83102d_chip },
 	{ .name = "hx83112b", .driver_data = (kernel_ulong_t)&hx83112b_chip },
 	{ /* sentinel */ }
 };
@@ -423,6 +433,7 @@ MODULE_DEVICE_TABLE(i2c, himax_ts_id);
 #ifdef CONFIG_OF
 static const struct of_device_id himax_of_match[] = {
 	{ .compatible = "himax,hx83100a", .data = &hx83100a_chip },
+	{ .compatible = "himax,hx83102d", .data = &hx83102d_chip },
 	{ .compatible = "himax,hx83112b", .data = &hx83112b_chip },
 	{ /* sentinel */ }
 };
-- 
2.56.0

