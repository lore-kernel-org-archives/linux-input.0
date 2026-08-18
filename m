Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79635C185
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041543; cv=pass; b=a0wY8usmqWI/S5V4NpqHYMTeRONc3SAF33SQTRzKOLmmRp0LacgpFkrXO9trtOb8ChBYqxLE93R1uLxweHR7dOMYCB4ue42QRtkp5lwN5IOVsXfbvzYOkayYEvAed71pSXW+/SeulXYTfAe5cUYztCr52E4VmmTABJEbxEEB30Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041543; c=relaxed/simple;
	bh=DJT11aK4BEheJPP/qY8HOdFg5c0h+5gAbI1rRLgLv24=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bUMhYCtKK165jFbEstgkLF8nHgFZkgAouOJIH3GitICCXBnEQApU6agE3+pMxNU+8fIMYy0rV0qF6FXILJMf24QRZ2+nDOBDAeM9qScqCren/pDhyfLJoRKyMx+7wVZ0DqdA7IuzzEIUHjewIWj8V1/FdcyIiqddz/vhHVLyCEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA39j0q9; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA39j0q9"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39faa67fab8so26186141fa.2
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 01:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787041540; cv=none;
        d=google.com; s=arc-20260327;
        b=GdGudXirkw7Lb6jx5ZwZGn0HEvbAKOdWgiqC53a1avi8Qqv+YKGS+dV8V/BEFcX0wW
         u43UwhpC/dW2gU0m06f8z0fAvmCy1gnwwSVaAHc+cO/gITRmE8vKWroUQfaNilyEoci5
         mkpRfPWexzz0XHCeRaSy4tDYGtIoFJuJzgSS9B7+P2pySHosGa+4N/L79a2prFFp1XpO
         /q1ERzQFR3VoSsY0Dc1D2AcKp7JjmgceCmiHcAZYPT+V/IzIMtQ1TaOTzYs9nnCbZO8d
         IX10tLqzzxOqHn/kt3Vs/AdJ+8sNpVlt/NC1/cirPH7YAX6phNOY0RNj1bQaGQUaYyUC
         /8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AFqjh8HzrXpWibQdtihVChZ+YGjEXJtHt987hhzQmKs=;
        fh=fDErLyCTzCcXKuys+ppZZsOENitZZAkUlTLqgF62ty4=;
        b=Q6VzVsjH20JhH6OjCqrP1flQqOM+gzFi49Sc3Tft5clJ7dTs91zMC9kyF0ypexJDEg
         TRlFapvlGWQ6lxn5MpECfrtbZV1Lbj8CZRoEhwgbVwBC2h4yP4/sFomSQFAHp4f/VkIC
         UIoCJnHXJEw7FkOGW3jn6dZQuVIHwItiWshlFgHszdLf1Z6UNwkhTTOVUAicTGa3SQtk
         QwHDFenF4EALvG4J1FDkTkfK7y0R+4yMW375mKWqQxaQ5NhStyPtTHKm9FdeNEGbd3uU
         8zbNIqBBiMjzxyavsymDXLmnpE1yf4+ni+n7Pl/Zw1PtWZefPrjeB3y8ChaWnZX3C3vY
         Dkdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041540; x=1787646340; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFqjh8HzrXpWibQdtihVChZ+YGjEXJtHt987hhzQmKs=;
        b=ZA39j0q9mwAJRkAWxKGtroIIAtNUI5Ng8vUyGEgmxB6VhWrqDh+MzBtG8Z2Df/jOoA
         sKW4ziafRZ89eiDGouyVqnt1PXk/1O3QLh6hAYgv5orGJZnbE0oge/pHh7CV+zuKT8G3
         LYAxskEDS9JJNgDdFF9hk2gPRZjlg5mPuwHymO/N4LHUCFpWhP6EkSG1dJnInR4tos/K
         ZHnu9unsPTJl/Jrq0ih0Hc9tXYnz+gZx+gYRTK3A1CU0Zzr1fPiVcUDEj6bA3PZt1fD4
         bD19Mspm7t+57cdMcddzuK7fYPodTw+qhnA2QNdgsfZbCH+MC0arDY6ZNDTbV0swWeGy
         ypRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041540; x=1787646340;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AFqjh8HzrXpWibQdtihVChZ+YGjEXJtHt987hhzQmKs=;
        b=YlrnD1geq3TZKHdC7Em6VJY2HVe8lJ07vdcnduS8+Vpy6K5DwXlizsvbuKtwbk25t7
         VPR/bpA/f295NHlHWEHoJ17RlDZEXj/DzYwxssStWTQ/7WlCLDftyp4OlihvIUqXZDHz
         za9Kuxe8ij0qrtTLW4zWtOrfaRvYLeNIKOD3GPE2Ioc7EsUNJVthktLN5jg8yJeKixGR
         TUvVJNYIaYiT4eYW15bA641VJ1JzPebKCXAN3vhAB/cTEMcF3JZNX4fUW/Pj5njmNEuz
         Iu44n605re/z/s+xL6g+fg5cPiY4lU9hpK3CTJpw426Yk2N4MoIEGtRJG3GxMETjy2ej
         xgYg==
