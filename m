Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9B3148D9
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348905; cv=none; b=cLcGu2F1UzkkCrPAIVbi4I8boYbg1HKa394EPRFwS8AN2E6fzoL5K7Bj/t/heiviXxYu4QZ+nJRpsU9zJ+HgpM3n1QpgDNvDE3/yjwhsRiilqsh9PPMontmcM6Rzm9jihYOPg0LA4BS993qL3dDmYK5BIW0aOpHpkQ6JKhi40vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348905; c=relaxed/simple;
	bh=+2Hg1z6ae7Nutrs41m3MhRVfWr94UqLJ44+dKJ8FaU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj9IdelU0SJvEPca/yNw6/yNk1vf+a6f/4oVgKu8w0BI/fWIt3DqFiZ6NImRbwaazmQDyAJ6utNhsLFHA/wcvw5vUlhqOftYdCDDovPf9ezfLh+AfB69LMiI0arwGWfEjWOjAGVPcmr9Dgve+EQgT+4yYcQOQD6Abwup/Q/VZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7cPUqlK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7cPUqlK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d530328efbso14110675ad.0
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787348903; x=1787953703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1E0HqiFZR2YgW/ELzdI5r6SrFe75z7a+6PDQwhx3kuw=;
        b=W7cPUqlK5IcpSARiSay7yBXx5Xb+ff7TStt7NaI6kRU9UmukPlhQg7JBcagPh0A0TX
         /7fdTzKUtAmpN9XbyrzqiQX29wTTrUzHktLOlgORJFbPklPMKNJ4ITrcypTALL3CTqCJ
         Fw2liXBz7+otK0GUv9FAvTNZappHrME2xszX1jseA5qDMglAvNbi/byWEzZub1TzLloI
         Dons/67AEDph55XMMFHCbtDACM4BXalYrd2PIXBhrLw44R03d+w8aTINyH7/X5aDuDlm
         v0ciM/oy8pwT5votuxCdCuMGPQ6sEEZvmXuOc44U2PIq5UVq9hvBwhE4dTurqZpLYLa2
         JRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787348903; x=1787953703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1E0HqiFZR2YgW/ELzdI5r6SrFe75z7a+6PDQwhx3kuw=;
        b=bFr3hc58x6+0UJURng7pAUSceyCyPvymroYOZT3G3HUbZ9nTmiFugGlBzIYC6P9U8V
         GZV4NXKguqyNygYny7flV7b8N/eZCXHTVdWr/C8PCSNcNh6qjOCHZOIMBNshX2zf5aWf
         5/iev8GWaa7iZ4RiEosud5lpkCLpQd+Xw4jLTgjq11faAGQH8iddEQKQRY3HH6d1L/xG
         p9j1gCcN3gBzGZUwcZjfNnPnmGG/MeBphfZU+Gms13/b8mL4DwNSsdUOb3l8Nmsblh52
         IXgliAagxd8CE7bo1hNMrIF3cQT737HZC+wvZF/Mn/SmdmzAsdpO4ZvFUDxyzofI1amk
         JRlA==
X-Gm-Message-State: AFuF++lDRFjdfMIqaqGz29B2f9Ua0Wv+cdvUh8K6CGnuLlW1VT1VpqkJ
	HPQWP4jFclXEQwdkq+k43g4XrVF+uJdHWhub3CJKYbHgdAgcsPdaasCU
X-Gm-Gg: AR+sD12OGUFr9vc8gl/9msYdf7qBSmFRD1TfLO/OAnEDXWzliPvdNngshgfKujGLq7p
	lFRrzL5BMRIlG9V5gK6blWJR7UIQ2IVOA/pkmwHkSAZxwj/ukcFHa6BhwOkRo0Dc85oIzM62g8K
	UzY73qNvt7FLkJanX7TSpBFLsj+CLNWD/ibZ8TP/Ny1cYi4yufcV8fOYDeLi5aWcejH4SKeVuC2
	HLwR4kuzUbEZOiG2MIqwXvrk6hT1sTo0JAeQA1UsTbK1ukNLEz4f6QIcJeXhvzRqsXv64UBmGm8
	dSL3mHtrVAWitbPQm66KFZWa0U81NQjPczGrtzmHTG3oVwllL1Q+ppkcdutk4NTN9WvU44U3Fjx
	OzaHpo3VqPW9FRa1UXBGkDpIH7sL9Gpacv+eRay6dUblXC3zqnT/y0fud6qflnyUY/5+w7stZdH
	GQdZ1hDn4RjVWgVWd+RbIZ7aKP4RgD4LgisQZWyWNVHOrCqYsS6IhHIVioJ1L03Udk/h6kdP9ud
	XwjqYdAFbw+7joHkGffAKYnz/UyMQ==
X-Received: by 2002:a17:902:ce08:b0:2cc:9179:32e with SMTP id d9443c01a7336-2d64afe9569mr176987765ad.10.1787348903625;
        Fri, 21 Aug 2026 14:48:23 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb46sm27276942eec.3.2026.08.21.14.48.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 14:48:22 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] HID: hid-lenovo-go: fix the FPS mode DPI request
Date: Sat, 22 Aug 2026 03:18:07 +0530
Message-ID: <20260821214810.87826-3-mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821214810.87826-1-mradityadash@gmail.com>
References: <20260821214810.87826-1-mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcu_property_out() adds the five-byte request header used by most
configuration commands. For FPS mode DPI writes, this inserts a device byte
before the four-byte DPI value.

The FPS mode DPI request does not contain a device byte. Its little-endian
DPI value starts immediately after the command and sub-command.

Use the four-byte header only for FPS mode DPI writes. Keep the common
header for all other requests.

Fixes: f0bedee60607 ("HID: hid-lenovo-go: Add FPS Mode DPI settings")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
The corrected FPS mode DPI write was not tested on hardware.

 drivers/hid/hid-lenovo-go.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index b8248bf8965c..a6e9a130ad41 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -725,6 +725,11 @@ static int mcu_property_out(struct hid_device *hdev, u8 id, u8 command,
 	int timeout = 50;
 	int ret;
 
+	/* The FPS mode DPI request does not contain a device byte. */
+	if (id == MCU_CONFIG_DATA && command == SET_DPI_CFG &&
+	    index == FPS_MODE_DPI)
+		header_size--;
+
 	if (header_size + len > GO_PACKET_SIZE)
 		return -EINVAL;
 
-- 
2.55.0

