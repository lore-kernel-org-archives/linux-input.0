Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C02853F3
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754745; cv=none; b=f89i2k3s79Cm2Dol3z7pjsRUGw3xhfxRWLunK8I02mjX1fWpOHiVL+9oLxfN+bH/BHN8Z4KVRavx3jdueTKdXqsiZ9JpqknX33gr06tKbASzg6o0YaYiMSO3fdY6uGPEL+fGMAK33qE5iQE9ZCXT6H39BoYpmhypI1c1MeE9mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754745; c=relaxed/simple;
	bh=i8TdYVTnlgUx8z+S0f17uyrfNqpqBeM0AvvLy2KDWXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxGVoMMdWLXz8xo0xisihe2HDe2QZFlsxBxxprJMDNVG4mN1eVANcNSEzWZBCadjTsCqpNZIC2WG07rE+DL7aa2DV0R2tYegPg//dSprbCD9sEvx1hSOkvzvKGo+kwfpOMkvIPEuR/fmjhZvRKFL8/9XpqwE5DSyua9GBq8srjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUCH4HP/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUCH4HP/"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so361193366b.2
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776754741; x=1777359541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Edq2ptyCRSr5qgmGluyTV2ehlX9fHU1GZR+pVn7rhBE=;
        b=RUCH4HP/ykh3NGKzIm6LXQjRgpU28l0tWJpePijh3zcFKxJ27UCCeiZr+7JjkHPfho
         NoyeUQobP1wtbaPWXOxP38XRa31IVb9x96sB2akCOh8fHKQpq/EpTttpHZbFtyvqC1l7
         ocORswVl9T5Lj1rxWtdIQbJwqIwrYOo0i4wNGpipic5eN0BNLGnPFjLWOAAnOIHbz+5P
         GUItn4Z7uotGyLzrxMZBmD9VRTIuuVU7EpqXdbwBIbsjy9IISE+uhOMT53z/nR3HZjSf
         WAUpHTfEy4ufTIER4ljuZISTOhoIFtv0FIvnftbKhXDtkhorhQ5pumcv2z1zEIaPAvsg
         bACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776754741; x=1777359541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edq2ptyCRSr5qgmGluyTV2ehlX9fHU1GZR+pVn7rhBE=;
        b=ga4PpK5HqhKIbsijE9IvzOxsZuwPVGtdj7dmQVYPpwUMVfVyo2YgyhmD6BjunQ1T51
         zTQoAfhkvVAWeWN6E3Lj6bgjaTueiSFub4WENcpTpQ6BOzlgwXMUjL5LAazX5R99NTck
         ojAWz+TxPCjQMwhs8aMs/4PkNeInIsVfu3pW7GzhqpDo9JWOz7vGOqMwJ3dofpzboEos
         9B3CKNvGjjG90IQqQUDg3i4gQR0Wa/Ddd3b4qUxWDpzKUemd/Xlv+w6Ec4bVCJabZ7f9
         Co2S4whurM6zMi9DeWzU5OOOmEWGQvw88H8x6xn/PT8WGOkQN15oQINqNNtpKtwM+fi6
         +csw==
X-Forwarded-Encrypted: i=1; AFNElJ+cT6lYBffS5ZSPZa/gPliRla6dEbUTjWUD7a/g/8BMILIjSCWCavLXhBdbhpTH+BgAiNKr0JMyLpbIRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBCKZ8vveMHdWqFwvGpgVTvPJOaQczQEtubol7w9HrkG8Nfn3
	ZQMNXhQilOqgBvFBS4mHhETh9gJBS0lK+WVlbgfWAjAKYYJd3QgYYDQJ
X-Gm-Gg: AeBDieusVfhq9mrOStQa6ydx1BOXqHAzTOwbiEhX/ksrddVQs+18McJQ/BrstVc8gJQ
	fB+UuO+aYWFnc1wlAI5CCvYgaOPf3tc85aCERCd9oel41kSlF7CVB+T2TGjYJxOXyp1bCiYV3Bl
	NC5/sLPgMl3dwbCewAYJ9TiZOOzNlacSFvffzjE4aveevVcgCYzCB8/imhabn0yZnP+vVJwRjfT
	S9IsBI2kb40WIXjKDlgIwtezqJay86fD1EEEWv2HeG2a26VBeZHlPT1k/ingnhrOsaSCMxu+rj8
	0p0C7ZGZAB5VbNMITMZ1ish9z8t9ybWBsG2Yjc00V/bhKK3NbFbMX5MH6UVaaDzOGKtpu3Yi6xk
	GIBPvzefpZdGRSR+va/mHSH8YUtjqSY2QUNp5kmfX5HRn/CbcM+kEwzI2zk+qWgx8wA1Kx2lSEi
	PUpiRue0GzlzpGaAVDDmCtOBUBMyXohd+FlyR8ey8NyODcdN6re3pVDkryCpnhW/qGlN9+sQ8/h
	8ViElh9y7Yrx5rlbB5moWQy69JVB7C/0DqRn7NvjmiOzJjXU9KrhjA8qilWS46tbaLDcM+lxgKM
	2jDe1CUhdFbW17eQ+t3CARDsho1yIps3kBEZB+QrdCrtjbm6a1P5UCgEb8snSXGsFtgSeLRAjp4
	H3sDssVXICWFG/nctkLi+qhTq4i0Rr3ICNaI/UwmRwcM+p0a28tA7ZqikLr/CvLSVZw7kZeY7ug
	1wv4FSBEo=
X-Received: by 2002:a17:907:d508:b0:ba9:3e6d:f768 with SMTP id a640c23a62f3a-ba93e6df95emr158575066b.2.1776754740965;
        Mon, 20 Apr 2026 23:59:00 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (172.178.13.34.bc.googleusercontent.com. [34.13.178.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455533bdfsm409675366b.57.2026.04.20.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:59:00 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3] iio: magnetometer: hid-sensor-magn-3d: prefer 'u32' type
Date: Tue, 21 Apr 2026 06:58:37 +0000
Message-ID: <20260421065837.1290-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'u32' instead of bare 'unsigned' to resolve checkpatch.pl warnings
and correct type use as defined in the struct hid_sensor_hub_callbacks.

No functional change.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - changed 'unsigned int' to 'u32' per struct definition
v3:
 - commit message edits

 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e4..b01dd53eb10 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -280,7 +280,7 @@ static const struct iio_info magn_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -302,7 +302,7 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -350,7 +350,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec **channels,
 				int *chan_count,
-				unsigned usage_id,
+				u32 usage_id,
 				struct magn_3d_state *st)
 {
 	int i;
-- 
2.47.3

