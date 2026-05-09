Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB939EF2A
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321461; cv=none; b=fPPTHtJL7XTnA02Lfgo4ZoXLW45kjXkpgRU9s1HeCgf1JFEPD8QlA5c7d2UZLgVGJXmERmNm5S2PCnR0WNpRMpiR2ABNeJ3UFON+tkB/50Bczz5O3OJdkTknAYGm9o6IpW1u1sWrEkhvZT4LMIxIbSSm/ZsE5NBt6455uotiz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321461; c=relaxed/simple;
	bh=fDDowIRabahRP7ZRMJkG11Sb9EjOwHHgjbqpVpODPyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDawpz7g2ZrrItbGfM8VseTel97B4RW6juOhiVcycSxwg77VF4AePFbX5ygAUGI4WU8eJ4JOplqyQcoIqVhvSrRf5TAAp0Y/xN0dUxOWMXhfS0Yne9V2bBSbKluS1LBRnrmNvNH0QjAd2Zk+O40OsGgxA3N47fUlZTSYrxipPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MORvAHNY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MORvAHNY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2adff872068so15320985ad.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321459; x=1778926259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABvgg+B1vj+fw2JrPeoeBLI2umPERJ7N6KddlE6yxNo=;
        b=MORvAHNYKmhv4Ki0BPUS/doKVEdmQ2vjBYaI83x/DrW2jFtBvWXvsgIQNrzomvVQLQ
         K9024TMLQW/QE0W1AtYbOuZx7AXzcHFUOwbo1kkpBmvchu2MFjAatyFXaxMqswTeBnde
         gTp4QHdGQ2Nxn3OaC5V10lR6aUEQ2WnrHhod9xpnhYTMCgIUNxFVCEGJmYIKhWKIR2PT
         h4FV3RRMTkSdEyxsbP6Cm/enNyl/RLoiJF41QTtzeRrEZbV7H47bB6YukW7upOZbubBj
         aZ9x5A73zESlSFnzOu1SRntaRbpkFpbPj3CjgCqC7P2n9WVuWJB4vyKGCVGi2yP8Qbg7
         kFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321459; x=1778926259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ABvgg+B1vj+fw2JrPeoeBLI2umPERJ7N6KddlE6yxNo=;
        b=fNPnqkcmsf07nezYxvlUb+2vlbyGJg+PsqQi/0AHSSJgzgNKyAv0qP8YpPzgzYmlKz
         clArHLjP+ePM3KUZOi9Pmk6b1ezfpE792k9U02cwj5qe+U3j1DWhgedihnUAKxkIXD32
         eXz2MVL6lXspqMhPuToEGOWI6DGXQMgHyDHNEYC98mcWBqATiJ1PERXDGfHr6t0Wut/W
         WUsKt3eVWyqi8AtgIn4usSwOQLr1RxaiLiwl/SdUBJ8Y7o8zU6E74VVUDLpSSBaanV3k
         fZnWKyfFI2rTBj8chrpO+/uo3rsYobjJdfzU5MP74ALg2XYHxQ5IXn9+VL30eJoUlAvS
         +GGA==
X-Forwarded-Encrypted: i=1; AFNElJ/C9pqlcWcIV6jXjb3Vbfzq89x1f2qKL+qhIixSsrlTtD4+Eqe2Pr2PPQTmcfsQvKIg1KDzfgIVbipwag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyu4kzs4VZrdwzE0UW813jZNEGptKP7aA64/zviTonAm8OZYo
	HQ9+sf3LJc+oB/rmPwD2DRc7WB/vNVb3gn+aJpJ01m7m9SPk7Cqz68QC
X-Gm-Gg: Acq92OGfLauoHpBCdHQYlYSybwh2rPfStKqXXujgmiD3fcIR62sT/w/E6veaZLeCqp6
	0Z/5HoMBGWArSkX9R9FHmOLEY6rlQ3PUXTvgYAhTn5YNrfqbIHaG1ucU54bO2WGbrNFssUY+Vcr
	Vz6r2rEmVV4V+iBjF2Dr3urbSlvNhoBYV6pMo51dCyWHjM0knj6aOxoiArXaHkkKIjSXKQ7mUhi
	Jzn4h3ycVgBcXI3mY9ZkeISDI3QXhVWk45nkOUjNIu7arq0mIpYQ5y4XmW2y9G+gpE7wlwRdbjv
	/2XRdmnk5eFqxdjs7V5kX8BVr8A6l7tv+TxFoFyAmUZ5AekPfhRVLwKxgvVqESph9oIrY6Vcdwf
	L9PTRb8y8zzHofV3ARvrf+fzUHPDEkbfH9t+2zzcOqGMY94JZEuOpU/kY2D+LpvzimYeiCbDzbR
	57uiualiM67Jyb2C6bplmvyoyM6qj+Ij0PfYGDdHOo/3nNMyZCyT4GgmHJkbT3lYtS+ofwHg==
X-Received: by 2002:a17:902:db12:b0:2b4:5cea:f619 with SMTP id d9443c01a7336-2ba79c10b84mr178754585ad.22.1778321459383;
        Sat, 09 May 2026 03:10:59 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:10:59 -0700 (PDT)
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
Subject: [PATCH v3 3/9] iio: hid-sensors: introduce device managed API
Date: Sat,  9 May 2026 15:40:34 +0530
Message-Id: <20260509101040.791404-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

hid_sensor_setup_trigger() is common API used for the HID IIO drivers,
prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
during setup and release using device managed framework during drivers
fail, unbind or remove path.

Register action with devm_add_action_or_reset() to release resource with
devres framework.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v3:
- Remove cast and update function based on review comment from Andy
- v2 link -> https://lore.kernel.org/all/20260429175918.2541914-3-sanjayembedded@gmail.com/
---
 .../common/hid-sensors/hid-sensor-trigger.c    | 18 ++++++++++++++++++
 .../common/hid-sensors/hid-sensor-trigger.h    |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 98fadc61a68a..fb6a4587ae03 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -301,6 +301,24 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 }
 EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
 
+static void hid_sensor_remove_trigger_action(void *attrb)
+{
+	hid_sensor_remove_trigger(attrb);
+}
+
+int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
+				  const char *name, struct hid_sensor_common *attrb)
+{
+	int ret;
+
+	ret = hid_sensor_setup_trigger(indio_dev, name, attrb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, attrb);
+}
+EXPORT_SYMBOL_NS(devm_hid_sensor_setup_trigger, "IIO_HID");
+
 static int __maybe_unused hid_sensor_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
index afec46ecbe71..6fd7c39a240d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -17,6 +17,8 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb);
 void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
+int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
+				  const char *name, struct hid_sensor_common *attrb);
 int hid_sensor_power_state(struct hid_sensor_common *st, bool state);
 
 #endif
-- 
2.34.1

