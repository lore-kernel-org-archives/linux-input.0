Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FD2D73A0
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664570; cv=none; b=AhgJuNQwmVvtWgPQzJriH3YMlyCopuztFOlBEdMapHcrrZNhUFP+J5Wbrs9+ItkTjt+6vLBL/R4sKgucNmZWx2PFaZ16OIJn2vr2z96yPG1TwM9TtE0MMXo1oXWBg/1RqTJbuardRd3FCG9lSMsoQnzh8H4F4yUYGKN5Iz96oeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664570; c=relaxed/simple;
	bh=7SAk7Fc0yzlHbXtxGBYgum1SrN0nR9Qrn9RNTSJLToY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AX7M4doVhI2GkturCq5GHJIY45dlS+X6la42oPxIF99cIP3oVcFICDSCPpZPqF382n8xW5LTpLtURp6l103U79+tTO8csSzaVlXG6Ty4rELU/QZ7d7d49JC+APvssN1+yds644PN2YSKcMmkiKZw3PcMT4lUiwIsg84c6wgV188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9qe9XCp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9qe9XCp"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80e24970f1dso4486257b3.0
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664567; x=1783269367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9cHL391eF8wlJWPwE6JxoCaVclgQ3+dLf6rQ/8ShHU=;
        b=E9qe9XCp+HHJWN3Y8fgjLBrS6yXehppIN/VcXW2rs0EtK8zvH4dcCI/T9/B/AKPp7t
         44XzIS2tSm4l8SSab1F5xyrPskQ3tMagM7gyD8/hPyGZKvVHeHyOhWO1mhZSdb9DhUSC
         HnB1z9S77Cu1cpQC2s0HyIDybnrvn/nQDhZhnikKyNjVk68K9/SXelH55YA7dOotXVEF
         nnBkqZST6G9PDjKYe0kN/f6dp+uETmWPgnWokRjjPcWnsMnzqwIndr74tY63EWoysCOl
         MCbyZ4vhETcfgeIcg+/efcAPEeR11HQ57KyO4FIwfrEsVJw+4KtC+gwaxnsSEvAs+95N
         FNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664567; x=1783269367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9cHL391eF8wlJWPwE6JxoCaVclgQ3+dLf6rQ/8ShHU=;
        b=mHOItcLrd2OJ0g3ydZYYV6XKauhPOGEzFCLudRwJsMpQTeRfHjYgFYmo336MLd2Z3R
         LTm1tmNipjdvrKwLM3AaykuHELyMXrkJLV3CU6xnQE16EqP9II77WJLDcajuiZwbx7m7
         /+2TpYPejn3gvbM5WhNeByFrJZOkLdj3HKWqGpPjASjp3O159Z4YyvkWzNXEx9zYzmAl
         2mFzoi1JyS1VvMkUzsWW3BmlWdAiS3Wj59j7Tdia740LmFrs24q5Tp76KOWBXLfAuqDc
         OBR4IQm6Xp+ao6xGwdKkz7MWWjsZ5Ua8rzMvzKOcfgo2g3n0n4Blcoi44bAnLLoRleR6
         0Ejw==
X-Forwarded-Encrypted: i=1; AHgh+RqsFujbOONTi2OCrmXnZjpylcIcShb9OWHxTk8scrEjJJ0m4fajZktOQIbcl/qgtExFwbnbQG0yYfo0xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ40lcmZ47dHGKQ8LogQcoxSbxbFNYK8hnMT0OU1YhLeNR2dQk
	ApydWxXJdbCuMGdZov4UKQC0lK8baTZnEBjfGfzDXw0YhQsM4cIfzIw7
X-Gm-Gg: AfdE7cmA0L2rF+5XzA1g5M5epmsAfFL+vieygjOvOQmMRuSzRp7v/ZP+f1vUgyWbxc0
	fsLkwgQOnDi98vyExeD4GkANGzqNsE8UCsVcas0texneJZo8/3scMddQuiXnsdEzay7KCDFvWzh
	GM+3mshS0hQIUpo3PdkRm4jw8roK7HBlSTato5K4QMBOQaTR5HgTc6od3BUCE8DX52C5f3Yma+E
	ZRmjP4lolZhmtTNjzGaQg9wxSQOTibIEsQ5T71+X4G/o19jSik+VXOyeHFzV+MuQ+kIUHCWqbMy
	+mhFu1Qpop4nEXcIq1M7hch2b86APUifwYB4rcDpdXcz5XbzJ9W4AQg1/FqqCX6BHc2O7650wS3
	JS0qD6pUdVWIfdMXscqtp5a6fSnlLsMYVLuDcWxLlnDqpybPEWZwktWGhuCj9fcJY0ONRz+BFMv
	kV82Le4Sj5aHtJpBbxr4J8dvzyorndTS/Ove76
X-Received: by 2002:a05:690c:6703:b0:809:28e1:d50c with SMTP id 00721157ae682-80a6c8781b9mr145384527b3.26.1782664566579;
        Sun, 28 Jun 2026 09:36:06 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80ea903f74fsm6294817b3.21.2026.06.28.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:36:06 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 1/4] HID: elo: ignore short touch reports
Date: Sun, 28 Jun 2026 18:35:24 +0200
Message-ID: <20260628163527.14279-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

elo_process_data() reads coordinates, flags, and pressure through data[7].
The raw-event callback only checks the packet marker, so a malformed USB
device can submit a one-byte marker report and trigger out-of-bounds
reads from the input buffer.

Only process touch packets that contain all eight protocol bytes.

Fixes: d23efc19478a ("HID: add driver for ELO 4000/4500")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-elo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index b8f5f3eb53a4..1aeec712c67b 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -89,7 +89,7 @@ static int elo_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	switch (report->id) {
 	case 0:
-		if (data[0] == 'T') {	/* Mandatory ELO packet marker */
+		if (size >= 8 && data[0] == 'T') { /* Mandatory ELO packet marker */
 			elo_process_data(hidinput->input, data, size);
 			return 1;
 		}
-- 
2.54.0

