Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAE1D5CFB
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771102852; cv=none; b=I0az/eV2zZpm9vHdrk9m8NTClwyqbE+YTFsPImEgHY8p0ewwOnirnKoY04wZdz7c9nmlQxG5RNzlSOl+Hg8DLnC3vP8GdJfqO9rvwCIivUDxFq844o78tUC4eNvmET9XF2C+kmRjCMubeUHB7oH5Z6of4ltVR5Jlh0ricGdYmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771102852; c=relaxed/simple;
	bh=u+2d2xYoQpzSjCzCDGd+eN4qGcY38sGOKNLBYRKL+0k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k8SmGZMxWFE79v5prbXZrRkOBvKcNSmmJZ26IjrIUvJIAzz/jz0BcU8yXMUciyKBwPNk2YD50SQA36X5byoNVw1/wkCcX9RaloMP0lu1TxoB5VAWltXPsPXaM4et3GsbnLKOAewy/h+jziADS2JCoo+lN1QmEmU19y1qiLDTiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RhhSCyse; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RhhSCyse"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d4c9537f90so921648a34.0
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 13:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771102850; x=1771707650; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AJN2DmyZzxrMDaAeIHz5lzUwylyT2LQfO5U2NARR4A=;
        b=RhhSCysexifnPlVI59KRQm2JKZy+2c1LOFm87hINeuQuKpnhTlqI3w+gOgxAKA6Lw4
         UnWHX2FPuTmQ77BM3M2+1eI96MsSFhTjcUexfCYtQGDs2XjFxqIvk07z8Ne7OIelcyb/
         SNz0+ipEtEw4EZmbvEIK15SIswqosKfeIgmPpHSa/VfdnMsUxRBxSj3eX9+CJ7Jsl6jT
         sQKgc2IGdDUKJi5mVbEYu24EdHnCNF3EDAwiK0q4X7nns4djA5H+ceVq7HMmA7OEmrbR
         J4kqSsnbPNs0NYhchN//f0knQSWpSi6LlT6iC3qaz1WN/ZsgbMxc4m2W3ZdU+WbILWew
         8LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771102850; x=1771707650;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AJN2DmyZzxrMDaAeIHz5lzUwylyT2LQfO5U2NARR4A=;
        b=QfiBc34n07QyFYCMgTx0o2El55ugZwWeE6YQxYdnPGsrmq9ZLDzTj8ldfDxbGy4ueM
         GzazKbEjur59e/dtVdjQWWNL4vT4eo8Ntn+s7WEPFVU3I+zJnKJdzWj9M6Nah0hk0eVB
         nFrLuQxLKG7/xvFIef3BeH5WSMaIAFQ+dt0n5P1msU7VsLnQBoq4Gfxc11f0gkTyM97u
         uVTtCnkTfOlyuADva9Jps+sKwRhx30XYimmuyF3M+bI09q9XX7P/Wk8NgECLN9cd5c8h
         NDu8hHAdE+7zGQbr8mWz6HSu2LYDhVr7GL7KqDHSSYG0RniidELWYQGpEPvhgN5wOMcp
         atuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1DX7iBQmQes1KQS4WEYib4HC9ppccVk7x/w5UYLs68Vf4GRoEwPYViAV/EC24JCFu/hSVE38lgY70VA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5gPQ2V7uJ0hYqh2NPdMrSz6a/c061IVOzsALz3NOPZfnZUyZK
	ir3RCNNSoLDW3xcQarnOBVWTvnH5AmnW9jl4yUhuXy+ItklpVKkUdlj+5gfkii6LqMA=
