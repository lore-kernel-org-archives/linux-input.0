Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E129315793
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650938; cv=none; b=quZ5EAQsg08uGEGgBsvSqT3dioq49rc4THGmo68X8987dj0Lj7kPjUhB2+01246RDbOuCI2rPHAPojSuzcm/ehI4SbUGij5IhYy3cC+KAuZrhuQrLI/YALobNdsvTu9UEeqRIKOp2pb/qbOMuCbZ2glGjoDYnJoBGj/dvEu/F40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650938; c=relaxed/simple;
	bh=dXQ1owQJu/NNm3CrwvIAz1pCMf+D4X94TxMHlQ3LOoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGIDwCDhFx+TiPAi9k3tETur0M6sIXPeyozwnFg6VxzF/rD9e9ru9EBw0uvM/ZyFLrlgp3qY/LCdQ9IGdDCev1AI8tMgpWn4Yar7sDJw+Mn+/I21MIP/fnzlx68ZGU1002gw3n2TPqWtUTrCfOTnhTxq9Bc6F/sCfTGVTja7Ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDwH7Xh6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDwH7Xh6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba928852a5so61936045ad.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650937; x=1780255737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRtYGBNh0deiKiXE6TxvFx4+EpkUyjk8HKubJk/jLJ0=;
        b=GDwH7Xh6h4wSZP/UO8WeTwwBai0jz4KPIRZbtL5nuRpP6sR6NtNzMIwzIeSA1d4MRT
         tQu5plireDchKn6cT29IjXaxi7/OlDfPgD0hiW7kaMKHvwIYSGM9ItIgvPX6wJsFk3eF
         yQFLfJPePmjWtSqJitHDADDKp1lwFkv4/m8iF8Lu0BA9NzfQwItdNJk9fXQ/G3RswMo7
         XOzQgRHStNvfMkBP9U6FJjSE+FefCT165tPzkkZfB3hQ5CWpLJOJLDkgeNom/Tn0aV37
         zVHUAt96xO47NaTzTs+TAs0K73+orJysEJKUQ6SB9pXG2yZnNBWPn+n9OH1J/tbOEoOJ
         qdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650937; x=1780255737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRtYGBNh0deiKiXE6TxvFx4+EpkUyjk8HKubJk/jLJ0=;
        b=rMY5MpGGiu9oG1C0D7PvP4QIwBe/QRp5xnPv4fm560wFVbFI7tIo86zeEYpOP/gmbJ
         f5At9nah85KVwhxdc/1TgyTldEzJ6ygGn5m3P564lh8flzxKrkuoQUUm0ii2KYISB630
         76FSlHcz8XFF8i8q0MeN/WMNqcJ7HT9tLxq/Exg7/zLP1ty2zQE9K1VOhKc545dVO+wI
         onQQUghexKxa/+z2oBw2bFBJhDht0OSpJDteEnRgDJHuCQ1TpR29c2LbdGhiM/RBIS7+
         +JqSZo4px4dX8pMwUEDOb4GpgjFby4TKdiwhyw6z7klUW+Dw78BlQRPOQCtM+t3hILGp
         HfMA==
X-Forwarded-Encrypted: i=1; AFNElJ8KzZzvrF8LE7k/yvWbhneRAOy0M5VPCFnPgsxstvh4C+jONYTEpHuCps1iLiEEQSEm40R25GOj2Q8ekQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhC0didwI/q20tDnmSpLDxAXCCXNzWfKY7WbuKd43b//qFpwXq
	+6mreCPevI5tbfVSggvq3Zm20D0UnzibEZUzBX0qQV1i2uKiQIFnAYWh
X-Gm-Gg: Acq92OEuUR91RkV0tMwsi34eWE9tg+DxbMk0+ju5UxosEvPQa52Uwmbh8YtWOHusaQt
	ovkAEEgvU3ReUe4Pjnl2Y+f2cj5cWAqiCgK1NilG0DAcGFESoI9XDyMA6AubV5pRezB0WVPJkzK
	8TMZTtVPOhalL2ZetkBniAhpHQVuM866RUx6+cxAAkUWvnkcXj1++Oy+jzVIjsIxpvNypkzUfzH
	T8o0xln9L8+zJnuQCdTcL2gAHAldOoRZiaC+dc5cK1+a3sBNVP59l0UOM/xihRZdaN5S32TEERz
	ONDWPyazMWt4pfLrCJ3/3UiZs6frbbDEyuLrDBorNwMcmOTu8UijtP2avkUcycdWvubcU+Jdfev
	iUmoK7eVcISXwhFMUbmLx4p2DAVQwZImGvD8kz1DRSScgfaXNT6CbIYlljvZ2N2ARNkqJWWDHaB
	JTPm/4vPOCIyh6ktHJ/M17K5iisDwbFl0wDFgWHKjUlQd9184lrtc+rj2qVpM=
X-Received: by 2002:a17:903:17cc:b0:2bd:4b8c:fd30 with SMTP id d9443c01a7336-2beb085c6ebmr127671735ad.41.1779650937009;
        Sun, 24 May 2026 12:28:57 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:56 -0700 (PDT)
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
Subject: [PATCH v4 29/36] iio: light: hid-sensor-prox: drop hid_sensor_remove_trigger() using devm API
Date: Mon, 25 May 2026 00:58:12 +0530
Message-Id: <20260524192812.1196549-10-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192812.1196549-1-sanjayembedded@gmail.com>
References: <20260524192812.1196549-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_hid_sensor_setup_trigger() to automatically release resource
during fail, unbind or removal of driver using devres framework.

This simplify the setup, remove goto, avoid manual resource cleanup in
teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-prox.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index eff206d7b812..85b06af67611 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -312,8 +312,8 @@ static int hid_prox_probe(struct platform_device *pdev)
 
 	atomic_set(&prox_state->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&prox_state->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &prox_state->common_attributes);
 	if (ret) {
 		dev_err(dev, "trigger setup failed\n");
 		return ret;
@@ -322,7 +322,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "device register failed\n");
-		goto error_remove_trigger;
+		return ret;
 	}
 
 	prox_state->callbacks.send_event = prox_proc_event;
@@ -339,8 +339,6 @@ static int hid_prox_probe(struct platform_device *pdev)
 
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&prox_state->common_attributes);
 	return ret;
 }
 
@@ -349,11 +347,9 @@ static void hid_prox_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct prox_state *prox_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(&prox_state->common_attributes);
 }
 
 static const struct platform_device_id hid_prox_ids[] = {
-- 
2.34.1

