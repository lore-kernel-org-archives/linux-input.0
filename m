Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54D34CCE
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019611; cv=none; b=CXRdNzmEY8NuFbfMzmAlfQiCy1dJdaHOxS/1YUsP94WrIYFVQEj2E4emlNjLxK9+kkTrsO0f/rVbl8spm+tdhOadHO4B1R9D71KuYdwNkk+Dsi2khopI0gr/qBTlpw0PDf7vSnv+BKjl+DG1gHnaex9Jqe6CaPQoDL4gqh8eXQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019611; c=relaxed/simple;
	bh=I/plwBxc++UJ+jioVz1M//rUbXgAOoHz3L0/Hciv0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojFWxJOx7+jaTpXUiPlIahkjJN46mcJUfgrWoIWnk2s7znXi584/JjGlt7JhR2JKGsn0kpRH1areLlq7/gLWJDBEoAwnds4jDPsKl6ZEDHhmTg+zPsAznLS16bUMZzkc9AKbbz1PXIegycUy77V58PHgcBJveYDOSke963CP90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLlm6LMv; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLlm6LMv"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-910316a2fc9so83558786d6.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789019609; x=1789624409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+IUBTvGGBhuQSgUbVMulefp5IaJyfqFJXLQOxcv7UtQ=;
        b=HLlm6LMvSEBLuM7wZ8ie35j/oaXZDncFsnDrEDwxly40SIbyiU5dIMOxUFGXoV6GhR
         O4Sqa049Dvg2r4TFe+rq+ND0MPM+cVBher7X+prHB0iErsB7oR8DS8r7WCnSe29BqIva
         3GOe4Z7ycWoGRpqdbHOZonfGFgBqDosZsVattchgEOjNXDzW2cAmAZcikxxrGbTpSF/A
         YNdMJyTajCoN1JHi6I11YI+PxkMN82yXk9yFr+Brh4la2mjYiLNU4zQuC2rACbcFxRnp
         CbxHhb1DomktLR424PxYHOiY8QzFLocJaeyCvAUuUqXyyHJuRMe5E0dr6wRao/ZOo0za
         wFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789019609; x=1789624409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+IUBTvGGBhuQSgUbVMulefp5IaJyfqFJXLQOxcv7UtQ=;
        b=rr4b95K8YiQxOzSi0aRGBhpAhgjtvb69pAl6W1A+LAczhlB9IZw5Iow2n5+LzFdYpA
         dVXKrANgJCv3sOUWKiG/ggGbOJ3BAM7UovpI2/Oa97MmKybk3GTQX+S5owgH7GgtZIdW
         1HhCVxB3wlqUF3ND2NXlcjPcJvx8GM3/yHLm2jK+224IexRdkHp6UHJhZdfTMQrtm+uk
         vnfNa48K+EK0Z+xee+XYXjvit/Pchsznj/0SAFXRA836OxIt0pKFuUU5OaSuAs9eRsHJ
         3qTIFMKItNr52UnL6HShwiXuC7o4f9jiYoNWkm3AHEEksRZ6O3WvXUpBv/Jietrk/zeq
         aHbg==
X-Gm-Message-State: AFuF++m3LV+C+T6oNR4Of4MxyPniSQSt/+AEzTJY3X4Vno83dX5hF8Ma
	kwKXkSF+Y5VLCCfeWRR6LzSJiGZcHnv67ByTBdT3BFYwR1T31xnJmbUap8MiB1n3