X-Gm-Gg: AZuq6aLGPqC70Rl7L8Esh6AAAEmNZDZxDHCa3RG6z+P0WEYqcAnQxWyfKnjpl/s9iiB
	QiZdlj3iHA72puuZC3jIELSS18rC+PGBePXR7AlJLu29YsL2DsV315RT63QuGuXYhE6teXTxjNa
	528bbQ7U0G2yo5kOXDnPD8oouVqX4AAZZRxvRurXu6Ztl4Vu1xckDVoNvGWwwI1NBLgp6hUg6rm
	B9ka6OZWXiijB/grpI891/0CUnPSm2hBNcUJq4BecT4V/V47Rwk/NUCm7wlveHHiE1giN1PQQyF
	UmZdNyjXj6ah1sSCMkxdf6DbdN8Yclp5eRe6D5y1FEKP4aW2osEMDaOk+eQTFjNU648/TQWP0/S
	OdtPb24jhnailuFaU+B0OMedpRrvkACudYJ+H5LAaaDsRDQsVvPf9TXjLQGMb27cJHP5m3gzCvM
	1FE2mKVaiVhkRi+uwNj8Jnqu9j4w==
X-Received: by 2002:a05:6830:648a:b0:7d1:9832:4796 with SMTP id 46e09a7af769-7d4c4a785d9mr3643804a34.16.1771102849891;
        Sat, 14 Feb 2026 13:00:49 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4da074c15sm1181680a34.15.2026.02.14.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 13:00:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: orientation: hid-sensor-rotation: fix quaternion
 alignment
Date: Sat, 14 Feb 2026 15:00:19 -0600
Message-Id: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqEMBAEvyJzdiAOG0W/Ih6i2+qARkmCCOLfN
 +yxoKoeigiKSF3xUMClUQ+foSoLmlbnF7B+M5MYqY1UH1Y9eNabA064xG7Txe/wiW1jR5mMaSG
 Wcn4GZO+/7of3/QHQ6CXXagAAAA==
X-Change-ID: 20260214-iio-fix-repeat-alignment-575b2c009e25
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Lixu Zhang <lixu.zhang@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=u+2d2xYoQpzSjCzCDGd+eN4qGcY38sGOKNLBYRKL+0k=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpkOJrV6kHmSUUdM8ecaLTEyrn2jpyKfO4+Agy6
 wD5YxkOm9SJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZDiawAKCRDCzCAB/wGP
 wA3JB/0S8uXpjOHSBnUB2ezOVtqy46chqbQ4icjSU5nekObaWVgJ+ja8klq9UzsQt8iWY9Pd3y4
 u/J7qwABJnGOiA7T5tL1U2Tb+M7iok6PAUXK8BX/75TSNgOy06/NEsUPehRWeHYOdGyrSJKOXsP
 wg5We8G4gsEGFal1zFG6jjoxFjTOlQZY5ZB69/wv0fOXEGYa5B6gFYovlhaXI5qmiPFlqHPOc3x
 GpPpiqxqGKnbxj/XixWnEgN+v/nG7XCbcC4MPDjvoAXezL1IT3hZUYErBNOyZOt94Twzl+3hAkw
 doHh0gKCqMY/PIbZQsPl3KdevUU5e3Ph0LKLz77F5+o8VuZJ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The main point of this series is to fix a regression reported in
hid-sensor-rotation where the alignment of the quaternion field in the
data was inadvertently changed from 16 bytes to 8 bytes. This is an
unusually case (one of only 2 in the kernel) where the .repeat field of
struct iio_scan_type is used and we have such a requirement. (The other
case uses u16 instead of u32, so it wasn't affected.)

To make the reason for the alignment more explicit to future readers,
we introduce a new macro, IIO_DECLARE_REPEATED_ELEMENT, to declare the
array with proper allignment. This is meant to follow the pattern of
the similar IIO_DECLARE_BUFFER_WITH_TS() macro.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      iio: add IIO_DECLARE_REPEATED_ELEMENT() macro
      iio: orientation: hid-sensor-rotation: fix quaternion alignment

 drivers/iio/orientation/hid-sensor-rotation.c |  2 +-
 include/linux/iio/iio.h                       | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: 0f11bb7985ceef2aeeb5c45c3c7bfff3f5a16e03
change-id: 20260214-iio-fix-repeat-alignment-575b2c009e25

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

