Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68513233923
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567405; cv=none; b=YuZsx3zUqiO5uSRAwv7dPFbFuXG5Aq23BG8DVZfPlX0js0APmRdoQ9+nuclOcpDXiiAsYinyJY0fFmXn7r1QK+JEKNSBdJ1XesZ/AcKMjguuw6OcMIles4bNu7SfNIlo3Y6TN4CvnxQBMvUVrOIXePHVzL1daUCuEJNhTLH7XvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567405; c=relaxed/simple;
	bh=cP+4U9AC/n7DQ4j6Q+01Y8jJOSjSG1IbtukTRFC96co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4F9+Az6tvKX94ftpphf8h0dDkxmIyW6T07x92JudlGSb6ov/QDTMdNzBvfk5K09fSGgsiCdB6NsgWNkqZPAc5bu1wQaxHpU4iGRPHtiEHYDYp05HKaFO4TO98hQ+m1JHu05gM7XM/EY3aFHcWpNnzqUhiwD0u5BceHm9RwZICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOPNT2fD; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOPNT2fD"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c675de8e1dso721470e0c.2
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 17:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788567401; x=1789172201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFPE/GeLZQJNUjlVPHTUrDmhgIqHfBgziOiwOmM9ZNo=;
        b=mOPNT2fDb5crMGshoXFC2mEspNBHR7sIrIBZBidoQM5I+5x4RATIpHrDPM656G6T5D
         TPMtQgOSNJNwbRCfasl37EFPNAOo+ocNzS+WXS7k0orfre/Y/DiFq/g6VX1e2HnUz9rE
         CGfgurud6ROBGkwZL2C9TBBqavEn/vU+2pnR2/hWqD/F1ByPFP+McwV/scfn+lMwfOfM
         ihfjj/YZDOt6j6xGzkASSPVXaocfsfadNOKHGZz5XbttNgnpXTnTtQyrjgBIEBHiJykb
         V16ev4bNvQz6AeFiiisON3aJ5Lz0bWp3bKV6a0OmT2i93wfzcSKgMrfH/WLLtUOPMOxr
         Ondw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788567401; x=1789172201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFPE/GeLZQJNUjlVPHTUrDmhgIqHfBgziOiwOmM9ZNo=;
        b=PV9nc2DrTy3nOZq/nk2wC4du7pVeQMkzp5l1bq+aXtnLot9KJ8lE0zk/iLnXCXuBjn
         NT4P7D331viy6WOmEkxKjgL1Edz29Y2oU7hOnEa1T2eU5YUEFnWRbwhvXuTmYcFVsPbK
         X1dKzG0d4CouxfBOCHd+wqQkSlyA355H7gOxwWPR1lJ/tnqcirdjFbTgN300R4t32JYG
         9Y7vAVGaKTPmHk/iMeaIs3XgmzLxh1VqWwjJFZb/+CbeTQdMajQWQyMBLHPHUGbvJJIM
         gQu4K3NM9/H0HfbzJycCmViFRFDyYlTWBQktLVvpb37z9qXf9CqsiPHcU59FCsVZATF0
         s1fg==
X-Forwarded-Encrypted: i=1; AKwUvBzALoJOvsYJOqWJPkdV0R//+22yjsekCbPinnOIzVEI6QytZHd2JyOSWqLTDIMmucHpFp9sa2brzD9yFA==@vger.kernel.org
X-Gm-Message-State: AFuF++nSB5FxEHdi19JsC3zKqD8Yeofy+lRB3Xylu+cD6d1YQS3Q4p4Q
	ptDnErLJ+Pze08bZzML4x+ybmMd//ZvxXwEUHNm8jYPPvZHDym3Q1+W0
