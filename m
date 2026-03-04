Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8136656D
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595210; cv=none; b=C1Gsg4DWjkHVr4YtUlEZqLPcck4mtTRqhCFEj/oFB4swGoVY6ynse4nD1xCDeXEzbjI/HiPYE6lZUzKCPKlLdIbVyD66F/LtFfpNc8hT8NT5Txh6CfUs8MpQj38+ndWYLHqjAzrQjV3EZn6G0X1VuegFfMtwjavN4+9F3BXRa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595210; c=relaxed/simple;
	bh=tpEy2NJ3GOByrF5jclVywkFqUATk1pZbTrsnLEiNYkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evpQpPU//HmHQNSnfMQCpwdTkIih+RsJkp3neYVvyExgA4FJA4A7rMW1k4QNUWpT6bkMAxuxETY4Kf1Ilo+rwKJJsNYw3WyJDg4uvdIresY86uO89wkr2sWqisQqlC2EEepJOc6xcSeB1ADv71Kphl8cy8lNm0y9RJq9FaHWhtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=60228.dev; spf=pass smtp.mailfrom=60228.dev; dkim=pass (2048-bit key) header.d=60228.dev header.i=@60228.dev header.b=Q4n+/2rx; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=60228.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=60228.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=60228.dev header.i=@60228.dev header.b="Q4n+/2rx"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-79881805788so61927457b3.0
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 19:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=60228.dev; s=google; t=1772595208; x=1773200008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpsJq/1pQSU5Twv19wcTQDyHD4BX2tA8Q+JADf85IVs=;
        b=Q4n+/2rxUS77NQwnWY0MY3+ounscsDTjZB77X5sCT8QkO4quEtOPMqtKUapXtyT4g3
         aqVn621zGa1iU1y8YwrgTI+QYTzmlgscsdw+kEA3xKwEnj2AtTL9IbYJqOIw/CQqmFfO
         kYVTCwTPLSN5gRwC+VVbnBWgJAFduGLyyjVCpHuPlaKPts3yBegW/wpZX1zVgfbydE2G
         sdmMvMQt3canJ8V4toU+iqRTL/tfJ3plJwFkpOeTjoyJMeyJzyKhQfSfTOLAL3XKuPEw
         wuH9pk2GtSYO9yxBwJlmD3pj3KlQbudldEFR6AQniJ0nfxz30TXvVN+h71tEUl7FYL9k
         hy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595208; x=1773200008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpsJq/1pQSU5Twv19wcTQDyHD4BX2tA8Q+JADf85IVs=;
        b=HvxYaYO0fd1vRj6E8TGw5PZ6P2gywurggCv65RFeubT4B1gqzTiKnvebVa/S8ySi7v
         hp6cLqpQ9NjV+AanBVauvG6wr82vI6db166xJZWf4NDoTU03qPqnbxwLBtpfvVTaoJ7e
         14Ne34KZz7f+o++B5OE2gEKBOX9/Ptqy8VfqSa2vTpPWmTiQezfXNZfYGzXgUCP9Mwpg
         PxYcR+JwNpIXmp4V+V+KOdZaUF7CcywSBPee4E4pUbcP7x/aOktfIqU9eNCdWvserXeZ
         yVWEDtxGLk5PpEunnwRqwL8iPxeamdBEqQPaiMO4JQEnpc0GflSE8FvhMwEX1Ef/UNUM
         WOKQ==
X-Gm-Message-State: AOJu0Yy908ko4tIFezalJk+Rhg0+fvFX8qdwO0yXWBqYkxMKJNmJW4qZ
	vr9mRLWArJcNw7ajbTI/d3Jxcydw0VBS89RvVZm6cu+zSYjl88OYLt6ocwwX2l5ULhH+8tozGgG
	lNyD81CPo466dMfw=
X-Gm-Gg: ATEYQzxgFIzAcbmBpM8TUZWwKBeUnIV9sNyR/77ulBXdMFBCtyuAzO5jOb6zacrWnR7
	61U4i4VewqxxRdWZm859WfOUZ6DbLctUsQrQYESnZnvPUBSX9M4rcFsKH3H6paB1VXUV8sfY8Q4
	8u/GaVmY8TW1TBjX8rkQQTXkF3iRybtiSgNYSTtdeiC+68yuPtLDjK4M9s2XFw/0B8gS4G2WibU
	ro+hBQs9VNGOHWF6zFlxTTjRBSs5HXbGqtc6fWohyRJomceTwYzV/V6q8oBXoO/SuHwys+wM0Wl
	sNjbbORw4hazvRdcDSLRqsDx+m9v08KG6Z8ybo5iCsLuhzmgZRsfdag/3dZ28friFPjgHwoDj8f
	vhFvwWxTMh0CJdnUe4pTen/0D6EuwUZCZvQuogeuNIUs1v1n0TY+HIQ0kukk69/i1RHcxlsKmuB
	KyRBimaIa4jvJo2sBXLej2T7Q1yOY=
X-Received: by 2002:a05:690c:1a:b0:795:eb7:6681 with SMTP id 00721157ae682-798c6cb4137mr5027177b3.47.1772595207862;
        Tue, 03 Mar 2026 19:33:27 -0800 (PST)
Received: from localhost ([2600:1700:2760:3c1f:566d:338c:4cb1:510e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876c53644sm71142087b3.39.2026.03.03.19.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:33:27 -0800 (PST)
From: leo vriska <leo@60228.dev>
To: linux-input@vger.kernel.org
Cc: leo vriska <leo@60228.dev>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: quirks: add HID_QUIRK_KEEP_OPEN for 8BitDo Pro 3
Date: Tue,  3 Mar 2026 22:32:39 -0500
Message-ID: <20260304033245.445671-2-leo@60228.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304033245.445671-1-leo@60228.dev>
References: <20260304033245.445671-1-leo@60228.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to a mailing list report [1], this controller's predecessor
has the same issue. However, it uses the xpad driver instead of HID, so
this quirk wouldn't apply.

[1]: https://lore.kernel.org/linux-input/unufo3$det$1@ciao.gmane.io/

Signed-off-by: leo vriska <leo@60228.dev>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4ab7640b119a..8c1f41a9e5f6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -22,6 +22,9 @@
 #define USB_DEVICE_ID_3M2256		0x0502
 #define USB_DEVICE_ID_3M3266		0x0506
 
+#define USB_VENDOR_ID_8BITDO		0x2dc8
+#define USB_DEVICE_ID_8BITDO_PRO_3	0x6009
+
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 #define USB_DEVICE_ID_A4TECH_X5_005D	0x000a
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 3217e436c052..b935bc9a061e 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -25,6 +25,7 @@
  */
 
 static const struct hid_device_id hid_quirks[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_8BITDO, USB_DEVICE_ID_8BITDO_PRO_3), HID_QUIRK_KEEP_OPEN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE), HID_QUIRK_ALWAYS_POLL },
-- 
2.53.0

