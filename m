Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC294A1387
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819768; cv=none; b=UJPWB6MQDxE7lwkzfpDXDJZlxGP6Zi/1GgdcCcsm1afbMCvr83ERpTWb/ez6SH8bc86vpS1anJgde5lNQQkykRQMoFCf7y0KIzwuOrLH3D7GRIAvvO967W3LJ9cf4EDrwOcNkDvx3uPFxIOsT2SevF+nBNnXh7fWZpGbVF9cBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819768; c=relaxed/simple;
	bh=M9dpQi4tgba0alF8ToireGxXNWyOZbiXHyjQLcZzwDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JptmkiPsLNUsPs9X/sgSuqA3d4PiZR6uQO37YbO+IZXZxxKorMIoGNpTb2aLzLbzcpsFFKbTOOb4tLxGlSaEgt6qET3SEU7wtTjqhbAM0iFU4UspzRz0RJi/MJFUuIfc6Ar1DeWbdVmfDYB1ZeEN/6lDSogh1lJSELr37kNAPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVpcPjgW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVpcPjgW"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1162133a91.2
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791819766; x=1792424566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u/2jqcJ/ml0TlpXSlqx8y6UB+yt84Zsc+jol0ebsN+s=;
        b=UVpcPjgWho+0O5cr65op1QK+LT8ao/hnHs6SUxzeXYUO+Y+46PC6HV1DoNNCoUA2DQ
         TCg/Iax8cdkgF9fTYMsNzZNWrseGHuNSTZ3REAaEKS+KBhcTNA5iX5ga2sX62foVzUUV
         Wwv7HcWUHT7JHEf0/aIppOz1wrVCui/MtWvWh9C94INhnnk3Y5XYFMqhHQ3ucWEKVUiq
         GX5/nz1LG9vVbv0sOFATzYLufQQhdF1Jt8y1ThmDgomlSGJ88HMVXV3qAyeQt8g5ZcX2
         F4PkjLPj3/ArWxXp19euDw0eX58pZ11tGczyd4HjH5V+PlBQMxAZLTFiMao7mhMzCTQw
         /7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791819766; x=1792424566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/2jqcJ/ml0TlpXSlqx8y6UB+yt84Zsc+jol0ebsN+s=;
        b=iI3nDUVA4KOLA2fq2ypXSN7GCqTANGa6ex3tpheZHa5RU9wKXiU/7JHq7oW1d5bsdU
         D7rzHRCoO+iXWTJAvqK2kYuBvbY7jA2H+JsyXWuMuB76bI0dJImQAzBgoT/Imw7vzV8A
         2XZEN3xogMNrLuxg3Cvi/uFIk9zS7CduUuBp6bTxOSReo39zQIba/15MK9ICeC48gUDh
         TqBggtsHk70czbxtTlYrixW+EOgPl+LfOxQs/5IP9pUo33Ir80gARxqIF7pTXzLzglL0
         JZoOj4AhHMx7zP8NvC3pzdS30MQyLffl4lxP81I3PdkirYKVgDAD1x5DpU9uCBNFrRPd
         robw==
X-Gm-Message-State: AFq9FYLfz32Wg6/lc/s7kSPRoQJPrw+IJqIlnVKkki6TOVZqAf8HzIY3
	1isHtIUMmp1VHya1toiPSEDmAPwJvMWDU1R6xJqyaPD4DqWsR0NKWJlziXT85w==
X-Gm-Gg: AYBFou0qFE3LJpcvhdJgGOU0k032XIvBFp7x5L11KNI5QuqpNpMCid8Y+3Bipl9KKzs
	Y7TvCUhRGdPQZeJ7p/HHj+7+n2wstY1qeUpqgX+Fw0lGXdD2aSSH2RRG1ygaurndn0KtiGr1CQ1
	IXlB9LOwCgLlFLphwULHrrzyCYkAxj/nT66Hi68g89T1/OyAb4QBUEDDGK0Ls5K2tyhuZ84dp8K
	INS7Y49vHeYLh7Hwi+LLcYnyW+SDHRrYZphxP36AV+U1R0dhYXD7ihylteIMbH0Z5lFqsfzNy9x
	zoWhAlTiWnYCV09u7ZAbp0fnqPftO5qaFRCgj+Em3z6h5cIAe5DNSY/kK5iYtT8E4xBDfBFOn2y
	ciUTARV7vli//me4FGSKOt/pVxY7BiDoUelDrR1Y1oUn2dW2zktchNb+vfxTtw8VAwzQMjhpS5N
	QDeTOwZ+WC6OZmrLOl1C+6iAcbEcYLP4PrbD5GF6ZmyDiT6KUwaA4ZvQKyNGFSTaPPlYfZMByth
	M3s6zOKEx/V1S4H
X-Received: by 2002:a17:90b:1d03:b0:3a5:de8:2c4f with SMTP id 98e67ed59e1d1-3ab3b04c2d0mr6638993a91.65.1791819766331;
        Mon, 12 Oct 2026 08:42:46 -0700 (PDT)
Received: from ROGZephyrusG16Air ([240e:b8f:977f:f400:ec2a:b15e:fef8:70a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f46dfesm17098384a91.8.2026.10.12.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:42:45 -0700 (PDT)
From: Liang Haowen <nbg2974@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: add ALWAYS_POLL quirk for YJX-CHIP EWEADN wireless receivers
Date: Mon, 12 Oct 2026 23:42:40 +0800
Message-ID: <20261012154240.33221-1-nbg2974@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 2.4 GHz receiver in EWEADN G5 wireless mice (YJX-CHIP A8A5:2255)
presents its mouse data on a standard interrupt IN endpoint. usbhid
only submits read URBs for an input device while a userspace consumer
holds it open, so on boot or replug the mouse pointer stays dead until
something opens the node.

The same receiver ships with a number of other EWEADN models (A6, A7,
E7, E9, E11, G2SE A, GS02 Pro, S7, S9SE, X23), so the quirk covers
the whole family.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Liang Haowen <nbg2974@gmail.com>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index cb7f16d..1ccdfa5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1633,6 +1633,9 @@
 #define USB_VENDOR_ID_YEALINK		0x6993
 #define USB_DEVICE_ID_YEALINK_P1K_P4K_B2K	0xb001
 
+#define USB_VENDOR_ID_YJXCHIP		0xa8a5
+#define USB_DEVICE_ID_YJXCHIP_MOUSE	0x2255
+
 #define USB_VENDOR_ID_ZEROPLUS		0x0c12
 
 #define USB_VENDOR_ID_ZYDACRON	0x13EC
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 96a36c5..92bd84e 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -222,6 +222,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD2, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS), HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD), HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_YJXCHIP, USB_DEVICE_ID_YJXCHIP_MOUSE),
+		HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_GROUP_AUDIO), HID_QUIRK_NOGET },
 
 	{ 0 }
-- 
2.55.0