X-Gm-Gg: AYBFou2mhMa4xenRkMzLfXm9i1ygxh3xAWfrcbNnTZ2uXQtGby+016sM/GRX0g3sXJ9
	PpEloAvxw9Fjp/ujCBr5ZfGchHpYPTXW1Xsz27ux+eErS/OMQvmZmM3GFu+fTedXQpO5MkQ83EK
	/suk2aJU7B6+QW35Ex8BG2+UYMlblgWhZrrC9zDe4MsNS+qYXQZl5smssWfo8wYImyJ4UmpHiFk
	X+fy2t31YoBu2LWm4yERattnVqujtjt7jJX8nlMn7iOLZGSxYAECSfqzwqx6d66ep5fihaAfxpe
	SWbB8tLausy18uYF3pRgpo5UdzcE3aqtTH7jwT7LgFXfH9wWzaauSYiVdRpvHs36Vp/09H3JlEn
	9Idz6p5KrVHb9Oi8t5eA539ZlSpQExvFF0vDOAjihb1zOctjGcP0eTDlHLWhTVZLf2/T7izenLz
	GU8ZaZGPLpSSvFgh5JBES/52kL5hnRN1CEBRmGbKqseyk1P/KyV5zQ4X1+waY1dhz5UkaMxzh2o
	oPS5C6NdLZrrcQxEDTK3R1DEaVIbFql
X-Received: by 2002:a05:6122:4f82:b0:5c2:ac92:eb18 with SMTP id 71dfb90a1353d-5c7ed3f6d2amr4275904e0c.7.1788567401218;
        Fri, 04 Sep 2026 17:16:41 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ecac1033sm3210562e0c.18.2026.09.04.17.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:16:39 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v4] Kconfig: fix typos in core makefiles/code and purge remaining ghosts (v4)
Date: Fri,  4 Sep 2026 21:16:31 -0300
Message-ID: <20260905001631.108652-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following precise automated feedback from Sashiko AI, the active
lcd-panel-cgram documentation has been completely retained to prevent
UAPI/Sphinx tree-wide translation breaks.

This version properly stages and includes the intended bugfixes:
  - Fixes MediaTek interconnect typo mapping mt8196.o to MT8196.
  - Fixes MediaTek regulator typo mapping mt6316-regulator to MT6316.
  - Fixes missing CONFIG_ prefix on DVB_ULE_DEBUG macro in dvb_net.c.
  - Cleans up the dangling comment in drivers/leds/Kconfig.
  - Purges the remaining verified ghost weight.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/interconnect/mediatek/Makefile | 2 +-
 drivers/leds/Kconfig                   | 1 -
 drivers/media/dvb-core/dvb_net.c       | 6 +++---
 drivers/regulator/Makefile             | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/mediatek/Makefile b/drivers/interconnect/mediatek/Makefile
index 6bd656668..64170ab16 100644
--- a/drivers/interconnect/mediatek/Makefile
+++ b/drivers/interconnect/mediatek/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_INTERCONNECT_MTK_DVFSRC_EMI) += icc-emi.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8183) += mt8183.o
 obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8195.o
-obj-$(CONFIG_INTERCONNECT_MTK_MT8195) += mt8196.o
+obj-$(CONFIG_INTERCONNECT_MTK_MT8196) += mt8196.o
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index d0d318223..800fbd560 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -873,7 +873,6 @@ config LEDS_UPBOARD
 	  This driver can also be built as a module. If so the module will be
 	  called leds-upboard.
 
-comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)"
 
 config LEDS_BLINKM
 	tristate "LED support for the BlinkM I2C RGB LED"
diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index a2159b2bc..3b503695e 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -68,7 +68,7 @@ static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
 
 #define DVB_NET_MULTICAST_MAX 10
 
-#ifdef DVB_ULE_DEBUG
+#ifdef CONFIG_DVB_ULE_DEBUG
 /*
  * The code inside DVB_ULE_DEBUG keeps a history of the
  * last 100 TS cells processed.
@@ -320,7 +320,7 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule_handle *h)
 {
 	/* We are about to process a new TS cell. */
 
-#ifdef DVB_ULE_DEBUG
+#ifdef CONFIG_DVB_ULE_DEBUG
 	if (ule_where >= &ule_hist[100*TS_SZ])
 		ule_where = ule_hist;
 	memcpy(ule_where, h->ts, TS_SZ);
@@ -659,7 +659,7 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
 			h->ts_remain > 2 ?
 				*(unsigned short *)h->from_where : 0);
 
-	#ifdef DVB_ULE_DEBUG
+	#ifdef CONFIG_DVB_ULE_DEBUG
 		hexdump(iov[0].iov_base, iov[0].iov_len);
 		hexdump(iov[1].iov_base, iov[1].iov_len);
 		hexdump(iov[2].iov_base, iov[2].iov_len);
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 5a764cec8..f81d1f31a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
-obj-$(CONFIG_REGULATOR_MT6315)  += mt6316-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316)  += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
-- 
2.43.0

