Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE23914FA
	for <linux-input@vger.kernel.org>; Thu, 26 Mar 2026 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506347; cv=none; b=vEiPCosNq8f8A416Tqjk4jUROSfEhBdlcJ0cW6PxUAqhDcO0VMhfbcX0yVc2QH2aA+6+bSTXPif5/6/VjcKpyHueAQKWQYlqSRvCE5Bd7iA7U1BIEjkPD2Yv1+EAZSpiN4TrZ015g+BCaIWrESkv4kk/Kjrfd8n6rxKYegbn3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506347; c=relaxed/simple;
	bh=BG9dwq32Jw5ObkBUCNM0jEEHZe4n9bTRXKHeoa/5Jss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQ+vZbS8vF4lyh12+62YTvTWzkrQKQY3bPq8VhzsCC4eFrq8KTmesgC6FeOBWt3AaFpeulB5GimijLeLatYmfgOuoOtV6T7ny7wOAXlJtK5mJfNllHsXVjwe6gd599MfVFpESafZKEcvwm3/L2qwHjEw/SDvHRjSVwSQy+LcbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuIrbNp6; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuIrbNp6"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c160308a54so1595713eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 23:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774506344; x=1775111144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYZRc5c/hfM+a8SsAQf2L3jVT1t8JOqTOKgOG/Px7dk=;
        b=nuIrbNp6oVTYcHe3B9CWHjMHdz1TEk16iinxcUcPHwD1Gnh9giGcLbFKWNBdCkz1BY
         GVbUkNw0sg7i6uicUu4etJ0vphv7+ecYoiaBQnjlxZAe0uK8rzMxC7vqvWJGfZRd1TP4
         yko8EUJQ9D1GOHojNKoy6HUAkO14IMEOkp7ost76PFv+bM6hvQv+gD/jrjkZrBKKbv8L
         gTCVnnPOmHMEeDZEpFwD1OO2/PYPWDQupEml0v7jVGP0ycrhX0cBEMlRpShcsK9YrTHO
         8x4IcZ71bVISBMB80Q+sCeCZEnhZHrnHtJqq/PK5daSD4d6BQLpQJm+ziGF2d71Aru6Q
         bRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774506344; x=1775111144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYZRc5c/hfM+a8SsAQf2L3jVT1t8JOqTOKgOG/Px7dk=;
        b=ksZmcUfLAT7crUZufxBb8sLqqSA2poNykyM+HJuitRqyrH7yEmLBMkp0RzqEkfeijH
         rhCxrxEhWdAhx3elx4n+uhILZ2/Z1CMfx84N22vv58zD6NycPzjzHi0Rv+UTOWcOcW9B
         /UQ0jSnw0trYL1L2Y77FTKItkPpVn3z4bWwR6UZpvumvyymJHsAYnc6q0Iwmj4DjUaTV
         mY/GtF3SKOlE1D4W3UN/3OD8dHCT4qi+9dqP+DbQtj3y2TASC8USXNYZ4qYtFUO773kp
         GXYPWmyKpHr6qxVxk+a+AqtTgQ/xLp8KmtZcgiZ4DpQxp0iDTHg4WTM90nz292CRrNFR
         EuBQ==
X-Gm-Message-State: AOJu0YznZeGJaiBDkZLH0mzNOzV4FVNZQRiLno3xgUFslYj/TNwufC+R
	zCtwbZeBOcQcp1GshN3FvN+S1wfL/WldtySAlQUCe3i571tbXoQozxl9
X-Gm-Gg: ATEYQzzaAA41J0f8OuHIp5JloU370RYzPofZL670ZUPkelreb2VvgTPR/sWBAIHq2w9
	YjvnTyBHnWCyQAKhjjj7aDgOz/XDSZXvc7EqswVlbkEYYwfFKkf3ySl9Cjklx1QteenxVZkDjpj
	pS8QEaK+pFjP/6QSJfJwci8XyEBhtlx4VKpHpxUFhTsoD9ccGZ338NbFjPvi+nnt3MfgB81F7Fe
	307+DCAiS8AHhlX0GkNEZlljBcZBl+hp7HNXsIcNXEdsT9HvZiBRzv9+X5zDQtaLM5vbpw0clDD
	56c+wlprZm4kIE2c6ucVVdbi8mdcSUJJOTdMotevyDqNMqp39vWl3Jqn/7gIcGNsECIHbNvimBM
	I57J3mMPXrtIyy0nvVJVK+Xs0f9Fyg/+6gRxCYB+VvHKenovOopIj+smWUaLKL41c0ywms2YsYG
	pdcqbSyrFFhSJ8h5LYrtZ5ln/W7MdBny3/d+AV/QhXqwXBSek3cSZ8g3/VwCOY5g3q5xIPcP7Rs
	B9yKKaoyubkhmk=
X-Received: by 2002:a05:7301:e8d:b0:2ba:6d87:cf6e with SMTP id 5a478bee46e88-2c15d26fb08mr3208917eec.4.1774506344279;
        Wed, 25 Mar 2026 23:25:44 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edc047esm1659207eec.23.2026.03.25.23.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 23:25:43 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HID: core: factor out hid_parse_collections()
Date: Wed, 25 Mar 2026 23:25:37 -0700
Message-ID: <20260326062539.750272-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to making use of __free(...) cleanup facilities to
clean up temporary buffers, factor out code parsing collections into
a separate function to make the code simpler.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 169 ++++++++++++++++++++++-------------------
 1 file changed, 89 insertions(+), 80 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 833df14ef68f..bb13dcb116a9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1244,6 +1244,88 @@ void hid_setup_resolution_multiplier(struct hid_device *hid)
 }
 EXPORT_SYMBOL_GPL(hid_setup_resolution_multiplier);
 
