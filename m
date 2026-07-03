Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2341735F
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092436; cv=none; b=LgplrxiPnXzrpCbmw6tzjtKqwnOvM/mBYCBuZaDc4E5E6w/FhuKE2S8Nhbd56rIwxjpXaPvFVVAb+WwnYx8achfBfe21l11mhwgi2kjIwG7RiAYJN//C9wKrB8JEhkUCEZ3fE8Ij+rgneLHMmzAdgCsdgyYUvUE38YZsvmOeHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092436; c=relaxed/simple;
	bh=TukiYcyaL6HvstWzY9oV1D0LPs+P1LWTmZhuuNPqXrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=taVEe5fl1BepVDy+73f7tkf/UrvJOieRGFr+X1V2iI7mOLw6/hUMHCylQihAKiSN5sU36++stSO0tRwzqdvIE5lrjYQb03ougO99N1SjI+xlulWXihEJtoaSHI7Bvmef+Po0rpNZcEeLhXB/HhtoEobBmPvv71uII2za2v3NCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kxwh/pP1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kxwh/pP1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so184625e9.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783092434; x=1783697234; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7jpWuBmgCfnac9kWe4AodWLj+AdSLC8VyDipYsDjci0=;
        b=Kxwh/pP1e3GlSdUkvwxexCLYyk2B6pOPZfxTrOplLomg/qHxRy4ReW5Vn2GdNG+55O
         vrMeVpt1Vt6OFKofBjJU6wS194EG1PjS5cd7F75gV8cLOUCuy3g25/E/jMLfFtrjdl4n
         VIdTO41eWQ+T7FvuBWUY3LqaJMpsJSrHgawSlc+o6hHm02/xr9r3L5fhfMforWPGK+sQ
         ioJZvq0kQK2JNOVCTbTsrGDP6GDkQTz/eW6Uev/5qWkX/47Y1YsmpJpXFnLRFgzCMNiG
         Kj8ManE6UThUlEaW/BKnpuXiP0CA8BuliYFA4IzsaOwfuYXK66Nkgo3eLX1jaB1JqkD8
         yMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783092434; x=1783697234;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7jpWuBmgCfnac9kWe4AodWLj+AdSLC8VyDipYsDjci0=;
        b=fE8zx1hGpXjveuQq/eLBqv5s0R5eKXA8TWqYX5w1KGO7oXuTis8A9FMwlJr1PjaBmv
         zHne9gMZPjj6SWctinzSMgGol0OlcpSM7NorbqociBK0JDB6BFm5LL1xDoFYeK57BQHH
         L4xjivsSRJNOvRGMOQz98C9vkwpliBh0Jas1wj81YAicnLffFfse6AtX55VUOTCeIFMl
         lBkp9wo71p2kbSMEKeBk37VwMatpx+nOGUz5Kof96axyEuOQ1BFTh9W7Ihqx7SDKm+9u
         PQOkoirQUnV9WORk/XUaOHOpEnibjFO0p4YWimRO2GdZzpDiqy7EDVfQh1Qp7ap/rGip
         GshA==
X-Forwarded-Encrypted: i=1; AFNElJ+LIKqumtatBRJ5t18b7StefKVYmS3KETRa1RaVri18Joo74rDX4YZSKtADp+fAPNNnzQ7Fvp3HpCE8tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+w59bFZ+qUnLE4KXcBbYLpYRrn+HYjeJ1nfE22dgkis+XrPPI
	jWiy4R2sjV8dfAnj9ZiIAIxpzLTEP6WTOh101NdBHE9v5xCoqkH+AUu36v1KFKxCfw==
X-Gm-Gg: AfdE7cnTjMLUyx/KiMfF1bCBtoP0trgcJL5MBXNPKkg0CzFkGpAqijsTQWhF4WszNH1
	GhGy6ECYFXbeEYKF1sQv8iiQxd6SNRbv51VAcsXhjgIcBwzLNe9CztJe9S7G2Vpo4APIjTU4Y5H
	/IkXq2u+HpEPZcB/OHCe9OZFWh8chsWThOW8yuL6Pr7ew9mTL2PZGCg2uf7JmsUdHOyLL6/KTnA
	3nT3f7bDRKKTOP8f9HtMAO7j8VF06XCrt50Ft8fzJINZGayloMorSt+e0nAJiZ3gGw63yl/6Wnc
	G/5yzZBdXvqL4hQgUY7RPsTUv0mjrHOaOZxqRYYKlbhsza4s3nYTQh9VJj3XmVSulKKzsmv4t6c
	K7awjp/cwMqLC65XYJycYCYPOLG4xR/t9L/VYG0VjiMfw76DKmTVvOCkevtlrNMwKzfInrKnEu3
	XaGSbCkwlTaEus6VlDaoFZt3z4cJx7OgeNc8duyaoBATviGVF8Q9oVLZdvlUqghusd474mPj4=
X-Received: by 2002:a05:600c:b4e:b0:493:c1a0:7fdc with SMTP id 5b1f17b1804b1-493d0fe58a3mr39155e9.0.1783092433298;
        Fri, 03 Jul 2026 08:27:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6e4csm128009f8f.10.2026.07.03.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:27:12 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:27:06 +0200
Subject: [PATCH] HID: asus: fix UAF of ->kbd_backlight on !CONFIG_ASUS_WMI
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-asus-uaf-v1-1-1a2af2534eb0@google.com>
X-B4-Tracking: v=1; b=H4sIAMnUR2oC/yXMTQqEMAxA4atI1hOIFX/wKjKLWlONC5VmKoJ4d
 +u4/BbvnaAchBXa7ITAu6isS0L+ycBNdhkZZUgGQ6aimgqcZECrUTFaj9Q3nBem9I4IUrIF9nL
 8d933tcZ+Zvd7HnBdN+42d09wAAAA
X-Change-ID: 20260703-hid-asus-uaf-0b8e1325fc00
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Carlo Caione <carlo@endlessm.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783092432; l=1129;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=TukiYcyaL6HvstWzY9oV1D0LPs+P1LWTmZhuuNPqXrI=;
 b=XC0Y/aLHtVUdK7FUQMa2p9np9WV2IGgb8xx+nXYLcWs2l9I+0i+dkh4YaSSE+qi0S3EGr9E0+
 eEOGREV+LiQAxNk8xsse4T12xmiEnjNbM7o2w3o/NhX7dJYqDHzWTEU
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

On kernels without !CONFIG_ASUS_WMI, asus_hid_register_listener() will
fail. asus_kbd_register_leds() reacts to this by freeing
drvdata->kbd_backlight, but doesn't NULL out the pointer, causing UAF when
asus_remove() follows this pointer.

I have tested that this bug causes an ASAN splat, and that this change
fixes the issue.

Cc: stable@vger.kernel.org
Fixes: af22a610bc38 ("HID: asus: support backlight on USB keyboards")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-asus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..c2a5edebbd7a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -777,6 +777,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	if (ret < 0) {
 		/* No need to have this still around */
 		devm_kfree(&hdev->dev, drvdata->kbd_backlight);
+		drvdata->kbd_backlight = NULL;
 	}
 
 	return ret;

---
base-commit: 51512e22efe813d8223de27f6fd02a8a48ea2323
change-id: 20260703-hid-asus-uaf-0b8e1325fc00

Best regards,
--  
Jann Horn <jannh@google.com>

