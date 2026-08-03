Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620EB43FD3B
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782822; cv=none; b=aaHs1xBIsK58Lf7eYG8NUqqWmeOPyujZoWbdOAXXY5tvEZTKr4tKXqSAi6bFxxFXsWLnLn3Dv/WYVMSIl/IhQtJ6YCglcf9Vs2MW1xQcsuonl4kOOIFhTu671eOL+de26B9dv+VHD4r2aiqyDirapRQpGAFhQRZiXxENndmwSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782822; c=relaxed/simple;
	bh=bkkjuJ7kHovlBy2GQl50Xio+Ck7Q4NkLDSybgRgkKTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsVF5YGJ12zOvbbuKKxvRh0umAxL3zRk9apNsgjTFJIaK9ILwttjoTgQ3km51umU6KK1CqI/FXg11I2gdB7Tj5nVDBU8FmhJVTWo/fqpcia7IDhMZp+0ltq5dwdnQVrfFHwgTXvlhvB5mkZtHmZVpqfhZg7euGQfhr6aM/wZBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDn9GZH8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDn9GZH8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3410800a91.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782815; x=1786387615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMeooT+Pd2wEyftNL9TbUExuIFr34iBpC5GZzR8qYww=;
        b=SDn9GZH8AF7tWgGkUBLPSHgFgyD7EBkNNjHYiDdgT6pDLHMfHEbneYcHCPz6k4dlQi
         fOrgQtcb9AQwMmYHPIv5auX+7pJCg6wniuJxXEf1ho1DBnCq2cKqyIW8DAlcSA+sODt5
         8/Lkp0GlG8+w/ggt6QhYML/LDmkT9eKDXZUx+i4lSPmnSy8pc/zzh2H0h618pOxGutda
         xD6eBWZxF2gbISWE13ANQiWY42Mas8WOiGbBqKVxRsbA3YnSZOM/1r77L3+K36Ho9inr
         lE3LcfWhcRh2EKc2gwPCK/uwYVO6B6Do4lTgHhzSnbWYfq6ksradlqlMkyCIf2di5Jof
         P7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782815; x=1786387615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMeooT+Pd2wEyftNL9TbUExuIFr34iBpC5GZzR8qYww=;
        b=hn98tw+Qvgy6m49tRlz32xEEy1PsMxhOH9rzq6xYqJO6GorRwJ3InY+WZ3dzolg/2u
         UZ3KJj5NQsmfjdq4RI+3zondJeMYznmZElQ0u9lwF5jaW7P8rUybrcE3RFsdFwbErZeT
         ki3JR+DaRh+EJzhdhnwpleDWgDPRygT36axqy2XN95m4A54DpuWsXqdD29HkOcWmAyhj
         53g/WzgCNHGhwXaRp+lSUcpsdI1ynwaJ2eWdxTsSTJWmM3Wxr27ZqtD1M+89BXgHmapu
         RDjiXyJFlbEjZ9/kLzRdTtBY2T8DQUlUKi8TGqj0YQz90VvBiAEUx9WRqD4/+6KBWwrU
         YUtg==
X-Gm-Message-State: AOJu0YxGqnuf2MREOaJegyv6cYQjI148TyBH4BIQumcVuBlKTwP3azpu
	NErto2XonjN1IY6ya2F9MdOsvNK4RynGQa8jMn0sjGQGCwYNaxh//JTG