+static int hid_parse_collections(struct hid_device *device)
+{
+	struct hid_parser *parser;
+	struct hid_item item;
+	const u8 *start = device->rdesc;
+	const u8 *end = start + device->rsize;
+	const u8 *next;
+	int ret;
+	static typeof(hid_parser_main) (* const dispatch_type[]) = {
+		hid_parser_main,
+		hid_parser_global,
+		hid_parser_local,
+		hid_parser_reserved
+	};
+
+	parser = vzalloc(sizeof(*parser));
+	if (!parser)
+		return -ENOMEM;
+
+	parser->device = device;
+
+	device->collection = kzalloc_objs(*device->collection,
+					  HID_DEFAULT_NUM_COLLECTIONS);
+	if (!device->collection) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
+	for (unsigned int i = 0; i < HID_DEFAULT_NUM_COLLECTIONS; i++)
+		device->collection[i].parent_idx = -1;
+
+	ret = -EINVAL;
+	while ((next = fetch_item(start, end, &item)) != NULL) {
+		start = next;
+
+		if (item.format != HID_ITEM_FORMAT_SHORT) {
+			hid_err(device, "unexpected long global item\n");
+			goto out;
+		}
+
+		if (dispatch_type[item.type](parser, &item)) {
+			hid_err(device, "item %u %u %u %u parsing failed\n",
+				item.format,
+				(unsigned int)item.size,
+				(unsigned int)item.type,
+				(unsigned int)item.tag);
+			goto out;
+		}
+	}
+
+	if (start != end) {
+		hid_err(device, "item fetching failed at offset %u/%u\n",
+			device->rsize - (unsigned int)(end - start),
+			device->rsize);
+		goto out;
+	}
+
+	if (parser->collection_stack_ptr) {
+		hid_err(device, "unbalanced collection at end of report description\n");
+		goto out;
+	}
+
+	if (parser->local.delimiter_depth) {
+		hid_err(device, "unbalanced delimiter at end of report description\n");
+		goto out;
+	}
+
+	/*
+	 * fetch initial values in case the device's
+	 * default multiplier isn't the recommended 1
+	 */
+	hid_setup_resolution_multiplier(device);
+
+	device->status |= HID_STAT_PARSED;
+	ret = 0;
+
+out:
+	kfree(parser->collection_stack);
+	vfree(parser);
+	return ret;
+}
+
 /**
  * hid_open_report - open a driver-specific device report
  *
@@ -1258,21 +1340,9 @@ EXPORT_SYMBOL_GPL(hid_setup_resolution_multiplier);
  */
 int hid_open_report(struct hid_device *device)
 {
-	struct hid_parser *parser;
-	struct hid_item item;
 	unsigned int size;
-	const __u8 *start;
-	const __u8 *end;
-	const __u8 *next;
-	int ret;
-	int i;
-	static int (*dispatch_type[])(struct hid_parser *parser,
-				      struct hid_item *item) = {
-		hid_parser_main,
-		hid_parser_global,
-		hid_parser_local,
-		hid_parser_reserved
-	};
+	const u8 *start;
+	int error;
 
 	if (WARN_ON(device->status & HID_STAT_PARSED))
 		return -EBUSY;
@@ -1309,74 +1379,13 @@ int hid_open_report(struct hid_device *device)
 	device->rdesc = start;
 	device->rsize = size;
 
-	parser = vzalloc(sizeof(struct hid_parser));
-	if (!parser) {
-		ret = -ENOMEM;
-		goto alloc_err;
-	}
-
-	parser->device = device;
-
-	end = start + size;
-
-	device->collection = kzalloc_objs(struct hid_collection,
-					  HID_DEFAULT_NUM_COLLECTIONS);
-	if (!device->collection) {
-		ret = -ENOMEM;
-		goto err;
-	}
-	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
-	for (i = 0; i < HID_DEFAULT_NUM_COLLECTIONS; i++)
-		device->collection[i].parent_idx = -1;
-
-	ret = -EINVAL;
-	while ((next = fetch_item(start, end, &item)) != NULL) {
-		start = next;
-
-		if (item.format != HID_ITEM_FORMAT_SHORT) {
-			hid_err(device, "unexpected long global item\n");
-			goto err;
-		}
-
-		if (dispatch_type[item.type](parser, &item)) {
-			hid_err(device, "item %u %u %u %u parsing failed\n",
-				item.format, (unsigned)item.size,
-				(unsigned)item.type, (unsigned)item.tag);
-			goto err;
-		}
-
-		if (start == end) {
-			if (parser->collection_stack_ptr) {
-				hid_err(device, "unbalanced collection at end of report description\n");
-				goto err;
-			}
-			if (parser->local.delimiter_depth) {
-				hid_err(device, "unbalanced delimiter at end of report description\n");
-				goto err;
-			}
-
-			/*
-			 * fetch initial values in case the device's
-			 * default multiplier isn't the recommended 1
-			 */
-			hid_setup_resolution_multiplier(device);
-
-			kfree(parser->collection_stack);
-			vfree(parser);
-			device->status |= HID_STAT_PARSED;
-
-			return 0;
-		}
+	error = hid_parse_collections(device);
+	if (error) {
+		hid_close_report(device);
+		return error;
 	}
 
-	hid_err(device, "item fetching failed at offset %u/%u\n",
-		size - (unsigned int)(end - start), size);
-err:
-	kfree(parser->collection_stack);
-alloc_err:
-	vfree(parser);
-	hid_close_report(device);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hid_open_report);
 
-- 
2.53.0.1018.g2bb0e51243-goog