X-Forwarded-Encrypted: i=1; AHgh+RopnnsxUjrWNG9LyHatf+5N3kSkW2iGZ6Wr25KxuxWl5DurVzrRGntGSiS61ABlplWGgPdeg2DMfB7Y9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/Y1kXh/PFxB0MzX2DQ5//Ckn05Q8qp5a4xBGBverGJ0VbAgd
	glAKcHR/b6v7PoiyTJHDnuqJR6Sivx53ryVlE7ueqKSJZYDwGFslXDUFAsj7wrUlF1nEYIK1536
	zbDS5kue1rkgX37Of4NqdmoA+7mwteTDTSefY
X-Gm-Gg: AR+sD130x4IH328PScSABD1tygyv3lUbFptX8pJpQ3lD0A/OORAqYJzE+tzBxuTV7E0
	F29zC5Aitz1Podp333mcHcbuySjg5wqWFTy/7JixpX5q80Spo5rWFq5r+vWOMQsZznYWA8rVdyk
	oOgnG7HK8GJo2omxtSKHmseIqZooNeIg6dDivuIJf0ATO8NsdS0Q9Jr4tg+3QQEWMKFV5PKFETb
	4VVyIC4MKzFswAkadgYH7N7cfxM6P1kVeM/HvIwmbbfOiMLHA6jB3bpVGtjxK2XHeKSILLV/TFn
	kvO8k9rT78+ZV4Mj+YEe3MqD3ros+eKikVB+Z7Fc5TpMEg==
X-Received: by 2002:a05:651c:2103:b0:39a:ee64:36f4 with SMTP id
 38308e7fff4ca-3a17516851bmr8813871fa.1.1787041539838; Tue, 18 Aug 2026
 01:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: PANZ <panz.development@gmail.com>
Date: Tue, 18 Aug 2026 10:25:27 +0200
X-Gm-Features: AcwNN1VRNToSE64_qqetuINC4oPAxG8EulkO8jxh2qP4RjtvZkYBWSdc6WMgTOM
Message-ID: <CAFinCN9OV6fS8acwZjqsp9WR7r9tKk2afdc0y9RuAsmmmJpWnw@mail.gmail.com>
Subject: [PATCH] HID: asus: fix touchpad multitouch initialization regression
To: jikos@kernel.org, bentiss@kernel.org
Cc: denis.benato@linux.dev, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In Linux 7.1, commit 7253091766de ("HID: asus: do not abort probe when
not necessary")
and commit 0919db9f3583 ("HID: asus: always fully initialize devices")
introduced regressions in the probe sequence for ASUS I2C/HID touchpads
(such as on the ASUS E200HA):

1. asus_start_multitouch() was placed inside the claimed input check block:
     if (drvdata->input && (hdev->claimed & HID_CLAIMED_INPUT))
   On ASUS touchpads, (hdev->claimed & HID_CLAIMED_INPUT) evaluates to
   false during asus_probe(), skipping asus_start_multitouch().

2. The asus_report_id_init loop in asus_probe() was executed unconditionally
   for all devices, which sends keyboard initialization feature requests
   (asus_kbd_init) to touchpad endpoints, corrupting touchpad probe state.

This patch fixes both issues by:
- Skipping keyboard report initialization for touchpad devices (!drvdata->tp).
- Moving asus_start_multitouch() outside the claimed input check block so
  multitouch initialization is always executed for touchpads.

Tested on ASUS E200HA (where touchpad functionality is fully restored)
and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).

Fixes: 7253091766de ("HID: asus: do not abort probe when not necessary")
Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
Cc: stable@vger.kernel.org
Signed-off-by: ppanzenboeck <panz.development@gmail.com>
---
 drivers/hid/hid-asus.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..7f19ca1e5a1b 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1294,12 +1294,14 @@ static int asus_probe(struct hid_device *hdev,
const struct hid_device_id *id)
  return ret;
  }

- for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
- if (asus_has_report_id(hdev, asus_report_id_init[r])) {
- ret = asus_kbd_init(hdev, asus_report_id_init[r]);
- if (ret < 0)
- hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
- asus_report_id_init[r], ret);
+ if (!drvdata->tp) {
+ for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+ if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+ ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+ if (ret < 0)
+ hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+ asus_report_id_init[r], ret);
+ }
  }
  }

@@ -1327,12 +1329,12 @@ static int asus_probe(struct hid_device *hdev,
const struct hid_device_id *id)
  drvdata->input->name = "Asus TouchPad";
  else
  drvdata->input->name = "Asus Keyboard";
+ }

- if (drvdata->tp) {
- ret = asus_start_multitouch(hdev);
- if (ret)
- goto err_stop_hw;
- }
+ if (drvdata->tp) {
+ ret = asus_start_multitouch(hdev);
+ if (ret)
+ goto err_stop_hw;
  }

  return 0;
-- 
2.47.0
