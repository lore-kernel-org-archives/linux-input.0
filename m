Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9F411673
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091839; cv=none; b=Dfy2RUfyVcovT55Jf/bX5mTEfPoo74ogMc1LHLxYgy94qIDef6TFoMxLyExX9al5UVvSANeQWuMgmctQIDesBCFkVvHzjKy1ibyABkNIo2pc/2Y2clyaie9L7/9xOqdhIQdbk7UZlvBnz8NROoQl4/pchbLnhsOeB0N9uvYgWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091839; c=relaxed/simple;
	bh=0eHW1w2sw8/QGjlmZcCx6sq7hihGPmbxeRNEM8aLoWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmLBHc+Pz6zSFpFW4dwwKtohz77MQ8QRlPJGbzjVA9AZqUMNUHoRrRTySTq9Nf7/jkHH4f91LFy1Zl8NH4t63WGsYgV8CPdLeK2pwBDjlAh8lt7H2I9yko8nneLZc3HweoidzmfS6lwV3clrc4FKK5vEI93sY5a1ZGohpXwzK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvHCWAAP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvHCWAAP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so184155e9.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783091836; x=1783696636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0Bc1ZmeOfqEtZgb3lF6zr0iTIVchQGs3e/FsoiNOcI=;
        b=pvHCWAAPTk6iA5zpH/Ry+A4wWFRuZFhEByMHyNX5kXmvi1H/aqVBHYuzgn6D8lDjfW
         F06YFAgnX9690y76aNRdIh2Dsxrq80u065H8VStVeLs9I0LhNpAvGFarDfbycBIQ2TZ+
         irm9LfmdWE1bmS2t06SONQGhr8fqrxSyy9x1zzrgOc4kDBXqu2d+muLYqrGsCo1iOYKI
         JcIxxD0t7E4iDf/iqsNi+WXSBa20TwQMfVxfM55riWzdLdmIT0BtWDLylH/bZa/lY7qt
         6sbq8EB6ilJu+QaNvdGAr7WObcG89HSEwNuD99t/pCBkPOQ7ejY4HvzK9uTFKsJXhqne
         SK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091836; x=1783696636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0Bc1ZmeOfqEtZgb3lF6zr0iTIVchQGs3e/FsoiNOcI=;
        b=oQWdyiIYItgYt71U6m+m47eVF+ozjCVvnKrOXB00PB8VSz/6cO4dnK1KyezSC4jr5I
         NaWFLfegPrpbttERGnfNULdZDvzAcjroQ6iVkeru8yn6WcbiovEmLzg2/dHnZ/rNcbZa
         52HAGPoC72MOBowGb+OZx5jSQip46G2fRnRhx3Pnif3QS6XdoC6rnkVAOD40lRKKdaqO
         YIX/xi/7ewmer/EUG4PWT2+iSdYaUF/z5Z1IBYLaueYNVOjpq2tRI523PZFFwhFR5avZ
         3RNvztPfLOXral26heahzT4VP0P7gtsMgC7FOyMnddVRXPanDL81dJ5rMAV0+fNJZYjd
         amZA==
X-Forwarded-Encrypted: i=1; AFNElJ/1xX8ZBIHZe6Yt43TjTjCMErzvZDzMUvbcYQci/R6DT3GTAHiHS7Uuxiq1NrmT2CbCbmNceRYWjbu0eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNvXvstmRI3IAHIPD2Q43OZ772DP/bdnaTRI0zlbI2Ay/N1Pn
	QWdNp8pNRrhMFnnUX/mIHKH2ZciCqDpfLR6le03GGhuS9zRq171GJ0sn8le2XV03VA==
X-Gm-Gg: AfdE7cnDHtdvay9n45sDrQwvwAyLKywn6AlcDao0B+03HLIyoODJ4ZpWhf6mCYyoNVV
	YfUocOtHPwKbWwX/RYRsBCpXUb121sWVatgp3VdlpM8ZdiWfgiSzflhG8vj9leALSKinIUVTEFR
	Cv+4LVXuqL68B0QYfXM/qdgc0VJXYOGm8wzPxNaADQasYLVd/vN4uU79bZezbMDLYbQ4+v7b00W
	vThYVU+biBw2Ix4nS17je9kLpuneZl6HhdzXnB6rpTIFstFzG8NRidOldKy58ewObqcIZ3sq8/e
	WsXDTXWQRBcb/U4Ehc/G0lIhliTy3w2l+hWxNx6yolLQCyxBVQYJPasgIHwMFPikU9gO1rXvizW
	9mqAlJs/lL6fovT9kl6MuzXnr9DPofZK1zTg5WUMFmRwKz/8LPVi29AvibXYoO+T8IVAmHui/Br
	SdQBGygOfLi0AMmJ9hz95/Gp44cV5AdC2lWcrH3UIDLpkgPkNE5dmPC/zo8u/rjZtBGDCl3wA=
X-Received: by 2002:a05:600c:b4e:b0:493:c1a0:7fdc with SMTP id 5b1f17b1804b1-493d0fe58a3mr22735e9.0.1783091835477;
        Fri, 03 Jul 2026 08:17:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960816sm7277f8f.29.2026.07.03.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:17:15 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:16:47 +0200
Subject: [PATCH 1/3] HID: asus: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v1-1-e80259ff625d@google.com>
References: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
In-Reply-To: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091826; l=1171;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=0eHW1w2sw8/QGjlmZcCx6sq7hihGPmbxeRNEM8aLoWY=;
 b=wpHZ0pNkb+9kdY42h8/fX9hLQ4JEwlogdTzfqlJmlDZYff14DfGxAFttmL4/rE4CyPaOHW8lf
 V4XZ7Hjg8/CB7J6kvzRpqlUM+x1ZWLCZyUBmKdRQGV/ZNUOrs9WVQQr
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-asus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..befa990b3210 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -753,7 +753,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+	if ((drvdata->quirks & QUIRK_ROG_ALLY_XPAD) && hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
 		udev = interface_to_usbdev(intf);
 		validate_mcu_fw_version(hdev,

-- 
2.55.0.rc0.799.gd6f94ed593-goog

