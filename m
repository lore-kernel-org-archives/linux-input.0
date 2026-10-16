Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D64B95AD
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168451; cv=none; b=aw0ple4q4fBKqnghqX47KKCAtGuvz1B5tXTC8yk2TRf31YCgIFrPJ65Q5CJu7atRhPG19w6w0Lb8jynCOCb/Q/v6SwsoroqD2gBc5nH3i/cuQwghwENS4tKEdArLvmhGD80sHy9hthltbvXddPTe63if+ESDEtxHWQD/LAn7e6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168451; c=relaxed/simple;
	bh=usDo/7XNU6nwa282LnLeCFXrrSZq4xQm0JTd4N6BgvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxG18g/NoOfy2vXWcmIT4osmDEe+Z2/JoMEzgn98zGdn+AUepv4LIW6vWnRO7PzCK0hy6ITlYxvqBgn58AcSYAaStq9gJWtC6mB/kBkFzuOaogt+AzP+NzcvCItPez6VQVobyFzycGTG4OlZKceL9pzzmxEcEir3zF3oD87JCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMShfoUW; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMShfoUW"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917aca1aee5so1652306d6.2
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168449; x=1792773249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfpDl7tRd49YIT38CJTAU2+wIjC5qIySjGavAzs37iQ=;
        b=gMShfoUWUmJJS9xaQ0lQXRpiyC4AD+VdWYl8k7H6L8o7MWjkOkhjk1bK6yXiKa5Dyf
         vDckAMiNx1idXk9KezO/Eqho7+2igccbIoXSS0IArIVtKYD4nE0VXHEpbWyt7YZHUxTp
         ZLCLXIkCaRDTPEjhm1jHEWpg9XP9oeRAjfvOlpf3gqamWgW/XkXh2BSL6ukZdZSD9ffh
         fZm714EJTy+60BTT5rettwyjn0H3F/1UAzF7wlSLHXMToZ2ip3fYi/IV8Jgxn+hl4stv
         VEnUm1iiMhyuSaxkvIX1fYOdQZxdxFkutiKD5X3IAG73JvxM8vLLN2EwjN0ORJu4M4rE
         Gwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168449; x=1792773249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SfpDl7tRd49YIT38CJTAU2+wIjC5qIySjGavAzs37iQ=;
        b=SG2ToH/lNrfsaN2uS7DErm0YgKDn+QvUp8pGqKkkZs78gzxaHbD8GqJzqa8hmc8w0L
         zzZ5LSyxP3If6cgUCYQiim22JiJ4f8tGsxW4CmDygi3/Tm0CUG0qCiWJ94i2Macko0te
         KbE65N4ZdtMgf9NUDghU0Dihudqto4Rtz/lwRbVuMomAz3S3n2eUq5Me60j2wciLRruT
         bb1GBb354m+w9Iq4mV+mDCGkj3trN18R9PEkfMCGJzHttMOaR3hK1BUwAPzcv5sVOyqn
         R27t+3gkw4cd8rFr7NTC6yrWCYgu11DQbEMyeb8jRoKVZ/N5YtB86SCwIt72CSfZbCRp
         9hqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLi+o63EUbclDS8BSd5YFY/EQyIlwJNkB0uyVLMwgFAZ3awkkydhQGW4KSBujblf5rZcLZZcDl0g1bPg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLoQIHIHzHaehsf24wiS9m1YawXcxjBmP44uqOCaexTqQapMPEC
	F9B/DCIFvYpmzBtvaBYnFN+4uumJ/gf/DffX4pWGmFNQ8VLn1SOXdfvn
