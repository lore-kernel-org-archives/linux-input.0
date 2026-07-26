Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD17EADC
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069957; cv=none; b=Q+1t1Wfj+v/LMlC1yEE1DCjMOeEHLCjsIQcf8+sCW8ZZ3/h0jOnaq7pJdbz+c95lDDn8neYEWEvS8/Th8fDv+hnGi9i0j1ht1Zow8OOoKWV50MZT3JQJilOcygEqIx0zT56uVVrjnbM5GT0Q7zP7Xfjp3/RnM/TwAShbNHehp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069957; c=relaxed/simple;
	bh=+DicZqvoxzRMbNNpDHwbco6MjGZW1B7WV/xUthTtgOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gzj+kBV5OBjovu7/RzV/QepNT11jraOmZmvL1T6uNGGcPkPSlDxe/IppjKX1Ck3yRIuDgV3ZHC4gJkkvQKzyAEC0zmHHlriYEV8Zxr5fIIvczWkmX0vEo5cvTWWJWCTBX0bGiU7R1XXh4ucAjZ5lYqT6ybFipSUTOutpebRsgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=yXPfpjfq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="yXPfpjfq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1578699f8f.1
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785069954; x=1785674754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zDZR69zxyQUnmAa+1SVSCo3XwuE2Lf+IdHyjHOEBtFQ=;
        b=yXPfpjfqABX+Uj2KL0kzjUfSGYTv3cWwA4iYRZeNJ14A8EIOjYYVbITjhwTAU6m3do
         Cbr9hZ+5TzJsV0TyE5SvOVt3qHI4ITiQQ7h41plsJVm+a/N40fA1f/zDGEJ+UJCN59oA
         v2NGQYptNBJgT01wMb1N8hU8Fj/egApKxZr61peTFv65x7D/Fz8YE4FflRafbyBm93NI
         Pu//f/Z5sMZ+0prPxHzJxxSk92Q/aUzwurDn3cpwAzOgXmocNAHOSxYCqFdUt2Ddz1EG
         YCRWIx1Rb8SafzKFpjQSg3Yc/Er+9HdM2LpiJfBr0i0BaP4LHuetAGdCEh47huUfgPlg
         FwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785069954; x=1785674754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDZR69zxyQUnmAa+1SVSCo3XwuE2Lf+IdHyjHOEBtFQ=;
        b=SI3MgEYE+D4BzmxFX5RAAKhTp+1K59Oe29mcBph7vJvywFjpXomrsGOmm8qgr2grK5
         HGxTXkQVe3yity5xdfWkXf49RYAq+U9OrrJApMqiOJhdJF9th7gjEL/Q6i5s1fjoS0L3
         6srLCtzJVkH45EE/tPFl+pF/n7YE6JcHSkQbT2Gl0YbifcPHYqlc6aEzzr16/A+CnKJQ
         ZfEUAfkwiG15hsS62oauo/O6EoRN/hfo9gUBKXIinxVyPi/HWJq+UizpseG1GxRhJ0X+
         SNOqBXtBhNV+cCpx+9rV/p6Vs4XNGsYDlBjwUYaHx6uADZAOVehi3TcUii4xGNByFmsK
         xYDQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYCkdg5+EGRn+aX+MSZYZL527wqOFtvDM7OlSVnyCVExDr+qRBJJUvCZeJXr/awf63z2jFDKdGhtCHzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0qMHaGuP0wIqBLADUKo2tl6QJz2Q0LpNHamRFRTrEw/JMaHh
	XZg6u7MBLE35MaQnYxLZuADCy0buf2fYrAUIjuQekFTNLy6EH54E8jVyonwDv7hAmMiK
X-Gm-Gg: AR+sD13i0bvRrQgbGE4FxaIKMVuC920bF2EKgsxneN4atjdJNGk+MlN1ovfPBLdnnAt
	cFXdovg4GXs6xLqImC8Bb7t7DnaRPWJyDbZEjjeRY8gGiF/ks+noPoyh4zztOnGiYrKFNBF/+c/
	eixpRkAqloTgjP0Y+TVIqdQnvHyHL4wzT3r7KEVyGOmpEh/61vzj8TYFexDoW6AGV1T8NxmYos6
	zsTVLrDVAW/9/IcBuDKWZacT57ZUEbAd5PDKAHIlszCzxPV+lNRL4+WI1VrJzXeKNNzoeYNri4O
	Li8JK2/P0SAOuwZbOgyuzQG5EGZly6f1VRqQICoiAQ0qrEiaCQ9Vkw7ueXRGovr6CO7TOiwY1/O
	Gzn98o6dKTZ4WQ51jhqmKzGjncpyezgwg4wOd8gAfcLJ1oYje8RUMDgMd1BdUwesCPbmvSORP+2
	NXdXKtG4z4wSqhe4WIwhSshD/q3FLlGZkUi8loH6WJvIItS++OXd/H83Nsm8PD756H9JxLqbBgj
	Pw1JJp2rh1f0bQqf5KNv7YD
