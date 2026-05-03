Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23435F612
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793229; cv=none; b=Ni8ER9S+44gfOvloaTURlaUKstQb9kiEytWHreZSso0I9nBsXmuA08zaNI4/vQOfiRm0ich/o/pnhs0t9aXfFzEqTIo23+8aefWL7XWS2u9pITl/Ep7oACc2r+HamseiUuDIMot1a8jm9xiCJEb4wEffsK7wdr/8FlmfkMwHus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793229; c=relaxed/simple;
	bh=kFUC4AFFFacUelY7IpdtKgONXXfUybiHuxyG9k2k2Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo+dgn3Yu2xMQrvifiGKLInE45fuf6Mf+rFIDSppug92uwB6neWzaU1AEmTTDNCc+touypreSme99vANhG4V6D9XS4L8cbnnUFdEJ1Xrxd4rqrQ1qmDpDwSSaH5Ju0/ZOaDhVuMndT+OSGfjCOQ2R9T3mXQLKPtBHzGAyM3PoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6vwT6jm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6vwT6jm"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2589c26e3so27823345ad.1
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777793227; x=1778398027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu0kLs5sc7Y9WY+aPYAuq9avhRq7tFLy/KnTa79pO+k=;
        b=X6vwT6jm89OT5DlNqvLy2zgzrUDoDG9mjRd81ccN4M7bG7bFD/QAP61blRxYyOhECX
         g+iZzTjgz8CSFFk/coQG9kUZoZdhayBA5RRq/vg9kxXeFXvt8VOYevJNaagPkiKEgblp
         +BErdohT7HoD7BtBtLkkVRchLIzWc/bL7nGBI7GtVhi8LHJXbvALbExnLhQHAbgaodKy
         7MLUo5zc3+jIj7z4D0EO/+wnFdD4IuPyfadvPAFYmNu6s9nFDlal1GwoBtRwVGuEt37z
         oQvpY8+Mc9Cs8ECnj13PB8ecDmMoIj3kHCBzKfwRPpNNMDi7TPBuyCpp9saDf+IM1L6I
         fZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777793227; x=1778398027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gu0kLs5sc7Y9WY+aPYAuq9avhRq7tFLy/KnTa79pO+k=;
        b=fUOBvh8Hv3Zqe6YlAjfB2vrPde2iuelaIbywIS9kGQFwGUZ+so6MiFJpUZtqZOX7rW
         NiECOq9BbP059hwvAyGH2a/7n7BTX73FuGOEoZCDKnisn5jFhxsqk6ABhF2Qc71V6ygW
         2wS+YIZr9tnn/JvqjL9JCny0K58aS06p3C/7VGjY8Hzx1JW6LkZoQO+BVB+d68j9FYUM
         rwGrLv7d5s2dEaawPx72k2ZXTKZhnGyS9fgkBLKUH/FzheGymtyq7S/Gp7W3qcZ0EDwP
         z57eJBDLc+q49eBRpQ6DEeXMmWiaandfVTI+KZblJa19qC5dSufwcsiSV/pRy+aa61RY
         rY1A==
X-Gm-Message-State: AOJu0YwzEq4wKJL6aDaCTKqZ5KA/Gd+54vdJAVPvP8pc/mWnSNLZD/x8
	/wY05eTDOzd2k3UX1fzWlQSzVS8Fj7TLP1HP/mtpzF8+E+0GuzjwzEgq
X-Gm-Gg: AeBDietUxdewS3iJse1qDQ7msKGVBM6y86BegYLHPepKdCB3DiEVJ3XruiUh4p0+0cQ
	13ow2aACOxSsdxYfwqNcYzs4LVtU4yvqB9juceeRP8KJVI1d3qTLkFF/lf5Ts7kmrC7e3YJ9wUU
	GT7PhdK61KjNwPLwkjCQnJKhdxOaprsUrSsUkHNrAWDkVH53iSV/r1L6pgb0/NwdTsVVNfYK+DG
	VYXQG2l4qMGPtyEC2WeooUw1HavFfDSIv3nj46Zf1DCEZPRJtN6rDFjbDCdiYLSEf0PyNq/l9K2
	0pY1ku3FepOYnQotK6u5C+z40RSYqXDLAMb/cHLd+6eFF5rqxiMagAFtuDYFOauzEdJmdb84cUE
	7cA5DLgkFBCTVicdpM62MKf8KY4g4Tlt0T2S6oPplxKMbR3o5ONYnedYJNsbEKv2i4ppp4rQYCk
	lgN88GT6EtwiplQBXafKAOhqpyDbD5/gsp+8y3KoyeqHFRA/1wBh28x8L6pI7nYnBKI1gg+Q==
X-Received: by 2002:a17:902:f541:b0:2ba:1a2e:5045 with SMTP id d9443c01a7336-2ba1a2e51cemr4512875ad.31.1777793227409;
        Sun, 03 May 2026 00:27:07 -0700 (PDT)
