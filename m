Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178923AC0DE
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748288; cv=none; b=A6d0dekmvItXEIld/NwQajOd7mrs2cctUgUxAef+xPU2GjitZ/4iO/gloUvHQrg7a5eT6Cgpc3gM5MJrs3TbWQ+SJzk0Mov3RdA/xwNCts7CBBc+/sg/L8TvXaaJpdU3/QI7JFYl/TyPnk24m1/8/+JRY694tkwPE6P81VxD8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748288; c=relaxed/simple;
	bh=2pm3Y7NlnPxbXpjl0DkMA6wQ3bmP8jqcLFQ2x99JvPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mk0NPKgZWkL0KdU2yt36Rni5AZZneDU9IUpgdxSw17dhpfYdFztCo/EmzSauvPUKFSoZHHx2s3eVRLW3LwQg8AOKS1Oye6lr1PmvfuYJtN5L+g9yIwOjV3AI2iiU5DqW5Z3Dwot6BdWhAJrJ0WjkN3njvVBtxHZGKwOvYi8Ibss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHOm3Cof; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHOm3Cof"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84234c83142so1156954b3a.1
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748286; x=1781353086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV97g0zZ+JRJuuxqClWQhzVj4nB+SyGRfwtZkITJgtw=;
        b=gHOm3CofG8401ccVX/EwyOz6YrbffheXVFrsFhDfdVhIL+IBGLEWXYcK7txATodiG0
         Gsh0+JloCRqCrH3NMBLd4+5UlcVZ8d8s3ZzLfF00ACdo312a92vS1RxGgXhzKQv6M8it
         IBTMWQe73DNWeDOvmnWzqnzqHVWwd8Hq5SH325/gBoFop/fke9gT6gl78ozoOt5A8BbW
         vXV9oeFvF82sND7cQ6QZEL+B06zt93giPFs2UfYLfuTyF+H5Fet+eTS9dttQ6vfXmnUT
         qHBPDJkt6N/Jna9G0DCHJBrU3tgmM9SKEzdxQiazG2ubTBQ/4KE90WAXDpkLo5YuNQ7i
         hRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748286; x=1781353086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tV97g0zZ+JRJuuxqClWQhzVj4nB+SyGRfwtZkITJgtw=;
        b=jVlGg5SfCP+PKj0ij7YJJ4J0u5ANUOBAqZTn7Xi9VjcBxrWtbfiuyPerj59aitERBk
         cSHQAlQkqlLzTeybyBG/HecFHyDmUMPLL3xrFLfwS5+csgY11YNfl/DybIZQweK0k2ce
         dndDnf9ixPvqCEq1KKP+KMDIi1dlTzp+/OP8h95N9v8My2EqXYbHSFxwsOLi3GzT1MTz
         E3V7KVZgkjjYhhs8RFVC+zvuchxBsoz5AK/CzOV7dUqYlrpWMBiQPS66fRUKjl8JsWvj
         pLoyaR5rfAVrM6mxTicFJyeyKXC3mOqhs+wIt1O+v4Vn2iB0Quuj7qOw+KLw1e3nQ/LM
         751A==
X-Gm-Message-State: AOJu0YyWVgpkSOd8FtMPjOGXZuObLVoKAWOWnDrpVq9kv40CLzQf+Xot
	V0iXQHxVehMeobZuDrEVyGo8kkfpMGYB79jc09fvAzuhXSiAZ62jsDAA
X-Gm-Gg: Acq92OFjMj3Z7iVM6EFDrNnj1U0ArwUhoXhaOMgvGFtuB1iHau7hiIAcMmQNye1vBTZ
	csEokbRtdUznLe8d4HmZ8DlktvdZQOHbqd7ueXmn66lTIz3kehqB2fGjbwWklOt1I0JEClRtac+
	SrZVWGnYKEb26c7jk+42dRr6A9pCRdVJAHepxshBjPnu8jsidvcmH194nVqOC0Skvl4cKUMDaRZ
	CVITp99hYhEsG9MnC87/zcSlvZ5VMizpBVIRW8Cmm57f1QfKObJh7/uOm2769t4CysK86GKlYJA
	N849FC2mBsbpqqcmpuGZgibAqUZHojCSUOKL2LCWButbSgCszXkFYl2C48BKqm9v/GR0bcnLqk7
	XTP1HQ4l1D1qeVSH1AbiZeKMJpjDbKu8xP2+CgEQa/4tB7QXSwaV6fqpm6K1nDig9BKqYPFlYrQ
	Lu6dsQmwhb83AlEo8/T7JlzGWdC5qfZh3UpfuOdNgbwegLQG86G5viieiI6GA=
X-Received: by 2002:a05:6a00:3692:b0:842:5da3:9b84 with SMTP id d2e1a72fcca58-842b0fb2843mr7916192b3a.34.1780748286314;
        Sat, 06 Jun 2026 05:18:06 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:18:05 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:47:44 +0530
Subject: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index d72e260b8266..ae2fda8dc500 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -241,7 +241,7 @@ static const struct iio_info als_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int als_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -263,7 +263,7 @@ static int als_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -305,7 +305,7 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int als_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				struct als_state *st)
 {
 	struct iio_chan_spec *channels;

-- 
2.34.1

