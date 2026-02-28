Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217EC401481
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772306140; cv=none; b=Tu/I4O+FY9LQ1rWUveZrX5+6xKyLZN/ixn1lNGFrerM4+BYcGQNeQ4ddHKaHQMN09vh938Fkbsk/OCKmLqNpWbOoP6qxoyGFyW4Z6nrRiEPjf+gUSAorUOwiF2q69uZ6hZztx18ABjiol3yWFVBhz6/22voOsma8c7jQND/8P2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772306140; c=relaxed/simple;
	bh=RaHWcaTGquYjBjkFXqSWHYS4JWm8jPuCNNkiQhCR/zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm5ZsOdoruTpnxxigLGjVHWGmDPA364NeWPhQzT8TMR3h96+f8rLlCFNuZOnF5llCdmWCZCTIphYgOnYpZxhgV/cKvorSZbm0mJheBP6fDD3dNo/Bf9MU5j/QS4gXAF1Lo9GIRLwuQi4G5S+0tsjh4YQo7fpHhKuGFTiSeivYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNtBaXnn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNtBaXnn"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-827307b12dfso1721791b3a.1
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772306137; x=1772910937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrjN8Am9nPkuoa8HBafNNHI41p4l7h9p4EeDz+6g2vw=;
        b=nNtBaXnn3Gw6ROSGPrVyXkeO3d0ULKG9kKU952f2VvQmADWAZSwMrM3sBNLs00R2bY
         33Cl0Vngi57H8oGG8XDWE6F2XJcsyBgdXDhZ3Ad41aWCa9EzgK8bQNEJ7xc/2LnDcIfD
         wkE0ACDw3G4e1lyzjSg3MbAkbCgmYSConK4KJf0HMU8CdrkNe5NjKtl5+kkvBfMFxpBu
         au5iFQKIIaJqZzPHZXVPSgASOCdAnR9JQf+B4viQiCrKi35GVp2os2/bTaNmouTT6MyE
         WJE1myhYa+CH8Ap7hUWdLjUVqRLPZsEDUisS0aHSBNpdsZPObOncQYMwNO4oRuqKwXHe
         +gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772306137; x=1772910937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TrjN8Am9nPkuoa8HBafNNHI41p4l7h9p4EeDz+6g2vw=;
        b=FSYKxpf2Nw1yUc3IXWQIaIUYz+aWFvjm1UBMjT4cpVUkPiIORYPjHMm0gkXN5ivelw
         HA7KJMJNE1rXIqdaT5IlojNDveCmydHZw+tlkkthsA2A6/OzVYaV5DgTdp+hhzIQKAgq
         Z2GU5kivvhROpUJNO9kEREz/y5VtLYs4LMyaHECZsyrCrkLlIxp9cEf62TFsSv9qUu+k
         2Uq2lW2DeaooKimrQYfYpoekwYhBozZaDmvUHdG+FaHF5ys2miMlOmd7NTvlCUEdYoEO
         YtsnewUeoUqlyR3kWFkZVVfDiNE8L8jeWUwWpFBJguNwLKIjU6f9n2aiLHXccg08fO9D
         HNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU58AXDunqnsnQm5tKq/6rE910G5maWOZ08CQcTTWMnPZ9IBKE43nYyxVB78XzfeCsxbo1N7sP1JVL0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGH4+QjeBSSYR8+3vc/Phg9iKJDVNpEWEVW2lPJTr42AasXqy8
	oTAp18aTpKzwiLL6VaXRsxd91WTZ0ksr9gKy58NtLnW1FgcdkQ4EekGY
X-Gm-Gg: ATEYQzxgOjttBI0nAZog411BJVcwlrHgj8uUVY73aqIac0h9+udxIbjhvsj03XC3o4x
	x+Cn4PzABLIUED8kSqa1D4lWwCRJGzHxVJfXNrRyVQ/69G3t8hB31taOCzPiOUg648+PV7qGzjY
	a666aO9QmlY/PY8T5QRgF4IF3dtKzfdCmbEZuLZKdmmbBfFrVKqsiUk+lpifZ/XprqveaMukod4
	VJsD9R//k4PrxGBpn1EUhvj8rHNoZlTAX6ZF8EvRAGo4dtPhDNlJI0+vK5nwdXVjjkPE4kHrTYZ
	ljpaP81tWG1SzM9c4vlzr9oCsAE1cDJ4sqa3V7We11wG6zii/KsK2qBQfX6ghC6Ftdr20MPQYhm
	4rfghyGCD0ar7urdwfnzPI7YE/lJmutc3CHfVciJ7qAPf4I+aUN9368WYmnDAy7F9cZ4g1w4v/+
	zuQ69jOFG/2Dd55o7GTL6jZgQL
X-Received: by 2002:a05:6a00:3685:b0:824:3d5b:3cd3 with SMTP id d2e1a72fcca58-8274d9dae20mr6737395b3a.0.1772306137308;
        Sat, 28 Feb 2026 11:15:37 -0800 (PST)
Received: from arch ([2409:40c2:5057:a20e:20e0:a4e3:da85:ffd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c910sm8327918b3a.8.2026.02.28.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:15:36 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: jikos@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	linux-input@vger.kernel.org
Subject: [PATCH 2/2] iio: hid-sensor-gyro-3d: fix typo in array name
Date: Sun,  1 Mar 2026 00:44:00 +0530
Message-ID: <20260228191400.19244-3-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228191400.19244-1-rougueprince47@gmail.com>
References: <20260228191400.19244-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The array 'gryo_3d_sensitivity_addresses' has a clear spelling mistake
in its prefix. Rename it to 'gyro_3d_sensitivity_addresses' to correctly
match the naming convention.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 8e3628cd8529..4f88fe478d84 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -42,7 +42,7 @@ static const u32 gyro_3d_addresses[GYRO_3D_CHANNEL_MAX] = {
 	HID_USAGE_SENSOR_ANGL_VELOCITY_Z_AXIS
 };
 
-static const u32 gryo_3d_sensitivity_addresses[] = {
+static const u32 gyro_3d_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_DATA_ANGL_VELOCITY,
 };
 
@@ -297,8 +297,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_parse_common_attributes(hsdev,
 						HID_USAGE_SENSOR_GYRO_3D,
 						&gyro_state->common_attributes,
-						gryo_3d_sensitivity_addresses,
-						ARRAY_SIZE(gryo_3d_sensitivity_addresses));
+						gyro_3d_sensitivity_addresses,
+						ARRAY_SIZE(gyro_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
-- 
2.53.0

