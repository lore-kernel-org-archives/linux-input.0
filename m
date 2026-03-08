Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE92949E0
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934308; cv=none; b=aEgAio7kqCEn+WkBEp36D2hc/cFoLClSqtwjHvigKly6LDn2dQjdPgqlXnClXEF9ipLFX1xIjsi/jD40oRfvnN0gaLc4hu11G/qoIy9v6aBhwgghHZpXC2T/muIIChPE84N8r6HUFE9hrVmR3xef90uKuQcVYEOcUYgfs4DEJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934308; c=relaxed/simple;
	bh=KGGRE2l5CPjgVQf6RrPuOXOkhsx986TzL2/v8BKzEhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YW7aYtXurCBjm+uN95pYfRgG4/8Bqkwd54r0vGTW37XyiQrPZX7pw0JwOyUmkZg2tixRYTE3vFmE5J2XEqxoPMq2sq6eMRvG5/QajXE3c0rn2HtNcNwWOV9z0p/esK2oLvXRNdGPNh2TU/kPZh4zpGiK+JS4GvFNtw5kjJOS7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=avbRg2Nb; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="avbRg2Nb"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-46702742c99so13842b6e.3
        for <linux-input@vger.kernel.org>; Sat, 07 Mar 2026 17:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772934306; x=1773539106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+TAeqDEeBH+L0ImN7q+ZuCaBBTUct7hL3W/vdGYMsM=;
        b=avbRg2NbpEQmJDI0V9ij0HawrzKvT4eoiZuKVpFqHUpq+lch2jo+Lr6SPPhHu4v9Jd
         5ktfHxm+ssFg0TTkcshRErbhW3qxF47sIxJsBKhuPpb/sdl4By35pBiUAYdIYXfhkZ5w
         /SHq/VhltBvT9gD/amEl3TPqT8PUms6edQf4Xf5PmOn8drJUA83qP2uvNhac6C9AU8n7
         fpiWlqEnahhtp1hyyR8q8vWfyBR9rhtV5zoytfqffVDNRZtfO0LDfDPV3shzp2bJXmmG
         ERlBS01aZO6udLll3MiKo7Y7wGsiiUVRnI3ybOXD71l77kmVBdGsnWo9+LkWhQaDYxhD
         cdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772934306; x=1773539106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X+TAeqDEeBH+L0ImN7q+ZuCaBBTUct7hL3W/vdGYMsM=;
        b=ncRKVfJdvRyYZf7mDMZQfaiWxraEjz6YJtctuAKE/muW/6ieDQ96H5r3PpWbp4xgM0
         rpha2+AaO26MiXdmPkf/cLRQTU7rO0vQWmnJUsD1igSPxl2VaKQxYBoUpoLM+auJ2/o7
         S3MlMvsJF22UJxgMuKbmSGHzJ+glq+ePPa3K4bClABQefbdvPtAB2YXh04TLFNuX+99N
         FNEG6ZpCG/TVfxNSwj9yPnOBrz7vYk5QYdlw1Ln/IwNgwUjX8O8vOOlgzlS6jM459gY3
         KNBgrcAx9gQ0qvWQ0gMSi74WsZ7+makDeynXxbGWos9QDSDbpVBuGAXK5uoI04RfGFBe
         DDSA==
X-Forwarded-Encrypted: i=1; AJvYcCVMJ9qwW2jioB81aanLYbN/EO25oLh/yzkAKSQgFUboeJ7VMMl5Sd+Bcnt2SPXxfKwz5pJ7cKcJzcGfQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ITYrB3NtfNco0RuxXUrOk+BcUwmjKJs/EPgvyIAF7FKVVsyg
	KxHde3jtAwcrkaUJMHX/L7vs8BhbZ97MakV4oWYxy+nBVSxYywY0PFppRGknrnHZ/8g=
