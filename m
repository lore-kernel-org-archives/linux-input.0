Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDEA3C4552
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360597; cv=none; b=YavdV8a36VOu2i8CkixzD7X398/Sc1ulP/G2LOiuJSKED/EOjzxiNuH5mfgt5lQo8XAogmJW6saLVf5UYme9WOslANagInmar4MYR3aJRx3WyKcspQkQFVdb2TlEHda7r5Ea4tbkrzbDeJ7VDi8KrKE4KBKgvyOA3cuFCXa9m+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360597; c=relaxed/simple;
	bh=MFkF4FxHhibTkpZ7hne1HySj9bjmGLfceyZ44mIAeVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WF4vifLQERgX4cVDYlWF3SVB8/ly2AfvhNbzFH1Ail4ZYNKfi1E1+v9nQvDYDkS7D/XQJCuescYsA3YblswFKWB66vOE4eWhobjtyTaVejbeAhJRkavUxXvgxEbxNgqx3wtktcc9NOPnaE4lhnDEfw2gyNkWt7E70aFpbbVFt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO8NFbny; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO8NFbny"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-834da62e52dso335463b3a.3
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360596; x=1777965396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vu8H0bZAUzIM+TB7GToLvbyidCdn+6nJwGvF9IVANM=;
        b=bO8NFbnyRxWDDVGsyPG0EUGEhpPqZvhxWvRDDThzJFNKz3RVBK6OnynF2nPAFmQifN
         DXeTzEZHg0AW5ekRrscKx4/HxkxdUHcxjTJQ/R9nZWsvVulY891Juh6ZI6HJEegZuaUA
         puDoMRCSTut81FjnZ3R/gk6AA4VCWHQuJuvzCLGTToCeDAwuNTqngouIC09fbPjUSi7n
         sMu0vg8UtMImCOPH3fVqO1jts6MyxIIfUWAfAajP4WXa80x5NjTIHh4VjUWZV9Uh59Zx
         xohuQmzDaeP4jYeh/m9LfxtO+RNP6umbRCEJQ14reFLufe8zRoPbV/f5C/197R1FKaFm
         TN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360596; x=1777965396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0vu8H0bZAUzIM+TB7GToLvbyidCdn+6nJwGvF9IVANM=;
        b=iLR1BDquc5B1tkzro08cuKq8bK1ApK48bj1DuNUqZJMPQdflwEHEn6/COzctY2kUWC
         ThOsAlLGYEwISoWy+jTdSipvBH66BBKZeHCt8922HzNO+FOV+HtAipFhZEL68RaKk7jH
         A1sWN65hwcAuXnMNNKAWDyyKFjZD5mhz4UqDvNgA+37IBUqwUY/eYb8zqq912YNgWblq
         +mC6ucJd8B1sj/3VTgW7fE2FZkfJcpWrWtLac18Hp7IzPSacGiBXwDiCpbM6P2EYJGz6
         /Ny7R7hfLBkWsYVfK/98cfHgXgEunfpCp+k9pJpzmg6CS4PTVVK2iTbEkhG5waMcX1C1
         TAHA==
X-Forwarded-Encrypted: i=1; AFNElJ9noNJD6bd7BUgS5TQeUnTd4zk9JVMFZFCGkpu7P/mCESQAkfthIRogjsDC1SKXL58Bz1xsk/pxwzmrSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzptIRGx9KePJPmv4fD/yrev/hwSAjdn7oolZD6rgAlezOFYBVM
	KWPnspVMYtLG6nZnVSpuvVl+A4utCtBIyKBvjxyB5Iggk+MBqJyQFn1+
X-Gm-Gg: AeBDieuWOFDnteBYVTtQZ854rRLEvNpsdHYeuVzHyA+Nu0uAeUx10BTJbVn7n7MAQnu
	C3EoUgH6fSOjtemFwLEDk6vr5f5YdK+y/stKJu806O2q9bS5QkKfeFPTeYFuYphC9a3+UD+thec
	ndgVnuoMXkfi+K47t82fOe5iPnclVdgJ/PVg2RX6X+ypa5EmL0LKkLyjGsckia/Ss+2atoU351x
	rUKqTbLyq9K39EQTy8zrrkDo0ctEwUz+Py6oT5d/tRK+lCewNE1EL9SWFroM/o4Giz81SaTqorv
	IwcADTumg/hrYsV2ya3g/XsHl3x4TNUJSEFj1vbM7OpEX7Pv/tdJYtZFI6FrOI6TR44QhyOH5v6
	+5mzppStnkapXAIrHSymHvJnk0zRr4CpeBqtaVsmHZRojluk6MqcRJ0iQZwqZ43/PvsYioWQ2Si
	muQm+lPVVHrNH1FuI5ep9C4MWPfSVQOH6Xvp7/XBg/dWT1GZrx+kut1jcb5Ww=
X-Received: by 2002:a05:6a00:3495:b0:81f:4a36:1c7c with SMTP id d2e1a72fcca58-834ddb9f2d0mr2167388b3a.23.1777360596021;
        Tue, 28 Apr 2026 00:16:36 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:35 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] iio: pressure: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:07 +0530
Message-Id: <20260428071613.1134053-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Update the driver to match the updated hid_sensor_remove_trigger()
prototype, which no longer requires struct iio_dev.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..2bf5d055e175 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -319,7 +319,7 @@ static int hid_press_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
+	hid_sensor_remove_trigger(&press_state->common_attributes);
 	return ret;
 }
 
@@ -332,7 +332,7 @@ static void hid_press_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
+	hid_sensor_remove_trigger(&press_state->common_attributes);
 }
 
 static const struct platform_device_id hid_press_ids[] = {
-- 
2.34.1

