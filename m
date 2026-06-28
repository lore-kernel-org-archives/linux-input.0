Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AF2D7393
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665217; cv=none; b=HK49y15D3D7pP6kvyy5RXztkRXD5zDLNb3KpvRKBoKFK09Ye3eLxBPVmeGiL/5yf/t9dp4becIezwkWeLG/nFSKB4D6upj1GyPDmBUtYHUFH9MXdEZXboEGldScPhH3XXukJ4rxoB+7gQ0/e8lej5vm+DdTH0mAAzB1CfcCA7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665217; c=relaxed/simple;
	bh=ReLUpbKCCfPRSlFp67b24hj0Q8lRvyhr90kcdYzXrLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXsXSfmnTb1K+GsjLumyX9PTrgMBfktq4t8l/jii2MCUKPz62ada2IaE9DvEXeIzjgWIVFjjIE2EZ5QurW+S2EB8mGHLi4DcQBM1Kh0V5I7Hyod9CHlC6/aSzC5EIyUttx1yXd3Ni5ycQ/WtbQ1Uwe7AEVjlekxHdSeY6AbGhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFX8oNux; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFX8oNux"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49270f771c9so6634295e9.0
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665215; x=1783270015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woNdZCNc/MzUa1vCL/yO/R3w6USI7p6fKOo+IjB4YGg=;
        b=YFX8oNuxj6MJLgHvXNqzJTIUoaVaF5gQsJWzLnADv0JCd0vVoepNHGAbvMiiQ6zdXS
         ui1ZGcxpzykrPiZyinfdklRT8v2zKNbrrMekBvC8l709bz8o0scTuUNKWt3n2UAu8OXW
         s8GBb5ZYYdPdJW126NeWbyTfldHgBuO6JW/3JVaIPVaGTgpGsmjXMORC/ZbCorqi5P+N
         lp/RmB4I14PM+/GsVtFRxGBmQiMGXY7q1qw0yPLPK3dhSK+8XlI9smj2MktX0hP2BUCC
         kcipEsUJX5acK42zDwE2EUqhN/f+N2K3onrxSD5BPjVFaHm2+w1eDo0AtsmM6nh0DJbf
         8f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665215; x=1783270015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=woNdZCNc/MzUa1vCL/yO/R3w6USI7p6fKOo+IjB4YGg=;
        b=nJvNlTK/GH4Yu9OqdJaXixRC9jQYLwp9eNXmF0Yv5KYbe+yqI+4wXWRpkKq7AOK9A8
         ni/I9Rttuv8abpJO6AlJ1tVGnxnJ5/Fcxdc1nXRGFSDpqYH815S2k7IONg7U5nBS9JLu
         9BdI1uJ6/lzkcLddG7iLFQSEtlzpJK3Tn0KKdILaxqaULxNLBYPyqlCqeEd+kZxehDFc
         VSefJkkydTtLLyeJAh8dKue7U7DT4KKCRBTmDQYoUKzUNMe1wqi7BlTSBEbD2LUds4jU
         iofm/2iOUVsK88DaTrY3k8ucAmyNYrKfg+uuveMrM+vR2jy/KPsiJhlf6kFv696kOViP
         gmMA==
X-Gm-Message-State: AOJu0Yy44YWxmG1DOTza19PCE9XQbqagfpLWGSPpjn+yBPxMl3bkx8ei
	TTyBW9UacP9zkZ5SDRsiSfWerFhIxRS/gC1m2cAjpgyHIVCw8DPjUL+n
X-Gm-Gg: AfdE7clO1/ZE1kaniqvy5vOHkiBWgUvBSJ0wxJyzHBZVutTVPONW4/DpcHRpZhitgWe
	JKJz/V9ateIe+09GgrKx+KzVlgyOBuVxCNkdorfvMLuq8jX/Gpx+LXm23xu4/sE/UFXYIAu9yAh
	C8KbE+eTEUW27HOqApH6EZ2F1FAjJE2OnLnKnaOa1EwSBveZGZqzqAp/VjXBXty3IcNRYqSKIve
	QBRUWORzatxBxT2xUWhRNz5NYc0HTm64tporPlhfDEgG5AAcszx/SfKtJGGrcW9+XZdT5v9LW/0
	R9XTr0O6f15AqCwDtipc+/Q+1S9VQHpERgKa4oMzZJcmO+by5UjSkSdXNVKVkzMYhVGVLPTf6r1
	1Gjl0mK1o7JEQoAwVDWNKkylNzDpCxTu3J3N3MjqR/GuaIxp+8bR+CaoWVxoLFfkEjdXMp8C+FX
	S4j/eGln6hQrN59fqO9XLZKpGbVQ==
X-Received: by 2002:a05:600c:4e4b:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-4926689ab05mr198128225e9.33.1782665214551;
        Sun, 28 Jun 2026 09:46:54 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:54 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 4/6] HID: roccat-kovaplus: reject short button reports
Date: Sun, 28 Jun 2026 18:46:09 +0200
Message-ID: <20260628164611.17467-4-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kovaplus raw-event helpers cast button reports to a five-byte
structure and read all payload fields without checking the received size.
A malformed USB device can therefore trigger out-of-bounds reads from a
short input report.

Require a complete button report before updating or forwarding it.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 9ec42c218ef9..55de262e165b 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -614,6 +614,10 @@ static int kovaplus_raw_event(struct hid_device *hdev,
 	if (kovaplus == NULL)
 		return 0;
 
+	if (data[0] == KOVAPLUS_MOUSE_REPORT_NUMBER_BUTTON &&
+	    size < sizeof(struct kovaplus_mouse_report_button))
+		return 0;
+
 	kovaplus_keep_values_up_to_date(kovaplus, data);
 
 	if (kovaplus->roccat_claimed)
-- 
2.54.0

