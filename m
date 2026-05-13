Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040A4C9560
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689979; cv=none; b=Ec3g3IFtJHN5tv6/ObMfV49uXKIH6e+jyiut+H8veiSgMTyrqVXxydwUcSjACsuYgS5OB/IL3LRYQUOu3XOhCCHjnFW+i6ZMMHkekYgbcvkigehTq0Qd/bNNcIdYq1ldd/Qnw5joQ++ldw+NUt6d9xxT3uy5nhUKHY6/bW3/u5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689979; c=relaxed/simple;
	bh=9l1cf5l/s9BZh5Dj5WLjoKEWLGrfy9f+vNzsyBhdYs0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jx9vnFW0PP3cVEMtaVgbTwCN4S93J8zX2hI19Dva4ApJHBmZ+JyrWQLXqhP7V2rbduo7ZwW9Bc8JHgvkaOcRN2nWR7qK+dqSqGAw0xfyQO619n4L3ZJhTHSEr0De3k4R5GCqx1ttiu5lH4vnTl1E+VKaAzkS4qS4o5HD1J2dPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgmVr4kM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgmVr4kM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso28576615e9.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689976; x=1779294776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulEmB9xTp6jFw5NgM0gGCx+n2ddmEfGsCJtepGPqJ3I=;
        b=RgmVr4kMcsVnNtgxlB5Cp+PGHzc20Uh8X6UdSIAKV1lOMdYHidFpWsmXqQKBv8tdEw
         kHHBjs4+sgabPFL2O7UQzeS+L1p4t33gGwV80ExqXUQVZZwPyZ8vmD0hhnNrxMSTlZ6f
         kvF0ICoBIlqk19dO/O2PeXRW1k93aq1kyOuaiA4WbeDJyUY4ufsCxuHIFk/zfDkex40p
         1SJKD/O9UhAciGkE+NuOXMwFQAc6f1dMJ+fwbcCFYeYmd/5pbuOiNgTIg80NrF30JOGO
         C6puwQXP/8Z9Cq3H/+gHvL6L1Q99DAFaUpPa8R4D7wAkQeY+qo9Pvl6uu2saLXqo6baZ
         h+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689976; x=1779294776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ulEmB9xTp6jFw5NgM0gGCx+n2ddmEfGsCJtepGPqJ3I=;
        b=NASSpgD6n91ZKPTScH/2rjtkwHVeVUBMvnqUGCfjnKFWpNMN/rXg6Xy9ZygqYihV7i
         l/zUPodjHR3nBkVBitMRG8S8tLvr/ioTm4kE15ECaNPqPhkWnd9GGys3fJpjfTRLw5Fa
         G1jkV3J2bv0mgMH0BsG9j/ek88xWtOkRZnHR+tnX4ditiblAUakqfxJZaKHcJ7UvMvOf
         y6G8Y9wDasNzWxV6HcbCkq724R2b5aLJ3futUy7oxR27XEsjkuou/6gtWs7Ro1gXfft7
         in6pZdY26l9zFqBcjqMSLeilLDYyGw5ed7qXxyxAA3ZzWwnrcnIpHs6YUJ43LuA3D9E3
         +Emg==
X-Forwarded-Encrypted: i=1; AFNElJ9gkNpdAnA6e1k5n5NWEfosyixBLk0Ffi7+//8jaaxgAhTSzM02NeziOxptR7Y1MvySDklokOsNx1apzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQGtT9292QV2/jIHTIU/ANpRmOeQZe4dUm8u+2sklweW7Ow5X
	DdC2x1oXDYiWvXDYdVpaDDsuprirDSJiWkvWUpzDJHtdahcWjQdMthnJ
