Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8247D927
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862959; cv=none; b=AIh4IBG4DPUkD6NFKq5yo0pdY1KaJBrQH7xjXzYZ+VLP8rhVKKQrWWjTAVTR35zjf5YbZhfQFtBZvaLgZUTlFqyfViAfPBD4gn1qLTogAp+dytDn5jFMz06Gk/3HqRSmY5AIOUlnljnhv/f63jm0vw3+UlwyjXCM+ua8gCdgzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862959; c=relaxed/simple;
	bh=9lnw1Fa7+1ai8yMi6EJQc7Ex1qH5GtxsH56m2SS0SDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPfZW3bLO50R45siq9iDb1+sJz1z32bl9ey59Pj8mk/WwPI8ZMbLDdg9IqYoec/KS8rnCeWy0z4TAuze+Wew925bWoj5y9X2ZNWTUzM6K6ePV52tj3w+OOv0Wxgz0uAI+TZ9IIlbPFRanDt0NHF7Kbmfa/zb54XDBhh++f8gy5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEOJX5bP; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEOJX5bP"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso6308809eec.1
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862956; x=1792467756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HPW6ypWLxPBPK/wnHCdzFVOHN9Lae0KKKozgNa5aJtQ=;
        b=sEOJX5bPJ9wDOYSoik+8biy/9ObTKHxxJJQq9BkWc+xvM2/zNZ454I3ak2+xEWj+0X
         LtK8dIO2iOuBgtdEAAks+rB+wAn1GkpedyTyDjcm4KguhUAL0dSPfNrIIrLH7mG1QZU/
         ux9xrkPs0RVsh3ASzK7/l4TlMEH35d1VFMwJOO4/rJFg77k5flyAhQsBVoAdLOdtRzIY
         MMfUou6bhKLl2ASG6G0pwcAe2met/6tMJKw3j4R0wglQmszeRxhJSt+vwugbL/e3bRHG
         1B8sDHnLf1F+LRO2vS55P9h8wa9Doui5dm4q469HjmyxLdgXVhwbw9NMcQGF/AO9bDDQ
         wU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862956; x=1792467756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HPW6ypWLxPBPK/wnHCdzFVOHN9Lae0KKKozgNa5aJtQ=;
        b=qFQ5i9/0oXNF1/4iJLIXch8fFXiNsr8hBC8PYIvGxRQYGaxzp9K4k6zguomoHL2YSZ
         dyVSnrKqd8hOIyX1+AVZ6apOD/Wvml71Jwb9UsNZSZ8V2i49lnEpzWKSH4AD/wPmULxu
         P7/VIKFkrnBgufQMOL+mIIOedPH+4TBAdlDcqvXO1CUd/xR2/nF+E2xUxRISuV1SNomf
         BqEqdi2C1Z5tqD9egkOFcK68U3jAE3HM7Zf1ZsZJCWqxvVhIcDXG1+gs3i9VqGLYuDLB
         LjB8wrqHzhX6hz/65MMD1xRcbpMZZqwJCRKjZzeMc2vQOsJZo20g+6ZiJhK7+KXNmvrF
         GBfg==
X-Forwarded-Encrypted: i=1; AKwUvBz1WnJ8IFsV60zEEG4+yJU4smef72kFoykEUK+QWS+B/xpSqeoOg8JE8ha73xd6ApOZusehAa/2c/dpeg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJBSzwp+cqKAYEHjcRKcck82wdUD4wWntKhr8ahODMn4bGE+JTE
	xip1R4NaRb7wB1AkYQMvM3QfI0FwVcH93b4lmilk9gR36Zhms2QJ8kzc
X-Gm-Gg: AYBFou300dkh2lWicovFgMEuyMjTTsIEw/SQNza59Y+/seeLYBWfYJPBl0PjOAxs1nm
	bWowg1kveUGfokuhpOB2h+R+nyxsyW1Jet1kEFFVvKhQDzAGzRSu/DeFqWe4E/MgjXhpo5kAKh4
	l0JlR28tXR3svgcEgTS6e/3T8TLGS7XMmOP5TKAdJj5KLSVvLn2p3EpfBUgTBFAOnHTEstrpAj1
	DRTOLCUp5yKSSfLOiSM0dYYCy6qTjBQa3hJkm1iCSB37sxRDA6K+t6AVhqB6khIRjfWD/gHlLV6
	v663wvinUD/fZAW83hKnHXQCwTEkkj4NZrRdByhhQShOM7h6mCYCPmgQsRqPXmbWounvvVuvK9o
	uHzXRghxEftDIC6FZRy+XG3cH2B98VQ2Urf5yiH5q0YTOSgYwwl29BcfGb7VnSpZ20UUYfId40Q
	X4BQJ2WkZ5SjsoQesNEDePTQBiSxkpIgHKSoi5EsgC6CoXKbYmBDaY/Qbf5ZlqpsZ4OTzVYipFM
	sd7hIWk9u4hPHeed19BXt6041C5R/PAj5tQkUOOj626+MxNMffjf36w+eB0/pY=
X-Received: by 2002:a05:7300:f582:b0:34c:5831:8a19 with SMTP id 5a478bee46e88-3537e0493a0mr15617210eec.40.1791862955569;
        Mon, 12 Oct 2026 20:42:35 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:34 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:23 -0700
Subject: [PATCH 7/9] HID: intel-thc-hid: Drop redundant report ID
 validation in quicki2c
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-7-e0dd5cb60b2e@gmail.com>
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

Now that the core HID request handling validates returned report IDs
for report retrieval requests centrally, the report ID check in the
Intel QuickI2C driver is redundant. Drop it while retaining packet
length validation.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
index 41271301215a..7a362a2ebe2b 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
@@ -160,9 +160,9 @@ int quicki2c_get_report(struct quicki2c_device *qcdev, u8 report_type,
 		return ret;
 	}
 
-	if (HIDI2C_DATA_LEN(le16_to_cpu(rpt->len)) != buf_len || rpt->data[0] != reportnum) {
-		dev_err_once(qcdev->dev, "Invalid packet, len (%d vs %zu) report id (%d vs %d)\n",
-			     le16_to_cpu(rpt->len), buf_len, rpt->data[0], reportnum);
+	if (HIDI2C_DATA_LEN(le16_to_cpu(rpt->len)) != buf_len) {
+		dev_err_once(qcdev->dev, "Invalid packet length (%d vs %zu)\n",
+			     le16_to_cpu(rpt->len), buf_len);
 		return -EINVAL;
 	}
 

-- 
2.56.0.385.gd3acb90ef8-goog