X-Gm-Gg: AYBFou11kTPAwe3gqQHKwxTZ96FqE0lKBos7EnOw8hNvv9wjUG/CsphVTYlMY1S9KP9
	eyBnDBM80ZBir5Gd780dmUi6AuhQP4NBR/UebrZ/P93Xh1Gs7MoAzTHRq0X3aaIBac3b4hU6WbU
	7nR0Rl0xCk27lbxacvU0UUH9GNaNhbaC4uD6o8bs1jYWSW6BnCBqL51Cuq95Jb2ScMq3+FLKWuq
	Et593dajPeu6thcn7yMRG2cHdvBF25k6Fk94vDYZcoPS2d9dMvcLdCcv6UatqJnUKwQyyUpgY+6
	eoxpqQHNz+WRW+gsHPK/tv4jr1daZ/CYDjuXv21tmmtPe/ZsK53wZKVgzkQjUlbH49DgvlQ7ELG
	Jigk8aBdHPKq6HicsL5fXgD//0Z0RM61thJXrTBDP0cAyPwpMuVjVrLvt76V1bBfuV3O/IrT9GC
	4YdEpdAgXu+ljt8kT8es+oYN/zVtWxFiew8tpQkUjA5MtkRXukYfTrI4MJ9bG0sRg=
X-Received: by 2002:ad4:5fcd:0:b0:91b:9232:2bea with SMTP id 6a1803df08f44-91bdf14dac7mr9565136d6.33.1792168449159;
        Fri, 16 Oct 2026 09:34:09 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcc47bccasm25272806d6.20.2026.10.16.09.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:34:08 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v7 1/2] HID: haptic: reorder try_module_get/get_device before input_ff_create
Date: Fri, 16 Oct 2026 13:33:48 -0300
Message-ID: <20261016163349.3293666-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016163349.3293666-1-qwe.aldo@gmail.com>
References: <20261016151343.3120300-1-qwe.aldo@gmail.com>
 <20261016163349.3293666-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move try_module_get() and get_device() before input_ff_create() in
hid_haptic_init().  The original order placed them after
input_ff_create(), and failures went to input_free which called
input_ff_destroy() without ever setting ret.  The caller saw ret == 0
on failure and kept a dangling pointer to the haptic struct.

With the references acquired first, all failure paths reach
stop_buffer_free directly.  The flush/event save/restore is no longer
needed.

Also move input_set_capability(dev, EV_FF, FF_HAPTIC) after
input_ff_create() so the capability is not advertised when FF setup
fails -- the caller masks the error and the input device may still
be registered, where EVIOCGEFFECTS would dereference a NULL dev->ff.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb..9753bbf 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -419,8 +419,6 @@ int hid_haptic_init(struct hid_device *hdev,
 	};
 	const char *prefix = "hid-haptic";
 	char *name;
-	int (*flush)(struct input_dev *dev, struct file *file);
-	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -499,39 +497,36 @@ int hid_haptic_init(struct hid_device *hdev,
 	fill_effect_buf(haptic, &stop_effect, &haptic->stop_effect,
 			HID_HAPTIC_ORDINAL_WAVEFORMSTOP);
 
-	input_set_capability(dev, EV_FF, FF_HAPTIC);
+	if (!try_module_get(THIS_MODULE)) {
+		dev_err(&hdev->dev, "Failed to increase module count.\n");
+		ret = -ENODEV;
+		goto stop_buffer_free;
+	}
+	if (!get_device(&hdev->dev)) {
+		dev_err(&hdev->dev, "Failed to get hdev device.\n");
+		ret = -ENODEV;
+		module_put(THIS_MODULE);
+		goto stop_buffer_free;
+	}
 
-	flush = dev->flush;
-	event = dev->event;
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
+		put_device(&hdev->dev);
+		module_put(THIS_MODULE);
 		goto stop_buffer_free;
 	}
 
+	input_set_capability(dev, EV_FF, FF_HAPTIC);
+
 	ff = dev->ff;
 	ff->private = haptic;
 	ff->upload = hid_haptic_upload_effect;
 	ff->playback = hid_haptic_playback;
 	ff->erase = hid_haptic_erase;
 	ff->destroy = hid_haptic_destroy;
-	if (!try_module_get(THIS_MODULE)) {
-		dev_err(&hdev->dev, "Failed to increase module count.\n");
-		goto input_free;
-	}
-	if (!get_device(&hdev->dev)) {
-		dev_err(&hdev->dev, "Failed to get hdev device.\n");
-		module_put(THIS_MODULE);
-		goto input_free;
-	}
 	return 0;
 
-input_free:
-	input_ff_destroy(dev);
-	/* Restore dev flush and event */
-	dev->flush = flush;
-	dev->event = event;
-	return ret;
 stop_buffer_free:
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
-- 
2.53.0