X-Received: by 2002:a5d:5f04:0:b0:47f:7005:285e with SMTP id ffacd0b85a97d-47f9feb6806mr6227705f8f.53.1785069953284;
        Sun, 26 Jul 2026 05:45:53 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.222.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm40939225f8f.6.2026.07.26.05.45.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 05:45:52 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: sony: clean up device list on probe failure
Date: Sun, 26 Jul 2026 14:45:51 +0200
Message-ID: <20260726124551.15323-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sony_input_configured() adds some controllers to sony_device_list before
HID core registers their input devices. input_register_device() can fail
after the callback returns successfully. sony_probe() then observes that
HID_CLAIMED_INPUT is clear and unwinds, but only stops the HID hardware.
The devres-managed sony_sc is freed while its list node remains linked, so
the next matching controller traverses freed memory.

Initialize the list node and device ID to inactive states. Make list
removal idempotent and run the driver-private cleanup on every probe
failure path. This also makes a second cleanup safe when
sony_input_configured() already unwound a partial initialization before
sony_probe() handles the missing input claim.

Found by 0sec (https://0sec.ai) using automated source analysis;
verified against the HID input registration and probe unwind paths.

Fixes: 4f967f6d7374 ("HID: sony: Fix memory issue when connecting device using both Bluetooth and USB")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Link: https://lore.kernel.org/linux-input/20260724143925.007D61F00A3A@smtp.kernel.org/
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/hid/hid-sony.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 253fff4066ebd..56471b7b052d1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1982,11 +1982,10 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 
 static void sony_remove_dev_list(struct sony_sc *sc)
 {
-	if (sc->list_node.next) {
-		scoped_guard(spinlock_irqsave, &sony_dev_list_lock) {
-			list_del(&(sc->list_node));
-		}
-	}
+	guard(spinlock_irqsave)(&sony_dev_list_lock);
+
+	if (!list_empty(&sc->list_node))
+		list_del_init(&sc->list_node);
 }
 
 static int sony_get_bt_devaddr(struct sony_sc *sc)
@@ -2127,6 +2126,13 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
 	}
 }
 
+static void sony_cleanup(struct sony_sc *sc)
+{
+	sony_cancel_work_sync(sc);
+	sony_remove_dev_list(sc);
+	sony_release_device_id(sc);
+}
+
 static int sony_input_configured(struct hid_device *hdev,
 					struct hid_input *hidinput)
 {
@@ -2313,9 +2319,7 @@ static int sony_input_configured(struct hid_device *hdev,
 err_close:
 	hid_hw_close(hdev);
 err_stop:
-	sony_cancel_work_sync(sc);
-	sony_remove_dev_list(sc);
-	sony_release_device_id(sc);
+	sony_cleanup(sc);
 	return ret;
 }
 
@@ -2339,6 +2343,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -ENOMEM;
 
 	spin_lock_init(&sc->lock);
+	INIT_LIST_HEAD(&sc->list_node);
+	sc->device_id = -1;
 
 	sc->quirks = quirks;
 	hid_set_drvdata(hdev, sc);
@@ -2367,6 +2373,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		sony_cleanup(sc);
 		return ret;
 	}
 
@@ -2421,7 +2428,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 err:
 	usb_free_urb(sc->ghl_urb);
-
+	sony_cleanup(sc);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -2436,13 +2443,7 @@ static void sony_remove(struct hid_device *hdev)
 	}
 
 	hid_hw_close(hdev);
-
-	sony_cancel_work_sync(sc);
-
-	sony_remove_dev_list(sc);
-
-	sony_release_device_id(sc);
-
+	sony_cleanup(sc);
 	hid_hw_stop(hdev);
 }
 
-- 
2.43.0

