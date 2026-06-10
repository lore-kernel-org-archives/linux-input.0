Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827C426ED6
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104305; cv=none; b=HKmFUktaDARo1iEwN7T79AK0NS009zdsE0sUZfATf4Bgl7rSMk/bCSa6j1qubSCtcekURZr2+crAOxvXuhzsVvGPclLMPZNYzbbn1NL2DSIfoHe5Gp4ecReYsUMK2VKsRbzrFnbJJ2pifraIsmoN0rfNSr68FXckPDtRXXReGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104305; c=relaxed/simple;
	bh=7pKNkZYBYOJ3nE8OBwZu20iefoJ6u0TO+Moyzq1GPvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNllHvFQaS6y8bfmaWcMlz6ghiveIrgWpf5un2BvfGAABr39cGc0/9XwGN3hNsITEOxtdepngJVwVfUp+BTbYA4b2UhUygpYSJZtmH6r6exubil99Nctn7Rxuf+uHadKE40LhKwZlUaehMJq2KyDpCEzs8VYhyEJn3I+5s52P+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=EIJa2nuj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="EIJa2nuj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-460166910e6so3629941f8f.2
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104301; x=1781709101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTZb/sym8oiZGcOh2/RrQUOwA5RHoQUSyGVmsi6Ixy0=;
        b=EIJa2nujNhGdgRvXm7ONBk2ZsyYwRC1rvaW3EhZj0DUFQYBgCYZuiJubpOwMPkqfcJ
         pU7aj/Wk2EQUSxbjCOPqiC8Q+tEULLpl4qDgKFUnYsDs+I4S+nFmwDE4DvNG//oQdiE7
         pkZRa+Dxa73VebhN92xbFGK+5Xc8CAtlA3puHPciUMfK0+TQ2gVJqOMFbS5Wvusa+cuc
         DifnqGZLFC9/eTMWXA6J+dixu9UhaVuHfEv/jmUBMwKlO0hmp4Kbs8RXlI/gcccFs6ly
         8YIKXTRnURSFqS+LJ6O5vFYsomTYKm3Kd5+RGNlxu85qqIRAtwrUvsYXpf2tbVN705F3
         TB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104301; x=1781709101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UTZb/sym8oiZGcOh2/RrQUOwA5RHoQUSyGVmsi6Ixy0=;
        b=RyLNRbmWBHMyCaHKeLMO56DReYEe78q1JwBsEYRiJY4cj5Y1ZmL8JO9Cctd5fbY3hk
         dJampryPWSy4M2MvdI6rG2pY6HfpHtyZddSw17dfSpbVr5xeJHx/pOqOD+Va5d9ivERk
         8aLBJ7C5KbBJBAYbzglq4Jt+KyjS8SfDuVoxsWq6FobX6alLY72iKubwJvrg8FycXAke
         KYCJ3D+Z38pQOBoLqbcEtixv007SP8Evx/pNRm6i9zE+almBLuf8TTLYWUGnl5+w8mM1
         Je3WH6xNevQneknjMr0sOl5F/fdJOerrJPPbPVDOOvE3UCdNmPbX53QqNij/Zj+29kMI
         OI1g==
X-Forwarded-Encrypted: i=1; AFNElJ/y0RsA49043fcS9s/0bK2uMVGyk1MVsBftaP7ye3R15qgNiv8IddmCd01wE62s5RVpuVzVqhH/QLdjSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+IrMIA/5Ff3pAonxamlYvtFZQ8M+bCORINwFlMt/v2MSwzM5
	HV9vluP2IfohMtP/X1p5XGz/UleQQa8Ni+2j6QbqheyCVWaSjLepwg/2dhdTBt2aEwWHHR36zLD
	tkFvf
X-Gm-Gg: Acq92OEsa2m4gH5Krt4BeEMdlWFRhPrRemGIRKdU8/GlqEgHwR6ggOJFmP+/j/GTMFd
	hXKR/huaPW4vzA8x++rMz1QCsxnNo1dd89d8doLJoPSt8VkB+K3GxPWdDMH5DKGwScv3wLUMFQ+
	5AM43m46fXiotjQx8b6tPghAgznQ4CirBTSAVPXuOcrESi1vKVYGAaY3mRfCSoxx49RNrpcZCjV
	h8N+21hQXJ8BjrHT1dRSHmGPVtdoG3P/undYHhkg8pcIUSUrq+fWVSrdvY5FnnWLNiHFIbL9wct
	zCZ9hVPMJt5UbtdenHZCHI5iup6ik9W61idbA4Dg8VqHpRUb+6n2Rbg7H0X0AS3tGsZCfsUBhND
	qJcMc1RLj7I+NzTUvQ9Wk11tabg0dmKQMGkAoii354udxcCVtV6cgOFP6sV7q61aXPJj6mjqa1X
	7N7Q4Q+19HQUsxUFkLyv67yRHwEBhgW5+ikZXHmLDcKF7A/fb7UNU=
