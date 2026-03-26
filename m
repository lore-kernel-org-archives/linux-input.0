Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DF3914FA
	for <linux-input@vger.kernel.org>; Thu, 26 Mar 2026 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506349; cv=none; b=J7ZmVv7mv5nQQAyyL26EO6YfusWLt5Ap8sK3P4pKBXHWAIg43+4i2gHVYR+9RHUDc8e1bwRD37gkW5WNH1zvW2x0A8OYGMJKGzmIfkAjkYVPSEWsl3RizmG9n1RZ2ITmxApjDHJjVwsBFgVObAHEg/69kAH9ctKigPNIKcdguoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506349; c=relaxed/simple;
	bh=E+4C3n1s7tOvVik6cAb2pb9Je5bsVW5yonX4fJHWRDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aj20YQynbBp1kEjx0C+oiOwGidvK5NXmXM/q7t3/ZPsZbodP9onnD9mLj4nTbj274b5A3QlDwmrEEMv1A0kDriCE7r8ptjoKFRXm2Xq02a/GrumCtceQzqJgwlDvHI55EttQhxDHdH2AxGiS0WCLvY9P5cV3a/zueVQvPx8JKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUyXaE4M; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUyXaE4M"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c107ef474fso1577908eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774506347; x=1775111147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuSy2/PhgqqDWpXtTQHNQtoOW4iKSEs+6du+OT5tKB4=;
        b=lUyXaE4MGm1n7ZafjgcDskvZSUvMW6j0y11kBNLlwGLQRgCbYKNTB52fK00McmuDzn
         EiSfrFZwuxrlc//Owh4N6Ji9c4KwwVamA28lwdqjaAD4x8TavxR0N4QVcn0BZgjqtVZ/
         l3jBMbJa6aN8MRzUzkupCn/G6E39AL7N5TA+Omyotc1wErzeq+Wv+fo1AYD5ZdSs6esY
         +2htcJgTwltDX4nPdaNyvmNzXxuyw0eFyAzmRiBIBqpUkzzuHuKsNDQSw00dm1J+Yi2v
         BxwJ5eaWGNEueyU4x84HopQCjpik2N/Yh+Y7riWMlruYoKOYqFLsUxMJOTdEU/oXKeyA
         ug4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774506347; x=1775111147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HuSy2/PhgqqDWpXtTQHNQtoOW4iKSEs+6du+OT5tKB4=;
        b=HvcJ6ccNTe9zF5U6xU0ckvMf72bdtQ18/mYcHyctUQk7Hro81cTB+HPCVjmH7/fAnM
         SMRElax+MQbYcbqiZQQVrECdBkruagkCfAi37bQiKyfa930Pv0OUyvpMcKgk5Zqp39pD
         y8IGrx4cdU+MdtCGXw76ZaK2p2z7+mH4fe3CE5h8JoQdrqcQloMR3a52XYwkbgT0+ovf
         eETJ0NQRx0odnjX4fpeaWYLFzI703KZaLtqvJGeTQJL3Vp2AuOwOinrJ8o8VgYEHC5Pi
         OyZVEW5AeQlD7fmNhjbezZ6zuL3dngWk27iAt+8bEme8dhxnZYoaDzJ/jMvtD/Ren7Uc
         5fXw==
X-Gm-Message-State: AOJu0Yw1dMpZAH3AE+Cjvoa2rvX5sTtBezU681iktZoreBIh5iuDWjNa
	8bgRRbgwJn5ffQq9X0cOLyzYGi8ivr2oxDQdptXiomEAf3jWjOT11VgX
X-Gm-Gg: ATEYQzyA3N7f/KC+846jSm1+LnNmtvlcGQMypRSFc9/2aoWT9AlSIZ1SFwLYs8+lQlE
	7Tz0ZJws7EOAf3HiFkITHtgW/H++H1rq7PUm8Y8DWpTMAUSlbF4wZgSkSNQTaNxloMIbFutCzeU
	kFhVI9WgWuOKo1J4dbLyYu4VSQ2nrKoQp623LSPoSfKJxUyFn6zBA2o0Lm6PUiYwB/5kZPlm3aT
	+KsNMdWXebwcLEvQUvOy7aHGIBKrlj/Y8hr+w8nSdLCEfJuPJTsBsAjyKyOLxvgL6xDKCgG4+X2
	1wFYGD02lBplgVdot49kBP2vLu52OjDzDxN8BEAAYQ3uZug4Mh36GCDzUmsGdr3uYpiKKkVyqKB
	avxpxiFLOlEDP3eLXfrKUpF/Oz+HVzVpr7QRx3/SO7Y3BraKZvMBr5PuXrzERGLyUfwryggut10
	njQ97rLjZkjI4uBcDu1ZFqkf/mJ34LdCgSV1rWNNmeRFoO179e/uYXzeh3X3E+GYDi8cyqrGruS
	teLaFt2IP7ZKls=