X-Gm-Gg: AR+sD117lKBo02h8+x1cXYTCGKdGOE5cVdocA0A56ADZGDntT2jekFhWPtHkweYOkuY
	kFHBuN7kiZ/qh04YnOZw8H/H+hpOQiIqFqFrQp/UBBKQE82gixzE2kjE1gMZmsXCnDAbFRRVx6Z
	CCuEigmbXcPDEbzw1g8sP6VOv6ESfaqpILkcXK8TxpyOMLlIibqWi6CEfOZRN3849fvbQY8BisL
	+E6/G04GdivyVCPafpjsPNroQf+Z+0Ain3bCw3RGEf3dcbOqbM4dggIijaaO3XCIldrTwQbTgsM
	PH7V6wMW24HqJtdVlAvX20jzVylPOwYFfv5Axsf4q3q6tpPKPwDTHejozfV2v1jKnuwDULbWvsd
	4gwmgu2QJYZ0ejZNe9NjjdmpQeAPi+z01AN5Cnh9AHdmoWlEws+jk/2alXFqNw2oC+jUs5v7ynW
	Net1jZW7Bz+PEu2cCM7k5Lf9jW3ebzutclwAEA6km55peu/XR+lj7gVCbnZ2rUQQT38B2/cidu/
	wfN4LRYLI2BnrJ6wiVqE6/mafeQZX4Bsohag3XEx7jYAapq2IV/5HYiZDVfMXHL
X-Received: by 2002:a05:6a20:a114:b0:3c0:9c19:65a3 with SMTP id adf61e73a8af0-3c92a98cd35mr11005065637.75.1785782815610;
        Mon, 03 Aug 2026 11:46:55 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:40 -0700
Subject: [PATCH 15/21] HID: thrustmaster: move FF initialization to
 .input_configured()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-15-1dc9bbacd88c@gmail.com>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
In-Reply-To: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, cocci@inria.fr
X-Mailer: b4 0.16-dev-b242f

The driver currently initializes force-feedback in its probe() function
after calling hid_hw_start(). This is racy as the input device is
already registered and visible to userspace at that point.

Move the FF initialization to the .input_configured() callback to ensure
the device is fully prepared before registration.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-tmff.c | 47 ++++++++++++++---------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
index 423f395d01ac..0ed152e0dba9 100644
--- a/drivers/hid/hid-tmff.c
+++ b/drivers/hid/hid-tmff.c
@@ -115,22 +115,25 @@ static int tmff_play(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int tmff_init(struct hid_device *hid, const signed short *ff_bits)
+static int tm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	struct tmff_device *tmff;
 	struct hid_report *report;
 	struct list_head *report_list;
-	struct hid_input *hidinput;
-	struct input_dev *input_dev;
+	struct input_dev *input_dev = hidinput->input;
+	const struct hid_device_id *id;
+	const signed short *ff_bits;
 	int error;
 	int i;
 
-	if (list_empty(&hid->inputs)) {
-		hid_err(hid, "no inputs found\n");
+	if (!list_is_first(&hidinput->list, &hid->inputs))
+		return 0;
+
+	id = hid_match_device(hid, hid->driver);
+	if (!id)
 		return -ENODEV;
-	}
-	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
-	input_dev = hidinput->input;
+
+	ff_bits = (void *)id->driver_data;
 
 	tmff = kzalloc_obj(struct tmff_device);
 	if (!tmff)
@@ -204,35 +207,13 @@ static int tmff_init(struct hid_device *hid, const signed short *ff_bits)
 	return error;
 }
 #else
-static inline int tmff_init(struct hid_device *hid, const signed short *ff_bits)
+static inline int tm_input_configured(struct hid_device *hid,
+				      struct hid_input *hidinput)
 {
 	return 0;
 }
 #endif
 
-static int tm_probe(struct hid_device *hdev, const struct hid_device_id *id)
-{
-	int ret;
-
-	ret = hid_parse(hdev);
-	if (ret) {
-		hid_err(hdev, "parse failed\n");
-		goto err;
-	}
-
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
-	if (ret) {
-		hid_err(hdev, "hw start failed\n");
-		goto err;
-	}
-
-	tmff_init(hdev, (void *)id->driver_data);
-
-	return 0;
-err:
-	return ret;
-}
-
 static const struct hid_device_id tm_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300),
 		.driver_data = (unsigned long)ff_rumble },
@@ -261,7 +242,7 @@ MODULE_DEVICE_TABLE(hid, tm_devices);
 static struct hid_driver tm_driver = {
 	.name = "thrustmaster",
 	.id_table = tm_devices,
-	.probe = tm_probe,
+	.input_configured = tm_input_configured,
 };
 module_hid_driver(tm_driver);
 

-- 
2.55.0.629.g250fe7f194-goog

