Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FA3BADB1
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680843; cv=none; b=kx4gxVVa5PX6jg4NenvvthFWTVtjKeJHEqu2hmFEpg4edw0NKijTEo+4cZ/86u3ydvRtZb+C0n2saAVUrvAQ22B+uVrkFnKFIq5kD4M9php0FTCk8NOgIpU59dRNE3sBXG6gH8K0QqS2jjCdDCLl/4Sv+Xo3rJxMtXeFBS50NeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680843; c=relaxed/simple;
	bh=CV7PJ/AkuS3OVQC4qRK25r81fhUlw3tcyoD5zG2xuWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVLsug2vxd5vzLR6VlbrSgG1XmjYxl/SjttKeDVf0wlr2HMY2MoEp9kBlnY9IIhW1FY8/EXkzIF+fDwBEcYVCAu0PCzf4w2KCAJ5XAUGTtP59jGQIG4Suy0svo3oCkq+0qk9NUf+ChD/2JTRhwyC5Us3uC0NHIwvlsOeXdfo/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTimmRna; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTimmRna"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf237e1433so66351995ad.1
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781680841; x=1782285641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQQU22W7VTSf4/MX/qZ4Mp7nZueHJQY0chKpfiwWsGc=;
        b=BTimmRnaqgVcnJsntjOvUExa262HiAu+kJfeiAMkw74MHkFT6ThdABQCUvK+IpbRGg
         obsefHeGYHcjUFDHHV+LD80Ke8kfvNj5xuKW+fro0Vk7tgKKZqaNMZFpOf7F5imN4Q+S
         s4Eg4y706/yUQ67g41mcSznmIRYh6L6e/ZbitBiYFahxnZMi3RRFtb6+DqvclGArt67x
         RuwQnEiGL+pnNx4ytKhXJiA1oDO33BA5P7e0YWxJQhLWJ5/n0G5u5jR2bbK/wM6lPZPP
         +hC35rMW6MP9FT73r/oOwwZNqdNl+zEYxVeifzzYH3a62JY62yKVE9MwTZFCbl70myg3
         w1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781680841; x=1782285641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQQU22W7VTSf4/MX/qZ4Mp7nZueHJQY0chKpfiwWsGc=;
        b=Zxti6N7aWiNbpaflg0T1GS64Cl8G90KdilR5FryOcsnnLIEE4zw1BwZPQ3mOWtMwpf
         l7Ug+mMOGFHZWZ5HSZFxNbz2m3WLcepGX41VINzcxkr+g35Ad5WPdu1HGQHxTcfzboDA
         SqecLarmq2CjCZ3ZhfCGpUNsm2WaNFL/GnXuVuy3+J05WZRdA1tQpjsPJ2SkQ+jH/HE8
         ahIhYc6IFE/nZW0zcrWnDs5Z/yKTBWskL9UMymH6u27lY1m6VBL2VfNftWMc99967ZXa
         ObWQQ9U0uXULhsf0LVaG9f0hS7biLx/100F+Bd7jkfGbF/SJMG53LGzq1HAt9d8LCxLt
         F+fQ==
X-Forwarded-Encrypted: i=1; AFNElJ925TNCwqlNY6rp5TbnyQtySVLRfHyATU07flP2wRC0wRwv28E+8Wnu41w+XafT2g6z+Tc5+oMUD9fYzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTU9g5RxiLea9kkUTRhQmC4TNnWT1IxZ5lgXaGkKYa1UiPdgZ
	fXhn6FxwOzIzJ5l8k4gKycdRZj0n/89FLEDyAqPuQPgm2n+oSCN/u+0R
X-Gm-Gg: AfdE7cmIwgcMs7gxdjNF0Gkr8mRp1a21eODpx0u+yZxCVvprV59lloEG5ZXm55WI4cG
	fWtRYcgPaUVJ1kSj3AuONe1cv5W+vchn+MQPLht8iGzY5en9rRQMeUQhYgV1bFUJ9VkMjBXUWtH
	W91KSFqtjM8Zbx51Nt4GBAyIOCqhYEyS7PLWPOIRqryW/hiQvfD8aF0970ccEV0u9p78t518gxp
	A2CvgPZsP5gwLjGdIpJDKP9tw+advEsxf2vODs9Za44fFzVfYgcbbWlYrmFiEINqrl90u5MUhVk
	wfuh6xq2T/aDUDWKNmataU4Dhtdcb3WUgvpG1wxWA9WN47LDxuG2btxV1dFSofz7FxSCCDRykyI
	sy6AJ1ZBOD4l6/CGjKTDo4v5LoTTBhG706Tevh3QxuW7p1fuUiRigZO7npf4XA9uXvmF2V8K+Wo
	9E287by3a/CwchWI/vkd5C/s1zEmCAQSE5
X-Received: by 2002:a17:903:b86:b0:2c6:ab89:4ff1 with SMTP id d9443c01a7336-2c6bc0ab228mr23751795ad.12.1781680841323;
        Wed, 17 Jun 2026 00:20:41 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:1886:6b7a:3e78:272c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6be262c52sm11854425ad.80.2026.06.17.00.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:20:40 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2] HID: wacom: avoid copying Bluetooth input reports
Date: Wed, 17 Jun 2026 15:20:35 +0800
Message-ID: <20260617072035.3373487-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260606040344.4-1-ruoyuw560@gmail.com>
References: <20260606040344.4-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_bt_irq() duplicates the received Bluetooth report with
kmemdup() so that it can pass 10-byte input report payloads to the
common Intuos parser. The helper then copies each payload back into
wacom->data before calling wacom_intuos_irq().

Avoid the allocation and copy by temporarily pointing wacom->data at the
current 10-byte payload while the common parser runs, then restoring the
original report pointer. The Bluetooth report parser keeps using the
original report buffer for dispatch and battery parsing, while the common
parser sees the same payload bytes as before.

This also removes the unchecked kmemdup() result from the Bluetooth IRQ
path.

Suggested-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v2:
- Replace the kmemdup()/memcpy() path with temporary wacom->data pointer
  substitution, as suggested by Jason.

 drivers/hid/wacom_wac.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85625d..a29bf051ada7c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1192,8 +1192,11 @@ static int int_dist(int x1, int y1, int x2, int y2)
 static void wacom_intuos_bt_process_data(struct wacom_wac *wacom,
 		unsigned char *data)
 {
-	memcpy(wacom->data, data, 10);
+	u8 *saved_data = wacom->data;
+
+	wacom->data = data;
 	wacom_intuos_irq(wacom);
+	wacom->data = saved_data;
 
 	input_sync(wacom->pen_input);
 	if (wacom->pad_input)
@@ -1202,7 +1205,7 @@ static void wacom_intuos_bt_process_data(struct wacom_wac *wacom,
 
 static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 {
-	u8 *data = kmemdup(wacom->data, len, GFP_KERNEL);
+	u8 *data = wacom->data;
 	int i = 1;
 	unsigned power_raw, battery_capacity, bat_charging, ps_connected;
 
@@ -1242,7 +1245,6 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 		break;
 	}
 
-	kfree(data);
 	return 0;
 }
 
-- 
2.51.0
