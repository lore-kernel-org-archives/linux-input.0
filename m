Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E7283FD8
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934304; cv=none; b=D+BCSadrX/X9wsBLaX5Lq4cSj3+hPoJUI+sAY71Nb56frbK61BGXwnyIOZ0wM3qJIaICiPMIx34Hzd7Gt25IlCEpN9Nev8iWiIHWprK7fLtGQq7/mKGhYrgK8kdwRS8A8cFyZoMlB/EqBSRFsZKimFQuBGVrlR5x+VvLBSxRc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934304; c=relaxed/simple;
	bh=HHzlMBc13MMwF6toEFotAoexdJQCCcdOvX6xGB6CV3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVke4ShdVpMc+3yVfvbLYy1cF4IUGgdLjoR+I9ITSBYp3cXPcO4K7ueDY+Koc0kwtDabZWJVlIVvSzzWU83Dd+BSdLxMu5NGgFEdRec4ilXBGlBQJAcQVSDAzvUg4M5M2J0jwPhFSEYFHIUHNh3hgOg+uyFfQbIRvOyivDSSEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FoU6KoWh; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FoU6KoWh"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-466f1c3c627so457215b6e.1
        for <linux-input@vger.kernel.org>; Sat, 07 Mar 2026 17:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772934302; x=1773539102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGxgpavVCm5ubQX5YkJ9mR4ETgfWkKx58BqM6JjVDbU=;
        b=FoU6KoWhFvLpN1kV8ueZP+anb14cUPaMjiZnHlq2Q60VJT4K6PqkHaN65TnUJQ9H1S
         tkdhAeCcq+KFhhw+D5MrPViXlgBZLVCZdJ6SDD8ZhaggaRhEjKpKEP/haF0gN+SNz0fS
         5a5opuSbEL4OOp9uu1qjDD1k0W1249vPBh8ew/6fatO+QVRU6qzKYN34z/8bxZH+bl7B
         VsluMJ8dAil58jPFstoYJcSeL7RHP+N8gHbm7Qb2y4apmenYyubKFRdOyL3s3rmkVRP5
         sQscTgR1iebnPdkj7EzK2xDoxUCYrUFxhEfRUoQzsMxrM/7/FHcXZNGSG4XsyUIVajJ4
         vlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772934302; x=1773539102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jGxgpavVCm5ubQX5YkJ9mR4ETgfWkKx58BqM6JjVDbU=;
        b=PAhbpO0eMUfOGcqP+74hqDzwoo0tM98Jf04v+Ugxzqy9jFGSQRoecfwZdNXZZuAW/0
         /NH39ttQGlZ3hcwUXCyOG+4z1PcqttKny+VDEfyJ7AqT33BmM9mko62xO+AnCevIc/Pw
         GzG1gISBvaQAAuTQ40cimZfoEd7rNje3JSOeSgohiEyqrI7dSrn4ZbyxROqs86B7Y/5K
         r1gei4tYN1bFOz8qNb3cIqoGy0VYjp3GF59wFQOjIF8XVD9wu6QyhKxYPxv32U9ZozVT
         KVDBzsW+gzOIE7fp7RqvT/rl5jGdyYNcQgOeKH2iHZj5FQjpOSkspSJT/XwDzSKr2hHf
         wiLw==
X-Forwarded-Encrypted: i=1; AJvYcCWzV+rHSNxh+sywQ6Ylex5ciGJsS6826HTgPL88evkpw6LnYluuDmbxo43u48/Vkdjo7P7ZS2YveqV1fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4OkIhogG80Pmeu0HUB7bVp97mbcou8JywqthtEgE8NH9xzv/J
	0LueGJJ1rX1/4CUpNIClSx5fyY/1mJfufUYMyh0hIEev7cTIxV7d7Zi/F2KXhcfEHjU=
X-Gm-Gg: ATEYQzzWKf1s3QqskiIBryCfQM0jpI6zgLDnL0BFfX/CKoTaRhP5f8gpLRXpIdYep42
	2TEUuI7LPjzk2RPgir/DFCS9Osm5ntvUtH4EG2jDgZDzlpKgxQfHEzZo0bX1DlqoTZJ17Zy3EvC
	HtTchq03FtGkixGrZcmB+jnVNxdYT31BEmIxRA6/UW7nOhUpx8Yn0LOa9Tuwx8zEyZfDXcrniou
	wpAL/bMacF3B6ueolel52ZQcxD4DM3/mYuk9YVueiBv1Cy/Gx/TJjbm2g6aLmk+Q+CRLMW7goY2
	gVFv6Xd5we3jnJ8NruNK/bourJ0bLtugP331MZqshFpFrMfHAJEtsIqbwXwkDKVhSFPw2avFfcX
	xfdiLvkZrLvGg810eJZ49GWeV85sfytxfBAlTY3P5bTT2bt5rdr0x56UwrqG2UFjlh3wOUdT45W
	aVFvL3eZy9P7L5g4RB0Gn+JCL5Iw0K/46/HbAglO8=
