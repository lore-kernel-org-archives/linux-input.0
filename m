Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB1233941
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512800; cv=none; b=pN9+SMLyGDneoYqFixv7yp09MZNdyrfqXdldBEeVyX9tnezIdNa5n/8vE2iPQzMMXG/695r5lc49UV70/MX5X0OtNcsIEt3CuZ+LTGGX5KZuCMWPvK5MKbGG9XmGJy8zWbM4737XkxXjwEgDL/uSYuDteohZZ5qFC3yDVglieTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512800; c=relaxed/simple;
	bh=0vTKycvbzbjmJvomuj/XgTFepo/EwumOAacRU/0stE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mlh9oYylOo/D4N69YN881R/HWQg3/NMIsmjpgUF+xLxIBCm7C/BOGiROjWv/4j9El5M6qJEyfmgaxNIMjgxDVk0JW0dY15ubh6BjsIj5nm/NH8jyuFDCrU4MHZwgn2stRKNWBttNnMBXw61TuaItAjV7Cmimga0woQmrnshScJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hucmf4cY; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hucmf4cY"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30246cfd41aso1420949eec.1
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512798; x=1780117598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X19iMzf/kdWvgmUR42/6jiMH+NpAJ73uf08bFK/q95A=;
        b=hucmf4cYYBTlZxqkQUigGRLyOCLyEKdJG3m2To+A29ZgQrEsuBMSCuOgecyNq0a3GK
         8lAecad9hAgKWGrSQFabuO768JXj9W4KWI2QTKVk9qfAx1EUZTgP/t6ZOf18P4vMXtnv
         Oa9UZwkwfpKKlhvRhJiUHWm0fAILIw9HRwWhc3UrEzv0Cyrsffn2wjTBXLRuuYVG1LtP
         WcW4N/mK6h8NcUjaLJ25W0Hg0OMD0XKkZtDvAnDnGeWmdNMfWASe0deTZouwgzQluPIv
         FL110CNJh+6k1U4W7Oqs0OEi6Bl3ws71Hdu96WgHC+4ooqLUdgAxxGSl778EipqyaYMn
         pDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512798; x=1780117598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X19iMzf/kdWvgmUR42/6jiMH+NpAJ73uf08bFK/q95A=;
        b=D7kt7NLQlS/EogJ2SyGGq0QRC2Tk61RQhMh3hmoM1VxH7KeN6zb/ZgRt+bRAXJR4zC
         ekhVwzsq9EXEvRSZ84BU5Uh6TfZvY89kR7/l+tbYb3bKWzF2BayeojRGro053YVnR8jc
         UnhLI1aX4HibZsm/pB7Hfl9rHjsRIFDZVSlKba8YOsmOxZbzSnAzguzEx07zHWpa22mH
         oxKwZ5EHybpYfHdyxrSJjoKFTmCijngTwBS2aQZC8VAS/CY28HP7r1pn3n5IKXNOAE07
         LkjIceoVlLdRdRPwzWJE0vOpcPlf8XytEEiXuImMrNgig2NuC+AYA02F1EWAGEWvbD3X
         nHLg==
X-Gm-Message-State: AOJu0YxfMCxdpapj042qTM4klhRBSb8jLCo7W1QHRVMLoUnuU/9+TnKP
	y+YTVHkRS8uXt33Xf8NtEaQ1WqxUOC3jgcXnNfkwEg0tcU4UiVfVhTttov+pGA==
X-Gm-Gg: Acq92OEhcjBB0azIDSXEsVI8TXYLRt06vHQg3kMbN5ZKD33EeEwlxgKKJQCLI/mt60u
	qw7dBbkU4bU+li+Lib/XXGQ/7PaZhQDXZx9Er/gzjmaHmsbuJsW3yyGoAZlg1dPNA2Q1y6Rz19h
	lZfXibBAQr+yPQh1QOxZ07DQjYiuXhYYn8Ay2PZJhiphTWq9WekJoZl33Ci4sH3WGD5WMcrcgE+
	RcjhuXpHdqIs+g/0q6n8ZEbOak7jrAh9qc6T+FvKz06YZ1k+LuO/4OykrkyTxsdyE5GtbOwN5Hg
	m2qx81UdbkTc12Dv781l7zLZhNBI594Xry/GktzHWU1QutpdMS6EdWaPk4aHwCl8nSGPn6I6rid
	2cR3q4Kose8Yj+65meSYWI4TkB3o+kVWsqJo414YMXUCuT3CmVxVL3ziI0GIDCME4P98QNYKhEK
	1HpXHkzJvqHEA7J6ncNyaJkwT2gQTB4uZzgSyen/d6+z76eVHrpnUklIHM4Crk2bE3okr43fXiQ
	rk2neK9m5yRGQ==
X-Received: by 2002:a05:693c:638d:20b0:304:4f23:68d3 with SMTP id 5a478bee46e88-3044f2446d3mr1548748eec.18.1779512798403;
        Fri, 22 May 2026 22:06:38 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:37 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 01/11] Input: ims-pcu - release data interface on disconnect
Date: Fri, 22 May 2026 22:06:19 -0700
Message-ID: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During probe the driver claims the data interface, but it never releases
it. Release it in disconnect to avoid leaving it permanently claimed.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 7a1cb9333f53..57d917387544 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -2090,6 +2090,7 @@ static void ims_pcu_disconnect(struct usb_interface *intf)
 		ims_pcu_destroy_application_mode(pcu);
 
 	ims_pcu_buffers_free(pcu);
+	usb_driver_release_interface(&ims_pcu_driver, pcu->data_intf);
 	kfree(pcu);
 }
 
-- 
2.54.0.746.g67dd491aae-goog

