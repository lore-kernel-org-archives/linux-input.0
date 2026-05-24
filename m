Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51122068D
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650507; cv=none; b=qM/W7NcGO3cGvcQW8HDfOFxCBA8vnfHJXhl3O5hqJDqPtUQ3Qa2hN2cZqxQAVFOR1ZMcO1NHpHxBfUIikCUUp5Q01zY9LMmoK2fvvFyUL9nPiBPAjKlmVpeqMTduxFkirQnq5kMQk69AbcL6KCjwrJML2Ie/5s5a1278CiQ/Hm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650507; c=relaxed/simple;
	bh=L3ovo+6Ro+nBzEezvu+E5fV6IUvO9DTQS8RV+KRwOlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYxcCjUr3AtItJ2TeTp7KvUvZEO5gYj43uFNZWe8R8prwLahQbjVngWG3lkltYqTZhAR5zg4GOPtq8HwtQn4PGaBCFec8LdP9eSWniQotH+QvPnWnLJ12IBsNXJdFg+QrDWPuC22tQl/hwZEiQwCz5pc3czu7e0pMd5NfkSijR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7OUMpf1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7OUMpf1"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-835b78c3797so3863681b3a.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650505; x=1780255305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVYsCz7J/uOD6Q014m35hqnUDvr2fi6eWsdHVw2C0Nc=;
        b=h7OUMpf1uS7Wmn87Ii0PSJoorfeMjWCbY58w0d9ozyaYg0+LiUiSi9rqEijBvwfskv
         /ZO4B3B9z/guzoma/T+PAutLD/14vCBsrXfKhsuVKfuBeMG+eHRp0e8SKjLRCZpbpvBd
         hNYPJ+2HOlbDa14KGWKzWnQyZojImrsOWtR8voLxv/PsTIKD2LfWF8ymGXYOr4Q4GTDw
         oBg3ey2TGV8l3SxeGE7dX7O+a5gRmCNs04aHPaySb9eXXgwJWTsePfMt6ei9uPES/m1g
         Iz3R9rpcxELh9Y72Zc3SxCSn5rKYzlUVgfD2AGpPzpdu8z6B81jcUIbhyHkA3ICbk9HK
         PAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650505; x=1780255305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AVYsCz7J/uOD6Q014m35hqnUDvr2fi6eWsdHVw2C0Nc=;
        b=NEzJaMN6lv8sBeYVVT0i6CGv1HNkMQtXnEkzjICU6bbXD9JFNwR4zXGY8Z9Juf4zkO
         QJ05IJXPmJBgj9cYfuvJ0pcLj+UJCPlpRp7aFYJ4l6a8e8KHV45fkMgRThTdz1O2DKV4
         QeYYh/HmlIrU7Rhi8zS91hKaa0JVMEn9THqc06zj5ODN8z1wWaU6uzrT7s4NtyImPpzp
         vhWMK3u9nxsbNlkyB7UI/iOnU9CVboSaHDCs1IdJu2xoLefDa4qekIXkYOlQoHtZqGs0
         fp/wrtaq8WMlHHuPy2mixJJyuK1m4fpjSb0Sjy+x2kkc04Fj7JMJyzz3ZMYQoe9IElTg
         /+iA==
X-Forwarded-Encrypted: i=1; AFNElJ/TYWdO10bPWkKA5EWC8hJR+9kXCUbYK2uYeCvRI/Jwu6Yb6RAOiZy+nD9IwpgKhNbgJEa+mf6RXEhVMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUDmbWqw/mbKMgcwvtttohEKDJz6fDYevY4XGhCMcdnbBcliB
	n6lzoMuMqst5Gc7CLqwW92FwLGMp0Qg6S8d+eXg2facsfSdUyyBIOB1P
X-Gm-Gg: Acq92OHbA9NJNQGBb04Hx6vvBivXGMFDsoTZehkUB+w8XTOeM3A3dE9AGjCAtdL/32g
	3HDf6qqdXCLZ5yy5HaU/w29AawZlqpvowUlz/VV0fknY622zTSXJ6N3wJ7LnOvBO3VZ5kHZ9FQR
	kHSsNpXTQon8JzbFovOzR7oZ5fX5+2YTq6OXgonpavExAMhCZYcqCwHDsK9Q5qvID1U/4fZWCpy
	zJYJ1gDVbKyktZXu3sQ3UAMa+c3ZA7+rX0+ITs09hbiVwwvSx4UJAQ9fW/647jEXWSif/vp+7nz
	OVdfjzZ5yYu+aIfWyD9EDmMK1e0akVYSOosr1N7UmWv7BGifujE/+lQ8yS573/KlnaVt6RHGohT
	wpCxY5S6VP1Z7NnkJpsWJ6V1R0QygUvulgwgjR+fDTSVdDMK50o7leh5JfCnyto/DG/JTi+i4GM
	+7DuNxQW0TC20PlBLC2H2s/or04vggfPopoep4GtiIjuQw7gVAC1k7hEoK2zI=
X-Received: by 2002:a05:6a00:9092:b0:82f:38:a5b2 with SMTP id d2e1a72fcca58-8415f3640c8mr10712096b3a.40.1779650505434;
        Sun, 24 May 2026 12:21:45 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:44 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/36] iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:30 +0530
Message-Id: <20260524192059.1193716-8-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192059.1193716-1-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4a11e4555099..20563d8efaf6 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -176,7 +176,7 @@ static const struct iio_info dev_rot_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -209,7 +209,7 @@ static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -240,7 +240,7 @@ static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int dev_rot_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				struct dev_rot_state *st)
 {
 	int ret;
-- 
2.34.1

