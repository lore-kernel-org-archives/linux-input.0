Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C723ED5B
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665212; cv=none; b=Kc/NGmup29Ro5aImdGWYT0Sz7Rirdyi86XpnoV8agcFdvd9ImpwXj1gRu7XyBJXagsYLM1KXYdcd+HQiLcKDCriMQjipByIceMZOmOp0/2b03+lMNmboTsSJFgJp4pr8+Urcr3TlD56XAL1VcZTyXsuPi4v1DGyzeDOvq95voNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665212; c=relaxed/simple;
	bh=H12shJ3HB7mf8AuLEd/viE9gKwwN+PYCULrOQyf53bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IwY6azXGsVti1mZATaNOzP4heZr/J7P0AOHWJ1uGgwBz42zABOqZXnMVCQuFUCPlROFIj01nZve+0ftMrLOd3wwVQXc3/mbdzsslpbulASzcBMNJYfjCKVjWBq4vkTcoo0BocdDfu5phNmKm/7TPQcIGhnGuQXCTaLkPH1Gfp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoUXdGtI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoUXdGtI"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4926f8e02e8so14298075e9.0
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665209; x=1783270009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzAFh70BrQW/5qshjiSX3ckNto34Zub+8TA4deGg+EU=;
        b=KoUXdGtIxL8dY/7ppoAEktFn6I8SNXb1WtLf5436rK/e00hslV6eNpCi6mehOF6qyG
         vq6/OzAayeRb1iCkJbH/56egf64BFAfnGXYz05B6X7MvyQklWz+LDUavGMgpdtFZIng9
         oQbjVlXafoLX9WnRlRkepb2dLgUcOXhluWQkzbmECZPuWnijoGjgSlW94uydThxPvWzU
         u1Lp/gIJzMEDCxOd25Vh8e3G+MapPcRNQP1bNxX3uPHG5S9khxyQMk+VTJcq9BWdBPgk
         OuGeNQpcpZOzRXmicAQkv087xMpRZXflxidQTO8pfwKlUD5acjPO/tHfEA62Hjs/Gldl
         7P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665209; x=1783270009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzAFh70BrQW/5qshjiSX3ckNto34Zub+8TA4deGg+EU=;
        b=OXvs8OH68HR8a9cJmZ8E/KgcH465KVrxL7dsSK5PIQW5e5FPlwTd9fLxPjfvPS6QvK
         1GOsKQ23ZBslhEUvhhe+qDbdddqbEwmFCuy4uafh85/+wQAgtpIie/3hxRu3rbzNK//R
         +61E7m9+ebD1m3QV1JaTvEl/6e2hcinqVJ27srFEdR+1U4V8nMEG97IUeVKX8U+JRb02
         hCQlJFZ+90OSOfpRHRyiMId/T42yMxgYQ+4EE3I46ufml6GjN1mdP8Hst6qzAtsvcjKi
         VCJGMK1VFJAs7/qYe8NJ3LRrQQsMLeCI3WRUWY800ERWIor6NS0Hs8StDDmdb7jSkXts
         zEfg==
X-Gm-Message-State: AOJu0YwVngtgCkOJTTcbWVDM8p0VkovbUjjZvC+sGYqwjeA47oF7k8Fl
	E/HZ34xRTchUQZq0GRv0lWijp0FE7Nz9aSCkZWact0eLVPZb3z7D+PBm
X-Gm-Gg: AfdE7cmb2i+R6QNz8gi4zaRSgqap0q6/L84/ByE0eYk4xmssMsg+AEHPY2y0WahQKcQ
	0aTWIdFbOhKLGLRE4D04JwN5GVUvQI+f74C41bABjYDDkGDIhNoMSWc2PIAwFlW+2V6VSO3cZZv
	geI0CqwNK1/SLfsqXLDyYtskAXwRjggrx44TUTxnwwI9oyLcLj4WANhwWlqG80LmzwIFSGM6NHr
	uzAS/wnOtLWqhv3RabXw4TJhpd2ZFmpS0Exj7M//zskoNx5BUjUYmiQFunJj5qINq/9Ar6bVFyJ
	FxV6qPXrgIKBvaF9+gQamIsmKmaQzVF5Jf35/QiOdObk0NJOX4uezknL37CcnL4MwtCjX0lYPqG
	DTrkfsvtlM7H2Y62ch3LKalUmsm5p68thjw5BOYW7ZD41D0/wlqrEO8wGEQCXMUgk7b2tksAoS4
	DwtVskic22nryo515LW08KpK1nOg==
X-Received: by 2002:a05:600c:8283:b0:492:5551:19c6 with SMTP id 5b1f17b1804b1-4926683b0f2mr219586205e9.7.1782665208544;
        Sun, 28 Jun 2026 09:46:48 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:47 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 1/6] HID: roccat-koneplus: reject short button reports
Date: Sun, 28 Jun 2026 18:46:06 +0200
Message-ID: <20260628164611.17467-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Koneplus raw-event path casts button reports to an eight-byte
structure before updating profile state and forwarding an event. A
malformed USB device can identify a shorter report as a button report
and trigger out-of-bounds reads.

Require the complete button report before either consumer sees it.

Fixes: 47dbdbffe15b ("HID: roccat: Add support for Roccat Kone[+] v2")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-koneplus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index f80a60539a96..e0f35251e81a 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -523,6 +523,10 @@ static int koneplus_raw_event(struct hid_device *hdev,
 	if (koneplus == NULL)
 		return 0;
 
+	if (data[0] == KONEPLUS_MOUSE_REPORT_NUMBER_BUTTON &&
+	    size < sizeof(struct koneplus_mouse_report_button))
+		return 0;
+
 	koneplus_keep_values_up_to_date(koneplus, data);
 
 	if (koneplus->roccat_claimed)
-- 
2.54.0