Received: from tranquility.wa.lan (60-241-74-71.static.tpgi.com.au. [60.241.74.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16a9esm64942945ad.50.2026.05.03.00.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 00:27:07 -0700 (PDT)
From: James Ye <jye836@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	lee@kernel.org,
	pavel@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	denis.benato@linux.dev,
	James Ye <jye836@gmail.com>
Subject: [PATCH 3/6] HID: asus: add support for T3304 detachable keyboard
Date: Sun,  3 May 2026 17:26:40 +1000
Message-ID: <20260503072643.2774762-4-jye836@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503072643.2774762-1-jye836@gmail.com>
References: <20260503072643.2774762-1-jye836@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASUSTek Computer, Inc. T3304 Soft Keyboard [0b05:1aad] is the detachable
keyboard of the ASUS Vivobook 13 Slate OLED (T3304). It presents as a
USB device with two interfaces: a keyboard and a pointing device
(touchpad).

Basic keyboard and full touchpad functionality work out-of-the-box with
hid-generic and hid-multitouch, but function key combos e.g. volume,
brightness control, home/end/pgup/pgdown require initialization.

Bind the keyboard interface to hid-asus for initialization. The
OEM-specific report descriptors required for this are present only on
the touchpad interface, not the keyboard, so a quirk is used to add the
required feature descriptor.

Signed-off-by: James Ye <jye836@gmail.com>
---
 drivers/hid/hid-asus.c | 58 +++++++++++++++++++++++++++++++++++++++---
 drivers/hid/hid-ids.h  |  1 +
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ef9d5eba4dc9..e4c97fddfaf1 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -99,6 +99,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_CLAYMORE_II_KEYBOARD	BIT(12)
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
+#define QUIRK_T3304_KEYBOARD		BIT(15)

 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -494,6 +495,14 @@ static int asus_kbd_init(struct hid_device *hdev, u8 report_id)
 		return ret;
 	}

+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	/* T3304 keyboard always replies with 16 0xff bytes. Don't check for
+	 * acknowledgment.
+	 */
+	if (drvdata->quirks & QUIRK_T3304_KEYBOARD)
+		return 0;
+
 	u8 *readbuf __free(kfree) = kzalloc(FEATURE_KBD_REPORT_SIZE, GFP_KERNEL);
 	if (!readbuf)
 		return -ENOMEM;
@@ -1312,10 +1321,12 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_warn(hdev, "Failed to initialize backlight.\n");

 	/*
-	 * For ROG keyboards, skip rename for consistency and ->input check as
-	 * some devices do not have inputs.
+	 * For ROG and T3304 keyboards, skip rename for consistency.
+	 * For ROG keyboards, skip ->input check as some devices do not have
+	 * inputs.
 	 */
-	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD)
+	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD ||
+	    drvdata->quirks & QUIRK_T3304_KEYBOARD)
 		return 0;

 	/*
@@ -1369,6 +1380,22 @@ static const __u8 asus_g752_fixed_rdesc[] = {
         0x2A, 0xFF, 0x00,		/*   Usage Maximum (0xFF)       */
 };

+static const __u8 asus_t3304_fixed_rdesc[] = {
+	0x06, 0x31, 0xff,              // Usage Page (Vendor Usage Page 0xff31)
+	0x09, 0x76,                    // Usage (Vendor Usage 0x76)
+	0xa1, 0x01,                    // Collection (Application)
+	0x05, 0xff,                    //  Usage Page (Vendor Usage Page 0xff)
+	0x85, 0x5a,                    //  Report ID (90)
+	0x19, 0x00,                    //  Usage Minimum (0)
+	0x2a, 0xff, 0x00,              //  Usage Maximum (255)
+	0x15, 0x00,                    //  Logical Minimum (0)
+	0x26, 0xff, 0x00,              //  Logical Maximum (255)
+	0x75, 0x08,                    //  Report Size (8)
+	0x95, 0x0f,                    //  Report Count (15)
+	0xb1, 0x02,                    //  Feature (Data,Var,Abs)
+	0xc0,                          // End Collection
+};
+
 static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -1473,6 +1500,28 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		}
 	}

+	/* T3304 keyboard's vendor descriptors are on the touchpad interface,
+	 * not the keyboard. But we need hid-multitouch to handle the touchpad,
+	 * Add a descriptor with only the config report so that this driver can
+	 * perform initialization.
+	 */
+	if (drvdata->quirks & QUIRK_T3304_KEYBOARD) {
+		__u8 *new_rdesc;
+		size_t new_size = *rsize + sizeof(asus_t3304_fixed_rdesc);
+
+		new_rdesc = devm_kzalloc(&hdev->dev, new_size, GFP_KERNEL);
+		if (new_rdesc == NULL)
+			return rdesc;
+
+		hid_info(hdev, "Fixing up Asus T3304 keyboard report descriptor\n");
+		memcpy(new_rdesc, rdesc, *rsize);
+		memcpy(new_rdesc + *rsize, asus_t3304_fixed_rdesc,
+		       sizeof(asus_t3304_fixed_rdesc));
+
+		*rsize = new_size;
+		rdesc = new_rdesc;
+	}
+
 	return rdesc;
 }

@@ -1536,6 +1585,9 @@ static const struct hid_device_id asus_devices[] = {
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T3304_KEYBOARD),
+	  QUIRK_T3304_KEYBOARD },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0cf63742315b..ecf30e36a99d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -219,6 +219,7 @@
 #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
 #define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD	0x183d
 #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
+#define USB_DEVICE_ID_ASUSTEK_T3304_KEYBOARD	0x1aad
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
--
2.54.0