X-Gm-Gg: Acq92OHUqh6M30y+epPfMF5zMwT3nRm9fN9nJrtNmtc/uqzrZxwZC0QG4/2A2hUMiRa
	/aIxqoHcwnvwEVKQWFnzkOfDjxY/AOMTmFBtgboHc0Q6SAYB3psgPsv/UkwxpKyQeTde7ExK5WM
	QIW5n6w8XI5KOyMzJGbwMILO19y846PvpspiSgz1rM+aGvZMFRxltFmlqxk0tPitj8FJDL4eTIj
	6XxAIxIiXIIxTQvBQ91If1zEyN8tPSw0HMoMB+Roahk1Na970SdkDRO4+12bfZ5H7D3hVnXQDol
	Ebady9ZXd/lBatKX1eSbHuSFUkvO4x7ihGkvOmNU1uWk3fMvPOLYwgT2lkY2n7OK0ne7IhionS/
	p/Gpzq0KwA9kNi/xrM01LbSRswFbXvFV6Y4WVifUTAIlHeIMJ6xF99zxypeOR5qxQrCCp1DD5a1
	0Xv1i7YZuPd56+hRduvdAj56cxMg59gH93BqKoJCiF+ATG/V0x6P+X5eEjCHIbpcZAWzFvEb5Un
	AlbDQo=
X-Received: by 2002:a05:600c:45cd:b0:48e:8741:fd3d with SMTP id 5b1f17b1804b1-48fc9a2ca5amr57396405e9.14.1778689976269;
        Wed, 13 May 2026 09:32:56 -0700 (PDT)
Received: from gmail.com ([91.126.139.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6498cdesm2486445e9.5.2026.05.13.09.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:32:55 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 5/7] hid-asus: Fix input mapping on dedicated vendor HID interfaces
Date: Wed, 13 May 2026 18:32:46 +0200
Message-ID: <20260513163248.16483-6-p.pisati@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513163248.16483-1-p.pisati@gmail.com>
References: <20260513163248.16483-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
---
 drivers/hid/hid-asus.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index cf9184ed2d3ec..fe52fd63d61c6 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1376,6 +1376,30 @@ static void asus_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+/*
+ * Some USB keyboards, like the Zenbook Duo UX8406MA keyboard, have a dedicated
+ * USB interface for vendor-specific reports, separate to the generic HID
+ * keyboard or consumer control interfaces.
+ *
+ * The kernel does not register these vendor-specific interfaces as keyboards,
+ * or perform input mapping on them at all.
+ *
+ * To work around this, a fake keyboard input can be added to the
+ * vendor-specific interface's report descriptor. The kernel then combines it
+ * with the vendor-specific collections, and allows the interface to be used as
+ * a regular keyboard with our custom mappings.
+ */
+static const __u8 asus_fake_keyboard_rdesc[] = {
+	0x05, 0x01, /* Usage Page (Generic Desktop) */
+	0x09, 0x06, /* Usage (Keyboard) */
+	0xa1, 0x01, /* Collection (Application) */
+	0x85, 0x01, /*   Report ID (1) */
+	0x75, 0x08, /*   Report Size (8) */
+	0x95, 0x01, /*   Report Count (1) */
+	0x81, 0x00, /*   Input (Data,Arr,Abs) */
+	0xc0,       /* End Collection */
+};
+
 static const __u8 asus_g752_fixed_rdesc[] = {
         0x19, 0x00,			/*   Usage Minimum (0x00)       */
         0x2A, 0xFF, 0x00,		/*   Usage Maximum (0xFF)       */
@@ -1457,6 +1481,26 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		}
 	}
 
+	if ((drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) &&
+	    hid_is_usb(hdev) &&
+	    to_usb_interface(hdev->dev.parent)->altsetting->desc.bInterfaceNumber == 4) {
+
+		__u8 *new_rdesc;
+		size_t new_size = *rsize + sizeof(asus_fake_keyboard_rdesc);
+
+		new_rdesc = devm_kzalloc(&hdev->dev, new_size, GFP_KERNEL);
+		if (new_rdesc == NULL)
+			return rdesc;
+
+		hid_info(hdev, "Injecting virtual Zenbook Duo keyboard usage page\n");
+
+		memcpy(new_rdesc, asus_fake_keyboard_rdesc, sizeof(asus_fake_keyboard_rdesc));
+		memcpy(new_rdesc + sizeof(asus_fake_keyboard_rdesc), rdesc, *rsize);
+
+		*rsize = new_size;
+		rdesc = new_rdesc;
+	}
+
 	if (drvdata->quirks & QUIRK_G752_KEYBOARD &&
 		 *rsize == 75 && rdesc[61] == 0x15 && rdesc[62] == 0x00) {
 		/* report is missing usage minimum and maximum */
-- 
2.53.0

