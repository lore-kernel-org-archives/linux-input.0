Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0928CF6F
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236249; cv=none; b=eTqxJAEgDnSV/yfthIT2qaEITIH5iAeQvIj7qCZU2bMaV0Q+NwJGW8Ftqe6iEp7sIRHmqYRFnZ+buysvR1X/7dv/gjklDgeLr5LUvrgZYAUE5gDLjGM+10Wpt8oehH0/5GeUtLmoyDoNI3MSynNbEzWGeDBfRIJOpTObs7jA/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236249; c=relaxed/simple;
	bh=xT83cWCgboG9zohOsFn2S0kQSxg4yq2xuEKYrXMDZO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx5VHAX4B3u68oWyZumfc6rcjKDO9EsVon0G9HsEyYvcP7k6jZzDOnp2wx4XrVMhpwlYscZKGR+ndT/s54fn3GSH/JoRkOr0HhTXWJvzTvqeFIA5UjN8a7FUNfKAcAE5NM4ibUAbl34Dpg0NvH+mWO/aGstfAvJr6mW2SX9/+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fid/X7P7; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fid/X7P7"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899c955f6c5so26908796d6.1
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236247; x=1772841047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t1rtMqAuIEi8Clsq4S655yskvEX9mAp8Bj+8ESGKPY=;
        b=fid/X7P7CgePiWcC12spbue1uM20wHDr+vb2yADBHBAcqeydmg170n0XRp6m9qR9c9
         hzvKejf+TFWZVlqdqd/1Uu4Wj1sYScNwlAKG8qKxLisz0Goags6YcyjQCJaRf62Mhh3R
         DQEFRhUrD9pA20mmugAK2pLp8V53ScsBd8QRoyB8Mu/Mr0/6hx2RBkncG2iTiVo87cOt
         bwxKGoJYRIn1J7rEN12gC1GEloPj98mhWkhn43IB8Xld6se8YJM90P1SKbAOPhPZCf98
         yoTmfg1Qm58DfKfrEGyJcrZQrgEmSJX48XDii6QTyjVjJqvCdFjBcK5o0Vw8Qjtkg3v7
         04TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236247; x=1772841047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/t1rtMqAuIEi8Clsq4S655yskvEX9mAp8Bj+8ESGKPY=;
        b=MH37aM2NNu7BDDc+S488pPtPIe6RXaaSIYg0uerHTgw38UBSG1JoepPwyNklm7n+H9
         AajXX+CTCH/K/vUU5HTTxMuIEtwmn6MRvExdf4trq26M2ZxmS8uFKrU40Z/Ig8xfkk0K
         NO70O11pEzMdPMXRmFAsgKqhlPEmVi3wEv+7GMYFX/5z1XY9Tnq0L1TJohmni4y0Wr/+
         +prNrSUFBVff72tnbFUaK5ZpfquHJJVvhagIqYltLqTcJbwjQvkIjbdlOAUyyisYvfIZ
         7XX4Kb1l8NvINV6HZ8E20w2vjsBXBWIYLO7RQHakBeA5EYBm9shAZ9d+eJ1DWLftLSbd
         PoaQ==
X-Gm-Message-State: AOJu0Yzewad4mI76g+DwcyrEcaXz1ifInecJs6tRuGn+AT72KqYWsMvK
	G6cZGVJQt1ZsUah3K0iRMnXyFufYyyP4eT4WeV3V7gTi3psh+YFcerPT
X-Gm-Gg: ATEYQzzb0PuA7PqawGoMkvg0BxD56qiJfYnToC6mPrgB6JZ/AKtZEvqk5iNRSydw/vA
	uY5OgrxUlCc+FjvHo9EZvKWYYm/Ffq0L1/CYugSQwBFEWLvqYGTBYo/66s7iwA8Otl+x4Z0nBPe
	X98MJXk5Qig2+cL3kjrO80qqDYOQidb4lz3i/ScatH/sanc82lnfdKppotguV2wcat6IuAVPHMu
	uEmBXjcH8QtPL2Htr1AFyhk3RHpRysXad3HLukIvC1GQQUUbp+P1Pn0dJso8jwHw6luy4E9QUHa
	C9b/4ISMVYvkaChb7Y6qG4KA0+OyCL40l58CCg8+9NTGTCwNiL1+XxDTdYpNcJy9wyT4NdJzxkg
	nIPw0BGPtaLPGKnugtdTshTq/pkaU2J0fEaj9CREsmcSeDsdHA29oSDEmAvAAphejhTxdQBLlkG
	JA7VDnAgBplCJu89HEgCrbstKTrSMw3wP9R7EUq1dCq0uTXIjAMLpyG7z/0f9I
X-Received: by 2002:ad4:5d68:0:b0:895:3b03:ab50 with SMTP id 6a1803df08f44-899d1f0b0a1mr66645176d6.65.1772236247534;
        Fri, 27 Feb 2026 15:50:47 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:47 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 02/18] HID: hid-ids: Add SteelSeries Arctis headset device IDs
Date: Fri, 27 Feb 2026 18:50:26 -0500
Message-ID: <20260227235042.410062-3-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227235042.410062-1-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB device IDs for the complete SteelSeries Arctis headset lineup,
including:
- Arctis 1, 1 Wireless, 7, 7P, 7X variants
- Arctis 7+ series (PS5, Xbox, Destiny editions)
- Arctis 9 Wireless
- Arctis Pro Wireless
- Arctis Nova 3, 3P, 3X
- Arctis Nova 5, 5X
- Arctis Nova 7 series (multiple variants and special editions)
- Arctis Nova Pro Wireless and Pro X

These IDs will be used by the updated hid-steelseries driver to provide
battery monitoring, sidetone control, and other device-specific features
for these wireless gaming headsets.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-ids.h | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b01704f37142..e16b8dc5edd0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1327,11 +1327,37 @@
 #define USB_DEVICE_ID_STEAM_CONTROLLER_WIRELESS	0x1142
 #define USB_DEVICE_ID_STEAM_DECK	0x1205
 
-#define USB_VENDOR_ID_STEELSERIES	0x1038
-#define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
-#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1	0x12b3
-#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X	0x12b6
-#define USB_DEVICE_ID_STEELSERIES_ARCTIS_9	0x12c2
+#define USB_VENDOR_ID_STEELSERIES				0x1038
+#define USB_DEVICE_ID_STEELSERIES_SRWS1				0x1410
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1			0x12b3
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X			0x12b6
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_7			0x1260
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_7_P			0x12d5
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_7_X			0x12d7
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_7_GEN2			0x12ad
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS			0x220e
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_P		0x2212
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_X		0x2216
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_DESTINY		0x2236
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_9			0x12c2
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_P		0x2269
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_X		0x226d
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5			0x2232
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X		0x2253
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7			0x2202
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2		0x22a1
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P		0x220a
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X		0x2206
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2		0x22a4
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_3		0x22a5
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO		0x223a
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2	0x22a9
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_WOW		0x227a
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_GEN2		0x227e
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2		0x229e
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_2	0x2258
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO		0x12e0
+#define USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO_X		0x12e5
 
 #define USB_VENDOR_ID_SUN		0x0430
 #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab
-- 
2.53.0