X-Gm-Gg: AYBFou0lf6GoPYnemCVzFrwGwkdCmhsm9zIXkrWVIYHaUGHv4uAZCNqyPu/n8y+qY37
	ozVcmwrY1+g7PAHODj+sChxpQ/+DE3rt+BgoR7pZiZqz8KG6anWnhRL3p1djQyn7wtrOMeIgy4H
	qp5D8ecm9e9/EWwokuAXdYvMJNI83J3Uep7DB1wjfrYCNMR92gK1FHdfrfMZlewAd9v+bBzHJ/P
	jaLBzYB/SKAEQ4+proPlmexN5AZR22tWvcEjMcbPlLLD3BLqjhhtXSWatCDf5805bDCtZJ4X///
	4c5Kh2FpgnjNAeM+r9Qv/DodHociaWVuwUMqRS3fLtKnU7Z9X6YGv1ouDArLpdpMdbqV7N5L5Mt
	Roc89GzWHXafNL6oIYuLtaI4b4YdZD3+KhGJOIHpvTM5kBrzj1Or1g1RkVfc3YnVC/HABgh4ivg
	oaMGI7grx0UUV6BPWMkQBuO9BpcGpS7UTZRwdnGgMJR0dL/nzeuu6TkX02EzKPaSqt8IBv0zXy6
	xclgd3FTGdDwLVl511VSRTn6Ll6b+CNGVMircLtD1i0epMNf+phJVhTHXufClNVRZB6ibwYVfPC
X-Received: by 2002:a05:6214:262c:b0:90e:8ce9:abca with SMTP id 6a1803df08f44-9103ef2f4a4mr486781836d6.14.1789019609232;
        Wed, 09 Sep 2026 22:53:29 -0700 (PDT)
Received: from omatop.tailabd03b.ts.net ([2607:f2c0:b17c:7400:2d95:6f24:1a92:cd74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040663a87sm165907856d6.19.2026.09.09.22.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 22:53:28 -0700 (PDT)
From: Ryan Doupe <ryan.doupe@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Ryan Doupe <ryan.doupe@gmail.com>
Subject: [PATCH] HID: asus: pass through ROG N-Key Win-lock reports
Date: Thu, 10 Sep 2026 01:53:03 -0400
Message-ID: <20260910055303.1238743-1-ryan.doupe@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS ROG Zephyrus G16 (USB 0b05:19b6) reports its Win-key lock
state using a vendor-defined input report:

  5d bf 01 01  lock
  5d bf 01 00  unlock

The firmware sends these reports when Fn+Super changes the lock state.
While locked, it also repeats the lock report when Super is pressed and
suppressed.

hid-asus filters all reports with ID 0x5d or 0x5e as continuous AURA
echoes. Since the driver's raw_event callback runs before the HID core
delivers reports to hidraw, this also prevents userspace from observing
the firmware-managed lock state.

Pass only 5d bf 01 xx reports through on the USB ROG N-Key Keyboard2.
Continue filtering all other 0x5d reports and all 0x5e reports.

Tested on an ASUS ROG Zephyrus G16 (0b05:19b6) by reading lock and
unlock notifications from hidraw while the EC suppressed and restored
KEY_LEFTMETA.

Assisted-by: LLM
Signed-off-by: Ryan Doupe <ryan.doupe@gmail.com>
---
 drivers/hid/hid-asus.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c38a2b3b..7e2eed8f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -100,6 +100,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
 #define QUIRK_FILTER_CAMERA_COMPANION	BIT(15)
+#define QUIRK_HID_WIN_LOCK		BIT(16)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -505,6 +506,16 @@ static int asus_raw_event(struct hid_device *hdev,
 	if (drvdata->quirks & QUIRK_MEDION_E1239T)
 		return asus_e1239t_event(drvdata, data, size);
 
+	/*
+	 * Report 0x5d normally carries a continuous stream of AURA echoes.
+	 * Win-key lock notifications use opcode 0xbf; pass those to hidraw.
+	 */
+	if ((drvdata->quirks & QUIRK_HID_WIN_LOCK) &&
+	    size >= 4 &&
+	    data[0] == FEATURE_KBD_LED_REPORT_ID1 &&
+	    data[1] == 0xbf && data[2] == 0x01)
+		return 0;
+
 	/*
 	 * Skip these report ID, the device emits a continuous stream associated
 	 * with the AURA mode it is in which looks like an 'echo'.
@@ -1689,7 +1700,8 @@ static const struct hid_device_id asus_devices[] = {
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD |
+		QUIRK_HID_FN_LOCK | QUIRK_HID_WIN_LOCK },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
-- 
2.55.0

