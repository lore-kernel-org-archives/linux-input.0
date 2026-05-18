Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFDB261B92
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120424; cv=none; b=sY/wb6LHFT6xeAKAb4uFb8f6bST8zl+7tQKjp9/H6dFUs+tb9mu1y8WUpbVp4QXKCn9978CRcq8koyWjG1tKQZDhu0lGujs/2Wo6Mfx45t/DcWAlqK/LJQbolTrPfwt/soxQQCzO1cdqzKOFynGQKvPDa3ZPZq5xButOIsDtVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120424; c=relaxed/simple;
	bh=nNVLFwaSAIDvIpmHe1HBjRdSBcNvB7SacHNgTDhwb4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DakcMs4cauNAUjGekkZbS4C7LZX79L4JCdnyDY9I79IgQH0vSJjGWElG7XkGpa0FRNlZzNRUSQMuLhXbyGvGaojQvxb2aiGbQKixes03GY1OXPMcbzVgY5fm9kD+wLkJa6+DTdfwlTfP734pbOaF3gLpHC47mZRgWyXF0LWI7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=vR0gwvnv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="vR0gwvnv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso2292171f8f.2
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120409; x=1779725209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlMfhEviKXjt/bYrgNS/DuGQqiwDoSdVj7ADssoybZ0=;
        b=vR0gwvnvJZGPv8vYDDa0pLzQO1VLhLbz/O71qV2gDs7JgL/uO6DHSCP0sQdT4mPv7w
         HPVXcqfo/tDjEocQXgSMb57X9v1+eAvraEpUws3oGa+DOVpW460pjul3FMQDYqibyMxg
         Z6tv/JyK87+bOsq7Zips80uGcxB5V4Ke3UCQHs3HvoWuV15lmcJolfRb7KSl/XGsrX3B
         RaMQtmhxsaUSS4Xek5dCNv2s4iU7guBM9dA0DboWUtmugaFGTjqmGgFchkRGDp0iW8re
         WspslBOOhRtALAV9XoUimCc38nsUv4ER4luCTr8xPzb4u/wCR8hEBhWGbcQc13OYFPti
         VtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120409; x=1779725209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PlMfhEviKXjt/bYrgNS/DuGQqiwDoSdVj7ADssoybZ0=;
        b=guojREgmBL5/dmivJdP0chJG9gvaq3XGpT/JurSneP8+29q4IEXefEOqUNldwdLRhH
         VEqk+fSoZSwNButicOsUHV4G8zkLX+WY3G0ICg/R385U84b0OCRxylHdkMug749Ep7zt
         ATnH1kielrRSPRQZbrhMOI7H5IIif8ip4aFxmhOWaPS+ZEXFxuw6aCYbDeRHVkGe/LqP
         sFfq8RQdrILrsg9a7ZM+MHsyy0Z6yUnYtQOphouzbDr2Xe2CsF6t3wqch0Je7Y1JgjCr
         DrgyMxlmcFep7o8NXC2bMmiFDRi4sfzxAx/OecVrIJArrCR4RI1suLUEIx0t2fhw8iNY
         T6KA==
X-Forwarded-Encrypted: i=1; AFNElJ8Z3c78rewV7H2ZLfsvCMVf/cd6U6nfJyafw4VcXViEKbPk7JGDaAOqe8JffUreeRsDSQyix/SKm4jjpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJmCyVHszONVRG3UI1hrBhuWTyPXNPX2EL4nDEXDnA7Vs9gEQ
	kwuBWlcHIx9GwP2sMP5/1o2z1g8K7YGkHhwe/l0txT4JZ1kBGnQYHZfbM/B5L5yORZ4=
X-Gm-Gg: Acq92OEM4HjfQ2WrWxdPKMfeYRWBZmRxPyppXL5pPbKxXeKa8Z93/2/lK3iBn2PRkgo
	hEtxUlkUfEpRsVwgQ8qhWkEmIix+60lbFlZgFGBk9gsPhCnw0IqGD3q4eXQTvngG0knIzVev7gq
	oJ9C1ZpSA/jjyjS2o5oNQTEsOOxL4dpKI0ydAbNntix6m4v9bEfbQuz0zOAeSXT63iEzBy63Jpk
	TSQpz54PtSYO2mv/+hmWTuVqVLYkZWgYLyRAhTM/NNRixGwfRiHbff0qlIeGHlttYZP7ZaO7Hwl
	xnkfm9/DgOj4s4hsNAjWSMEEKpIJ43zI3Gkx099xkitSvXVYe21ukAYJ+R9CKVWIlPVbeMGgDHl
	WqqEAK83Le6EnU5zoYn1QOpFDb5uLgnEW1ehDpMMRpWD2AKawtoTGI0NClMIjKhadVRHx4SEss5
	UyL7TEuZ2YcOKtCgOKcUskJUG+D5GCYwJEoG8224jA
X-Received: by 2002:a05:6000:1ace:b0:45d:3cbf:bdda with SMTP id ffacd0b85a97d-45e5c58d4ccmr24791826f8f.20.1779120408750;
        Mon, 18 May 2026 09:06:48 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:48 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:27 +0100
Subject: [PATCH 08/11] HID: hid-ite: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-8-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=1844;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=nNVLFwaSAIDvIpmHe1HBjRdSBcNvB7SacHNgTDhwb4s=;
 b=3q7D5SwZy+SEgk7TLJ9WafWiMw1l6VRsJgX46Y4QXQM5VB9IIi70NXXlCBi4ifazeH4v8H6Nh
 nXL6HvnQQcHDkEE4Ek2+0ThS7ri86+uoMrt2VrUrz89TyLN1VN0HFPO
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The module is storing an integer inside the drvdata pointer, which is
confusing, lets fix this and set the whole of 'hid_device_id' struct
as the drvdata and then simply use its integer 'driver_data' field for
quirks, which shall make the code cleaner, type-safe, consistent and
more readable.

This makes the cast to (void *) during storage a bit safer (just to
suppress the const qualifier warning) and the cast to (unsigned long)
during retrieval is removed.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-ite.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ite.c b/drivers/hid/hid-ite.c
index 8e42780a2663..63908f24b524 100644
--- a/drivers/hid/hid-ite.c
+++ b/drivers/hid/hid-ite.c
@@ -15,7 +15,9 @@
 
 static const __u8 *ite_report_fixup(struct hid_device *hdev, __u8 *rdesc, unsigned int *rsize)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+
+	const struct hid_device_id *id = hid_get_drvdata(hdev);
+	unsigned long quirks = id->driver_data;
 
 	if (quirks & QUIRK_TOUCHPAD_ON_OFF_REPORT) {
 		/* For Acer Aspire Switch 10 SW5-012 keyboard-dock */
@@ -44,7 +46,8 @@ static int ite_input_mapping(struct hid_device *hdev,
 		int *max)
 {
 
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	const struct hid_device_id *id = hid_get_drvdata(hdev);
+	unsigned long quirks = id->driver_data;
 
 	if ((quirks & QUIRK_TOUCHPAD_ON_OFF_REPORT) &&
 	    (usage->hid & HID_USAGE_PAGE) == 0x00880000) {
@@ -94,7 +97,7 @@ static int ite_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
 
-	hid_set_drvdata(hdev, (void *)id->driver_data);
+	hid_set_drvdata(hdev, (void *)id);
 
 	ret = hid_open_report(hdev);
 	if (ret)

-- 
2.43.0