X-Received: by 2002:a05:6808:2445:b0:450:3e60:fb47 with SMTP id 5614622812f47-466dcbd1f97mr4102020b6e.60.1772934302213;
        Sat, 07 Mar 2026 17:45:02 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a7b4:e550:6d81:e067])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm3244357b6e.13.2026.03.07.17.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 17:45:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 07 Mar 2026 19:44:10 -0600
Subject: [PATCH v2 2/5] iio: buffer: check return value of
 iio_compute_scan_bytes()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-iio-fix-timestamp-alignment-v2-2-d1d48fbadbbf@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3313; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HHzlMBc13MMwF6toEFotAoexdJQCCcdOvX6xGB6CV3Y=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBprNR7b767suN6jIKEqDrRz3nX7EsZpiKJ6DtLp
 WwYVCLT/LCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaazUewAKCRDCzCAB/wGP
 wHz8B/404pwOs/Vt3dvW9KS8BQtWuQsOAsPEw79yoNxkAp1XprMgmWvc+HDTabcL6WVP+6xakIm
 XksXkmHCZh+1FuydrDCHGDvsG9q9YEcGpeB/FTZywede0OYd02ATP/jONq9PfDXvHh7oO9pViEA
 z/xEVl7INOOIyfM0dHbj+5s+mCldMSfkLbLIDFbNDsq13Q4ZRcxWllg03KLLPmdzRU2K0rd5Bbr
 1N0O+VN/Nepd+ixC3Ue7HH+EGlXdStU9x+7U3bLTV9/2BQ3lWhdUjzuIyJMi/rWhIrbcVzTI6MV
 GHn5YkrE1NrT6wMc7IgxCcMSjI63qqlD+VvDHXs92U42DG4k
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Check return value of iio_compute_scan_bytes() as it can return an
error.

The result is moved to an output parameter while we are touching this
as we will need to add a second output parameter in a later change.

The return type of iio_buffer_update_bytes_per_datum() also had to be
changed to propagate the error.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f15a180dc49e..4e413b4bb073 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -762,7 +762,8 @@ static int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
 }
 
 static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
-				  const unsigned long *mask, bool timestamp)
+				  const unsigned long *mask, bool timestamp,
+				  unsigned int *scan_bytes)
 {
 	unsigned int bytes = 0;
 	int length, i, largest = 0;
@@ -788,8 +789,9 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 		largest = max(largest, length);
 	}
 
-	bytes = ALIGN(bytes, largest);
-	return bytes;
+	*scan_bytes = ALIGN(bytes, largest);
+
+	return 0;
 }
 
 static void iio_buffer_activate(struct iio_dev *indio_dev,
@@ -834,18 +836,23 @@ static int iio_buffer_disable(struct iio_buffer *buffer,
 	return buffer->access->disable(buffer, indio_dev);
 }
 
-static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
-					      struct iio_buffer *buffer)
+static int iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
+					     struct iio_buffer *buffer)
 {
 	unsigned int bytes;
+	int ret;
 
 	if (!buffer->access->set_bytes_per_datum)
-		return;
+		return 0;
 
-	bytes = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
-				       buffer->scan_timestamp);
+	ret = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
+				     buffer->scan_timestamp, &bytes);
+	if (ret)
+		return ret;
 
 	buffer->access->set_bytes_per_datum(buffer, bytes);
+
+	return 0;
 }
 
 static int iio_buffer_request_update(struct iio_dev *indio_dev,
@@ -853,7 +860,10 @@ static int iio_buffer_request_update(struct iio_dev *indio_dev,
 {
 	int ret;
 
-	iio_buffer_update_bytes_per_datum(indio_dev, buffer);
+	ret = iio_buffer_update_bytes_per_datum(indio_dev, buffer);
+	if (ret)
+		return ret;
+
 	if (buffer->access->request_update) {
 		ret = buffer->access->request_update(buffer);
 		if (ret) {
@@ -896,6 +906,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer;
 	bool scan_timestamp;
 	unsigned int modes;
+	int ret;
 
 	if (insert_buffer &&
 	    bitmap_empty(insert_buffer->scan_mask, masklength)) {
@@ -983,8 +994,11 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 		scan_mask = compound_mask;
 	}
 
-	config->scan_bytes = iio_compute_scan_bytes(indio_dev,
-						    scan_mask, scan_timestamp);
+	ret = iio_compute_scan_bytes(indio_dev, scan_mask, scan_timestamp,
+				     &config->scan_bytes);
+	if (ret)
+		return ret;
+
 	config->scan_mask = scan_mask;
 	config->scan_timestamp = scan_timestamp;
 

-- 
2.43.0

