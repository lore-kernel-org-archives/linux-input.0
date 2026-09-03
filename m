Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA404B66D2
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452193; cv=none; b=E+wX0sand6it8tkrBfAqnk7zV1snE9dT0URmo53Q+QCEDzRh2XOQW/u5eaJujRjwrD6Aheh7lE0WLEYS49EaJNVZjVEQkU/ccOzgg/YlStf4HwJXjq+XtJMG1b4EXiEdO32+wzuh98+zDieNPwkFSuqjjNGA12sVUSEaiuxrBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452193; c=relaxed/simple;
	bh=g5tqxRsOR91sQ3AW9yWcdpBPwVC0G7CKzdBkK2R6Pkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQya0BMNXaYR/a+MwKi2GAeK4NBXle2iF13BVDQuGP7hgIZ37HN5BuEpyucIeIPZa6RomAvkj3ymqXZk4aZDCavtE9Cee4Acj0WBK+WrE27XbUuk3q7MwS37VneihsRIYCarncFkzQw3ths+Sjr72Gv/zKtPyR/jTGcHo1IlAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx1sbmuH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx1sbmuH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d5cad1a6baso24324655ad.3
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452191; x=1789056991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSgXnjoUNknjXUvjoWtbCv44ddxbNO+yDLCL/qWWSsc=;
        b=Jx1sbmuHYqKlV4RlWdEciNBkReiuxkZjuKkpzmDodarS+oLC4Dxp87nCDIW8x24z6d
         Q/dcvfu/aMByq51WTzcXVxy3C/y7ESCS039FghOBp6EpxC19a0bFs0y3QBgvpOEpAfCA
         cWT7+gJsGxO+lxIdjHrxfu953fqcR9NcGBbxGHEQa4zxjPFKXO6wxCKB47i3dT3/5TqP
         w1DhT0+9RSu25aHsu4GlX24ljD2U+JDWD0Qb0VpYhMO49CR09D3xlMZzlNlR98VXpMQc
         xTNH5Rl9TCmslLpz5m0HNPd28IKS5cZ1ul7Z4fBJTMjszcupvMA33OvCMYcx0xvm1cvE
         kzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452191; x=1789056991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSgXnjoUNknjXUvjoWtbCv44ddxbNO+yDLCL/qWWSsc=;
        b=Z2iJPmtDSnhx/VYRbmcuySVHlkP3h2yDAy4S8uQxf13a3pGf8R0P63PnmHtJA8TH2Z
         3nMH8NAc2e51t1FLldvbihGUs6EEJkQ42nZ+DRspazgLb+Zxsv9KXxsrq8akrGEc5oUW
         F5imyazY6gTeJFUvHSiT2pn3tiyK84JwtoIXqiqrs8OmPGN6VpU4/i9SNDFZg2HbTuuS
         dMu2UNGjv3ZbTKzJTk7Czgz5tFw/E6LzvldxONvIrnyWxGQVtt6wCGMGrY1YOcjTindm
         E+j0Pzwczo1meo42KSTqXSRfcGwurN5Bk9LXTIWefRd8a8nWIZY68fRWbcRGgO3OJxn1
         l6bQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8VKJzN27SipwOeBKL72kK24Q4+yPmCJh/6f4Td0K9ImfvApRanvpUAM5JYJIl/ZqeVMG+6BFKW9dsJQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nrtXpVLjsZflF+GMI591Pa+hBdBz0/c8mcVX3Io+ZbKH6TCngg
	AK9NEPskyH5JJjCVsdoAFhhonE8BQjZ9AuCeRX8b998IrTIY3GXHP2E=
X-Gm-Gg: AYBFou2DbG1DUejRxHBtVJKjLWcWo7o2DJp2+rDUSEtIgFnyJpxIUYYv9IXdCDt5ykp
	UCTXHw+Bs3/V7INVmT9IoiKom/IRYFvwrz7xuhdDNymeQBySrEFdHzVW2pUvtRrLURVAwr4cPe7
	WWgW+FdXlZ4GUNi8YdQbHHYCV+4zCMyhu99j2LPfyTxd5DnL57GGrh4PQmj07T0A75WTaUdd9Gd
	YhINDV8iaRFWiQMYg/c5luD40b6e+zS5DD3IJaHl2OKgz7x5/NErY+v0mqxA47t9L08jyaevarW
	El7UK3VSSp9/Ivmh9/hYSWusQx7338MWtHwKTz6ei8JTCey3JwBMow7CQF5QKKOk58obxfirPLi
	ZY9hDvvO16bUwzys5cp6vqjVFD8mFb1Vnx2HNqu++ql6oD7cjNxjJOPfwNehQQltbcjBI8jY17U
	BL9zz0mljLXC821BSU/vcVktm5YOCIT81KX9Vifw5vDfFT4RW+RI2HeDYeOxrD2oign8jU
X-Received: by 2002:a17:902:d58a:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2db124a8c93mr2158135ad.7.1788452190951;
        Thu, 03 Sep 2026 09:16:30 -0700 (PDT)
Received: from NUC8I5BEH-shama.lan ([103.76.86.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe62d8dcsm12806095ad.26.2026.09.03.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:16:30 -0700 (PDT)
From: Youth Cao <cocoh2os08@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Xu Rao <raoxu@uniontech.com>,
	Ai Chao <aichao@kylinos.cn>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Youth Cao <cocoh2os08@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: i2c-hid: Add i2c-hid-quirk-bad-input-size quirk for 0911:5288 device
Date: Fri,  4 Sep 2026 00:14:44 +0800
Message-ID: <20260903161444.786-1-cocoh2os08@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have recently acquired a cheap Apollo Lake-based laptop that uses a
Hynitron CST128-A touchpad controller. While booting from a Debian LiveCD,
the kernel log is flooded with the following error (though the touchpad
works well):

  i2c_hid_acpi i2c-ALPS0001:00: i2c_hid_get_input: incomplete report (27/42405)

The CST128-A was identified via ACPI as ALPS0001:00, and the I2C HID
device ID (0911:5288) was shared with the Hantick 5288.

Add the I2C_HID_QUIRK_BAD_INPUT_SIZE quirk option to the existing Hantick
5288 quirk entry to suppress the kernel log flood.

Signed-off-by: Youth Cao <cocoh2os08@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 0e725a0f0abe..776dd14feba7 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -123,7 +123,7 @@ static const struct i2c_hid_quirks {
 	__u32 quirks;
 } i2c_hid_quirks[] = {
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
-		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
+		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET | I2C_HID_QUIRK_BAD_INPUT_SIZE },
 	{ I2C_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_VOYO_WINPAD_A15,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
 	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_3118,
-- 
2.47.3