X-Gm-Gg: ATEYQzxFPCXFO3d71X3IETaKj89WzVNxJqo0tm9LPDg/+NkfBgvFJBGUy8O5W4qz49V
	r1e2q4BQLcIJuq86luFFSFYDxMwsEY9tP4Hfrm09KxG6JbDhrMAmlTia/mmUS5b5bseUK4AbWkX
	4Fe6s/Lo4TlO1jbjD2fjkq5qWGgihVvYLJ3vx2slBXoKhOx5GEVipq9txnzbguLIb3olroaeUOO
	Y9Z6RtLUZTv+cZaGkBhV5n81HvSEpoH0R0d5y8cUKKhymFYDNvj2UxPEDUIDGUnYwV6bwsgJ01N
	KcM/N8ssP60nZQzxe3XJgFPYNyySyJiy5+b6ibqr31qGka5KEcUZ32AnfIUnXPYdWxJLgQ65C7A
	ZZjPuShWyUaUn846bbr5cDKwjEl8fJAuMNjzMO6W/B1FZtHfpfWHlOmDVxFu19tjRgf/yNE90/K
	wTha2pTHIX7BCVoIDThSkT/f2Awpnh
X-Received: by 2002:a05:6808:3a0f:b0:463:ae2a:ebec with SMTP id 5614622812f47-466dca4883emr4113475b6e.22.1772934306280;
        Sat, 07 Mar 2026 17:45:06 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a7b4:e550:6d81:e067])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm3244357b6e.13.2026.03.07.17.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 17:45:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 07 Mar 2026 19:44:12 -0600
Subject: [PATCH v2 4/5] iio: buffer: ensure repeat alignment is a power of
 two
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-iio-fix-timestamp-alignment-v2-4-d1d48fbadbbf@baylibre.com>
References: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
In-Reply-To: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, Francesco Lavra <flavra@baylibre.com>, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KGGRE2l5CPjgVQf6RrPuOXOkhsx986TzL2/v8BKzEhs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBprNSI+w5dXqe1KCxUBkRwVln7cnSQ30EL5CJJI
 YxY1TzRbAGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaazUiAAKCRDCzCAB/wGP
 wH4hB/90QpXGpaE2wP8nKyQz/wOwnUDGw6z5fgcxEBtazFY2zIWfUwisWjYYQyu35pJtx7Bw898
 MUdE8yz3wQ77dhAL2cy36rCPInbcWktvIe4w94jnvzzBFvT5FeCOpNFvS3GJQpS6HY6qDb7iCbN
 wmjgCQnTJAUE8qtrYaevWBFMMiolx6JbQjwrj41/iORpBDwUB7Yp+Lju9zdTDbawi/auffhnbTE
 DmMScQWs9neU662/sMmXpqtR+mP/+KgiYW3BErGnzZnS4K40utpHfLTAnCTC1B5FMsK4E8oL0ij
 WzlyxVFeZoTLI3RgRk7Jeq1SKRruGvY/HGwqysIJQTUtq+uI
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use roundup_pow_of_two() in the calculation of iio_storage_bytes_for_si()
when scan_type->repeat > 1 to ensure that the size is a power of two.
storagebits is always going to be a power of two bytes, so we only need
to apply this to the repeat factor. The storage size is also used for
alignment, and we want to ensure that all alignments are a power of two.

The only repeat in use in the kernel currently is for quaternions, which
have a repeat of 4, so this does not change the result for existing
users.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes: new patch

In v1, Nuno made the point that if the size isn't a power of two, then
the alignment won't be a power of two either. And this could cause
unexpected problems regarding alignment in general.

This will affect the work Francesco is doing with IIO_MOD_QUATERNION_AXIS
which will have a repeat of 3, so this is a good time to think about this.
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index ecfe0c9740e2..c38da24561c0 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -748,7 +748,7 @@ static int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 	bytes = scan_type->storagebits / 8;
 
 	if (scan_type->repeat > 1)
-		bytes *= scan_type->repeat;
+		bytes *= roundup_pow_of_two(scan_type->repeat);
 
 	return bytes;
 }

-- 
2.43.0

