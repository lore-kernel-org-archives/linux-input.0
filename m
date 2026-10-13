Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E750547F2FE
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862953; cv=none; b=SZT+B2AtB9f+Q/8XcpgwX9Rvl6HaB74Bd41Zz1QJ9El3iILzDmkQ7p107Z1gJMbAx3Rv5M9PRnXn2n6CavwG6ojVPghaVW2aO6PV5ARH0dcRVj3LMcpeNJSfEOnUYYYUImlDlJXkqW9G0BczLsY6eKHVdIfvcGn9EeBkYLppje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862953; c=relaxed/simple;
	bh=8WHjR6Y3FYP/UdZNsrdNGrWq9ncm7ckzhqHWtFq/KFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjKBDXBsX63XwdNwyvEVXtRbju1swFnX9X5XDdNJSTP1NcVyfy2H4IPNRqvhrFvh2kZg7baEfmu6AqfOK/dcS+Z/yaEu0yRKCewX5eBnAntoZ1aL9OdKDQN2aY9N3IaQoPwh/39PFviuK25ZEa64izPisbs+xJ4mhOarByPDLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNprEhDr; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNprEhDr"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so1126695eec.1
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862947; x=1792467747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qppf84QoHZGS5TMpFwUMwLIr3ZVPsYBrBYVC6qpryv4=;
        b=WNprEhDrRJMgvlpNGfJKLzPsX6y9yfLpylotdyiuXoqLhhvw9ca2vk0r0h61ZUT0fA
         +6D1u807oDqr7J7LxOmgq3kLc7AQoV1+OgAx7j0IctaA1MAz6Qw7A2KNMcOHGm8fOupJ
         v6gmMgUsttBwEwc9EkgOaZEcd1ePkO7tp+RURWjkxb2HHLBY8ELsJ2UmuKz5Td/yYeJT
         aRcPaQHNheQo0rPne336V6B5QWVPPyFkFQrBNsyJsSXUkqEf2/J4cP/D0mn32p5VGQtP
         kw5bjcFInx2ZiREDHsgh3ZBbQsbO8epbjJe+gSjFloONzp1MgOChNsvyLBAJCT3ANwbj
         1aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862947; x=1792467747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qppf84QoHZGS5TMpFwUMwLIr3ZVPsYBrBYVC6qpryv4=;
        b=ZcZlaMxBww6PobK+JXLfqAH8BFqTvNnkhoX/07yHkSixCTszJIcq//PpMqpdd2Pdub
         FwwSR4IS/JPl7X1PEY2vKBYWg4A/i59AYVrClULg71a5vJlOx5wg9p4Uxu6nNMo9/Alf
         hRG3uyQPyvDFpfWnDet5qEEpaFSNCoU2ILGESe/iEEsrjtJoarnb0pOJmkIdcW2vDV/p
         reVyP1SEkeUTGjpVZouRI+siHz7o3KK6ibreCNa37fqGBif1Awzrs4LJUghFS8r6gkFB
         SYWV/Di8OhblA4Lsafs8Vakb2mUG7DT+jvhuA31iRpJd03GnlaieBGPp5LcuG307BK2J
         2iaQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+cF5yyUwyWOVrIQjDbL9f8PpC4n2MIis4F5FLU6Z9oMmc3aqKPPyuTvXmzxpZRHNa4nZHaHJbPMAxIA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL2/96J/OTGdI8Af694IIkZ+usPnq05S8qZeQsOy61Xy08SOHBt
	POwZNSmE6dOCYnmjkm7EXWAM4uYxWzaTSD9I6ya2Gqt9ES/0EDy+FNKK
X-Gm-Gg: AYBFou0gW4O9VALIXTc7eaWlK98dVTOI+8tC9kkfXQfc7xH+m5jOUE92RFXwfCNo+yl
	k85IPlYR/NO7BR/Npio52LaxSa1VhKVhmCX5sS2GzNxivwq0z+tAu9DfB2iTAQWkQJb0Sg/F9ig
	1jggUKxXzQ+aHIJQrsyutFcEyN2SFcrJ41uI4s2iVsogCnWXwK1CIIb/lRKRawCffuqrv51ZzJT
	kUJTrGlGwxYvy3en5Xa5iYYDCOK8B3Vy9KcU8Z61w5C5iD4N8yeHplE8bLxVpIYSb4edhn5ZqWn
	LcxwbnrJwfMEHOFpSranMGeQTWStrpYb9wzV1xD/OEMKkaIXUR6sgjn2GYcgQ/ID4JNjBYldNUa
	3cgdABAFhHvn/eKJ/OHwuoB7Tc9YEyKNU9kffDSS7rN/e1clWIMiV5OfMndSmlDx0FIGSSL5J20
	r7W5b+OY6Ew3mThbb06dKo7g8DoMUDzhLKF8tm5zkicpPth7Qu3MNFcIV02a/96++R/pkGOduST
	k8iNQBb4zJBrs/qARvAcEf8skiWsNBSt2XsyRUCL6U2RVh5302uKOp/Kf6kkpRO5MpDEq4s+w==
X-Received: by 2002:a05:7300:fd03:b0:351:4866:255c with SMTP id 5a478bee46e88-3537e058277mr21437793eec.32.1791862946940;
        Mon, 12 Oct 2026 20:42:26 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:26 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:18 -0700
Subject: [PATCH 2/9] HID: core: Fix GET_REPORT input processing for
 unnumbered reports
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-2-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
In-Reply-To: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.17-dev-e56a4

When emulating report retrieval requests in the HID core, low-level
transport drivers store a dummy report ID of 0 at the start of the
buffer for unnumbered reports, with the actual report payload placed
after the initial byte.

Passing the raw transfer buffer and total returned length directly to
the input layer causes unnumbered reports to be processed with an
extraneous leading byte and an incorrect payload length. Offset the
buffer past the leading byte and deduct the dummy report ID from the
length when forwarding unnumbered reports to the input layer.

Fixes: 0d0777ccaa2d ("HID: core: ensure __hid_request reserves the report ID as the first byte")
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ec7c2860c93e..a33e864a25f9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2033,8 +2033,13 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 		return ret;
 	}
 
-	if (reqtype == HID_REQ_GET_REPORT)
-		hid_input_report(hid, report->type, buf, ret, 0);
+	if (reqtype == HID_REQ_GET_REPORT) {
+		if (report->id == 0)
+			ret--;
+
+		if (ret > 0)
+			hid_input_report(hid, report->type, data_buf, ret, 0);
+	}
 
 	return 0;
 }

-- 
2.56.0.385.gd3acb90ef8-goog

