Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0793B5851
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333471; cv=none; b=VQXqeAy6slIWuMlM8BkgKHzwF/pa0i/Liebb42vcjsBpi+5oo+JDl6LEZ3y7Xj/vsx6sBV6oVdLZuZwLnZurxSpJuNNCRYanfEUDNgPcKlJ899QoAdmBOXCz/B1BopkSI/UxQbNruix8/W+Jgi9rIu+MbQuL3V8o9BCwvQ1NCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333471; c=relaxed/simple;
	bh=9qdKyp5agbbjYzTy+gAniLiLFuOM6OusSwuJ6o9b6KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXM+Me16a9OQ+5cRcnybYwOOa4nJ6kAJue33IZaIfRAFN7U6XzVrww4AilkBCEE+vh7PpbaGiEpDGlqvrihFmeXCTngE4eHB9yB0ATEAz/FMH2Vk8tNjLZWXKZyTNoF/uHfYOc/V4N+oTPDZ97m6TZwrh9dqbawZWxeWJJoQdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkLvzVpF; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkLvzVpF"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56cde757d3dso1305350e0c.2
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774333469; x=1774938269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhRLd8KQvILenMrYsAiRnKYz454ZhDA5XTnLnFbyjwc=;
        b=PkLvzVpFxhm35WZ+fz3WwT3US16pp2so4VCI/LC0jJQiCaYZbOL1mq3xHf34Ah6hQk
         cO8pDPQgqMUfiRWNXrCtRChmxkamYxv0FkmUykmiQ9uqDaLbhtE6MP46O65QJVUHh+tn
         h2XClT4434n8eXHNKLVf42cBDtKiSeRTx4hVVloUgiGJ6mReCI3yQpswWaXwYLetWn/U
         wk9gXaweZ7t6wSd8SoyuuykIhQNVjF1/C3AgjnIuvZFVYh66Tz/Pv+x62/DoHq8dESJZ
         D+XDquFrbEC+X0eRlpOyQMeKczbnjOLbwFgajeiVhHgGWcNfpKcvwb2K42WVo3r8I2Nk
         C1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774333469; x=1774938269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhRLd8KQvILenMrYsAiRnKYz454ZhDA5XTnLnFbyjwc=;
        b=jhfuhj2SRLOl4ZdnUP9Wp8rOcmcgD7AlcmJ45jd/ANwnVskgvgnkr+v5k45ilwjhQZ
         NH8jeNKKexesM/61GJNoVwkwqFRmkgGOvXfjVPP3ReGWdbyqV9Orhm6H4ZN1HlbIqTlH
         KXNDk/5C10TCt4KlPYl+vMQrTOs045zeD6zkhVhWmZQsVx6okilyy8wBAoSRGIYx3HDW
         Su6gqxcVZyu5R3ZU5weOCQJuYscblTJ2ONrHja4ANWp+EcSv760GUw+lkmg67VZ4GY0k
         xqToW1WQMCiuA5BmCqBW9GBjCib32/visOLuOd66Nxgth9XEZ1gWyLYNrgR18zlDyv0j
         1SNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY7gHseQi+1O4X81EzeVbmkDnwV42BbDM/+kFKUFWP0WHG8/Zof8iH0xfcd2HV5Ind3RruREML1FDA2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWtR7AVLK3oFF98CReDdwAkFTLztLPgSV3e78lraB7b+goMwq
	keA7CKRzSP9o6skkEMTUzSCyBTDB3n/rWIRktpnk5x5chpk4BLCW0UtV
X-Gm-Gg: ATEYQzwWQwfJBa6rTSwn9OuySWS6epdSA0xJETACnCNB6ehzZns7E2arFiC+fhCrZk5
	Dd/qT7yIiHAK2hfIgxj2FSD71epUiNrY3+ZeRNotssBvr/5SBtx9jcW4YXry/WpqQ4ZumaqrvTZ
	8eh1NLCewYqohJS7VnsSGCclG2bU4ljlDzNULyXKp3lSeYsDuo1OxIcMzQCXBeRsT/6m8b5iSK+
	jGQ0C+4CxvMyVS3eSVDMoQyow/Z0tUp2ZIhD+jgRbGIj2azaF6sIU5NrSNpYHSGFYn1no6nayH8
	DPxMT6sZCZEoBqlFB2cg0N6VEGbsLgaDknn0JuSlMxg4cDBbT96MCK6bO3WWnMxkb/tw2WcFLTZ
	cfbp5dyCg0Jz97tFfNflm2G2AmdfDsU2mRRpOfJhIECYIva3qimzNOQGOtCfpV8IS4CXMapHjou
	gczvIW9EOAhvpgBOihsuAzessysEo=
X-Received: by 2002:a05:6122:1798:b0:56b:960a:a4b7 with SMTP id 71dfb90a1353d-56cde343441mr6514088e0c.5.1774333468983;
        Mon, 23 Mar 2026 23:24:28 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:7680:1048::11:161])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcfc94dsm14996801e0c.18.2026.03.23.23.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:24:28 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: gupt21@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] HID: mcp2221: validate report size in raw_event handler
Date: Tue, 24 Mar 2026 00:24:03 -0600
Message-ID: <20260324062403.341855-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcp2221_raw_event() accesses the data buffer at offsets up to 55
without validating the size parameter. Since __hid_input_report()
invokes the driver's raw_event callback before
hid_report_raw_event() performs its own report-size validation, a
device sending a truncated HID report can cause out-of-bounds heap
reads in the kernel.

The most critical access is the memcpy from data[50] into
mcp->adc_values (6 bytes) when CONFIG_IIO is reachable. Other
unchecked accesses include data[20] and a memcpy at data[22].
Additionally, a memcpy with device-controlled length (data[3],
up to 60 bytes) from data[4] does not verify that size is large
enough to cover the copy.

MCP2221 devices use 64-byte HID reports. Add a check at the top of
the handler to reject any report shorter than expected.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ef3b5c77c..fcac37491 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -851,6 +851,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
+	/* MCP2221 always sends 64-byte reports */
+	if (size < 64)
+		return 0;
+
 	switch (data[0]) {
 
 	case MCP2221_I2C_WR_DATA:
-- 
2.43.0