X-Received: by 2002:a05:7300:a94b:b0:2c1:558c:16f0 with SMTP id 5a478bee46e88-2c15d3e2f5dmr4108426eec.22.1774506346526;
        Wed, 25 Mar 2026 23:25:46 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edc047esm1659207eec.23.2026.03.25.23.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 23:25:45 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: core: use __free(kfree) and __free(kvfree) to clean up temporary buffers
Date: Wed, 25 Mar 2026 23:25:38 -0700
Message-ID: <20260326062539.750272-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326062539.750272-1-dmitry.torokhov@gmail.com>
References: <20260326062539.750272-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies error handling and protects against memory leaks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bb13dcb116a9..b40953e0f52e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -924,7 +924,6 @@ static int hid_scan_main(struct hid_parser *parser, struct hid_item *item)
  */
 static int hid_scan_report(struct hid_device *hid)
 {
-	struct hid_parser *parser;
 	struct hid_item item;
 	const __u8 *start = hid->dev_rdesc;
 	const __u8 *end = start + hid->dev_rsize;
@@ -936,7 +935,7 @@ static int hid_scan_report(struct hid_device *hid)
 		hid_parser_reserved
 	};
 
-	parser = vzalloc(sizeof(struct hid_parser));
+	struct hid_parser *parser __free(kvfree) = vzalloc(sizeof(*parser));
 	if (!parser)
 		return -ENOMEM;
 
@@ -987,7 +986,6 @@ static int hid_scan_report(struct hid_device *hid)
 	}
 
 	kfree(parser->collection_stack);
-	vfree(parser);
 	return 0;
 }
 
@@ -1246,7 +1244,6 @@ EXPORT_SYMBOL_GPL(hid_setup_resolution_multiplier);
 
 static int hid_parse_collections(struct hid_device *device)
 {
-	struct hid_parser *parser;
 	struct hid_item item;
 	const u8 *start = device->rdesc;
 	const u8 *end = start + device->rsize;
@@ -1259,7 +1256,7 @@ static int hid_parse_collections(struct hid_device *device)
 		hid_parser_reserved
 	};
 
-	parser = vzalloc(sizeof(*parser));
+	struct hid_parser *parser __free(kvfree) = vzalloc(sizeof(*parser));
 	if (!parser)
 		return -ENOMEM;
 
@@ -1267,10 +1264,9 @@ static int hid_parse_collections(struct hid_device *device)
 
 	device->collection = kzalloc_objs(*device->collection,
 					  HID_DEFAULT_NUM_COLLECTIONS);
-	if (!device->collection) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!device->collection)
+		return -ENOMEM;
+
 	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
 	for (unsigned int i = 0; i < HID_DEFAULT_NUM_COLLECTIONS; i++)
 		device->collection[i].parent_idx = -1;
@@ -1322,7 +1318,6 @@ static int hid_parse_collections(struct hid_device *device)
 
 out:
 	kfree(parser->collection_stack);
-	vfree(parser);
 	return ret;
 }
 
@@ -1358,9 +1353,9 @@ int hid_open_report(struct hid_device *device)
 		 * on a copy of our report descriptor so it can
 		 * change it.
 		 */
-		__u8 *buf = kmemdup(start, size, GFP_KERNEL);
+		u8 *buf __free(kfree) = kmemdup(start, size, GFP_KERNEL);
 
-		if (buf == NULL)
+		if (!buf)
 			return -ENOMEM;
 
 		start = device->driver->report_fixup(device, buf, &size);
@@ -1371,8 +1366,7 @@ int hid_open_report(struct hid_device *device)
 		 * needs to be cleaned up or not at the end.
 		 */
 		start = kmemdup(start, size, GFP_KERNEL);
-		kfree(buf);
-		if (start == NULL)
+		if (!start)
 			return -ENOMEM;
 	}
 
@@ -1998,11 +1992,11 @@ static struct hid_report *hid_get_report(struct hid_report_enum *report_enum,
 int __hid_request(struct hid_device *hid, struct hid_report *report,
 		enum hid_class_request reqtype)
 {
-	char *buf, *data_buf;
+	u8 *data_buf;
 	int ret;
 	u32 len;
 
-	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -2021,17 +2015,13 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 	ret = hid_hw_raw_request(hid, report->id, buf, len, report->type, reqtype);
 	if (ret < 0) {
 		dbg_hid("unable to complete request: %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	if (reqtype == HID_REQ_GET_REPORT)
 		hid_input_report(hid, report->type, buf, ret, 0);
 
-	ret = 0;
-
-out:
-	kfree(buf);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(__hid_request);
 
-- 
2.53.0.1018.g2bb0e51243-goog