X-Received: by 2002:a05:600c:818c:b0:490:6237:521d with SMTP id 5b1f17b1804b1-490c25b3ca5mr438744025e9.13.1781104301236;
        Wed, 10 Jun 2026 08:11:41 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:40 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 10 Jun 2026 16:11:29 +0100
Subject: [PATCH v2 06/12] HID: hid-cypress: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-6-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=3832;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=7pKNkZYBYOJ3nE8OBwZu20iefoJ6u0TO+Moyzq1GPvg=;
 b=NrvuC5mID7ENybkWptCQEHtLBiRYG2rObFWdgGgtXLTqwceV0KxfuvHq5WPgmKgw957sEaesY
 TXsNO0usDPHCxx1pbFo5T0CPs/UQX5irwk2wDRySeQLsRZaQThKv6Sd
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The module is storing an integer inside the drvdata pointer, which is
confusing - furthermore this integer is mutable. When its value is
changed it is set again using the 'hid_set_drvdata' API within
the 'cp_event' function.

Let's fix this, create and allocate the 'cp_device' struct that is then
set as the drvdata and then simply use its integer 'quirks' field for
storing the quirks, which shall make the code cleaner, type-safe,
consistent and more readable.

This makes the cast to (void *) during storage unnecessary and the cast
to (unsigned long) during retrieval is also removed.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-cypress.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-cypress.c b/drivers/hid/hid-cypress.c
index 98548201feec..f18fddc176d0 100644
--- a/drivers/hid/hid-cypress.c
+++ b/drivers/hid/hid-cypress.c
@@ -25,6 +25,10 @@
 
 #define VA_INVAL_LOGICAL_BOUNDARY	0x08
 
+struct cp_device {
+	unsigned long quirks;
+};
+
 /*
  * Some USB barcode readers from cypress have usage min and usage max in
  * the wrong order
@@ -70,7 +74,8 @@ static __u8 *va_logical_boundary_fixup(struct hid_device *hdev, __u8 *rdesc,
 static const __u8 *cp_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	const struct cp_device *cp_device = hid_get_drvdata(hdev);
+	unsigned long quirks = cp_device->quirks;
 
 	if (quirks & CP_RDESC_SWAPPED_MIN_MAX)
 		rdesc = cp_rdesc_fixup(hdev, rdesc, rsize);
@@ -84,7 +89,8 @@ static int cp_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	const struct cp_device *cp_device = hid_get_drvdata(hdev);
+	unsigned long quirks = cp_device->quirks;
 
 	if (!(quirks & CP_2WHEEL_MOUSE_HACK))
 		return 0;
@@ -100,22 +106,21 @@ static int cp_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 static int cp_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct cp_device *cp_device = hid_get_drvdata(hdev);
 
 	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
-			!usage->type || !(quirks & CP_2WHEEL_MOUSE_HACK))
+			!usage->type || !(cp_device->quirks & CP_2WHEEL_MOUSE_HACK))
 		return 0;
 
 	if (usage->hid == 0x00090005) {
 		if (value)
-			quirks |=  CP_2WHEEL_MOUSE_HACK_ON;
+			cp_device->quirks |= CP_2WHEEL_MOUSE_HACK_ON;
 		else
-			quirks &= ~CP_2WHEEL_MOUSE_HACK_ON;
-		hid_set_drvdata(hdev, (void *)quirks);
+			cp_device->quirks &= ~CP_2WHEEL_MOUSE_HACK_ON;
 		return 1;
 	}
 
-	if (usage->code == REL_WHEEL && (quirks & CP_2WHEEL_MOUSE_HACK_ON)) {
+	if (usage->code == REL_WHEEL && (cp_device->quirks & CP_2WHEEL_MOUSE_HACK_ON)) {
 		struct input_dev *input = field->hidinput->input;
 
 		input_event(input, usage->type, REL_HWHEEL, value);
@@ -127,10 +132,17 @@ static int cp_event(struct hid_device *hdev, struct hid_field *field,
 
 static int cp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
-	unsigned long quirks = id->driver_data;
 	int ret;
+	struct cp_device *cp_device;
 
-	hid_set_drvdata(hdev, (void *)quirks);
+	cp_device = devm_kzalloc(&hdev->dev, sizeof(*cp_device), GFP_KERNEL);
+
+	if (!cp_device)
+		return -ENOMEM;
+
+	cp_device->quirks = id->driver_data;
+
+	hid_set_drvdata(hdev, cp_device);
 
 	ret = hid_parse(hdev);
 	if (ret) {

-- 
2.43.0

